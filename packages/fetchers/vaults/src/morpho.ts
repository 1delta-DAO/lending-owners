import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  mapWithConcurrency,
} from "@lending-owners/core";
import { fractionToPercent, num } from "./shared.js";

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

      // Roster: every vault the API knows, then filtered locally by chain.
      const vaults: Array<{ address: string; chainId: ChainId }> = [];
      for (let skip = 0; ; skip += ROSTER_PAGE) {
        const page = await client.graphql<{
          vaults: { pageInfo?: { countTotal?: number }; items: VaultListItem[] };
        }>(API, ROSTER_QUERY, { first: ROSTER_PAGE, skip });
        for (const item of page.vaults.items ?? []) {
          const chainId = String(item.chain?.id ?? "") as ChainId;
          if (!chainId) continue;
          if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;
          vaults.push({ address: item.address.toLowerCase(), chainId });
        }
        const total = page.vaults.pageInfo?.countTotal ?? 0;
        if (skip + ROSTER_PAGE >= total || (page.vaults.items ?? []).length === 0) break;
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
          }>(API, HISTORY_QUERY, {
            address: v.address,
            chainId: Number(v.chainId),
            options,
          });
          return { v, history: data.vaultByAddress?.historicalState };
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
            depositRate:
              entry.netApy !== undefined ? fractionToPercent(entry.netApy) : undefined,
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
