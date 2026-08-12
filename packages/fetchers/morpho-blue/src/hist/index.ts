import {
  type Address,
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";

const LENDER_KEY = "MORPHO_BLUE";

/** Same host the ownership fetcher uses. Note: NOT `api.morpho.org` — that host
 *  serves a different schema without `markets`/`marketId`. */
const MORPHO_API_URL = "https://blue-api.morpho.org/graphql";

/**
 * Morpho is the single biggest win in the backfill: ~94.6 % of our Morpho
 * market ids, free, keyless, **back to each market's creation** (712 daily
 * points measured on a 2024 market), and it is the only source that publishes
 * both `supplyAssets` and `supplyShares` — i.e. an exact share price, which is
 * what actually answers "realized vs quoted".
 * See LENDING_HISTORY_BACKFILL_PLAN.md §0.3.2 and §0.9 A4.
 */
const SERIES = [
  "supplyApy",
  "borrowApy",
  "supplyAssets",
  "supplyShares",
  "borrowAssets",
  "borrowShares",
  "collateralAssets",
  "utilization",
  "supplyAssetsUsd",
  "borrowAssetsUsd",
  "collateralAssetsUsd",
] as const;
type SeriesName = (typeof SERIES)[number];

/**
 * The API rejects a document over 1,000,000 complexity with HTTP 403 rather
 * than truncating it, and the quoted `complexity` is charged **before**
 * execution — so it scales with `first × series`, NOT with how many points come
 * back. Two measurements pin the constant:
 *
 *   20 markets × 9 series,  365-day window → 1,804,300  (÷180 = 10,024)
 *   50 markets × 11 series, 30-day window  → 5,519,250  (÷550 = 10,035)
 *
 * Same constant across a 12× difference in window, which is what makes the
 * window-independence certain rather than assumed. Requesting a longer history
 * therefore costs nothing extra in complexity — only in response bytes.
 */
const MAX_COMPLEXITY = 1_000_000;
const COMPLEXITY_PER_MARKET_SERIES = 10_035;
const COMPLEXITY_BUDGET = MAX_COMPLEXITY * 0.7;

/** `skip` is capped API-side; paging past it silently returns nothing. */
const MAX_SKIP = 10_000;

/** Precision of the emitted share price. The target column is
 *  `numeric(60,30)`, and float64 would drop exactly the tail digits the
 *  realized-return ratio depends on — so this is computed in BigInt. */
const INDEX_DECIMALS = 30n;

/** Morpho reports APYs as fractions (0.0985 = 9.85 %); the `HistoryPoint`
 *  contract is percent. */
const AS_PERCENT = 100;

interface TimeseriesPoint {
  x: number;
  y: string | number | null;
}

interface RawMarket {
  marketId: string;
  chain: { id: number };
  creationTimestamp: number;
  loanAsset: { address: string; decimals: number; symbol: string } | null;
  collateralAsset: { address: string; decimals: number; symbol: string } | null;
  historicalState: Partial<Record<SeriesName, TimeseriesPoint[] | null>>;
}

export interface MorphoBlueHistoryConfig {
  /** Chains to walk; defaults to every chain the API reports markets on. */
  chainIds?: ChainId[];
  concurrency?: number;
  /** Override the derived page size (markets per request). */
  pageSize?: number;
}

/** Markets per request, bounded by the complexity cap. Independent of the
 *  requested window — see the note on `COMPLEXITY_PER_MARKET_SERIES`. */
export function pageSizeFor(seriesCount = SERIES.length): number {
  const perMarket = Math.max(1, seriesCount) * COMPLEXITY_PER_MARKET_SERIES;
  return Math.max(1, Math.min(50, Math.floor(COMPLEXITY_BUDGET / perMarket)));
}

const marketLenderKey = (marketId: string): string =>
  `${LENDER_KEY}_${marketId.replace(/^0x/i, "").toUpperCase()}`;

/**
 * `assets / shares` as a fixed-point decimal string. Morpho seeds every market
 * with virtual shares, so this starts near 1e-6 and grows — the absolute scale
 * is meaningless, only the ratio between two samples matters.
 */
function sharePrice(assets: string | number | null, shares: string | number | null): string | undefined {
  try {
    const a = BigInt(String(assets ?? "0"));
    const s = BigInt(String(shares ?? "0"));
    if (s <= 0n || a < 0n) return undefined;
    const scaled = (a * 10n ** INDEX_DECIMALS) / s;
    const text = scaled.toString().padStart(Number(INDEX_DECIMALS) + 1, "0");
    const cut = text.length - Number(INDEX_DECIMALS);
    const frac = text.slice(cut).replace(/0+$/, "");
    return frac ? `${text.slice(0, cut)}.${frac}` : text.slice(0, cut);
  } catch {
    // A non-integer string (the API occasionally returns a float for USD-ish
    // series). Not fatal — the point simply carries no index.
    return undefined;
  }
}

function num(v: string | number | null | undefined): number | undefined {
  if (v == null) return undefined;
  const n = Number(v);
  return Number.isFinite(n) ? n : undefined;
}

function toHuman(raw: string | number | null | undefined, decimals: number): number | undefined {
  if (raw == null) return undefined;
  const n = Number(raw);
  return Number.isFinite(n) ? n / 10 ** decimals : undefined;
}

function buildQuery(first: number, skip: number, chainId: string, fromSec: number, toSec: number, interval: string): string {
  const opts = `(options:{startTimestamp:${fromSec},endTimestamp:${toSec},interval:${interval}})`;
  const series = SERIES.map((s) => `${s}${opts}{x y}`).join(" ");
  // `orderBy: UniqueKey` is load-bearing, not cosmetic. Paging a collection
  // ordered by a *mutable* field (SupplyAssetsUsd) while its values move
  // re-orders rows between requests: a market can be served on two pages while
  // another is never served at all. Measured on chain 1 — SupplyAssetsUsd
  // paging produced 3,362 duplicate points (3.2 %), which means a comparable
  // number of markets were silently skipped. UniqueKey is immutable.
  return `query {
  markets(first: ${first}, skip: ${skip}, where: { chainId_in: [${chainId}] }, orderBy: UniqueKey, orderDirection: Asc) {
    pageInfo { countTotal }
    items {
      marketId
      chain { id }
      creationTimestamp
      loanAsset { address decimals symbol }
      collateralAsset { address decimals symbol }
      historicalState { ${series} }
    }
  }
}`;
}

async function fetchChainIds(client: PacedClient): Promise<ChainId[]> {
  const data = await client.graphql<{ chains: Array<{ id: number }> }>(
    MORPHO_API_URL,
    "query { chains { id } }",
  );
  return (data.chains ?? []).map((c) => String(c.id) as ChainId);
}

/**
 * Rates, totals **and exact share price** for every Morpho Blue market, back to
 * market creation.
 *
 * Two rows are emitted per market per bucket, matching how our book keys them:
 * the loan side (which carries the rates and the supply/borrow indices) and the
 * collateral side (which carries only collateral totals). Verified against
 * `/meta/lending/complete`: one market id yields both `…:1:<loanAsset>` named
 * "Loan USDS" and `…:1:<collateralAsset>` named "Collateral CULT".
 */
export function createMorphoBlueHistoryFetcher(
  config: MorphoBlueHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "morpho-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 130,
        signal: ctx.signal,
      });

      const fromSec = Math.floor(ctx.from.getTime() / 1000);
      const toSec = Math.floor(ctx.to.getTime() / 1000);
      const interval = ctx.resolution === "1h" ? "HOUR" : "DAY";
      // Adaptive: if the API's complexity constant ever moves, halve and retry
      // rather than failing the whole chain.
      let first = config.pageSize ?? pageSizeFor();

      const chains =
        ctx.chainIds ?? config.chainIds ?? (await fetchChainIds(client));

      for (const chainId of chains) {
        let skip = 0;
        let total = Number.POSITIVE_INFINITY;
        let done = 0;

        while (skip < total) {
          let data: { markets: { pageInfo: { countTotal: number }; items: RawMarket[] } };
          for (;;) {
            try {
              data = await client.graphql(
                MORPHO_API_URL,
                buildQuery(first, skip, String(chainId), fromSec, toSec, interval),
              );
              break;
            } catch (err) {
              const tooComplex = /too complex/i.test((err as Error).message ?? "");
              if (!tooComplex || first <= 1) throw err;
              first = Math.max(1, Math.floor(first / 2));
              console.warn(`[${LENDER_KEY}] query too complex — retrying with pageSize=${first}`);
            }
          }

          const items = data.markets?.items ?? [];
          total = data.markets?.pageInfo?.countTotal ?? items.length;
          if (items.length === 0) break;

          for (const market of items) {
            yield* emitMarket(market, chainId, ctx);
          }

          skip += items.length;
          done += items.length;
          ctx.onProgress?.(Math.min(done, total), total, `${LENDER_KEY} chain ${chainId}`);

          if (skip >= MAX_SKIP && skip < total) {
            console.warn(
              `[${LENDER_KEY}] chain ${chainId}: truncated at ${skip}/${total} — the API caps skip at ${MAX_SKIP}`,
            );
            break;
          }
        }
      }
    },
  };
}

