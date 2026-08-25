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
import { num } from "./shared.js";

/**
 * Lagoon vaults — HISTORY_APIS.md "lagoon" row.
 *
 * Roster from the same GraphQL the spot fetcher uses (margin-fetcher
 * `vaults/lagoon/api.ts`): `POST api.lagoon.finance/query`, `vaults(where:
 * {chainId_eq, isVisible_eq: true})`, no auth. History via
 * `vaultByAddress(chainId, address) { stateHistory { <field>(options:
 * {startTimestamp, endTimestamp}) { x y } } }`.
 *
 * Live-pinned (2026-08-25):
 *  - THE trap: each field caps at exactly **1,000 points and keeps the
 *    NEWEST** — `startTimestamp: 0` silently truncates the head (verified:
 *    `totalAssetsUsd` on the largest ETH vault answers exactly 1000 rows
 *    starting months after the pps series' real inception). So page
 *    BACKWARDS: full page ⇒ re-query with `endTimestamp = oldest.x - 1`.
 *  - Points are event-driven and irregular (12 s … days apart, settlement-
 *    driven) → bucketed to `ctx.resolution` keeping the LAST point per
 *    bucket.
 *  - `pricePerShare` (raw) is scaled by the **asset's** decimals, NOT the
 *    share's — pinned on an 18-dec-share/6-dec-USDC vault (`1051892` ≈
 *    1.0519 USDC/share) and an 8-dec cbBTC one. The roster carries
 *    `asset.decimals`, so the index is emitted as assets-per-share, scaled
 *    by pure string arithmetic (raw values overflow float64).
 *  - `y` comes back as a STRING in `stateHistory` but a NUMBER in `state` —
 *    tolerate both. A vault with no usable asset decimals falls back to
 *    `pricePerShareUsd` with `indexKind: "exchange_rate"` — a
 *    **USD-denominated** index (asset-price moves pollute the realized
 *    return), which is why it is the fallback and not the default.
 *  - No stored APR series exists (`stateAt` is point-in-time only) →
 *    no `depositRate` from this source.
 */

const LENDER_KEY = "VAULT_LAGOON";
const API = "https://api.lagoon.finance/query";
const FIELD_CAP = 1000; // exact — verified live
const ROSTER_PAGE = 200;

/** Chains with a Lagoon factory — mirrored from margin-fetcher's
 *  `LAGOON_CHAIN_IDS` (docs.lagoon.finance networks page). */
const LAGOON_CHAIN_IDS: ChainId[] = [
  "1", // Ethereum
  "42161", // Arbitrum
  "8453", // Base
  "43114", // Avalanche
  "10", // Optimism
  "137", // Polygon
  "59144", // Linea
  "5000", // Mantle
  "146", // Sonic
] as ChainId[];

interface RosterItem {
  address: string | null;
  symbol: string | null;
  asset: { decimals: number | null } | null;
}

interface Datapoint {
  x: number;
  y: number | string | null;
}

const ROSTER_QUERY = `query Roster($where: VaultFilterInput!, $first: Int!, $skip: Int!) {
  vaults(first: $first, skip: $skip, orderBy: totalAssetsUsd, orderDirection: desc, where: $where) {
    items { address symbol asset { decimals } }
  }
}`;

/** Shift a raw integer string left by `decimals` — exact, no float64. */
const scaleByDecimals = (raw: string | number, decimals: number): string | undefined => {
  const s = typeof raw === "number" ? String(raw) : raw;
  if (!/^\d+$/.test(s)) return undefined; // rejects exponent-form numbers
  if (decimals === 0) return s;
  const padded = s.padStart(decimals + 1, "0");
  return `${padded.slice(0, -decimals)}.${padded.slice(-decimals)}`;
};

export interface LagoonVaultHistoryConfig {
  concurrency?: number;
}

