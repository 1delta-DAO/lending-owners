/**
 * Vault-provider history fetchers — the earn-surface counterpart of the
 * per-lender `hist/` modules. One module per provider; the curl-verified
 * source matrix (endpoints, retention, units, traps) is margin-fetcher's
 * `src/vaults/HISTORY_APIS.md` and every module cites its row.
 */
export { createCapVaultHistoryFetcher } from "./cap.js";
export { createFluidVaultHistoryFetcher } from "./fluid.js";
export { createGearboxVaultHistoryFetcher } from "./gearbox.js";
export { createGmxVaultHistoryFetcher } from "./gmx.js";
export { createHyperbeatVaultHistoryFetcher } from "./hyperbeat.js";
export { createHypercoreVaultHistoryFetcher } from "./hypercore.js";
export { createLagoonVaultHistoryFetcher } from "./lagoon.js";
export { createMorphoVaultHistoryFetcher } from "./morpho.js";
export { createPendleVaultHistoryFetcher } from "./pendle.js";
export { createSiloVaultHistoryFetcher } from "./silo.js";
export { createUpshiftVaultHistoryFetcher } from "./upshift.js";
export { createYearnVaultHistoryFetcher } from "./yearn.js";
export { createYieldBasisVaultHistoryFetcher } from "./yieldbasis.js";
