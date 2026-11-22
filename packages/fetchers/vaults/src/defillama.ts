import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  type MarketUid,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { apyToAprPercent, decimalString, num } from "./shared.js";

/**
 * DefiLlama `/chart/{poolUuid}` — the universal daily fallback, APR_BACKFILL.md
 * "The two universal fallbacks" and HISTORY_GAPS §3.3's "no generic fetcher
 * module" line.
 *
 * One route, `GET yields.llama.fi/chart/{uuid}`, serves one point per day
 * (~23:01 UTC) since the pool was listed, with no decay: `{timestamp, tvlUsd,
 * apy, apyBase, apyReward, pricePerShare}`. Verified 2026-09-09 on sUSDe: 901+
 * daily points back to 2024-02-16.
 *
 * This module exists for the sources with NO official history API — where the
 * matrix's verdict is literally "DefiLlama + archival". Where an official API
 * exists it is always preferred and there is no row here: Re's own NAV route is
 * ten months deeper than its Llama pool, and Strata's own file is full-life,
 * so pointing both at Llama would be a worse series under a second source name.
 *
 * The roster is pinned by UUID because that is the only safe join. Llama's
 * `YUSD` pools are Aegis, not YieldFi — a symbol join silently attaches one
 * protocol's series to another's vault (APR_BACKFILL "ticker collisions"), and
 * that is unrecoverable once it is in the store. Every row below carries the
 * UUID margin-fetcher's live fetcher already uses for that asset, so the two
 * cannot drift apart quietly.
 *
 * Adding a source is one line. `pricePerShare` is populated for many savings
 * pools and null for others (Ethena, Re, Hastra, Native, Parallel, OpenEden,
 * sDOLA) — it is emitted when present and simply absent otherwise.
 *
 * Units: `apy` is PERCENT APY. `total_rate` is APR — the live fetchers convert
 * with `apyToAprPercent` (margin-fetcher `ethena.ts` does so for this very
 * sUSDe pool) — so every point is converted here. Rows exported before
 * 2026-10-30 carry the raw APY.
 */

const LENDER_KEY = "VAULT_LLAMA";
const API = "https://yields.llama.fi/chart";

/** Pool UUID → the vault the series describes. UUIDs mirrored from
 *  margin-fetcher's per-asset fetchers; addresses from its savings registry. */
