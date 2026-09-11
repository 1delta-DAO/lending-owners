import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { num } from "./shared.js";

/**
 * Lista slisBNB — the BNB liquid-staking rate margin-fetcher's `lista.ts`
 * spot fetcher reads the head of.
 *
 * `GET api.lista.org/api/datachart/history?name=slisBNBRate&cycle=1
 *      &startTime=<s>&endTime=<s>` — daily APR points, percent.
 *
 * Probed 2026-09-11: a 500-day window answers 501 points, 730 days is
 * `"Time range too large"` (code 1012). So the depth is not capped, the WINDOW
 * is — this module pages backwards in 365-day windows until one comes back
 * empty, which is how the earlier "every guessed `api.lista.org` route 404'd"
 * note in the vault plan gets corrected: the datachart route is real, it just
 * needs its exact query shape.
 *
 * Only `slisBNBRate` is wired. `lisUSDRate` also serves data but describes the
 * Moolah lisUSD lending market, not a vault we hold; the `lisAster*` names are
 * empty (the spot fetcher already says so); the Moolah VAULTS themselves have
 * no series here or anywhere else public — DefiLlama's `lista-lending` pools
 * are per-underlying aggregates with no vault identity, so they cannot be
 * joined to a vault uid without inventing the join.
 *
 * Units: `amount` is already PERCENT ("4.67"). `chartTime` is a UTC midnight
 * unix stamp.
 */

const LENDER_KEY = "VAULT_LISTA";
const CHAIN_ID = "56" as ChainId;
const API = "https://api.lista.org/api/datachart/history";
const SLISBNB = "0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b";

/** Under the measured ceiling (500 works, 730 does not). */
const WINDOW_DAYS = 365;
const MS_DAY = 86_400_000;

interface ChartResponse {
  code?: string;
  msg?: string;
  data?: Array<{ amount: string; chartTime: number }>;
}

export function createListaVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "lista-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 300,
        signal: ctx.signal,
      });

      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, SLISBNB);
      const from = ctx.from.getTime();
      const seen = new Set<number>();
      let end = ctx.to.getTime();
      let windows = 0;

      // Newest window first; stop on the first empty one, which is what the
      // API answers for a range before the series began.
      while (end > from) {
        const start = Math.max(from, end - WINDOW_DAYS * MS_DAY);
        const res = await client.getJson<ChartResponse>(
          `${API}?name=slisBNBRate&cycle=1&startTime=${Math.floor(start / 1000)}&endTime=${Math.floor(end / 1000)}`,
        );
        if (res.msg && res.msg !== "success") {
          throw new Error(`[${LENDER_KEY}] datachart: ${res.code} ${res.msg}`);
        }
        const rows = res.data ?? [];
        if (rows.length === 0) break;

        for (const row of rows) {
          const tsMs = Number(row.chartTime) * 1000;
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > ctx.to.getTime()) continue;
          const bucket = bucketStart(tsMs, "1d").getTime();
          // Window edges overlap by design (inclusive bounds both sides).
          if (seen.has(bucket)) continue;
          seen.add(bucket);
          const apr = num(row.amount);
          if (apr === undefined) continue;

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: CHAIN_ID,
            dataTs: new Date(bucket).toISOString(),
            source: "lista-api",
            depositRate: apr, // already percent
          };
        }
        windows += 1;
        ctx.onProgress?.(windows, windows + 1, `${LENDER_KEY} slisBNB ← ${new Date(start).toISOString().slice(0, 10)}`);
        if (start <= from) break;
        end = start - MS_DAY;
      }
    },
  };
}
