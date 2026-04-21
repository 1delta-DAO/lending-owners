import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  OWNER_FRACTION_BY_LENDER,
  makeMarketUid,
} from "@lending-owners/core";
import { aaveV4Spokes } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { Chain } from "@1delta/chain-registry";

const LENDER_KEY = "AAVE_V4";
const API_URL = "https://api.v4.aave.com/graphql";

// Aave V4 is currently only on Ethereum mainnet.
// Additional chains will be picked up automatically from aaveV4Spokes() after SDK init.
const BASE_SUPPORTED_CHAINS: ChainId[] = [Chain.ETHEREUM_MAINNET];

export interface AaveV4Config {
  /** Override the API URL (e.g. for testing). */
  apiUrl?: string;
  /** Skip fetching SDK metadata (caller already initialized it). */
  skipMetadataInit?: boolean;
  /** Minimum owner fraction of market total to include. Defaults to OWNER_FRACTION_BY_LENDER["AAVE_V4"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ────────────────────────────────────────────────────────────

interface RawReserve {
  id: string; // opaque ReserveId used by the API
  chain: { chainId: number };
  asset: { underlying: { address: string } };
}

interface ReservesResponse {
  reserves: RawReserve[];
}

interface RawHolder {
  address: string;
  amount: { amount: { onChainValue: string } };
}

interface ReserveHoldersResponse {
  reserveHolders: {
    items: RawHolder[];
    pageInfo: { next: string | null };
  };
}

// ── GraphQL queries ──────────────────────────────────────────────────────────

const RESERVES_QUERY = /* GraphQL */ `
  query Reserves($chainId: ChainId!) {
    reserves(request: { query: { chainIds: [$chainId] } }) {
      id
      chain { chainId }
      asset { underlying { address } }
    }
  }
`;

// PageSize is an enum in the Aave V4 API: TEN | FIFTY. FIFTY gives 50 items per page.
const RESERVE_HOLDERS_QUERY = /* GraphQL */ `
  query ReserveHolders($reserveId: ReserveId!, $cursor: Cursor) {
    reserveHolders(request: {
      reserve: { reserveId: $reserveId }
      pageSize: FIFTY
      cursor: $cursor
    }) {
      items {
        address
        amount { amount { onChainValue } }
      }
      pageInfo { next }
    }
  }
`;

// ── HTTP helper ──────────────────────────────────────────────────────────────

async function queryGraphQL<T>(
  url: string,
  query: string,
  variables: Record<string, unknown>,
  signal?: AbortSignal,
): Promise<T> {
  const res = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ query, variables }),
    signal,
  });
  if (!res.ok) {
    throw new Error(`[${LENDER_KEY}] API HTTP ${res.status}`);
  }
  const json = (await res.json()) as { data?: T; errors?: Array<{ message: string }> };
  if (json.errors?.length) {
    throw new Error(`[${LENDER_KEY}] API errors: ${json.errors.map((e) => e.message).join("; ")}`);
  }
  if (!json.data) {
    throw new Error(`[${LENDER_KEY}] API returned no data`);
  }
  return json.data;
}

// ── Data fetching ────────────────────────────────────────────────────────────

async function fetchReservesForChain(
  url: string,
  chainId: ChainId,
  signal?: AbortSignal,
): Promise<RawReserve[]> {
  const data = await queryGraphQL<ReservesResponse>(
    url,
    RESERVES_QUERY,
    { chainId: String(chainId) },
    signal,
  );
  return data.reserves;
}

async function fetchAllHolders(
  url: string,
  reserveId: string,
  signal?: AbortSignal,
): Promise<RawHolder[]> {
  const all: RawHolder[] = [];
  let cursor: string | null = null;
  for (;;) {
    const variables: Record<string, unknown> = { reserveId };
    if (cursor !== null) variables.cursor = cursor;
    const data = await queryGraphQL<ReserveHoldersResponse>(
      url,
      RESERVE_HOLDERS_QUERY,
      variables,
      signal,
    );
    const { items, pageInfo } = data.reserveHolders;
    all.push(...items);
    if (!pageInfo.next) break;
    cursor = pageInfo.next;
  }
  return all;
}

// ── Market grouping ──────────────────────────────────────────────────────────

function buildMarketOwnership(
  underlying: Address,
  holders: RawHolder[],
  chainId: ChainId,
  minOwnerFraction: number,
): MarketOwnership | null {
  const uid = makeMarketUid(LENDER_KEY, chainId, underlying);
  const allOwners: Record<Address, number> = {};
  for (const h of holders) {
    const account = h.address.toLowerCase() as Address;
    const balance = Number(h.amount.amount.onChainValue);
    if (!Number.isFinite(balance) || balance <= 0) continue;
    allOwners[account] = (allOwners[account] ?? 0) + balance;
  }
  const totalSupply = Object.values(allOwners).reduce((s, b) => s + b, 0);
  const threshold = totalSupply * minOwnerFraction;
  const filtered = Object.entries(allOwners)
    .filter(([, bal]) => bal >= threshold)
    .sort(([, a], [, b]) => b - a);
  if (filtered.length === 0) return null;
  return {
    marketUid: uid,
    lenderKey: LENDER_KEY,
    chainId,
    underlying,
    totalSupply,
    owners: Object.fromEntries(filtered) as Record<Address, number>,
  };
}

// ── Factory ──────────────────────────────────────────────────────────────────

export function createAaveV4Fetcher(config: AaveV4Config = {}): OwnershipFetcher {
  const url = config.apiUrl ?? API_URL;
  const minOwnerFraction = config.minOwnerFraction ?? OWNER_FRACTION_BY_LENDER[LENDER_KEY] ?? 0.01;

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: BASE_SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ aaveV4Spokes: true });
      }

      // Derive supported chains from the SDK (falls back to BASE_SUPPORTED_CHAINS
      // if the registry is empty, e.g. in tests without network access).
      const spokesData = aaveV4Spokes() ?? {};
      const sdkChains = Object.keys(spokesData) as ChainId[];
      const supportedChains = sdkChains.length > 0 ? sdkChains : BASE_SUPPORTED_CHAINS;
      const chains = ctx?.chainIds ?? supportedChains;

      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
      };

      for (const chainId of chains) {
        const reserves = await fetchReservesForChain(url, chainId, ctx?.signal);
        if (reserves.length === 0) continue;

        for (const reserve of reserves) {
          const underlying = reserve.asset.underlying.address.toLowerCase() as Address;
          const holders = await fetchAllHolders(url, reserve.id, ctx?.signal);
          if (holders.length === 0) continue;

          const market = buildMarketOwnership(underlying, holders, chainId, minOwnerFraction);
          if (market) snapshot.markets[market.marketUid] = market;
        }
      }

      return snapshot;
    },
  };
}
