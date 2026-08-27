import {
  type ChainId,
  type HistoryFetcher,
  type HistoryPoint,
  type HistoryResolution,
  bucketStart,
} from "@lending-owners/core";
import { NdjsonSink } from "./ndjson.js";
import { loadAaveV3Reserves } from "./reserves.js";
import { type MarketRegistry, loadMarketRegistry } from "./registry.js";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { createAaveV3HistoryFetcher } from "@lending-owners/fetcher-aave-v3";
import { createCompoundV3HistoryFetcher } from "@lending-owners/fetcher-compound-v3";
import { createEulerHistoryFetcher } from "@lending-owners/fetcher-euler";
import { createLlamaLendHistoryFetcher } from "@lending-owners/fetcher-llamalend";
import { createMoonwellHistoryFetcher } from "@lending-owners/fetcher-moonwell";
import { createMorphoBlueHistoryFetcher } from "@lending-owners/fetcher-morpho-blue";
import {
  createCapVaultHistoryFetcher,
  createFluidVaultHistoryFetcher,
  createGearboxVaultHistoryFetcher,
  createGmxVaultHistoryFetcher,
  createHyperbeatVaultHistoryFetcher,
  createHypercoreVaultHistoryFetcher,
  createLagoonVaultHistoryFetcher,
  createMorphoVaultHistoryFetcher,
  createPendleVaultHistoryFetcher,
  createSiloVaultHistoryFetcher,
  createUpshiftVaultHistoryFetcher,
  createYearnVaultHistoryFetcher,
  createYieldBasisVaultHistoryFetcher,
} from "@lending-owners/fetcher-vaults";
import { createVenusHistoryFetcher } from "@lending-owners/fetcher-venus";
import path from "node:path";
import { fileURLToPath } from "node:url";

/**
 * Historical backfill runner — the second axis of this repo.
 *
 * Writes NDJSON, one line per `(market_uid, data_ts)`, to
 * `<out>/<LENDER>/<chainId>/<yyyy-mm>.ndjson`. It deliberately does NOT write
 * to Postgres: the ingest half lives in `yield-tracer` behind
 * `POST /ingest/lending-history`, and a backfill must never write to prod
 * directly. See LENDING_HISTORY_BACKFILL_PLAN.md §0.8.
 *
 *   pnpm fetch:history -- --lender COMPOUND_V3 --days 30
 *   pnpm fetch:history -- --lender MORPHO_BLUE --from 2025-08-01 --chain 1
 *   pnpm capture:daily
 */

type FetcherFactory = () => HistoryFetcher;

/** Loaded once per process and shared by every fetcher — it is a 25 MB
 *  document, and each fetcher needs the same index. */
let registry: MarketRegistry | undefined;

/** Registry. Add a lender here once its `hist/` module exists. */
const FETCHERS: Record<string, FetcherFactory> = {
  AAVE_V3: () => createAaveV3HistoryFetcher({ reserves: loadAaveV3Reserves() }),
  COMPOUND_V3: () => createCompoundV3HistoryFetcher({ skipMetadataInit: true }),
  EULER: () => createEulerHistoryFetcher(),
  LLAMALEND: () => createLlamaLendHistoryFetcher(),
  MOONWELL: () => createMoonwellHistoryFetcher(),
  MORPHO_BLUE: () => createMorphoBlueHistoryFetcher(),
  VENUS: () => createVenusHistoryFetcher(),
  // Vault providers (the earn surface). Source matrix + traps:
  // margin-fetcher `src/vaults/HISTORY_APIS.md`. Uids are
  // `VAULT_<PROVIDER>:<chainId>:<vaultAddress>` and deliberately do NOT join
  // the lending `markets` table — the SQL export skips them until a vault
  // ingest exists.
  VAULT_CAP: () => createCapVaultHistoryFetcher(),
  VAULT_FLUID: () => createFluidVaultHistoryFetcher(),
  VAULT_GEARBOX: () => createGearboxVaultHistoryFetcher(),
  VAULT_GMX: () => createGmxVaultHistoryFetcher(),
  VAULT_HYPERBEAT: () => createHyperbeatVaultHistoryFetcher(),
  VAULT_HYPERCORE: () => createHypercoreVaultHistoryFetcher(),
  VAULT_LAGOON: () => createLagoonVaultHistoryFetcher(),
  VAULT_MORPHO: () => createMorphoVaultHistoryFetcher(),
  VAULT_PENDLE: () => createPendleVaultHistoryFetcher(),
  VAULT_SILO: () => createSiloVaultHistoryFetcher(),
  VAULT_UPSHIFT: () => createUpshiftVaultHistoryFetcher(),
  VAULT_YEARN: () => createYearnVaultHistoryFetcher(),
  VAULT_YIELDBASIS: () => createYieldBasisVaultHistoryFetcher(),
};

