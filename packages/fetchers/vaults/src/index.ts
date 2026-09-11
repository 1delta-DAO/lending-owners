/**
 * Vault-provider history fetchers — the earn-surface counterpart of the
 * per-lender `hist/` modules. One module per provider; the curl-verified
 * source matrix (endpoints, retention, units, traps) is margin-fetcher's
 * `src/vaults/HISTORY_APIS.md` and every module cites its row.
 */
export { createCapVaultHistoryFetcher } from "./cap.js";
export { createDefiLlamaVaultHistoryFetcher } from "./defillama.js";
export { createEulerEarnVaultHistoryFetcher } from "./eulerEarn.js";
export { createFalconVaultHistoryFetcher } from "./falcon.js";
export { createFluidVaultHistoryFetcher } from "./fluid.js";
export { createGearboxVaultHistoryFetcher } from "./gearbox.js";
export { createGmxVaultHistoryFetcher } from "./gmx.js";
export { createHyperbeatVaultHistoryFetcher } from "./hyperbeat.js";
export { createHypercoreVaultHistoryFetcher } from "./hypercore.js";
export { createLagoonVaultHistoryFetcher } from "./lagoon.js";
export { createMorphoVaultHistoryFetcher } from "./morpho.js";
export { createPendleVaultHistoryFetcher } from "./pendle.js";
export { createReVaultHistoryFetcher } from "./re.js";
export { createSdolaVaultHistoryFetcher } from "./sdola.js";
export { createSfrxusdVaultHistoryFetcher } from "./sfrxusd.js";
export { createSiloVaultHistoryFetcher } from "./silo.js";
export { createSkyVaultHistoryFetcher } from "./sky.js";
export { createSparkSavingsVaultHistoryFetcher } from "./sparkSavings.js";
export { createStrataVaultHistoryFetcher } from "./strata.js";
export { createToriVaultHistoryFetcher } from "./tori.js";
export { createUpshiftVaultHistoryFetcher } from "./upshift.js";
export { createUsddVaultHistoryFetcher } from "./usdd.js";
export { createWrenVaultHistoryFetcher } from "./wren.js";
export { createYoVaultHistoryFetcher } from "./yo.js";
export { createYearnVaultHistoryFetcher } from "./yearn.js";
export { createYieldBasisVaultHistoryFetcher } from "./yieldbasis.js";
// 2026-09-11 — the "no upstream history" rows of HISTORY_GAPS §3.1/§3.3.
export { createOnchainVaultHistoryFetcher, ONCHAIN_VAULTS, type OnchainVaultRow } from "./onchain.js";
export { createLisAsterHistoryFetcher } from "./lisaster.js";
export { createBitfiVaultHistoryFetcher } from "./bitfi.js";
