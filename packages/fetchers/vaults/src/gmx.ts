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
 * GMX V2 GM pools + GLV vaults — HISTORY_APIS.md "gmx" row. APR ONLY: no
 * public pps or TVL series exists (the squid indexes fees, not balances).
 *
 * Source is the subsquid GraphQL per chain
 * (`gmx.squids.live/gmx-synthetics-{arbitrum|avalanche}:prod/api/graphql`),
 * entity `aprSnapshots`: one row per (address, UTC-midnight day) with
 * `entityType: Market | Glv` — both are wanted, and both key the uid on the
 * GM/GLV token address, so no roster enumeration is needed: the window query
 * IS the roster (probed live: `offset` paging works, `orderBy` accepts a
 * list, `aprSnapshotsConnection { totalCount }` sizes the window — ~137
 * rows/day on Arbitrum across ~120 markets + GLVs).
 *
 * UNITS — the defining trap: `aprByFee` / `aprByBorrowingFee` are 1e30-scaled
 * FRACTIONS (GMX FLOAT_PRECISION; 5.46e28 = 5.46 %), and the supply APR is
 * the SUM of the two legs. Verified against the live aggregate
 * `arbitrum-api.gmxinfra.io/apy?period=7d` on 2026-08-25 for
 * `0x0CCB4fAa…` (wstETH/USDe): mean of the last 7 daily squid rows
 * = 21.50 % nominal APR vs the REST endpoint's 0.24386 = 24.39 % APY —
 * same magnitude, the residual being compounding + window alignment (their
 * 7d window ends "now", the snapshots at midnight). A scale error here would
 * be off by orders of magnitude, not 3 points.
 *
 * Retention: squid inception 2023-09-26 on Arbitrum (GLV rows from 2024-09).
 * Snapshots are DAILY — under `resolution: "1h"` this still emits at most
 * one point per day, floored to its day bucket.
 */

const LENDER_KEY = "VAULT_GMX";
const PAGE = 1000;

const SQUIDS: Array<{ chainId: ChainId; url: string }> = [
  {
    chainId: "42161" as ChainId,
    url: "https://gmx.squids.live/gmx-synthetics-arbitrum:prod/api/graphql",
  },
  {
    chainId: "43114" as ChainId,
    url: "https://gmx.squids.live/gmx-synthetics-avalanche:prod/api/graphql",
  },
];

interface AprSnapshot {
  /** `<address>:<snapshotTimestamp>` — the natural cursor, unused because
   *  plain offset paging works on this squid. */
  id: string;
  address: string;
  snapshotTimestamp: number; // unix seconds, always UTC midnight (probed)
  aprByFee: string; // 1e30-scaled fraction, decimal string
  aprByBorrowingFee: string; // 1e30-scaled fraction, decimal string
  entityType: "Market" | "Glv";
}

/** The stable secondary sort makes offset pages deterministic across the
 *  many rows sharing one snapshotTimestamp. */
const QUERY = `query Snapshots($limit: Int!, $offset: Int!, $from: Int!, $to: Int!) {
  aprSnapshots(
    limit: $limit
    offset: $offset
    orderBy: [snapshotTimestamp_ASC, id_ASC]
    where: { snapshotTimestamp_gte: $from, snapshotTimestamp_lte: $to }
  ) {
    id
    address
    snapshotTimestamp
    aprByFee
    aprByBorrowingFee
    entityType
  }
}`;

/** 1e30-scaled fraction string → percent. Number() precision loss is far
 *  below display precision for an APR. */
const e30FractionToPercent = (v: string): number | undefined => {
  const n = Number(v);
  return Number.isFinite(n) ? (n / 1e30) * 100 : undefined;
};

export function createGmxVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "gmx-squid",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const squids = SQUIDS.filter(
        (s) => !ctx.chainIds || ctx.chainIds.includes(s.chainId),
      );
      const from = Math.floor(ctx.from.getTime() / 1000);
      const to = Math.floor(ctx.to.getTime() / 1000);
      let done = 0;

      for (const squid of squids) {
        for (let offset = 0; ; offset += PAGE) {
          const data = await client.graphql<{ aprSnapshots: AprSnapshot[] }>(
            squid.url,
            QUERY,
            { limit: PAGE, offset, from, to },
          );
          const rows = data.aprSnapshots ?? [];

          for (const row of rows) {
            const fee = e30FractionToPercent(row.aprByFee);
            const borrowing = e30FractionToPercent(row.aprByBorrowingFee);
            if (fee === undefined && borrowing === undefined) continue;
            const tsMs = row.snapshotTimestamp * 1000;
            yield {
              marketUid: makeMarketUid(
                LENDER_KEY,
                squid.chainId,
                row.address,
              ),
              lenderKey: LENDER_KEY,
              chainId: squid.chainId,
              // Snapshots sit at UTC midnight already; flooring to the day
              // keeps 1h runs from inventing sub-daily buckets.
              dataTs: bucketStart(tsMs, "1d").toISOString(),
              observedTs: new Date(tsMs).toISOString(),
              source: "gmx-squid",
              depositRate: (fee ?? 0) + (borrowing ?? 0),
            };
          }

          if (rows.length < PAGE) break;
        }
        done += 1;
        ctx.onProgress?.(done, squids.length, `${LENDER_KEY} ${squid.chainId}`);
      }
    },
  };
}
