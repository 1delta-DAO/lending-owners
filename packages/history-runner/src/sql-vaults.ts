import type { HistoryPoint } from "@lending-owners/core";

/**
 * NDJSON → `.sql` for the VAULT families — the earn-surface half of `sql.ts`,
 * and the psql twin of yield-tracer's `integst/vaultHistory`. The two MUST
 * agree: same runner-key → provider map, same column mapping, same merge rule.
 * A change here is a change there.
 *
 * What differs from the lending script:
 *
 *  1. **The uid is translated, not used.** `VAULT_<KEY>:<chain>:<addr>` is the
 *     collector's key; the snapshot tables key on `(chain_id, provider,
 *     vault_address)` in the LIVE fetcher's vocabulary. `PROVIDER_OF` is that
 *     translation, staged as a VALUES table so the join is plain SQL.
 *  2. **Four targets, split by provider.** Pendle, GMX and HyperCore have their
 *     own tables and units (`/earn/history` reads them the same way).
 *     Pendle re-keys from the AMM market the collector uses to the PT token the
 *     table uses, via `pendle_vaults_latest.market_address`.
 *  3. **The gate is `*_latest`.** No FK, but `vaults_snapshots.underlying` is
 *     NOT NULL and comes from there — and a vault the live cron never listed is
 *     skipped and counted, never written under a guessed identity.
 *  4. **Live rows win on merge.** The lending script lets the incoming value
 *     win; here an existing `live-cron` row keeps its values and the backfill
 *     only fills NULLs, while a backfill row can be corrected by a later one.
 *     Provenance is first-writer in both.
 */

/** Runner key → live provider. Mirror of `PROVIDER_OF` in yield-tracer. */
export const PROVIDER_OF: Record<string, string> = {
  VAULT_MORPHO: "morpho",
  VAULT_FLUID: "fluid",
  VAULT_YEARN: "yearn",
  VAULT_UPSHIFT: "upshift",
  VAULT_LAGOON: "lagoon",
  VAULT_SILO: "silo",
  VAULT_GEARBOX: "gearbox",
  VAULT_EULER_EARN: "euler-earn",
  VAULT_LISTA: "lst",
  VAULT_PENDLE: "pendle",
  VAULT_GMX: "gmx",
  VAULT_HYPERCORE: "hypercore",
  VAULT_CAP: "savings",
  VAULT_HYPERBEAT: "savings",
  VAULT_YIELDBASIS: "savings",
  VAULT_RE: "savings",
  VAULT_SDOLA: "savings",
  VAULT_SKY: "savings",
  VAULT_SPARK: "savings",
  VAULT_SFRXUSD: "savings",
  VAULT_WREN: "savings",
  VAULT_STRATA: "savings",
  VAULT_USDD: "savings",
  VAULT_YO: "savings",
  VAULT_FALCON: "savings",
  VAULT_TORI: "savings",
  VAULT_LLAMA: "savings",
  VAULT_VENUS_HUB: "savings",
};

/** Staging columns, in COPY order. Only what a vault row can carry into a
 *  target column; borrow-side and utilization fields have no home on the earn
 *  tables and are not staged. */
export const VAULT_COLUMNS = [
  "runner_key",
  "chain_id",
  "address",
  "data_ts",
  "source",
  "rate",
  "total_assets",
  "total_assets_usd",
  "share_index",
  "index_kind",
] as const;

const RATE_MAX = "1e10"; // numeric(18,8)
const AMOUNT_MAX = "1e22"; // numeric(40,18)
const USD_MAX = "1e30"; // numeric(40,10) / numeric(38,8)

/** Pendle's nominal APR from its implied APY — margin-fetcher's
 *  `apyToAprPercent`, same year length, so backfilled and live rows agree. */
const SECONDS_PER_YEAR = 31_536_000;

const capped = (col: string, max: string): string =>
  `CASE WHEN abs(s.${col}) >= ${max} THEN NULL ELSE s.${col} END`;

/** Live rows keep their values; backfill rows accept corrections. */
const merge = (table: string, col: string): string =>
  `CASE WHEN ${table}.source = 'live-cron'
        THEN COALESCE(${table}.${col}, excluded.${col})
        ELSE COALESCE(excluded.${col}, ${table}.${col}) END`;
const keepLiveSource = (table: string): string =>
  `CASE WHEN ${table}.source = 'live-cron' THEN 'live-cron' ELSE excluded.source END`;

function copyValue(v: unknown): string {
  if (v === null || v === undefined) return "\\N";
  if (typeof v === "number") return Number.isFinite(v) ? String(v) : "\\N";
  return String(v)
    .replace(/\\/g, "\\\\")
    .replace(/\t/g, "\\t")
    .replace(/\n/g, "\\n")
    .replace(/\r/g, "\\r");
}

/** `VAULT_SDOLA:1:0xb45a…` → COPY line, or null for a uid that is not a vault
 *  uid (never for an unknown key — those are staged and reported by SQL, so
 *  the operator sees them in the psql output rather than in a log here). */
