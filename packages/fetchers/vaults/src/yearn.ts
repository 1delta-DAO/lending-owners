import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  type HistoryResolution,
  PacedClient,
  bucketStart,
  makeMarketUid,
  mapWithConcurrency,
} from "@lending-owners/core";
import { decimalString, fractionToPercent, num } from "./shared.js";

/**
 * Yearn V3 vaults — HISTORY_APIS.md "yearn" row.
 *
 * Roster from yDaemon (`https://ydaemon.yearn.fi/{chainId}/vaults/all`, the
 * route margin-fetcher's `vaults/yearn/api.ts` already reads), filtered the
 * same way: **V3 + endorsed** only. yDaemon has no history — that lives in
 * Kong GraphQL (`POST kong.yearn.farm/api/gql`), `timeseries(chainId,
 * address, label, component, period, limit, timestamp) { time value }`.
 *
 * Live-pinned (2026-08-25):
 *  - `time` is a STRING of unix seconds; `value` a JSON number. Order is
 *    ALWAYS oldest-first (no DESC), `limit` caps at 1000 → page forward via
 *    the `timestamp` arg. The arg is FLOORED to the period bucket (a cursor
 *    of last+1 returns the last row again), so the next cursor is
 *    `lastTime + bucketSeconds`.
 *  - APY label is **`apy-bwd-delta-pps`** with `component: "net"` — the
 *    obvious `label: "apy"` silently returns `[]`. Values are FRACTIONS →
 *    percent here.
 *  - pps is `label: "pps", component: "humanized"` → assets-per-share.
 *  - TVL answered cleanly on the probe as `label: "tvl-c",
 *    component: "tvl"` (USD; without `component` the same stamp repeats
 *    across five components) → included.
 *  - period strings are exact, space included: '1 hour', '1 day', … —
 *    hourly buckets exist but are sparse (aligned to where samples are).
 */

const LENDER_KEY = "VAULT_YEARN";
const YDAEMON = "https://ydaemon.yearn.fi";
const KONG = "https://kong.yearn.farm/api/gql";
const PAGE = 1000; // Kong's hard cap; a full page means "more to fetch"

/** Chains with endorsed V3 vaults indexed by yDaemon — mirrored from
 *  margin-fetcher's `YEARN_CHAIN_IDS` (verified there against live yDaemon;
 *  requesting others is a wasted round-trip). */
const YEARN_CHAIN_IDS: ChainId[] = [
  "1", // Ethereum
  "137", // Polygon
  "8453", // Base
  "42161", // Arbitrum
  "100", // Gnosis
  "146", // Sonic
  "747474", // Katana
] as ChainId[];

/** yDaemon page size. Verified in margin-fetcher: `limit >= 1000` returns the
 *  whole roster in one page (Ethereum, the largest chain, is 574 rows), and
 *  smaller limits OVERLAP between pages, silently dropping vaults. */
const ROSTER_LIMIT = 2000;

/** Vaults whose yDaemon USD TVL is at or below this are skipped. The chains
 *  above carry ~284 endorsed V3 vaults of which ~90 hold $0 — mostly retired
 *  or never-seeded strategies whose Kong series are flat padding. The cutoff
 *  keeps the run at ~190 vaults × 3 paged series; raise it if the roster
 *  grows past what a daily run tolerates. */
const MIN_TVL_USD = 0;

interface YDaemonVault {
  address: string | null;
  version: string | null;
  endorsed: boolean | null;
  symbol: string | null;
  tvl: { tvl: number | null } | null;
}

interface KongPoint {
  time: string; // unix seconds as a string
  value: number | null;
}

type SeriesField = "apy" | "pps" | "tvlUsd";

const SERIES: Array<{ field: SeriesField; label: string; component: string }> = [
  { field: "apy", label: "apy-bwd-delta-pps", component: "net" },
  { field: "pps", label: "pps", component: "humanized" },
  { field: "tvlUsd", label: "tvl-c", component: "tvl" },
];

const PERIOD: Record<HistoryResolution, { name: string; seconds: number }> = {
  "1h": { name: "1 hour", seconds: 3_600 },
  "1d": { name: "1 day", seconds: 86_400 },
};

export interface YearnVaultHistoryConfig {
  concurrency?: number;
}

