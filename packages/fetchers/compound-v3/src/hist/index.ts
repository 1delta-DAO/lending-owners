const LENDER_KEY = "COMPOUND_V3";

const HISTORICAL_SUMMARY_URL =
  "https://v3-api.compound.finance/market/all-networks/all-contracts/historical/summary";

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

export async function fetchCompoundV3HistoricalApy(): Promise<CompoundV3HistoricalPoint[]> {
  const res = await fetch(HISTORICAL_SUMMARY_URL);
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
