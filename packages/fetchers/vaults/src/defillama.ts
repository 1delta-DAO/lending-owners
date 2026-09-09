import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { decimalString, num } from "./shared.js";

/**
 * DefiLlama `/chart/{poolUuid}` — the universal daily fallback, APR_BACKFILL.md
 * "The two universal fallbacks" and HISTORY_GAPS §3.3's "no generic fetcher
 * module" line.
 *
 * One route, `GET yields.llama.fi/chart/{uuid}`, serves one point per day
 * (~23:01 UTC) since the pool was listed, with no decay: `{timestamp, tvlUsd,
 * apy, apyBase, apyReward, pricePerShare}`. Verified 2026-09-09 on sUSDe: 901+
 * daily points back to 2024-02-16.
 *
 * This module exists for the sources with NO official history API — where the
 * matrix's verdict is literally "DefiLlama + archival". Where an official API
 * exists it is always preferred and there is no row here: Re's own NAV route is
 * ten months deeper than its Llama pool, and Strata's own file is full-life,
 * so pointing both at Llama would be a worse series under a second source name.
 *
 * The roster is pinned by UUID because that is the only safe join. Llama's
 * `YUSD` pools are Aegis, not YieldFi — a symbol join silently attaches one
 * protocol's series to another's vault (APR_BACKFILL "ticker collisions"), and
 * that is unrecoverable once it is in the store. Every row below carries the
 * UUID margin-fetcher's live fetcher already uses for that asset, so the two
 * cannot drift apart quietly.
 *
 * Adding a source is one line. `pricePerShare` is populated for many savings
 * pools and null for others (Ethena, Re, Hastra, Native, Parallel, OpenEden,
 * sDOLA) — it is emitted when present and simply absent otherwise.
 *
 * Units: `apy` is already PERCENT — Llama's convention matches ours.
 */

const LENDER_KEY = "VAULT_LLAMA";
const API = "https://yields.llama.fi/chart";

/** Pool UUID → the vault the series describes. UUIDs mirrored from
 *  margin-fetcher's per-asset fetchers; addresses from its savings registry. */
const POOLS: Array<{ uuid: string; chainId: ChainId; address: string; symbol: string }> = [
  {
    uuid: "66985a81-9c51-46ca-9977-42b4fe7bc6df",
    chainId: "1" as ChainId,
    address: "0x9d39a5de30e57443bff2a8307a4256c8797a3497",
    symbol: "sUSDe",
  },
  {
    uuid: "f8cd444e-d99f-4132-b234-fd3482bf8806",
    chainId: "1" as ChainId,
    address: "0x056b269eb1f75477a8666ae8c7fe01b64dd55ecc",
    symbol: "USD3",
  },
  {
    uuid: "a99bb965-ebaa-4d98-9ed2-fa18de52c605",
    chainId: "1" as ChainId,
    address: "0xf689555121e529ff0463e191f9bd9d1e496164a7",
    symbol: "sUSD3",
  },
  {
    uuid: "da8c4ac9-733d-4a98-85a5-83b76b7e84d1",
    chainId: "1" as ChainId,
    address: "0xe346c29b5b60ef870b9724c57ccfbbc631e47dee",
    symbol: "wiTRY",
  },
  {
    uuid: "cb6139f9-4a68-4efd-8245-0312a92aee55",
    chainId: "1" as ChainId,
    address: "0x38eeb52f0771140d10c4e9a9a72349a329fe8a6a",
    symbol: "apyUSD",
  },
];

interface ChartResponse {
  status?: string;
  data?: Array<{
    timestamp: string; // ISO, ~23:01 UTC
    tvlUsd?: number | null;
    apy?: number | null; // percent
    apyBase?: number | null;
    apyReward?: number | null;
    pricePerShare?: number | null;
  }>;
}

export function createDefiLlamaVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "defillama-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 250,
        signal: ctx.signal,
      });

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const pool of POOLS) {
        done += 1;
        if (ctx.chainIds && !ctx.chainIds.includes(pool.chainId)) continue;

        let rows: NonNullable<ChartResponse["data"]> = [];
        try {
          const res = await client.getJson<ChartResponse>(`${API}/${pool.uuid}`);
          rows = res.data ?? [];
        } catch (err) {
          // A delisted pool 404s. That is one asset's series gone, not a run.
          console.warn(`[${LENDER_KEY}] ${pool.symbol} (${pool.uuid}): ${(err as Error).message}`);
          continue;
        }

        const marketUid = makeMarketUid(LENDER_KEY, pool.chainId, pool.address);
        for (const row of rows) {
          const tsMs = Date.parse(row.timestamp);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const apy = num(row.apy) ?? num(row.apyBase);
          const tvl = num(row.tvlUsd);
          const pps = num(row.pricePerShare);
          if (apy === undefined && tvl === undefined && pps === undefined) continue;

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: pool.chainId,
            // Llama stamps ~23:01, so the day bucket is the previous day's
            // close; `observedTs` keeps the real sampling time.
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "defillama-api",
            depositRate: apy, // already percent
            totalDepositsUsd: tvl,
            supplyIndex: decimalString(pps),
            indexKind: pps === undefined ? undefined : "assets_per_share",
          };
        }
        ctx.onProgress?.(done, POOLS.length, `${LENDER_KEY} ${pool.symbol}`);
      }
    },
  };
}