const POOLS: Array<{
  uuid: string;
  chainId: ChainId;
  address: string;
  symbol: string;
  /** Runner key the uid is built under. Default `VAULT_LLAMA` (provider
   *  `savings`); rows whose yield-tracer venue is `vault.lst` use
   *  `VAULT_LLAMA_LST` (provider `lst`), or they join no live vault. */
  lenderKey?: "VAULT_LLAMA" | "VAULT_LLAMA_LST";
  /** Which Llama field is the row's rate. Default `apy` (falling back to
   *  `apyBase`); `apyBase` where Llama's `apy` adds a reward leg the live
   *  row does not carry (Zerobase USDT on Optimism: +2 pp). */
  rateField?: "apy" | "apyBase";
}> = [
  {
    uuid: "66985a81-9c51-46ca-9977-42b4fe7bc6df",
    chainId: "1" as ChainId,
    address: "0x9d39a5de30e57443bff2a8307a4256c8797a3497",
    symbol: "sUSDe",
  },
  {
    uuid: "f8cd444e-d99f-4132-b234-fd3482bf8806",
    chainId: "1" as ChainId,
    address: "0x056b269eb1f75477a8666ae8c7fe01b64dd55ecc",
    symbol: "USD3",
  },
  {
    uuid: "a99bb965-ebaa-4d98-9ed2-fa18de52c605",
    chainId: "1" as ChainId,
    address: "0xf689555121e529ff0463e191f9bd9d1e496164a7",
    symbol: "sUSD3",
  },
  {
    uuid: "da8c4ac9-733d-4a98-85a5-83b76b7e84d1",
    chainId: "1" as ChainId,
    address: "0xe346c29b5b60ef870b9724c57ccfbbc631e47dee",
    symbol: "wiTRY",
  },
  {
    uuid: "cb6139f9-4a68-4efd-8245-0312a92aee55",
    chainId: "1" as ChainId,
    address: "0x38eeb52f0771140d10c4e9a9a72349a329fe8a6a",
    symbol: "apyUSD",
  },
  // Saturn sUSDat (added 2026-09-11). Llama's `saturn` pool measures the
  // INCOME leg — the STRC dividend pass-through — which is what the spot
  // fetcher measures too, and 136 of its 150 points carry `pricePerShare`,
  // which is the MARK (96 % of NAV is STRC held outright, and the share price
  // ran 1.00 → 0.78 → 1.02 in five months). Both land here: `depositRate` says
  // what the position earned, `supplyIndex` says what the principal did.
  {
    uuid: "47e72726-3b2b-4fe6-b4a9-a26e1fcd9a50",
    chainId: "1" as ChainId,
    address: "0xd166337499e176bbc38a1fbd113ab144e5bd2df7",
    symbol: "sUSDat",
  },
  // Lane C pins (EARN_BACKFILL_2026_10.md §4), decided 2026-10-30 against
  // the live /earn rows: same protocol, rate and TVL within band, last 7
  // daily points overlapping our stored rows. Decision table, with every
  // rejected row and its reason: data/earn-backfill-2026-10/llama-pins.json.
  // Addresses are the earnUid's last segment VERBATIM — Solana base58 is
  // case-sensitive (see `uidOf`).
  // ── lane C pins 2026-10-30: vault.lst rows → VAULT_LLAMA_LST ──
  {
    uuid: "9e709e57-84eb-496b-82ce-2e8f6a17db1b",
    chainId: "solana" as ChainId,
    address: "BNso1VUJnh4zcfpZa6986Ea66P6TCp59hvtNJ8b1X85",
    symbol: "Binance BNSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "465d177e-3d0d-42c0-b5f5-31c857567135",
    chainId: "1" as ChainId,
    address: "0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549",
    symbol: "Liquid Collective LSETH",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "52bd72a7-9e81-4112-abb4-71673e8de9bf",
    chainId: "solana" as ChainId,
    address: "jupSoLaHXQiZZTSfEWMTRRgpnyFm8f6sZdosWBjx93v",
    symbol: "Jupiter JUPSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "296651fc-25f6-4434-b8ec-17c2af9808da",
    chainId: "solana" as ChainId,
    address: "Dso1bDeDjCQxTrWHqUUi63oBvV7Mdm6WaobLbQ7gnPQ",
    symbol: "Drift DSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "b3f93865-5ec8-4662-90a0-11808e0aa2bd",
    chainId: "solana" as ChainId,
    address: "mSoLzYCxHdYgdzU16g5QSh3i5K3z3KZK7ytfqcJm7So",
    symbol: "Marinade MSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "568bbb48-dc88-4313-b1cc-ab1d4e763d6d",
    chainId: "solana" as ChainId,
    address: "sctmB7GPi5L2Q5G9tUSzXvhZ4YiDMEGcRov9KfArQpx",
    symbol: "DeFi Development DFDVSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "7f5c2e8b-0428-431b-ba6e-571c38a57010",
    chainId: "solana" as ChainId,
    address: "pSo1f9nQXWgXibFtKf7NWYxb5enAM4qfP6UJSiXRQfL",
    symbol: "Phantom PSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "f76cc844-73a2-4cc7-8de7-f9fb874c626d",
    chainId: "solana" as ChainId,
    address: "Bybit2vBJGhPF52GBdNaQfUJ6ZpThSgHBobjWZpLPb4B",
    symbol: "Bybit BBSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "8b46fdde-a5e4-4574-9926-6ba8047f4fca",
    chainId: "solana" as ChainId,
    address: "vSoLxydx6akxyMD9XEcPvGYNGq6Nn66oqVb3UkGkei7",
    symbol: "The Vault VSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "177d0a37-d0fb-4b18-b290-f46bbe8d307f",
    chainId: "solana" as ChainId,
    address: "7Q2afV64in6N6SeZsAAB81TJzwDoD6zpqmHkzi9Dcavn",
    symbol: "JPool JSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "a4bbdd3c-0515-54b9-bad6-babb62a41084",
    chainId: "solana" as ChainId,
    address: "aeroXvCT6tjGVNyTvZy86tFDwE4sYsKCh7FbNDcrcxF",
    symbol: "Phase PDSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "d7e101d6-8e6c-4348-9c5f-62398872a301",
    chainId: "solana" as ChainId,
    address: "he1iusmfkpAdwvxLNGV8Y1iSbj4rUy6yMhEA3fotn9A",
    symbol: "Helius HSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "aa7c9efd-011b-4f38-b775-8a141d0baf1f",
    chainId: "solana" as ChainId,
    address: "jag58eRBC1c88LaAsRPspTMvoKJPbnzw9p9fREzHqyV",
    symbol: "JagPool JAGSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "481ba825-cc83-4b90-a7ee-9baa66b9ee83",
    chainId: "solana" as ChainId,
    address: "stke7uu3fXHsGqKVVjKnkmj65LRPVrqr4bLG2SJg7rh",
    symbol: "STKE STKESOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "ca2acc2d-6246-44aa-ae91-8725b2c62c7c",
    chainId: "1" as ChainId,
    address: "0xf951e335afb289353dc249e82926178eac7ded78",
    symbol: "Swell SWETH",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "ad383eed-61d8-4378-80bd-a197d9a11c79",
    chainId: "1" as ChainId,
    address: "0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4",
    symbol: "Bedrock UNIETH",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "1b94ffcc-41ce-4071-b5b7-12d6670f4d75",
    chainId: "solana" as ChainId,
    address: "hy1oXYgrBW6PVcJ4s6s2FKavRdwgWTXdfE69AxT7kPT",
    symbol: "Hylo HYLOSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "3997db8b-3f0c-4774-985d-d9fed3978f53",
    chainId: "solana" as ChainId,
    address: "Gekfj7SL2fVpTDxJZmeC46cTYxinjB6gkAnb6EGT6mnn",
    symbol: "DoubleZero DZSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "28d991e9-dcd9-4fcd-a29e-0fa98a296c5e",
    chainId: "solana" as ChainId,
    address: "kySo1nETpsZE2NWe5vj2C64mPSciH1SppmHb4XieQ7B",
    symbol: "Kyros KYSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "1d683a73-47a8-4c20-bafa-692b5ec043b5",
    chainId: "solana" as ChainId,
    address: "BonK1YhkXEGLZzwtcvRTip3gAL9nCeQD7ppZBLXhtTs",
    symbol: "Bonk BONKSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "f2aad126-ae18-5512-bc64-8fa59c136331",
    chainId: "solana" as ChainId,
    address: "BPSoLzmLQn47EP5aa7jmFngRL8KC3TWAeAwXwZD8ip3P",
    symbol: "Backpack BPSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  {
    uuid: "2df41814-3481-4e53-a91f-4a621e750f91",
    chainId: "solana" as ChainId,
    address: "strng7mqqc1MBJJV6vMzYbEqnwVGvKKGKedeCvtktWA",
    symbol: "Stronghold STRONGSOL",
    lenderKey: "VAULT_LLAMA_LST",
  },
  // ── lane C pins 2026-10-30: vault.savings rows ──
  {
    uuid: "55b0893b-1dbb-47fd-9912-5e439cd3d511",
    chainId: "1" as ChainId,
    address: "0x35d8949372d46b7a3d5a56006ae77b215fc69bc0",
    symbol: "Usual BUSD0",
  },
  {
    uuid: "b86d4934-2e75-415a-bdd2-e28143d72491",
    chainId: "1" as ChainId,
    address: "0xf0bb20865277abd641a307ece5ee04e79073416c",
    symbol: "ether.fi LIQUIDETH",
  },
  {
    uuid: "7083d6a5-e3cb-4eeb-8204-f1b735e4ecbb",
    chainId: "solana" as ChainId,
    address: "5Y8NV33Vv7WbnLfq3zBcKSdYPrk7g2KoiQoe7M2tcxp5",
    symbol: "OnRe ONYC",
  },
  {
    uuid: "d0f54ea9-b41f-5d60-a2fc-9a34eb211bbb",
    chainId: "1" as ChainId,
    address: "0xbbfc8683c8fe8cf73777fede7ab9574935fea0a4",
    symbol: "Lido EARNETH",
  },
  {
    uuid: "3075a746-bdd1-4aac-bcd5-b035abee2622",
    chainId: "solana" as ChainId,
    address: "5oVNBeEEQvYi1cX3ir8Dx5n1P7pdxydbGF2X4TxVusJm",
    symbol: "Sanctum INF",
  },
  {
    uuid: "76bb34c2-e68a-4398-9fba-d8a14c0caa44",
    chainId: "solana" as ChainId,
    address: "3b8X44fLF9ooXaUm3hhSgjpmVs6rZZ3pPoGnGahc3Uu7",
    symbol: "Hastra PRIME",
  },
  {
    uuid: "4964d3ac-eb9a-54dd-a7f6-faadac4393ea",
    chainId: "solana" as ChainId,
    address: "GNE6oDS6jHrfaV3GQVVCCp37fDnT7PiPuewMKBj2bqNm",
    symbol: "Hastra AUTO",
  },
  {
    uuid: "d44f890a-3dcb-5abb-a9bf-8c4e5bb62559",
    chainId: "1" as ChainId,
    address: "0x4ce1ac8f43e0e5bd7a346a98af777bf8fbea1981",
    symbol: "Lido EARNUSD",
  },
  {
    uuid: "edf44260-d78f-5dab-853a-f89c4f523169",
    chainId: "1" as ChainId,
    address: "0xeb892628d1e58bc475a6dcb7f5dbc4f591632aa4",
    symbol: "Axis SUSDX",
  },
  {
    uuid: "7c8e64e8-a186-5dbc-a954-d8e1a4fe66bb",
    chainId: "1" as ChainId,
    address: "0x119dd7daff816f29d7ee47596ae5e4bdc4299165",
    symbol: "Nest NOPAL",
  },
  {
    uuid: "488f06db-5a36-450e-9ba9-b4321be39c7c",
    chainId: "1" as ChainId,
    address: "0x273da948aca9261043fbdb2a857bc255ecc29012",
    symbol: "Fluid fLiteUSD",
  },
  {
    uuid: "3e78432a-f58b-46b2-ba69-1b446efc3e21",
    chainId: "56" as ChainId,
    address: "0x385c279445581a186a4182a5503094ebb652ec71",
    symbol: "Unitas SUSDU",
  },
  {
    uuid: "8eaf3e4a-6030-5868-a9c9-57770ecf57ae",
    chainId: "solana" as ChainId,
    address: "GArhnnDj3GYhmQeApKVXaRv4TQFwhPcs3SNF6FXsTeXq",
    symbol: "Nest NOPAL",
  },
  {
    uuid: "f21c4938-864a-44bd-91fb-c492864fcb46",
    chainId: "98866" as ChainId,
    address: "0x119dd7daff816f29d7ee47596ae5e4bdc4299165",
    symbol: "Nest NOPAL",
  },
  {
    uuid: "e9a686bf-21ed-4f78-82be-cd32625c4725",
    chainId: "1" as ChainId,
    address: "0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56",
    symbol: "Tokemak autoETH",
  },
  {
    uuid: "e575606e-5642-4f87-b9ad-3e53d6f83c82",
    chainId: "1" as ChainId,
    address: "0xb3b3c527ba57cd61648e2ec2f5e006a0b390a9f8",
    symbol: "GAIB SAID",
  },
  {
    uuid: "d29499b9-016c-51b3-aa5a-f5e4a303300e",
    chainId: "1" as ChainId,
    address: "0x6fec234e8801ed88964bc058a0f9fbcc9fcbd2eb",
    symbol: "Nest NPRIME",
  },
  {
    uuid: "eda98ff9-24b1-53bc-8c9e-9d3ba547b73c",
    chainId: "1" as ChainId,
    address: "0x2b5895b716311a1eac8f93fb88c56af9ec8c1a69",
    symbol: "JUSD Finance JUSD",
  },
  {
    uuid: "2f063aed-0a5a-4ba5-8b63-8404b2a99fca",
    chainId: "1" as ChainId,
    address: "0x5f46d540b6ed704c3c8789105f30e075aa900726",
    symbol: "ether.fi LIQUIDBTC",
  },
  {
    uuid: "320550a3-b7c4-4017-a5dd-f3ebed459470",
    chainId: "1" as ChainId,
    address: "0x27b5739e22ad9033bcbf192059122d163b60349d",
    symbol: "Yearn YCRV",
  },
  {
    uuid: "f455e212-39fd-5555-aa9b-45fc31d2d506",
    chainId: "1" as ChainId,
    address: "0xc9854f2af89d4d26837004d1e154bd3c3c1009b1",
    symbol: "Yuzu YZSYRUP",
  },
  {
    uuid: "ae992838-303f-5a75-8dc7-0cb765396245",
    chainId: "98866" as ChainId,
    address: "0x7488b23f4c26b44eef2e0766896be47443e86d79",
    symbol: "Nest NAXI",
  },
  {
    uuid: "d2d4c777-6cdb-564c-8b53-be12cda04f7b",
    chainId: "43114" as ChainId,
    address: "0x119dd7daff816f29d7ee47596ae5e4bdc4299165",
    symbol: "Nest NOPAL",
  },
  {
    uuid: "693ec0f2-1901-4645-a132-16b34696c84b",
    chainId: "42161" as ChainId,
    address: "0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec",
    symbol: "Gauntlet GTUSDA",
  },
  {
    uuid: "ea75fef6-f916-465d-81c9-d2a159cbf767",
    chainId: "1" as ChainId,
    address: "0x9be9294722f8aad37b11a9792be2c782182cafa2",
    symbol: "Ember eEARN",
  },
  {
    uuid: "fbd2a90a-f18f-412f-9f75-cc75432efd3f",
    chainId: "1" as ChainId,
    address: "0xf6ebea08a0dfd44825f67fa9963911c81be2a947",
    symbol: "Superform SUPERUSDC",
  },
  {
    uuid: "39143e86-aca1-4538-a77d-8b081fab62b6",
    chainId: "1" as ChainId,
    address: "0xa036823b9a24f63c32553367bf181ee04229c3ac",
    symbol: "Superform SUPERWETH",
  },
  {
    uuid: "30cd7c50-3aea-4364-80c7-4b4c964ffaca",
    chainId: "1" as ChainId,
    address: "0x3a43aec53490cb9fa922847385d82fe25d0e9de7",
    symbol: "YO yoETH",
  },
  {
    uuid: "58226309-3608-4c9d-bf4d-62d1c637bee9",
    chainId: "1" as ChainId,
    address: "0x0000000f2eb9f69274678c76222b35eec7588a65",
    symbol: "YO yoUSD",
  },
  {
    uuid: "e1fed8de-cdeb-48f8-b814-8b1a9ff38fb1",
    chainId: "999" as ChainId,
    address: "0xfde5b0626fc80e36885e2fa9cd5ad9d7768d725c",
    symbol: "Harmonix haHYPE",
  },
  {
    uuid: "d764f4ea-c791-4c10-a2d1-505b6c75712a",
    chainId: "1" as ChainId,
    address: "0x3bd9248048df95db4fbd748c6cd99c1baa40bad0",
    symbol: "Gauntlet GTUSDA",
  },
  {
    uuid: "a546653f-1bd8-57e1-ba26-2c0b975f7dd0",
    chainId: "999" as ChainId,
    address: "0x95f6d66c09a22e6f2bb693306b3ed69663066cbb",
    symbol: "Liminal XLEND",
  },
  {
    uuid: "53b78982-b991-4276-9208-60a1749587aa",
    chainId: "8453" as ChainId,
    address: "0x2c71f70e2ec720ae061ae7e0316fc9654d94f417",
    symbol: "Superform SUP",
  },
  {
    uuid: "a7e28f73-d613-4ddf-ab90-756018fdf299",
    chainId: "8453" as ChainId,
    address: "0x11820afe50ea96851ee2bdbae329d97771e41ec6",
    symbol: "Superform SUPERUSDC",
  },
  {
    uuid: "2f22ea35-b2cd-4407-afdf-2b8c086c3765",
    chainId: "1" as ChainId,
    address: "0xbcbc8cb4d1e8ed048a6276a5e94a3e952660bcbc",
    symbol: "YO yoBTC",
  },
  {
    uuid: "31aa8e4b-fd5d-595f-9f05-61606eb4d385",
    chainId: "1" as ChainId,
    address: "0x066d10e240999aea6798b2e2ca0bdac2923cbdff",
    symbol: "Nest NFXCF",
  },
  {
    uuid: "bc128d75-8019-5d5c-9e6c-2ab94b03b642",
    chainId: "8453" as ChainId,
    address: "0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc",
    symbol: "Superform SUPERNVDA",
  },
  {
    uuid: "7ed79c44-6d28-5ff5-b387-b214f7730e74",
    chainId: "42161" as ChainId,
    address: "0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7",
    symbol: "YO yoUSD Edge",
  },
  {
    uuid: "d69cb2c8-bf7a-4817-8364-6713a2140213",
    chainId: "1" as ChainId,
    address: "0x8c365af7094eaac29314edee577b435892ca93a3",
    symbol: "Superform SUPERWBTC",
  },
  {
    uuid: "4dbe1258-b4bc-53f5-b9c0-4c497e028939",
    chainId: "1" as ChainId,
    address: "0x1b2b8cfef0b7b1fad216b55fefeeb0c3349da141",
    symbol: "Strata JRNOPAL",
  },
  {
    uuid: "a23fd6f5-fd53-4934-830f-2ea789148cdd",
    chainId: "8453" as ChainId,
    address: "0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7",
    symbol: "YO yoUSD Edge",
  },
  {
    uuid: "34c1bf61-ef0e-4832-8f14-67008187d3b4",
    chainId: "8453" as ChainId,
    address: "0x0e70c10fa06931f7b878653a15aecc86145c1af7",
    symbol: "Superform SUPERWETH",
  },
  {
    uuid: "6a9a0fe1-962e-5393-9be6-811022d51e8a",
    chainId: "8453" as ChainId,
    address: "0x363600ac7173e8d91bcfee68d711bb93e992c110",
    symbol: "Superform SUPERGOOGL",
  },
  {
    uuid: "048dcabb-8c0d-598e-9249-858698e72498",
    chainId: "8453" as ChainId,
    address: "0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7",
    symbol: "Superform SUPERTSLA",
  },
  {
    uuid: "b5f05b22-718f-549b-813d-430a24a6ed45",
    chainId: "42161" as ChainId,
    address: "0xfe8f223f3d81462f55bf8609897b8cecfa4b195c",
    symbol: "Alchemix mixWETH",
  },
  {
    uuid: "0c795123-f6a0-412f-92e8-11fbb598ac08",
    chainId: "42161" as ChainId,
    address: "0x0000000f2eb9f69274678c76222b35eec7588a65",
    symbol: "YO yoUSD",
  },
  {
    uuid: "2641f5c8-27d0-5d42-aa69-69bdc760a874",
    chainId: "8453" as ChainId,
    address: "0x02b12a394f0a98b80e53d85f6831041932f1b621",
    symbol: "Superform SUPERSPCX",
  },
  {
    uuid: "1e4a570e-c1f5-4f48-8379-9064da8bf330",
    chainId: "1" as ChainId,
    address: "0x50c749ae210d3977adc824ae11f3c7fd10c871e9",
    symbol: "YO yoEUR",
  },
  {
    uuid: "af6e6de5-5fe1-5146-b8b6-e1f6112932a6",
    chainId: "8453" as ChainId,
    address: "0x301a1ceb684d62833101b373ab6c395349b24033",
    symbol: "Superform SUPERAAPL",
  },
  // ── lane E pins (ticket 0006, verified 2026-10-30: lane-e-findings.json) ──
  {
    uuid: "ad047a62-5c88-4b43-bf42-4e4d0858c53a",
    chainId: "98866" as ChainId,
    address: "0x066d10e240999aea6798b2e2ca0bdac2923cbdff",
    symbol: "Nest nFALCON (Plume)",
  },
  {
    uuid: "08ab92f4-a0e0-4660-9349-54596b224ebe",
    chainId: "10" as ChainId,
    address: "0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e",
    symbol: "Zerobase USDT",
    rateField: "apyBase",
  },
  {
    uuid: "a061ebd7-b5db-57e9-9361-99504b710165",
    chainId: "1" as ChainId,
    address: "0xbd373c9d3d8976a4fecc504a93c768bbe8c3227c",
    symbol: "Royco ROY-ST-apyUSD",
  },
  {
    uuid: "168147fa-b90d-5ffd-bfb3-9ea4e737ff5e",
    chainId: "1" as ChainId,
    address: "0xab2ab53e1e2e2c5d7202918ec8c873712bcc4a2d",
    symbol: "Royco ROY-JT-apyUSD",
  },
  {
    uuid: "77ffc09b-8e16-57d2-a7a7-d21d2f400b70",
    chainId: "10" as ChainId,
    address: "0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822",
    symbol: "Alchemix mixWETH (Optimism)",
  },
  {
    uuid: "97bc3a39-1ce6-58aa-8c52-7fb5be902fe0",
    chainId: "42161" as ChainId,
    address: "0xeba62b842081cef5a8184318dc5c4e4aaca9f651",
    symbol: "Alchemix mixUSDC (Arbitrum)",
  },
  {
    uuid: "d214617a-29b1-4b60-9c23-bf3864e22e03",
    chainId: "8453" as ChainId,
    address: "0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce",
    symbol: "Superform superCBBTC",
  },
  {
    uuid: "3ce855c8-aede-5ebf-abf7-800fae05d2a2",
    chainId: "8453" as ChainId,
    address: "0x7778192c7e2c22a27c63d63485699888148d5919",
    symbol: "Superform superMSFT",
  },
  {
    uuid: "3b519f39-0bb2-5d9e-bade-49bad3dac0a4",
    chainId: "8453" as ChainId,
    address: "0x4855b2756910b7525d5b466292c394669ee74e7e",
    symbol: "Superform superAMZN",
  },
  {
    uuid: "b58ea55e-70ff-5dca-9f23-b91946855486",
    chainId: "14" as ChainId,
    address: "0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d",
    symbol: "Superform bizUSDT0",
  },
];

