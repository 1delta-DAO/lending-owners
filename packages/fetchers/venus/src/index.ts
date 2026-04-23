import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  OWNER_FRACTION_BY_LENDER,
  checkSubgraphFreshness,
  isPlaceholderEnvValue,
  makeMarketUid,
} from "@lending-owners/core";
import { Chain } from "@1delta/chain-registry";

const LENDER_KEY = "VENUS";

// Messari Venus subgraph deployments (decentralized network).
// Source: https://github.com/messari/subgraphs/blob/master/deployment/decentralized_network_deployments.csv
const SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.BNB_SMART_CHAIN_MAINNET]: "CwswJ7sfENafqgAYU1upn3hQgoEV2CXXRZRJ7XtgJrKG",
};

const SUPPORTED_CHAINS = Object.keys(SUBGRAPH_IDS) as ChainId[];

const subgraphUrl = (apiKey: string, id: string): string =>
  `https://gateway.thegraph.com/api/${apiKey}/subgraphs/id/${id}`;

export type PositionSide = "LENDER" | "BORROWER";

export interface VenusConfig {
  subgraphApiKey: string;
  side?: PositionSide;
  pageSize?: number;
  /** Minimum owner fraction of market total to include. Defaults to OWNER_FRACTION_BY_LENDER["VENUS"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ─────────────────────────────────────────────────────────────

interface RawMarket {
  id: string;
  inputToken: { id: string; decimals: number };
  inputTokenBalance: string;
}

interface MarketsResponse {
  markets: RawMarket[];
}

interface RawPosition {
  id: string;
  account: { id: string };
  balance: string;
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

const MARKETS_QUERY = /* GraphQL */ `
  query Markets($first: Int!, $lastId: String!) {
    markets(first: $first, where: { id_gt: $lastId, inputTokenBalance_gt: "0" }, orderBy: id, orderDirection: asc) {
      id
      inputToken { id decimals }
      inputTokenBalance
    }
  }
`;

const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($marketId: String!, $side: PositionSide!, $minBalance: BigInt!, $first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { market: $marketId, side: $side, balance_gt: $minBalance, id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      account { id }
      balance
    }
  }
`;

// ── Data fetching ─────────────────────────────────────────────────────────────

async function fetchMarkets(url: string, pageSize: number, signal?: AbortSignal): Promise<RawMarket[]> {
  const all: RawMarket[] = [];
  let lastId = "";
  for (;;) {
    const data = await queryGraphQL<MarketsResponse>(url, MARKETS_QUERY, { first: pageSize, lastId }, signal);
    const batch = data.markets;
    if (batch.length === 0) break;
    all.push(...batch);
    if (batch.length < pageSize) break;
    lastId = batch[batch.length - 1].id;
  }
  return all;
}

async function fetchMarketPositions(
  url: string,
  marketId: string,
  side: PositionSide,
  minBalance: string,
  pageSize: number,
  signal?: AbortSignal,
): Promise<RawPosition[]> {
  const all: RawPosition[] = [];
  let lastId = "";
  for (;;) {
    const data = await queryGraphQL<PositionsResponse>(
      url,
      POSITIONS_QUERY,
      { marketId, side, minBalance, first: pageSize, lastId },
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

function buildMarketOwnership(
  positions: RawPosition[],
  underlying: Address,
  chainId: ChainId,
  decimals: number,
  totalSupply: number,
): MarketOwnership | null {
  const scalar = 10 ** decimals;
  const owners: Record<Address, number> = {};
  for (const p of positions) {
    const account = p.account.id.toLowerCase() as Address;
    const balance = Number(p.balance) / scalar;
    if (!Number.isFinite(balance) || balance <= 0) continue;
    owners[account] = (owners[account] ?? 0) + balance;
  }
  if (Object.keys(owners).length === 0) return null;
  const uid = makeMarketUid(LENDER_KEY, chainId, underlying);
  const sorted = Object.fromEntries(Object.entries(owners).sort((a, b) => b[1] - a[1]));
  return { marketUid: uid, lenderKey: LENDER_KEY, chainId, underlying, totalSupply, owners: sorted };
}

// ── Factory ───────────────────────────────────────────────────────────────────

export function createVenusFetcher(config: VenusConfig): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  if (isPlaceholderEnvValue(config.subgraphApiKey)) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey must not be placeholder (xxx)`);
  }
  const side: PositionSide = config.side ?? "LENDER";
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);
  const minOwnerFraction = config.minOwnerFraction ?? OWNER_FRACTION_BY_LENDER[LENDER_KEY] ?? 0.01;

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
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
        const url = subgraphUrl(config.subgraphApiKey, subgraphId);
        try {
          const freshness = await checkSubgraphFreshness(LENDER_KEY, url, chainId, ctx?.signal);
          if (freshness) snapshot.chainFreshness![chainId] = freshness;

          const markets = await fetchMarkets(url, pageSize, ctx?.signal);
          for (const market of markets) {
            try {
              const underlying = market.inputToken.id.toLowerCase() as Address;
              const minBalance = (
                (BigInt(market.inputTokenBalance) * BigInt(Math.round(minOwnerFraction * 1e6))) /
                1000000n
              ).toString();
              const positions = await fetchMarketPositions(url, market.id, side, minBalance, pageSize, ctx?.signal);
              const totalSupply = Number(market.inputTokenBalance) / (10 ** market.inputToken.decimals);
              const ownership = buildMarketOwnership(positions, underlying, chainId, market.inputToken.decimals, totalSupply);
              if (ownership) snapshot.markets[ownership.marketUid] = ownership;
            } catch (err) {
              console.warn(`[${LENDER_KEY}] chain ${chainId} market ${market.id} skipped: ${(err as Error).message}`);
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
