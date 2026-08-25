import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  bucketStart,
  makeMarketUid,
  sleep,
} from "@lending-owners/core";
import { num } from "./shared.js";

/**
 * Hyperliquid HyperCore vaults — HISTORY_APIS.md "hypercore" row. **TVL
 * ONLY.** `POST api.hyperliquid.xyz/info {"type":"vaultDetails"}` returns
 * `portfolio` buckets, each `[name, {accountValueHistory, pnlHistory, vlm}]`
 * with `[msTimestamp, "usdString"]` pairs. What is NOT emitted, deliberately:
 *  - APR: the response carries only a single current `apr` fraction — no
 *    series. The best approximation (`Δpnl / accountValue_start`) carries
 *    flow error, so it is left to consumers, not baked into collection.
 *  - Share price: NOT derivable — `accountValueHistory` conflates deposits/
 *    withdrawals with performance, and no supply series exists to divide by.
 *  - Cumulative PnL (`pnlHistory`): real and clean, but `HistoryPoint` has
 *    no PnL field, and overloading an accumulator column with a signed USD
 *    running total would corrupt `realizedApy` for any consumer that trusts
 *    `indexKind`. Skipped until the contract grows a field for it.
 *
 * Bucket retention is the trap: `day`/`week`/`month` are ROLLING windows
 * (~24h at ~30min, 7d, 30d) — only `allTime` reaches inception, at ~weekly
 * spacing. Each request picks the FINEST bucket whose span still covers
 * `ctx.from`, so a 5-day window gets 7d-bucket density while a backfill
 * degrades to weekly (start recording now — the fine buckets lose a day of
 * history every day). `perp*` buckets are the perp sleeve only — a subset of
 * the same account value, never emitted.
 *
 * Roster: mirrored from margin-fetcher
 * `src/vaults/hypercore/registry.ts` (HYPERCORE_VAULT_REGISTRY) — HyperCore
 * has no list-all endpoint, so the spot fetcher pins these too. Keep in
 * sync. Chain "999": HyperCore is not an EVM chain; our rows attribute its
 * vaults to the HyperEVM umbrella chain (see `HYPERCORE_PROVIDER_CHAIN` in
 * margin-fetcher's `fetchVaultsAll.ts`).
 */

const LENDER_KEY = "VAULT_HYPERCORE";
const CHAIN_ID = "999" as ChainId;
const INFO_URL = "https://api.hyperliquid.xyz/info";

const VAULTS: Array<{ address: string; name: string }> = [
  { address: "0xdfc24b077bc1425ad1dea75bcb6f8158e10df303", name: "Hyperliquidity Provider (HLP)" },
  { address: "0xb0a55f13d22f66e6d495ac98113841b2326e9540", name: "HLP Liquidator 2" },
  { address: "0xd6e56265890b76413d1d527eb9b75e334c0c5b42", name: "[ Systemic Strategies ] HyperGrowth" },
  { address: "0x1e37a337ed460039d1b15bd3bc489de789768d5e", name: "Growi HF" },
  { address: "0x07fd993f0fa3a185f7207adccd29f7a87404689d", name: "[ Systemic Strategies ] L/S Grids" },
  { address: "0xc179e03922afe8fa9533d3f896338b9fb87ce0c8", name: "drkmttr" },
  { address: "0x45e7014f092c5f9c39482caec131346f13ac5e73", name: "Ultron" },
  { address: "0xac26cf5f3c46b5e102048c65b977d2551b72a9c7", name: "Long HYPE & BTC | Short Garbage" },
  { address: "0x115849ce84370f25cadcf0d348510d73837e1aa5", name: "Orbit Value Strategies" },
  { address: "0x010461c14e146ac35fe42271bdc1134ee31c703a", name: "HLP Strategy A" },
  { address: "0x31ca8395cf837de08b24da3f660e77761dfb974b", name: "HLP Strategy B" },
  { address: "0x654016a8c9fcf0c4cb7ed6078aba21f7f399f7b7", name: "BredoStrategy" },
  { address: "0xb1505ad1a4c7755e0eb236aa2f4327bfc3474768", name: "Bitcoin Moving Average Long/Short" },
  { address: "0xa6a34f0bf2ccea9a1ddf9e9a973f17c498dc5e40", name: "FC Genesis - Quantum" },
  { address: "0x8231fdf9997c003a267374b45fb25c0455aa1dcb", name: "AIQuantPulse" },
];

