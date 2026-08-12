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
  /** Total deposited amount in human-readable units (divided by token decimals). */
  totalSupply?: number;
  owners: OwnerBalances;
  /** Total borrowed amount, in `underlying` units. */
  totalBorrow?: number;
  /** Borrow-side breakdown, in `underlying` units. */
  borrowers?: OwnerBalances;
  /**
   * Collateral token for isolated markets (Morpho Blue), where collateral is a
   * separate asset from `underlying` and is never lent out.
   */
  collateralToken?: Address;
  /** Total collateral posted, in `collateralToken` units. */
  totalCollateral?: number;
  /** Collateral-side breakdown, in `collateralToken` units. */
  collateralOwners?: OwnerBalances;
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
  /**
   * Chains whose data source failed during this run. A snapshot with a non-empty
   * list is partial: it is missing every market on those chains, so overwriting a
   * previous snapshot with it silently deletes markets. The runner refuses to
   * write partial snapshots unless `--allow-partial` is passed.
   */
  failedChains?: ChainId[];
}

export const makeMarketUid = (
  lenderKey: LenderKey,
  chainId: ChainId,
  underlying: Address,
): MarketUid => `${lenderKey}:${chainId}:${underlying.toLowerCase()}` as MarketUid;
