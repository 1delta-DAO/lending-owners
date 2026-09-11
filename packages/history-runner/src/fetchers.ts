import type { HistoryFetcher } from "@lending-owners/core";
import { loadAaveV3Reserves } from "./reserves.js";
import { createAaveV3HistoryFetcher } from "@lending-owners/fetcher-aave-v3";
import { createCompoundV3HistoryFetcher } from "@lending-owners/fetcher-compound-v3";
import { createEulerHistoryFetcher } from "@lending-owners/fetcher-euler";
import { createLlamaLendHistoryFetcher } from "@lending-owners/fetcher-llamalend";
import { createMoonwellHistoryFetcher } from "@lending-owners/fetcher-moonwell";
import { createMorphoBlueHistoryFetcher } from "@lending-owners/fetcher-morpho-blue";
import {
  createCapVaultHistoryFetcher,
  createDefiLlamaVaultHistoryFetcher,
  createEulerEarnVaultHistoryFetcher,
  createFalconVaultHistoryFetcher,
  createFluidVaultHistoryFetcher,
  createGearboxVaultHistoryFetcher,
  createGmxVaultHistoryFetcher,
  createHyperbeatVaultHistoryFetcher,
  createHypercoreVaultHistoryFetcher,
  createLagoonVaultHistoryFetcher,
  createMorphoVaultHistoryFetcher,
  createPendleVaultHistoryFetcher,
  createReVaultHistoryFetcher,
  createSdolaVaultHistoryFetcher,
  createSfrxusdVaultHistoryFetcher,
  createSiloVaultHistoryFetcher,
  createSkyVaultHistoryFetcher,
  createSparkSavingsVaultHistoryFetcher,
  createStrataVaultHistoryFetcher,
  createToriVaultHistoryFetcher,
  createUpshiftVaultHistoryFetcher,
  createUsddVaultHistoryFetcher,
  createWrenVaultHistoryFetcher,
  createYoVaultHistoryFetcher,
  createYearnVaultHistoryFetcher,
  createYieldBasisVaultHistoryFetcher,
  createOnchainVaultHistoryFetcher,
  createLisAsterHistoryFetcher,
  createBitfiVaultHistoryFetcher,
} from "@lending-owners/fetcher-vaults";
import { createVenusHistoryFetcher } from "@lending-owners/fetcher-venus";

/**
 * Which lenders the history runner can fetch, kept apart from the CLI so a
 * second tool can ask "what is registered?" without running a backfill:
 * `index.ts` calls `main()` at import time, so importing it to read the
 * registry would start a run. `coverage.ts` needs exactly this list to tell a
 * key with no data from a key with no module.
 */
export type FetcherFactory = () => HistoryFetcher;