/**
 * Sources whose window is a rolling one — data older than the window is gone
 * from the API for good. These are what `--decaying` selects, and they are the
 * only part of the plan that gets worse by waiting (plan §0.1).
 */
const DECAYING: string[] = ["COMPOUND_V3", "LLAMALEND", "VAULT_CAP", "VAULT_GEARBOX"];

/** Rows buffered before a write. Big enough that appends are not chatty, small
 *  enough that a crash loses little and memory stays flat on a 700-point-per-
 *  market source like Morpho. */
const FLUSH_EVERY = 2000;

interface Args {
  lenders: string[];
  from?: Date;
  to: Date;
  resolution: HistoryResolution;
  outDir: string;
  chainIds?: ChainId[];
  days?: number;
  dryRun: boolean;
}

function parseArgs(argv: string[], repoRoot: string): Args {
  const lenders: string[] = [];
  let from: Date | undefined;
  let to = new Date();
  let resolution: HistoryResolution = "1d";
  let outDir = path.join(repoRoot, "data", "history");
  let chainIds: ChainId[] | undefined;
  let days: number | undefined;
  let dryRun = false;

  const value = (i: number, flag: string): string => {
    const v = argv[i + 1];
    if (!v) throw new Error(`missing value for ${flag}`);
    return v;
  };
  const date = (raw: string, flag: string): Date => {
    const d = new Date(raw);
    if (Number.isNaN(d.getTime())) throw new Error(`${flag}: "${raw}" is not a date`);
    return d;
  };

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    switch (arg) {
      case "--lender":
      case "--lenders":
        for (const l of value(i, arg).split(",")) {
          const key = l.trim().toUpperCase().replace(/-/g, "_");
          if (key) lenders.push(key);
        }
        i += 1;
        break;
      case "--decaying":
        lenders.push(...DECAYING);
        break;
      case "--all":
        lenders.push(...Object.keys(FETCHERS));
        break;
      case "--from":
        from = date(value(i, arg), arg);
        i += 1;
        break;
      case "--to":
        to = date(value(i, arg), arg);
        i += 1;
        break;
      case "--days":
        days = Number(value(i, arg));
        if (!Number.isFinite(days) || days <= 0) throw new Error("--days must be a positive number");
        i += 1;
        break;
      case "--resolution": {
        const r = value(i, arg);
        if (r !== "1d" && r !== "1h") throw new Error(`--resolution must be 1d or 1h, got "${r}"`);
        resolution = r;
        i += 1;
        break;
      }
      case "--out":
        outDir = path.resolve(value(i, arg));
        i += 1;
        break;
      case "--chain":
      case "--chains":
        chainIds = value(i, arg)
          .split(",")
          .map((c) => c.trim())
          .filter(Boolean) as ChainId[];
        i += 1;
        break;
      case "--dry-run":
        dryRun = true;
        break;
      case "--":
        // pnpm inserts its own `--` ahead of forwarded args, so a bare
        // separator can appear once or twice depending on invocation.
        break;
      default:
        if (arg?.startsWith("--")) throw new Error(`unknown flag ${arg}`);
    }
  }

  if (days !== undefined) from = new Date(to.getTime() - days * 86_400_000);
  if (!from) from = new Date(to.getTime() - 30 * 86_400_000);

  const unknown = lenders.filter((l) => !(l in FETCHERS));
  if (unknown.length > 0) {
    throw new Error(
      `no history fetcher for ${unknown.join(", ")}. Available: ${Object.keys(FETCHERS).join(", ")}`,
    );
  }

  return {
    lenders: [...new Set(lenders)],
    from,
    to,
    resolution,
    outDir,
    chainIds,
    days,
    dryRun,
  };
}

