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
 * Strata tranched CDOs — VAULT_HISTORY_BACKFILL_PLAN.md §3 "Strata sr/jr
 * tranches" row.
 *
 * `GET s3.strata.money/tranches/analytics-v18.json` is the file the live spot
 * fetcher already reads, and it carries the history: every CDO holds `all`
 * (full-life, WEEKLY 7-day spacing), `d30` (30 daily points) and `d7`. Verified
 * 2026-09-09: 7 CDOs, ethenaCdo back to 2025-10-05.
 *
 * `all` is used rather than `d30` because weekly-since-inception beats daily
 * for a month; the two overlap and would collide on `(marketUid, dataTs)`
 * anyway, so mixing them buys nothing but ambiguity about which sample won.
 *
 * **The URL is version-pinned.** A bump to `-v19` strands this job silently —
 * the request just 404s — so a fetch failure here is raised, not swallowed.
 *
 * Each CDO carries two tranches with independent prices and rates: `srt`
 * (senior) and `jrt` (junior, first-loss). They are separate markets, keyed on
 * their own tranche tokens.
 *
 * Units: `apr`/`apy` are already PERCENT (3.12 = 3.12 %); `price` is the
 * tranche's assets-per-share; `tvl` is USD.
 *
 * **Junior APYs go astronomical and that is upstream truth, not a unit error.**
 * Measured on the first run: jrUSDat carries 5.4e11 % on 2026-07-05 and
 * 1.7e10 % on 2026-08-09. A junior tranche is first-loss, its share price moves
 * violently (0.26 → 0.42 across those weeks), and annualizing a weekly move of
 * that size produces exactly these numbers. They are passed through rather than
 * clamped — the same choice as Yield Basis's legitimate negative APYs — and the
 * ingest nulls anything above `numeric(18,8)` and counts it, which
 * `pnpm validate:history` reports as HANDLED rather than blocking. The share
 * price beside it is the number to trust for realized return.
 */

const LENDER_KEY = "VAULT_STRATA";
const CHAIN_ID = "1" as ChainId;
const API = "https://s3.strata.money/tranches/analytics-v18.json";

/** Analytics CDO key → the two tranche tokens, from margin-fetcher's savings
 *  registry. A CDO the file gains before this map does is skipped loudly —
 *  guessing an address would file a real series under a wrong market. */
const TRANCHES: Record<string, { sr: { symbol: string; address: string }; jr: { symbol: string; address: string } }> = {
  ethenaCdo: {
    sr: { symbol: "srUSDe", address: "0x3d7d6fdf07ee548b939a80edbc9b2256d0cdc003" },
    jr: { symbol: "jrUSDe", address: "0xc58d044404d8b14e953c115e67823784dea53d8f" },
  },
  neutrlCdo: {
    sr: { symbol: "srNUSD", address: "0x65a44528e8868166401ea08b549e19552af589db" },
    jr: { symbol: "jrNUSD", address: "0xfc807058a352b61aeef6a38e2d0fc3990225e772" },
  },
  mhyperCdo: {
    sr: { symbol: "srmHYPER", address: "0x627ea69929212916ec57b1b26d2e1a19f6129b53" },
    jr: { symbol: "jrmHYPER", address: "0xeb205d26e9e605ec82d1c0d652e00037c278714b" },
  },
  saturnCdo: {
    sr: { symbol: "srUSDat", address: "0xfaa9a0e1db9e22ae3a20b2b58a68dc24d053d066" },
    jr: { symbol: "jrUSDat", address: "0x011e55d2b28306458e37ca7e997c879bb25a455d" },
  },
  figureCdo: {
    sr: { symbol: "srPRIME", address: "0x35bff778d3fc53a561486bf28e761428499232eb" },
    jr: { symbol: "jrPRIME", address: "0xf4c91f24e20ee8ed5eda905e501a1136334c2f27" },
  },
};

interface TranchePoint {
  tvl?: number;
  price?: number;
  apr?: number;
  apy?: number;
}
interface CdoPoint {
  date?: string;
  timestamp?: number; // unix seconds
  blockNr?: number;
  srt?: TranchePoint;
  jrt?: TranchePoint;
}
type StrataResponse = Record<string, { all?: CdoPoint[] } | undefined>;

export function createStrataVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "strata-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<StrataResponse>(API);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const unmapped: string[] = [];
      let done = 0;

      for (const [cdo, series] of Object.entries(res ?? {})) {
        const tranches = TRANCHES[cdo];
        if (!tranches) {
          if (Array.isArray(series?.all)) unmapped.push(cdo);
          continue;
        }
        for (const point of series?.all ?? []) {
          const tsMs = point.timestamp !== undefined ? Number(point.timestamp) * 1000 : Date.parse(point.date ?? "");
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const dataTs = bucketStart(tsMs, ctx.resolution).toISOString();

          for (const [leg, tranche] of [
            ["srt", tranches.sr],
            ["jrt", tranches.jr],
          ] as const) {
            const t = point[leg];
            if (!t) continue;
            const apy = num(t.apy) ?? num(t.apr);
            const price = num(t.price);
            if (apy === undefined && price === undefined) continue;

            yield {
              marketUid: makeMarketUid(LENDER_KEY, CHAIN_ID, tranche.address),
              lenderKey: LENDER_KEY,
              chainId: CHAIN_ID,
              dataTs,
              observedTs: new Date(tsMs).toISOString(),
              source: "strata-api",
              blockNumber: point.blockNr,
              depositRate: apy, // already percent
              totalDepositsUsd: num(t.tvl),
              supplyIndex: decimalString(price),
              indexKind: price === undefined ? undefined : "assets_per_share",
            };
          }
        }
        done += 1;
        ctx.onProgress?.(done, Object.keys(TRANCHES).length, `${LENDER_KEY} ${cdo}`);
      }

      if (unmapped.length > 0) {
        console.warn(
          `[${LENDER_KEY}] CDO(s) with history and no pinned tranche tokens: ${unmapped.join(", ")} — skipped`,
        );
      }
    },
  };
}
