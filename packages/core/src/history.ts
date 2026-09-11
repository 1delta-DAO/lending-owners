import type { Address, ChainId, LenderKey, MarketUid } from "./types.js";

/**
 * The second axis of this repo: historical rates, totals and accumulator
 * (share-price / index) series per market. See LENDING_HISTORY_BACKFILL_PLAN.md
 * §0.8 for why collection lives here and ingestion lives in `yield-tracer`.
 */

export type HistoryResolution = "1d" | "1h";

/** Provenance, carried on every row so backfilled data can be re-derived or
 *  dropped independently of the live hourly cron. Mirrors the `source` column
 *  the plan adds to `lending_snapshots` (§5). */
export type HistorySource =
  | "morpho-api"
  | "euler-api"
  | "aave-api"
  | "compound-api"
  | "venus-api"
  | "moonwell-ponder"
  | "curve-api"
  | "subgraph"
  | "archival-rpc"
  // Vault-provider sources (the earn surface — see margin-fetcher
  // `src/vaults/HISTORY_APIS.md` for the curl-verified per-source matrix).
  | "pendle-api"
  | "lagoon-api"
  | "upshift-api"
  | "yearn-kong"
  | "fluid-api"
  | "gearbox-api"
  | "gmx-squid"
  | "hyperliquid-api"
  | "cap-api"
  | "hyperbeat-api"
  | "yieldbasis-api"
  | "silo-api"
  // Savings-registry and earn sources added 2026-09-09 (HISTORY_GAPS §3.1/§3.3
  // closed): every one curl-verified before the module was written, and the
  // retention limit that decides whether it needs the daily ratchet is stated
  // in the module's header.
  | "re-api"
  | "inverse-api"
  | "blockanalitica-api"
  | "frax-api"
  | "wren-api"
  | "falcon-api"
  | "tori-api"
  | "yo-api"
  | "strata-api"
  | "usdd-api"
  | "euler-earn-api"
  | "defillama-api"
  | "lista-api";

/**
 * What the raw accumulator number means. Kept alongside the value rather than
 * normalized at collection time: normalizing loses the protocol-native number,
 * and the ratio of two samples is scale-free anyway, so the consumer never
 * needs the unit to compute realized return — only to display it.
 */
export type IndexKind = "ray" | "wad" | "assets_per_share" | "exchange_rate";

/**
 * One line of the NDJSON output: everything known about one market at one
 * bucket. Every field beyond the key is optional — a source fills what it has,
 * and no source fills all of it.
 *
 * **Rates are PERCENT, not fractions** — `4.90` means 4.90 % APY. This is not
 * a preference: it is what `lending_snapshots.deposit_rate` already holds, per
 * `yield-tracer/app/src/integst/lending/index.ts` (`depositRate?: number; // %
 * like 4.90 => 4.90`). Sources disagree with each other here — Compound and
 * Aave hand back fractions, Curve and Euler hand back percent — so every
 * fetcher normalizes on the way out. Getting this wrong is a silent 100×
 * error that only shows up as an absurd realized-vs-quoted gap much later.
 */
export interface HistoryPoint {
  /** Must match `computeMarketUid` in yield-tracer exactly, or the row will
   *  not join `markets` — and `lending_snapshots` has an FK, so a mismatch is
   *  a hard insert failure, not a silent orphan. See plan §0.10.1. */
  marketUid: MarketUid;
  lenderKey: LenderKey;
  chainId: ChainId;
  /** Bucket start, normalized to `resolution`, ISO-8601 UTC. This is the
   *  idempotency key together with `marketUid` — never the raw source stamp,
   *  which drifts between runs (Venus samples at 18:03 one day, 23:41 the
   *  next) and would duplicate rows on every re-run. */
  dataTs: string;
  /** The un-normalized timestamp the source actually reported, when it differs
   *  from the bucket. Kept because it is the truth about when the sample was
   *  taken, and the drift explains small realized-vs-quoted discrepancies. */
  observedTs?: string;
  source: HistorySource;
  /** Present when the source pins one (Venus) or when we pinned it ourselves
   *  (archival replay). Makes the accumulator read reproducible. */
  blockNumber?: number;

  // ── spot state — a point sample, unrecoverable if not captured (plan §1) ───
  depositRate?: number;
  variableBorrowRate?: number;
  totalDeposits?: number;
  totalDebt?: number;
  totalDepositsUsd?: number;
  totalDebtUsd?: number;
  utilization?: number;

  // ── accumulator — monotone, path-independent, the actual product (plan §1) ─
  /** Decimal string, NOT a number: these carry up to 30 significant digits
   *  (`numeric(60,30)` in the target schema) and float64 silently truncates
   *  the tail that the realized-return ratio depends on. */
  supplyIndex?: string;
  borrowIndex?: string;
  indexKind?: IndexKind;
}

