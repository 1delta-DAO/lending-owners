import {
  type Address,
  type ChainId,
  type FetcherContext,
  type MarketOwnership,
  type OwnerBalances,
  type OwnershipFetcher,
  type OwnershipSnapshot,
  OWNER_FRACTION_BY_LENDER,
  checkIndexedBlockFreshness,
  makeMarketUid,
} from "@lending-owners/core";
import { morphoPools } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";

const LENDER_KEY = "MORPHO_BLUE";
const SDK_PROTOCOL_KEY = "MORPHO_BLUE";

/**
 * Morpho's official indexer. Chosen over the Messari subgraphs because those are
 * unmaintained: as of 2026-08 the mainnet, Base, OP and Unichain deployments all
 * return "bad indexers" / "no allocations", which silently dropped every mainnet
 * and Base market from the snapshot. This API needs no key and is the canonical
 * source for every chain Morpho is deployed on.
 */
const MORPHO_API_URL = "https://blue-api.morpho.org/graphql";

/** The API caps `first` at 1000 and `skip` at 10000 on every paginated collection. */
const MAX_PAGE_SIZE = 1000;
const MAX_SKIP = 10000;

/** Public API budget is 750 requests/min; stay well under it. */
const DEFAULT_CONCURRENCY = 6;
const MIN_REQUEST_INTERVAL_MS = 130; // ~460 requests/min

/**
 * Chains Morpho is deployed on, as of 2026-08. Only used to advertise support —
 * the chains actually fetched come from the API at fetch time, so a new Morpho
 * deployment is picked up without a code change.
 */
const KNOWN_CHAIN_IDS = [
  "1",
  "10",
  "130",
  "137",
  "143",
  "480",
  "988",
  "999",
  "4217",
  "4663",
  "5042",
  "8453",
  "42161",
  "747474",
] as ChainId[];

/** Market ids are 32-byte hashes; validated because they are interpolated into queries. */
const MARKET_ID_RE = /^0x[0-9a-fA-F]{64}$/;

/**
 * Per-request complexity budget the API enforces. Cost scales with the requested
 * `first` across all aliases in a document, so this bounds how many market sides
 * are batched into one request.
 */
const MAX_COMPLEXITY = 1_000_000;
const COMPLEXITY_PER_ITEM = 200;
const COMPLEXITY_BUDGET = MAX_COMPLEXITY * 0.6;

export interface MorphoBlueConfig {
  apiUrl?: string;
  pageSize?: number;
  skipMetadataInit?: boolean;
  /** Concurrent API requests. Defaults to 6. */
  concurrency?: number;
  /** Minimum owner fraction of the market total per side. Defaults to OWNER_FRACTION_BY_LENDER["MORPHO_BLUE"]. */
  minOwnerFraction?: number;
}

// ── GraphQL types ─────────────────────────────────────────────────────────────

/** BigInt scalars arrive as a JS number while they fit in a double, as a string beyond that. */
type BigIntish = string | number | null;

interface RawChain {
  id: number;
  headBlock: { number: number } | null;
}

interface RawAsset {
  address: string;
  decimals: number;
}

interface RawMarket {
  marketId: string;
  loanAsset: RawAsset | null;
  collateralAsset: RawAsset | null;
  state: {
    supplyAssets: BigIntish;
    borrowAssets: BigIntish;
    collateralAssets: BigIntish;
    supplyShares: BigIntish;
    borrowShares: BigIntish;
  } | null;
}

interface RawPosition {
  user: { address: string } | null;
  state: {
    supplyAssets: BigIntish;
    borrowAssets: BigIntish;
    collateral: BigIntish;
  } | null;
}

interface RawVaultV2 {
  address: string;
  chain: { id: number } | null;
  adapters: { items: Array<{ address: string }> | null } | null;
}

interface Paginated<T> {
  pageInfo: { countTotal: number };
  items: T[] | null;
}

// ── GraphQL queries ───────────────────────────────────────────────────────────

const CHAINS_QUERY = /* GraphQL */ `
  query Chains {
    chains {
      id
      headBlock {
        number
      }
    }
  }
`;

/**
 * A Vault V2 supplies to a market through a per-allocation adapter contract, so
 * the on-chain position holder is the adapter, not the vault. This maps each
 * adapter back to its parent vault so ownership lands on the vault — matching how
 * V1 MetaMorpho vaults, which supply directly, already appear.
 */