export function toVaultCopyLine(p: HistoryPoint): string | null {
  const parts = String(p.marketUid).split(":");
  if (parts.length !== 3 || !parts[0]!.startsWith("VAULT_")) return null;
  const row: Record<(typeof VAULT_COLUMNS)[number], unknown> = {
    runner_key: parts[0],
    chain_id: parts[1],
    address: parts[2]!.toLowerCase(),
    data_ts: p.dataTs,
    source: p.source,
    rate: p.depositRate ?? null,
    total_assets: p.totalDeposits ?? null,
    total_assets_usd: p.totalDepositsUsd ?? null,
    share_index: p.supplyIndex ?? null,
    index_kind: p.indexKind ?? null,
  };
  return VAULT_COLUMNS.map((c) => copyValue(row[c])).join("\t");
}

const STAGE_DDL = `CREATE TEMP TABLE _vault_stage (
  runner_key       text,
  chain_id         text,
  address          text,
  data_ts          timestamptz,
  source           text,
  rate             numeric,
  total_assets     numeric,
  total_assets_usd numeric,
  -- text, NOT numeric: a wad index is a raw integer string that must land
  -- in share_price_raw verbatim, and numeric(60,30)::text would print it
  -- with thirty zero decimals. Only the assets_per_share kind is cast.
  share_index      text,
  index_kind       text
) ON COMMIT DROP;

CREATE TEMP TABLE _vault_provider (runner_key text PRIMARY KEY, provider text NOT NULL) ON COMMIT DROP;
INSERT INTO _vault_provider VALUES
${Object.entries(PROVIDER_OF)
  .map(([k, v]) => `  ('${k}', '${v}')`)
  .join(",\n")};
`;

const RESOLVE_DDL = `-- One resolved row per staged row: the live identity it joins, or NULLs.
-- Pendle re-keys market → PT; everything else keys on the address as-is.
CREATE TEMP TABLE _vault_resolved ON COMMIT DROP AS
SELECT s.*,
       p.provider,
       CASE WHEN p.provider = 'pendle' THEN lower(pl.vault_address)
            WHEN p.provider = 'gmx'    THEN lower(gl.vault_address)
            WHEN p.provider = 'hypercore' THEN lower(hl.vault_address)
            ELSE lower(vl.vault_address) END AS vault_address,
       vl.underlying
  FROM _vault_stage s
  LEFT JOIN _vault_provider p ON p.runner_key = s.runner_key
  LEFT JOIN vaults_latest vl
         ON p.provider NOT IN ('pendle', 'gmx', 'hypercore')
        AND vl.chain_id = s.chain_id AND vl.provider = p.provider
        AND lower(vl.vault_address) = s.address
  LEFT JOIN pendle_vaults_latest pl
         ON p.provider = 'pendle'
        AND pl.chain_id = s.chain_id AND lower(pl.market_address) = s.address
  LEFT JOIN gmx_vaults_latest gl
         ON p.provider = 'gmx'
        AND gl.chain_id = s.chain_id AND lower(gl.vault_address) = s.address
  LEFT JOIN hypercore_vaults_latest hl
         ON p.provider = 'hypercore'
        AND hl.chain_id = s.chain_id AND lower(hl.vault_address) = s.address;`;

const GENERIC_INSERT = `INSERT INTO vaults_snapshots (
    chain_id, provider, vault_address, underlying, data_ts,
    total_rate, total_assets_formatted, total_assets_usd,
    share_price, share_price_raw, source
)
SELECT DISTINCT ON (s.chain_id, s.provider, s.vault_address, s.data_ts)
       s.chain_id, s.provider, s.vault_address, s.underlying, s.data_ts,
       -- The source's headline rate → total_rate. The base/rewards split is
       -- unknown, so deposit_rate stays NULL rather than asserting rewards = 0.
       ${capped("rate", RATE_MAX)},
       ${capped("total_assets", AMOUNT_MAX)},
       ${capped("total_assets_usd", USD_MAX)},
       -- assets_per_share is the formatted "1 share → X assets" the read
       -- surface plots; other kinds are the protocol's raw integer.
       CASE WHEN s.index_kind = 'assets_per_share' THEN s.share_index::numeric(40,18) END,
       CASE WHEN s.index_kind IS DISTINCT FROM 'assets_per_share' THEN s.share_index END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL
   AND s.provider NOT IN ('pendle', 'gmx', 'hypercore')
   AND (s.rate IS NOT NULL OR s.total_assets IS NOT NULL
        OR s.total_assets_usd IS NOT NULL OR s.share_index IS NOT NULL)
 ORDER BY s.chain_id, s.provider, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, provider, vault_address, data_ts) DO UPDATE SET
    total_rate             = ${merge("vaults_snapshots", "total_rate")},
    total_assets_formatted = ${merge("vaults_snapshots", "total_assets_formatted")},
    total_assets_usd       = ${merge("vaults_snapshots", "total_assets_usd")},
    share_price            = ${merge("vaults_snapshots", "share_price")},
    share_price_raw        = ${merge("vaults_snapshots", "share_price_raw")},
    source                 = ${keepLiveSource("vaults_snapshots")};`;

