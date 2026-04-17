import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  OWNER_FRACTION_BY_LENDER,
  checkSubgraphFreshness,
  makeMarketUid,
} from "@lending-owners/core";
import { compoundV3Pools } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { isCompoundV3 } from "@1delta/lender-registry";
import { Chain } from "@1delta/chain-registry";

export * from "./hist/index.js";

const LENDER_KEY = "COMPOUND_V3";

// Paperclip Compound V3 community subgraphs (decentralized network).
// https://github.com/papercliplabs/compound-v3-subgraph
const SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "5nwMCSHaTqG3Kd2gHznbTXEnZ9QNWsssQfbHhDqQSQFp",
  [Chain.ARBITRUM_ONE]: "Ff7ha9ELmpmg81D6nYxy4t8aGP26dPztqD1LDJNPqjLS",
  [Chain.POLYGON_MAINNET]: "AaFtUWKfFdj2x8nnE3RxTSJkHwGHvawH3VWFBykCGzLs",
  [Chain.BASE]: "2hcXhs36pTBDVUmk5K2Zkr6N4UYGwaHuco2a6jyTsijo",
};

const SUPPORTED_CHAINS: ChainId[] = Object.keys(SUBGRAPH_IDS) as ChainId[];

const subgraphUrl = (apiKey: string, id: string): string =>
  `https://gateway.thegraph.com/api/${apiKey}/subgraphs/id/${id}`;

