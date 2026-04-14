import type { ChainId, LenderKey, OwnershipSnapshot } from "./types.js";

export interface FetcherContext {
  chainIds?: ChainId[];
  signal?: AbortSignal;
}

export interface OwnershipFetcher {
  readonly lenderKey: LenderKey;
  readonly supportedChainIds: ReadonlyArray<ChainId>;
  fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot>;
}
