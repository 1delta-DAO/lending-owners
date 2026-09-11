import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { decimalString, num } from "./shared.js";

/**
 * Venus Liquidity Hubs (BNB Chain) — the per-asset 4626 allocator vaults
 * margin-fetcher's `registryVenusHub.ts` added 2026-09-10. Found 2026-09-11 by
 * probing: the Hubs are absent from `api.venus.io/markets` (the lending
 * module's route answers `result: null` for a hub address) but have a route
 * family of their own:
 *
 *  - roster  `GET /liquidity-hub/hubs?chainId=56` — every Hub with its live
 *    state (pps, blended APY, TVL, fee dials, yield groups)
 *  - history `GET /liquidity-hub/hubs/{hub}/history?chainId=56&range=all` —
 *    daily rows `{blockTimestamp, blockNumber, supplyApy, totalSupplyCents,
 *    exchangeRateMantissa, pricePerShare}`, one per UTC day at 23:59:55.
 *
 * `range` is a whitelist: `1m`, `3m`, `1y`, `all`. `all` exists, so this is a
 * DURABLE source (inception-backfillable), not a ratchet — verified 35 points
 * back to 2026-08-07, the day after the first Hub took deposits.
 *
 * Units: `supplyApy` is already PERCENT ("2.03"). `totalSupplyCents` is USD in
 * cents → dollars here. `pricePerShare` is assets-per-share and is kept as the
 * accumulator; `exchangeRateMantissa` is the same number at 1e18 and is not
 * emitted twice.
 *
 * The roster is fetched, not pinned: `addYieldGroup`/new Hubs are ACM-gated
 * governance actions, and a pinned list would lag them silently.
 */

const LENDER_KEY = "VAULT_VENUS_HUB";
const CHAIN_ID = "56" as ChainId;
const API = "https://api.venus.io/liquidity-hub";

interface HubRow {
  hubAddress?: string;
  symbol?: string;
}
interface HubsResponse {
  result?: HubRow[];
}
interface HistoryRow {
  blockNumber?: string;
  blockTimestamp?: number; // unix seconds
  supplyApy?: string; // percent
  totalSupplyCents?: string;
  pricePerShare?: string;
}
interface HistoryResponse {
  result?: HistoryRow[];
}

export function createVenusHubVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "venus-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 250,
        signal: ctx.signal,
      });

      const roster = (await client.getJson<HubsResponse>(`${API}/hubs?chainId=${CHAIN_ID}`)).result ?? [];
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const hub of roster) {
        done += 1;
        const address = hub.hubAddress?.toLowerCase();
        if (!address) continue;
        const res = await client.getJson<HistoryResponse>(
          `${API}/hubs/${address}/history?chainId=${CHAIN_ID}&range=all`,
        );
        const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, address);

        for (const row of res.result ?? []) {
          const tsMs = Number(row.blockTimestamp) * 1000;
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const apy = num(row.supplyApy);
          const pps = num(row.pricePerShare);
          const cents = num(row.totalSupplyCents);
          if (apy === undefined && pps === undefined && cents === undefined) continue;

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: CHAIN_ID,
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "venus-api",
            blockNumber: row.blockNumber === undefined ? undefined : Number(row.blockNumber),
            depositRate: apy, // already percent
            totalDepositsUsd: cents === undefined ? undefined : cents / 100,
            supplyIndex: decimalString(row.pricePerShare),
            indexKind: pps === undefined ? undefined : "assets_per_share",
          };
        }
        ctx.onProgress?.(done, roster.length, `${LENDER_KEY} ${hub.symbol ?? address}`);
      }
    },
  };
}
