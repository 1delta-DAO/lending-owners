import type { OwnershipFetcher } from "@lending-owners/core";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { createAaveV3Fetcher } from "@lending-owners/fetcher-aave-v3";
import { createCompoundV3Fetcher } from "@lending-owners/fetcher-compound-v3";
import { createAaveV4Fetcher } from "@lending-owners/fetcher-aave-v4";
import { createMorphoBlueFetcher } from "@lending-owners/fetcher-morpho-blue";
import { createEulerFetcher } from "@lending-owners/fetcher-euler";
import { createSiloFetcher } from "@lending-owners/fetcher-silo";

function requireEnv(name: string): string {
  const v = process.env[name];
  if (!v) throw new Error(`missing required env var: ${name}`);
  return v;
}

async function main() {
  // Initialize all protocol metadata once so individual fetchers skip redundant fetches.
  await fetchLenderMetaFromDirAndInitialize({
    compoundV3Pools: true,
    aaveV4Spokes: true,
    morphoPools: true,
    eulerVaults: true,
    siloV2Markets: true,
    siloV3Markets: true,
  });

  const fetchers: OwnershipFetcher[] = [
    createAaveV3Fetcher({ subgraphApiKey: requireEnv("AAVE_V3_SUBGRAPH_API_KEY") }),
    createCompoundV3Fetcher({
      subgraphApiKey: requireEnv("COMPOUND_V3_SUBGRAPH_API_KEY"),
      skipMetadataInit: true,
    }),
    createAaveV4Fetcher({ skipMetadataInit: true }),
    createMorphoBlueFetcher({
      subgraphApiKey: requireEnv("MORPHO_BLUE_SUBGRAPH_API_KEY"),
      skipMetadataInit: true,
    }),
    createEulerFetcher({ skipMetadataInit: true }),
    createSiloFetcher({ subgraphApiKey: requireEnv("SILO_SUBGRAPH_API_KEY"), skipMetadataInit: true }),
  ];

  for (const f of fetchers) {
    try {
      const snap = await f.fetch();
      console.log(JSON.stringify(snap, null, 2));
    } catch (err) {
      console.error(`[${f.lenderKey}] failed:`, (err as Error).message);
    }
  }
}

main();