export interface CompoundV3Config {
  subgraphApiKey: string;
  pageSize?: number;
  skipMetadataInit?: boolean;
  /** Minimum owner fraction of market total to include. Defaults to OWNER_FRACTION_BY_LENDER["COMPOUND_V3"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ─────────────────────────────────────────────────────────────

// Paperclip schema: Market.configuration.baseToken.token.id = underlying address
// Market.accounting.totalBaseSupply = total supply in base units (BigInt)
interface RawMarket {
  id: string;
  configuration: { baseToken: { token: { id: string; decimals: number } } };
  accounting: { totalBaseSupply: string };
}

interface MarketResponse {
  market: RawMarket | null;
}

// Position IDs are Bytes in the Paperclip schema.
// Supply side: basePrincipal > 0. Borrow side: basePrincipal < 0.
interface RawPosition {
  id: string;
  account: { id: string };
  accounting: { basePrincipal: string };
}

interface PositionsResponse {
  positions: RawPosition[];
}

// ── HTTP helper ───────────────────────────────────────────────────────────────

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
    throw new Error(`[${LENDER_KEY}] subgraph HTTP ${res.status}`);
  }
  const json = (await res.json()) as { data?: T; errors?: Array<{ message: string }> };
  if (!json.data) {
    const msg = json.errors?.map((e) => e.message).join("; ") ?? "no data";
    throw new Error(`[${LENDER_KEY}] subgraph errors: ${msg}`);
  }
  if (json.errors?.length) {
    console.warn(
      `[${LENDER_KEY}] subgraph partial errors: ${json.errors.slice(0, 3).map((e) => e.message).join("; ")}${json.errors.length > 3 ? ` (+${json.errors.length - 3} more)` : ""}`,
    );
  }
  return json.data;
}

// ── GraphQL queries ───────────────────────────────────────────────────────────

// Fetch a single comet market. ID is the comet proxy address (Bytes).
const MARKET_QUERY = /* GraphQL */ `
  query Market($id: Bytes!) {
    market(id: $id) {
      id
      configuration {
        baseToken {
          token { id decimals }
        }
      }
      accounting {
        totalBaseSupply
      }
    }
  }
`;

// Supply positions: basePrincipal_gt filters to accounts with positive principal (suppliers).
// ID is Bytes — use "0x" as the initial cursor (empty bytes < all addresses).
const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($marketId: Bytes!, $minPrincipal: BigInt!, $first: Int!, $lastId: Bytes!) {
    positions(
      first: $first
      where: { market: $marketId, accounting_: { basePrincipal_gt: $minPrincipal }, id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      account { id }
      accounting { basePrincipal }
    }
  }
`;

// ── Data fetching ─────────────────────────────────────────────────────────────

async function fetchCometMarket(url: string, comet: string, signal?: AbortSignal): Promise<RawMarket | null> {
  const data = await queryGraphQL<MarketResponse>(url, MARKET_QUERY, { id: comet.toLowerCase() }, signal);
  return data.market;
}

async function fetchMarketPositions(
  url: string,
  marketId: string,
  minPrincipal: string,
  pageSize: number,
  signal?: AbortSignal,
): Promise<RawPosition[]> {
  const all: RawPosition[] = [];
  let lastId = "0x";
  for (;;) {
    const data = await queryGraphQL<PositionsResponse>(
      url,
      POSITIONS_QUERY,
      { marketId, minPrincipal, first: pageSize, lastId },
      signal,
    );
    const batch = data.positions.filter(Boolean);
    if (batch.length === 0) break;
    all.push(...batch);
    if (batch.length < pageSize) break;
    lastId = batch[batch.length - 1].id;
  }
  return all;
}

// ── Market grouping ───────────────────────────────────────────────────────────

function buildMarketOwnership(positions: RawPosition[], underlying: Address, chainId: ChainId, decimals: number): MarketOwnership | null {
  const scalar = 10 ** decimals;
  const owners: Record<Address, number> = {};
  for (const p of positions) {
    const account = p.account.id.toLowerCase() as Address;
    const balance = Number(p.accounting.basePrincipal) / scalar;
    if (!Number.isFinite(balance) || balance <= 0) continue;
    owners[account] = (owners[account] ?? 0) + balance;
  }
  if (Object.keys(owners).length === 0) return null;
  const uid = makeMarketUid(LENDER_KEY, chainId, underlying);
  const sorted = Object.fromEntries(Object.entries(owners).sort((a, b) => b[1] - a[1]));
  return { marketUid: uid, lenderKey: LENDER_KEY, chainId, underlying, owners: sorted };
}

// ── Factory ───────────────────────────────────────────────────────────────────

export function createCompoundV3Fetcher(config: CompoundV3Config): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);
  const minOwnerFraction = config.minOwnerFraction ?? OWNER_FRACTION_BY_LENDER[LENDER_KEY] ?? 0.01;

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ compoundV3Pools: true });
      }
      const pools = compoundV3Pools();
      const chains = ctx?.chainIds ?? SUPPORTED_CHAINS;
      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
        chainFreshness: {},
      };

      for (const chainId of chains) {
        const subgraphId = SUBGRAPH_IDS[chainId];
        if (!subgraphId) continue;
        const chainPools: Record<string, string> = pools[chainId] ?? {};
        const comets = Object.entries(chainPools)
          .filter(([lender]) => isCompoundV3(lender))
          .map(([, comet]) => comet);
        if (comets.length === 0) continue;

        const url = subgraphUrl(config.subgraphApiKey, subgraphId);
        try {
          const freshness = await checkSubgraphFreshness(LENDER_KEY, url, chainId, ctx?.signal);
          if (freshness) snapshot.chainFreshness![chainId] = freshness;

          for (const comet of comets) {
            try {
              const market = await fetchCometMarket(url, comet, ctx?.signal);
              if (!market) {
                console.warn(`[${LENDER_KEY}] chain ${chainId} comet ${comet}: market not found in subgraph`);
                continue;
              }
              const underlying = market.configuration.baseToken.token.id.toLowerCase() as Address;
              const totalSupply = market.accounting.totalBaseSupply;
              const minPrincipal = (
                (BigInt(totalSupply) * BigInt(Math.round(minOwnerFraction * 1e6))) /
                1000000n
              ).toString();
              const positions = await fetchMarketPositions(url, comet.toLowerCase(), minPrincipal, pageSize, ctx?.signal);
              const ownership = buildMarketOwnership(positions, underlying, chainId, market.configuration.baseToken.token.decimals);
              if (ownership) snapshot.markets[ownership.marketUid] = ownership;
            } catch (err) {
              console.warn(`[${LENDER_KEY}] chain ${chainId} comet ${comet} skipped: ${(err as Error).message}`);
            }
          }
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} skipped: ${(err as Error).message}`);
        }
      }

      return snapshot;
    },
  };
}
