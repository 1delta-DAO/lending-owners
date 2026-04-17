import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";
import { morphoPools } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { Chain } from "@1delta/chain-registry";

const LENDER_KEY = "MORPHO_BLUE";
const SDK_PROTOCOL_KEY = "MORPHO_BLUE";

const subgraphUrl = (apiKey: string, id: string): string =>
  `https://gateway.thegraph.com/api/${apiKey}/subgraphs/id/${id}`;

// Subgraph IDs from https://thegraph.com/explorer/profile/0x84d3e4ee550dd5f99e76a548ac59a6be1c8dcf79
// Side note: Morpho Blue's subgraph schema uses "SUPPLIER" (not "LENDER") for supply positions.
const SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "8Lz789DP5VKLXumTMTgygjU2xtuzx8AhbaacgN5PYCAs",
  [Chain.BASE]: "71ZTy1veF9twER9CLMnPWeLQ7GZcwKsjmygejrgKirqs",
  [Chain.ARBITRUM_ONE]: "XsJn88DNCHJ1kgTqYeTgHMQSK4LuG1LR75339QVeQ26",
  [Chain.POLYGON_MAINNET]: "EhFokmwryNs7qbvostceRqVdjc3petuD13mmdUiMBw8Y",
  [Chain.OP_MAINNET]: "5y8d3K3vVCR7r5YwANGCjupLc3hUge54XvhYMEq3Jmq1",
  [Chain.UNICHAIN]: "ESbNRVHte3nwhcHveux9cK4FFAZK3TTLc5mKQNtpYgmu",
  [Chain.SONIC_MAINNET]: "J2THmwKHrTLKT9HPZNwZ69NkJ7WSbtLKz7pUQZW1Z1Qc",
  [Chain.SCROLL]: "Aic7prLAxhtipUEbLu5BhDDWf4LssT9n3DG4fT9yCRqm",
  [Chain.MODE]: "341uEcvH1UAzWETvVB974Au1YR3MksJdf2jhjuHXDLQ7",
  [Chain.FRAXTAL]: "CDFzHFQTXj1ryFgA8KpkUuv6qu3Jk6fLG7kzdpuCe95g",
  [Chain.INK]: "7pezYZCEJVBbZbbkjLFcPo3hdVUxUv8skF2FqGibRcfk",
  [Chain.CORN]: "4SswjwWRyBryaEBwzHfwayEpJWRS9f7xvsGC5kE6govQ",
  [Chain.HEMI_NETWORK]: "2JZScBV6sD7BdoU9JBAwYPrbzUarPGGz9P1xVWFQxmdX",
};

// Chains with both a subgraph and confirmed Morpho Blue deployment (via morphoPools SDK data).
// This list is the intersection; SDK init at runtime can further validate.
const SUPPORTED_CHAINS = Object.keys(SUBGRAPH_IDS) as ChainId[];

export interface MorphoBlueConfig {
  subgraphApiKey: string;
  /** Page size for subgraph pagination (max 1000). Default 1000. */
  pageSize?: number;
  /** Skip fetching SDK metadata (caller already initialized it). */
  skipMetadataInit?: boolean;
}

// ── GraphQL types ────────────────────────────────────────────────────────────

// Morpho Blue uses "SUPPLIER" for supply-side positions (not "LENDER").
// "COLLATERAL" is a separate side for pure collateral deposits — excluded here.
type PositionSide = "SUPPLIER" | "BORROWER" | "COLLATERAL";

interface RawPosition {
  id: string;
  account: { id: string };
  asset: { id: string };
  balance: string;
}

interface PositionsResponse {
  positions: RawPosition[];
}

// ── GraphQL query ────────────────────────────────────────────────────────────

const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($side: PositionSide!, $first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { side: $side, balance_gt: "0", id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      account { id }
      asset { id }
      balance
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
    throw new Error(`[${LENDER_KEY}] subgraph HTTP ${res.status}`);
  }
  const json = (await res.json()) as { data?: T; errors?: Array<{ message: string }> };
  if (json.errors?.length) {
    throw new Error(`[${LENDER_KEY}] subgraph errors: ${json.errors.map((e) => e.message).join("; ")}`);
  }
  if (!json.data) {
    throw new Error(`[${LENDER_KEY}] subgraph returned no data`);
  }
  return json.data;
}

// ── Data fetching ────────────────────────────────────────────────────────────

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
    const batch = data.positions;
    if (batch.length === 0) break;
    all.push(...batch);
    if (batch.length < pageSize) break;
    lastId = batch[batch.length - 1].id;
  }
  return all;
}

// ── Market grouping ──────────────────────────────────────────────────────────

function groupByAsset(
  positions: RawPosition[],
  chainId: ChainId,
): Record<string, MarketOwnership> {
  const byAsset: Record<string, MarketOwnership> = {};
  for (const p of positions) {
    const asset = p.asset.id.toLowerCase() as Address;
    const account = p.account.id.toLowerCase() as Address;
    const balance = Number(p.balance);
    if (!Number.isFinite(balance) || balance <= 0) continue;
    const uid = makeMarketUid(LENDER_KEY, chainId, asset);
    let market = byAsset[uid];
    if (!market) {
      market = { marketUid: uid, lenderKey: LENDER_KEY, chainId, underlying: asset, owners: {} };
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

// ── Factory ──────────────────────────────────────────────────────────────────

export function createMorphoBlueFetcher(config: MorphoBlueConfig): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ morphoPools: true });
      }

      // Use SDK to confirm which chains have a live Morpho Blue deployment,
      // then intersect with chains we also have a subgraph for.
      const pools = morphoPools() ?? {};
      const deployedChains = new Set(Object.keys(pools[SDK_PROTOCOL_KEY] ?? {}));

      const chains = ctx?.chainIds ?? SUPPORTED_CHAINS;
      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
      };

      for (const chainId of chains) {
        const subgraphId = SUBGRAPH_IDS[chainId];
        if (!subgraphId) continue;
        // Skip chains where SDK has no record of a Morpho deployment (may be stale data).
        if (deployedChains.size > 0 && !deployedChains.has(String(chainId))) continue;

        try {
          const url = subgraphUrl(config.subgraphApiKey, subgraphId);
          const positions = await fetchAllPositions(url, "SUPPLIER", pageSize, ctx?.signal);
          const markets = groupByAsset(positions, chainId);
          Object.assign(snapshot.markets, markets);
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} skipped: ${(err as Error).message}`);
        }
      }

      return snapshot;
    },
  };
}