/**
 * Maps a protocol-native market identifier to our `market_uid`.
 *
 * Every family keys its uid on a different leaf — vToken for Compound V2 forks,
 * mToken for Moonwell, vault for Euler, silo for Silo, underlying for Aave —
 * and `lending_snapshots` has an FK to `markets`, so a uid built even slightly
 * differently is not an orphan row, it is a rejected insert. Rather than
 * re-deriving five variants of that rule (the exact hazard A1 exists to close),
 * a fetcher hands over what the protocol calls the market and the runner looks
 * up the uid our book already uses. Unresolvable markets are dropped and
 * counted, never guessed at.
 */
export type UidResolver = (
  chainId: ChainId,
  leafAddress: string,
) => MarketUid | undefined;

export interface HistoryContext {
  /** Inclusive bucket floor. */
  from: Date;
  /** Inclusive bucket ceiling. */
  to: Date;
  resolution: HistoryResolution;
  chainIds?: ChainId[];
  signal?: AbortSignal;
  /** Called as markets complete so a multi-hour run is observable. */
  onProgress?: (done: number, total: number, label: string) => void;
  /** Injected by the runner. A fetcher that needs it and does not get it should
   *  fail loudly rather than invent uids. */
  resolveUid?: UidResolver;
}

/**
 * Sibling of `OwnershipFetcher`. Async-iterable rather than array-returning:
 * Morpho alone is ~3,300 markets × ~700 daily points, which must stream to
 * disk instead of accumulating in memory.
 */
export interface HistoryFetcher {
  readonly lenderKey: LenderKey;
  readonly source: HistorySource;
  /** Lower bound of what this source can serve, when it is a known constant —
   *  Euler's indexer genesis, Compound's 30-day roll. Used to warn when a
   *  requested `from` predates it rather than silently returning less. */
  readonly earliest?: (now: Date) => Date | undefined;
  fetch(ctx: HistoryContext): AsyncIterable<HistoryPoint>;
}

const MS_HOUR = 3_600_000;
const MS_DAY = 86_400_000;

/** Floors a timestamp to its bucket. Daily buckets are UTC midnight. */
export function bucketStart(ts: Date | number, resolution: HistoryResolution): Date {
  const ms = typeof ts === "number" ? ts : ts.getTime();
  const size = resolution === "1h" ? MS_HOUR : MS_DAY;
  return new Date(Math.floor(ms / size) * size);
}

/**
 * Re-label a point by the hour its observation actually happened in.
 *
 * Sources disagree about when in a day they sample. Measured across the whole
 * corpus: Aave, Euler, Morpho, Moonwell and LlamaLend emit day-aligned points
 * (`observedTs === dataTs`, drift 0.00h), while Venus, Compound V3 and eight
 * vault providers sample at arbitrary times — Venus's worst case put a nominal
 * 24 h step 24.0 h away from reality.
 *
 * Flooring those to midnight is harmless for rates and totals: a rate stamped
 * to a day is still that day's rate. It is NOT harmless for accumulators, where
 * realized return divides by elapsed time — a step labelled 24 h whose reality
 * was 47.9 h reads roughly 2x wrong. Five families both drift and carry an
 * index (Lagoon, Silo, YieldBasis, Gearbox, Cap), so this is a live problem,
 * not a hypothetical one.
 *
 * Labelling by the observation's hour bounds the error at 1 h (≈4 % on a daily
 * step instead of ≈100 %) and still lands on an exact hour boundary, which is
 * what `lending_snapshots` is keyed on — the live cron floors to the hour too.
 * Day-aligned sources are unaffected: their observation IS midnight, so the
 * hour bucket of it is midnight.
 */
export function alignToObservation(point: HistoryPoint): HistoryPoint {
  if (!point.observedTs) return point;
  const observed = Date.parse(point.observedTs);
  if (!Number.isFinite(observed)) return point;
  const hour = bucketStart(observed, "1h").toISOString();
  if (hour === point.dataTs) return point;
  return { ...point, dataTs: hour };
}

/** Stable sort key for NDJSON output and for dedup on append. */
export function pointKey(p: HistoryPoint): string {
  return `${p.marketUid} ${p.dataTs}`;
}

/**
 * Realized APY between two accumulator samples. This is the whole point of the
 * index column: it is exact and path-independent, so it needs no assumption
 * about compounding or about what the rate did in between (plan §1).
 */
export function realizedApy(
  first: { index: string; ts: string },
  last: { index: string; ts: string },
): number | undefined {
  const i0 = Number(first.index);
  const i1 = Number(last.index);
  const days = (Date.parse(last.ts) - Date.parse(first.ts)) / MS_DAY;
  if (!(i0 > 0) || !(i1 > 0) || !(days > 0)) return undefined;
  return (i1 / i0) ** (365 / days) - 1;
}

/** `0xAbC` → `0xabc`, for uid components. */
export const lower = (a: string): Address => a.toLowerCase() as Address;
