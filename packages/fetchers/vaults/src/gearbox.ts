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
 * Gearbox V3 passive pools — HISTORY_APIS.md "gearbox" row. A DECAYING source.
 *
 * Roster: `GET api.gearbox.foundation/markets/list/{chainId}` (pool address on
 * `address`). Series: `GET /v1/graph/pool/{graph}/{poolAddr}/1y?chainId=` for
 * `deposit_apy` (PERCENT floats — 6.99 = 6.99 %, verified live), `diesel_rate`
 * (assets-per-share pps, ~1.004) and `expected_liquidity` (HUMAN asset units —
 * a graph tail of 72.180288 matched the roster's `liquidity.expected` for the
 * same USDC pool exactly, and a WETH pool reads 1092.7 where USD would be ~4M
 * → `totalDeposits`, never `totalDepositsUsd`).
 *
 * ALWAYS period `1y`: `1d`/`1w`/`1m` are broken upstream (empty or a single
 * zero) — fetch the year and slice to the ctx window locally. Retention is the
 * 1y window (no `all` period exists), hence `earliest`. Untracked pools answer
 * 200 with `data: []` — counted and skipped, never emitted as zeros. Stamps
 * are irregular ~hourly → bucketed to ctx.resolution keeping the LAST point
 * per bucket.
 */

const LENDER_KEY = "VAULT_GEARBOX";
const API = "https://api.gearbox.foundation";
const RETENTION_DAYS = 365;

/** Chains whose `/markets/list/{id}` answered non-empty, probed 2026-08-25:
 *  1, 143 (Monad), 9745 (Plasma), 42793 (Etherlink). Empty on that date:
 *  10, 42161, 8453, 56, 137, 146, 252, 1135, 130, 480, 5000, 34443, 59144,
 *  100, 999, 80094 — the legacy Arbitrum/Optimism books are not served by
 *  this API. Re-probe when Gearbox announces a deployment. */
const CHAINS: ChainId[] = ["1", "143", "9745", "42793"] as ChainId[];

const GRAPHS = ["deposit_apy", "diesel_rate", "expected_liquidity"] as const;
type Graph = (typeof GRAPHS)[number];

interface MarketRow {
  chainId: number;
  address: string;
  symbol?: string;
  status?: string;
}

interface GraphPoint {
  time: number; // unix seconds, irregular ~hourly
  value: number;
}

interface GraphResponse {
  data?: { id?: string; title?: string; data?: GraphPoint[] };
}

export interface GearboxVaultHistoryConfig {
  concurrency?: number;
}

export function createGearboxVaultHistoryFetcher(
  config: GearboxVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "gearbox-api",
    earliest: (now) => new Date(now.getTime() - RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const chains = CHAINS.filter((c) => !ctx.chainIds || ctx.chainIds.includes(c));
      const pools: Array<{ chainId: ChainId; address: string; symbol: string }> = [];
      for (const chainId of chains) {
        const rows = await client.getJson<MarketRow[]>(`${API}/markets/list/${chainId}`);
        for (const row of rows ?? []) {
          pools.push({
            chainId,
            address: row.address.toLowerCase(),
            symbol: row.symbol ?? "",
          });
        }
      }

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;
      let untracked = 0;

      const results = await mapWithConcurrency(pools, config.concurrency ?? 3, async (pool) => {
        const series = new Map<Graph, GraphPoint[]>();
        for (const graph of GRAPHS) {
          try {
            const res = await client.getJson<GraphResponse>(
              // ALWAYS 1y — shorter periods are broken upstream (see header).
              `${API}/v1/graph/pool/${graph}/${pool.address}/1y?chainId=${pool.chainId}`,
            );
            series.set(graph, res.data?.data ?? []);
          } catch (err) {
            console.warn(
              `[${LENDER_KEY}] ${pool.chainId}:${pool.address} ${graph} skipped: ${(err as Error).message}`,
            );
            series.set(graph, []);
          }
        }
        done += 1;
        ctx.onProgress?.(done, pools.length, `${LENDER_KEY} ${pool.symbol}`);
        return { pool, series };
      });

      for (const { pool, series } of results) {
        if (GRAPHS.every((g) => (series.get(g) ?? []).length === 0)) {
          untracked += 1; // 200 + empty = untracked pool, not a zero series
          continue;
        }
        const marketUid = makeMarketUid(LENDER_KEY, pool.chainId, pool.address);

        // Merge the three irregular series on their bucket, keeping the LAST
        // sample per bucket per graph.
        const byBucket = new Map<
          number,
          { apy?: number; pps?: number; liquidity?: number; observed: number }
        >();
        const put = (graph: Graph, field: "apy" | "pps" | "liquidity") => {
          for (const p of series.get(graph) ?? []) {
            const tsMs = p.time * 1000;
            if (tsMs < from || tsMs > to) continue;
            const value = num(p.value);
            if (value === undefined) continue;
            const bucket = bucketStart(tsMs, ctx.resolution).getTime();
            const entry = byBucket.get(bucket) ?? { observed: 0 };
            // Points arrive chronological but guard on the stamp anyway.
            if (entry[field] === undefined || tsMs >= entry.observed) {
              entry[field] = value;
              entry.observed = Math.max(entry.observed, tsMs);
            }
            byBucket.set(bucket, entry);
          }
        };
        put("deposit_apy", "apy");
        put("diesel_rate", "pps");
        put("expected_liquidity", "liquidity");

        for (const [bucket, entry] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: pool.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(entry.observed).toISOString(),
            source: "gearbox-api",
            depositRate: entry.apy, // already percent
            totalDeposits: entry.liquidity, // human asset units (see header)
            supplyIndex: entry.pps !== undefined ? String(entry.pps) : undefined,
            indexKind: entry.pps !== undefined ? "assets_per_share" : undefined,
          };
        }
      }

      if (untracked > 0) {
        console.warn(`[${LENDER_KEY}] ${untracked}/${pools.length} pools untracked upstream (empty series)`);
      }
    },
  };
}
