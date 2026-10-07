import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";

/**
 * Lista slisBNB — daily share price + trailing realized APR, read ON-CHAIN.
 *
 * slisBNB is a value-accruing LST whose whole yield is the exchange rate
 * `ListaStakeManager.convertSnBnbToBnb(1e18)` (BNB per slisBNB, 1e18-scaled).
 * Per UTC day this reads that rate at the day's first block (DefiLlama's block
 * index, `coins.llama.fi/block/bsc/<ts>`) on an archival BNB RPC, and emits:
 *
 *  - `supplyIndex` = the rate, `assets_per_share` (decimal string, exact)
 *  - `depositRate` = nominal APR percent over the trailing `WINDOW_DAYS`:
 *        (R(d) / R(d − W) − 1) × 365 / W × 100
 *    backward-looking from the day start, never clamped.
 *
 * ── Why NOT `api.lista.org/api/datachart/history?name=slisBNBRate` ──────────
 * This module read that series until 2026-10-07, and it is the wrong number.
 * It is the app's "Comprehensive APY" — staking PLUS the Binance Launchpool /
 * HODLer airdrop leg — and the trailing window it averages over is chosen by
 * the REQUEST SPAN: ≤ ~3 months returns the 3-month composite, ~4–6 months the
 * 6-month one, longer the 12-month one. Our 365-day pages therefore imported
 * the 12-month composite: 18.8 % in late 2025 against ~0.7 % the token earned.
 * The airdrop leg never reaches the exchange rate (it is paid to slisBNB or
 * Moolah's slisBNBx receipt held in a Binance Wallet MPC wallet), so it is not
 * this row's yield. Lista publishes no history of the staking leg alone
 * (`/v1/stakes/yield-apy` is current-only), so the chain is the only source.
 * Measured 2026-10-07: 30 d 0.99 %, 90 d 0.83 %, 365 d 0.69 % — vs the
 * 2.34 % / 1.58 % / 4.68 % composites. yield-tracer's
 * `scripts/repair-slisbnb-intrinsic.ts` rewrote the rows the old series wrote.
 *
 * RPCs: plain JSON-RPC. `BSC_ARCHIVE_RPCS` (comma-separated)
 * overrides the default pair — both public endpoints served archival
 * `eth_call` 1.5 years deep on 2026-10-07 (publicnode / drpc / dataseed did not).
 */

const LENDER_KEY = "VAULT_LISTA";
const CHAIN_ID = "56" as ChainId;
const SLISBNB = "0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b";
const STAKE_MANAGER = "0x1adb950d8bb3da4be104211d5ab038628e477fe6";
/** `convertSnBnbToBnb(uint256)` with 1e18. */
const RATE_CALLDATA = "0xce6298e1" + (10n ** 18n).toString(16).padStart(64, "0");
const LLAMA_BLOCK = "https://coins.llama.fi/block/bsc";
const DEFAULT_RPCS = ["https://bsc-mainnet.public.blastapi.io", "https://1rpc.io/bnb"];
/** The window `/yields/intrinsic/drift` compares the published rate against. */
const WINDOW_DAYS = 30;
const MS_DAY = 86_400_000;
/** Lista slisBNB launched 2023; the StakeManager answers from well before this. */
const SERIES_START_MS = Date.parse("2024-01-01T00:00:00Z");

const rpcs = (): string[] =>
  (process.env.BSC_ARCHIVE_RPCS ?? "")
    .split(",")
    .map((s) => s.trim())
    .filter(Boolean)
    .concat(process.env.BSC_ARCHIVE_RPCS ? [] : DEFAULT_RPCS);

export function createListaVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "archival-rpc",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const llama = new PacedClient({ label: `${LENDER_KEY}:block`, concurrency: 1, minIntervalMs: 250, signal: ctx.signal });
      const urls = rpcs();

      const rateAt = async (block: number): Promise<bigint | undefined> => {
        for (let attempt = 0; attempt < urls.length * 3; attempt++) {
          try {
            const res = await fetch(urls[attempt % urls.length], {
              method: "POST",
              headers: { "Content-Type": "application/json", "User-Agent": "lending-owners" },
              body: JSON.stringify({
                jsonrpc: "2.0",
                id: 1,
                method: "eth_call",
                params: [{ to: STAKE_MANAGER, data: RATE_CALLDATA }, `0x${block.toString(16)}`],
              }),
              signal: ctx.signal,
            });
            const j = (await res.json()) as { result?: string };
            if (typeof j.result === "string" && j.result.length > 2) return BigInt(j.result);
          } catch {
            /* next endpoint */
          }
          await new Promise((r) => setTimeout(r, 500 * (attempt + 1)));
        }
        return undefined;
      };

      const closes = new Map<number, { block: number; rate: bigint }>();
      const closeOf = async (dayMs: number) => {
        if (closes.has(dayMs)) return closes.get(dayMs);
        const { height } = await llama.getJson<{ height?: number }>(`${LLAMA_BLOCK}/${dayMs / 1000}`);
        if (!Number.isInteger(height)) return undefined;
        const rate = await rateAt(height!);
        if (rate === undefined || rate === 0n) return undefined;
        const c = { block: height!, rate };
        closes.set(dayMs, c);
        return c;
      };

      const first = bucketStart(Math.max(ctx.from.getTime(), SERIES_START_MS), "1d").getTime();
      const last = bucketStart(ctx.to.getTime(), "1d").getTime();
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, SLISBNB);
      const total = Math.max(1, Math.round((last - first) / MS_DAY) + 1);
      let n = 0;

      for (let day = first; day <= last; day += MS_DAY) {
        n += 1;
        const end = await closeOf(day);
        if (!end) continue;
        const start = await closeOf(day - WINDOW_DAYS * MS_DAY);
        // 1e12 fixed point keeps the ratio exact well past the 8 stored decimals.
        const apr =
          start === undefined
            ? undefined
            : ((Number((end.rate * 10n ** 12n) / start.rate) / 1e12 - 1) * 365 * 100) / WINDOW_DAYS;
        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: new Date(day).toISOString(),
          source: "archival-rpc",
          blockNumber: end.block,
          supplyIndex: `${end.rate / 10n ** 18n}.${(end.rate % 10n ** 18n).toString().padStart(18, "0")}`,
          indexKind: "assets_per_share",
          ...(apr === undefined || !Number.isFinite(apr) ? {} : { depositRate: apr }),
        };
        if (n % 30 === 0) ctx.onProgress?.(n, total, `${LENDER_KEY} slisBNB ${new Date(day).toISOString().slice(0, 10)}`);
      }
    },
  };
}
