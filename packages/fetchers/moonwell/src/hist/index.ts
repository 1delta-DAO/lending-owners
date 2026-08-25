import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
} from "@lending-owners/core";

const LENDER_KEY = "MOONWELL";

/** Moonwell's own Ponder indexer — free, keyless, every chain they deploy on. */
const PONDER_URL = "https://ponder.moonwell.fi";

/** Ponder pages with a cursor; 1000 is its practical per-page ceiling. */
const PAGE = 1000;

interface Snapshot {
  chainId: number;
  marketAddress: string;
  totalBorrows: string;
  totalBorrowsUSD: string;
  totalSupplies: string;
  totalSuppliesUSD: string;
  baseSupplyApy: string;
  baseBorrowApy: string;
  timestamp: number;
}

export interface MoonwellHistoryConfig {
  concurrency?: number;
}

const QUERY = `query($after: String, $from: Int!) {
  marketDailySnapshots(limit: ${PAGE}, after: $after, orderBy: "timestamp", orderDirection: "asc", where: { timestamp_gte: $from }) {
    items {
      chainId
      marketAddress
      totalBorrows
      totalBorrowsUSD
      totalSupplies
      totalSuppliesUSD
      baseSupplyApy
      baseBorrowApy
      timestamp
    }
    pageInfo { hasNextPage endCursor }
  }
}`;

/**
 * Rates and totals for every Moonwell market, back to the indexer's genesis
 * (~2025-08-21 when measured). No `exchangeRate` on the snapshot, so the index
 * column for these markets still comes from archival replay.
 */
export function createMoonwellHistoryFetcher(
  _config: MoonwellHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "moonwell-ponder",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (!ctx.resolveUid) throw new Error(`[${LENDER_KEY}] needs a uid resolver`);
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 120,
        signal: ctx.signal,
      });

      const fromSec = Math.floor(ctx.from.getTime() / 1000);
      const to = ctx.to.getTime();
      let after: string | null = null;
      let seen = 0;
      let unresolved = 0;
      const missing = new Set<string>();

      for (;;) {
        const data: {
          marketDailySnapshots: {
            items: Snapshot[];
            pageInfo: { hasNextPage: boolean; endCursor: string | null };
          };
        } = await client.graphql(PONDER_URL, QUERY, { after, from: fromSec });

        const page = data.marketDailySnapshots;
        for (const s of page.items ?? []) {
          const tsMs = Number(s.timestamp) * 1000;
          if (!Number.isFinite(tsMs) || tsMs > to) continue;
          const chainId = String(s.chainId) as ChainId;
          if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;

          // Leaf is the mToken (`MOONWELL:1:0xeddc25b…` is mUSDT), not the
          // underlying — same rule as the rest of the Compound V2 family.
          const marketUid = ctx.resolveUid(chainId, s.marketAddress);
          if (!marketUid) {
            unresolved += 1;
            missing.add(`${chainId}:${s.marketAddress}`);
            continue;
          }

          const supplyUsd = Number(s.totalSuppliesUSD);
          const borrowUsd = Number(s.totalBorrowsUSD);
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId,
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "moonwell-ponder",
            // Ponder stores these as fractions (0.049 = 4.9 %).
            depositRate: Number(s.baseSupplyApy) * 100,
            variableBorrowRate: Number(s.baseBorrowApy) * 100,
            totalDepositsUsd: Number.isFinite(supplyUsd) ? supplyUsd : undefined,
            totalDebtUsd: Number.isFinite(borrowUsd) ? borrowUsd : undefined,
            utilization: supplyUsd > 0 ? borrowUsd / supplyUsd : undefined,
          };
          seen += 1;
        }

        ctx.onProgress?.(seen, seen, `${LENDER_KEY} snapshots`);
        if (!page.pageInfo?.hasNextPage || !page.pageInfo.endCursor) break;
        after = page.pageInfo.endCursor;
      }

      if (unresolved > 0) {
        console.warn(
          `[${LENDER_KEY}] ${unresolved} snapshot(s) for ${missing.size} market(s) not in the book — skipped: ${[...missing].slice(0, 4).join(", ")}`,
        );
      }
    },
  };
}