const VAULT_V2_ADAPTERS_QUERY = /* GraphQL */ `
  query VaultV2Adapters($first: Int!, $skip: Int!) {
    vaultV2s(
      first: $first
      skip: $skip
      orderBy: Address
      orderDirection: Asc
      where: { totalAssets_gte: 1 }
    ) {
      pageInfo {
        countTotal
      }
      items {
        address
        chain {
          id
        }
        adapters {
          items {
            address
          }
        }
      }
    }
  }
`;

const MARKETS_QUERY = /* GraphQL */ `
  query Markets($first: Int!, $skip: Int!, $chainId: Int!) {
    markets(
      first: $first
      skip: $skip
      orderBy: UniqueKey
      orderDirection: Asc
      where: { chainId_in: [$chainId] }
    ) {
      pageInfo {
        countTotal
      }
      items {
        marketId
        loanAsset {
          address
          decimals
        }
        collateralAsset {
          address
          decimals
        }
        state {
          supplyAssets
          borrowAssets
          collateralAssets
          supplyShares
          borrowShares
        }
      }
    }
  }
`;

/** The three position sides, each with the market total it is measured against. */
const SIDES = ["supply", "borrow", "collateral"] as const;
type Side = (typeof SIDES)[number];

/**
 * Filter field per side. Supply and borrow are filtered on *shares* rather than
 * assets — shares convert to assets through a single per-market index, so a share
 * threshold selects exactly the same owners as the equivalent asset threshold.
 */
const SIDE_FILTER: Record<Side, string> = {
  supply: "supplyShares_gte",
  borrow: "borrowShares_gte",
  collateral: "collateral_gte",
};

const SIDE_ORDER_BY: Record<Side, string> = {
  supply: "SupplyShares",
  borrow: "BorrowShares",
  collateral: "Collateral",
};

// ── HTTP client ───────────────────────────────────────────────────────────────

const sleep = (ms: number, signal?: AbortSignal): Promise<void> =>
  new Promise((resolve, reject) => {
    const timer = setTimeout(resolve, ms);
    signal?.addEventListener(
      "abort",
      () => {
        clearTimeout(timer);
        reject(new Error("aborted"));
      },
      { once: true },
    );
  });

/**
 * Concurrency-limited GraphQL client that backs off on the API's 429s instead of
 * failing the whole chain.
 */
class ApiClient {
  private active = 0;
  private readonly queue: Array<() => void> = [];
  private nextSlotAt = 0;

  constructor(
    private readonly url: string,
    private readonly concurrency: number,
    private readonly signal?: AbortSignal,
  ) {}

  async query<T>(query: string, variables: Record<string, unknown>): Promise<T> {
    await this.acquire();
    try {
      await this.pace();
      return await this.execute<T>(query, variables);
    } finally {
      this.release();
    }
  }

  /** Spaces request starts so bursts stay under the API's per-minute budget. */
  private async pace(): Promise<void> {
    const now = Date.now();
    const startAt = Math.max(now, this.nextSlotAt);
    this.nextSlotAt = startAt + MIN_REQUEST_INTERVAL_MS;
    if (startAt > now) await sleep(startAt - now, this.signal);
  }

  private async execute<T>(
    query: string,
    variables: Record<string, unknown>,
  ): Promise<T> {
    for (let attempt = 0; ; attempt += 1) {
      const res = await fetch(this.url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query, variables }),
        signal: this.signal,
      });
      if (res.status === 429 && attempt < 4) {
        const retryAfter = Number(res.headers.get("retry-after"));
        const waitMs = Number.isFinite(retryAfter)
          ? Math.min(retryAfter * 1000, 90_000)
          : 2000 * 2 ** attempt;
        console.warn(
          `[${LENDER_KEY}] rate limited, retrying in ${Math.round(waitMs / 1000)}s`,
        );
        await sleep(waitMs, this.signal);
        continue;
      }
      const json = (await res.json().catch(() => null)) as {
        data?: T;
        errors?: Array<{ message: string }>;
      } | null;
      if (!json?.data) {
        const msg =
          json?.errors?.map((e) => e.message).join("; ") ?? `HTTP ${res.status}`;
        throw new Error(`[${LENDER_KEY}] API errors: ${msg}`);
      }
      if (json.errors?.length) {
        console.warn(
          `[${LENDER_KEY}] API partial errors: ${json.errors
            .slice(0, 3)
            .map((e) => e.message)
            .join("; ")}${json.errors.length > 3 ? ` (+${json.errors.length - 3} more)` : ""}`,
        );
      }
      return json.data;
    }
  }

  private acquire(): Promise<void> {
    if (this.active < this.concurrency) {
      this.active += 1;
      return Promise.resolve();
    }
    return new Promise((resolve) => {
      this.queue.push(() => {
        this.active += 1;
        resolve();
      });
    });
  }

  private release(): void {
    this.active -= 1;
    this.queue.shift()?.();
  }
}

