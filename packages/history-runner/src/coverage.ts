import { createReadStream } from "node:fs";
import { mkdir, readdir, readFile, stat, writeFile } from "node:fs/promises";
import path from "node:path";
import { createInterface } from "node:readline";
import { fileURLToPath } from "node:url";
import type { HistoryPoint } from "@lending-owners/core";
import { DECAYING, FETCHERS } from "./fetchers.js";
import { VAULT_PROVIDER_ROSTER } from "./vault-providers.js";
import { META_URL } from "./registry.js";

/**
 * Coverage report: what history do we actually hold, and what is still missing.
 *
 *   pnpm coverage:history
 *   pnpm coverage:history -- --offline          # disk only, no book fetch
 *   pnpm coverage:history -- --book /tmp/meta.json
 *
 * Three questions, which HISTORY_GAPS.md answers by hand and therefore only
 * answers as of the day someone last edited it:
 *
 *  1. **Held** — per lender/vault provider, per chain, per market: how many
 *     points, over what window, how dense, which series (rate / totals / USD /
 *     accumulator), and how old the newest point is.
 *  2. **Missing** — every market in the live book (`/meta/lending/complete`,
 *     the same document the uid registry is built from) that has no history
 *     row at all, split by whether a module exists for its family or not.
 *     That split is the whole point: a gap inside a covered family is a
 *     backfill run, a family with no module is code that has to be written.
 *  3. **Decaying** — a rolling-window source whose newest point is stale is
 *     losing days permanently, so it is called out separately from a durable
 *     source that is merely behind (plan §0.1).
 *
 * Output is written to `data/coverage/` (gitignored — it is derived, and the
 * missing-market CSV alone is ~1 MB): `COVERAGE.md` to read, `coverage.json`
 * for anything programmatic, `missing-markets.csv` to work through.
 *
 * Vault MARKETS are reported held-only: their uids
 * (`VAULT_<PROVIDER>:<chain>:<addr>`) deliberately do not exist in the lending
 * book, so there is no roster to diff a single vault against — a missing vault
 * can only be found by asking the provider's own API, which is what a fetch run
 * does. Vault PROVIDERS are diffed, against the declared earn-side roster in
 * `vault-providers.ts` (the sources the live fetcher pulls spot data for, and
 * whether their upstream API also serves history).
 */

/** Bit per series family, so "what does this market actually carry" costs one
 *  number per market rather than a Set per market across ~10k markets. */
const F_DEPOSIT_RATE = 1 << 0;
const F_BORROW_RATE = 1 << 1;
const F_TOTALS = 1 << 2;
const F_USD = 1 << 3;
const F_INDEX = 1 << 4;
const F_UTILIZATION = 1 << 5;

const SERIES_LABEL: ReadonlyArray<[number, string]> = [
  [F_DEPOSIT_RATE, "depositRate"],
  [F_BORROW_RATE, "borrowRate"],
  [F_TOTALS, "totals"],
  [F_USD, "usd"],
  [F_INDEX, "index"],
  [F_UTILIZATION, "utilization"],
];

const MS_DAY = 86_400_000;
const dayNum = (iso: string): number => Math.floor(Date.parse(iso) / MS_DAY);
const dayIso = (n: number): string => new Date(n * MS_DAY).toISOString().slice(0, 10);

interface MarketCoverage {
  uid: string;
  /** The runner key the rows were filed under — the `data/history/<KEY>/` dir. */
  lenderKey: string;
  chainId: string;
  points: number;
  firstDay: number;
  lastDay: number;
  /** Distinct day buckets seen. Compared against the span, this is density:
   *  a series with 700 days of span and 120 days of data is not "backfilled". */
  days: Set<number>;
  fields: number;
  sources: Set<string>;
}

/**
 * Above this, the size proxy is not a market — it is a broken input. Measured
 * on the live book: 5 of 16,215 priced markets exceed it, and every one is
 * either an uncapped collateral-only vault reporting a 1e17 "liquidity" at a
 * placeholder price of $1, or a junk oracle quoting $1e12 a token. Summed
 * unguarded they turn a family total into `$308891001.08B`, which is worse
 * than no number at all. They are dropped and counted, never clamped: a
 * clamped value would still be wrong, just less obviously.
 */
const SIZE_CEILING_USD = 1e11;

interface BookMarket {
  uid: string;
  chainId: string;
  /** Uid family as the book spells it — `MORPHO_BLUE_<marketId>`. */
  family: string;
  /** Family with the per-market id stripped — `MORPHO_BLUE`. */
  root: string;
  name: string;
  symbol: string;
  /** Withdrawable liquidity × spot price. A size PROXY, not TVL: the book
   *  carries no supplied total, and liquidity understates a heavily borrowed
   *  market. Good enough to rank 6,000 missing markets by, which is all it is
   *  used for. */
  sizeUsd?: number;
  active: boolean;
}