/** Rolling buckets, finest first — the selection order below depends on it. */
const BUCKET_PREFERENCE = ["day", "week", "month", "allTime"] as const;

type SeriesPoint = [number, string]; // [msTimestamp, "usd"]

interface PortfolioBucket {
  accountValueHistory?: SeriesPoint[];
  pnlHistory?: SeriesPoint[];
  vlm?: string | number;
}

type PortfolioEntry = [string, PortfolioBucket];

interface VaultDetailsResponse {
  name?: string;
  portfolio?: PortfolioEntry[];
}

/** PacedClient.getJson hard-codes GET and .graphql expects a `data`
 *  envelope, so this info API (plain-JSON POST) gets its own small
 *  retried POST — sequential over 15 vaults, which is pacing enough. */
async function postInfo<T>(body: unknown, signal?: AbortSignal): Promise<T> {
  let lastErr: unknown;
  for (let attempt = 0; attempt < 4; attempt += 1) {
    try {
      const res = await fetch(INFO_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
        signal,
      });
      if (res.status === 429 || res.status >= 500) {
        await sleep(Math.min(2000 * 2 ** attempt, 30_000), signal);
        continue;
      }
      if (!res.ok) {
        const text = await res.text().catch(() => "");
        throw new Error(`HTTP ${res.status} ${text.slice(0, 200)}`);
      }
      return (await res.json()) as T;
    } catch (err) {
      lastErr = err;
      if ((err as Error)?.name === "AbortError") throw err;
      await sleep(Math.min(1000 * 2 ** attempt, 15_000), signal);
    }
  }
  throw new Error(`[${LENDER_KEY}] ${(lastErr as Error)?.message ?? "request failed"}`);
}

/** Finest bucket whose span covers `fromMs` (its first point is at or before
 *  it). Falls back to `allTime` — the only bucket reaching inception — when
 *  the window predates every rolling bucket. */
function pickBucket(
  portfolio: PortfolioEntry[],
  fromMs: number,
): PortfolioBucket | undefined {
  let widest: PortfolioBucket | undefined;
  for (const name of BUCKET_PREFERENCE) {
    const bucket = portfolio.find((p) => p[0] === name)?.[1];
    const first = bucket?.accountValueHistory?.[0];
    if (!first) continue;
    widest = bucket;
    if (first[0] <= fromMs) return bucket;
  }
  return widest;
}

export function createHypercoreVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "hyperliquid-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const vault of VAULTS) {
        let details: VaultDetailsResponse | undefined;
        try {
          details = await postInfo<VaultDetailsResponse>(
            { type: "vaultDetails", vaultAddress: vault.address },
            ctx.signal,
          );
        } catch (err) {
          if ((err as Error)?.name === "AbortError") throw err;
          console.warn(`[${LENDER_KEY}] ${vault.address} skipped: ${(err as Error).message}`);
        }

        const bucket = details?.portfolio
          ? pickBucket(details.portfolio, from)
          : undefined;
        const series = bucket?.accountValueHistory ?? [];

        // Points come oldest-first at irregular spacing; last-write-wins per
        // bucket keeps the LATEST sample of each day/hour.
        const byBucket = new Map<number, { tvlUsd: number; observedMs: number }>();
        for (const [tsMs, usd] of series) {
          if (tsMs < from || tsMs > to) continue;
          const tvlUsd = num(usd);
          if (tvlUsd === undefined) continue;
          const key = bucketStart(tsMs, ctx.resolution).getTime();
          byBucket.set(key, { tvlUsd, observedMs: tsMs });
        }

        const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, vault.address);
        for (const [key, entry] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: CHAIN_ID,
            dataTs: new Date(key).toISOString(),
            observedTs: new Date(entry.observedMs).toISOString(),
            source: "hyperliquid-api",
            totalDepositsUsd: entry.tvlUsd,
          };
        }

        done += 1;
        ctx.onProgress?.(done, VAULTS.length, `${LENDER_KEY} ${vault.name}`);
      }
    },
  };
}