/** Registry. Add a lender here once its `hist/` module exists. */
export const FETCHERS: Record<string, FetcherFactory> = {
  AAVE_V3: () => createAaveV3HistoryFetcher({ reserves: loadAaveV3Reserves() }),
  COMPOUND_V3: () => createCompoundV3HistoryFetcher({ skipMetadataInit: true }),
  EULER: () => createEulerHistoryFetcher(),
  LLAMALEND: () => createLlamaLendHistoryFetcher(),
  MOONWELL: () => createMoonwellHistoryFetcher(),
  MORPHO_BLUE: () => createMorphoBlueHistoryFetcher(),
  VENUS: () => createVenusHistoryFetcher(),
  // Vault providers (the earn surface). Source matrix + traps:
  // margin-fetcher `src/vaults/HISTORY_APIS.md`. Uids are
  // `VAULT_<PROVIDER>:<chainId>:<vaultAddress>` and deliberately do NOT join
  // the lending `markets` table — the SQL export skips them until a vault
  // ingest exists.
  VAULT_CAP: () => createCapVaultHistoryFetcher(),
  VAULT_FLUID: () => createFluidVaultHistoryFetcher(),
  VAULT_GEARBOX: () => createGearboxVaultHistoryFetcher(),
  VAULT_GMX: () => createGmxVaultHistoryFetcher(),
  VAULT_HYPERBEAT: () => createHyperbeatVaultHistoryFetcher(),
  VAULT_HYPERCORE: () => createHypercoreVaultHistoryFetcher(),
  VAULT_LAGOON: () => createLagoonVaultHistoryFetcher(),
  VAULT_MORPHO: () => createMorphoVaultHistoryFetcher(),
  VAULT_PENDLE: () => createPendleVaultHistoryFetcher(),
  VAULT_SILO: () => createSiloVaultHistoryFetcher(),
  VAULT_UPSHIFT: () => createUpshiftVaultHistoryFetcher(),
  VAULT_YEARN: () => createYearnVaultHistoryFetcher(),
  VAULT_YIELDBASIS: () => createYieldBasisVaultHistoryFetcher(),
  // Savings-registry sources (2026-09-09). Each one closes a HISTORY_GAPS
  // §3.1/§3.3 line; the module header cites the matrix row it implements and
  // states its retention, which is what decides membership in DECAYING below.
  VAULT_FALCON: () => createFalconVaultHistoryFetcher(),
  VAULT_RE: () => createReVaultHistoryFetcher(),
  VAULT_SDOLA: () => createSdolaVaultHistoryFetcher(),
  VAULT_SFRXUSD: () => createSfrxusdVaultHistoryFetcher(),
  VAULT_SKY: () => createSkyVaultHistoryFetcher(),
  VAULT_SPARK: () => createSparkSavingsVaultHistoryFetcher(),
  VAULT_TORI: () => createToriVaultHistoryFetcher(),
  VAULT_WREN: () => createWrenVaultHistoryFetcher(),
  VAULT_EULER_EARN: () => createEulerEarnVaultHistoryFetcher(),
  VAULT_STRATA: () => createStrataVaultHistoryFetcher(),
  VAULT_USDD: () => createUsddVaultHistoryFetcher(),
  VAULT_YO: () => createYoVaultHistoryFetcher(),
  VAULT_LLAMA: () => createDefiLlamaVaultHistoryFetcher(),
  // The "no upstream history" rows (2026-09-11, HISTORY_GAPS §3.1/§3.3):
  // a generic archival share-price replay over every savings source without a
  // module (Saturn, the Venus Liquidity Hub, Vesper, Neutrl, Parallel, Theo,
  // Angle, Avant, OpenEden, Maple, YieldFi, Resolv, Reservoir, Resupply,
  // InfiniFi, Hastra, f(x), scrvUSD, Hyperbeat's pricer, Native, Bitway — 167
  // rows), BitFi's on-chain epoch ledgers, and the lisAster reward rate.
  VAULT_ONCHAIN: () => createOnchainVaultHistoryFetcher(),
  VAULT_BITFI: () => createBitfiVaultHistoryFetcher(),
  VAULT_LISASTER: () => createLisAsterHistoryFetcher(),
};

/**
 * Sources whose window is a rolling one — data older than the window is gone
 * from the API for good. These are what `--decaying` selects, and they are the
 * only part of the plan that gets worse by waiting (plan §0.1).
 */
export const DECAYING: string[] = [
  "COMPOUND_V3",
  "LLAMALEND",
  "VAULT_CAP",
  "VAULT_GEARBOX",
  // Added 2026-09-09 with the savings modules. Blockanalitica's `days_ago` is a
  // 365-day whitelist (bigger is an HTTP 500, not a clamp), Falcon caps at 365
  // rolling points, and Tori serves exactly 30 — so for all four, a day not
  // captured is a day gone.
  "VAULT_FALCON",
  "VAULT_SKY",
  "VAULT_SPARK",
  "VAULT_TORI",
  // YO's yield route is a fixed 30-day window whatever the params say (its TVL
  // route is full-depth, so only half of this source decays).
  "VAULT_YO",
  // Aave's API window is the `TimeWindow` enum, whose widest value is
  // LAST_YEAR — a 365-day roll. The module has existed since the first build
  // but was never in the daily set, so the tail was being lost.
  "AAVE_V3",
  // 2026-09-11. Neither of these has a rolling window in the usual sense —
  // they have NO upstream window at all. lisAster's API serves the current
  // rate and nothing else, so the daily run is the archive. VAULT_ONCHAIN is
  // archival where a chain's public endpoints serve old state and head-only
  // where they do not (BNB has 2 of 27; several chains have none), and on
  // those chains a day nobody samples is a day nobody can sample later.
  "VAULT_LISASTER",
  "VAULT_ONCHAIN",
];