/**
 * Isolated-market families mint one uid family per market, and they do it
 * three different ways: `MORPHO_BLUE_<marketId>`, `FRAXLEND_1_<pair>`,
 * `TWYNE_1_<vault>_<underlying>` (two hex segments), `FLUID_1_13` and
 * `SKY_1_ETH_C` (chain id then an index or an ilk name). Left alone, the book
 * reports 6,829 "families" and no row of the report means anything; normalized
 * it reports 168, which is the number of protocols there actually are.
 *
 * The rule: cut at the first segment that is either 8+ hex characters or a
 * bare number that is a chain id IN THIS BOOK. Data-driven on the chain-id
 * half deliberately — `COMPOUND_V3_USDC` and `AAVE_V3_PRIME` must survive
 * intact, and only the live chain list can tell `LIQUITY_V2_1_1` (protocol,
 * chain 1, branch 1) from a suffix that is part of the name.
 */
function makeFamilyRoot(chainIds: ReadonlySet<string>): (family: string) => string {
  const hex = /^[0-9A-Fa-f]{8,}$/;
  return (family: string): string => {
    const parts = family.split("_");
    for (let i = 1; i < parts.length; i += 1) {
      const p = parts[i]!;
      if (hex.test(p) || (/^\d+$/.test(p) && chainIds.has(p))) return parts.slice(0, i).join("_");
    }
    return family;
  };
}

const familyOf = (uid: string): string => uid.slice(0, uid.indexOf(":"));

