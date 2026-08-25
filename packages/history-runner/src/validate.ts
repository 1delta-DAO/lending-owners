import { createReadStream } from "node:fs";
import { readdir, stat } from "node:fs/promises";
import path from "node:path";
import { createInterface } from "node:readline";
import { fileURLToPath } from "node:url";
import type { HistoryPoint } from "@lending-owners/core";

/**
 * Back-check NDJSON against the columns it is destined for, BEFORE it is
 * shipped anywhere.
 *
 *   pnpm validate:history --dir data/history
 *
 * Two classes of problem, both of which have already happened here:
 *
 *  1. **Overflow.** `lending_snapshots.deposit_rate` is `numeric(18,8)`, whose
 *     magnitude ceiling is 10^(18-8) = 10^10. Postgres does not clamp — it
 *     raises `numeric field overflow` and aborts the entire multi-row INSERT,
 *     so one dust market with a runaway IRM takes down a batch of thousands.
 *  2. **Unit drift.** Sources disagree on percent vs fraction, and a 100×
 *     error is invisible in review because the numbers still look like rates.
 *     A plausibility band catches it: a family whose median deposit rate is
 *     ~0.03 is reporting fractions; ~300 is reporting basis points.
 */

/** `numeric(p,s)` holds magnitudes strictly below 10^(p−s). */
const COLUMN_LIMITS: Record<string, { column: string; max: number }> = {
  depositRate: { column: "lending_snapshots.deposit_rate numeric(18,8)", max: 1e10 },
  variableBorrowRate: { column: "lending_snapshots.variable_borrow_rate numeric(18,8)", max: 1e10 },
  totalDeposits: { column: "lending_snapshots.total_deposits numeric(40,18)", max: 1e22 },
  totalDebt: { column: "lending_snapshots.total_debt numeric(40,18)", max: 1e22 },
  totalDepositsUsd: { column: "lending_snapshots.total_deposits_usd numeric(40,10)", max: 1e30 },
  totalDebtUsd: { column: "lending_snapshots.total_debt_usd numeric(40,10)", max: 1e30 },
};

/** Median deposit rate outside this band almost certainly means wrong units.
 *  Real lending markets sit between roughly 0.1 % and 60 % APY. */
const PLAUSIBLE_MEDIAN = { low: 0.05, high: 200 };

interface FamilyStats {
  rows: number;
  uids: Set<string>;
  overflow: Map<string, number>;
  overflowExample: Map<string, number>;
  nonFinite: number;
  badTimestamp: number;
  missingUid: number;
  emptyRows: number;
  depositRates: number[];
  indexRows: number;
  badIndex: number;
  sources: Set<string>;
  minTs: string | null;
  maxTs: string | null;
}

function emptyStats(): FamilyStats {
  return {
    rows: 0,
    uids: new Set(),
    overflow: new Map(),
    overflowExample: new Map(),
    nonFinite: 0,
    badTimestamp: 0,
    missingUid: 0,
    emptyRows: 0,
    depositRates: [],
    indexRows: 0,
    badIndex: 0,
    sources: new Set(),
    minTs: null,
    maxTs: null,
  };
}

const SPOT_FIELDS = [
  "depositRate",
  "variableBorrowRate",
  "totalDeposits",
  "totalDebt",
  "totalDepositsUsd",
  "totalDebtUsd",
  "utilization",
] as const;

function checkRow(s: FamilyStats, r: HistoryPoint): void {
  s.rows += 1;
  if (!r.marketUid || typeof r.marketUid !== "string") s.missingUid += 1;
  else s.uids.add(r.marketUid);
  if (r.source) s.sources.add(r.source);

  const ts = Date.parse(r.dataTs);
  if (!Number.isFinite(ts)) s.badTimestamp += 1;
  else {
    const d = r.dataTs.slice(0, 10);
    if (!s.minTs || d < s.minTs) s.minTs = d;
    if (!s.maxTs || d > s.maxTs) s.maxTs = d;
  }

  for (const [field, { max }] of Object.entries(COLUMN_LIMITS)) {
    const v = (r as unknown as Record<string, unknown>)[field];
    if (v == null) continue;
    if (typeof v !== "number" || !Number.isFinite(v)) {
      s.nonFinite += 1;
      continue;
    }
    if (Math.abs(v) >= max) {
      s.overflow.set(field, (s.overflow.get(field) ?? 0) + 1);
      const prior = s.overflowExample.get(field) ?? 0;
      if (Math.abs(v) > prior) s.overflowExample.set(field, v);
    }
  }

  if (typeof r.depositRate === "number" && Number.isFinite(r.depositRate) && r.depositRate > 0) {
    s.depositRates.push(r.depositRate);
  }

  if (r.supplyIndex || r.borrowIndex) {
    s.indexRows += 1;
    for (const v of [r.supplyIndex, r.borrowIndex]) {
      if (v == null) continue;
      // Must be a plain decimal STRING — a number here means precision was
      // already lost upstream, and `numeric(60,30)` cannot get it back.
      if (typeof v !== "string" || !/^-?\d+(\.\d+)?$/.test(v)) s.badIndex += 1;
    }
  }

  const hasAny = SPOT_FIELDS.some(
    (f) => (r as unknown as Record<string, unknown>)[f] != null,
  );
  if (!hasAny && !r.supplyIndex && !r.borrowIndex) s.emptyRows += 1;
}

