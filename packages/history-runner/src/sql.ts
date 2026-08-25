import { createReadStream } from "node:fs";
import { mkdir, readdir, stat, writeFile } from "node:fs/promises";
import path from "node:path";
import { createInterface } from "node:readline";
import type { HistoryPoint } from "@lending-owners/core";

/**
 * NDJSON → self-contained `.sql`, for operators who would rather run psql than
 * a Node script (a DBA with a connection but no checkout, a migration window, a
 * restore drill, a review-before-apply policy).
 *
 * The generated file is safe to run against production and safe to run twice.
 * Three properties do that work, and all three are non-obvious:
 *
 *  1. **It stages, then joins.** Rows land in a TEMP table and are inserted
 *     `JOIN markets USING (market_uid)`. Both target tables carry an FK to
 *     `markets`, so a direct INSERT of a backfill — which legitimately contains
 *     markets the live cron never saw — would abort the entire transaction on
 *     the first orphan. The join turns that into a skip, and the script reports
 *     how many it skipped.
 *  2. **It de-duplicates before inserting.** Postgres raises "cannot affect row
 *     a second time" if `ON CONFLICT DO UPDATE` fires twice for one key in a
 *     single statement, so `DISTINCT ON (market_uid, data_ts)` collapses to the
 *     last row per key first.
 *  3. **It COALESCEs on conflict.** A source carrying only rates must not blank
 *     the totals a richer source already wrote for the same bucket.
 *
 * Wrapped in BEGIN/COMMIT: a failed apply leaves nothing behind.
 */

/** Staging columns, in COPY order. */
const COLUMNS = [
  "market_uid",
  "data_ts",
  "source",
  "block_number",
  "deposit_rate",
  "variable_borrow_rate",
  "total_deposits",
  "total_debt",
  "total_deposits_usd",
  "total_debt_usd",
  "utilization",
  "supply_index",
  "borrow_index",
  "index_kind",
] as const;

const STAGE_DDL = `CREATE TEMP TABLE _hist_stage (
  market_uid           text,
  data_ts              timestamptz,
  source               text,
  block_number         bigint,
  deposit_rate         numeric,
  variable_borrow_rate numeric,
  total_deposits       numeric,
  total_debt           numeric,
  total_deposits_usd   numeric,
  total_debt_usd       numeric,
  utilization          numeric,
  supply_index         numeric(60,30),
  borrow_index         numeric(60,30),
  index_kind           text
) ON COMMIT DROP;`;

/** COPY text format: NULL is `\N`, and tab/newline/backslash must be escaped.
 *  Our values are addresses, ISO timestamps and numbers, but escaping is
 *  cheaper than trusting that forever. */
function copyValue(v: unknown): string {
  if (v === null || v === undefined) return "\\N";
  if (typeof v === "number") return Number.isFinite(v) ? String(v) : "\\N";
  return String(v)
    .replace(/\\/g, "\\\\")
    .replace(/\t/g, "\\t")
    .replace(/\n/g, "\\n")
    .replace(/\r/g, "\\r");
}

function toCopyLine(p: HistoryPoint): string {
  const row: Record<(typeof COLUMNS)[number], unknown> = {
    market_uid: p.marketUid,
    data_ts: p.dataTs,
    source: p.source,
    block_number: p.blockNumber ?? null,
    deposit_rate: p.depositRate ?? null,
    variable_borrow_rate: p.variableBorrowRate ?? null,
    total_deposits: p.totalDeposits ?? null,
    total_debt: p.totalDebt ?? null,
    total_deposits_usd: p.totalDepositsUsd ?? null,
    total_debt_usd: p.totalDebtUsd ?? null,
    utilization: p.utilization ?? null,
    // Strings, deliberately: these carry 30 significant digits and float64
    // would drop exactly the tail the realized-return ratio depends on.
    supply_index: p.supplyIndex ?? null,
    borrow_index: p.borrowIndex ?? null,
    index_kind: p.indexKind ?? null,
  };
  return COLUMNS.map((c) => copyValue(row[c])).join("\t");
}

