import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type MarketUid,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  makeMarketUid,
} from "@lending-owners/core";
import { siloMarkets, siloMarketsV3 } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
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

// All chains covered by at least one V2 or V3 subgraph.
const SUPPORTED_CHAINS = [
  ...new Set([...Object.keys(V2_SUBGRAPH_IDS), ...Object.keys(V3_SUBGRAPH_IDS)]),
] as ChainId[];

export interface SiloConfig {
  subgraphApiKey: string;
  /** Page size for subgraph pagination (max 1000). Default 1000. */
  pageSize?: number;
  /** Skip fetching SDK metadata (caller already initialized it). */
  skipMetadataInit?: boolean;
}

// ── GraphQL types ────────────────────────────────────────────────────────────

// Silo subgraph schema (both V2 and V3) uses Messari's "LENDER" side for supply positions.
// The Position entity links to a Market (individual silo vault) which has an inputToken.
interface RawPosition {
  id: string;
  account: { id: string };
  market: { id: string; inputToken: { id: string } };
  balance: string;
}

interface PositionsResponse {
  positions: RawPosition[];
}

// ── GraphQL query ────────────────────────────────────────────────────────────

// Works for both V2 and V3 Silo subgraph schemas — both expose the Messari-compatible
// `Position` entity with `side`, `balance`, and `market.inputToken`.
const POSITIONS_QUERY = /* GraphQL */ `
  query Positions($first: Int!, $lastId: String!) {
    positions(
      first: $first
      where: { side: LENDER, balance_gt: "0", id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      account { id }
      market { id inputToken { id } }
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
  pageSize: number,
  signal?: AbortSignal,
): Promise<RawPosition[]> {
  const all: RawPosition[] = [];
  let lastId = "";
  for (;;) {
    const data = await queryGraphQL<PositionsResponse>(
      url,
      POSITIONS_QUERY,
      { first: pageSize, lastId },
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

function groupByUnderlying(
  positions: RawPosition[],
  allowedSilos: Set<string> | null,
  chainId: ChainId,
): Record<string, MarketOwnership> {
  const byAsset: Record<string, MarketOwnership> = {};
  for (const p of positions) {
    const siloAddr = p.market.id.toLowerCase();
    // If SDK provides a registry for this chain, skip silos not in it.
    if (allowedSilos !== null && !allowedSilos.has(siloAddr)) continue;

    const underlying = p.market.inputToken.id.toLowerCase() as Address;
    const account = p.account.id.toLowerCase() as Address;
    const balance = Number(p.balance);
    if (!Number.isFinite(balance) || balance <= 0) continue;

    const uid = makeMarketUid(LENDER_KEY, chainId, underlying);
    let market = byAsset[uid];
    if (!market) {
      market = { marketUid: uid, lenderKey: LENDER_KEY, chainId, underlying, owners: {} };
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

// Builds a Set of lowercase silo addresses from the SDK registry for a given chain.
// Returns null if no registry data is available (chain not yet in SDK → do not filter).
function buildAllowedSilos(
  chainId: ChainId,
  v2Data: ReturnType<typeof siloMarkets>,
  v3Data: ReturnType<typeof siloMarketsV3>,
): Set<string> | null {
  const chainStr = String(chainId);
  const v2Entries = (v2Data[chainStr] ?? []) as Array<{ silo0: { silo: string }; silo1: { silo: string } }>;
  const v3Entries = (v3Data[chainStr] ?? []) as Array<{ silo0: { silo: string }; silo1: { silo: string } }>;

  if (v2Entries.length === 0 && v3Entries.length === 0) return null;

  const allowed = new Set<string>();
  for (const entry of [...v2Entries, ...v3Entries]) {
    allowed.add(entry.silo0.silo.toLowerCase());
    allowed.add(entry.silo1.silo.toLowerCase());
  }
  return allowed;
}

// ── Factory ──────────────────────────────────────────────────────────────────

export function createSiloFetcher(config: SiloConfig): OwnershipFetcher {
  if (!config.subgraphApiKey) {
    throw new Error(`[${LENDER_KEY}] subgraphApiKey is required`);
  }
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ siloV2Markets: true, siloV3Markets: true });
      }

      const v2Data = siloMarkets() ?? {};
      const v3Data = siloMarketsV3() ?? {};

      const chains = ctx?.chainIds ?? SUPPORTED_CHAINS;
      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
      };

      for (const chainId of chains) {
        const allowedSilos = buildAllowedSilos(chainId, v2Data, v3Data);
        const v2SubgraphId = V2_SUBGRAPH_IDS[chainId];
        const v3SubgraphId = V3_SUBGRAPH_IDS[chainId];

        const mergeMarkets = (markets: Record<string, MarketOwnership>): void => {
          for (const [uid, market] of Object.entries(markets)) {
            const muid = uid as MarketUid;
            const existing = snapshot.markets[muid];
            if (!existing) {
              snapshot.markets[muid] = market;
            } else {
              for (const [owner, bal] of Object.entries(market.owners)) {
                const addr = owner as Address;
                existing.owners[addr] = (existing.owners[addr] ?? 0) + bal;
              }
            }
          }
        };

        // Query V2 subgraph for this chain (if available)
        if (v2SubgraphId) {
          const url = subgraphUrl(config.subgraphApiKey, v2SubgraphId);
          const positions = await fetchAllPositions(url, pageSize, ctx?.signal);
          mergeMarkets(groupByUnderlying(positions, allowedSilos, chainId));
        }

        // Query V3 subgraph for this chain (if available)
        if (v3SubgraphId) {
          const url = subgraphUrl(config.subgraphApiKey, v3SubgraphId);
          const positions = await fetchAllPositions(url, pageSize, ctx?.signal);
          mergeMarkets(groupByUnderlying(positions, allowedSilos, chainId));
        }
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
