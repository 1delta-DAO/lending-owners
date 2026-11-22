import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { apyToAprPercent, decimalString, num } from "./shared.js";

/**
 * Inverse Finance jrDOLA (v2) and sINV — the two staking vaults margin-fetcher
 * added to its savings registry on 2026-10-23 (`registryFirm.ts`). Same source
 * family as `sdola.ts`: Inverse's own app API keeps the full daily archive one
 * `/history` away.
 *
 *  - jrDOLA: `GET www.inverse.finance/api/junior/jdola-staking-history`
 *    (247 entries from 2026-02-19, daily).
 *  - sINV:   `GET www.inverse.finance/api/inv-staking/history`
 *    (771 entries from 2024-09-05, daily).
 *
 * Both share prices were checked against archival `convertToAssets(1e18)` on
 * 2026-10-23 and agree to ~1e-9 (sINV at 2024-09-29 / 2025-03-28 / 2026-01-26 /
 * 2026-10-23; jrDOLA at 2026-08-08 / 2026-09-07 / 2026-10-23).
 *
 * Traps, both about WHICH CONTRACT a row describes:
 *
 *  - jrDOLA's endpoint is not v2-only. It starts on Inverse's v1 vault
 *    (`0x6338…a452`, superseded), carries v1 through its 2026-04-16 slash
 *    (share price 1.0242 → 0.0024 sDOLA, 340,061.89 DOLA of DOLA/wstUSR-market
 *    bad debt repaid) and keeps serving v1's 0.0024 until 2026-07-07, two
 *    weeks after v2 was deployed. Rows are therefore kept only from v2's
 *    deployment AND with a share price ≥ 0.5 — v2 started at 1.0 and v1 never
 *    recovered, so the price alone separates them.
 *  - sINV's endpoint starts 2024-09-05, before this vault (sINV v2) existed;
 *    the early top-level fields are the v1 vault's. Rows before v2's deployment
 *    are dropped. (`V1` inside later rows is the old vault, ignored.)
 *
 * Units — a deliberate departure from this package's "APY → depositRate"
 * convention: both endpoints publish `apy` in PERCENT APY, but yield-tracer
 * stores a savings row's `depositRate` verbatim as `vaults_snapshots.total_rate`,
 * which the live sweep fills with margin-fetcher's APR (`apyToAprPercent` of
 * the same `apy`). Writing the APY would put a 28.6 % next to the live 25.2 %
 * on jrDOLA, so the rate is converted here with margin-fetcher's exact formula.
 *
 * Rates: jrDOLA's `apy` is the junior leg only, in sDOLA terms — `totalApy`
 * adds sDOLA's own yield and would double-count (it already reaches the holder
 * through sDOLA's price). `projectedApy` is a budget projection, never used.
 */

const CHAIN_ID = "1" as ChainId;
interface InverseEntry {
  timestamp: number; // ms
  [k: string]: unknown;
}

interface Spec {
  lenderKey: string;
  api: string;
  vault: string;
  /** First day THIS vault holds deposits — rows before it describe a predecessor. */
  deployedAtMs: number;
  /** Share price field (underlying per share). */
  rateKey: string;
  totalAssetsKey: string;
  /** Underlying price in USD, for TVL when the row carries no `tvlUsd`. */
  usdPrice: (row: InverseEntry) => number | undefined;
  /** Extra row filter (jrDOLA's v1 guard). */
  keep?: (sharePrice: number) => boolean;
  label: string;
}

const createInverseFetcher = (spec: Spec): HistoryFetcher => ({
  lenderKey: spec.lenderKey,
  source: "inverse-api",

  async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
    if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
    const client = new PacedClient({
      label: spec.lenderKey,
      concurrency: 1,
      minIntervalMs: 200,
      signal: ctx.signal,
    });

    const res = await client.getJson<{ totalEntries?: InverseEntry[] }>(spec.api);
    const rows = res.totalEntries ?? [];
    const marketUid = makeMarketUid(spec.lenderKey, CHAIN_ID, spec.vault);
    const from = Math.max(ctx.from.getTime(), spec.deployedAtMs);
    const to = ctx.to.getTime();

    // First sample of each bucket wins, so a re-run picks the same row (the
    // sink dedupes on `(marketUid, dataTs)`).
    const chosen = new Map<number, InverseEntry>();
    for (const row of rows) {
      const tsMs = Number(row.timestamp);
      if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
      const sharePrice = num(row[spec.rateKey]);
      if (sharePrice === undefined || (spec.keep && !spec.keep(sharePrice))) continue;
      const bucket = bucketStart(tsMs, ctx.resolution).getTime();
      const prior = chosen.get(bucket);
      if (prior === undefined || tsMs < Number(prior.timestamp)) chosen.set(bucket, row);
    }

    for (const [bucket, row] of [...chosen].sort((a, b) => a[0] - b[0])) {
      const apy = num(row.apy) ?? num(row.calculatedApy);
      const totalAssets = num(row[spec.totalAssetsKey]);
      const price = spec.usdPrice(row);
      yield {
        marketUid,
        lenderKey: spec.lenderKey,
        chainId: CHAIN_ID,
        dataTs: new Date(bucket).toISOString(),
        observedTs: new Date(Number(row.timestamp)).toISOString(),
        source: "inverse-api",
        depositRate: apy === undefined ? undefined : apyToAprPercent(apy), // APR percent, see header
        totalDeposits: totalAssets,
        totalDepositsUsd:
          num(row.tvlUsd) ?? (totalAssets !== undefined && price !== undefined ? totalAssets * price : undefined),
        supplyIndex: decimalString(row[spec.rateKey]),
        indexKind: "assets_per_share",
      };
    }
    ctx.onProgress?.(1, 1, `${spec.lenderKey} ${spec.label}`);
  },
});

/** jrDOLA v2 `0x6f80…bc7`, deployed block 25,377,638 (2026-06-23). Share price in sDOLA. */
export function createJrdolaVaultHistoryFetcher(): HistoryFetcher {
  return createInverseFetcher({
    lenderKey: "VAULT_JRDOLA",
    api: "https://www.inverse.finance/api/junior/jdola-staking-history",
    vault: "0x6f80a22a57c7f0257094ea8d426af3f747defbc7",
    deployedAtMs: Date.UTC(2026, 5, 23),
    rateKey: "jrDolaExRate",
    totalAssetsKey: "jrDolaTotalAssets",
    // `tvlUsd` is on every row; no fallback price needed.
    usdPrice: () => undefined,
    keep: (sharePrice) => sharePrice >= 0.5,
    label: "jrDOLA",
  });
}

/** sINV v2 `0x08d2…e994`, deployed block 20,771,285 (2024-09-17), first deposits
 *  2024-09-19 — on 09-18 its supply was still 0 while the API's top-level rows
 *  (share price 1.0051) were the v1 vault's, so the series starts at 09-19. */
export function createSinvVaultHistoryFetcher(): HistoryFetcher {
  return createInverseFetcher({
    lenderKey: "VAULT_SINV",
    api: "https://www.inverse.finance/api/inv-staking/history",
    vault: "0x08d23468a467d2bb86fae0e32f247a26c7e2e994",
    deployedAtMs: Date.UTC(2024, 8, 19),
    rateKey: "sInvExRate",
    totalAssetsKey: "sInvTotalAssets",
    usdPrice: (row) => num(row.invMarketPrice),
    label: "sINV",
  });
}