const SPOT_INSERT = `INSERT INTO lending_snapshots (
    market_uid, data_ts, deposit_rate, variable_borrow_rate,
    total_deposits, total_debt, total_deposits_usd, total_debt_usd,
    utilization, source
)
SELECT DISTINCT ON (s.market_uid, s.data_ts)
       s.market_uid, s.data_ts, s.deposit_rate, s.variable_borrow_rate,
       s.total_deposits, s.total_debt, s.total_deposits_usd, s.total_debt_usd,
       s.utilization, s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.deposit_rate         IS NOT NULL
    OR s.variable_borrow_rate IS NOT NULL
    OR s.total_deposits       IS NOT NULL
    OR s.total_debt           IS NOT NULL
    OR s.total_deposits_usd   IS NOT NULL
    OR s.total_debt_usd       IS NOT NULL
    OR s.utilization          IS NOT NULL
 ORDER BY s.market_uid, s.data_ts, s.ctid DESC
ON CONFLICT (market_uid, data_ts) DO UPDATE SET
    deposit_rate         = COALESCE(excluded.deposit_rate,         lending_snapshots.deposit_rate),
    variable_borrow_rate = COALESCE(excluded.variable_borrow_rate, lending_snapshots.variable_borrow_rate),
    total_deposits       = COALESCE(excluded.total_deposits,       lending_snapshots.total_deposits),
    total_debt           = COALESCE(excluded.total_debt,           lending_snapshots.total_debt),
    total_deposits_usd   = COALESCE(excluded.total_deposits_usd,   lending_snapshots.total_deposits_usd),
    total_debt_usd       = COALESCE(excluded.total_debt_usd,       lending_snapshots.total_debt_usd),
    utilization          = COALESCE(excluded.utilization,          lending_snapshots.utilization),
    source               = excluded.source;`;

const INDEX_INSERT = `INSERT INTO market_index_snapshots (
    market_uid, data_ts, block_number, supply_index, borrow_index, index_kind, source
)
SELECT DISTINCT ON (s.market_uid, s.data_ts)
       s.market_uid, s.data_ts, s.block_number, s.supply_index, s.borrow_index,
       COALESCE(s.index_kind, 'unknown'), s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.supply_index IS NOT NULL
    OR s.borrow_index IS NOT NULL
 ORDER BY s.market_uid, s.data_ts, s.ctid DESC
ON CONFLICT (market_uid, data_ts) DO UPDATE SET
    block_number = COALESCE(excluded.block_number, market_index_snapshots.block_number),
    supply_index = COALESCE(excluded.supply_index, market_index_snapshots.supply_index),
    borrow_index = COALESCE(excluded.borrow_index, market_index_snapshots.borrow_index),
    index_kind   = excluded.index_kind,
    source       = excluded.source;`;

/** Emitted before COMMIT so an operator sees the skip count in the psql output
 *  rather than discovering the gap in a dashboard weeks later. */
const REPORT = `SELECT
    (SELECT count(*) FROM _hist_stage)                                     AS staged_rows,
    (SELECT count(DISTINCT s.market_uid) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS unknown_markets,
    (SELECT count(*) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS rows_skipped
\\gset _hist_
\\echo '  staged=':_hist_staged_rows'  skipped_rows=':_hist_rows_skipped'  unknown_markets=':_hist_unknown_markets`;

export interface SqlExportMeta {
  sourceFile: string;
  rows: number;
  generatedFrom: string;
}

