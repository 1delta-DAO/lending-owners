import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  type LenderKey,
  type MarketUid,
  PacedClient,
  bucketStart,
  mapWithConcurrency,
} from "@lending-owners/core";

/**
 * Aave V4 — `api.v4.aave.com/graphql`, the first-party history API. Both
 * sides, ~6-hourly inside `LAST_MONTH`, daily beyond it; free and keyless.
 *
 * The plan filed this as "unprobed — introspection disabled". Introspection
 * is only PARTIAL: `__type` answers for input objects and enums, and that was
 * enough to recover the shape live on 2026-09-15:
 *
 *   spokes(request:{ query:{ chainIds } })                        → spoke address, id
 *   reserves(request:{ query:{ spokeId }, filter: ALL, orderBy:{…} }) → id, onChainId
 *   supplyApyHistory / borrowApyHistory(request:{ reserve, window, includeRewards })
 *
 * `filter` is an ENUM (`SUPPLY|BORROW|COLLATERAL|ALL`), not an object — every
 * `filter: {}` attempt is rejected with a message that names the type but not
 * the kind. `ReserveId` decodes to `<chainId>::<spoke>::<onChainId>`, and our
 * uid is built from the same three parts:
 *
 *   AAVE_V4_<SPOKE, upper-hex, no 0x>:<chainId>:<onChainId>
 *
 * (verified against the prod book: `AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E9
 * 5900A3A56:43114:1` is BTC.b on the Avalanche "Main" spoke). Constructed, not
 * resolved: the leaf is a small integer shared by every spoke on the chain.
 *
 * Rates come back as FRACTIONS (`0.000983` = 0.098 %) with `includeRewards`
 * off — the base rate, which is what `lending_snapshots.deposit_rate` holds
 * for Aave V3 too. ×100 on the way out.
 */

const LENDER_KEY = "AAVE_V4" as LenderKey;
const API = "https://api.v4.aave.com/graphql";

/** Aave V4 deployments the book carries (COVERAGE.md 2026-09-11: 1, 10, 43114). */
const CHAINS: ChainId[] = ["1", "10", "43114"] as ChainId[];

/** Same enum as V3's API; the widest window the days need. */
const WINDOWS = [
  { name: "LAST_DAY", days: 1 },
  { name: "LAST_WEEK", days: 7 },
  { name: "LAST_MONTH", days: 31 },
  { name: "LAST_SIX_MONTHS", days: 183 },
  { name: "LAST_YEAR", days: 366 },
  { name: "ALL", days: Infinity },
] as const;

interface Spoke {
  id: string;
  address: string;
  chain: { chainId: number };
}
interface Reserve {
  id: string;
  onChainId: number | string;
}
interface RateSample {
  date: string;
  avgRate: { value: string } | null;
}

const SPOKES_QUERY = `query($chainIds: [Int!]!) {
  spokes(request: { query: { chainIds: $chainIds } }) { id address chain { chainId } }
}`;
const RESERVES_QUERY = `query($spokeId: SpokeId!) {
  reserves(request: { query: { spokeId: $spokeId }, filter: ALL, orderBy: { supplyApy: DESC } }) { id onChainId }
}`;
const HISTORY_QUERY = `query($reserve: ReserveId!, $window: TimeWindow!) {
  supply: supplyApyHistory(request: { reserve: $reserve, window: $window, includeRewards: false }) { date avgRate { value } }
  borrow: borrowApyHistory(request: { reserve: $reserve, window: $window, includeRewards: false }) { date avgRate { value } }
}`;

export interface AaveV4HistoryConfig {
  concurrency?: number;
}

export function createAaveV4HistoryFetcher(config: AaveV4HistoryConfig = {}): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "aave-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 150,
        signal: ctx.signal,
      });
      const chains = CHAINS.filter((c) => !ctx.chainIds || ctx.chainIds.includes(c));
      if (chains.length === 0) return;

      const { spokes } = await client.graphql<{ spokes: Spoke[] }>(API, SPOKES_QUERY, {
        chainIds: chains.map(Number),
      });

      const reserves: Array<{ chainId: ChainId; spoke: string; reserveId: string; onChainId: string }> = [];
      for (const s of spokes ?? []) {
        try {
          const r = await client.graphql<{ reserves: Reserve[] }>(API, RESERVES_QUERY, { spokeId: s.id });
          for (const x of r.reserves ?? []) {
            reserves.push({
              chainId: String(s.chain.chainId) as ChainId,
              spoke: s.address,
              reserveId: x.id,
              onChainId: String(x.onChainId),
            });
          }
        } catch (err) {
          console.warn(`[${LENDER_KEY}] spoke ${s.address}@${s.chain.chainId}: ${(err as Error).message}`);
        }
      }
      console.log(`[${LENDER_KEY}] ${reserves.length} reserves across ${spokes?.length ?? 0} spoke(s) on ${chains.join(",")}`);

      const days = Math.ceil((ctx.to.getTime() - ctx.from.getTime()) / 86_400_000);
      const window = (WINDOWS.find((w) => days <= w.days) ?? WINDOWS[WINDOWS.length - 1]!).name;
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      const results = await mapWithConcurrency(reserves, config.concurrency ?? 4, async (r) => {
        try {
          const data = await client.graphql<{ supply: RateSample[]; borrow: RateSample[] }>(
            API,
            HISTORY_QUERY,
            { reserve: r.reserveId, window },
          );
          return { r, supply: data.supply ?? [], borrow: data.borrow ?? [] };
        } catch (err) {
          console.warn(`[${LENDER_KEY}] reserve ${r.onChainId}@${r.spoke}: ${(err as Error).message}`);
          return { r, supply: [] as RateSample[], borrow: [] as RateSample[] };
        } finally {
          done += 1;
          ctx.onProgress?.(done, reserves.length, LENDER_KEY);
        }
      });

      for (const { r, supply, borrow } of results) {
        const lenderKey = `AAVE_V4_${r.spoke.slice(2).toUpperCase()}` as LenderKey;
        const marketUid = `${lenderKey}:${r.chainId}:${r.onChainId}` as MarketUid;
        // Merge the two series by sample date, then keep the LAST sample per
        // bucket — LAST_MONTH is 6-hourly, so a `1d` run collapses four.
        const byDate = new Map<string, { s?: string; b?: string }>();
        for (const x of supply) byDate.set(x.date, { ...byDate.get(x.date), s: x.avgRate?.value });
        for (const x of borrow) byDate.set(x.date, { ...byDate.get(x.date), b: x.avgRate?.value });
        const byBucket = new Map<number, { ts: number; s?: string; b?: string }>();
        for (const [date, v] of byDate) {
          const ts = Date.parse(date);
          if (!Number.isFinite(ts) || ts < from || ts > to) continue;
          const bucket = bucketStart(ts, ctx.resolution).getTime();
          const prev = byBucket.get(bucket);
          if (!prev || ts >= prev.ts) byBucket.set(bucket, { ts, ...v });
        }
        for (const [bucket, v] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          if (v.s == null && v.b == null) continue;
          yield {
            marketUid,
            lenderKey,
            chainId: r.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(v.ts).toISOString(),
            source: "aave-api",
            depositRate: v.s == null ? undefined : Number(v.s) * 100,
            variableBorrowRate: v.b == null ? undefined : Number(v.b) * 100,
          };
        }
      }
    },
  };
}
