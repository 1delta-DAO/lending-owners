import type { OwnershipFetcher } from "@lending-owners/core";
import { createAaveV3Fetcher } from "@lending-owners/fetcher-aave-v3";
import { createCompoundV3Fetcher } from "@lending-owners/fetcher-compound-v3";

function requireEnv(name: string): string {
  const v = process.env[name];
  if (!v) throw new Error(`missing required env var: ${name}`);
  return v;
}

const fetchers: OwnershipFetcher[] = [
  createAaveV3Fetcher({ subgraphApiKey: requireEnv("AAVE_V3_SUBGRAPH_API_KEY") }),
  createCompoundV3Fetcher({ subgraphApiKey: requireEnv("COMPOUND_V3_SUBGRAPH_API_KEY") }),
];

async function main() {
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
