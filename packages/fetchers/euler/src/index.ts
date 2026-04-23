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
import { eulerVaults } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";
import { Chain } from "@1delta/chain-registry";

const LENDER_KEY = "EULER_V2";
const EULER_V2_FORK = "EULER_V2";

// Public Goldsky endpoints — no API key required.
// Schema entity: TrackingVaultBalance { id, vault (Bytes), mainAddress (Bytes), balance, debt }
// Underlying asset is resolved via eulerVaults() SDK data (vault → underlying map).
const ENDPOINTS: Partial<Record<ChainId, string>> = {
  [Chain.ETHEREUM_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-mainnet/latest/gn",
  [Chain.BASE]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-base/latest/gn",
  [Chain.ARBITRUM_ONE]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-arbitrum/latest/gn",
  [Chain.OP_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-optimism/latest/gn",
  [Chain.AVALANCHE_C_CHAIN]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-avalanche/latest/gn",
  [Chain.BNB_SMART_CHAIN_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-bsc/latest/gn",
  [Chain.GNOSIS]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-gnosis/latest/gn",
  [Chain.BERACHAIN]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-berachain/latest/gn",
  [Chain.SONIC_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-sonic/latest/gn",
  [Chain.MANTLE]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-mantle/latest/gn",
  [Chain.UNICHAIN]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-unichain/latest/gn",
  [Chain.WORLD_CHAIN]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-worldchain/latest/gn",
  [Chain.INK]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-ink/latest/gn",
  [Chain.BOB]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-bob/latest/gn",
  [Chain.SWELLCHAIN]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-swell/latest/gn",
  [Chain.HYPEREVM]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-hyperevm/latest/gn",
  [Chain.TAC_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-tac/latest/gn",
  [Chain.PLASMA_MAINNET]: "https://api.goldsky.com/api/public/project_cm4iagnemt1wp01xn4gh1agft/subgraphs/euler-v2-plasma/latest/gn",
};

const SUPPORTED_CHAINS = Object.keys(ENDPOINTS) as ChainId[];

export interface EulerConfig {
  /** Page size for subgraph pagination (max 1000). Default 1000. */
  pageSize?: number;
  /** Skip fetching SDK metadata (caller already initialized it). */
  skipMetadataInit?: boolean;
  /** Minimum owner fraction of market total to include. Defaults to OWNER_FRACTION_BY_LENDER["EULER"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ────────────────────────────────────────────────────────────

interface RawVaultBalance {
  id: string;
  vault: string;       // vault address (Bytes — raw hex string, not an object reference)
  mainAddress: string; // owner's canonical wallet address (sub-account byte stripped)
  balance: string;
}

interface VaultBalancesResponse {
  trackingVaultBalances: RawVaultBalance[];
}

// ── GraphQL query ────────────────────────────────────────────────────────────

const VAULT_BALANCES_QUERY = /* GraphQL */ `
  query VaultBalances($first: Int!, $lastId: String!) {
    trackingVaultBalances(
      first: $first
      where: { balance_gt: "0", id_gt: $lastId }
      orderBy: id
      orderDirection: asc
    ) {
      id
      vault
      mainAddress
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

async function fetchAllVaultBalances(
  url: string,
  pageSize: number,
  signal?: AbortSignal,
): Promise<RawVaultBalance[]> {
  const all: RawVaultBalance[] = [];
  let lastId = "";
  for (;;) {
    const data = await queryGraphQL<VaultBalancesResponse>(
      url,
      VAULT_BALANCES_QUERY,
      { first: pageSize, lastId },
      signal,
    );
    const batch = data.trackingVaultBalances;
    if (batch.length === 0) break;
    all.push(...batch);
    if (batch.length < pageSize) break;
    lastId = batch[batch.length - 1].id;
  }
  return all;
}

// ── Market grouping ──────────────────────────────────────────────────────────

function groupByUnderlying(
  vaultBalances: RawVaultBalance[],
  vaultToUnderlying: Map<string, string>,
  chainId: ChainId,
  minOwnerFraction: number,
): Record<string, MarketOwnership> {
  // First pass: accumulate all balances to compute per-market total.
  const rawTotals: Record<string, number> = {};
  const rawOwners: Record<string, Record<Address, number>> = {};
  const underlyingByUid: Record<string, string> = {};

  for (const entry of vaultBalances) {
    const vaultAddr = entry.vault.toLowerCase();
    const underlying = vaultToUnderlying.get(vaultAddr);
    if (!underlying) continue;

    const account = entry.mainAddress.toLowerCase() as Address;
    const balance = Number(entry.balance);
    if (!Number.isFinite(balance) || balance <= 0) continue;

    const uid = makeMarketUid(LENDER_KEY, chainId, underlying as Address);
    rawTotals[uid] = (rawTotals[uid] ?? 0) + balance;
    rawOwners[uid] = rawOwners[uid] ?? {};
    rawOwners[uid][account] = (rawOwners[uid][account] ?? 0) + balance;
    underlyingByUid[uid] = underlying;
  }

  // Second pass: filter to owners above threshold, set totalSupply.
  const result: Record<string, MarketOwnership> = {};
  for (const [uid, total] of Object.entries(rawTotals)) {
    const threshold = total * minOwnerFraction;
    const filtered = Object.entries(rawOwners[uid])
      .filter(([, bal]) => bal >= threshold)
      .sort(([, a], [, b]) => b - a);
    if (filtered.length === 0) continue;
    result[uid] = {
      marketUid: uid as MarketOwnership["marketUid"],
      lenderKey: LENDER_KEY,
      chainId,
      underlying: underlyingByUid[uid] as Address,
      totalSupply: total,
      owners: Object.fromEntries(filtered) as Record<Address, number>,
    };
  }
  return result;
}

// ── Factory ──────────────────────────────────────────────────────────────────

export function createEulerFetcher(config: EulerConfig = {}): OwnershipFetcher {
  const pageSize = Math.min(Math.max(config.pageSize ?? 1000, 1), 1000);
  const minOwnerFraction = config.minOwnerFraction ?? OWNER_FRACTION_BY_LENDER[LENDER_KEY] ?? 0.01;

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: SUPPORTED_CHAINS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ eulerVaults: true });
      }

      const vaultsData = eulerVaults() ?? {};
      const chainVaults = vaultsData[EULER_V2_FORK] ?? {};

      const chains = ctx?.chainIds ?? SUPPORTED_CHAINS;
      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
      };

      for (const chainId of chains) {
        const url = ENDPOINTS[chainId];
        if (!url) continue;

        // Build vault → underlying map from SDK. Skip chain if no vault data available.
        const vaultEntries = chainVaults[String(chainId)] ?? [];
        if (vaultEntries.length === 0) continue;

        const vaultToUnderlying = new Map<string, string>();
        for (const entry of vaultEntries) {
          vaultToUnderlying.set(entry.vault.toLowerCase(), entry.underlying.toLowerCase());
        }

        const rawBalances = await fetchAllVaultBalances(url, pageSize, ctx?.signal);
        const markets = groupByUnderlying(rawBalances, vaultToUnderlying, chainId, minOwnerFraction);
        Object.assign(snapshot.markets, markets);
      }

      return snapshot;
    },
  };
}
