import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  vaultWanted,
} from "@lending-owners/core";
import { trailingRealizedApr } from "./ipor.js";
import { decimalString, num } from "./shared.js";

/**
 * ether.fi Liquid (Veda BoringVault) spokes on Optimism — ticket 0006 lane E.
 *
 * Source: `api.sevenseas.capital/dailyData/{network}/{vault}/0/latest`, keyless,
 * one point per UTC day with `share_price`, `total_assets`, `tvl`, `daily_apy`
 * and `block_number`. The Optimism series starts 2026-04-02, when the spokes
 * were deployed.
 *
 * Mapping (verified 2026-10-30 against the live rows):
 *  - `supplyIndex` = `share_price` — the Ethereum accountant's rate, which the
 *    live veda reader on the OP spoke also reports; matches ours exactly.
 *  - `depositRate` = trailing-30-day realized APR of that share price — what
 *    margin-fetcher's `llamaGapShareRateFetcher` computes for these rows. NOT
 *    `daily_apy` (a one-day APY). Within 0.06 pp of live on the overlap.
 *  - totals from `total_assets` / `tvl`; the first days after deployment are
 *    0 or garbage, so a total is emitted only once TVL is positive.
 */

const LENDER_KEY = "VAULT_ETHERFI_LIQUID";
const API = "https://api.sevenseas.capital/dailyData";

const VAULTS: ReadonlyArray<{ chainId: ChainId; network: string; address: string; symbol: string }> = [
  { chainId: "10" as ChainId, network: "optimism", address: "0x08c6f91e2b681faf5e17227f2a44c307b3c1364c", symbol: "liquidUSD" },
  { chainId: "10" as ChainId, network: "optimism", address: "0xf0bb20865277abd641a307ece5ee04e79073416c", symbol: "liquidETH" },
  { chainId: "10" as ChainId, network: "optimism", address: "0x5f46d540b6ed704c3c8789105f30e075aa900726", symbol: "liquidBTC" },
];

interface DailyRow {
  unix_seconds?: number;
  share_price?: number | string | null;
  total_assets?: string | number | null;
  tvl?: string | number | null;
  block_number?: number;
}

export function createEtherfiLiquidVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "sevenseas-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({ label: LENDER_KEY, concurrency: 1, minIntervalMs: 500, signal: ctx.signal });
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const v of VAULTS) {
        done += 1;
        if (ctx.chainIds && !ctx.chainIds.includes(v.chainId)) continue;
        if (!vaultWanted(ctx, v.chainId, v.address)) continue;

        let rows: DailyRow[] = [];
        try {
          const res = await client.getJson<{ Response?: DailyRow[] }>(`${API}/${v.network}/${v.address}/0/latest`);
          rows = res.Response ?? [];
        } catch (err) {
          console.warn(`[${LENDER_KEY}] ${v.symbol}: ${(err as Error).message}`);
          continue;
        }

        // Newest-first upstream; the rate needs them ascending, and over the
        // WHOLE series so the first in-range point keeps its full lookback.
        const samples = rows
          .map((r) => ({ tsMs: Number(r.unix_seconds) * 1000, ratio: num(r.share_price), row: r }))
          .filter((s): s is { tsMs: number; ratio: number; row: DailyRow } => Number.isFinite(s.tsMs) && (s.ratio ?? 0) > 0)
          .sort((a, b) => a.tsMs - b.tsMs);
        const rates = trailingRealizedApr(samples);

        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);
        for (let i = 0; i < samples.length; i++) {
          const s = samples[i]!;
          if (s.tsMs < from || s.tsMs > to) continue;
          const tvl = num(s.row.tvl);
          const sane = tvl !== undefined && tvl > 0;
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: bucketStart(s.tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(s.tsMs).toISOString(),
            source: "sevenseas-api",
            depositRate: rates[i],
            totalDeposits: sane ? num(s.row.total_assets) : undefined,
            totalDepositsUsd: sane ? tvl : undefined,
            supplyIndex: decimalString(s.row.share_price),
            indexKind: "assets_per_share",
          };
        }
        ctx.onProgress?.(done, VAULTS.length, `${LENDER_KEY} ${v.symbol}`);
      }
    },
  };
}