function fmt(d: Date): string {
  return d.toISOString().slice(0, 19).replace("T", " ");
}

async function runLender(key: string, args: Args): Promise<void> {
  const fetcher = FETCHERS[key]!();
  const sink = new NdjsonSink(args.outDir, key);
  const startedAt = Date.now();

  // A source that cannot serve the requested window should say so before it
  // spends an hour quietly returning less than was asked for.
  const earliest = fetcher.earliest?.(args.to);
  if (earliest && args.from && args.from < earliest) {
    console.warn(
      `[${key}] requested from ${fmt(args.from)} but this source only serves back to ~${fmt(earliest)} — the rest is not recoverable here.`,
    );
  }

  const from = bucketStart(args.from!, args.resolution);
  console.log(
    `[${key}] ${fmt(from)} → ${fmt(args.to)} @${args.resolution}${args.chainIds ? ` chains=${args.chainIds.join(",")}` : ""}${args.dryRun ? " (dry run)" : ""}`,
  );

  let buffer: HistoryPoint[] = [];
  let seen = 0;
  let lastLog = 0;

  const flush = async () => {
    if (buffer.length === 0) return;
    if (!args.dryRun) await sink.write(buffer);
    buffer = [];
  };

  for await (const point of fetcher.fetch({
    from,
    to: args.to,
    resolution: args.resolution,
    chainIds: args.chainIds,
    // Family-scoped, not global: leaves are shared across lenders (Aave's leaf
    // is the underlying token, which dozens of Morpho markets also use), so a
    // global lookup resolves almost nothing for those families.
    resolveUid: registry?.forFamily(key),
    onProgress: (done, total, label) => {
      const now = Date.now();
      if (now - lastLog < 5000 && done !== total) return;
      lastLog = now;
      console.log(`[${key}] ${label}: ${done}/${total}`);
    },
  })) {
    buffer.push(point);
    seen += 1;
    if (buffer.length >= FLUSH_EVERY) await flush();
  }
  await flush();

  const { written, skipped, files } = sink.stats;
  const elapsedMs = Date.now() - startedAt;
  if (!args.dryRun && written > 0) {
    await sink.writeManifest({
      lender: key,
      source: fetcher.source,
      from: from.toISOString(),
      to: args.to.toISOString(),
      resolution: args.resolution,
      runAt: new Date().toISOString(),
      elapsedMs,
    });
  }
  console.log(
    `[${key}] points=${seen} written=${written} duplicate=${skipped} files=${files} elapsedMs=${elapsedMs}`,
  );
}

async function main(): Promise<void> {
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
  const args = parseArgs(process.argv.slice(2), repoRoot);

  if (args.lenders.length === 0) {
    console.error(
      [
        "usage: --lender <KEY>[,<KEY>] | --decaying | --all",
        "       [--from ISO | --days N] [--to ISO] [--resolution 1d|1h]",
        "       [--chain <id>[,<id>]] [--out DIR] [--dry-run]",
        "",
        `available: ${Object.keys(FETCHERS).join(", ")}`,
        `decaying (capture daily or lose it): ${DECAYING.join(", ")}`,
      ].join("\n"),
    );
    process.exitCode = 1;
    return;
  }

  // Same bootstrap the ownership runner uses: the registries are what turn a
  // protocol's own market identifiers into our market_uids. `compoundV3BaseData`
  // is required on top of `compoundV3Pools` — the pools registry maps comet
  // addresses but not their base assets, and without the base asset there is no
  // uid to key a Compound row by.
  // One shared market registry. Fetchers hand over a protocol-native address
  // and get back the uid our book already uses, so rows join `markets` by
  // construction instead of by re-deriving `computeMarketUid` per family.
  registry = await loadMarketRegistry();
  console.log(`[registry] ${registry.size} market uids loaded`);

  await fetchLenderMetaFromDirAndInitialize({
    compoundV3Pools: true,
    compoundV3BaseData: true,
    morphoPools: true,
  });

  let failed = 0;
  for (const key of args.lenders) {
    try {
      await runLender(key, args);
    } catch (err) {
      failed += 1;
      console.error(`[${key}] failed:`, (err as Error).message);
    }
  }
  if (failed > 0) process.exitCode = 1;
}

main();
