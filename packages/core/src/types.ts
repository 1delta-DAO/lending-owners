import type { Chain } from "@1delta/chain-registry";

export type LenderKey = string;
export type ChainId = Chain;
export type Address = string;

export type MarketUid = `${LenderKey}:${ChainId}:${Address}`;

export type OwnerBalances = Record<Address, number>;

export interface MarketOwnership {
  marketUid: MarketUid;
  lenderKey: LenderKey;
  chainId: ChainId;
  underlying: Address;
  owners: OwnerBalances;
}

export interface ChainFreshness {
  subgraphBlock: number;
  rpcBlock: number;
  blocksBehind: number;
  minutesBehind: number;
}

export interface OwnershipSnapshot {
  lenderKey: LenderKey;
  fetchedAt: string;
  markets: Record<MarketUid, MarketOwnership>;
  chainFreshness?: Partial<Record<ChainId, ChainFreshness>>;
}

export const makeMarketUid = (
  lenderKey: LenderKey,
  chainId: ChainId,
  underlying: Address,
): MarketUid => `${lenderKey}:${chainId}:${underlying.toLowerCase()}` as MarketUid;