/** Walks a `skip`-paginated collection until `countTotal` is reached. */
async function fetchAllPages<T>(
  client: ApiClient,
  label: string,
  query: string,
  variables: Record<string, unknown>,
  pick: (data: never) => Paginated<T>,
  pageSize: number,
): Promise<T[]> {
  const all: T[] = [];
  for (let skip = 0; ; ) {
    const page = pick(
      await client.query<never>(query, { ...variables, first: pageSize, skip }),
    );
    const items = page.items ?? [];
    all.push(...items);
    skip += items.length;
    if (items.length === 0 || skip >= page.pageInfo.countTotal) break;
    if (skip > MAX_SKIP) {
      console.warn(
        `[${LENDER_KEY}] ${label}: truncated at ${skip}/${page.pageInfo.countTotal} — API caps skip at ${MAX_SKIP}`,
      );
      break;
    }
  }
  return all;
}

// ── Numeric helpers ───────────────────────────────────────────────────────────

function toBigInt(value: BigIntish): bigint {
  if (value == null) return 0n;
  if (typeof value === "number") {
    return Number.isFinite(value) ? BigInt(Math.trunc(value)) : 0n;
  }
  const trimmed = value.trim();
  if (!/^-?\d+$/.test(trimmed)) return 0n;
  return BigInt(trimmed);
}

/**
 * Morpho reports the totals of drained markets as small negative values (a
 * rounding artifact of its share accounting), so totals are clamped at zero.
 */
function toHuman(raw: bigint, decimals: number): number {
  return raw > 0n ? Number(raw) / 10 ** decimals : 0;
}

// ── Adapter resolution ────────────────────────────────────────────────────────

type AdapterMap = Map<string, Address>;

const adapterKey = (chainId: number, address: string): string =>
  `${chainId}:${address.toLowerCase()}`;

async function fetchAdapterMap(
  client: ApiClient,
  pageSize: number,
): Promise<AdapterMap> {
  const vaults = await fetchAllPages<RawVaultV2>(
    client,
    "vaultV2s",
    VAULT_V2_ADAPTERS_QUERY,
    {},
    (d: { vaultV2s: Paginated<RawVaultV2> }) => d.vaultV2s,
    // The nested adapter list makes this query far heavier per item than the
    // others, and the API rejects anything over its complexity budget.
    Math.min(pageSize, 200),
  );
  const map: AdapterMap = new Map();
  for (const vault of vaults) {
    const chainId = vault.chain?.id;
    if (chainId == null) continue;
    for (const adapter of vault.adapters?.items ?? []) {
      map.set(
        adapterKey(chainId, adapter.address),
        vault.address.toLowerCase() as Address,
      );
    }
  }
  return map;
}

// ── Per-side owner queries ────────────────────────────────────────────────────

interface SideRequest {
  marketId: string;
  side: Side;
  /** Minimum raw balance for this side, in the unit the side's filter uses. */
  minFilterValue: bigint;
}

/**
 * Builds one aliased document per batch. Every entry filters server-side on the
 * market's own threshold, so a side can never return more than `1 /
 * minOwnerFraction` owners — that is what keeps markets with 100k+ positions
 * within a single page and clear of the `skip` cap.
 */
function buildSideBatchQuery(batch: SideRequest[], chainId: number, first: number): string {
  const parts = batch.map((req, i) => {
    const filter = `{ chainId_in: [${chainId}], marketUniqueKey_in: ["${req.marketId}"], ${SIDE_FILTER[req.side]}: "${req.minFilterValue}" }`;
    return `    s${i}: marketPositions(first: ${first}, orderBy: ${SIDE_ORDER_BY[req.side]}, orderDirection: Desc, where: ${filter}) {
      items {
        user {
          address
        }
        state {
          supplyAssets
          borrowAssets
          collateral
        }
      }
    }`;
  });
  return `query SideOwners {\n${parts.join("\n")}\n}`;
}

