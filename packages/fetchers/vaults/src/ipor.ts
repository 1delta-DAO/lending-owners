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
import { decimalString, num } from "./shared.js";

/**
 * IPOR Fusion PlasmaVaults — EARN_BACKFILL_2026_10.md §3 (lane B). The live rows
 * are twelve curated savings entries (lending-sdks `docs/earn/IPOR_FUSION.md`),
 * so the runner key maps to provider `savings` in `PROVIDER_OF`.
 *
 * Source: `GET https://api.ipor.io/v2/fusion/vault-history/{chainId}/{vault}-{w}`,
 * a static gzip S3 object per window. Measured 2026-10-30:
 *  - `-1y` is hourly but NOT always back to inception: four of the twelve
 *    vaults are older than a year and `-1y` cuts them at 365 days.
 *  - `-all` is hourly to inception, but rebuilt rarely (rETHLPC's was 23 days
 *    stale; the Base files were a day old).
 *  - `-30d` is rebuilt daily-ish (hours old) — it is also exactly what the live
 *    rate is computed from.
 *  - `-7d` is rebuilt about hourly (minutes old). `-90d`/`-365d`/`-1d` 404.
 *  So all four are fetched and unioned by block timestamp: `-all` for depth,
 *  the rest for the recent tail. Overlapping points were checked identical
 *  (same block, same ratio) on all twelve vaults, so precedence is moot.
 *
 * Units (verified 2026-10-30 against on-chain `convertToAssets` and the live
 * share price on yields.1delta.io):
 *  - `assetsToSharesRatio` is already a decimal in ASSET units per WHOLE share
 *    (= `convertToAssets(10**shareDecimals) / 10**assetDecimals`), e.g.
 *    0.976 WETH per rETHLPC — no rescale. → `supplyIndex`, `assets_per_share`.
 *  - `totalBalance` is decimal asset units; `tvl` is USD.
 *  - `apy` / `netApy` / `grossApy` are NOT used: IPOR_FUSION.md §2.3 measured
 *    them overstating the realized rate by up to 2×.
 *
 * Rate: margin-fetcher `yields/intrinsic/fetchers/iporFusion.ts`
 * (`realizedAprFromHistory`) is the live definition — share-price growth from
 * the first to the last point of the `-30d` file, annualised SIMPLE, percent
 * APR, negative passed through, nothing under 7 days. Here each point gets the
 * same thing over its own trailing 30 days (first point at or after t − 30 d),
 * so the first month after inception carries a shorter window down to 7 days
 * and the first week carries no rate.
 */

const LENDER_KEY = "VAULT_IPOR";
const SOURCE = "ipor-api" as const;
const API = "https://api.ipor.io/v2/fusion/vault-history";

const MS_DAY = 86_400_000;
const RATE_WINDOW_MS = 30 * MS_DAY;
const MIN_RATE_WINDOW_MS = 7 * MS_DAY;
const MS_YEAR = 365 * MS_DAY;

/** Fetched in this order; a later window overwrites an earlier one's point in
 *  the same hour (fresher file wins). */
const WINDOWS = ["all", "1y", "30d", "7d"] as const;

/**
 * calldata-sdk `IPOR_FUSION_VAULTS` (registryIporFusion.ts), the one table every
 * leg of the integration is built from. Pinned here rather than imported: this
 * repo does not depend on calldata-sdk, and the set is curated (12 vaults).
 */
export const IPOR_FUSION_VAULTS: ReadonlyArray<{ chainId: ChainId; vault: string; symbol: string }> = [
  { chainId: "1" as ChainId, vault: "0xb9e806e8f2d94c015ffefa90cd24ecce18f1663c", symbol: "rETHLPC" },
  { chainId: "1" as ChainId, vault: "0xb8a451107a9f87fde481d4d686247d6e43ed715e", symbol: "fusnstETH" },
  { chainId: "1" as ChainId, vault: "0xb0f56bb0bf13ee05fef8cd2d8df5ffdfcac7a74f", symbol: "$TAUSIUSD" },
  { chainId: "1" as ChainId, vault: "0xf8f226da66244f89e70c5b5d1a5c5b0d505eb1d8", symbol: "bdUSD" },
  { chainId: "1" as ChainId, vault: "0x7659fc26bf3a63e8133bbecb7e16acd48ee8e292", symbol: "BTCdc" },
  { chainId: "1" as ChainId, vault: "0xe9385eff3f937fcb0f0085da9a3f53d6c2b4fb5f", symbol: "ipsrUSDfusion" },
  { chainId: "8453" as ChainId, vault: "0x17d0f109ee895bad0b68aa104aa72bd0b003ad8e", symbol: "CSETHLO" },
  { chainId: "8453" as ChainId, vault: "0xe883426b4fc84a7f5cc86415cabbef43e73a4cc8", symbol: "TAUCBETH" },
  { chainId: "8453" as ChainId, vault: "0x7872893e528fe2c0829e405960db5b742112aa97", symbol: "bAutopilot_wETH" },
  { chainId: "8453" as ChainId, vault: "0x5900c3b72458f12967dc1bef35b92d271f5cdbc1", symbol: "CSCBETHLL" },
  { chainId: "8453" as ChainId, vault: "0xd46a3c2d958d0a2cb098d48c48dc19fe3a710f37", symbol: "CSUSDCLO" },
  { chainId: "8453" as ChainId, vault: "0x0d877dc7c8fa3ad980dfdb18b48ec9f8768359c4", symbol: "bAutopilot_USDC" },
];

