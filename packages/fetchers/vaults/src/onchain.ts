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
 * `VAULT_ONCHAIN` — the share-price REPLAY for every earn-side source with no
 * upstream history API: archival `eth_call` at one block per day, pinned by
 * `coins.llama.fi/block`. HISTORY_GAPS §3.1's last line ("archival
 * `convertToAssets` replay (plan §0.9 A6) still open") and §3.3's "most are
 * 4626/rate-getter archival-reconstructible" — this is that module, generic
 * over the six rate getters the savings registry actually uses.
 *
 * Why one module and not one per protocol: the thing being read is the same
 * accumulator everywhere — assets-per-share at a block — and a share price is
 * the ONE series that is exact by construction (two samples give the realized
 * return, no rate model in between). What differs per protocol is only the
 * getter and its scale, which is a row in the roster, not a module.
 *
 * ## The roster is generated, then hand-pinned
 *
 * Rows were emitted from margin-fetcher's `SAVINGS_REGISTRY` on 2026-09-11
 * (every entry whose brand has no history module here) and pasted, because
 * this workspace does not depend on lending-sdks. Re-run the generator when
 * the registry grows; do not edit an address by hand without re-verifying the
 * getter — `kind` decides the SELECTOR and the SCALE, and a wrong pair reads
 * cleanly as a wrong number.
 *
 * ## What each kind reads
 *
 *  - `erc4626`            `convertToAssets(10^shareDec)` + `totalAssets()`, both
 *                         in the asset's decimals. Saturn sUSDat, the Venus
 *                         Liquidity Hub, Neutrl, Parallel, Theo, Angle, Avant,
 *                         OpenEden, Maple, YieldFi, Resolv, Reservoir, Resupply,
 *                         InfiniFi, Hastra, f(x), scrvUSD.
 *  - `vesperPricePerShare` Vesper's `pricePerShare()` is UNDERLYING-scaled (the
 *                         1e12 trap on the 6-dec pools) + `totalValue()`.
 *  - `hyperbeatPricer`    the vault's Pricer `getRate()` at 8 decimals — the
 *                         series HISTORY_GAPS §3.1 says must be recorded
 *                         forward because Hyperbeat's API is APY-only.
 *  - `navOracle`          a Chainlink-shaped feed's `latestRoundData().answer`
 *                         at the block (Theo's RedStone feed on Stable).
 *  - `nativeWnlp`         `getNlpByWnlp(1e18)`, NTLP per wNLP, 1e18-scaled.
 *  - `bitway`             the PARENT vault's two-arg
 *                         `convertToAssets(10^dec, underlying)`.
 *
 * ## Archival is probed, never assumed
 *
 * The RPC roster is the `rpc-tester` list per chain, and most public
 * endpoints on it are pruned: on 2026-09-11, 5 of 13 Ethereum endpoints and
 * 2 of 27 BNB endpoints served a 30–90-day-old `eth_call`. The module probes
 * every endpoint at the run's OLDEST block and keeps the ones that answer;
 * with none, it logs the chain and still records TODAY (the head is never
 * pruned), which makes the daily run a forward archive on exactly the chains
 * where a backfill is impossible. Hence `VAULT_ONCHAIN` is in `DECAYING`: not
 * because a source rolls, but because a day nobody samples on a pruned chain
 * is a day nobody can sample later.
 *
 * ## Block pinning
 *
 * `coins.llama.fi/block/{slug}/{ts}` is free and exact for the chains it
 * indexes; the rest (Robinhood, Stable, X Layer, Morph) fall back to a
 * bisection over `eth_getBlockByNumber`, cached per day. Either way the block
 * is stamped on the point, so a consumer can re-read the same state.
 *
 * ## Saturn specifically
 *
 * This is the BALANCE-SHEET series for sUSDat. DefiLlama's pool (a `VAULT_LLAMA`
 * row) reports the vault's income leg (~13 %); `convertToAssets` carries the
 * STRC mark as well, and over the vault's life the two disagree by ~8.5 pp with
 * a −22.8 % drawdown in between. See lending-sdks `SATURN.md` §1. Both series
 * are kept because they answer different questions.
 */

const LENDER_KEY = "VAULT_ONCHAIN";
const RPC_LIST = "https://raw.githubusercontent.com/1delta-DAO/rpc-tester/main/rpcs";
const LLAMA_BLOCK = "https://coins.llama.fi/block";

export type OnchainKind =
  | "erc4626"
  | "vesperPricePerShare"
  | "hyperbeatPricer"
  | "navOracle"
  | "nativeWnlp"
  | "bitway";

export interface OnchainVaultRow {
  chainId: ChainId;
  /** The share token — the uid leaf. */
  address: string;
  symbol: string;
  brand: string;
  shareDecimals: number;
  assetDecimals: number;
  kind: OnchainKind;
  /** `navOracle`: the feed and its answer decimals. */
  oracle?: string;
  oracleDecimals?: number;
  /** `hyperbeatPricer`: the vault's Pricer. */
  pricer?: string;
  /** `bitway`: the parent staking vault every read goes to, and the leg. */
  stakingVault?: string;
  underlying?: string;
}

/** Chains the `rpc-tester` repo carries no list for (404). The vault side
 *  reaches them through the same single public endpoint margin-fetcher uses;
 *  whether that endpoint serves old state is probed like any other. */
const EXTRA_RPCS: Record<string, string[]> = {
  "988": ["https://rpc.stable.xyz"],
  "4663": ["https://rpc.mainnet.chain.robinhood.com"],
};

/** DefiLlama's chain slugs for `/block`. Chains not here use RPC bisection. */
const LLAMA_SLUG: Record<string, string> = {
  "1": "ethereum",
  "10": "optimism",
  "56": "bsc",
  "100": "xdai",
  "143": "monad",
  "8453": "base",
  "42161": "arbitrum",
  "43114": "avax",
  "59144": "linea",
  "999": "hyperliquid",
};

