import {
  type Address,
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { compoundV3BaseData, compoundV3Pools } from "@1delta/data-sdk";
import { fetchLenderMetaFromDirAndInitialize } from "@1delta/initializer-sdk";

const LENDER_KEY = "COMPOUND_V3";

const HISTORICAL_SUMMARY_URL =
  "https://v3-api.compound.finance/market/all-networks/all-contracts/historical/summary";

/**
 * Compound's history endpoint is a **hard 30-day rolling window** — verified
 * repeatedly: 840 points = 28 comets × exactly 30 days, and the oldest day
 * falls off every night. Anything not captured within 30 days of happening is
 * gone from this source forever (DefiLlama keeps supply-side for ~106 of these
 * comets, but no borrow-side). It is the reason the daily capture job exists.
 * See LENDING_HISTORY_BACKFILL_PLAN.md §0.1.
 */
export const COMPOUND_V3_WINDOW_DAYS = 30;

/** `utilization` is 1e18-scaled; every other numeric field is a plain decimal
 *  string. The two APRs arrive as **fractions** (0.0399 = 3.99 %) and must be
 *  scaled to percent for the `HistoryPoint` contract. */
const WAD = 1e18;
const AS_PERCENT = 100;

export interface CompoundV3HistoricalPoint {
  chainId: number;
  comet: string;
  borrowApr: number;
  supplyApr: number;
  totalBorrowValue: string;
  totalSupplyValue: string;
  totalCollateralValue: string;
  utilization: string;
  basePriceUsd: number;
  collateralAssetSymbols: string[];
  timestamp: number;
  date: string;
}

interface RawHistoricalPoint {
  chain_id: number;
  comet: { address: string };
  borrow_apr: string;
  supply_apr: string;
  total_borrow_value: string;
  total_supply_value: string;
  total_collateral_value: string;
  utilization: string;
  base_usd_price: string;
  collateral_asset_symbols: string[];
  timestamp: number;
  date: string;
}

export async function fetchCompoundV3HistoricalApy(
  signal?: AbortSignal,
): Promise<CompoundV3HistoricalPoint[]> {
  const res = await fetch(HISTORICAL_SUMMARY_URL, { signal });
  if (!res.ok) {
    throw new Error(`[${LENDER_KEY}] historical summary HTTP ${res.status}`);
  }
  const raw = (await res.json()) as RawHistoricalPoint[];
  return raw.map((r) => ({
    chainId: r.chain_id,
    comet: r.comet.address,
    borrowApr: Number(r.borrow_apr),
    supplyApr: Number(r.supply_apr),
    totalBorrowValue: r.total_borrow_value,
    totalSupplyValue: r.total_supply_value,
    totalCollateralValue: r.total_collateral_value,
    utilization: r.utilization,
    basePriceUsd: Number(r.base_usd_price),
    collateralAssetSymbols: r.collateral_asset_symbols,
    timestamp: r.timestamp,
    date: r.date,
  }));
}

interface CometIdentity {
  /** Per-comet lender key, e.g. `COMPOUND_V3_USDC` — the uid's first segment,
   *  matching what the ownership fetcher writes. */
  lenderKey: string;
  underlying: Address;
}

/**
 * comet address → (lenderKey, base asset), resolved entirely offline from the
 * registry. The historical endpoint identifies markets only by comet address,
 * and the uid needs the base token, so without this map no row can be keyed.
 */
async function buildCometIndex(
  skipMetadataInit?: boolean,
): Promise<Map<string, CometIdentity>> {
  if (!skipMetadataInit) {
    await fetchLenderMetaFromDirAndInitialize({ compoundV3Pools: true });
  }
  const pools = compoundV3Pools() as Record<string, Record<string, string>>;
  const base = compoundV3BaseData() as Record<string, Record<string, { baseAsset: string }>>;

  const index = new Map<string, CometIdentity>();
  for (const [chainId, byLender] of Object.entries(pools ?? {})) {
    for (const [lenderKey, comet] of Object.entries(byLender ?? {})) {
      const baseAsset = base?.[lenderKey]?.[chainId]?.baseAsset;
      if (!baseAsset) continue;
      index.set(`${chainId}:${comet.toLowerCase()}`, {
        lenderKey,
        underlying: baseAsset.toLowerCase() as Address,
      });
    }
  }
  return index;
}

export interface CompoundV3HistoryConfig {
  skipMetadataInit?: boolean;
}

/**
 * Rates + totals for every comet, for whatever the 30-day window currently
 * holds. No index/accumulator: Compound V3 exposes none through this API, so
 * the realized-return half for these markets comes from archival replay
 * (plan §0.9 A6).
 */
export function createCompoundV3HistoryFetcher(
  config: CompoundV3HistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "compound-api",
    earliest: (now) => new Date(now.getTime() - COMPOUND_V3_WINDOW_DAYS * 86_400_000),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const [raw, cometIndex] = await Promise.all([
        fetchCompoundV3HistoricalApy(ctx.signal),
        buildCometIndex(config.skipMetadataInit),
      ]);

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const unresolved = new Set<string>();
      let emitted = 0;

      for (const r of raw) {
        const tsMs = r.timestamp * 1000;
        if (tsMs < from || tsMs > to) continue;

        const key = `${r.chainId}:${r.comet.toLowerCase()}`;
        const identity = cometIndex.get(key);
        if (!identity) {
          unresolved.add(key);
          continue;
        }

        const chainId = String(r.chainId) as ChainId;
        const totalDeposits = Number(r.totalSupplyValue);
        const totalDebt = Number(r.totalBorrowValue);
        yield {
          marketUid: makeMarketUid(identity.lenderKey, chainId, identity.underlying),
          lenderKey: identity.lenderKey,
          chainId,
          dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
          observedTs: new Date(tsMs).toISOString(),
          source: "compound-api",
          depositRate: r.supplyApr * AS_PERCENT,
          variableBorrowRate: r.borrowApr * AS_PERCENT,
          totalDeposits,
          totalDebt,
          totalDepositsUsd: totalDeposits * r.basePriceUsd,
          totalDebtUsd: totalDebt * r.basePriceUsd,
          utilization: Number(r.utilization) / WAD,
        };
        emitted += 1;
      }

      if (unresolved.size > 0) {
        // Loud, not silent: an unmapped comet is a market whose entire history
        // we are dropping, and the window it is dropping from is decaying.
        console.warn(
          `[${LENDER_KEY}] ${unresolved.size} comet(s) not in the registry — no uid, rows dropped: ${[...unresolved].slice(0, 5).join(", ")}`,
        );
      }
      ctx.onProgress?.(emitted, emitted, `${LENDER_KEY} window`);
    },
  };
}