interface IporHistoryResponse {
  createdAt?: string;
  history?: Array<{
    blockNumber?: number | string;
    blockTimestamp?: string;
    totalBalance?: string | number | null;
    tvl?: string | number | null;
    assetsToSharesRatio?: string | number | null;
  }>;
}

interface Sample {
  tsMs: number;
  blockNumber?: number;
  ratioStr: string;
  ratio: number;
  totalBalance?: number;
  tvl?: number;
}

/** Simple-annualised realized APR, percent, over each sample's trailing
 *  30 days — `realizedAprFromHistory` applied per point. `samples` sorted. */
export function trailingRealizedApr(samples: ReadonlyArray<Pick<Sample, "tsMs" | "ratio">>): Array<number | undefined> {
  const out: Array<number | undefined> = [];
  let lo = 0;
  for (let i = 0; i < samples.length; i++) {
    const cur = samples[i]!;
    while (lo < i && samples[lo]!.tsMs < cur.tsMs - RATE_WINDOW_MS) lo++;
    const first = samples[lo]!;
    const dt = cur.tsMs - first.tsMs;
    out.push(dt >= MIN_RATE_WINDOW_MS ? (cur.ratio / first.ratio - 1) * (MS_YEAR / dt) * 100 : undefined);
  }
  return out;
}

export function createIporVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: SOURCE,

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const vaults = IPOR_FUSION_VAULTS.filter(
        (v) => (!ctx.chainIds || ctx.chainIds.includes(v.chainId)) && vaultWanted(ctx, v.chainId, v.vault),
      );
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const vault of vaults) {
        done += 1;
        // Keyed by exact block timestamp: the windows sample the same blocks.
        const byTs = new Map<number, Sample>();
        let windowsOk = 0;
        for (const w of WINDOWS) {
          let body: IporHistoryResponse;
          try {
            body = await client.getJson<IporHistoryResponse>(`${API}/${vault.chainId}/${vault.vault}-${w}`);
          } catch (err) {
            // A missing window (NoSuchKey → 403/404) is survivable while
            // another one answers; all of them failing throws below.
            console.warn(`[${LENDER_KEY}] ${vault.symbol} -${w}: ${(err as Error).message}`);
            continue;
          }
          windowsOk += 1;
          for (const p of body.history ?? []) {
            const tsMs = p.blockTimestamp ? Date.parse(p.blockTimestamp) : NaN;
            const ratioStr = decimalString(p.assetsToSharesRatio);
            const ratio = num(ratioStr);
            if (!Number.isFinite(tsMs) || ratioStr === undefined || ratio === undefined || !(ratio > 0)) continue;
            byTs.set(tsMs, {
              tsMs,
              blockNumber: num(p.blockNumber),
              ratioStr,
              ratio,
              totalBalance: num(p.totalBalance),
              tvl: num(p.tvl),
            });
          }
        }
        if (windowsOk === 0) throw new Error(`[${LENDER_KEY}] no history window answered for ${vault.symbol}`);

        const samples = [...byTs.values()].sort((a, b) => a.tsMs - b.tsMs);
        // The rate needs the 30 days BEFORE `from`, so it is computed over the
        // whole series and only then filtered.
        const rates = trailingRealizedApr(samples);

        const marketUid = makeMarketUid(LENDER_KEY, vault.chainId, vault.vault);
        const seen = new Set<number>();
        for (let i = 0; i < samples.length; i++) {
          const s = samples[i]!;
          if (s.tsMs < from || s.tsMs > to) continue;
          const bucket = bucketStart(s.tsMs, ctx.resolution).getTime();
          if (seen.has(bucket)) continue;
          seen.add(bucket);
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: vault.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(s.tsMs).toISOString(),
            source: SOURCE,
            blockNumber: s.blockNumber,
            depositRate: rates[i], // percent APR, simple — the live convention
            totalDeposits: s.totalBalance,
            totalDepositsUsd: s.tvl,
            supplyIndex: s.ratioStr,
            indexKind: "assets_per_share",
          };
        }
        ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${vault.symbol}`);
      }
    },
  };
}
