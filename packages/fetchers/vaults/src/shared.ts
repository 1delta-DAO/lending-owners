/**
 * Vault-provider history fetchers — the earn-surface counterpart of the
 * per-lender `hist/` modules. Source matrix, retention limits and traps are
 * documented (curl-verified) in margin-fetcher
 * `src/vaults/HISTORY_APIS.md`; every module here cites the row it implements.
 *
 * Conventions on top of `HistoryPoint`:
 *  - uid: `VAULT_<PROVIDER>:<chainId>:<vaultAddress>` via `makeMarketUid`.
 *    These deliberately do NOT join yield-tracer's lending `markets` table —
 *    the SQL export skips them, which is correct until a vault ingest exists.
 *  - share price → `supplyIndex` (decimal string) with
 *    `indexKind: "assets_per_share"`.
 *  - APY → `depositRate`, **percent** (the repo-wide rule; sources disagree —
 *    every module normalizes on the way out and says so at the call site).
 *  - TVL → `totalDepositsUsd` (USD) / `totalDeposits` (asset units).
 */

/** Fraction → percent. Call sites use this to MARK a conversion, so a reader
 *  can grep where units were changed. */
export const fractionToPercent = (fraction: number): number => fraction * 100;

/** Tolerant numeric parse: APIs in this set hand back numbers, decimal
 *  strings, and nulls interchangeably. */
export const num = (v: unknown): number | undefined => {
  if (v === null || v === undefined || v === "") return undefined;
  const n = Number(v);
  return Number.isFinite(n) ? n : undefined;
};

/** Keep a decimal string as-is when it parses, else undefined — for
 *  `supplyIndex`, which must never round-trip through float64. */
export const decimalString = (v: unknown): string | undefined => {
  if (typeof v === "number") return Number.isFinite(v) ? String(v) : undefined;
  if (typeof v !== "string" || v === "") return undefined;
  return Number.isFinite(Number(v)) ? v : undefined;
};
