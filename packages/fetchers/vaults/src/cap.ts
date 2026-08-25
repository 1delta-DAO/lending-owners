import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { decimalString, fractionToPercent, num } from "./shared.js";

/**
 * Cap stcUSD (Ethereum) — HISTORY_APIS.md "cap" row. A DECAYING source.
 *
 * `GET api.cap.app/v1/vaults/1/{cUSD}/timeseries/{bucket}_{window}` — the
 * route the savings fetcher already reads (`1d_1M`) is the entire history
 * surface. Combo whitelist: 1d_1W, 1d_1M, 1d_1Y, 1h_1W, 1h_1M; everything
 * else (incl. `1d_all`) is a Cloudflare WAF 403, so retention beyond one
 * year is unreachable — this source belongs in the daily capture set.
 *
 * Richest payload in the vault set: share price
 * (`stakedCapTokenToCapTokenRatio`), TVL and APR/APY in one series.
 * `stakingApr`/`stakingApy` are FRACTIONS → converted to percent here.
 */

const LENDER_KEY = "VAULT_CAP";
const CHAIN_ID = "1" as ChainId;

/** The vanity address margin-fetcher's `capFetcher` already queries; the
 *  series it returns describes the staked vault (stcUSD share price, staking
 *  TVL, staking APY), so the uid keys on the same address. */
const CUSD = "0xcCcc62962d17b8914c62D74FfB843d73B2a3cccC";
const STAKED_VAULT = CUSD;

interface CapPoint {
  timestamp: string; // ISO bucket start
  lastUpdatedAt?: string;
  vaultTvlUsd?: string;
  stakingTvlUsd?: string;
  stakedCapTokenToCapTokenRatio?: string;
  stakingApr?: string; // fraction
  stakingApy?: string; // fraction
}

interface CapResponse {
  timeseries?: CapPoint[];
}

/** One year of dailies / one month of hourlies — the deepest allowed combos. */
export const CAP_RETENTION_DAYS = 365;

export function createCapVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "cap-api",
    earliest: (now) => new Date(now.getTime() - CAP_RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 300,
        signal: ctx.signal,
      });

      // Always fetch the deepest allowed combo for the resolution and window
      // locally — the API has no custom ranges.
      const combo = ctx.resolution === "1h" ? "1h_1M" : "1d_1Y";
      const res = await client.getJson<CapResponse>(
        `https://api.cap.app/v1/vaults/1/${CUSD}/timeseries/${combo}`,
      );
      const points = res.timeseries ?? [];
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, STAKED_VAULT);

      let emitted = 0;
      for (const p of points) {
        const tsMs = Date.parse(p.timestamp);
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const apy = num(p.stakingApy);
        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
          observedTs: p.lastUpdatedAt,
          source: "cap-api",
          depositRate: apy !== undefined ? fractionToPercent(apy) : undefined,
          totalDepositsUsd: num(p.stakingTvlUsd),
          supplyIndex: decimalString(p.stakedCapTokenToCapTokenRatio),
          indexKind: "assets_per_share",
        };
        emitted += 1;
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} stcUSD (${emitted} pts)`);
    },
  };
}
