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

const LENDER_KEY = "SILO";

const GATEWAY = "https://gateway-arbitrum.network.thegraph.com/api";
const subgraphUrl = (apiKey: string, id: string): string =>
  `${GATEWAY}/${apiKey}/subgraphs/id/${id}`;

// Known Silo V2 protocol subgraph IDs.
// V2 protocol = the original Silo isolated lending markets (siloMarkets() SDK data).
// Sources: https://devdocs.silo.finance/silo-subgraphs/subgraph-introduction
const V2_SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "5cNT22xQJVEWBBigBMBicv4UZAnGxH2CeHpenTJ8Q8kA", // Llama edition
  [Chain.ARBITRUM_ONE]: "2ufoztRpybsgogPVW6j9NTn1JmBWFYPKbP7pAabizADU",
};

// Known Silo V3 protocol subgraph IDs.
// V3 protocol = the newer Silo markets (siloMarketsV3() SDK data).
const V3_SUBGRAPH_IDS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "81ER342viJd3oRvPf28M7GwsnToa1RVWDNLnTr1eBciC",
};

const SUPPORTED_CHAINS = [
  ...new Set([...Object.keys(V2_SUBGRAPH_IDS), ...Object.keys(V3_SUBGRAPH_IDS)]),
] as ChainId[];

export interface SiloConfig {
  subgraphApiKey: string;
  pageSize?: number;
  /** Minimum owner fraction of market total to include. Defaults to OWNER_FRACTION_BY_LENDER["SILO"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ─────────────────────────────────────────────────────────────

interface RawMarket {
  id: string;
  inputToken: { id: string; decimals: number };
  supply: string;
}

interface MarketsResponse {
  markets: RawMarket[];
}

interface RawPosition {
  id: string;
  account: { id: string };
  sTokenBalance: string;
  spTokenBalance: string;
}

interface PositionsResponse {
  positions: RawPosition[];
}

// ── GraphQL queries ───────────────────────────────────────────────────────────

// Works for both V2 and V3 Silo subgraph schemas — both expose the Messari-compatible
// Market entity with inputToken and inputTokenBalance.
// Silo's schema uses `supply` (not `inputTokenBalance`) for the total tokens supplied per market.
const MARKETS_QUERY = /* GraphQL */ `
  query Markets($first: Int!, $lastId: String!) {
    markets(first: $first, where: { id_gt: $lastId, supply_gt: "0" }, orderBy: id, orderDirection: asc) {
      id
      inputToken { id decimals }
      supply
    }
  }
`;

const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($marketId: String!, $minBalance: BigInt!, $first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { market: $marketId, side: LENDER, sTokenBalance_gt: $minBalance, id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      account { id }
      sTokenBalance
      spTokenBalance
    }
  }
`;

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
      { marketId, minBalance, first: pageSize, lastId },
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

// ── Factory ───────────────────────────────────────────────────────────────────

export function createSiloFetcher(config: SiloConfig): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  if (isPlaceholderEnvValue(config.subgraphApiKey)) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey must not be placeholder (xxx)`);
  }
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
        const v2SubgraphId = V2_SUBGRAPH_IDS[chainId];
        const v3SubgraphId = V3_SUBGRAPH_IDS[chainId];

        const mergeOwnership = (ownership: MarketOwnership): void => {
          const muid = ownership.marketUid;
          const existing = snapshot.markets[muid];
          if (!existing) {
            snapshot.markets[muid] = ownership;
          } else {
            for (const [owner, bal] of Object.entries(ownership.owners)) {
              const addr = owner as Address;
              existing.owners[addr] = (existing.owners[addr] ?? 0) + bal;
            }
          }
        };

        const fetchSubgraph = async (subgraphId: string, label: string): Promise<void> => {
          const url = subgraphUrl(config.subgraphApiKey, subgraphId);
          try {
            const freshness = await checkSubgraphFreshness(LENDER_KEY, url, chainId, ctx?.signal);
            if (freshness) {
              // For Silo, V2 and V3 run on the same chain — keep the most recent freshness reading.
              const existing = snapshot.chainFreshness![chainId];
              if (!existing || freshness.subgraphBlock > existing.subgraphBlock) {
                snapshot.chainFreshness![chainId] = freshness;
              }
            }

            const markets = await fetchMarkets(url, pageSize, ctx?.signal);
            for (const market of markets) {
              const underlying = market.inputToken.id.toLowerCase() as Address;
              const minBalance = (BigInt(market.supply) * BigInt(Math.round(minOwnerFraction * 1e6)) / 1000000n).toString();
              const positions = await fetchMarketPositions(url, market.id, minBalance, pageSize, ctx?.signal);

              const scalar = 10 ** market.inputToken.decimals;
              const totalSupply = Number(market.supply) / scalar;
              const owners: Record<Address, number> = {};
              for (const p of positions) {
                const account = p.account.id.toLowerCase() as Address;
                const balance = (Number(p.sTokenBalance) + Number(p.spTokenBalance)) / scalar;
                if (!Number.isFinite(balance) || balance <= 0) continue;
                owners[account] = (owners[account] ?? 0) + balance;
              }
              if (Object.keys(owners).length === 0) continue;
              const uid = makeMarketUid(LENDER_KEY, chainId, underlying);
              const sorted = Object.fromEntries(Object.entries(owners).sort((a, b) => b[1] - a[1]));
              mergeOwnership({ marketUid: uid, lenderKey: LENDER_KEY, chainId, underlying, totalSupply, owners: sorted });
            }
          } catch (err) {
            console.warn(`[${LENDER_KEY}] chain ${chainId} ${label} skipped: ${(err as Error).message}`);
          }
        };

        if (v2SubgraphId) await fetchSubgraph(v2SubgraphId, "V2");
        if (v3SubgraphId) await fetchSubgraph(v3SubgraphId, "V3");
      }

      // Re-sort owners by descending balance after cross-subgraph merging.
      for (const market of Object.values(snapshot.markets)) {
        const sorted = Object.entries(market.owners).sort((a, b) => b[1] - a[1]);
        market.owners = Object.fromEntries(sorted);
      }

      return snapshot;
    },
  };
}
