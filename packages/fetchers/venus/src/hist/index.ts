import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  mapWithConcurrency,
} from "@lending-owners/core";

const LENDER_KEY = "VENUS";
const API = "https://api.venus.io";

/**
 * Venus serves **365 daily points** per market and — uniquely among the free
 * sources — hands back the **block number** with every point. That turns the
 * archival `exchangeRateStored` read needed for the index column into a pinned
 * single call rather than a block search, which is why this fetcher records it.
 * See LENDING_HISTORY_BACKFILL_PLAN.md §0.4.
 */
const PERIODS = { year: 365, halfyear: 182, month: 30 } as const;
type Period = keyof typeof PERIODS;

/** Totals arrive in **cents**, not token units or dollars. */
const CENTS = 100;

interface VenusMarket {
  address: string;
  chainId: string;
  symbol: string;
  underlyingAddress: string;
}

interface VenusHistoryPoint {
  borrowApy: string;
  supplyApy: string;
  blockNumber: string;
  blockTimestamp: string;
  totalBorrowCents: string;
  totalSupplyCents: string;
}

export interface VenusHistoryConfig {
  concurrency?: number;
}

async function fetchMarkets(client: PacedClient): Promise<VenusMarket[]> {
  const out: VenusMarket[] = [];
  // Both pools are paginated at 20; `total` closes the loop.
  for (const pool of ["core-pool", "isolated-pools"]) {
    for (let page = 0; ; page += 1) {
      let res: { total?: number; result?: VenusMarket[] };
      try {
        res = await client.getJson(`${API}/markets/${pool}?limit=100&page=${page}`);
      } catch (err) {
        console.warn(`[${LENDER_KEY}] ${pool} page ${page}: ${(err as Error).message}`);
        break;
      }
      const items = res.result ?? [];
      out.push(...items);
      if (items.length === 0 || out.length >= (res.total ?? 0)) break;
      if (page > 50) break;
    }
  }
  return out;
}

function periodFor(days: number): Period {
  if (days <= PERIODS.month) return "month";
  if (days <= PERIODS.halfyear) return "halfyear";
  return "year";
}

export function createVenusHistoryFetcher(config: VenusHistoryConfig = {}): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "venus-api",
    earliest: (now) => new Date(now.getTime() - PERIODS.year * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (!ctx.resolveUid) throw new Error(`[${LENDER_KEY}] needs a uid resolver`);
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 120,
        signal: ctx.signal,
      });

      const markets = await fetchMarkets(client);
      const days = Math.ceil((ctx.to.getTime() - ctx.from.getTime()) / 86_400_000);
      const period = periodFor(days);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      let done = 0;
      let unresolved = 0;
      const results = await mapWithConcurrency(markets, config.concurrency ?? 4, async (m) => {
        try {
          const res = await client.getJson<{ result?: { data?: VenusHistoryPoint[] } }>(
            `${API}/markets/history?asset=${m.address}&period=${period}&limit=1000`,
          );
          return { market: m, points: res.result?.data ?? [] };
        } catch (err) {
          console.warn(`[${LENDER_KEY}] ${m.symbol} (${m.address}): ${(err as Error).message}`);
          return { market: m, points: [] as VenusHistoryPoint[] };
        } finally {
          done += 1;
          ctx.onProgress?.(done, markets.length, LENDER_KEY);
        }
      });

      for (const { market, points } of results) {
        const chainId = String(market.chainId) as ChainId;
        if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;
        // The uid leaf for the Compound V2 family is the vToken, NOT the
        // underlying — `VENUS:1:0x4fafbdc…` is vFRAX, not FRAX.
        const marketUid = ctx.resolveUid(chainId, market.address);
        if (!marketUid) {
          unresolved += 1;
          continue;
        }
        for (const p of points) {
          const tsMs = Number(p.blockTimestamp) * 1000;
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const supply = Number(p.totalSupplyCents) / CENTS;
          const borrow = Number(p.totalBorrowCents) / CENTS;
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId,
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "venus-api",
            blockNumber: Number(p.blockNumber) || undefined,
            // Already percent — Venus quotes 7.60 for 7.60 %.
            depositRate: Number(p.supplyApy),
            variableBorrowRate: Number(p.borrowApy),
            totalDepositsUsd: Number.isFinite(supply) ? supply : undefined,
            totalDebtUsd: Number.isFinite(borrow) ? borrow : undefined,
            utilization: supply > 0 ? borrow / supply : undefined,
          };
        }
      }
      if (unresolved > 0) {
        console.warn(`[${LENDER_KEY}] ${unresolved} market(s) not in the book — skipped`);
      }
    },
  };
}
