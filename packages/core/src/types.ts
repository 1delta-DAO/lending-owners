export type LenderKey = string;
export type ChainId = number;
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

export interface OwnershipSnapshot {
  lenderKey: LenderKey;
  fetchedAt: string;
  markets: Record<MarketUid, MarketOwnership>;
}

export const makeMarketUid = (
  lenderKey: LenderKey,
  chainId: ChainId,
  underlying: Address,
): MarketUid => `${lenderKey}:${chainId}:${underlying.toLowerCase()}` as MarketUid;
