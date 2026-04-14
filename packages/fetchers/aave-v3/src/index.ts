import {
  type FetcherContext,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";

const LENDER_KEY = "AAVE_V3";
const SUPPORTED_CHAINS = [1, 10, 137, 8453, 42161] as const;

const SUBGRAPH_URLS: Record<number, string> = {
  1: "https://api.thegraph.com/subgraphs/name/aave/protocol-v3",
};

async function queryGraphQL<T>(url: string, query: string, variables: Record<string, unknown>): Promise<T> {
  void url;
  void query;
  void variables;
  throw new Error("not implemented: GraphQL transport");
}

export const aaveV3Fetcher: OwnershipFetcher = {
  lenderKey: LENDER_KEY,
  supportedChainIds: SUPPORTED_CHAINS,

  async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
    const chains = ctx?.chainIds ?? [...SUPPORTED_CHAINS];
    const snapshot: OwnershipSnapshot = {
      lenderKey: LENDER_KEY,
      fetchedAt: new Date().toISOString(),
      markets: {},
    };

    for (const chainId of chains) {
      const url = SUBGRAPH_URLS[chainId];
      if (!url) continue;
      // TODO: paginate aTokens + balances via subgraph
      void queryGraphQL;
      void makeMarketUid;
    }

    return snapshot;
  },
};

export default aaveV3Fetcher;
