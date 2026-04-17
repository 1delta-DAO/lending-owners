import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";
import { Chain } from "@1delta/chain-registry";

const LENDER_KEY = "AAVE_V3";

// Subgraph IDs from Messari's Aave V3 deployment (decentralized network).
// Schema uses "COLLATERAL" for supply-side positions (not "LENDER").
// Source: https://github.com/messari/subgraphs/blob/master/deployment/deployment.json
const SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "JCNWRypm7FYwV8fx5HhzZPSFaMxgkPuw4TnR3Gpi81zk",
  [Chain.BASE]: "D7mapexM5ZsQckLJai2FawTKXJ7CqYGKM8PErnS3cJi9",
  [Chain.ARBITRUM_ONE]: "4xyasjQeREe7PxnF6wVdobZvCw5mhoHZq3T7guRpuNPf",
  [Chain.POLYGON_MAINNET]: "6yuf1C49aWEscgk5n9D1DekeG1BCk5Z9imJYJT3sVmAT",
  [Chain.OP_MAINNET]: "3RWFxWNstn4nP3dXiDfKi9GgBoHx7xzc7APkXs1MLEgi",
  [Chain.AVALANCHE_C_CHAIN]: "72Cez54APnySAn6h8MswzYkwaL9KjvuuKnKArnPJ8yxb",
};

const SUPPORTED_CHAINS = Object.keys(SUBGRAPH_IDS) as ChainId[];

const subgraphUrl = (apiKey: string, id: string): string =>
  `https://gateway.thegraph.com/api/${apiKey}/subgraphs/id/${id}`;

export type PositionSide = "COLLATERAL" | "LENDER" | "BORROWER";

export interface AaveV3Config {
  subgraphApiKey: string;
  side?: PositionSide;
  pageSize?: number;
}

interface RawPosition {
  id: string;
  side: PositionSide;
  account: { id: string };
  asset: { id: string };
  balance: string;
}

interface PositionsResponse {
  positions: RawPosition[];
}

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
    // Partial data returned alongside errors (e.g. orphaned null-field entries).
    // Warn and continue — valid positions are still processed.
    console.warn(`[${LENDER_KEY}] subgraph partial errors: ${json.errors.slice(0, 3).map((e) => e.message).join("; ")}${json.errors.length > 3 ? ` (+${json.errors.length - 3} more)` : ""}`);
  }
  return json.data;
}

const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($side: PositionSide!, $first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { side: $side, balance_gt: "0", id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      side
      account { id }
      asset { id }
      balance
    }
  }
`;

async function fetchAllPositions(
  url: string,
  side: PositionSide,
  pageSize: number,
  signal?: AbortSignal,
): Promise<RawPosition[]> {
  const all: RawPosition[] = [];
  let lastId = "";
  for (;;) {
    const data = await queryGraphQL<PositionsResponse>(
      url,
      POSITIONS_QUERY,
      { side, first: pageSize, lastId },
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

function groupByAsset(
  positions: RawPosition[],
  lenderKey: string,
  chainId: ChainId,
): Record<string, MarketOwnership> {
  const byAsset: Record<string, MarketOwnership> = {};
  for (const p of positions) {
    const asset = p.asset.id.toLowerCase() as Address;
    const account = p.account.id.toLowerCase() as Address;
    const balance = Number(p.balance);
    if (!Number.isFinite(balance) || balance <= 0) continue;
    const uid = makeMarketUid(lenderKey, chainId, asset);
    let market = byAsset[uid];
    if (!market) {
      market = { marketUid: uid, lenderKey, chainId, underlying: asset, owners: {} };
      byAsset[uid] = market;
    }
    market.owners[account] = (market.owners[account] ?? 0) + balance;
  }
  for (const market of Object.values(byAsset)) {
    const sorted = Object.entries(market.owners).sort((a, b) => b[1] - a[1]);
    market.owners = Object.fromEntries(sorted);
  }
  return byAsset;
}

export function createAaveV3Fetcher(config: AaveV3Config): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  const side: PositionSide = config.side ?? "COLLATERAL";
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      const chains = ctx?.chainIds ?? SUPPORTED_CHAINS;
      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
      };

      for (const chainId of chains) {
        const subgraphId = SUBGRAPH_IDS[chainId];
        if (!subgraphId) continue;
        try {
          const url = subgraphUrl(config.subgraphApiKey, subgraphId);
          const positions = await fetchAllPositions(url, side, pageSize, ctx?.signal);
          const markets = groupByAsset(positions, LENDER_KEY, chainId);
          Object.assign(snapshot.markets, markets);
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} skipped: ${(err as Error).message}`);
        }
      }

      return snapshot;
    },
  };
}
