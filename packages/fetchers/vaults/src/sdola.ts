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
 * Inverse Finance sDOLA — APR_BACKFILL.md "sDOLA (Inverse)" row.
 *
 * `GET www.inverse.finance/api/dola-staking/history` returns the full snapshot
 * archive in one call: 939 entries to 2024-02-08 inception, verified
 * 2026-09-09. The matrix's verdict was "official — just append `/history`",
 * and that is exactly what this is.
 *
 * Schema drifts across the archive, which is the one trap: early entries carry
 * `apr` and no `apy`/`sDolaExRate` at all, later ones carry `apy`, `apy1d`,
 * `tvlUsd` and `sDolaExRate`. Fields are therefore taken defensively and the
 * share price falls back to `sDolaTotalAssets / sDolaSupply`, which is the same
 * quantity the API later exposes directly.
 *
 * Units: `apy` and `apr` are already PERCENT (6.27 = 6.27 %).
 */

const LENDER_KEY = "VAULT_SDOLA";
const CHAIN_ID = "1" as ChainId;
const API = "https://www.inverse.finance/api/dola-staking/history";
const SDOLA = "0xb45ad160634c528cc3d2926d9807104fa3157305";

interface SdolaEntry {
  timestamp: number; // ms
  apy?: number;
  apr?: number;
  calculatedApy?: number;
  tvlUsd?: number;
  totalAssets?: number;
  sDolaExRate?: number;
  sDolaSupply?: number;
  sDolaTotalAssets?: number;
}

interface SdolaResponse {
  totalEntries?: SdolaEntry[];
}

export function createSdolaVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "inverse-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 1,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const res = await client.getJson<SdolaResponse>(API);
      const rows = res.totalEntries ?? [];
      const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, SDOLA);
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();

      // The archive samples several times a day in places; keep the FIRST
      // sample of each bucket so a re-run picks the same one (the sink dedupes
      // on `(marketUid, dataTs)`, so an arbitrary choice would flap).
      const chosen = new Map<number, SdolaEntry>();
      for (const row of rows) {
        const tsMs = Number(row.timestamp);
        if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
        const bucket = bucketStart(tsMs, ctx.resolution).getTime();
        const prior = chosen.get(bucket);
        if (prior === undefined || tsMs < Number(prior.timestamp)) chosen.set(bucket, row);
      }

      for (const [bucket, row] of [...chosen].sort((a, b) => a[0] - b[0])) {
        const rate = num(row.apy) ?? num(row.calculatedApy) ?? num(row.apr);
        const exRate =
          num(row.sDolaExRate) ??
          (num(row.sDolaTotalAssets) !== undefined && num(row.sDolaSupply)
            ? Number(row.sDolaTotalAssets) / Number(row.sDolaSupply)
            : undefined);
        if (rate === undefined && exRate === undefined) continue;

        yield {
          marketUid,
          lenderKey: LENDER_KEY,
          chainId: CHAIN_ID,
          dataTs: new Date(bucket).toISOString(),
          observedTs: new Date(Number(row.timestamp)).toISOString(),
          source: "inverse-api",
          depositRate: rate, // already percent
          totalDeposits: num(row.totalAssets) ?? num(row.sDolaTotalAssets),
          totalDepositsUsd: num(row.tvlUsd),
          supplyIndex: decimalString(exRate),
          indexKind: exRate === undefined ? undefined : "assets_per_share",
        };
      }
      ctx.onProgress?.(1, 1, `${LENDER_KEY} sDOLA`);
    },
  };
}
