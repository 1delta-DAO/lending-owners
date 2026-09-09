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
 * Spark savings vaults — APR_BACKFILL.md "Spark sUSDC V1 + sp* V2" row.
 * A DECAYING source.
 *
 * `GET spark.data.blockanalitica.com/v1/savings/vaults/historic/?days_ago=365`
 * returns EVERY vault in one call — 2,127 rows across 7 symbols, verified
 * 2026-09-09. Same Blockanalitica family as the Sky routes, so the same
 * `days_ago` whitelist applies (365 max, larger is a 500) and the same ratchet
 * argument: 365 days back is all this route will ever give.
 *
 * The trap is identity, not transport: rows carry a SYMBOL and no chain, while
 * `spUSDC` is deployed CREATE2-deterministically at the same address on
 * Ethereum and Avalanche as two independent vaults with independent rates.
 * Attributing one series to both would invent a measurement, so each symbol is
 * mapped to a single pinned deployment and anything unmapped is skipped and
 * counted — the same discipline as Upshift's address-only host.
 *
 * `sUSDS` also appears in this feed because Spark's V1 vault holds it, but that
 * series is Sky's Savings Rate and is collected under `VAULT_SKY` from the
 * source that owns it — mapping it here too would double-count one rate.
 *
 * Units: `rate` is a FRACTION string ("0.015") → percent here; `tvl_usd` is USD.
 */

const LENDER_KEY = "VAULT_SPARK";
const API = "https://spark.data.blockanalitica.com/v1/savings/vaults/historic/";

/** The largest whitelisted window (the family's `days_ago` is a whitelist). */
export const SPARK_RETENTION_DAYS = 365;

/** symbol → the deployment this feed's series is attributed to. Addresses from
 *  margin-fetcher `sparkSavings.ts` (`SPARK_VAULTS_V2`) and the savings
 *  registry's V1 `sUSDC` group. */
const VAULTS: Record<string, { chainId: ChainId; address: string }> = {
  spUSDC: { chainId: "1" as ChainId, address: "0x28b3a8fb53b741a8fd78c0fb9a6b2393d896a43d" },
  spUSDT: { chainId: "1" as ChainId, address: "0xe2e7a17dff93280dec073c995595155283e3c372" },
  spETH: { chainId: "1" as ChainId, address: "0xfe6eb3b609a7c8352a241f7f3a21cea4e9209b8f" },
  spPYUSD: { chainId: "1" as ChainId, address: "0x80128dbb9f07b93dde62a6daeadb69ed14a7d354" },
  spUSDG: { chainId: "1" as ChainId, address: "0xde770c84fe66e063336b31737cfe9790f18c4087" },
  sUSDC: { chainId: "1" as ChainId, address: "0x19ebd191f7a24ece672ba13a302212b5ef7f35cb" },
};

interface SparkRow {
  date: string;
  symbol: string;
  tvl_usd?: string;
  rate?: string; // fraction
}

interface SparkResponse {
  data?: SparkRow[];
}

export function createSparkSavingsVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "blockanalitica-api",
    earliest: (now) => new Date(now.getTime() - SPARK_RETENTION_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 300,
        signal: ctx.signal,
      });

      const res = await client.getJson<SparkResponse>(`${API}?days_ago=${SPARK_RETENTION_DAYS}`);
      const rows = res.data ?? [];
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const skipped = new Map<string, number>();
      let emitted = 0;

      for (const row of rows) {
        const vault = VAULTS[row.symbol];
        if (!vault) {
          skipped.set(row.symbol, (skipped.get(row.symbol) ?? 0) + 1);
          continue;
        }
        if (ctx.chainIds && !ctx.chainIds.includes(vault.chainId)) continue;
        const tsMs = Date.parse(`${row.date}T00:00:00Z`);
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const rate = num(row.rate);
        const tvl = num(row.tvl_usd);
        if (rate === undefined && tvl === undefined) continue;

        emitted += 1;
        yield {
          marketUid: makeMarketUid(LENDER_KEY, vault.chainId, vault.address),
          lenderKey: LENDER_KEY,
          chainId: vault.chainId,
          dataTs: bucketStart(tsMs, "1d").toISOString(),
          source: "blockanalitica-api",
          depositRate: rate === undefined ? undefined : fractionToPercent(rate),
          totalDepositsUsd: tvl,
        };
      }

      // Loudly, not silently: an unmapped symbol is a vault whose history we
      // are dropping on the floor, and the feed gains symbols over time.
      for (const [symbol, n] of skipped) {
        console.warn(`[${LENDER_KEY}] no pinned deployment for "${symbol}" — skipped ${n} rows`);
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} ${emitted} points`);
    },
  };
}
