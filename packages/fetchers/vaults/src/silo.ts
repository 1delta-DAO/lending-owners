import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  mapWithConcurrency,
} from "@lending-owners/core";
import { decimalString, num } from "./shared.js";

/**
 * Silo managed vaults — HISTORY_APIS.md "silo" row.
 *
 * `POST api-v3.silo.finance` (Ponder-style GraphQL, no auth). Roster from the
 * `vaults` root (the same one margin-fetcher's `vaults/silo/fetchPublic.ts`
 * reads — 14 vaults across the indexer's chains at pin time); series from
 * **`vaultTimeseriess`** — the double-s plural is real.
 *
 * Live-pinned (2026-08-25):
 *  - `timestamp` and `blockNumber` are STRINGS of integers; `timestamp_gte`/
 *    `_lte` filters are `BigInt` — an unquoted int literal is a
 *    GRAPHQL_VALIDATION_FAILED, pass them as quoted strings. `where.chainId`
 *    is a plain Int.
 *  - `apr` / `userApr` are PERCENT strings already (`"1.2923…"` on a vault
 *    the app shows at 1.29 %) — no scaling. `userApr` is the depositor's
 *    net-of-fee rate → `depositRate`; genuinely-`"0"` early rows are real
 *    (pre-first-deposit), not padding.
 *  - `assetRatio` is the share price as a decimal string — assets per share
 *    with the share/asset decimals offset baked in (a USDC vault reads
 *    ~1.039e-6 against 18-dec shares). Stored verbatim: the realized-return
 *    ratio is scale-free.
 *  - `totalAssets` is already human-scaled asset units; `totalAssetsUsd` a
 *    number.
 *  - Cadence: daily rows at UTC midnight forever, plus hourly rows for the
 *    trailing ~24 h only (not retained). For `1h` we serve what exists —
 *    hourly where the API kept it, the daily row's bucket otherwise — and
 *    never error. For `1d`, keeping the LAST row per bucket collapses the
 *    trailing hourly cluster into the day.
 *  - `limit` caps at exactly 1000 (1001 is an error) → forward-page with
 *    `timestamp_gte = last + 1`; `totalCount` exists but the short-page stop
 *    needs no second source of truth.
 */

const LENDER_KEY = "VAULT_SILO";
const API = "https://api-v3.silo.finance";
const PAGE = 1000; // hard cap — 1001 answers "Unexpected error"

/** Chains the Silo indexer covers — mirrored from margin-fetcher's
 *  `SILO_API_SUPPORTED_CHAIN_IDS` (note: Sonic is absent from the indexer). */
const SILO_CHAIN_IDS: ChainId[] = [
  "1", // Ethereum
  "42161", // Arbitrum
  "43114", // Avalanche
  "50", // XDC
  "1776", // Injective
] as ChainId[];

/** Indexer inception (Arbitrum, the earliest chain — chain 1 starts
 *  2025-06-06). Nothing before this exists on any chain. */
const INDEXER_INCEPTION = Date.parse("2025-05-09T00:00:00Z");

interface RosterItem {
  id: string;
  chainId: number;
  symbol?: string | null;
}

interface SeriesRow {
  timestamp: string;
  apr?: string | null;
  userApr?: string | null;
  totalAssets?: string | null;
  totalAssetsUsd?: number | null;
  assetRatio?: string | null;
  blockNumber?: string | null;
}

const ROSTER_QUERY = `query Roster($chainIds: [Int!]) {
  vaults(where: { chainId_in: $chainIds }, limit: ${PAGE}) {
    items { id chainId symbol }
    totalCount
  }
}`;

const SERIES_QUERY = `query Series($chainId: Int, $vaultId: String, $gte: BigInt, $lte: BigInt) {
  vaultTimeseriess(
    where: { chainId: $chainId, vaultId: $vaultId, timestamp_gte: $gte, timestamp_lte: $lte }
    orderBy: "timestamp"
    orderDirection: "asc"
    limit: ${PAGE}
  ) {
    items { timestamp apr userApr totalAssets totalAssetsUsd assetRatio blockNumber }
    totalCount
  }
}`;

export interface SiloVaultHistoryConfig {
  concurrency?: number;
}

export function createSiloVaultHistoryFetcher(
  config: SiloVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "silo-api",
    earliest: () => new Date(INDEXER_INCEPTION),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const chainIds = SILO_CHAIN_IDS.filter(
        (c) => !ctx.chainIds || ctx.chainIds.includes(c),
      );
      if (chainIds.length === 0) return;

      // ── roster — 14 vaults total at pin time, one page is the whole book ──
      const roster = await client.graphql<{
        vaults: { items: RosterItem[]; totalCount?: number };
      }>(API, ROSTER_QUERY, { chainIds: chainIds.map(Number) });
      const vaults = (roster.vaults.items ?? []).map((item) => ({
        chainId: String(item.chainId) as ChainId,
        address: item.id.toLowerCase(),
        symbol: item.symbol ?? item.id,
      }));

      const fromSec = Math.floor(ctx.from.getTime() / 1000);
      const toSec = Math.ceil(ctx.to.getTime() / 1000);
      let done = 0;

      const fetchRows = async (v: { chainId: ChainId; address: string }): Promise<SeriesRow[]> => {
        const out: SeriesRow[] = [];
        let cursor = fromSec;
        // Loop guard; real vault series are ≪ 40k rows.
        for (let page = 0; page < 40; page += 1) {
          const data = await client.graphql<{
            vaultTimeseriess: { items: SeriesRow[]; totalCount?: number };
          }>(API, SERIES_QUERY, {
            chainId: Number(v.chainId),
            vaultId: v.address,
            gte: String(cursor),
            lte: String(toSec),
          });
          const rows = data.vaultTimeseriess.items ?? [];
          out.push(...rows);
          if (rows.length < PAGE) break;
          const last = Number(rows.at(-1)!.timestamp);
          if (!Number.isFinite(last) || last >= toSec) break;
          cursor = last + 1;
        }
        return out;
      };

      const results = await mapWithConcurrency(vaults, config.concurrency ?? 3, async (v) => {
        try {
          return { v, rows: await fetchRows(v) };
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] ${v.chainId}:${v.address} skipped: ${(err as Error).message}`,
          );
          return { v, rows: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${v.symbol}`);
        }
      });

      for (const { v, rows } of results) {
        if (!rows || rows.length === 0) continue;
        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);

        // Ascending input; the LAST row per bucket wins (collapses the
        // trailing-24h hourly cluster into its day on 1d runs).
        const byBucket = new Map<number, SeriesRow & { tsMs: number }>();
        for (const row of rows) {
          const tsMs = Number(row.timestamp) * 1000;
          if (!Number.isFinite(tsMs)) continue;
          const bucket = bucketStart(tsMs, ctx.resolution).getTime();
          const prev = byBucket.get(bucket);
          if (!prev || prev.tsMs <= tsMs) byBucket.set(bucket, { ...row, tsMs });
        }

        for (const [bucket, row] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          const supplyIndex = decimalString(row.assetRatio);
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(row.tsMs).toISOString(),
            source: "silo-api",
            blockNumber: num(row.blockNumber),
            // Percent strings already — no scaling (header note).
            depositRate: num(row.userApr) ?? num(row.apr),
            totalDeposits: num(row.totalAssets),
            totalDepositsUsd: num(row.totalAssetsUsd),
            supplyIndex,
            indexKind: supplyIndex !== undefined ? "assets_per_share" : undefined,
          };
        }
      }
    },
  };
}
