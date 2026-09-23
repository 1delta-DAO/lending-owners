/**
 * Lending families whose only history source is a third-party API, and which
 * have no ownership package of their own to hang a `hist/` module on. Keyed
 * by the LENDING family so rows land in `lending_snapshots` — the earn-side
 * `VAULT_*` modules in `fetcher-vaults` read some of the same routes but emit
 * vault uids no `markets` row carries.
 */
export { createFluidLendingHistoryFetcher } from "./fluid.js";
export {
  createDefiLlamaLendingHistoryFetcher,
  type DefiLlamaLendingConfig,
} from "./defillama.js";
export { createAaveV4HistoryFetcher } from "./aaveV4.js";
