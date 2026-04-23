import type { OwnershipFetcher } from "@lending-owners/core";
import type { OwnershipSnapshot } from "@lending-owners/core";
import { isPlaceholderEnvValue } from "@lending-owners/core";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { createAaveV3Fetcher } from "@lending-owners/fetcher-aave-v3";
import { createCompoundV3Fetcher } from "@lending-owners/fetcher-compound-v3";
import { createAaveV4Fetcher } from "@lending-owners/fetcher-aave-v4";
import { createMorphoBlueFetcher } from "@lending-owners/fetcher-morpho-blue";
import { createEulerFetcher } from "@lending-owners/fetcher-euler";
import { createSiloFetcher } from "@lending-owners/fetcher-silo";
import { createSparkFetcher } from "@lending-owners/fetcher-spark";
import { createVenusFetcher } from "@lending-owners/fetcher-venus";
import { createDForceFetcher } from "@lending-owners/fetcher-dforce";
import { createMoonwellFetcher } from "@lending-owners/fetcher-moonwell";
import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

type LenderKey =
  | "AAVE_V3"
  | "COMPOUND_V3"
  | "AAVE_V4"
  | "MORPHO_BLUE"
  | "EULER"
  | "SILO"
  | "SPARK"
  | "VENUS"
  | "DFORCE"
  | "MOONWELL";

function requireEnv(name: string): string {
  const v = process.env[name];
  if (!v?.trim()) throw new Error(`missing required env var: ${name}`);
  if (isPlaceholderEnvValue(v)) throw new Error(`env var ${name} is set to placeholder (xxx), not a valid API key`);
  return v.trim();
}

/** Lenders that read a subgraph API key from the environment (via {@link requireEnv}). */
const LENDER_SUBGRAPH_ENV: Partial<Record<LenderKey, string>> = {
  AAVE_V3: "AAVE_V3_SUBGRAPH_API_KEY",
  COMPOUND_V3: "COMPOUND_V3_SUBGRAPH_API_KEY",
  MORPHO_BLUE: "MORPHO_BLUE_SUBGRAPH_API_KEY",
  SILO: "SILO_SUBGRAPH_API_KEY",
  SPARK: "SPARK_SUBGRAPH_API_KEY",
  VENUS: "VENUS_SUBGRAPH_API_KEY",
  DFORCE: "DFORCE_SUBGRAPH_API_KEY",
  MOONWELL: "MOONWELL_SUBGRAPH_API_KEY",
};

function shouldSkipLenderForPlaceholderApiKey(key: LenderKey): boolean {
  const envName = LENDER_SUBGRAPH_ENV[key];
  if (!envName) return false;
  const raw = process.env[envName];
  if (raw != null && isPlaceholderEnvValue(raw)) {
    console.warn(`[${key}] skipped: ${envName} is placeholder (xxx), not a real API key`);
    return true;
  }
  return false;
}

function normalizeLenderKey(value: string): LenderKey {
  const normalized = value.trim().toUpperCase().replace(/-/g, "_");
  const allowed: Record<LenderKey, true> = {
    AAVE_V3: true,
    COMPOUND_V3: true,
    AAVE_V4: true,
    MORPHO_BLUE: true,
    EULER: true,
    SILO: true,
    SPARK: true,
    VENUS: true,
    DFORCE: true,
    MOONWELL: true,
  };
  if (!(normalized in allowed)) {
    throw new Error(
      `unknown lender "${value}". Allowed: ${Object.keys(allowed).join(", ")}`
    );
  }
  return normalized as LenderKey;
}

function parseSelectedLenders(args: string[]): Set<LenderKey> | null {
  const selected = new Set<LenderKey>();
  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];
    if (arg === "--lender") {
      const value = args[i + 1];
      if (!value) throw new Error("missing value for --lender");
      selected.add(normalizeLenderKey(value));
      i += 1;
      continue;
    }
    if (arg === "--lenders") {
      const value = args[i + 1];
      if (!value) throw new Error("missing value for --lenders");
      for (const lender of value.split(",")) {
        if (!lender.trim()) continue;
        selected.add(normalizeLenderKey(lender));
      }
      i += 1;
      continue;
    }
  }
  return selected.size > 0 ? selected : null;
}

function sortOwners(owners: Record<string, number>): Record<string, number> {
  const sorted = Object.entries(owners).sort((a, b) => {
    if (b[1] !== a[1]) return b[1] - a[1];
    return a[0].localeCompare(b[0]);
  });
  return Object.fromEntries(sorted);
}

