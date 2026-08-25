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
import { fractionToPercent, num } from "./shared.js";

/**
 * Pendle PT markets — HISTORY_APIS.md "pendle" row.
 *
 * `GET /core/v1/{chain}/markets/{market}/historical-data?time_frame=day`
 * returns the market's WHOLE life in one un-paginated columnar response
 * (`{timestamp[], impliedApy[], underlyingApy[], baseApy[], maxApy[],
 * tvl[]}`) — verified to 2023 on wstETH. Hourly exists but pages at 1440
 * rows and needs BOTH ISO bounds; the daily form needs neither, so this
 * fetcher serves `1d` only and refuses `1h` loudly rather than half-serving
 * it.
 *
 * APYs are FRACTIONS → percent here. `impliedApy` is the PT's fixed rate
 * (the row's economics — the five-APY trap from PENDLE_PT.md); it lands on
 * `depositRate`. `tvl` is USD.
 */

const LENDER_KEY = "VAULT_PENDLE";
const API = "https://api-v2.pendle.finance/core";

interface PendleMarketAll {
  address: string;
  expiry?: string;
  /** `<chainId>-<address>` — the chain lives HERE, not on a field of its own. */
  pt?: string;
}

interface HistoricalData {
  total?: number;
  timestamp?: number[];
  impliedApy?: Array<number | null>;
  underlyingApy?: Array<number | null>;
  tvl?: Array<number | null>;
}

export interface PendleVaultHistoryConfig {
  concurrency?: number;
}

export function createPendleVaultHistoryFetcher(
  config: PendleVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "pendle-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.resolution !== "1d") {
        throw new Error(
          `[${LENDER_KEY}] only 1d is served — Pendle's hourly route pages at 1440 rows ` +
            `with mandatory ISO bounds and is not wired here (HISTORY_APIS.md).`,
        );
      }
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 150,
        signal: ctx.signal,
      });

      // One call lists every market on every chain — including matured ones,
      // which is exactly right for a backfill (their series simply end).
      const all = await client.getJson<{ markets: PendleMarketAll[] }>(`${API}/v1/markets/all`);
      const markets = (all.markets ?? [])
        .map((m) => {
          const chainId = m.pt?.split("-")[0] as ChainId | undefined;
          return chainId ? { chainId, address: m.address.toLowerCase() } : undefined;
        })
        .filter((m): m is { chainId: ChainId; address: string } => !!m)
        .filter((m) => !ctx.chainIds || ctx.chainIds.includes(m.chainId));

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      const results = await mapWithConcurrency(markets, config.concurrency ?? 4, async (m) => {
        try {
          const data = await client.getJson<HistoricalData>(
            `${API}/v1/${m.chainId}/markets/${m.address}/historical-data?time_frame=day`,
          );
          return { m, data };
        } catch (err) {
          // Matured markets can 404 their history; count, don't fail the run.
          console.warn(`[${LENDER_KEY}] ${m.chainId}:${m.address} skipped: ${(err as Error).message}`);
          return { m, data: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, markets.length, LENDER_KEY);
        }
      });

      for (const { m, data } of results) {
        const stamps = data?.timestamp ?? [];
        if (stamps.length === 0) continue;
        const marketUid = makeMarketUid(LENDER_KEY, m.chainId, m.address);
        for (let i = 0; i < stamps.length; i += 1) {
          const tsMs = stamps[i]! * 1000;
          if (tsMs < from || tsMs > to) continue;
          const implied = num(data?.impliedApy?.[i]);
          const tvl = num(data?.tvl?.[i]);
          if (implied === undefined && tvl === undefined) continue;
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: m.chainId,
            dataTs: bucketStart(tsMs, "1d").toISOString(),
            source: "pendle-api",
            depositRate: implied !== undefined ? fractionToPercent(implied) : undefined,
            totalDepositsUsd: tvl,
          };
        }
      }
    },
  };
}
