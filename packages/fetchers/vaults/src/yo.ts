import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { num } from "./shared.js";

/**
 * YO Protocol — APR_BACKFILL.md "yoETH (YO)" row. Half DECAYING.
 *
 * Two routes with very different depths, which is the whole point of the row:
 *  - `/vault/yield/timeseries/{network}/{vault}` is a FIXED 30-day window; its
 *    range params are ignored, so the APY tail is lost every day it is not
 *    captured.
 *  - `/vault/tvl/timeseries/{network}/{vault}` is full-depth (verified back to
 *    2025-02-04), so TVL needs no ratchet.
 *
 * Both are merged into one series here: the TVL points carry the history, and a
 * yield value is attached wherever the two land in the same bucket. Emitting
 * them as two sources would double the rows for one measurement.
 *
 * The roster is fetched, not pinned — `/vault/stats` lists every live vault
 * with its chain and share-token address, which is exactly the uid leaf.
 *
 * Units: `yield` is already PERCENT (2.46 = 2.46 %); `tvl` is asset units and
 * `tvlUsd` is USD.
 */

const LENDER_KEY = "VAULT_YO";
const API = "https://api.yo.xyz/api/v1";

/** What the yield route serves regardless of parameters. */
export const YO_YIELD_RETENTION_DAYS = 30;

interface StatsResponse {
  data?: Array<{
    id?: string;
    chain?: { id?: number; name?: string };
    shareAsset?: { address?: string };
  }>;
}
interface YieldResponse {
  data?: Array<{ timestamp: number; yield: string }>;
}
interface TvlResponse {
  data?: Array<{ timestamp: number; tvl: string; tvlUsd: string }>;
}

export function createYoVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "yo-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const stats = await client.getJson<StatsResponse>(`${API}/vault/stats`);
      const vaults = (stats.data ?? []).flatMap((v) => {
        const address = v.shareAsset?.address;
        const chainId = v.chain?.id;
        const network = v.chain?.name;
        if (!address || chainId === undefined || !network) return [];
        return [{ id: v.id ?? address, address, chainId: String(chainId) as ChainId, network }];
      });

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const vault of vaults) {
        done += 1;
        if (ctx.chainIds && !ctx.chainIds.includes(vault.chainId)) continue;
        const path = `${vault.network}/${vault.address}`;

        // A vault too young for one of the routes answers with an empty array
        // rather than an error, so both are optional and neither aborts.
        const [tvl, yields] = await Promise.all([
          client.getJson<TvlResponse>(`${API}/vault/tvl/timeseries/${path}`).catch(() => ({}) as TvlResponse),
          client
            .getJson<YieldResponse>(`${API}/vault/yield/timeseries/${path}`)
            .catch(() => ({}) as YieldResponse),
        ]);

        const yieldByBucket = new Map<number, number>();
        for (const row of yields.data ?? []) {
          const tsMs = Number(row.timestamp);
          const apy = num(row.yield);
          if (!Number.isFinite(tsMs) || apy === undefined) continue;
          yieldByBucket.set(bucketStart(tsMs, ctx.resolution).getTime(), apy);
        }

        const marketUid = makeMarketUid(LENDER_KEY, vault.chainId, vault.address);
        const seen = new Set<number>();
        for (const row of tvl.data ?? []) {
          const tsMs = Number(row.timestamp);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const bucket = bucketStart(tsMs, ctx.resolution).getTime();
          if (seen.has(bucket)) continue;
          seen.add(bucket);

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: vault.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "yo-api",
            depositRate: yieldByBucket.get(bucket), // already percent
            totalDeposits: num(row.tvl),
            totalDepositsUsd: num(row.tvlUsd),
          };
        }

        // A yield point outside the TVL series' reach would otherwise be
        // dropped — the 30-day window is the part that cannot be recovered.
        for (const [bucket, apy] of yieldByBucket) {
          if (seen.has(bucket) || bucket < from || bucket > to) continue;
          seen.add(bucket);
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: vault.chainId,
            dataTs: new Date(bucket).toISOString(),
            source: "yo-api",
            depositRate: apy,
          };
        }
        ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${vault.id}`);
      }
    },
  };
}
