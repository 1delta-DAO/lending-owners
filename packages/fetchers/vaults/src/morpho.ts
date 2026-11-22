import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  vaultWanted,
  mapWithConcurrency,
} from "@lending-owners/core";
import { apyToAprPercent, fractionToPercent, num } from "./shared.js";

/**
 * MetaMorpho vaults — HISTORY_APIS.md "morpho" row. The best-in-class source:
 * `Vault.historicalState` serves share price, net APY and TVL to vault
 * INCEPTION at HOUR..YEAR intervals (hourly verified at Jan-2024).
 *
 * Notes that came out of the live probe, not the docs:
 *  - series come back NEWEST-FIRST;
 *  - APYs are FRACTIONS → percent here;
 *  - schema drift: `Vault.chainId`/`whitelisted` are gone — it is
 *    `chain { id }` / `listed` now (and `marketByUniqueKey` → `marketById`
 *    on the market side, for whoever extends this to market histories);
 *  - pinned-market runaway APYs appear verbatim in history — no clamping
 *    here, collection stores what the source said (the earn-surface
 *    `dropUnrealizableRates` rule is a SERVING rule, not a collection rule).
 */

const LENDER_KEY = "VAULT_MORPHO";
const API = "https://blue-api.morpho.org/graphql";
const ROSTER_PAGE = 100;

interface VaultListItem {
  address: string;
  chain?: { id: number | string };
}

interface Datapoint {
  x: number;
  y: number | null;
}

interface VaultHistory {
  sharePriceNumber?: Datapoint[];
  netApy?: Datapoint[];
  totalAssetsUsd?: Datapoint[];
}

const ROSTER_QUERY = `query Roster($first: Int!, $skip: Int!) {
  vaults(first: $first, skip: $skip) {
    pageInfo { countTotal }
    items { address chain { id } }
  }
}`;

/** Vault V2 — its own roster and lookup (`vaults` is MetaMorpho V1 only; the
 *  live fetcher has read `vaultV2s` since 2026-10-19). Aliased to the V1
 *  field names so one merge serves both. V2 has no historical `netApy`:
 *  `avgNetApy` over the trailing 24 h is the closest series (net of both
 *  fees, like the live `netApyExcludingRewards`; the overlap gate checks it). */
const ROSTER_V2_QUERY = `query RosterV2($first: Int!, $skip: Int!) {
  vaultV2s(first: $first, skip: $skip) {
    pageInfo { countTotal }
    items { address chain { id } }
  }
}`;

const HISTORY_V2_QUERY = `query HistoryV2($address: String!, $chainId: Int!, $options: TimeseriesOptions) {
  vaultV2ByAddress(address: $address, chainId: $chainId) {
    historicalState {
      sharePriceNumber: sharePrice(options: $options) { x y }
      netApy: avgNetApy(options: $options, lookbackHours: 24) { x y }
      totalAssetsUsd(options: $options) { x y }
    }
  }
}`;

const HISTORY_QUERY = `query History($address: String!, $chainId: Int!, $options: TimeseriesOptions) {
  vaultByAddress(address: $address, chainId: $chainId) {
    historicalState {
      sharePriceNumber(options: $options) { x y }
      netApy(options: $options) { x y }
      totalAssetsUsd(options: $options) { x y }
    }
  }
}`;

export interface MorphoVaultHistoryConfig {
  concurrency?: number;
}

export function createMorphoVaultHistoryFetcher(
  config: MorphoVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "morpho-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 250,
        signal: ctx.signal,
      });

      // Roster: every vault the API knows (V1 and V2), then filtered locally.
      const vaults: Array<{ address: string; chainId: ChainId; v2: boolean }> = [];
      const seen = new Set<string>();
      for (const { query, field, v2 } of [
        { query: ROSTER_QUERY, field: "vaults", v2: false },
        { query: ROSTER_V2_QUERY, field: "vaultV2s", v2: true },
      ] as const) {
        for (let skip = 0; ; skip += ROSTER_PAGE) {
          const page = await client.graphql<
            Record<string, { pageInfo?: { countTotal?: number }; items: VaultListItem[] }>
          >(API, query, { first: ROSTER_PAGE, skip });
          const list = page[field];
          for (const item of list?.items ?? []) {
            const chainId = String(item.chain?.id ?? "") as ChainId;
            if (!chainId) continue;
            if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;
            if (!vaultWanted(ctx, chainId, item.address)) continue;
            const address = item.address.toLowerCase();
            if (seen.has(`${chainId}:${address}`)) continue;
            seen.add(`${chainId}:${address}`);
            vaults.push({ address, chainId, v2 });
          }
          const total = list?.pageInfo?.countTotal ?? 0;
          if (skip + ROSTER_PAGE >= total || (list?.items ?? []).length === 0) break;
        }
      }

      const options = {
        startTimestamp: Math.floor(ctx.from.getTime() / 1000),
        endTimestamp: Math.ceil(ctx.to.getTime() / 1000),
        interval: ctx.resolution === "1h" ? "HOUR" : "DAY",
      };
      let done = 0;

      const results = await mapWithConcurrency(vaults, config.concurrency ?? 3, async (v) => {
        try {
          const data = await client.graphql<{
            vaultByAddress?: { historicalState?: VaultHistory };
            vaultV2ByAddress?: { historicalState?: VaultHistory };
          }>(API, v.v2 ? HISTORY_V2_QUERY : HISTORY_QUERY, {
            address: v.address,
            chainId: Number(v.chainId),
            options,
          });
          return {
            v,
            history: (v.v2 ? data.vaultV2ByAddress : data.vaultByAddress)?.historicalState,
          };
        } catch (err) {
          console.warn(`[${LENDER_KEY}] ${v.chainId}:${v.address} skipped: ${(err as Error).message}`);
          return { v, history: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, vaults.length, LENDER_KEY);
        }
      });

      for (const { v, history } of results) {
        if (!history) continue;
        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);

        // Merge the three newest-first series on their bucket stamp.
        const byBucket = new Map<
          number,
          { sharePrice?: number; netApy?: number; tvlUsd?: number }
        >();
        const put = (
          points: Datapoint[] | undefined,
          field: "sharePrice" | "netApy" | "tvlUsd",
        ) => {
          for (const p of points ?? []) {
            const value = num(p.y);
            if (value === undefined) continue;
            const bucket = bucketStart(p.x * 1000, ctx.resolution).getTime();
            const entry = byBucket.get(bucket) ?? {};
            entry[field] = value;
            byBucket.set(bucket, entry);
          }
        };
        put(history.sharePriceNumber, "sharePrice");
        put(history.netApy, "netApy");
        put(history.totalAssetsUsd, "tvlUsd");

        for (const [bucket, entry] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: new Date(bucket).toISOString(),
            source: "morpho-api",
            // netApy is an APY fraction; the live row stores
            // apyToAprPercent(netApy × 100) (margin-fetcher fetchFromApi.ts).
            depositRate:
              entry.netApy !== undefined ? apyToAprPercent(fractionToPercent(entry.netApy)) : undefined,
            totalDepositsUsd: entry.tvlUsd,
            supplyIndex:
              entry.sharePrice !== undefined ? String(entry.sharePrice) : undefined,
            indexKind: "assets_per_share",
          };
        }
      }
    },
  };
}
