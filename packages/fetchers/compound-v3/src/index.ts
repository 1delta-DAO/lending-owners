import {
  type FetcherContext,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";

const LENDER_KEY = "COMPOUND_V3";
const SUPPORTED_CHAINS = [1, 137, 8453, 42161] as const;

const COMET_API = "https://api.compound.finance/v3";

async function fetchJson<T>(url: string): Promise<T> {
  void url;
  throw new Error("not implemented: REST transport");
}

export const compoundV3Fetcher: OwnershipFetcher = {
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
      // TODO: list comets for chain, then fetch principal balances per holder
      void chainId;
      void COMET_API;
      void fetchJson;
      void makeMarketUid;
    }

    return snapshot;
  },
};

export default compoundV3Fetcher;