// ── Market grouping ───────────────────────────────────────────────────────────

/** Sums balances per resolved owner and drops anything that rounds to nothing. */
function buildSide(
  balances: Map<Address, bigint>,
  decimals: number,
): OwnerBalances | null {
  const entries: Array<[Address, number]> = [];
  for (const [owner, raw] of balances) {
    if (raw <= 0n) continue;
    const value = toHuman(raw, decimals);
    if (!Number.isFinite(value) || value <= 0) continue;
    entries.push([owner, value]);
  }
  if (entries.length === 0) return null;
  entries.sort((a, b) => b[1] - a[1]);
  return Object.fromEntries(entries);
}

function buildMarketOwnership(
  market: RawMarket,
  sides: Record<Side, Map<Address, bigint>>,
  chainId: ChainId,
): MarketOwnership | null {
  const loanAsset = market.loanAsset;
  if (!loanAsset || !market.state) return null;

  const loanDecimals = loanAsset.decimals;
  const collateralAsset = market.collateralAsset;

  const owners = buildSide(sides.supply, loanDecimals);
  const borrowers = buildSide(sides.borrow, loanDecimals);
  const collateralOwners = collateralAsset
    ? buildSide(sides.collateral, collateralAsset.decimals)
    : null;
  if (!owners && !borrowers && !collateralOwners) return null;

  const underlying = loanAsset.address.toLowerCase() as Address;
  const lenderKey = `${LENDER_KEY}_${market.marketId.slice(2).toUpperCase()}`;
  const ownership: MarketOwnership = {
    marketUid: makeMarketUid(lenderKey, chainId, underlying),
    lenderKey,
    chainId,
    underlying,
    totalSupply: toHuman(toBigInt(market.state.supplyAssets), loanDecimals),
    owners: owners ?? {},
    totalBorrow: toHuman(toBigInt(market.state.borrowAssets), loanDecimals),
  };
  if (borrowers) ownership.borrowers = borrowers;
  if (collateralAsset) {
    ownership.collateralToken = collateralAsset.address.toLowerCase() as Address;
    ownership.totalCollateral = toHuman(
      toBigInt(market.state.collateralAssets),
      collateralAsset.decimals,
    );
    if (collateralOwners) ownership.collateralOwners = collateralOwners;
  }
  return ownership;
}

// ── Factory ───────────────────────────────────────────────────────────────────

