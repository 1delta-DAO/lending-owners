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
 * Sky / Maker savings — APR_BACKFILL.md rows "sUSDS (Sky)", "stUSDS (Sky)" and
 * "sDAI (Maker)". A DECAYING source.
 *
 * `GET info-sky.blockanalitica.com/{save/ssr,save/dsr,stusds}/historic/?days_ago=N`
 * — one call per rate, daily rows with the rate, the total deposited and the
 * depositor count. Verified 2026-09-09: 366 rows each.
 *
 * `days_ago` is a WHITELIST, not a range: 30 and 365 work, anything larger
 * answers HTTP 500 rather than a truncated series (APR_BACKFILL trap). 365 is
 * therefore the hard ceiling of this route, which makes it a ratchet — the
 * exact reconstruction beyond it is the chi/ssr accumulator, which is a
 * different (archival-RPC) job.
 *
 * Units: `rate` is a FRACTION string ("0.047500000000000000") → percent here.
 * `total` is in underlying units, not USD — all three are USD-pegged, but the
 * field is not a USD measurement, so it lands in `totalDeposits`.
 */

const LENDER_KEY = "VAULT_SKY";
const CHAIN_ID = "1" as ChainId;
const API = "https://info-sky.blockanalitica.com";

/** The API keys its routes by RATE, not by vault, so the vault each series
 *  describes is pinned here (addresses from margin-fetcher's registry). */
const SERIES: Array<{ path: string; symbol: string; address: string }> = [
  { path: "save/ssr", symbol: "sUSDS", address: "0xa3931d71877c0e7a3148cb7eb4463524fec27fbd" },
  { path: "save/dsr", symbol: "sDAI", address: "0x83f20f44975d03b1b09e64809b757c47f942beea" },
  { path: "stusds", symbol: "stUSDS", address: "0x99cd4ec3f88a45940936f469e4bb72a2a701eeb9" },
];

/** The largest whitelisted window; bigger values are a 500, not a clamp. */
export const SKY_RETENTION_DAYS = 365;

interface HistoricRow {
  date: string; // "2025-09-09"
  datetime?: string;
  total?: string;
  rate?: string; // fraction
  utilization?: string; // stUSDS only, fraction
  borrow?: string; // stUSDS only
}

interface HistoricResponse {
  historic?: HistoricRow[];
}

export function createSkyVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "blockanalitica-api",
    earliest: (now) => new Date(now.getTime() - SKY_RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 300,
        signal: ctx.signal,
      });

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const series of SERIES) {
        // Always ask for the deepest whitelisted window and slice locally —
        // an arbitrary `days_ago` is a 500, so there is nothing to tune.
        const res = await client.getJson<HistoricResponse>(
          `${API}/${series.path}/historic/?days_ago=${SKY_RETENTION_DAYS}`,
        );
        const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, series.address);
        for (const row of res.historic ?? []) {
          const tsMs = Date.parse(`${row.date}T00:00:00Z`);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const rate = num(row.rate);
          const total = num(row.total);
          if (rate === undefined && total === undefined) continue;
          const utilization = num(row.utilization);

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: CHAIN_ID,
            dataTs: bucketStart(tsMs, "1d").toISOString(),
            source: "blockanalitica-api",
            depositRate: rate === undefined ? undefined : fractionToPercent(rate),
            totalDeposits: total,
            totalDebt: num(row.borrow),
            utilization: utilization === undefined ? undefined : fractionToPercent(utilization),
          };
        }
        done += 1;
        ctx.onProgress?.(done, SERIES.length, `${LENDER_KEY} ${series.symbol}`);
      }
    },
  };
}
