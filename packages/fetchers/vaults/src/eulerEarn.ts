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
 * Euler Earn vaults — VAULT_HISTORY_BACKFILL_PLAN.md §2.3 "euler-earn" row and
 * HISTORY_GAPS §3.3's first bullet.
 *
 * Roster: `GET /v3/earn/vaults?chainId=&visibility=visible,warning,hidden`.
 * The `visibility` param is not optional in practice — it is the empty-default
 * trap the plan warns about: every Earn vault is `hidden` or `pending_review`,
 * so the default listing is empty and the module would silently collect
 * nothing. `visibility=all` is rejected outright (the API enumerates its
 * allowed values in the 400 body), so the three real values are passed.
 *
 * History: `GET /v3/earn/vaults/{chainId}/{address}/totals?resolution=&from=&to=`
 * → `data.history[] = {timestamp, totalAssets, totalAssetsUsd, sharePrice, apy}`.
 * Verified 2026-09-09 on a live vault: 136 daily points from the 2026-04-23
 * recorder floor. Depth is per-vault and patchy — a vault created after the
 * floor starts at its creation, one created before still starts at the floor,
 * and the plan measured vaults with two zeroed rows and nothing else. Archival
 * 4626 reads remain the trustworthy series; this is the cheap 80 %.
 *
 * One correction to the plan from this build: `totalAssetsUsd` is NOT always
 * null — it is populated on the live vaults probed here, and only the
 * `sharePriceQuote` sub-object is missing on older rows.
 *
 * Units: `apy` is PERCENT (3.60 = 3.60 %), matching the rest of the Euler API
 * and opposite to Morpho's fractions. `sharePrice` is assets-per-share.
 */

const LENDER_KEY = "VAULT_EULER_EARN";
const API = "https://v3.euler.finance/v3";
const VISIBILITY = "visible,warning,hidden";

/** Same deployments the EVK lending module walks. */
const DEFAULT_CHAINS = ["1", "130", "8453", "42161", "43114", "56", "9745", "146"] as ChainId[];

/** Their recorder's start — nothing before this exists on any route. */
const FLOOR_MS = Date.parse("2026-04-23T00:00:00Z");

interface EarnVault {
  address?: string;
  symbol?: string;
}
interface RosterResponse {
  data?: EarnVault[];
}
interface TotalsRow {
  timestamp?: string;
  totalAssets?: string;
  totalAssetsUsd?: number | null;
  sharePrice?: number | null;
  apy?: number | null;
}
interface TotalsResponse {
  data?: { history?: TotalsRow[] };
}

export function createEulerEarnVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "euler-earn-api",
    earliest: () => new Date(FLOOR_MS),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const chains = (ctx.chainIds ?? DEFAULT_CHAINS).filter(Boolean);
      // Asking before the floor returns `[]` rather than an error, so clamp
      // and let the runner's `earliest` warning explain the rest.
      const fromMs = Math.max(ctx.from.getTime(), FLOOR_MS);
      const toMs = ctx.to.getTime();
      if (fromMs > toMs) return;
      const range = `from=${Math.floor(fromMs / 1000)}&to=${Math.ceil(toMs / 1000)}`;

      for (const chainId of chains) {
        let roster: EarnVault[] = [];
        try {
          const res = await client.getJson<RosterResponse>(
            `${API}/earn/vaults?chainId=${chainId}&visibility=${VISIBILITY}`,
          );
          roster = res.data ?? [];
        } catch (err) {
          // A chain with no Earn deployment 400s; that is not a run failure.
          console.warn(`[${LENDER_KEY}] chain ${chainId} roster failed: ${(err as Error).message}`);
          continue;
        }

        let done = 0;
        for (const vault of roster) {
          const address = vault.address;
          done += 1;
          if (!address) continue;

          let rows: TotalsRow[] = [];
          try {
            const res = await client.getJson<TotalsResponse>(
              `${API}/earn/vaults/${chainId}/${address}/totals?resolution=${ctx.resolution}&${range}`,
            );
            rows = res.data?.history ?? [];
          } catch (err) {
            console.warn(
              `[${LENDER_KEY}] ${chainId}:${address} totals failed: ${(err as Error).message}`,
            );
            continue;
          }

          const marketUid = makeMarketUid(LENDER_KEY, chainId, address);
          for (const row of rows) {
            const tsMs = Date.parse(row.timestamp ?? "");
            if (!Number.isFinite(tsMs) || tsMs < fromMs || tsMs > toMs) continue;
            const apy = num(row.apy);
            const pps = num(row.sharePrice);
            const assets = num(row.totalAssetsUsd);
            // Creation-row padding: a vault's first rows are all zero on every
            // field, which is not a measurement of anything.
            if ((apy ?? 0) === 0 && (pps ?? 0) === 0 && (assets ?? 0) === 0) continue;

            yield {
              marketUid,
              lenderKey: LENDER_KEY,
              chainId,
              dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
              source: "euler-earn-api",
              depositRate: apy, // already percent
              totalDepositsUsd: assets,
              supplyIndex: decimalString(pps),
              indexKind: pps === undefined ? undefined : "assets_per_share",
            };
          }
          ctx.onProgress?.(done, roster.length, `${LENDER_KEY} ${chainId} ${vault.symbol ?? address}`);
        }
      }
    },
  };
}