export function createMorphoBlueFetcher(
  config: MorphoBlueConfig = {},
): OwnershipFetcher {
  const url = config.apiUrl ?? MORPHO_API_URL;
  const pageSize = Math.min(
    Math.max(config.pageSize ?? MAX_PAGE_SIZE, 1),
    MAX_PAGE_SIZE,
  );
  const concurrency = Math.max(config.concurrency ?? DEFAULT_CONCURRENCY, 1);
  const minOwnerFraction =
    config.minOwnerFraction ?? OWNER_FRACTION_BY_LENDER[LENDER_KEY] ?? 0.01;
  const minOwnerFractionPpm = BigInt(Math.round(minOwnerFraction * 1e6));
  // At most `1 / fraction` owners can clear the threshold; a little headroom
  // covers ties right at the boundary.
  const ownersPerSide = Math.min(
    MAX_PAGE_SIZE,
    Math.ceil(1 / Math.max(minOwnerFraction, 1e-6)) + 10,
  );
  const sidesPerBatch = Math.max(
    1,
    Math.floor(COMPLEXITY_BUDGET / (COMPLEXITY_PER_ITEM * ownersPerSide)),
  );

  return {
    lenderKey: LENDER_KEY,
    supportedChainIds: KNOWN_CHAIN_IDS,

    async fetch(ctx?: FetcherContext): Promise<OwnershipSnapshot> {
      if (!config.skipMetadataInit) {
        await fetchLenderMetaFromDirAndInitialize({ morphoPools: true });
      }

      const pools = morphoPools() ?? {};
      const deployedChains = new Set(Object.keys(pools[SDK_PROTOCOL_KEY] ?? {}));
      const requested = ctx?.chainIds ? new Set(ctx.chainIds.map(String)) : null;
      const client = new ApiClient(url, concurrency, ctx?.signal);

      const snapshot: OwnershipSnapshot = {
        lenderKey: LENDER_KEY,
        fetchedAt: new Date().toISOString(),
        markets: {},
        chainFreshness: {},
        failedChains: [],
      };

      const { chains } = await client.query<{ chains: RawChain[] }>(
        CHAINS_QUERY,
        {},
      );
      const adapters = await fetchAdapterMap(client, pageSize);

      for (const chain of chains) {
        const key = String(chain.id);
        if (deployedChains.size > 0 && !deployedChains.has(key)) continue;
        if (requested && !requested.has(key)) continue;
        const chainId = key as ChainId;

        try {
          if (chain.headBlock) {
            const freshness = await checkIndexedBlockFreshness(
              LENDER_KEY,
              "morpho-api",
              chain.headBlock.number,
              chainId,
              ctx?.signal,
            );
            if (freshness) snapshot.chainFreshness![chainId] = freshness;
          }

          const markets = await fetchAllPages<RawMarket>(
            client,
            `chain ${chainId} markets`,
            MARKETS_QUERY,
            { chainId: chain.id },
            (d: { markets: Paginated<RawMarket> }) => d.markets,
            pageSize,
          );

          // Per market, ask only for owners already above its own threshold.
          const byMarket = new Map<string, RawMarket>();
          const sideBalances = new Map<
            string,
            Record<Side, Map<Address, bigint>>
          >();
          const requests: SideRequest[] = [];
          for (const market of markets) {
            if (!market.state || !market.loanAsset) continue;
            if (!MARKET_ID_RE.test(market.marketId)) continue;
            const totals: Record<Side, bigint> = {
              supply: toBigInt(market.state.supplyShares),
              borrow: toBigInt(market.state.borrowShares),
              collateral: toBigInt(market.state.collateralAssets),
            };
            if (totals.supply <= 0n && totals.collateral <= 0n) continue;
            const marketId = market.marketId.toLowerCase();
            byMarket.set(marketId, market);
            sideBalances.set(marketId, {
              supply: new Map(),
              borrow: new Map(),
              collateral: new Map(),
            });
            for (const side of SIDES) {
              if (totals[side] <= 0n) continue;
              const threshold = (totals[side] * minOwnerFractionPpm) / 1_000_000n;
              requests.push({
                marketId: market.marketId,
                side,
                minFilterValue: threshold > 0n ? threshold : 1n,
              });
            }
          }
          if (byMarket.size === 0) continue;

          const batches: SideRequest[][] = [];
          for (let i = 0; i < requests.length; i += sidesPerBatch) {
            batches.push(requests.slice(i, i + sidesPerBatch));
          }
          console.log(
            `[${LENDER_KEY}] chain ${chainId}: ${byMarket.size} markets, ${requests.length} sides in ${batches.length} requests`,
          );

          await Promise.all(
            batches.map(async (batch) => {
              const data = await client.query<
                Record<string, { items: RawPosition[] | null }>
              >(buildSideBatchQuery(batch, chain.id, ownersPerSide), {});
              batch.forEach((req, i) => {
                const balances = sideBalances.get(req.marketId.toLowerCase());
                if (!balances) return;
                for (const item of data[`s${i}`]?.items ?? []) {
                  const raw = item.user?.address?.toLowerCase();
                  if (!raw || !item.state) continue;
                  // Aggregate under the parent vault: two adapters of the same
                  // vault in one market must not appear as two owners.
                  const owner = (adapters.get(adapterKey(chain.id, raw)) ??
                    raw) as Address;
                  const amount = toBigInt(
                    req.side === "supply"
                      ? item.state.supplyAssets
                      : req.side === "borrow"
                        ? item.state.borrowAssets
                        : item.state.collateral,
                  );
                  if (amount <= 0n) continue;
                  const target = balances[req.side];
                  target.set(owner, (target.get(owner) ?? 0n) + amount);
                }
              });
            }),
          );

          for (const [marketId, market] of byMarket) {
            const ownership = buildMarketOwnership(
              market,
              sideBalances.get(marketId)!,
              chainId,
            );
            if (ownership) snapshot.markets[ownership.marketUid] = ownership;
          }
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] chain ${chainId} skipped: ${(err as Error).message}`,
          );
          snapshot.failedChains!.push(chainId);
        }
      }

      return snapshot;
    },
  };
}