function* emitMarket(
  market: RawMarket,
  chainId: ChainId,
  ctx: HistoryContext,
): Generator<HistoryPoint> {
  const loan = market.loanAsset;
  if (!loan) return;

  const hs = market.historicalState ?? {};
  const lenderKey = marketLenderKey(market.marketId);
  const loanAddress = loan.address.toLowerCase() as Address;
  const collateral = market.collateralAsset;

  // Index every series by timestamp: the API returns them newest-first and,
  // for a market created mid-window, they can differ in length. Zipping by
  // position would silently pair a rate with the wrong day's share price.
  const byTs = new Map<number, Partial<Record<SeriesName, string | number | null>>>();
  for (const name of SERIES) {
    for (const p of hs[name] ?? []) {
      let row = byTs.get(p.x);
      if (!row) byTs.set(p.x, (row = {}));
      row[name] = p.y;
    }
  }

  // The API returns the aligned grid PLUS a trailing "as of now" sample, so the
  // current bucket always arrives twice (measured: 31 points for a 30-day
  // window, the last two both dated today). Keeping the aligned sample gives a
  // uniform daily series; keeping both would collide on `(marketUid, dataTs)`
  // and be silently deduped downstream, hiding real duplicates behind noise.
  const chosen = new Map<number, number>();
  for (const ts of byTs.keys()) {
    const bucket = bucketStart(ts * 1000, ctx.resolution).getTime();
    const prior = chosen.get(bucket);
    if (prior === undefined || ts < prior) chosen.set(bucket, ts);
  }

  for (const ts of [...chosen.values()].sort((a, b) => a - b)) {
    const row = byTs.get(ts)!;
    const tsMs = ts * 1000;
    const dataTs = bucketStart(tsMs, ctx.resolution).toISOString();
    const observedTs = new Date(tsMs).toISOString();

    const supplyApy = num(row.supplyApy);
    const borrowApy = num(row.borrowApy);
    const supplyIndex = sharePrice(row.supplyAssets ?? null, row.supplyShares ?? null);
    const borrowIndex = sharePrice(row.borrowAssets ?? null, row.borrowShares ?? null);

    const loanPoint: HistoryPoint = {
      marketUid: makeMarketUid(lenderKey, chainId, loanAddress),
      lenderKey,
      chainId,
      dataTs,
      observedTs,
      source: "morpho-api",
      depositRate: supplyApy === undefined ? undefined : supplyApy * AS_PERCENT,
      variableBorrowRate: borrowApy === undefined ? undefined : borrowApy * AS_PERCENT,
      totalDeposits: toHuman(row.supplyAssets, loan.decimals),
      totalDebt: toHuman(row.borrowAssets, loan.decimals),
      totalDepositsUsd: num(row.supplyAssetsUsd),
      totalDebtUsd: num(row.borrowAssetsUsd),
      utilization: num(row.utilization),
    };
    if (supplyIndex || borrowIndex) {
      loanPoint.supplyIndex = supplyIndex;
      loanPoint.borrowIndex = borrowIndex;
      loanPoint.indexKind = "assets_per_share";
    }
    yield loanPoint;

    if (collateral) {
      const collateralAddress = collateral.address.toLowerCase() as Address;
      if (collateralAddress !== loanAddress) {
        yield {
          marketUid: makeMarketUid(lenderKey, chainId, collateralAddress),
          lenderKey,
          chainId,
          dataTs,
          observedTs,
          source: "morpho-api",
          totalDeposits: toHuman(row.collateralAssets, collateral.decimals),
          totalDepositsUsd: num(row.collateralAssetsUsd),
        };
      }
    }
  }
}