function normalizeSnapshot(snapshot: OwnershipSnapshot): OwnershipSnapshot {
  const sortedMarkets = Object.entries(snapshot.markets).sort((a, b) => a[0].localeCompare(b[0]));
  const normalizedMarkets = Object.fromEntries(
    sortedMarkets.map(([marketUid, market]) => [
      marketUid,
      {
        ...market,
        owners: sortOwners(market.owners),
      },
    ]),
  );

  return {
    ...snapshot,
    markets: normalizedMarkets,
  };
}

function countOwnerEntries(snapshot: OwnershipSnapshot): number {
  return Object.values(snapshot.markets).reduce((total, market) => total + Object.keys(market.owners).length, 0);
}

async function main() {
  const selectedLenders = parseSelectedLenders(process.argv.slice(2));
  const repoRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..");
  const dataDir = path.join(repoRoot, "data");
  await mkdir(dataDir, { recursive: true });

  // Initialize all protocol metadata once so individual fetchers skip redundant fetches.
  await fetchLenderMetaFromDirAndInitialize({
    compoundV3Pools: true,
    aaveV4Spokes: true,
    morphoPools: true,
    eulerVaults: true,
  });

  const fetcherFactories: Record<LenderKey, () => OwnershipFetcher> = {
    AAVE_V3: () => createAaveV3Fetcher({ subgraphApiKey: requireEnv("AAVE_V3_SUBGRAPH_API_KEY") }),
    COMPOUND_V3: () =>
      createCompoundV3Fetcher({
        subgraphApiKey: requireEnv("COMPOUND_V3_SUBGRAPH_API_KEY"),
        skipMetadataInit: true,
      }),
    AAVE_V4: () => createAaveV4Fetcher({ skipMetadataInit: true }),
    MORPHO_BLUE: () =>
      createMorphoBlueFetcher({
        subgraphApiKey: requireEnv("MORPHO_BLUE_SUBGRAPH_API_KEY"),
        skipMetadataInit: true,
      }),
    EULER: () => createEulerFetcher({ skipMetadataInit: true }),
    SILO: () =>
      createSiloFetcher({
        subgraphApiKey: requireEnv("SILO_SUBGRAPH_API_KEY"),
      }),
    SPARK: () => createSparkFetcher({ subgraphApiKey: requireEnv("SPARK_SUBGRAPH_API_KEY") }),
    VENUS: () => createVenusFetcher({ subgraphApiKey: requireEnv("VENUS_SUBGRAPH_API_KEY") }),
    DFORCE: () => createDForceFetcher({ subgraphApiKey: requireEnv("DFORCE_SUBGRAPH_API_KEY") }),
    MOONWELL: () => createMoonwellFetcher({ subgraphApiKey: requireEnv("MOONWELL_SUBGRAPH_API_KEY") }),
  };

  const lenderOrder: LenderKey[] = [
    "AAVE_V3",
    "COMPOUND_V3",
    "AAVE_V4",
    "MORPHO_BLUE",
    "EULER",
    "SILO",
    "SPARK",
    "VENUS",
    "DFORCE",
    "MOONWELL",
  ];

  const targetLenders = selectedLenders
    ? lenderOrder.filter((key) => selectedLenders.has(key))
    : lenderOrder;

  const lendersToRun = targetLenders.filter((key) => !shouldSkipLenderForPlaceholderApiKey(key));

  if (lendersToRun.length === 0) {
    const hint =
      selectedLenders && selectedLenders.size > 0
        ? "Selected lender(s) were skipped due to placeholder API keys (xxx)."
        : "No lenders left to run after skipping placeholder API keys (xxx).";
    console.error(hint);
    process.exitCode = 1;
    return;
  }

  const fetchers: OwnershipFetcher[] = lendersToRun.map((key) => fetcherFactories[key]());

  for (const f of fetchers) {
    const startedAt = Date.now();
    console.log(`fetching ${f.lenderKey}...`);
    try {
      const snap = normalizeSnapshot(await f.fetch());
      const outputPath = path.join(dataDir, `${f.lenderKey}.json`);
      await writeFile(outputPath, `${JSON.stringify(snap, null, 2)}\n`, "utf8");
      const elapsedMs = Date.now() - startedAt;
      console.log(
        `[${f.lenderKey}] saved ${outputPath} markets=${Object.keys(snap.markets).length} owners=${countOwnerEntries(snap)} elapsedMs=${elapsedMs}`,
      );
    } catch (err) {
      console.error(`[${f.lenderKey}] failed:`, (err as Error).message);
    }
  }
}

main();