export function createYearnVaultHistoryFetcher(
  config: YearnVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "yearn-kong",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 150,
        signal: ctx.signal,
      });

      const chains = YEARN_CHAIN_IDS.filter(
        (c) => !ctx.chainIds || ctx.chainIds.includes(c),
      );

      // ── roster ────────────────────────────────────────────────────────────
      const vaults: Array<{ chainId: ChainId; address: string; symbol: string }> = [];
      for (const chainId of chains) {
        try {
          // One page at ROSTER_LIMIT is the verified-complete read; a chain
          // outgrowing it would need margin-fetcher's paging loop (whose
          // page-past-the-end answer is an EMPTY 200 body, which getJson
          // cannot parse — another reason not to page speculatively).
          const items = await client.getJson<YDaemonVault[]>(
            `${YDAEMON}/${chainId}/vaults/all?limit=${ROSTER_LIMIT}&page=1`,
          );
          if (!Array.isArray(items)) continue;
          const seen = new Set<string>();
          for (const v of items) {
            const address = (v.address ?? "").toLowerCase();
            if (!address || seen.has(address)) continue;
            if (!v.version?.startsWith("3.") || !v.endorsed) continue;
            if ((v.tvl?.tvl ?? 0) <= MIN_TVL_USD) continue;
            seen.add(address);
            vaults.push({ chainId, address, symbol: v.symbol ?? address });
          }
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] roster chain ${chainId} skipped: ${(err as Error).message}`,
          );
        }
      }

      const period = PERIOD[ctx.resolution];
      const fromSec = Math.floor(ctx.from.getTime() / 1000);
      const toSec = Math.ceil(ctx.to.getTime() / 1000);
      let done = 0;

      /** All three series for one vault, paging each label forward until it
       *  answers a short page. The first request batches all three as
       *  aliases; only labels that filled their page are re-requested. */
      const fetchVaultSeries = async (v: {
        chainId: ChainId;
        address: string;
      }): Promise<Record<SeriesField, KongPoint[]>> => {
        const out: Record<SeriesField, KongPoint[]> = { apy: [], pps: [], tvlUsd: [] };
        let active = SERIES.map((s) => ({ ...s, cursor: fromSec }));
        // 40 pages ≈ 110 years of dailies — a loop guard, not a real bound.
        for (let page = 0; page < 40 && active.length > 0; page += 1) {
          const query = `query { ${active
            .map(
              (s) =>
                `${s.field}: timeseries(chainId: ${Number(v.chainId)}, address: "${v.address}", ` +
                `label: "${s.label}", component: "${s.component}", period: "${period.name}", ` +
                `limit: ${PAGE}, timestamp: ${s.cursor}) { time value }`,
            )
            .join(" ")} }`;
          const data = await client.graphql<Partial<Record<SeriesField, KongPoint[]>>>(
            KONG,
            query,
          );
          const next: typeof active = [];
          for (const s of active) {
            const rows = data[s.field] ?? [];
            // The cursor floors to its bucket, so the previous page's last
            // row can come back again — drop anything not strictly newer.
            const lastSeen = out[s.field].at(-1)?.time;
            const fresh = rows.filter((r) => lastSeen === undefined || r.time > lastSeen);
            out[s.field].push(...fresh);
            const last = rows.at(-1);
            if (rows.length === PAGE && last && Number(last.time) < toSec) {
              next.push({ ...s, cursor: Number(last.time) + period.seconds });
            }
          }
          active = next;
        }
        return out;
      };

      const results = await mapWithConcurrency(vaults, config.concurrency ?? 4, async (v) => {
        try {
          return { v, series: await fetchVaultSeries(v) };
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] ${v.chainId}:${v.address} skipped: ${(err as Error).message}`,
          );
          return { v, series: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${v.symbol}`);
        }
      });

      const fromMs = ctx.from.getTime();
      const toMs = ctx.to.getTime();

      for (const { v, series } of results) {
        if (!series) continue;
        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);

        // Merge the three oldest-first series on their (already bucket-
        // aligned) stamp.
        const byBucket = new Map<number, Partial<Record<SeriesField, number>>>();
        for (const s of SERIES) {
          for (const p of series[s.field]) {
            const tsMs = Number(p.time) * 1000;
            if (!Number.isFinite(tsMs) || tsMs < fromMs || tsMs > toMs) continue;
            const value = num(p.value);
            if (value === undefined) continue;
            const bucket = bucketStart(tsMs, ctx.resolution).getTime();
            const entry = byBucket.get(bucket) ?? {};
            entry[s.field] = value;
            byBucket.set(bucket, entry);
          }
        }

        for (const [bucket, entry] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          // pps is flat 1.0 and APY flat 0 before a vault's first accrual;
          // both are plausible real values, so nothing is filtered here —
          // collection stores what the source said.
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: new Date(bucket).toISOString(),
            source: "yearn-kong",
            depositRate: entry.apy !== undefined ? fractionToPercent(entry.apy) : undefined,
            totalDepositsUsd: entry.tvlUsd,
            supplyIndex: decimalString(entry.pps),
            indexKind: entry.pps !== undefined ? "assets_per_share" : undefined,
          };
        }
      }
    },
  };
}
