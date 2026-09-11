import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { fractionToPercent, num } from "./shared.js";

/**
 * `VAULT_LISASTER` — Lista's lisAster reward rate, self-archived.
 *
 * lisAster (BNB, `0xa17a…9f06`) is a 1:1 one-way lock receipt over ASTER with
 * NO exchange rate and NO redemption: the ~23–26 % it pays is a weekly Merkle
 * CLAIM in lisAster, computed off-chain, and Moolah collateral counts as
 * staked (Lista FAQ, reconciled on-chain 2026-09-11 — see the memory note
 * `lista-lisaster`). So there is no accumulator to replay and nothing on-chain
 * says what the rate was last week: `api.lista.org/api/lisaster/overview`
 * serves the CURRENT `lisasterApy` and `currentEpochId` only, and
 * `datachart/history?name=lisAster*` answers empty. The daily run is
 * therefore the archive — hence `DECAYING`.
 *
 * Units: `lisasterApy` is a FRACTION (`0.2633`), converted to percent here.
 * It is an APY on a CLAIMED reward, not an accrual, and the token's price never
 * moves — say so wherever the series is shown. `soloStakingApy` (the
 * explicit-stake path) is deliberately not recorded: one series, one meaning.
 *
 * The uid leaf is the TOKEN, because there is no vault: the rate is what a
 * lisAster holder earns wherever the token sits (staking contract or Moolah).
 */

const LENDER_KEY = "VAULT_LISASTER";
const CHAIN_ID = "56" as ChainId;
const API = "https://api.lista.org/api/lisaster/overview";
const LISASTER = "0xa17a497d20cc143508fe3b63578b13ba6b9c9f06";

interface OverviewResponse {
  code?: string;
  data?: {
    tvlUsd?: string | number;
    totalStakedAster?: string | number;
    lisasterApy?: string | number;
    soloStakingApy?: string | number;
    currentEpochId?: number;
    updatedAt?: number;
  };
}

export function createLisAsterHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "lista-api",
    // Nothing older than the run itself exists upstream.
    earliest: (now) => now,

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({ label: LENDER_KEY, concurrency: 1, minIntervalMs: 200, signal: ctx.signal });
      const res = await client.getJson<OverviewResponse>(API);
      const d = res.data;
      const apy = num(d?.lisasterApy);
      if (apy === undefined) {
        console.warn(`[${LENDER_KEY}] overview carried no lisasterApy`);
        return;
      }
      // `updatedAt` is the API's own stamp (seconds); the point is bucketed on
      // it so two runs in one day collapse to one row.
      const tsMs = d?.updatedAt ? d.updatedAt * 1000 : Date.now();
      if (tsMs < ctx.from.getTime() || tsMs > ctx.to.getTime() + 86_400_000) return;
      yield {
        marketUid: makeMarketUid(LENDER_KEY, CHAIN_ID, LISASTER),
        lenderKey: LENDER_KEY,
        chainId: CHAIN_ID,
        dataTs: bucketStart(tsMs, "1d").toISOString(),
        observedTs: new Date(tsMs).toISOString(),
        source: "lista-api",
        depositRate: fractionToPercent(apy),
        totalDepositsUsd: num(d?.tvlUsd),
        // `totalStakedAster` is `LisAsterStaking.totalSupply()` only — the
        // explicit-stake base, NOT the reward base (Moolah collateral is
        // eligible too). Recorded as the size the API publishes.
        totalDeposits: num(d?.totalStakedAster),
      };
      ctx.onProgress?.(1, 1, `${LENDER_KEY} lisAster epoch ${d?.currentEpochId ?? "?"}`);
    },
  };
}