export function createLagoonVaultHistoryFetcher(
  config: LagoonVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "lagoon-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const chains = LAGOON_CHAIN_IDS.filter(
        (c) => !ctx.chainIds || ctx.chainIds.includes(c),
      );

      // ── roster ────────────────────────────────────────────────────────────
      const vaults: Array<{ chainId: ChainId; address: string; symbol: string; assetDecimals?: number }> = [];
      for (const chainId of chains) {
        try {
          for (let skip = 0; skip < ROSTER_PAGE * 20; skip += ROSTER_PAGE) {
            const page = await client.graphql<{ vaults: { items: RosterItem[] } }>(
              API,
              ROSTER_QUERY,
              {
                where: { chainId_eq: Number(chainId), isVisible_eq: true },
                first: ROSTER_PAGE,
                skip,
              },
            );
            const items = page.vaults.items ?? [];
            for (const item of items) {
              if (!item.address) continue;
              const dec = item.asset?.decimals;
              vaults.push({
                chainId,
                address: item.address.toLowerCase(),
                symbol: item.symbol ?? item.address,
                assetDecimals: typeof dec === "number" && dec >= 0 ? dec : undefined,
              });
            }
            if (items.length < ROSTER_PAGE) break;
          }
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] roster chain ${chainId} skipped: ${(err as Error).message}`,
          );
        }
      }

      const fromSec = Math.floor(ctx.from.getTime() / 1000);
      const toSec = Math.ceil(ctx.to.getTime() / 1000);
      let done = 0;

      /** One stateHistory field, paged BACKWARDS through the newest-kept
       *  1,000-point cap. Returns ascending, deduped on `x`. */
      const fetchField = async (
        v: { chainId: ChainId; address: string },
        field: string,
      ): Promise<Datapoint[]> => {
        const pages: Datapoint[][] = [];
        let end = toSec;
        // 60 pages × 1000 events is far past any live vault's history.
        for (let page = 0; page < 60; page += 1) {
          const query = `query { vaultByAddress(chainId: ${Number(v.chainId)}, address: "${v.address}") {
            stateHistory { ${field}(options: { startTimestamp: ${fromSec}, endTimestamp: ${end} }) { x y } }
          } }`;
          const data = await client.graphql<{
            vaultByAddress?: { stateHistory?: Record<string, Datapoint[] | undefined> };
          }>(API, query);
          const rows = data.vaultByAddress?.stateHistory?.[field] ?? [];
          if (rows.length === 0) break;
          pages.unshift(rows);
          const oldest = rows[0]!.x;
          if (rows.length < FIELD_CAP || oldest <= fromSec) break;
          end = oldest - 1;
        }
        return pages.flat();
      };

      const results = await mapWithConcurrency(vaults, config.concurrency ?? 3, async (v) => {
        // assets-per-share when the asset's decimals are known (the normal
        // case); USD share price otherwise — see header.
        const ppsField = v.assetDecimals !== undefined ? "pricePerShare" : "pricePerShareUsd";
        try {
          const [pps, tvlUsd] = await Promise.all([
            fetchField(v, ppsField),
            fetchField(v, "totalAssetsUsd"),
          ]);
          return { v, ppsField, pps, tvlUsd };
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] ${v.chainId}:${v.address} skipped: ${(err as Error).message}`,
          );
          return { v, ppsField, pps: undefined, tvlUsd: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${v.symbol}`);
        }
      });

      const fromMs = ctx.from.getTime();
      const toMs = ctx.to.getTime();

      for (const { v, ppsField, pps, tvlUsd } of results) {
        if (!pps && !tvlUsd) continue;
        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);

        // Keep the LAST point per bucket per field (series are ascending, so
        // later points simply overwrite).
        const byBucket = new Map<number, { pps?: Datapoint; tvl?: Datapoint }>();
        const put = (points: Datapoint[] | undefined, field: "pps" | "tvl") => {
          for (const p of points ?? []) {
            const tsMs = p.x * 1000;
            if (!Number.isFinite(tsMs) || tsMs < fromMs || tsMs > toMs) continue;
            const bucket = bucketStart(tsMs, ctx.resolution).getTime();
            const entry = byBucket.get(bucket) ?? {};
            if (!entry[field] || entry[field]!.x <= p.x) entry[field] = p;
            byBucket.set(bucket, entry);
          }
        };
        put(pps, "pps");
        put(tvlUsd, "tvl");

        for (const [bucket, entry] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          const supplyIndex =
            entry.pps?.y === null || entry.pps === undefined
              ? undefined
              : ppsField === "pricePerShare"
                ? scaleByDecimals(entry.pps.y!, v.assetDecimals!)
                : num(entry.pps.y)?.toString();
          const observed = Math.max(entry.pps?.x ?? 0, entry.tvl?.x ?? 0);
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: observed > 0 ? new Date(observed * 1000).toISOString() : undefined,
            source: "lagoon-api",
            totalDepositsUsd: entry.tvl ? num(entry.tvl.y) : undefined,
            supplyIndex,
            indexKind:
              supplyIndex === undefined
                ? undefined
                : ppsField === "pricePerShare"
                  ? "assets_per_share"
                  : "exchange_rate",
          };
        }
      }
    },
  };
}