/** `makeMarketUid` lower-cases the address, which is right for EVM and
 *  destroys a Solana base58 key (a lower-cased mint joins nothing). Non-0x
 *  addresses are kept verbatim. */
function uidOf(lenderKey: string, chainId: ChainId, address: string): MarketUid {
  if (address.startsWith("0x")) return makeMarketUid(lenderKey, chainId, address);
  return [lenderKey, chainId, address].join(":") as MarketUid;
}

interface ChartResponse {
  status?: string;
  data?: Array<{
    timestamp: string; // ISO, ~23:01 UTC
    tvlUsd?: number | null;
    apy?: number | null; // percent
    apyBase?: number | null;
    apyReward?: number | null;
    pricePerShare?: number | null;
  }>;
}

export function createDefiLlamaVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "defillama-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 250,
        signal: ctx.signal,
      });

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const pool of POOLS) {
        done += 1;
        if (ctx.chainIds && !ctx.chainIds.includes(pool.chainId)) continue;

        let rows: NonNullable<ChartResponse["data"]> = [];
        try {
          const res = await client.getJson<ChartResponse>(`${API}/${pool.uuid}`);
          rows = res.data ?? [];
        } catch (err) {
          // A delisted pool 404s. That is one asset's series gone, not a run.
          console.warn(`[${LENDER_KEY}] ${pool.symbol} (${pool.uuid}): ${(err as Error).message}`);
          continue;
        }

        const lenderKey = pool.lenderKey ?? LENDER_KEY;
        const marketUid = uidOf(lenderKey, pool.chainId, pool.address);
        for (const row of rows) {
          const tsMs = Date.parse(row.timestamp);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          // Llama writes 0 for a day it failed to compute (sUP: 72 of 262 days,
          // yCRV 53, LsETH 50) — a fake 0 % that drags every 30-day average.
          // Drop the rate; the day's TVL and share price still stand.
          const apyRaw =
            pool.rateField === "apyBase" ? num(row.apyBase) : (num(row.apy) ?? num(row.apyBase));
          const apy = apyRaw === 0 ? undefined : apyRaw;
          const tvl = num(row.tvlUsd);
          const pps = num(row.pricePerShare);
          if (apy === undefined && tvl === undefined && pps === undefined) continue;

          yield {
            marketUid,
            lenderKey,
            chainId: pool.chainId,
            // Llama stamps ~23:01, so the day bucket is the previous day's
            // close; `observedTs` keeps the real sampling time.
            dataTs: bucketStart(tsMs, ctx.resolution).toISOString(),
            observedTs: new Date(tsMs).toISOString(),
            source: "defillama-api",
            depositRate: apy === undefined ? undefined : apyToAprPercent(apy), // APY → APR, see header
            totalDepositsUsd: tvl,
            supplyIndex: decimalString(pps),
            indexKind: pps === undefined ? undefined : "assets_per_share",
          };
        }
        ctx.onProgress?.(done, POOLS.length, `${LENDER_KEY} ${pool.symbol}`);
      }
    },
  };
}
