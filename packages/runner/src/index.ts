import type { OwnershipFetcher } from "@lending-owners/core";
import { aaveV3Fetcher } from "@lending-owners/fetcher-aave-v3";
import { compoundV3Fetcher } from "@lending-owners/fetcher-compound-v3";

const fetchers: OwnershipFetcher[] = [aaveV3Fetcher, compoundV3Fetcher];

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
