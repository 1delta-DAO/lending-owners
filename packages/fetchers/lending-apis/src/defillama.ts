import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  type LenderKey,
  PacedClient,
  bucketStart,
} from "@lending-owners/core";

/**
 * DefiLlama's yield charts as a LENDING history source, for the families that
 * have no first-party history API — the Aave and Compound forks, Dolomite,
 * Curvance, Neverland, Takara, Benqi, Kinetic, HyperLend, HypurrFi, xLend.
 *
 * ── What it gives, and what it does not ─────────────────────────────────────
 * `GET yields.llama.fi/chart/{pool}` → one point per day: `apyBase` (the
 * supply APY without incentives, PERCENT), `apy` (with incentives), `tvlUsd`.
 * That is the SUPPLY side only. The borrow side lives behind
 * `/chartLendBorrow/{pool}`, which answers HTTP 402 without a paid key
 * (plan §0.3, re-confirmed) — so `variableBorrowRate` is never emitted here,
 * and a fork's borrow history stays a gap until it gets a real source.
 * Daily, not hourly: Llama samples once a day around 23:00 UTC.
 *
 * `depositRate` is `apyBase` when present and `apy` otherwise. Where our live
 * fetcher separates base rate from rewards (Aave forks do), `apyBase` is the
 * like-for-like figure; the fallback to `apy` is for adapters that report
 * only a blended number, and is the lesser evil against no point at all.
 * `totalDepositsUsd` is `tvlUsd` — on a lending pool that is supplied TVL,
 * the same quantity the live fetcher stores.
 *
 * ── How a pool finds its market ─────────────────────────────────────────────
 * A Llama pool knows its chain, its project and `underlyingTokens[0]`. Our
 * uid leaf is whatever the protocol calls the market — the qToken for a
 * Compound-V2 fork, a numeric market id for Dolomite, the reserve id for Aave
 * V4 — so the leaf resolver would find nothing. This fetcher declares
 * `resolveBy: "underlying"` and the runner resolves through the book's
 * `underlying` column, scoped to the family, requiring a UNIQUE hit. A family
 * with two markets on the same asset on one chain (isolated silos, Fluid
 * vaults) resolves to nothing and is counted, never guessed.
 *
 * One fetcher instance per family, so each writes its own `<FAMILY>/` tree
 * and the coverage report reads per family, as for every other module.
 */

const POOLS_URL = "https://yields.llama.fi/pools";
const CHART_URL = "https://yields.llama.fi/chart";

/** Llama's chain names for the chains our book covers. Anything else is
 *  ignored — a project on a chain we do not list is not a gap of ours. */
const CHAIN_BY_LLAMA_NAME: Record<string, ChainId> = {
  Ethereum: "1",
  "OP Mainnet": "10",
  Optimism: "10",
  Flare: "14",
  Cronos: "25",
  XDC: "50",
  BSC: "56",
  Gnosis: "100",
  Unichain: "130",
  Polygon: "137",
  Monad: "143",
  Sonic: "146",
  "X Layer": "196",
  "zkSync Era": "324",
  PulseChain: "369",
  "Hyperliquid L1": "999",
  Metis: "1088",
  CORE: "1116",
  Lisk: "1135",
  Sei: "1329",
  Soneium: "1868",
  MegaETH: "4326",
  Mantle: "5000",
  Kaia: "8217",
  Base: "8453",
  Plasma: "9745",
  Mode: "34443",
  Arbitrum: "42161",
  Celo: "42220",
  Etherlink: "42793",
  Hemi: "43111",
  Avalanche: "43114",
  Ink: "57073",
  Linea: "59144",
  Bob: "60808",
  Berachain: "80094",
  Blast: "81457",
  "Plume Mainnet": "98866",
  Taiko: "167000",
  Scroll: "534352",
  Katana: "747474",
} as unknown as Record<string, ChainId>;

interface LlamaPool {
  pool: string;
  chain: string;
  project: string;
  symbol?: string;
  category?: string;
  underlyingTokens?: string[] | null;
  tvlUsd?: number | null;
}

interface ChartResponse {
  status?: string;
  data?: Array<{
    timestamp: string; // ISO, ~23:01 UTC
    tvlUsd?: number | null;
    apy?: number | null; // percent
    apyBase?: number | null;
    apyReward?: number | null;
  }>;
}

export interface DefiLlamaLendingConfig {
  /** Our lender family — the uid prefix and the output directory. */
  family: string;
  /** Llama `project` slugs that ARE this family. */
  projects: string[];
  /** Restrict to these chains (default: every chain the pools list names). */
  chainIds?: ChainId[];
  concurrency?: number;
}

