/**
 * Minimum owner fraction per lender: owners holding less than this share of a market's
 * total supply are excluded from the snapshot. Applied at the subgraph query level via
 * `balance_gt` to avoid fetching positions that will be filtered out anyway.
 *
 * Values are fractions in [0, 1]. Default is 0.01 (1%).
 * Tune per lender as data density requires.
 */
export const OWNER_FRACTION_BY_LENDER: Record<string, number> = {
  AAVE_V3: 0.01,
  MORPHO_BLUE: 0.01,
  COMPOUND_V3: 0.01,
  SILO: 0.01,
  SPARK: 0.01,
  VENUS: 0.01,
  DFORCE: 0.01,
  MOONWELL: 0.01,
};

export const DEFAULT_OWNER_FRACTION = 0.01;
