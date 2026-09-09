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
 * Re Protocol reUSD / reUSDe — APR_BACKFILL.md "reUSD/reUSDe (Re)" row, depth
 * re-confirmed in VAULT_HISTORY_BACKFILL_PLAN.md §3.
 *
 * `GET api.re.xyz/price` (documented, unauth) returns BOTH tokens' whole daily
 * NAV history in one call: `{data: {reUSD: [{date, price, apy}], reUSDe: […]}}`.
 * Verified 2026-09-09: reUSD 458 points, reUSDe 513 points to 2025-04-01.
 *
 * This is the entry the matrix says "official replaces DefiLlama" for, and the
 * reason is depth: the Llama pool starts 2026-04-02, ten months later, and
 * carries no share price. The live spot fetcher still reads Llama — that is a
 * separate wiring job, not this module's business.
 *
 * Units: `price` IS the NAV (assets per share, ~1.09), kept verbatim as the
 * accumulator. `apy` is already PERCENT (6.66 = 6.66 %) and is the source's
 * trailing-7d figure, not a spot rate — the field name is the API's, the
 * caveat is ours.
 *
 * A NAV oracle has no chain: Re mints the same token on four chains against one
 * NAV, and 99.4 % of supply is on Ethereum, so the series is attributed to the
 * mainnet deployment rather than duplicated per chain (duplicating would invent
 * four independent series out of one measurement).
 */

const LENDER_KEY = "VAULT_RE";
const CHAIN_ID = "1" as ChainId;
const API = "https://api.re.xyz/price";

/** Mainnet addresses, mirrored from margin-fetcher's savings registry. */
const TOKENS: Array<{ symbol: "reUSD" | "reUSDe"; address: string }> = [
  { symbol: "reUSD", address: "0x5086bf358635b81d8c47c66d1c8b9e567db70c72" },
  { symbol: "reUSDe", address: "0xddc0f880ff6e4e22e4b74632fbb43ce4df6ccc5a" },
];

interface RePoint {
  date: string; // "2026-09-08"
  price: number; // NAV, assets per share
  apy: number; // percent, trailing 7d
}

interface ReResponse {
  success?: boolean;
  data?: Partial<Record<string, RePoint[]>>;
}

export function createReVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "re-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<ReResponse>(API);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const token of TOKENS) {
        const rows = res.data?.[token.symbol] ?? [];
        const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, token.address);
        for (const row of rows) {
          const tsMs = Date.parse(`${row.date}T00:00:00Z`);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const price = num(row.price);
          const apy = num(row.apy);
          // The first days of the series carry apy 0 while the NAV is still
          // exactly 1.0 — real rows, but the rate is not measured yet.
          if (price === undefined && apy === undefined) continue;

          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: CHAIN_ID,
            dataTs: bucketStart(tsMs, "1d").toISOString(),
            source: "re-api",
            depositRate: apy, // already percent
            supplyIndex: decimalString(price),
            indexKind: price === undefined ? undefined : "assets_per_share",
          };
        }
        done += 1;
        ctx.onProgress?.(done, TOKENS.length, `${LENDER_KEY} ${token.symbol}`);
      }
    },
  };
}
