import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";
import { compoundV3Pools } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { isCompoundV3 } from "@1delta/lender-registry";
import { Chain } from "@1delta/chain-registry";

export * from "./hist/index.js";

const LENDER_KEY = "COMPOUND_V3";

const SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "AwoxEZbiWLvv6e3QdvdMZw4WDURdGbvPfHmZRc8Dpfz9",
};

const SUPPORTED_CHAINS: ChainId[] = Object.keys(SUBGRAPH_IDS) as ChainId[];

const subgraphUrl = (apiKey: string, id: string): string =>
  `https://gateway.thegraph.com/api/${apiKey}/subgraphs/id/${id}`;

export type PositionSide = "LENDER" | "BORROWER";

export interface CompoundV3Config {
  subgraphApiKey: string;
  /** LENDER (suppliers) | BORROWER. Defaults to LENDER. */
  side?: PositionSide;
  /** Page size for subgraph pagination (max 1000). */
  pageSize?: number;
  /** Skip auto-init of 1delta metadata (caller initialized it). */
  skipMetadataInit?: boolean;
}

interface RawPosition {
  id: string;
  side: PositionSide;
  account: { id: string };
  asset: { id: string };
  balance: string;
  market: { id: string };
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
  if (json.errors?.length) {
    throw new Error(`[${LENDER_KEY}] subgraph errors: ${json.errors.map((e) => e.message).join("; ")}`);
  }
  if (!json.data) {
    throw new Error(`[${LENDER_KEY}] subgraph returned no data`);
  }
  return json.data;
}

const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($market: String!, $side: PositionSide!, $first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { market: $market, side: $side, balance_gt: "0", id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      side
      account { id }
      asset { id }
      balance
      market { id }
    }
  }
`;

async function fetchMarketPositions(
  url: string,
  market: Address,
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
      { market: market.toLowerCase(), side, first: pageSize, lastId },
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

function groupByAsset(
  positions: RawPosition[],
  lenderKey: string,
  chainId: ChainId,
): Record<string, MarketOwnership> {
  const byAsset: Record<string, MarketOwnership> = {};
  for (const p of positions) {
    const asset = p.asset.id.toLowerCase();
    const account = p.account.id.toLowerCase();
    const balance = Number(p.balance);
    if (!Number.isFinite(balance) || balance <= 0) continue;
    const uid = makeMarketUid(lenderKey, chainId, asset);
    let market = byAsset[uid];
    if (!market) {
      market = {
        marketUid: uid,
        lenderKey,
        chainId,
        underlying: asset,
        owners: {},
      };
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

export function createCompoundV3Fetcher(config: CompoundV3Config): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  const side: PositionSide = config.side ?? "LENDER";
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);

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
      };

      for (const chainId of chains) {
        const subgraphId = SUBGRAPH_IDS[chainId];
        if (!subgraphId) continue;
        const chainPools: Record<string, string> = pools[chainId] ?? {};
        const comets = Object.entries(chainPools)
          .filter(([, lender]) => isCompoundV3(lender))
          .map(([comet]) => comet);
        if (comets.length === 0) continue;
        const url = subgraphUrl(config.subgraphApiKey, subgraphId);
        for (const comet of comets) {
          try {
            const positions = await fetchMarketPositions(url, comet, side, pageSize, ctx?.signal);
            const markets = groupByAsset(positions, LENDER_KEY, chainId);
            Object.assign(snapshot.markets, markets);
          } catch (err) {
            console.warn(`[${LENDER_KEY}] chain ${chainId} comet ${comet} skipped: ${(err as Error).message}`);
          }
        }
      }

      return snapshot;
    },
  };
}
