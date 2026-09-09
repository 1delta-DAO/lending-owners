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
 * Tori strUSD — APR_BACKFILL.md "strUSD (Tori)" row. A DECAYING source.
 *
 * `GET app.tori.finance/api/apy/history` — daily, exactly 30 points, verified
 * 2026-09-09. The matrix could not tell a 30-day rolling window from a
 * full-life series when it was written (the vault had just launched in
 * 2026-07); a year later the vault is older than the series, which settles it:
 * the window ROLLS, and every day not captured is gone.
 *
 * Thirty points is also why this cannot be backfilled into: a first run gets a
 * month and nothing more, so the value of this module is the daily capture, not
 * the initial pull.
 *
 * Units: `value` is already PERCENT (11.06 = 11.06 %).
 */

const LENDER_KEY = "VAULT_TORI";
const CHAIN_ID = "1" as ChainId;
const API = "https://app.tori.finance/api/apy/history";
const STRUSD = "0x280839980a7ed0d7717f64125fe241012e5f5815";

/** What the route serves, full stop — there is no window parameter. */
export const TORI_RETENTION_DAYS = 30;

interface ToriResponse {
  data?: Array<{ date: string; value: number }>;
}

export function createToriVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "tori-api",
    earliest: (now) => new Date(now.getTime() - TORI_RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<ToriResponse>(API);
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, STRUSD);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const row of res.data ?? []) {
        const tsMs = Date.parse(`${row.date}T00:00:00Z`);
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const apy = num(row.value);
        if (apy === undefined) continue;

        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: bucketStart(tsMs, "1d").toISOString(),
          source: "tori-api",
          depositRate: apy, // already percent
        };
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} strUSD`);
    },
  };
}