const PENDLE_INSERT = `INSERT INTO pendle_vaults_snapshots (
    chain_id, vault_address, data_ts, implied_apy, supply_rate, tvl_usd, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       ${capped("rate", RATE_MAX)},
       -- nominal APR from the implied APY: margin-fetcher's apyToAprPercent
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= ${RATE_MAX} THEN NULL
            ELSE 100 * (power(s.rate / 100 + 1, 1.0 / ${SECONDS_PER_YEAR}) - 1) * ${SECONDS_PER_YEAR} END,
       ${capped("total_assets_usd", USD_MAX)},
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'pendle'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    implied_apy = ${merge("pendle_vaults_snapshots", "implied_apy")},
    supply_rate = ${merge("pendle_vaults_snapshots", "supply_rate")},
    tvl_usd     = ${merge("pendle_vaults_snapshots", "tvl_usd")},
    source      = ${keepLiveSource("pendle_vaults_snapshots")};`;

const GMX_INSERT = `INSERT INTO gmx_vaults_snapshots (
    chain_id, vault_address, data_ts, apy, tvl_usd, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       -- gmx_vaults_snapshots.apy is a FRACTION (rateIsFraction in earn.ts);
       -- the collector normalized to percent, so divide back down here.
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= ${RATE_MAX} THEN NULL ELSE s.rate / 100 END,
       ${capped("total_assets_usd", USD_MAX)},
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'gmx'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    apy     = ${merge("gmx_vaults_snapshots", "apy")},
    tvl_usd = ${merge("gmx_vaults_snapshots", "tvl_usd")},
    source  = ${keepLiveSource("gmx_vaults_snapshots")};`;

const HYPERCORE_INSERT = `INSERT INTO hypercore_vaults_snapshots (
    chain_id, vault_address, data_ts, tvl_usd, apr, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       ${capped("total_assets_usd", USD_MAX)},
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= ${RATE_MAX} THEN NULL ELSE s.rate / 100 END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'hypercore'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    tvl_usd = ${merge("hypercore_vaults_snapshots", "tvl_usd")},
    apr     = ${merge("hypercore_vaults_snapshots", "apr")},
    source  = ${keepLiveSource("hypercore_vaults_snapshots")};`;

/** Echoed before COMMIT — the skip counts an operator must see. */
const REPORT = `SELECT
    (SELECT count(*) FROM _vault_stage)                                          AS staged_rows,
    (SELECT count(*) FROM _vault_resolved WHERE provider IS NULL)                AS rows_unmapped_key,
    (SELECT count(*) FROM _vault_resolved WHERE provider IS NOT NULL AND vault_address IS NULL)
                                                                                 AS rows_unknown_vault,
    (SELECT count(DISTINCT runner_key || ':' || chain_id || ':' || address)
       FROM _vault_resolved WHERE provider IS NOT NULL AND vault_address IS NULL) AS unknown_vaults
\\gset _vault_
\\echo '  staged=':_vault_staged_rows'  unmapped_key_rows=':_vault_rows_unmapped_key'  unknown_vault_rows=':_vault_rows_unknown_vault'  unknown_vaults=':_vault_unknown_vaults`;

export interface VaultSqlMeta {
  rows: number;
  generatedFrom: string;
}

export function renderVaultSql(lines: string[], meta: VaultSqlMeta): string {
  return [
    `-- Generated from ${meta.generatedFrom} (${meta.rows} vault rows)`,
    `-- Apply with:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <this file>`,
    `--`,
    `-- Requires yield-tracer migration 0141 (the \`source\` column on the vault`,
    `-- snapshot tables). Safe to re-run: every insert upserts on the table's`,
    `-- unique index, live-cron rows are never overwritten or relabelled.`,
    `-- Rows for vaults the live surface does not list are skipped, not fatal,`,
    `-- and the counts are echoed before COMMIT.`,
    `\\set ON_ERROR_STOP on`,
    `BEGIN;`,
    ``,
    STAGE_DDL,
    ``,
    `COPY _vault_stage (${VAULT_COLUMNS.join(", ")}) FROM stdin;`,
    ...lines,
    `\\.`,
    ``,
    `ANALYZE _vault_stage;`,
    ``,
    RESOLVE_DDL,
    ``,
    `ANALYZE _vault_resolved;`,
    ``,
    GENERIC_INSERT,
    ``,
    PENDLE_INSERT,
    ``,
    GMX_INSERT,
    ``,
    HYPERCORE_INSERT,
    ``,
    REPORT,
    ``,
    `COMMIT;`,
    ``,
  ].join("\n");
}