/** Renders one self-contained script. `lines` are pre-rendered COPY rows. */
export function renderSql(lines: string[], meta: SqlExportMeta): string {
  return [
    `-- Generated from ${meta.generatedFrom} (${meta.rows} rows)`,
    `-- Apply with:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <this file>`,
    `--`,
    `-- Safe to re-run: every insert upserts on (market_uid, data_ts).`,
    `-- Safe against the markets FK: rows for unknown markets are skipped, not`,
    `-- fatal, and the count is echoed before COMMIT.`,
    `\\set ON_ERROR_STOP on`,
    `BEGIN;`,
    ``,
    STAGE_DDL,
    ``,
    `COPY _hist_stage (${COLUMNS.join(", ")}) FROM stdin;`,
    ...lines,
    `\\.`,
    ``,
    `ANALYZE _hist_stage;`,
    ``,
    SPOT_INSERT,
    ``,
    INDEX_INSERT,
    ``,
    REPORT,
    ``,
    `COMMIT;`,
    ``,
  ].join("\n");
}

async function collectFiles(dir: string): Promise<string[]> {
  const out: string[] = [];
  const walk = async (d: string): Promise<void> => {
    for (const e of await readdir(d, { withFileTypes: true })) {
      const full = path.join(d, e.name);
      if (e.isDirectory()) await walk(full);
      else if (e.name.endsWith(".ndjson")) out.push(full);
    }
  };
  await walk(dir);
  return out.sort();
}

async function convert(file: string, inDir: string, outDir: string): Promise<number> {
  const lines: string[] = [];
  let malformed = 0;
  const rl = createInterface({
    input: createReadStream(file, "utf8"),
    crlfDelay: Number.POSITIVE_INFINITY,
  });
  for await (const line of rl) {
    if (!line.trim()) continue;
    try {
      lines.push(toCopyLine(JSON.parse(line) as HistoryPoint));
    } catch {
      malformed += 1;
    }
  }
  if (malformed > 0) console.warn(`  ${path.basename(file)}: ${malformed} unparseable line(s)`);
  if (lines.length === 0) return 0;

  const rel = path.relative(inDir, file).replace(/\.ndjson$/, ".sql");
  const target = path.join(outDir, rel);
  await mkdir(path.dirname(target), { recursive: true });
  await writeFile(
    target,
    renderSql(lines, { sourceFile: file, rows: lines.length, generatedFrom: path.relative(inDir, file) }),
    "utf8",
  );
  return lines.length;
}

async function main(): Promise<void> {
  const argv = process.argv.slice(2);
  let inDir = "data/history";
  let outDir = "data/history-sql";
  const only: string[] = [];
  for (let i = 0; i < argv.length; i += 1) {
    const a = argv[i];
    const v = (): string => {
      const x = argv[i + 1];
      if (!x) throw new Error(`missing value for ${a}`);
      return x;
    };
    if (a === "--dir") { inDir = path.resolve(v()); i += 1; }
    else if (a === "--out") { outDir = path.resolve(v()); i += 1; }
    else if (a === "--family" || a === "--lender") { only.push(v().toUpperCase()); i += 1; }
    else if (a === "--") { /* pnpm separator */ }
    else if (a?.startsWith("--")) throw new Error(`unknown flag ${a}`);
  }
  inDir = path.resolve(inDir);
  outDir = path.resolve(outDir);

  const s = await stat(inDir).catch(() => null);
  if (!s) {
    console.error(`no such directory: ${inDir}`);
    process.exitCode = 1;
    return;
  }
  let files = await collectFiles(inDir);
  if (only.length > 0) {
    files = files.filter((f) => only.some((fam) => path.relative(inDir, f).startsWith(`${fam}/`)));
  }
  if (files.length === 0) {
    console.error("no .ndjson files matched");
    process.exitCode = 1;
    return;
  }

  console.log(`converting ${files.length} file(s) → ${outDir}`);
  let rows = 0;
  for (const f of files) {
    const n = await convert(f, inDir, outDir);
    rows += n;
    console.log(`  ${path.relative(inDir, f)} → ${n} rows`);
  }
  console.log(`\ndone — ${rows} rows across ${files.length} file(s) in ${outDir}`);
  console.log(`apply one:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <file>`);
  console.log(`apply all:  find ${outDir} -name '*.sql' | sort | xargs -I{} psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f {}`);
}

main();
