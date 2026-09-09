import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { decimalString } from "./shared.js";

/**
 * Wren wstGBP — VAULT_HISTORY_BACKFILL_PLAN.md §3 "wstGBP (Wren)" row.
 *
 * The endpoint the live spot fetcher ALREADY calls, `GET wstgbp.com/api/nav-growth`,
 * carries a `history` array: the full-life NAV restatement series, starting at
 * exactly 1e18 on 2026-04-10 with roughly weekly steps. Verified 2026-09-09:
 * 17 points. No new endpoint was needed — only noticing the array was there.
 *
 * `windowDays` is ignored by the API, so there is nothing to page or tune.
 *
 * Units: `price` is a WAD (1e18) string and is kept RAW as the accumulator —
 * `indexKind: "wad"` — because that is the number the issuer restates. There is
 * no per-point rate: `aprWad` is a single trailing-window figure for "now", not
 * a series, so it is deliberately NOT stamped onto historical points.
 *
 * The yield is earned in POUNDS; a USD view of this vault has to net out the
 * GBP/USD move, which no field here provides.
 */

const LENDER_KEY = "VAULT_WREN";
const CHAIN_ID = "1" as ChainId;
const API = "https://wstgbp.com/api/nav-growth";
const WSTGBP = "0x57c3571f10767e49c9d7b60feb6c67804783b7ae";

interface WrenResponse {
  history?: Array<{ price: string; timestamp: number }>; // wad, unix seconds
}

export function createWrenVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "wren-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<WrenResponse>(API);
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, WSTGBP);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const row of res.history ?? []) {
        const tsMs = Number(row.timestamp) * 1000;
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const price = decimalString(row.price);
        if (price === undefined) continue;

        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
          observedTs: new Date(tsMs).toISOString(),
          source: "wren-api",
          supplyIndex: price,
          indexKind: "wad",
        };
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} wstGBP`);
    },
  };
}
