import {
  type Address,
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  mapWithConcurrency,
} from "@lending-owners/core";

const LENDER_KEY = "LLAMALEND";

const PRICES_API = "https://prices.curve.finance/v1";

/**
 * The snapshots endpoint returns a **hard 100 points** regardless of `agg`,
 * `per_page`, `page`, or an explicit `start`/`end` — all four were probed and
 * every one returns the same newest 100. At `agg=day` that is a ~100-day
 * rolling window, so LlamaLend is the second decaying source alongside
 * Compound V3 and belongs in the daily capture job.
 * See LENDING_HISTORY_BACKFILL_PLAN.md §0.4.
 */
export const CURVE_SNAPSHOT_CAP = 100;

/** Curve's chain slugs → our chain ids. The slug list is fetched at runtime so
 *  a new LlamaLend deployment shows up without a code change; anything not in
 *  this map is skipped loudly rather than guessed at. */
const CHAIN_BY_SLUG: Record<string, ChainId> = {
  ethereum: "1" as ChainId,
  optimism: "10" as ChainId,
  fraxtal: "252" as ChainId,
  sonic: "146" as ChainId,
  arbitrum: "42161" as ChainId,
};

interface CurveToken {
  symbol: string;
  address: string;
  decimals: number;
}

interface CurveMarket {
  name: string;
  controller: string;
  vault: string;
  collateral_token: CurveToken;
  borrowed_token: CurveToken;
}

interface CurveSnapshot {
  timestamp: string;
  lend_apy: number;
  borrow_apy: number;
  total_debt: number;
  total_assets: number;
  total_debt_usd: number;
  total_assets_usd: number;
  n_loans: number;
}

export interface LlamaLendHistoryConfig {
  /** Slugs to fetch; defaults to everything `/lending/chains` reports. */
  chainSlugs?: string[];
  concurrency?: number;
}

/**
 * Per-market uid. LlamaLend markets are keyed by **controller** address and
 * carry two rows — the borrowed side (which holds the rates) and the
 * collateral side (which does not). Verified against `/meta/lending/complete`:
 * `LLAMALEND_143985860EFAEACB92DB23E4B0C4D66BE51B08D2:1:0x09db87…` is the
 * ynETH-long controller with its collateral token as the underlying.
 */
const marketLenderKey = (controller: string): string =>
  `${LENDER_KEY}_${controller.replace(/^0x/i, "").toUpperCase()}`;

async function fetchChainSlugs(client: PacedClient): Promise<string[]> {
  const res = await client.getJson<{ data: string[] }>(`${PRICES_API}/lending/chains`);
  return res.data ?? [];
}

async function fetchMarkets(client: PacedClient, slug: string): Promise<CurveMarket[]> {
  const res = await client.getJson<{ data: CurveMarket[] }>(
    `${PRICES_API}/lending/markets/${slug}?fetch_on_chain=false&per_page=1000`,
  );
  return res.data ?? [];
}

async function fetchSnapshots(
  client: PacedClient,
  slug: string,
  controller: string,
  resolution: "1d" | "1h",
): Promise<CurveSnapshot[]> {
  const agg = resolution === "1h" ? "hour" : "day";
  const res = await client.getJson<{ data: CurveSnapshot[] }>(
    `${PRICES_API}/lending/markets/${slug}/${controller}/snapshots?agg=${agg}`,
  );
  return res.data ?? [];
}

/**
 * Rates + totals for every LlamaLend market, both sides.
 *
 * No accumulator: `total_assets` is the vault's asset side, not a share price,
 * and the API exposes no share count — so realized return for LlamaLend comes
 * from archival replay of the vault's `convertToAssets` (plan §0.9 A6).
 */
export function createLlamaLendHistoryFetcher(
  config: LlamaLendHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "curve-api",
    earliest: (now) => new Date(now.getTime() - CURVE_SNAPSHOT_CAP * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 150,
        signal: ctx.signal,
      });

      const slugs = config.chainSlugs ?? (await fetchChainSlugs(client));
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      for (const slug of slugs) {
        const chainId = CHAIN_BY_SLUG[slug];
        if (!chainId) {
          console.warn(`[${LENDER_KEY}] unknown chain slug "${slug}" — skipped (add it to CHAIN_BY_SLUG)`);
          continue;
        }
        if (ctx.chainIds && !ctx.chainIds.includes(chainId)) continue;

        const markets = await fetchMarkets(client, slug);
        let done = 0;

        // Snapshots are fetched concurrently, but yielded in market order so
        // the NDJSON shard stays grouped by market.
        const perMarket = await mapWithConcurrency(markets, config.concurrency ?? 4, async (m) => {
          try {
            const snaps = await fetchSnapshots(client, slug, m.controller, ctx.resolution);
            done += 1;
            ctx.onProgress?.(done, markets.length, `${LENDER_KEY} ${slug}`);
            return { market: m, snaps };
          } catch (err) {
            console.warn(
              `[${LENDER_KEY}] ${slug} ${m.name} (${m.controller}) skipped: ${(err as Error).message}`,
            );
            return { market: m, snaps: [] as CurveSnapshot[] };
          }
        });

        for (const { market, snaps } of perMarket) {
          const lenderKey = marketLenderKey(market.controller);
          const borrowed = market.borrowed_token?.address?.toLowerCase() as Address | undefined;
          const collateral = market.collateral_token?.address?.toLowerCase() as Address | undefined;
          if (!borrowed) continue;

          for (const s of snaps) {
            const tsMs = Date.parse(s.timestamp.endsWith("Z") ? s.timestamp : `${s.timestamp}Z`);
            if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
            const dataTs = bucketStart(tsMs, ctx.resolution).toISOString();
            const observedTs = new Date(tsMs).toISOString();

            // Borrowed side carries the market's economics. Curve already
            // reports APYs in percent, so no scaling here (unlike Compound).
            yield {
              marketUid: makeMarketUid(lenderKey, chainId, borrowed),
              lenderKey,
              chainId,
              dataTs,
              observedTs,
              source: "curve-api",
              depositRate: s.lend_apy,
              variableBorrowRate: s.borrow_apy,
              totalDeposits: s.total_assets,
              totalDebt: s.total_debt,
              totalDepositsUsd: s.total_assets_usd,
              totalDebtUsd: s.total_debt_usd,
              utilization: s.total_assets > 0 ? s.total_debt / s.total_assets : 0,
            };

            // Collateral side exists in our book as its own market_uid with no
            // rates (see `/meta/lending/complete`). Emitting it keeps the two
            // sides in step rather than leaving half the uids without history.
            if (collateral && collateral !== borrowed) {
              yield {
                marketUid: makeMarketUid(lenderKey, chainId, collateral),
                lenderKey,
                chainId,
                dataTs,
                observedTs,
                source: "curve-api",
              };
            }
          }
        }
      }
    },
  };
}
