import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { fractionToPercent, num } from "./shared.js";

/**
 * Falcon sUSDf — APR_BACKFILL.md "sUSDf (Falcon)" row. A DECAYING source.
 *
 * `GET api.falcon.finance/api/v1/statistics/history?measurement=apy&days=N` —
 * undocumented but open, daily, newest-first. Verified 2026-09-09: 365 points
 * with `days=365`.
 *
 * The cap is a 365-point ROLLING window, confirmed in the matrix — so this is a
 * ratchet, not a backfill: whatever is older than a year has already been lost
 * and today's tail is lost tomorrow unless it is captured. That is why it
 * belongs in the daily set rather than in a one-shot run.
 *
 * `measurement` is a whitelist: `apy` and `usdf_supply` work, `tvl` and
 * `share_price` are rejected — so no share price is available from this route
 * (the vault is a plain 4626, so archival `convertToAssets` is the pps source
 * if one is ever needed).
 *
 * Units: `value` is a FRACTION string ("0.04734925…") → percent here.
 */

const LENDER_KEY = "VAULT_FALCON";
const CHAIN_ID = "1" as ChainId;
const API = "https://api.falcon.finance/api/v1/statistics/history";
const SUSDF = "0xc8cf6d7991f15525488b2a83df53468d682ba4b0";

/** The rolling cap the matrix measured; asking for more returns the same 365. */
export const FALCON_RETENTION_DAYS = 365;

type FalconRow = { timestamp: number; value: string };

export function createFalconVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "falcon-api",
    earliest: (now) => new Date(now.getTime() - FALCON_RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const rows = await client.getJson<FalconRow[]>(
        `${API}?measurement=apy&days=${FALCON_RETENTION_DAYS}`,
      );
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, SUSDF);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const row of Array.isArray(rows) ? rows : []) {
        const tsMs = Number(row.timestamp) * 1000;
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const apy = num(row.value);
        if (apy === undefined) continue;

        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: bucketStart(tsMs, "1d").toISOString(),
          observedTs: new Date(tsMs).toISOString(),
          source: "falcon-api",
          depositRate: fractionToPercent(apy),
        };
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} sUSDf`);
    },
  };
}