/** Generated from margin-fetcher `SAVINGS_REGISTRY` 2026-09-11 — see header. */
export const ONCHAIN_VAULTS: readonly OnchainVaultRow[] = [
  { chainId: "1" as ChainId, address: "0x08efcc2f3e61185d0ea7f8830b3fec9bfa2ee313", symbol: "sNUSD", brand: "Neutrl", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xd166337499e176bbc38a1fbd113ab144e5bd2df7", symbol: "sUSDat", brand: "Saturn", shareDecimals: 18, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xda06ee2dacf9245aa80072a4407debdea0d7e341", symbol: "savETH", brand: "Avant", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x557ab1e003951a73c12d16f0fea8490e39c33c35", symbol: "sreUSD", brand: "Resupply", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x7743e50f534a7f9f1791dde7dcd89f7783eefc39", symbol: "fxSAVE", brand: "f(x) Protocol", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xd3fd63209fa2d55b07a0f6db36c2f43900be3094", symbol: "wsrUSD", brand: "Reservoir", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x1202f5c7b4b9e47a1a484e8b270be34dbbc75055", symbol: "wstUSR", brand: "Resolv", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xdbdc1ef57537e34680b898e1febd3d68c7389bcb", symbol: "siUSD", brand: "InfiniFi", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x80ac24aa929eaf5013f6436cda2a7ba190f5cc0b", symbol: "syrupUSDC", brand: "Maple", shareDecimals: 6, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x356b8d89c1e1239cbbb9de4815c39a1474d5ba7d", symbol: "syrupUSDT", brand: "Maple", shareDecimals: 6, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x87b65c4aaffa76881f9e96f3e7ed945ddfc3cd7a", symbol: "syrupUSDG", brand: "Maple", shareDecimals: 6, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x19ebb35279a16207ec4ba82799cc64715065f7f6", symbol: "PRIME", brand: "Hastra", shareDecimals: 6, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x0655977feb2f289a4ab78af67bab0d17aab84367", symbol: "scrvUSD", brand: "Curve", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xa808bc9775cb41c52c7842f8b50427fe7a770326", symbol: "sthUSD", brand: "Theo", shareDecimals: 6, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x0022228a2cc5e7ef0274a7baa600d44da5ab5776", symbol: "stUSD", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x004626a008b1acdc4c74ab51644093b155e59a23", symbol: "stEUR", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x19ebd191f7a24ece672ba13a302212b5ef7f35cb", symbol: "yUSD", brand: "YieldFi", shareDecimals: 18, assetDecimals: 6, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x0d45b129dc868963025db79a9074ea9c9e32cae4", symbol: "sUSDp", brand: "Parallel", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0xad55aebc9b8c03fc43cd9f62260391c13c23e7c0", symbol: "cUSDO", brand: "OpenEden", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "1" as ChainId, address: "0x50ecabe78ae99bb1adc292a94e535feb0ed29853", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x9441f31ab75f466a8afdc67a0fa65241f7600f5a", symbol: "wNLP-WBTC", brand: "Native", shareDecimals: 8, assetDecimals: 8, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xc31daeeb822790e9ca730e7e34a9ef497fffc959", symbol: "wNLP-USDT", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x3c339289baa2eab3802c1f0c10e025b29bdbea1a", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xb88791ef86d10037f7481b4e3fcbca5bb4162bfa", symbol: "wNLP-STONEUSD", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xaeb7c9122d897a224180d2ca25bc86a16d12ae92", symbol: "wNLP-CRCLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x66924f881bd0cbfabded19838c5f5443867359d9", symbol: "wNLP-GOOGLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xb5cebfa986dd20a674be725bacebabec458abc84", symbol: "wNLP-INTCon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x3b1dbe5ca2d39fac168e3575d707b714a7eaa7e7", symbol: "wNLP-MRVLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x1e42d39df3e927c0765f258a8b7f75726350f41b", symbol: "wNLP-MUon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xe74ee33a50a9eab6f62cb22f44b1e72e5579894c", symbol: "wNLP-NVDAon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xe05f1635756b6f5046e53f8e911a14794a73a4e7", symbol: "wNLP-QQQon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xbffaaa25d2b8fe6e3e8c2c790673fa0c28c64bd4", symbol: "wNLP-SPCXon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x0183d055c77310af03dcb397efaa7e9cfb6db59b", symbol: "wNLP-TSLAon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x2ba837484e8969da87d237effedea7badd294dd9", symbol: "wNLP-CRCLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x8425b76b81008d6b8f0ed468d72a2098fc13b2d2", symbol: "wNLP-GOOGLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x2014e669ab74e114aa155c6b9c162bb26a5b9972", symbol: "wNLP-NVDAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x12a81e5b0721e62d907ae5527031fb29f9eef323", symbol: "wNLP-QQQx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x405a559b5c0fcb207ddd60dd2b87e9f6b5798564", symbol: "wNLP-SPCXx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x95603e6d7753833b1ad9feba5f4e7213ba5b1d8a", symbol: "wNLP-TSLAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xa15100ee8c648dd9d01271424bface4891aa2e8f", symbol: "wNLP-PAXG", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x894e71b1cdf9fb8775d54dd911d60d5bd2a0e256", symbol: "wNLP-XAUt", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x72bc5907f4bd6963a145cad7fe6538927062bec4", symbol: "wNLP-tGLD", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0x4aa3d1cca957ee0c21333b7465fc94feab45037a", symbol: "wNLP-DRAMon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "1" as ChainId, address: "0xca7c607c590ad16007ccbbba9d26f4df656a36c2", symbol: "vamsETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "1" as ChainId, address: "0x4c73f025a1947ec770327b9956fc61f535f72c22", symbol: "vamsUSD", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "1" as ChainId, address: "0x4dbe3f01abe271d3e65432c74851625a8c30aa7b", symbol: "vaSTETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "1" as ChainId, address: "0xd1c117319b3595fbc39b471ab1fd485629eb05f2", symbol: "vaETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "1" as ChainId, address: "0xa8b607aa09b6a2e306f93e74c282fb13f6a80452", symbol: "vaUSDC", brand: "Vesper", shareDecimals: 18, assetDecimals: 6, kind: "vesperPricePerShare" },
  { chainId: "1" as ChainId, address: "0x0538c8bac84e95a9df8ac10aad17dbe81b9e36ee", symbol: "vaDAI", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "10" as ChainId, address: "0x0022228a2cc5e7ef0274a7baa600d44da5ab5776", symbol: "stUSD", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "10" as ChainId, address: "0xdd63ae655b388cd782681b7821be37fdb6d0e78d", symbol: "vawstETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "10" as ChainId, address: "0x539505dde2b9771debe0898a84441c5e7fdf6bc0", symbol: "vaUSDC", brand: "Vesper", shareDecimals: 18, assetDecimals: 6, kind: "vesperPricePerShare" },
  { chainId: "10" as ChainId, address: "0xccf3d1acf799bae67f6e354d685295557cf64761", symbol: "vaETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "56" as ChainId, address: "0x64748ea3e31d0b7916f0ff91b017b9f404ded8ef", symbol: "cUSDO", brand: "OpenEden", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "56" as ChainId, address: "0x85f08a266758ea0c98b15deae71ca6ee84392afa", symbol: "wNLP-WBNB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xfafae0cdec65cdd601ffc39f472dd4f5c7bd0721", symbol: "wNLP-ETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xea5ff211ef700dccc521a1e6501c9fe1b95d8ee7", symbol: "wNLP-USDT", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x8592ffff658310150befd83c3c5de326e9bf6f0d", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x2f6f303924f0fdc559c57a14cb73dd9a4d611bd8", symbol: "wNLP-USD1", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xa1cc671f9b975d0a548c436175b99891db961934", symbol: "wNLP-STONEUSD", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x50fbc992085b065a404fb007e344d49c558047b2", symbol: "wNLP-CRCLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x14e13011121fa293d20a4d9a7037814f3c932860", symbol: "wNLP-GOOGLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x6b3de4f43d20c7b29bca9850dfbf6bf94824e67e", symbol: "wNLP-INTCon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x0d8de51813ef9b8634d3b91086884d3045a5f3e8", symbol: "wNLP-MRVLon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x3a18cde8a81060bdc7cace60ecbc2f01765f6008", symbol: "wNLP-MUon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x493fb39c8e37726539d3fb074c333a1eab58e36b", symbol: "wNLP-NVDAon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x03e7dce34eed4adc4b228d00a28deba2b7941266", symbol: "wNLP-QQQon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xb810dc8f7ffc2318931b4af211592eac5e1d0190", symbol: "wNLP-SPCXon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x73be73e7570fbcbd3d83de1e32ae5594c3963fe1", symbol: "wNLP-TSLAon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x90cc94befe6c6437de7c6ded32a4dc25ebbee3d2", symbol: "wNLP-DRAMon", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xddfe8d98a0b459a2a2906e02ab3dd5a5bbc303c8", symbol: "wNLP-CRCLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xa8d9eb043d4bc05e4b0dac89cd5837cf40fb3bc5", symbol: "wNLP-GOOGLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x358100ed7ecdd6c608d9d5e642e34b1a2ba152b7", symbol: "wNLP-NVDAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x427fb58709c47fb8794771bd2e17784c0cda845a", symbol: "wNLP-QQQx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x335d144f211c3f4dedb3ef1fe003cbc7dd9c24a9", symbol: "wNLP-SPCXx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xbcac5180fc867d741d06e1aafde15d65ca16d3f3", symbol: "wNLP-TSLAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xd8a25f5e864534bb2324f2eff6f5c3dd58693b8b", symbol: "wNLP-A4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x16ccbca076c24d1c174cddc8ce30389097bf8982", symbol: "wNLP-COINB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xe05f1635756b6f5046e53f8e911a14794a73a4e7", symbol: "wNLP-C4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x52207f4c347631abb40484e30c71fa66660581a7", symbol: "wNLP-DRAMB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x3dac466a0190ce1dd7a062290ce48310206b4bca", symbol: "wNLP-E3B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xfc6fdde35860a327be88f54bf35993f72de91a87", symbol: "wNLP-GLWB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x38982f1604d2459f317ca9ff03808b17d4d9754b", symbol: "wNLP-GOOGLB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x737b83b17156348b84157d528e02bd9acec4163a", symbol: "wNLP-I4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xcf76092d538e4df7a1e8dc3eb8c21be1d462a5da", symbol: "wNLP-L4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x25fe9180e6c95da24b7a3fcff8bf2dbca1fb171a", symbol: "wNLP-M5B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x19bbae8f804b0ea4c7c4351f722fd39efe37c2b2", symbol: "wNLP-M6B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xafcd64ebfc83d57ddf5716f3814019f5543d7c46", symbol: "wNLP-M4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x66924f881bd0cbfabded19838c5f5443867359d9", symbol: "wNLP-M2B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x4d45a527b03551821c8d7d8974b939ed6a2824ec", symbol: "wNLP-NBISB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x2ba837484e8969da87d237effedea7badd294dd9", symbol: "wNLP-N4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x93da79355ae801a673e4d3b656a4152330646ee4", symbol: "wNLP-P4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xdfa34465d1c6c044304b798fa4a147eac579b66b", symbol: "wNLP-QCOMB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x564d609b363b902148af559c18aa1bc84bf29a5b", symbol: "wNLP-Q3B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x2014e669ab74e114aa155c6b9c162bb26a5b9972", symbol: "wNLP-S4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xcd1c23eaec3bbdef5f945f2b352b188c8a3b14d3", symbol: "wNLP-SOXLB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xf27760f7b431ad8caee0f4e3062e6140b14e0ebc", symbol: "wNLP-S5B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x5c53355123a51bd800934e0fa1f8eb8c9f3a848b", symbol: "wNLP-SPYB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xaeb7c9122d897a224180d2ca25bc86a16d12ae92", symbol: "wNLP-T4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x3bdd26cf07bd97baa5f2a588cb6a67b83c7a60a5", symbol: "wNLP-WDCB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x63689d5fe0d8f766fc11296c694634cd6f14ee6e", symbol: "wNLP-CANP", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x01246b4a5e22bba113108606451db0817a7d20f1", symbol: "wNLP-CBRSB", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0x31ac519953055b7c356228658e6836d1c7b4fa36", symbol: "wNLP-SK4B", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "56" as ChainId, address: "0xccafb706225331aedfec75b5347d462b98ed2fd2", symbol: "bwUSDT", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0x5c4a6903732532eeb3ae0803e062d8ae25d52bd1", underlying: "0x55d398326f99059ff775485246999027b3197955" },
  { chainId: "56" as ChainId, address: "0xaa3d2534b4b87a2859e28c223f18265244ffffb7", symbol: "bwU", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0x5c4a6903732532eeb3ae0803e062d8ae25d52bd1", underlying: "0xce24439f2d9c6a2289f741120fe202248b666666" },
  { chainId: "56" as ChainId, address: "0x82356c921422a2202e0f96dfccc352598ca8ef71", symbol: "bwBTW", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0x5c4a6903732532eeb3ae0803e062d8ae25d52bd1", underlying: "0x444045b0ee1ee319a660a5e3d604ca0ffa35acaa" },
  { chainId: "56" as ChainId, address: "0x73af543d809c8d3414e5b92b3aa2c25b182ba3a1", symbol: "BTWUSDT", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0xb82e32062c773c7748776c06fdb11b92edae3b63", underlying: "0x55d398326f99059ff775485246999027b3197955" },
  { chainId: "56" as ChainId, address: "0xb5c3617d4f077851cc6c7fae558d32e9782307f9", symbol: "BTWUSD1", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0xb82e32062c773c7748776c06fdb11b92edae3b63", underlying: "0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d" },
  { chainId: "56" as ChainId, address: "0x4effb6bce5cad64d7162c7f7f15f557221b106d5", symbol: "BTWU", brand: "Bitway", shareDecimals: 18, assetDecimals: 18, kind: "bitway", stakingVault: "0xb82e32062c773c7748776c06fdb11b92edae3b63", underlying: "0xce24439f2d9c6a2289f741120fe202248b666666" },
  { chainId: "56" as ChainId, address: "0x18afdacf30f8671021dec4b78297e39d2fe87226", symbol: "vhUSDT", brand: "Venus", shareDecimals: 24, assetDecimals: 18, kind: "erc4626" },
  { chainId: "56" as ChainId, address: "0x9d2d9592cf8dfbf59107faab703d08494be14617", symbol: "vhUSDC", brand: "Venus", shareDecimals: 24, assetDecimals: 18, kind: "erc4626" },
  { chainId: "56" as ChainId, address: "0x0e5aa174d4f31b757a237eb1999de151596788b0", symbol: "vhU", brand: "Venus", shareDecimals: 24, assetDecimals: 18, kind: "erc4626" },
  { chainId: "100" as ChainId, address: "0x004626a008b1acdc4c74ab51644093b155e59a23", symbol: "stEUR", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "143" as ChainId, address: "0x0166f153e26f572dfac570ccc351ba84ac7a2a72", symbol: "wNLP-WMON", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "143" as ChainId, address: "0xf3d44492f11a2dc234acba80a9e377ab5732b09d", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "143" as ChainId, address: "0x3b1dbe5ca2d39fac168e3575d707b714a7eaa7e7", symbol: "wNLP-USDT0", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "143" as ChainId, address: "0x01135c821a87154de3f338f1978811f2648e9570", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "143" as ChainId, address: "0x72c486886d199984bdbcf278ba68358365b0f8b7", symbol: "wNLP-cbBTC", brand: "Native", shareDecimals: 8, assetDecimals: 8, kind: "nativeWnlp" },
  { chainId: "143" as ChainId, address: "0x70dd4db19f75dfea083ce50e77f9b53b55d8558a", symbol: "wNLP-AUSD", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0xde540eabdb4ee3a2680394a4346dbfd76bb78e83", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x0b28888e8f0755809c679e01f67591d1ed5ae9b9", symbol: "wNLP-USD₮0", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x6285d06426eef9beef33ee92eab7f491f736da57", symbol: "wNLP-USDG", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x7fde95f8ca333f87677e89e42d09cb4b156f8921", symbol: "wNLP-NVDAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x78901dd5e09434c6d8c4caa651c012280324af59", symbol: "wNLP-TSLAx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0xe1e4bcb64121fff9cfa4d4f5bc31759f035992ad", symbol: "wNLP-CRCLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x1d2831785db72d0809d493a4cfcc90fee47927ad", symbol: "wNLP-GOOGLx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x4fb706eb3e3784da4fc5aa824886f6129a65fb2e", symbol: "wNLP-QQQx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "196" as ChainId, address: "0x6540c6b85ade3601f9bdf5b2d8712615dbd7730b", symbol: "wNLP-SPCXx", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "988" as ChainId, address: "0xd1db209087516883ec705cfeb99e80bb6032d540", symbol: "sthUSD", brand: "Theo", shareDecimals: 6, assetDecimals: 6, kind: "navOracle", oracle: "0xb81131b6368b3f0a83af09db4e39ac23da96c2db", oracleDecimals: 8 },
  { chainId: "999" as ChainId, address: "0x5e105266db42f78fa814322bce7f388b4c2e61eb", symbol: "hbUSDT", brand: "Hyperbeat", shareDecimals: 18, assetDecimals: 6, kind: "hyperbeatPricer", pricer: "0x3636a26ec1d512c5ecff42f7adaa5ce7964c6579" },
  { chainId: "999" as ChainId, address: "0x057ced81348d57aad579a672d521d7b4396e8a61", symbol: "hbUSDC", brand: "Hyperbeat", shareDecimals: 18, assetDecimals: 6, kind: "hyperbeatPricer", pricer: "0xe0995a641d454c149e6c808baa37cb2b38763316" },
  { chainId: "999" as ChainId, address: "0x81e064d0eb539de7c3170edf38c1a42cbd752a76", symbol: "lstHYPE", brand: "Hyperbeat", shareDecimals: 18, assetDecimals: 18, kind: "hyperbeatPricer", pricer: "0x5ed0ec0b0643dab621dc814c8d058e161b9b884b" },
  { chainId: "999" as ChainId, address: "0x441794d6a8f9a3739f5d4e98a728937b33489d29", symbol: "liquidHYPE", brand: "Hyperbeat", shareDecimals: 18, assetDecimals: 18, kind: "hyperbeatPricer", pricer: "0x90a0a650f0c403a92ae22f162b3e61818d6f8f11" },
  { chainId: "999" as ChainId, address: "0x9b3a8f7cec208e247d97dee13313690977e24459", symbol: "sUSDp", brand: "Parallel", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "2818" as ChainId, address: "0xcf7b55c544b579a09b54f5a4da3e1ba476c04364", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "2818" as ChainId, address: "0xca0f3fb46eb413abefa10d91aa2a6fd49eab60eb", symbol: "wNLP-BGBTC", brand: "Native", shareDecimals: 8, assetDecimals: 8, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0x7ce2c710c132f68a74dbb186644ec1eb86dfaf4e", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0xbb761ba477de2e887968d6c01073a477a9f9815b", symbol: "wNLP-USDG", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0x1eda0a1353c57113ff41c32f38ca4b8d0cfec562", symbol: "wNLP-AMD", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0x965cfe674859cb223ffdc0f72722ad5619f7d90f", symbol: "wNLP-CRCL", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0xa43ab4c0539ad04b41203fc0544d859540088613", symbol: "wNLP-MSFT", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0xb05b806fc5bdce389b734dce50400fa27ae54942", symbol: "wNLP-MU", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0x001660ed89e93c7c9b348e247934fa1ebc3a2625", symbol: "wNLP-NVDA", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0xbd254986706115081d84b7a71f3aa1f07d748a5b", symbol: "wNLP-SNDK", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0x68722297b35760ff16b873c4c89187f4e1d5dbe6", symbol: "wNLP-SPCX", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "4663" as ChainId, address: "0xf54b421461d41203e4babdc59d1259d7de886a73", symbol: "wNLP-TSLA", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "8453" as ChainId, address: "0x0022228a2cc5e7ef0274a7baa600d44da5ab5776", symbol: "stUSD", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "8453" as ChainId, address: "0x472ed57b376fe400259fb28e5c46eb53f0e3e7e7", symbol: "sUSDp", brand: "Parallel", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "8453" as ChainId, address: "0x83db73ef5192de4b6a4c92bd0141ba1a0dc87c65", symbol: "cUSDO", brand: "OpenEden", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "8453" as ChainId, address: "0xc750fe788a828dc960cd08e8bbe1ddd3bffc03bf", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "8453" as ChainId, address: "0xe745b0565cecb4612a41eae78319bf3ca8063e6f", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "8453" as ChainId, address: "0x0872c63c9b1f55ea4166752ba3b890a444b59e9e", symbol: "wNLP-USDT", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "8453" as ChainId, address: "0x90256c018d2acadda2da0b4fd61449e956fd59b6", symbol: "wNLP-cbBTC", brand: "Native", shareDecimals: 8, assetDecimals: 8, kind: "nativeWnlp" },
  { chainId: "8453" as ChainId, address: "0x913ece180df83a2b81a4976f83ca88543a0c51b8", symbol: "vamsETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "8453" as ChainId, address: "0x82562507429876486b60af4f32390ef0947b3d13", symbol: "vaETH", brand: "Vesper", shareDecimals: 18, assetDecimals: 18, kind: "vesperPricePerShare" },
  { chainId: "42161" as ChainId, address: "0x0022228a2cc5e7ef0274a7baa600d44da5ab5776", symbol: "stUSD", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "42161" as ChainId, address: "0x004626a008b1acdc4c74ab51644093b155e59a23", symbol: "stEUR", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "42161" as ChainId, address: "0x4772d2e014f9fc3a820c444e3313968e9a5c8121", symbol: "yUSD", brand: "YieldFi", shareDecimals: 18, assetDecimals: 6, kind: "erc4626" },
  { chainId: "42161" as ChainId, address: "0x9db777ca39e1f1144d564cb5f593d629d2debe46", symbol: "wNLP-WETH", brand: "Native", shareDecimals: 18, assetDecimals: 18, kind: "nativeWnlp" },
  { chainId: "42161" as ChainId, address: "0xe83ce032108f539c5a5b1c6029a89ff412d9e27f", symbol: "wNLP-USDT", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "42161" as ChainId, address: "0xb873363be6e4c99c1f4e6ffd6526c7c03a7a07ad", symbol: "wNLP-USDC", brand: "Native", shareDecimals: 6, assetDecimals: 6, kind: "nativeWnlp" },
  { chainId: "42161" as ChainId, address: "0xd8865923465463002bc2ccc522e5a21f8d06adfa", symbol: "wNLP-WBTC", brand: "Native", shareDecimals: 8, assetDecimals: 8, kind: "nativeWnlp" },
  { chainId: "43114" as ChainId, address: "0x06d47f3fb376649c3a9dafe069b3d6e35572219e", symbol: "savUSD", brand: "Avant", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "43114" as ChainId, address: "0x649342c6bff544d82df1b2ba3c93e0c22cdeba84", symbol: "savBTC", brand: "Avant", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "43114" as ChainId, address: "0x9d92c21205383651610f90722131655a5b8ed3e0", symbol: "sUSDp", brand: "Parallel", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "59144" as ChainId, address: "0x0022228a2cc5e7ef0274a7baa600d44da5ab5776", symbol: "stUSD", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
  { chainId: "59144" as ChainId, address: "0x004626a008b1acdc4c74ab51644093b155e59a23", symbol: "stEUR", brand: "Angle", shareDecimals: 18, assetDecimals: 18, kind: "erc4626" },
];

// ── ABI plumbing (hand-encoded; the four shapes below are the whole surface) ─

const SEL = {
  convertToAssets: "0x07a2d13a",
  totalAssets: "0x01e1d114",
  totalSupply: "0x18160ddd",
  pricePerShare: "0x99530b06",
  totalValue: "0xd4c3eea0",
  getRate: "0x679aefce",
  getNlpByWnlp: "0x265f3e0e",
  convertToAssetsToken: "0x36103291",
  latestRoundData: "0xfeaf968c",
} as const;

const pad32 = (hex: string): string => hex.replace(/^0x/, "").padStart(64, "0");
const uintArg = (v: bigint): string => pad32(v.toString(16));
const addrArg = (a: string): string => pad32(a.toLowerCase());
const pow10 = (n: number): bigint => 10n ** BigInt(n);

const decodeUint = (hex: string | undefined, wordIndex = 0): bigint | undefined => {
  if (!hex || hex === "0x") return undefined;
  const body = hex.replace(/^0x/, "");
  const word = body.slice(wordIndex * 64, wordIndex * 64 + 64);
  if (word.length < 64) return undefined;
  return BigInt("0x" + word);
};

/** Signed int256 word (a NAV feed's `answer`). */
const decodeInt = (hex: string | undefined, wordIndex: number): bigint | undefined => {
  const u = decodeUint(hex, wordIndex);
  if (u === undefined) return undefined;
  return u >= 1n << 255n ? u - (1n << 256n) : u;
};

/** The two calls a row needs: [rate, size]. */
function callsFor(row: OnchainVaultRow): Array<{ to: string; data: string }> {
  switch (row.kind) {
    case "erc4626":
      return [
        { to: row.address, data: SEL.convertToAssets + uintArg(pow10(row.shareDecimals)) },
        { to: row.address, data: SEL.totalAssets },
      ];
    case "vesperPricePerShare":
      return [
        { to: row.address, data: SEL.pricePerShare },
        { to: row.address, data: SEL.totalValue },
      ];
    case "hyperbeatPricer":
      return [
        { to: row.pricer!, data: SEL.getRate },
        { to: row.address, data: SEL.totalSupply },
      ];
    case "navOracle":
      return [
        { to: row.oracle!, data: SEL.latestRoundData },
        { to: row.address, data: SEL.totalSupply },
      ];
    case "nativeWnlp":
      return [
        { to: row.address, data: SEL.getNlpByWnlp + uintArg(pow10(18)) },
        { to: row.address, data: SEL.totalSupply },
      ];
    case "bitway":
      return [
        {
          to: row.stakingVault!,
          data: SEL.convertToAssetsToken + uintArg(pow10(row.shareDecimals)) + addrArg(row.underlying!),
        },
        { to: row.address, data: SEL.totalSupply },
      ];
  }
}

/** Fixed-point → decimal string without a float in between. */
const toDecimal = (v: bigint, decimals: number): string => {
  const neg = v < 0n;
  const abs = neg ? -v : v;
  const s = abs.toString().padStart(decimals + 1, "0");
  const int = s.slice(0, s.length - decimals);
  const frac = s.slice(s.length - decimals).replace(/0+$/, "");
  return (neg ? "-" : "") + int + (frac ? "." + frac : "");
};

/** Parse the two answers into (assets per ONE share, total assets), both as
 *  decimal strings in the asset's units. `undefined` = a revert on the rate
 *  call — the row is skipped for that day, never emitted as 0. */
function parseFor(
  row: OnchainVaultRow,
  rateHex: string | undefined,
  sizeHex: string | undefined,
): { pps: string; total?: string } | undefined {
  const size = decodeUint(sizeHex);
  switch (row.kind) {
    case "erc4626": {
      const r = decodeUint(rateHex);
      if (r === undefined) return undefined;
      return { pps: toDecimal(r, row.assetDecimals), total: size === undefined ? undefined : toDecimal(size, row.assetDecimals) };
    }
    case "vesperPricePerShare": {
      const r = decodeUint(rateHex);
      if (r === undefined) return undefined;
      return { pps: toDecimal(r, row.assetDecimals), total: size === undefined ? undefined : toDecimal(size, row.assetDecimals) };
    }
    case "hyperbeatPricer": {
      const r = decodeUint(rateHex);
      if (r === undefined) return undefined;
      // 8-dec rate × 18-dec supply → assets in the asset's own decimals.
      const total = size === undefined ? undefined : toDecimal((size * r) / pow10(8 + row.shareDecimals - row.assetDecimals), row.assetDecimals);
      return { pps: toDecimal(r, 8), total };
    }
    case "navOracle": {
      const r = decodeInt(rateHex, 1);
      if (r === undefined || r <= 0n) return undefined;
      const d = row.oracleDecimals ?? 18;
      const total = size === undefined ? undefined : toDecimal((size * r) / pow10(d + row.shareDecimals - row.assetDecimals), row.assetDecimals);
      return { pps: toDecimal(r, d), total };
    }
    case "nativeWnlp": {
      const r = decodeUint(rateHex);
      if (r === undefined) return undefined;
      const total = size === undefined ? undefined : toDecimal((size * r) / pow10(18 + row.shareDecimals - row.assetDecimals), row.assetDecimals);
      return { pps: toDecimal(r, 18), total };
    }
    case "bitway": {
      const r = decodeUint(rateHex);
      if (r === undefined) return undefined;
      const total = size === undefined ? undefined : toDecimal((size * r) / pow10(row.shareDecimals), row.assetDecimals);
      return { pps: toDecimal(r, row.assetDecimals), total };
    }
  }
}

// ── RPC ─────────────────────────────────────────────────────────────────────

interface RpcResult {
  id: number;
  result?: string;
  error?: { message?: string };
}

class ChainRpc {
  private urls: string[] = [];
  private cursor = 0;
  constructor(
    private readonly chainId: ChainId,
    /** RPC calls — one attempt each, see the fetcher. */
    private readonly client: PacedClient,
    /** The rpc-tester list itself — an ordinary HTTP GET with retries. */
    private readonly http: PacedClient,
  ) {}

  async init(probeBlock: number | undefined): Promise<number> {
    let list: string[] = [];
    try {
      const res = await this.http.getJson<{ rpcs: Array<{ url: string }> }>(`${RPC_LIST}/${this.chainId}.json`);
      list = res.rpcs.map((r) => r.url).filter(Boolean);
    } catch {
      list = [];
    }
    list.push(...(EXTRA_RPCS[this.chainId] ?? []).filter((u) => !list.includes(u)));
    if (probeBlock === undefined) {
      this.urls = list;
      return list.length;
    }
    // Keep the endpoints that serve STATE at the oldest block we will ask for.
    // A pruned node answers "missing trie node" / "state ... is pruned" / an
    // empty result; anything but a real word is a fail.
    const probe = ONCHAIN_VAULTS.find((r) => r.chainId === this.chainId);
    const [call] = probe ? callsFor(probe) : [];
    const ok: string[] = [];
    await Promise.all(
      list.map(async (url) => {
        try {
          const [r] = await this.batch(url, call ? [call] : [], probeBlock, 1);
          if (r?.result && r.result !== "0x" && !r.error) ok.push(url);
        } catch {
          /* pruned or dead */
        }
      }),
    );
    this.urls = ok;
    return ok.length;
  }

  /** All calls at `block` (`undefined` = latest), as JSON-RPC batches of at
   *  most `BATCH` — public endpoints cap batch size low (nodies: 10) and a
   *  too-large batch is rejected whole, which reads as a dead endpoint. */
  async batch(
    url: string,
    calls: Array<{ to: string; data: string }>,
    block: number | undefined,
    attempts = 2,
  ): Promise<RpcResult[]> {
    const tag = block === undefined ? "latest" : "0x" + block.toString(16);
    const BATCH = 10;
    const out: RpcResult[] = [];
    for (let start = 0; start < calls.length; start += BATCH) {
      const slice = calls.slice(start, start + BATCH);
      const body = slice.map((c, i) => ({
        jsonrpc: "2.0",
        id: start + i,
        method: "eth_call",
        params: [{ to: c.to, data: c.data }, tag],
      }));
      let lastErr: unknown;
      let got: RpcResult[] | undefined;
      for (let a = 0; a < attempts && !got; a += 1) {
        try {
          const res = await this.client.postJson<RpcResult[] | RpcResult>(url, body);
          got = (Array.isArray(res) ? res : [res]).sort((x, y) => x.id - y.id);
        } catch (err) {
          lastErr = err;
        }
      }
      if (!got) throw lastErr;
      out.push(...got);
    }
    return out;
  }

  /** Round-robin over the archival set; a failing endpoint is rotated out for
   *  the rest of the run rather than retried into a rate limit. */
  async callAll(calls: Array<{ to: string; data: string }>, block: number | undefined): Promise<RpcResult[]> {
    while (this.urls.length > 0) {
      const url = this.urls[this.cursor % this.urls.length];
      try {
        const out = await this.batch(url, calls, block);
        // A batch where EVERY call errored the same way is an endpoint fault
        // (rate limit, pruned), not a contract fault.
        const allErr = out.length > 0 && out.every((r) => r.error);
        if (allErr) throw new Error(out[0]?.error?.message ?? "all calls errored");
        this.cursor += 1;
        return out;
      } catch (err) {
        console.warn(`[${LENDER_KEY}] ${this.chainId} dropping ${url}: ${(err as Error).message}`);
        this.urls.splice(this.cursor % this.urls.length, 1);
      }
    }
    throw new Error(`[${LENDER_KEY}] chain ${this.chainId}: no RPC left`);
  }

  async getBlock(tag: string): Promise<{ number: number; timestamp: number } | undefined> {
    for (const url of this.urls) {
      try {
        const res = await this.client.postJson<{ result?: { number: string; timestamp: string } }>(url, {
          jsonrpc: "2.0",
          id: 1,
          method: "eth_getBlockByNumber",
          params: [tag, false],
        });
        if (res.result) return { number: parseInt(res.result.number, 16), timestamp: parseInt(res.result.timestamp, 16) };
      } catch {
        /* next */
      }
    }
    return undefined;
  }

  get available(): boolean {
    return this.urls.length > 0;
  }
}

/** Last block at or before `ts` (unix seconds). */
async function blockAt(
  chainId: ChainId,
  ts: number,
  client: PacedClient,
  rpc: ChainRpc,
  head: { number: number; timestamp: number },
): Promise<number | undefined> {
  const slug = LLAMA_SLUG[chainId];
  if (slug) {
    try {
      const res = await client.getJson<{ height: number; timestamp: number }>(`${LLAMA_BLOCK}/${slug}/${ts}`);
      if (Number.isFinite(res.height)) return res.height;
    } catch {
      /* fall through to bisection */
    }
  }
  // Bisection on block timestamps — ~20 reads per day, cached by the caller.
  let lo = 0;
  let hi = head.number;
  if (head.timestamp <= ts) return head.number;
  while (hi - lo > 1) {
    const mid = Math.floor((lo + hi) / 2);
    const b = await rpc.getBlock("0x" + mid.toString(16));
    if (!b) return undefined;
    if (b.timestamp <= ts) lo = mid;
    else hi = mid;
  }
  return lo;
}

export function createOnchainVaultHistoryFetcher(rows: readonly OnchainVaultRow[] = ONCHAIN_VAULTS): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "archival-rpc",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      // Two clients on purpose. HTTP APIs (rpc-tester list, llama block index)
      // get the normal retry policy; RPC endpoints get ONE attempt each,
      // because failover across the list is this module's own retry and the
      // client's 429 backoff (up to ~60 s per endpoint) would otherwise turn
      // one rate-limited entry into a ten-minute stall per chain.
      const client = new PacedClient({ label: LENDER_KEY, concurrency: 4, minIntervalMs: 120, signal: ctx.signal });
      const rpcClient = new PacedClient({ label: `${LENDER_KEY}:rpc`, concurrency: 4, minIntervalMs: 60, maxAttempts: 1, signal: ctx.signal });
      const byChain = new Map<ChainId, OnchainVaultRow[]>();
      for (const r of rows) {
        if (ctx.chainIds && !ctx.chainIds.includes(r.chainId)) continue;
        (byChain.get(r.chainId) ?? byChain.set(r.chainId, []).get(r.chainId)!).push(r);
      }

      const DAY = 86_400_000;
      const fromDay = bucketStart(ctx.from.getTime(), "1d").getTime();
      const toDay = bucketStart(ctx.to.getTime(), "1d").getTime();
      const today = bucketStart(Date.now(), "1d").getTime();
      let done = 0;
      const total = byChain.size;

      for (const [chainId, chainRows] of byChain) {
        done += 1;
        const rpc = new ChainRpc(chainId, rpcClient, client);
        // Head first, over the unprobed list; then narrow to archival endpoints
        // at the oldest block the window needs.
        await rpc.init(undefined);
        const head = await rpc.getBlock("latest");
        if (!head) {
          console.warn(`[${LENDER_KEY}] ${chainId}: no RPC answered eth_getBlockByNumber — skipped`);
          continue;
        }
        const oldestTs = Math.floor(Math.min(fromDay + DAY, Date.now()) / 1000);
        const oldestBlock = await blockAt(chainId, oldestTs, client, rpc, head);
        const archival = await rpc.init(fromDay + DAY >= today ? undefined : oldestBlock);
        if (!rpc.available) {
          console.warn(`[${LENDER_KEY}] ${chainId}: no endpoint serves block ${oldestBlock} — recording the head only`);
          await rpc.init(undefined);
        }
        const archivalOk = archival > 0 && rpc.available;

        const calls = chainRows.flatMap(callsFor);
        for (let day = fromDay; day <= toDay; day += DAY) {
          const isToday = day >= today;
          if (!isToday && !archivalOk) continue;
          // Sample the day's CLOSE: the last block at or before the next
          // bucket's start, so the point describes the whole day.
          const sampleTs = Math.floor(Math.min(day + DAY - 1, Date.now()) / 1000);
          const block = isToday ? head.number : await blockAt(chainId, sampleTs, client, rpc, head);
          if (block === undefined) continue;

          let out: RpcResult[];
          try {
            out = await rpc.callAll(calls, isToday ? undefined : block);
          } catch (err) {
            console.warn(`[${LENDER_KEY}] ${chainId} ${new Date(day).toISOString().slice(0, 10)}: ${(err as Error).message}`);
            break;
          }
          for (let i = 0; i < chainRows.length; i += 1) {
            const row = chainRows[i];
            const rate = out[i * 2];
            const size = out[i * 2 + 1];
            const parsed = parseFor(row, rate?.error ? undefined : rate?.result, size?.error ? undefined : size?.result);
            // A revert on the rate call is "the vault did not exist yet" for
            // every day before deployment — silence is the right answer.
            if (!parsed) continue;
            yield {
              marketUid: makeMarketUid(LENDER_KEY, chainId, row.address),
              lenderKey: LENDER_KEY,
              chainId,
              dataTs: new Date(day).toISOString(),
              observedTs: new Date(sampleTs * 1000).toISOString(),
              source: "archival-rpc",
              blockNumber: block,
              supplyIndex: parsed.pps,
              indexKind: "assets_per_share",
              totalDeposits: parsed.total === undefined ? undefined : Number(parsed.total),
            };
          }
        }
        ctx.onProgress?.(done, total, `${LENDER_KEY} chain ${chainId} (${chainRows.length} vaults${archivalOk ? "" : ", head only"})`);
      }
    },
  };
}