interface MetaMarket {
  name?: string;
  asset?: { symbol?: string } | null;
  price?: { priceUsd?: number | null } | null;
  withdrawLiquidity?: number | null;
  flags?: { isActive?: boolean; isFrozen?: boolean } | null;
}
interface MetaResponse {
  items: Record<string, Record<string, Record<string, MetaMarket>>>;
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

/** Streams every NDJSON line once. ~1.5 M rows / ~380 MB today, so nothing is
 *  buffered beyond the per-market tallies. */
async function scanDisk(dir: string): Promise<Map<string, MarketCoverage>> {
  const markets = new Map<string, MarketCoverage>();
  const files = await collectFiles(dir);
  let done = 0;
  for (const file of files) {
    const lenderKey = path.relative(dir, file).split(path.sep)[0]!;
    const rl = createInterface({
      input: createReadStream(file, "utf8"),
      crlfDelay: Number.POSITIVE_INFINITY,
    });
    for await (const line of rl) {
      if (!line.trim()) continue;
      let r: HistoryPoint;
      try {
        r = JSON.parse(line) as HistoryPoint;
      } catch {
        continue;
      }
      if (!r.marketUid || !r.dataTs) continue;
      const d = dayNum(r.dataTs);
      if (!Number.isFinite(d)) continue;

      let m = markets.get(r.marketUid);
      if (!m) {
        m = {
          uid: r.marketUid,
          lenderKey,
          chainId: String(r.chainId ?? ""),
          points: 0,
          firstDay: d,
          lastDay: d,
          days: new Set(),
          fields: 0,
          sources: new Set(),
        };
        markets.set(r.marketUid, m);
      }
      m.points += 1;
      if (d < m.firstDay) m.firstDay = d;
      if (d > m.lastDay) m.lastDay = d;
      m.days.add(d);
      if (r.source) m.sources.add(r.source);
      if (r.depositRate != null) m.fields |= F_DEPOSIT_RATE;
      if (r.variableBorrowRate != null) m.fields |= F_BORROW_RATE;
      if (r.totalDeposits != null || r.totalDebt != null) m.fields |= F_TOTALS;
      if (r.totalDepositsUsd != null || r.totalDebtUsd != null) m.fields |= F_USD;
      if (r.supplyIndex != null || r.borrowIndex != null) m.fields |= F_INDEX;
      if (r.utilization != null) m.fields |= F_UTILIZATION;
    }
    done += 1;
    if (done % 200 === 0) process.stderr.write(`  scanned ${done}/${files.length} files\n`);
  }
  return markets;
}

function sizeProxy(price: unknown, liq: unknown): number | undefined {
  if (typeof price !== "number" || typeof liq !== "number") return undefined;
  const v = price * liq;
  if (!Number.isFinite(v) || v < 0 || v > SIZE_CEILING_USD) return undefined;
  return v;
}

interface Book {
  markets: Map<string, BookMarket>;
  /** Built from this book's chain ids — see {@link makeFamilyRoot}. */
  familyRoot: (family: string) => string;
}

async function loadBook(bookPath?: string): Promise<Book> {
  const raw = bookPath
    ? await readFile(bookPath, "utf8")
    : await (async () => {
        const res = await fetch(META_URL);
        if (!res.ok) throw new Error(`book HTTP ${res.status} from ${META_URL}`);
        return res.text();
      })();
  const body = JSON.parse(raw) as MetaResponse;
  const familyRoot = makeFamilyRoot(new Set(Object.keys(body.items ?? {})));
  const out = new Map<string, BookMarket>();
  for (const [chainId, lenders] of Object.entries(body.items ?? {})) {
    for (const [family, mkts] of Object.entries(lenders ?? {})) {
      for (const [uid, m] of Object.entries(mkts ?? {})) {
        const price = m.price?.priceUsd;
        const liq = m.withdrawLiquidity;
        out.set(uid, {
          uid,
          chainId,
          family,
          root: familyRoot(family),
          name: m.name ?? "",
          symbol: m.asset?.symbol ?? "",
          sizeUsd: sizeProxy(price, liq),
          active: m.flags?.isActive !== false && m.flags?.isFrozen !== true,
        });
      }
    }
  }
  return { markets: out, familyRoot };
}

interface LenderSummary {
  lenderKey: string;
  kind: "lender" | "vault";
  decaying: boolean;
  chains: string[];
  markets: number;
  points: number;
  firstDay: string;
  lastDay: string;
  ageDays: number;
  /** Median over markets of (distinct days / span days) — series density. */
  density: number;
  series: string[];
  sources: string[];
  perChain: Array<{
    chainId: string;
    markets: number;
    points: number;
    firstDay: string;
    lastDay: string;
    ageDays: number;
  }>;
}

const median = (xs: number[]): number => {
  if (xs.length === 0) return 0;
  const a = [...xs].sort((x, y) => x - y);
  return a[Math.floor(a.length / 2)]!;
};

function summarizeLenders(
  markets: Map<string, MarketCoverage>,
  today: number,
): LenderSummary[] {
  const byLender = new Map<string, MarketCoverage[]>();
  for (const m of markets.values()) {
    const bucket = byLender.get(m.lenderKey);
    if (bucket) bucket.push(m);
    else byLender.set(m.lenderKey, [m]);
  }

  const summarize = (ms: MarketCoverage[]) => {
    let points = 0;
    let first = Number.POSITIVE_INFINITY;
    let last = Number.NEGATIVE_INFINITY;
    for (const m of ms) {
      points += m.points;
      if (m.firstDay < first) first = m.firstDay;
      if (m.lastDay > last) last = m.lastDay;
    }
    return { points, first, last };
  };

  const out: LenderSummary[] = [];
  for (const [lenderKey, ms] of byLender) {
    const { points, first, last } = summarize(ms);
    let fields = 0;
    const sources = new Set<string>();
    const densities: number[] = [];
    const byChain = new Map<string, MarketCoverage[]>();
    for (const m of ms) {
      fields |= m.fields;
      for (const s of m.sources) sources.add(s);
      const span = m.lastDay - m.firstDay + 1;
      densities.push(span > 0 ? m.days.size / span : 1);
      const bucket = byChain.get(m.chainId);
      if (bucket) bucket.push(m);
      else byChain.set(m.chainId, [m]);
    }
    out.push({
      lenderKey,
      kind: lenderKey.startsWith("VAULT_") ? "vault" : "lender",
      decaying: DECAYING.includes(lenderKey),
      chains: [...byChain.keys()].sort((a, b) => Number(a) - Number(b)),
      markets: ms.length,
      points,
      firstDay: dayIso(first),
      lastDay: dayIso(last),
      ageDays: today - last,
      density: median(densities),
      series: SERIES_LABEL.filter(([bit]) => (fields & bit) !== 0).map(([, l]) => l),
      sources: [...sources].sort(),
      perChain: [...byChain]
        .map(([chainId, cms]) => {
          const c = summarize(cms);
          return {
            chainId,
            markets: cms.length,
            points: c.points,
            firstDay: dayIso(c.first),
            lastDay: dayIso(c.last),
            ageDays: today - c.last,
          };
        })
        .sort((a, b) => b.markets - a.markets),
    });
  }
  return out.sort((a, b) => a.lenderKey.localeCompare(b.lenderKey));
}

interface FamilyCoverage {
  root: string;
  /** Runner keys whose rows landed in this family, empty when nothing is held. */
  repoKeys: string[];
  bookMarkets: number;
  held: number;
  missing: number;
  missingActive: number;
  missingSizeUsd: number;
  /** Missing markets whose size proxy was unusable (no price, or over the
   *  ceiling) — so a small `missingSizeUsd` is not read as "nothing there". */
  missingSizeUnknown: number;
  chains: string[];
  missingChains: string[];
}

function usd(n: number | undefined): string {
  if (n === undefined || !Number.isFinite(n)) return "—";
  if (n >= 1e9) return `$${(n / 1e9).toFixed(2)}B`;
  if (n >= 1e6) return `$${(n / 1e6).toFixed(1)}M`;
  if (n >= 1e3) return `$${(n / 1e3).toFixed(0)}k`;
  return `$${n.toFixed(0)}`;
}

const pct = (x: number): string => `${(x * 100).toFixed(0)}%`;

async function main(): Promise<void> {
  const argv = process.argv.slice(2);
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
  let dir = path.join(repoRoot, "data", "history");
  let outDir = path.join(repoRoot, "data", "coverage");
  let bookPath: string | undefined;
  let offline = false;
  let staleDays = 3;
  let top = 40;
  for (let i = 0; i < argv.length; i += 1) {
    const a = argv[i];
    if (a === "--dir") dir = path.resolve(repoRoot, argv[++i] ?? dir);
    else if (a === "--out") outDir = path.resolve(repoRoot, argv[++i] ?? outDir);
    else if (a === "--book") bookPath = path.resolve(repoRoot, argv[++i] ?? "");
    else if (a === "--offline") offline = true;
    else if (a === "--stale-days") staleDays = Number(argv[++i]);
    else if (a === "--top") top = Number(argv[++i]);
    else if (a === "--help" || a === "-h") {
      console.log(
        [
          "usage: pnpm coverage:history [options]",
          "  --dir DIR          history NDJSON root (default data/history)",
          "  --out DIR          report output (default data/coverage, gitignored)",
          "  --book FILE        read the market book from a file instead of the API",
          "  --offline          skip the book entirely; report held data only",
          "  --stale-days N     freshness threshold, default 3",
          "  --top N            rows per ranked table in the markdown, default 40",
        ].join("\n"),
      );
      return;
    }
  }
  if (!(await stat(dir).catch(() => null))) {
    console.error(`no such directory: ${dir}`);
    process.exitCode = 1;
    return;
  }

  const today = Math.floor(Date.now() / MS_DAY);
  console.log(`[coverage] scanning ${dir}`);
  const markets = await scanDisk(dir);
  const lenders = summarizeLenders(markets, today);
  const totalPoints = lenders.reduce((n, l) => n + l.points, 0);
  console.log(`[coverage] ${markets.size} markets, ${totalPoints} points, ${lenders.length} keys`);

  // ── the book: everything the live cron knows about, which is the only
  //    roster that says what "missing" means on the lender side ──────────────
  let book: Map<string, BookMarket> | undefined;
  let familyRoot: ((family: string) => string) | undefined;
  if (!offline) {
    console.log(`[coverage] loading market book${bookPath ? ` from ${bookPath}` : ""}`);
    ({ markets: book, familyRoot } = await loadBook(bookPath));
    console.log(`[coverage] book: ${book.size} markets`);
  }

  const families = new Map<string, FamilyCoverage>();
  const missingRows: Array<BookMarket & { repoKeys: string[]; reason: string }> = [];
  const orphans: MarketCoverage[] = [];
  /** Every uid family the book carries — used to tell "the book does not track
   *  this market" from "the book tracks this family under a different leaf". */
  const bookFamilies = new Set<string>();
  /** Held lender-side markets that DO exist in the book, per runner key. */
  const inBookByKey = new Map<string, number>();

  if (book) {
    const heldByRoot = new Map<string, Set<string>>();
    for (const m of markets.values()) {
      const b = book.get(m.uid);
      if (!b) continue;
      let s = heldByRoot.get(b.root);
      if (!s) heldByRoot.set(b.root, (s = new Set()));
      s.add(m.lenderKey);
    }

    for (const b of book.values()) {
      bookFamilies.add(b.family);
      let f = families.get(b.root);
      if (!f) {
        families.set(
          b.root,
          (f = {
            root: b.root,
            repoKeys: [...(heldByRoot.get(b.root) ?? [])].sort(),
            bookMarkets: 0,
            held: 0,
            missing: 0,
            missingActive: 0,
            missingSizeUsd: 0,
            missingSizeUnknown: 0,
            chains: [],
            missingChains: [],
          }),
        );
      }
      f.bookMarkets += 1;
      if (!f.chains.includes(b.chainId)) f.chains.push(b.chainId);
      if (markets.has(b.uid)) {
        f.held += 1;
      } else {
        f.missing += 1;
        if (b.active) f.missingActive += 1;
        if (b.sizeUsd === undefined) f.missingSizeUnknown += 1;
        else f.missingSizeUsd += b.sizeUsd;
        if (!f.missingChains.includes(b.chainId)) f.missingChains.push(b.chainId);
        missingRows.push({
          ...b,
          repoKeys: f.repoKeys,
          // The one distinction that decides what to do about a missing market.
          reason: f.repoKeys.length > 0 ? "gap-in-covered-family" : "no-module",
        });
      }
    }

    // Rows whose uid is not in the book join nothing: `lending_snapshots` has an
    // FK to `markets`, so the SQL export skips them silently. Vault uids are
    // orphans BY DESIGN (no vault ingest yet) and are excluded here — mixing
    // them in would bury the real lender-side misses.
    for (const m of markets.values()) {
      if (m.lenderKey.startsWith("VAULT_")) continue;
      if (book.has(m.uid)) inBookByKey.set(m.lenderKey, (inBookByKey.get(m.lenderKey) ?? 0) + 1);
      else orphans.push(m);
    }
  }

  // ── registry vs disk: a key with a module and no data, and a lender that is
  //    fetched for ownership but has no history module at all ─────────────────
  const heldKeys = new Set(lenders.map((l) => l.lenderKey));
  const registeredEmpty = Object.keys(FETCHERS)
    .filter((k) => !heldKeys.has(k))
    .sort();
  const ownershipKeys = (await readdir(path.join(repoRoot, "data")))
    .filter((f) => f.endsWith(".json"))
    .map((f) => f.slice(0, -5))
    .sort();
  const ownershipNoModule = ownershipKeys.filter((k) => !(k in FETCHERS));

  /** `FLUID` → `VAULT_FLUID`, `SILO_V2` → `VAULT_SILO`: the same protocol is
   *  often already collected on the earn surface while its lending markets are
   *  not, and a report that calls that family "no history at all" reads as more
   *  missing than it is. */
  const vaultKeyFor = (root: string): string | undefined => {
    const k = `VAULT_${root.replace(/_V\d+$/, "")}`;
    return heldKeys.has(k) ? k : undefined;
  };

  missingRows.sort((a, b) => (b.sizeUsd ?? 0) - (a.sizeUsd ?? 0));
  const familyList = [...families.values()];
  const uncovered = familyList
    .filter((f) => f.held === 0)
    .sort((a, b) => b.missingSizeUsd - a.missingSizeUsd || b.bookMarkets - a.bookMarkets);
  const partial = familyList
    .filter((f) => f.held > 0 && f.missing > 0)
    .sort((a, b) => b.missingSizeUsd - a.missingSizeUsd || b.missing - a.missing);
  const complete = familyList.filter((f) => f.held > 0 && f.missing === 0);

  // ── report ────────────────────────────────────────────────────────────────
  const md: string[] = [];
  const w = (s = "") => md.push(s);
  const stamp = new Date().toISOString();
  w(`# History coverage — generated ${stamp}`);
  w();
  w(
    "Generated by `pnpm coverage:history` from the NDJSON on disk and the live " +
      "market book. Derived output — do not edit, do not commit (`data/coverage/` is gitignored). " +
      "The hand-maintained narrative lives in [HISTORY_GAPS.md](../../HISTORY_GAPS.md).",
  );
  w();
  w(
    `**Held:** ${markets.size.toLocaleString()} markets · ${totalPoints.toLocaleString()} points · ` +
      `${lenders.length} runner keys` +
      (book ? ` · **book:** ${book.size.toLocaleString()} lending markets` : " · book: skipped (`--offline`)"),
  );
  w();

  const stale = lenders.filter((l) => l.decaying && l.ageDays > staleDays);
  if (stale.length > 0) {
    w(`## ⚠ Rolling-window sources going stale (>${staleDays}d)`);
    w();
    w("These serve a rolling window — every day not captured is gone for good (plan §0.1).");
    w();
    w("| key | newest point | age |");
    w("| --- | --- | --- |");
    for (const l of stale) w(`| ${l.lenderKey} | ${l.lastDay} | **${l.ageDays}d** |`);
    w();
  }

  w("## 1. What is held");
  w();
  w("`density` = median over markets of distinct days ÷ span, so 100% is an unbroken daily series.");
  w();
  w(
    "`in book` = held markets that still exist in the live book, i.e. the ones an ingest can actually " +
      "join (§4 has the rest). Vault uids are not in the book at all, so it does not apply to them.",
  );
  w();
  w("| key | kind | chains | markets | in book | points | window | age | density | series |");
  w("| --- | --- | ---: | ---: | ---: | ---: | --- | ---: | ---: | --- |");
  for (const l of lenders) {
    const joinable =
      !book || l.kind === "vault" ? "n/a" : `${(inBookByKey.get(l.lenderKey) ?? 0).toLocaleString()}`;
    w(
      `| ${l.lenderKey}${l.decaying ? " ⏳" : ""} | ${l.kind} | ${l.chains.length} | ` +
        `${l.markets.toLocaleString()} | ${joinable} | ${l.points.toLocaleString()} | ${l.firstDay} → ${l.lastDay} | ` +
        `${l.ageDays}d | ${pct(l.density)} | ${l.series.join(", ")} |`,
    );
  }
  w();
  w("⏳ = rolling window, captured daily by `pnpm capture:daily`.");
  w();

  w("### Per chain");
  w();
  w("| key | chain | markets | points | window | age |");
  w("| --- | ---: | ---: | ---: | --- | ---: |");
  for (const l of lenders) {
    for (const c of l.perChain) {
      w(
        `| ${l.lenderKey} | ${c.chainId} | ${c.markets.toLocaleString()} | ${c.points.toLocaleString()} | ` +
          `${c.firstDay} → ${c.lastDay} | ${c.ageDays}d |`,
      );
    }
  }
  w();

  w("## 2. What has to be produced");
  w();
  if (!book) {
    w("Book not loaded (`--offline`) — the missing side of the report needs it.");
    w();
  } else {
    w(
      `**${missingRows.length.toLocaleString()}** book markets have no history row. ` +
        `${missingRows.filter((r) => r.reason === "gap-in-covered-family").length.toLocaleString()} ` +
        "sit in a family we already fetch (a backfill run, or a uid that failed to resolve); the rest " +
        "belong to families with no `hist/` module (code to write). Full list in `missing-markets.csv`.",
    );
    w();

    w("### 2a. Registered fetchers with nothing on disk");
    w();
    w(
      registeredEmpty.length === 0
        ? "None — every key in the history registry has data."
        : registeredEmpty.map((k) => `- **${k}** — module exists, never run (or output lost)`).join("\n"),
    );
    w();

    w("### 2b. Gaps inside families we already fetch");
    w();
    w("| family | runner key | held | book | missing | missing (active) | missing size | unpriced | chains missing |");
    w("| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |");
    for (const f of partial.slice(0, top)) {
      w(
        `| ${f.root} | ${f.repoKeys.join(", ")} | ${f.held.toLocaleString()} | ${f.bookMarkets.toLocaleString()} | ` +
          `${f.missing.toLocaleString()} | ${f.missingActive.toLocaleString()} | ${usd(f.missingSizeUsd)} | ` +
          `${f.missingSizeUnknown.toLocaleString()} | ` +
          `${f.missingChains.slice(0, 8).join(" ")}${f.missingChains.length > 8 ? " …" : ""} |`,
      );
    }
    if (partial.length > top) w(`| … ${partial.length - top} more | | | | | | | | |`);
    w();

    w("### 2c. Families with no history at all");
    w();
    w(
      `${uncovered.length.toLocaleString()} of ${familyList.length.toLocaleString()} families in the book have ` +
        "zero rows here. Ranked by withdrawable liquidity × price — a size PROXY, not TVL: the book carries no " +
        `supplied total, liquidity understates a heavily borrowed market, and anything over ${usd(SIZE_CEILING_USD)} ` +
        "is treated as a broken input and counted under `unpriced` instead.",
    );
    w();
    w(
      "`earn side` names a `VAULT_*` key we already collect for the same protocol: its vaults are held, its " +
        "lending markets are not. Two different surfaces, so this is a partial answer, not a covered row.",
    );
    w();
    w("| family | book markets | active | size | unpriced | earn side | chains |");
    w("| --- | ---: | ---: | ---: | ---: | --- | --- |");
    for (const f of uncovered.slice(0, top)) {
      w(
        `| ${f.root} | ${f.bookMarkets.toLocaleString()} | ${f.missingActive.toLocaleString()} | ` +
          `${usd(f.missingSizeUsd)} | ${f.missingSizeUnknown.toLocaleString()} | ${vaultKeyFor(f.root) ?? "—"} | ` +
          `${f.chains.slice(0, 8).join(" ")}${f.chains.length > 8 ? " …" : ""} |`,
      );
    }
    if (uncovered.length > top) w(`| … ${uncovered.length - top} more | | | | | | |`);
    w();
  }

  w("### 2d. Lenders fetched for ownership with no history module");
  w();
  w(
    ownershipNoModule.length === 0
      ? "None."
      : ownershipNoModule.map((k) => `- **${k}** — \`data/${k}.json\` exists, no \`hist/\` module`).join("\n"),
  );
  w();

  w("## 3. The earn surface");
  w();
  w("### 3a. Vault providers held");
  w();
  w(
    "Vault uids do not exist in the lending book, so there is no roster to diff a single vault against — a " +
      "missing vault only shows up when the provider's own API is asked. Held-only:",
  );
  w();
  w("| provider | chains | vaults | points | window | age | series |");
  w("| --- | ---: | ---: | ---: | --- | ---: | --- |");
  for (const l of lenders.filter((x) => x.kind === "vault")) {
    w(
      `| ${l.lenderKey}${l.decaying ? " ⏳" : ""} | ${l.chains.length} | ${l.markets.toLocaleString()} | ` +
        `${l.points.toLocaleString()} | ${l.firstDay} → ${l.lastDay} | ${l.ageDays}d | ${l.series.join(", ")} |`,
    );
  }
  w();

  // The providers half of the earn side: what the LIVE fetcher pulls spot data
  // for, versus what has a `hist/` module here. Declared, not derived — see
  // `vault-providers.ts` for why — so it is cross-checked both ways below.
  const roster = [...VAULT_PROVIDER_ROSTER];
  const uncollected = roster.filter((r) => r.availability !== "module");
  const byStatus = {
    "api-history": uncollected.filter((r) => r.availability === "api-history"),
    rolling: uncollected.filter((r) => r.availability === "rolling"),
    "no-api": uncollected.filter((r) => r.availability === "no-api"),
  };

  w("### 3b. Earn-side sources with no history module");
  w();
  w(
    `${roster.filter((r) => r.availability === "module").length} of ${roster.length} declared earn-side sources are ` +
      `collected here. The other ${uncollected.length} are fetched live for spot data and have no \`hist/\` module.`,
  );
  w();
  w(
    `**${byStatus["api-history"].length} have a working upstream history API** — a backfill someone has to write, ` +
      `**${byStatus.rolling.length} serve a rolling window** (losing days every day nobody records them), and ` +
      `**${byStatus["no-api"].length} have no history surface at all** (DefiLlama \`/chart\`, archival 4626 reads, ` +
      "or our own daily self-archive).",
  );
  w();
  w("| source | upstream | what exists | verified in |");
  w("| --- | --- | --- | --- |");
  const statusLabel: Record<string, string> = {
    "api-history": "**API has history**",
    rolling: "**rolling window** ⏳",
    "no-api": "no history API",
  };
  for (const r of [...byStatus["api-history"], ...byStatus.rolling, ...byStatus["no-api"]]) {
    w(`| ${r.source} | ${statusLabel[r.availability]} | ${r.note} | ${r.doc} |`);
  }
  w();

  // Both directions of drift, because the roster is hand-written and the two
  // sides rot differently: a module can land without its row being flipped, and
  // a key can be registered that the roster never heard of.
  const rosterKeys = new Set(roster.flatMap((r) => (r.runnerKey ? [r.runnerKey] : [])));
  const claimedNoData = roster.filter(
    (r) => r.runnerKey && !heldKeys.has(r.runnerKey) && r.availability === "module",
  );
  const unlisted = Object.keys(FETCHERS).filter((k) => k.startsWith("VAULT_") && !rosterKeys.has(k));
  if (claimedNoData.length > 0 || unlisted.length > 0) {
    w("**Roster drift** — `vault-providers.ts` disagrees with the registry:");
    w();
    for (const r of claimedNoData) w(`- ${r.source} claims module \`${r.runnerKey}\`, which has no data on disk`);
    for (const k of unlisted) w(`- \`${k}\` is registered in \`FETCHERS\` but is not in the roster`);
    w();
  }

  if (book) {
    w("## 4. Rows that will not join `markets`");
    w();
    if (orphans.length === 0) {
      w("None — every lender-side uid on disk exists in the book.");
    } else {
      const orphanPoints = orphans.reduce((n, o) => n + o.points, 0);
      // Two very different causes, and guessing between them sent us looking
      // for a uid bug that did not exist. If the book has NO market for the
      // uid's family, the book simply does not carry that market and upstream
      // is broader than our book — nothing here is wrong. If the family IS in
      // the book but this exact uid is not, the leaf differs, and that IS a
      // keying mismatch worth chasing.
      const familyAbsent = orphans.filter((o) => !bookFamilies.has(familyOf(o.uid)));
      const familyPresent = orphans.filter((o) => bookFamilies.has(familyOf(o.uid)));
      w(
        `**${orphans.length.toLocaleString()}** lender-side uids on disk (${orphanPoints.toLocaleString()} points) ` +
          "are not in the book. `lending_snapshots` has an FK to `markets`, so the SQL export skips these silently — " +
          "they are counted, never fatal. Full list in `orphan-markets.csv`.",
      );
      w();
      w(
        `- **${familyAbsent.length.toLocaleString()}** belong to a uid family the book has no market for at all: ` +
          "the source serves markets our book never indexed. Not a defect here — the fix is market discovery on the " +
          "yield-tracer side, or accepting the skip.",
      );
      w(
        `- **${familyPresent.length.toLocaleString()}** belong to a family the book DOES carry, under a different ` +
          "leaf or chain. That is a keying mismatch (or a deployment the book missed) and is worth chasing.",
      );
      if (familyPresent.length > 0) {
        w();
        for (const o of familyPresent.slice(0, top)) w(`  - \`${o.uid}\` (${o.lenderKey}, ${o.points} points)`);
        if (familyPresent.length > top) w(`  - … ${familyPresent.length - top} more`);
      }
      w();
      const byKey = new Map<string, { uids: number; points: number; families: Set<string> }>();
      for (const o of orphans) {
        let e = byKey.get(o.lenderKey);
        if (!e) byKey.set(o.lenderKey, (e = { uids: 0, points: 0, families: new Set() }));
        e.uids += 1;
        e.points += o.points;
        e.families.add(familyRoot ? familyRoot(familyOf(o.uid)) : familyOf(o.uid));
      }
      w("| key | orphan uids | held total | points | families |");
      w("| --- | ---: | ---: | ---: | --- |");
      for (const [k, e] of [...byKey].sort((a, b) => b[1].uids - a[1].uids)) {
        const held = lenders.find((l) => l.lenderKey === k)?.markets ?? 0;
        w(
          `| ${k} | ${e.uids.toLocaleString()} | ${held.toLocaleString()} | ${e.points.toLocaleString()} | ` +
            `${[...e.families].sort().slice(0, 4).join(", ")}${e.families.size > 4 ? " …" : ""} |`,
        );
      }
    }
    w();
    w(
      "`VAULT_*` uids are orphans by design — they carry no `markets` row until a vault ingest exists " +
        "(HISTORY_GAPS.md §3.4) — and are excluded from this count.",
    );
    w();
  }

  await mkdir(outDir, { recursive: true });
  await writeFile(path.join(outDir, "COVERAGE.md"), `${md.join("\n")}\n`, "utf8");

  await writeFile(
    path.join(outDir, "coverage.json"),
    `${JSON.stringify(
      {
        generatedAt: stamp,
        historyDir: dir,
        totals: { markets: markets.size, points: totalPoints, keys: lenders.length },
        lenders,
        registeredEmpty,
        ownershipNoModule,
        earnRoster: roster,
        book: book
          ? {
              url: bookPath ?? META_URL,
              markets: book.size,
              families: familyList.length,
              complete: complete.map((f) => f.root).sort(),
              partial,
              uncovered,
              orphans: orphans.map((o) => ({
                uid: o.uid,
                lenderKey: o.lenderKey,
                cause: bookFamilies.has(familyOf(o.uid)) ? "family-in-book" : "family-absent-from-book",
                points: o.points,
                firstDay: dayIso(o.firstDay),
                lastDay: dayIso(o.lastDay),
              })),
            }
          : null,
        markets: [...markets.values()]
          .map((m) => ({
            uid: m.uid,
            lenderKey: m.lenderKey,
            chainId: m.chainId,
            points: m.points,
            firstDay: dayIso(m.firstDay),
            lastDay: dayIso(m.lastDay),
            days: m.days.size,
            spanDays: m.lastDay - m.firstDay + 1,
            series: SERIES_LABEL.filter(([bit]) => (m.fields & bit) !== 0).map(([, l]) => l),
            sources: [...m.sources],
          }))
          .sort((a, b) => a.uid.localeCompare(b.uid)),
      },
      null,
      1,
    )}\n`,
    "utf8",
  );

  if (book) {
    const csv = [
      "market_uid,family,chain_id,name,symbol,active,size_usd,reason,runner_key",
      ...missingRows.map((r) =>
        [
          r.uid,
          r.root,
          r.chainId,
          `"${r.name.replace(/"/g, '""')}"`,
          r.symbol,
          r.active ? "1" : "0",
          r.sizeUsd === undefined ? "" : r.sizeUsd.toFixed(2),
          r.reason,
          r.repoKeys.join("|"),
        ].join(","),
      ),
    ].join("\n");
    await writeFile(path.join(outDir, "missing-markets.csv"), `${csv}\n`, "utf8");

    const orphanCsv = [
      "market_uid,runner_key,chain_id,points,first_day,last_day",
      ...orphans
        .sort((a, b) => b.points - a.points)
        .map((o) =>
          [o.uid, o.lenderKey, o.chainId, o.points, dayIso(o.firstDay), dayIso(o.lastDay)].join(","),
        ),
    ].join("\n");
    await writeFile(path.join(outDir, "orphan-markets.csv"), `${orphanCsv}\n`, "utf8");
  }

  const rel = path.relative(repoRoot, outDir);
  console.log(`[coverage] wrote ${rel}/COVERAGE.md, ${rel}/coverage.json${
      book ? `, ${rel}/missing-markets.csv, ${rel}/orphan-markets.csv` : ""
    }`);
  if (stale.length > 0) {
    console.log(
      `[coverage] ⚠ rolling-window sources stale >${staleDays}d: ${stale
        .map((l) => `${l.lenderKey}(${l.ageDays}d)`)
        .join(", ")}`,
    );
  }
}

main();