/** The pools list is 11 MB; one fetch per process serves every family. */
let poolsCache: Promise<LlamaPool[]> | undefined;
function loadPools(client: PacedClient): Promise<LlamaPool[]> {
  if (!poolsCache) {
    poolsCache = client
      .getJson<{ data?: LlamaPool[] }>(POOLS_URL)
      .then((r) => r.data ?? [])
      .catch((err) => {
        poolsCache = undefined;
        throw err;
      });
  }
  return poolsCache;
}

export function createDefiLlamaLendingHistoryFetcher(
  config: DefiLlamaLendingConfig,
): HistoryFetcher {
  const family = config.family.toUpperCase();
  return {
    lenderKey: family as LenderKey,
    source: "defillama-api",
    resolveBy: "underlying",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (!ctx.resolveUid) throw new Error(`[${family}] needs a uid resolver`);
      const client = new PacedClient({
        label: family,
        concurrency: config.concurrency ?? 2,
        minIntervalMs: 250,
        signal: ctx.signal,
      });

      const projects = new Set(config.projects);
      const pools = (await loadPools(client)).filter((p) => {
        if (!projects.has(p.project)) return false;
        const chainId = CHAIN_BY_LLAMA_NAME[p.chain];
        if (!chainId) return false;
        if (config.chainIds && !config.chainIds.includes(chainId)) return false;
        if (ctx.chainIds && !ctx.chainIds.includes(chainId)) return false;
        return true;
      });

      // Resolve first, fetch second: a pool with no market in the book costs
      // nothing, and the unresolved count is the honest coverage number.
      // `MarketUid` is a template-literal union over every chain id; typing the
      // array element with it overflows the checker, so it is held as string.
      const targets: Array<{ pool: LlamaPool; chainId: ChainId; marketUid: string }> = [];
      const unresolved: string[] = [];
      for (const pool of pools) {
        const chainId = CHAIN_BY_LLAMA_NAME[pool.chain]!;
        const underlying = pool.underlyingTokens?.[0];
        // Written as statements: a conditional over `MarketUid | undefined`
        // overflows TypeScript's union-size limit (see registry.ts).
        let uid: string | undefined;
        if (underlying) uid = ctx.resolveUid(chainId, underlying) as string | undefined;
        if (!uid) {
          unresolved.push(`${pool.chain}:${pool.symbol ?? pool.pool}`);
          continue;
        }
        targets.push({ pool, chainId, marketUid: uid });
      }
      console.log(
        `[${family}] ${targets.length}/${pools.length} Llama pool(s) resolve to a market` +
          (unresolved.length
            ? ` — unresolved: ${unresolved.slice(0, 8).join(", ")}${unresolved.length > 8 ? " …" : ""}`
            : ""),
      );

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;
      for (const { pool, chainId, marketUid } of targets) {
        done += 1;
        let rows: NonNullable<ChartResponse["data"]> = [];
        try {
          rows = (await client.getJson<ChartResponse>(`${CHART_URL}/${pool.pool}`)).data ?? [];
        } catch (err) {
          console.warn(`[${family}] ${pool.chain}:${pool.symbol} (${pool.pool}): ${(err as Error).message}`);
          continue;
        } finally {
          ctx.onProgress?.(done, targets.length, `${family} ${pool.chain}:${pool.symbol ?? ""}`);
        }

        // Daily samples; keep the LAST per bucket so a `1h` run gets the one
        // hour Llama actually sampled rather than 24 copies of it.
        const byBucket = new Map<number, (typeof rows)[number]>();
        for (const r of rows) {
          const tsMs = Date.parse(r.timestamp);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const bucket = bucketStart(tsMs, ctx.resolution).getTime();
          const prev = byBucket.get(bucket);
          if (!prev || tsMs >= Date.parse(prev.timestamp)) byBucket.set(bucket, r);
        }
        for (const [bucket, r] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          const rate = r.apyBase ?? r.apy;
          const tvl = r.tvlUsd;
          if (rate == null && tvl == null) continue;
          yield {
            marketUid: marketUid as HistoryPoint["marketUid"],
            lenderKey: family as LenderKey,
            chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(Date.parse(r.timestamp)).toISOString(),
            source: "defillama-api",
            depositRate: rate == null ? undefined : Number(rate),
            totalDepositsUsd: tvl == null ? undefined : Number(tvl),
          };
        }
      }
    },
  };
}