function median(xs: number[]): number | undefined {
  if (xs.length === 0) return undefined;
  const a = [...xs].sort((x, y) => x - y);
  return a[Math.floor(a.length / 2)];
}

async function collect(dir: string): Promise<string[]> {
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

async function main(): Promise<void> {
  const argv = process.argv.slice(2);
  // Default relative to the REPO root, not the package — the script is run
  // through pnpm from either place.
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
  let dir = path.join(repoRoot, "data", "history");
  for (let i = 0; i < argv.length; i += 1) {
    if (argv[i] === "--dir") {
      dir = path.resolve(argv[i + 1] ?? dir);
      i += 1;
    }
  }
  dir = path.resolve(dir);
  if (!(await stat(dir).catch(() => null))) {
    console.error(`no such directory: ${dir}`);
    process.exitCode = 1;
    return;
  }

  const byFamily = new Map<string, FamilyStats>();
  for (const file of await collect(dir)) {
    const family = path.relative(dir, file).split(path.sep)[0]!;
    let s = byFamily.get(family);
    if (!s) byFamily.set(family, (s = emptyStats()));
    const rl = createInterface({
      input: createReadStream(file, "utf8"),
      crlfDelay: Number.POSITIVE_INFINITY,
    });
    for await (const line of rl) {
      if (!line.trim()) continue;
      try {
        checkRow(s, JSON.parse(line) as HistoryPoint);
      } catch {
        s.badTimestamp += 1;
      }
    }
  }

  let problems = 0;
  console.log(
    `${"family".padEnd(14)}${"rows".padStart(9)}${"uids".padStart(7)}${"medRate".padStart(9)}${"index".padStart(8)}${"empty".padStart(7)}  window`,
  );
  for (const [family, s] of [...byFamily].sort()) {
    const med = median(s.depositRates);
    console.log(
      `${family.padEnd(14)}${String(s.rows).padStart(9)}${String(s.uids.size).padStart(7)}` +
        `${(med === undefined ? "—" : med.toFixed(3)).padStart(9)}${String(s.indexRows).padStart(8)}` +
        `${String(s.emptyRows).padStart(7)}  ${s.minTs} → ${s.maxTs}`,
    );
  }

  console.log();
  for (const [family, s] of [...byFamily].sort()) {
    const say = (msg: string) => {
      problems += 1;
      console.log(`  ${family}: ${msg}`);
    };
    for (const [field, count] of s.overflow) {
      const worst = s.overflowExample.get(field);
      say(
        `${count} row(s) OVERFLOW ${COLUMN_LIMITS[field]!.column} (worst ${worst?.toExponential(3)}) — ` +
          `these abort the whole INSERT batch, they are not clamped`,
      );
    }
    if (s.nonFinite > 0) say(`${s.nonFinite} non-finite numeric value(s)`);
    if (s.badTimestamp > 0) say(`${s.badTimestamp} unparseable row(s)/timestamp(s)`);
    if (s.missingUid > 0) say(`${s.missingUid} row(s) with no market_uid`);
    if (s.badIndex > 0) say(`${s.badIndex} index value(s) not a decimal string — precision already lost`);
    const med = median(s.depositRates);
    if (med !== undefined && (med < PLAUSIBLE_MEDIAN.low || med > PLAUSIBLE_MEDIAN.high)) {
      say(
        `median deposit rate ${med.toFixed(4)} is outside [${PLAUSIBLE_MEDIAN.low}, ${PLAUSIBLE_MEDIAN.high}] — ` +
          `likely a percent/fraction unit error`,
      );
    }
    if (s.emptyRows > 0) {
      say(`${s.emptyRows} row(s) carry a key but no data — these are dropped at ingest`);
    }
  }

  if (problems === 0) console.log("no problems found");
  else {
    console.log(`\n${problems} problem(s) — fix before ingesting`);
    process.exitCode = 1;
  }
}

main();
