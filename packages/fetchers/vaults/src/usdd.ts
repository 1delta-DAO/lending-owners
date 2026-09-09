import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { fractionToPercent, num } from "./shared.js";

/**
 * USDD sUSDD — APR_BACKFILL.md "sUSDD (USDD)" row.
 *
 * `GET openapi.usdd.io/api/v1/market-site/overview/apy` returns every chain's
 * daily APY series in one call: `data.items[] = {chain, items: [{statisticTime,
 * apy}]}`. Verified 2026-09-09, Ethereum series since 2025-09.
 *
 * The Ethereum and BNB stacks are INDEPENDENT deployments with independent
 * rates and their own Pot, so each chain's series is a separate market — the
 * `chain` field is the join key, not decoration.
 *
 * Only deployments whose share-token address is pinned here are emitted; the
 * rest (including TRON, which is not EVM and has no `chainId` in our scheme)
 * are skipped and counted rather than attributed to a guessed address.
 *
 * Units: `apy` is a FRACTION string ("0.04000000189…") → percent here. Leading
 * zero-APY rows are the pre-launch pad and are dropped.
 */

const LENDER_KEY = "VAULT_USDD";
const API = "https://openapi.usdd.io/api/v1/market-site/overview/apy";

/** The API's own chain slug → our chain id and the sUSDD share token.
 *  Ethereum's address is the one margin-fetcher's `usdd.ts` pins from a live
 *  `sUSDD.pot()` read; a slug without a verified address is skipped, never
 *  guessed. */
const CHAINS: Record<string, { chainId: ChainId; address: string }> = {
  eth: { chainId: "1" as ChainId, address: "0xc5d6a7b61d18afa11435a889557b068bb9f29930" },
};

interface UsddResponse {
  data?: {
    items?: Array<{
      chain?: string;
      items?: Array<{ statisticTime: number; apy: string }>;
    }>;
  };
}

export function createUsddVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "usdd-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<UsddResponse>(API);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const skipped: string[] = [];
      let done = 0;

      for (const series of res.data?.items ?? []) {
        const slug = series.chain ?? "";
        const target = CHAINS[slug];
        if (!target) {
          skipped.push(slug || "(unnamed)");
          continue;
        }
        if (ctx.chainIds && !ctx.chainIds.includes(target.chainId)) continue;
        const marketUid = makeMarketUid(LENDER_KEY, target.chainId, target.address);

        for (const row of series.items ?? []) {
          const tsMs = Number(row.statisticTime);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const apy = num(row.apy);
          if (apy === undefined || apy === 0) continue;

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: target.chainId,
            dataTs: bucketStart(tsMs, "1d").toISOString(),
            source: "usdd-api",
            depositRate: fractionToPercent(apy),
          };
        }
        done += 1;
        ctx.onProgress?.(done, Object.keys(CHAINS).length, `${LENDER_KEY} ${slug}`);
      }

      if (skipped.length > 0) {
        console.warn(
          `[${LENDER_KEY}] no pinned sUSDD address for chain slug(s) ${skipped.join(", ")} — series skipped`,
        );
      }
    },
  };
}
