import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  mapWithConcurrency,
} from "@lending-owners/core";

const LENDER_KEY = "AAVE_V3";
const API = "https://api.v3.aave.com/graphql";

/**
 * Aave's own API. Rates only — no totals and, crucially, **no liquidityIndex**,
 * so the accumulator for Aave still comes from archival
 * `getReserveNormalizedIncome`. `LAST_YEAR` is the widest window the enum
 * offers (DAY/WEEK/MONTH/SIX_MONTHS/YEAR) and returns 365 daily averages.
 *
 * Only canonical Aave deployments are served here; the ~100 Aave forks are not
 * on this API and fall to archival replay.
 */
const WINDOWS = [
  { name: "LAST_YEAR", days: 365 },
  { name: "LAST_SIX_MONTHS", days: 182 },
  { name: "LAST_MONTH", days: 30 },
  { name: "LAST_WEEK", days: 7 },
] as const;

interface RateSample {
  avgRate: { value: string } | null;
  date: string;
}

interface Reserve {
  chainId: number;
  market: string;
  underlyingToken: string;
  symbol: string;
}

export interface AaveV3HistoryConfig {
  /** Reserves from `data/AAVE_V3.json`. With an explicit chain list the API's
   *  own `markets` listing is the roster and this is only the fallback — see
   *  `resolveReserves`. */
  reserves: Reserve[];
  concurrency?: number;
}

const HISTORY_QUERY = `query($market: EvmAddress!, $chainId: Int!, $token: EvmAddress!, $window: TimeWindow!) {
  supply: supplyAPYHistory(request: { market: $market, chainId: $chainId, underlyingToken: $token, window: $window }) {
    avgRate { value }
    date
  }
  borrow: borrowAPYHistory(request: { market: $market, chainId: $chainId, underlyingToken: $token, window: $window }) {
    avgRate { value }
    date
  }
}`;

function windowFor(days: number): (typeof WINDOWS)[number]["name"] {
  for (let i = WINDOWS.length - 1; i >= 0; i -= 1) {
    if (days <= WINDOWS[i]!.days) return WINDOWS[i]!.name;
  }
  return "LAST_YEAR";
}


/**
 * Every (market, chainId, underlyingToken) triple the run should ask about.
 *
 * `data/AAVE_V3.json` only lists the chains the ownership runner has been
 * pointed at — four of them on 2026-09-14 — while our lending book carries
 * Aave V3 on a dozen more (Base, Plasma, Linea, Gnosis, Sonic, Celo, Ink,
 * X Layer …). The plan's note that the Aave API "has no listing endpoint" is
 * out of date: `markets(request:{chainIds})` returns every pool with its
 * reserves, and it also carries the pool address, which the hand-kept
 * `POOL_BY_CHAIN` had WRONG for Linea. So the API is the roster and the file
 * is the fallback for when the API is down — never the other way round.
 */
const MARKETS_QUERY = `query($chainIds: [ChainId!]!) {
  markets(request: { chainIds: $chainIds }) {
    address
    chain { chainId }
    reserves { underlyingToken { address symbol } }
  }
}`;

interface MarketsResponse {
  markets: Array<{
    address: string;
    chain: { chainId: number };
    reserves: Array<{ underlyingToken: { address: string; symbol: string } }>;
  }>;
}

async function resolveReserves(
  client: PacedClient,
  fromFile: Reserve[],
  chainIds: ChainId[] | undefined,
): Promise<Reserve[]> {
  const wanted = chainIds?.map(Number);
  const fileReserves = fromFile.filter((r) => !wanted || wanted.includes(Number(r.chainId)));
  // Without an explicit chain list the file defines the scope, as before.
  if (!wanted) return fileReserves;

  let discovered: Reserve[] = [];
  try {
    const data = await client.graphql<MarketsResponse>(API, MARKETS_QUERY, { chainIds: wanted });
    for (const m of data.markets ?? []) {
      for (const r of m.reserves ?? []) {
        discovered.push({
          chainId: Number(m.chain.chainId),
          market: m.address,
          underlyingToken: r.underlyingToken.address,
          symbol: r.underlyingToken.symbol,
        });
      }
    }
  } catch (err) {
    console.warn(
      `[${LENDER_KEY}] markets listing failed (${(err as Error).message}); ` +
        `falling back to data/AAVE_V3.json (${fileReserves.length} reserves)`,
    );
    return fileReserves;
  }

  // API first, file for anything the API did not mention.
  const seen = new Set(discovered.map((r) => `${r.chainId}:${r.underlyingToken.toLowerCase()}`));
  for (const r of fileReserves) {
    const k = `${r.chainId}:${r.underlyingToken.toLowerCase()}`;
    if (!seen.has(k)) {
      seen.add(k);
      discovered.push(r);
    }
  }
  const missing = wanted.filter((c) => !discovered.some((r) => Number(r.chainId) === c));
  console.log(
    `[${LENDER_KEY}] ${discovered.length} reserves on ${wanted.length - missing.length} chain(s) via the API` +
      (missing.length ? ` — no Aave V3 market on: ${missing.join(",")}` : ""),
  );
  return discovered;
}

export function createAaveV3HistoryFetcher(config: AaveV3HistoryConfig): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "aave-api",
    earliest: (now) => new Date(now.getTime() - 365 * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (!ctx.resolveUid) throw new Error(`[${LENDER_KEY}] needs a uid resolver`);
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 150,
        signal: ctx.signal,
      });

      const days = Math.ceil((ctx.to.getTime() - ctx.from.getTime()) / 86_400_000);
      const window = windowFor(days);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const reserves = await resolveReserves(client, config.reserves, ctx.chainIds);

      let done = 0;
      let unresolved = 0;
      const results = await mapWithConcurrency(reserves, config.concurrency ?? 4, async (r) => {
        try {
          const data = await client.graphql<{ supply: RateSample[]; borrow: RateSample[] }>(
            API,
            HISTORY_QUERY,
            {
              market: r.market,
              chainId: Number(r.chainId),
              token: r.underlyingToken,
              window,
            },
          );
          return { reserve: r, supply: data.supply ?? [], borrow: data.borrow ?? [] };
        } catch (err) {
          console.warn(`[${LENDER_KEY}] ${r.symbol} @${r.chainId}: ${(err as Error).message}`);
          return { reserve: r, supply: [] as RateSample[], borrow: [] as RateSample[] };
        } finally {
          done += 1;
          ctx.onProgress?.(done, reserves.length, LENDER_KEY);
        }
      });

      for (const { reserve, supply, borrow } of results) {
        const chainId = String(reserve.chainId) as ChainId;
        // Aave is the one family whose uid leaf IS the underlying.
        const marketUid = ctx.resolveUid(chainId, reserve.underlyingToken);
        if (!marketUid) {
          unresolved += 1;
          continue;
        }
        const borrowByDate = new Map(borrow.map((b) => [b.date, b.avgRate?.value]));
        for (const s of supply) {
          const tsMs = Date.parse(s.date);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const sup = s.avgRate?.value;
          const bor = borrowByDate.get(s.date);
          // Aave returns FRACTIONS (0.0369 = 3.69 %); the contract is percent.
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId,
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "aave-api",
            depositRate: sup == null ? undefined : Number(sup) * 100,
            variableBorrowRate: bor == null ? undefined : Number(bor) * 100,
          };
        }
      }
      if (unresolved > 0) {
        console.warn(`[${LENDER_KEY}] ${unresolved} reserve(s) not in the book — skipped`);
      }
    },
  };
}
