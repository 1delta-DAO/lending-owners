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
 * Yield Basis LT markets — HISTORY_APIS.md "yield (Yield Basis)" row.
 *
 * Roster: `GET /v1/analytics/gauges?chainId=1` — the one route that exposes
 * each market's `ltAddress` (the LT vault token, the address our savings rows
 * key on) next to its `marketId`, covering all 11 markets incl. the retired
 * generations (verified identical with `includeLegacy=true`). The uid leaf is
 * therefore the LT address, not the factory index. Snapshots per market:
 * `GET /v1/analytics/markets/snapshots/{chainId}/{marketIdx}`; trading APY for
 * the whole chain in one call: `GET /v1/analytics/markets/trading-apy`.
 *
 * The param traps from the matrix, re-verified live 2026-08-25: the names are
 * INVERTED (`timeframeSeconds` is the bucket, `window` the span), only
 * 3600/86400 buckets are accepted, and `window=all` REQUIRES 86400 — hourly
 * with `window=all` answers `success: false`. So `1d` = `window=all&
 * timeframeSeconds=86400` (inception depth); `1h` = bare
 * `timeframeSeconds=3600`, a ~30-day rolling default, warned about when the
 * ctx window reaches deeper.
 *
 * Units: `ppsRaw` is the 1e18-scaled asset-units share price → `supplyIndex`
 * as the RAW decimal string, `indexKind: "wad"` (never divided — float64
 * would eat the tail realized-return depends on). `tradingApy` is a 1e18
 * SIGNED fraction → percent = v / 1e18 × 100; negatives are legitimate
 * (volatile-profile markets — never clamp). TVL is NOT emitted: the matrix
 * suggested `withdrawableRaw × assetPriceUsdRaw`, but `withdrawableRaw` is
 * per-SHARE (0.969 vs pps 1.009 on the live WBTC market), so that product is
 * a USD pps, not a TVL — the doc needs correcting.
 */

const LENDER_KEY = "VAULT_YIELDBASIS";
const API = "https://api.yieldbasis.com/v1/analytics";

/** Yield Basis is Ethereum-only (all 11 factory markets). */
const CHAINS: ChainId[] = ["1"] as ChainId[];

interface Gauge {
  address?: string;
  ltAddress?: string;
  assetAddress?: string;
  marketId?: string;
}

interface SnapshotRow {
  bucketStart: number; // unix seconds
  marketId: string;
  ppsRaw?: string | null; // 1e18 asset units
  sampleBlockNumber?: number | null;
  sampleBlockTimestamp?: number | null;
}

interface TradingApyRow {
  bucketStart: number;
  marketId: string;
  tradingApy?: string | null; // 1e18 SIGNED fraction
}

interface Envelope<T> {
  success?: boolean;
  data?: T;
  error?: string;
}

const WAD = 1e18;

export interface YieldBasisVaultHistoryConfig {
  concurrency?: number;
}

export function createYieldBasisVaultHistoryFetcher(
  config: YieldBasisVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "yieldbasis-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      // 1d reaches inception; 1h is a ~30d rolling default (see header).
      const params =
        ctx.resolution === "1h"
          ? "timeframeSeconds=3600"
          : "window=all&timeframeSeconds=86400";
      if (ctx.resolution === "1h" && ctx.from.getTime() < Date.now() - 30 * 86_400_000) {
        console.warn(
          `[${LENDER_KEY}] hourly snapshots only reach ~30 days back — ` +
            `from=${ctx.from.toISOString()} will be partially served`,
        );
      }

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const chainId of CHAINS) {
        if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;

        const gauges = await client.getJson<Envelope<Gauge[]>>(
          `${API}/gauges?chainId=${chainId}`,
        );
        const markets = (gauges.data ?? [])
          .map((g) => ({ marketId: g.marketId ?? "", lt: (g.ltAddress ?? "").toLowerCase() }))
          .filter((m) => m.marketId !== "" && m.lt !== "");

        // Chain-level trading APY in ONE call, grouped by marketId.
        const apyRes = await client.getJson<Envelope<TradingApyRow[]>>(
          `${API}/markets/trading-apy?chainId=${chainId}&includeLegacy=true&${params}`,
        );
        const apyByMarket = new Map<string, Map<number, number>>();
        for (const row of apyRes.data ?? []) {
          const raw = num(row.tradingApy);
          if (raw === undefined) continue;
          const perBucket = apyByMarket.get(row.marketId) ?? new Map<number, number>();
          // 1e18 signed fraction → percent; negatives kept (see header).
          perBucket.set(
            bucketStart(row.bucketStart * 1000, ctx.resolution).getTime(),
            (raw / WAD) * 100,
          );
          apyByMarket.set(row.marketId, perBucket);
        }

        let done = 0;
        const results = await mapWithConcurrency(markets, config.concurrency ?? 3, async (m) => {
          try {
            const res = await client.getJson<Envelope<SnapshotRow[]>>(
              `${API}/markets/snapshots/${chainId}/${m.marketId}?${params}`,
            );
            if (res.success === false) throw new Error(res.error ?? "success: false");
            return { m, rows: res.data ?? [] };
          } catch (err) {
            console.warn(
              `[${LENDER_KEY}] market ${m.marketId} skipped: ${(err as Error).message}`,
            );
            return { m, rows: [] as SnapshotRow[] };
          } finally {
            done += 1;
            ctx.onProgress?.(done, markets.length, `${LENDER_KEY} market ${m.marketId}`);
          }
        });

        for (const { m, rows } of results) {
          if (rows.length === 0) continue;
          const marketUid = makeMarketUid(LENDER_KEY, chainId, m.lt);
          const apyBuckets = apyByMarket.get(m.marketId);
          const seen = new Set<number>();

          // Snapshot rows come newest-first; emit oldest-first.
          for (const row of [...rows].sort((a, b) => a.bucketStart - b.bucketStart)) {
            const tsMs = row.bucketStart * 1000;
            if (tsMs < from || tsMs > to) continue;
            const bucket = bucketStart(tsMs, ctx.resolution).getTime();
            if (seen.has(bucket)) continue;
            seen.add(bucket);
            const pps = typeof row.ppsRaw === "string" && row.ppsRaw !== "" ? row.ppsRaw : undefined;
            yield {
              marketUid,
              lenderKey: LENDER_KEY,
              chainId,
              dataTs: new Date(bucket).toISOString(),
              observedTs:
                row.sampleBlockTimestamp != null
                  ? new Date(row.sampleBlockTimestamp * 1000).toISOString()
                  : undefined,
              source: "yieldbasis-api",
              blockNumber: row.sampleBlockNumber ?? undefined,
              depositRate: apyBuckets?.get(bucket),
              // RAW 1e18 decimal string — never through float64 (see header).
              supplyIndex: pps,
              indexKind: pps !== undefined ? "wad" : undefined,
            };
          }
        }
      }
    },
  };
}
