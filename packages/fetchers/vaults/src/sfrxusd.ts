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
 * Frax sfrxUSD — APR_BACKFILL.md "sfrxUSD (Frax)" row.
 *
 * `GET api.frax.finance/v2/sfrxusd/summary-stats/history?range=all` — daily
 * rows since 2025-05-01, unauth, absent from their own Swagger (the spec was
 * recovered externally). Verified 2026-09-09: 497 points.
 *
 * The richest of the savings rows: one call carries APR, APY, the share price
 * (`frxusdPerSfrxusd`) and both supply measures, each stamped with the
 * Ethereum AND Fraxtal block it was read at.
 *
 * Units: `sfrxusdApr` / `sfrxusdApy` are already PERCENT (4.80 = 4.80 %).
 * `frxusdPerSfrxusd` is assets-per-share in frxUSD terms.
 */

const LENDER_KEY = "VAULT_SFRXUSD";
const CHAIN_ID = "1" as ChainId;
const API = "https://api.frax.finance/v2/sfrxusd/summary-stats/history?range=all";
const SFRXUSD = "0xcf62f905562626cfcdd2261162a51fd02fc9c5b6";

interface FraxRow {
  intervalTimestamp: string; // ISO
  blockNumberEthereum?: number;
  sfrxusdApr?: number; // percent
  sfrxusdApy?: number; // percent
  frxusdPerSfrxusd?: number; // assets per share
  sfrxusdTotalSupply?: number;
  sfrxusdTotalMarketCap?: number;
}

interface FraxResponse {
  items?: FraxRow[];
}

export function createSfrxusdVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "frax-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<FraxResponse>(API);
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, SFRXUSD);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const row of res.items ?? []) {
        const tsMs = Date.parse(row.intervalTimestamp);
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const apy = num(row.sfrxusdApy) ?? num(row.sfrxusdApr);
        const pps = num(row.frxusdPerSfrxusd);
        if (apy === undefined && pps === undefined) continue;

        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: bucketStart(tsMs, "1d").toISOString(),
          source: "frax-api",
          blockNumber: row.blockNumberEthereum,
          depositRate: apy, // already percent
          totalDeposits: num(row.sfrxusdTotalSupply),
          totalDepositsUsd: num(row.sfrxusdTotalMarketCap),
          supplyIndex: decimalString(pps),
          indexKind: pps === undefined ? undefined : "assets_per_share",
        };
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} sfrxUSD`);
    },
  };
}
