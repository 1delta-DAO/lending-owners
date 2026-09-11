/**
 * The earn-side roster: every vault source we fetch SPOT data for, and whether
 * its upstream API can also serve history.
 *
 * Why this is a hand-maintained table and not derived: the live vault fetcher
 * (`VAULT_PROVIDERS` in lending-sdks `margin-fetcher/src/vaults/fetchVaultsAll.ts`)
 * is in a sibling repo this workspace does not depend on, and the answer to
 * "does this source have history" lives in prose — the curl-verified matrices in
 * `VAULT_HISTORY_BACKFILL_PLAN.md` §2–§3 (this repo) and margin-fetcher's
 * `src/vaults/HISTORY_APIS.md` + `src/vaults/savings/APR_BACKFILL.md`. Nothing
 * in either repo encodes it.
 *
 * Without this table the coverage report's earn side can only list what is
 * already on disk, which answers "what do we have" and silently answers "what
 * is missing" with nothing — the one question worth asking about a provider we
 * fetch daily and have never backfilled. `coverage.ts` cross-checks it both
 * ways against `FETCHERS` and the disk, so drift is reported rather than
 * believed.
 *
 * Keep rows in sync when a `hist/` module lands: flip `runnerKey` from
 * undefined to the key, and the check in `coverage.ts` stops complaining.
 */

export type HistoryAvailability =
  /** A `hist/` module exists here and collects it. */
  | "module"
  /** Upstream serves real history, no module here yet — a backfill to write. */
  | "api-history"
  /** Upstream serves a ROLLING window — every uncaptured day is lost for good,
   *  so this needs a recorder now, not a backfill later. */
  | "rolling"
  /** No upstream history surface. DefiLlama `/chart/{poolUuid}`, archival 4626
   *  reads, or our own daily self-archive are the only routes. */
  | "no-api";

export interface VaultProviderRow {
  /** The live fetcher's provider name, or `savings:<asset>` for one entry of
   *  the savings registry (which is a single provider holding ~30 sources). */
  source: string;
  /** The `VAULT_*` runner key, when a `hist/` module exists. */
  runnerKey?: string;
  availability: HistoryAvailability;
  /** What the series is and how deep, in one line. */
  note: string;
  /** Where the row was verified. */
  doc: string;
}

const VAULT_PLAN = "VAULT_HISTORY_BACKFILL_PLAN.md";
const HISTORY_APIS = "margin-fetcher HISTORY_APIS.md";
const APR_BACKFILL = "margin-fetcher savings/APR_BACKFILL.md";

export const VAULT_PROVIDER_ROSTER: readonly VaultProviderRow[] = [
  // ── collected here ───────────────────────────────────────────────────────
  {
    source: "morpho",
    runnerKey: "VAULT_MORPHO",
    availability: "module",
    note: "pps + netApy + TVL to inception, hourly or daily",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "pendle",
    runnerKey: "VAULT_PENDLE",
    availability: "module",
    note: "impliedApy + TVL to inception; matured markets keep their full life",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "fluid",
    runnerKey: "VAULT_FLUID",
    availability: "module",
    note: "hourly supply/borrow APR since 2024-02, block-pinned",
    doc: HISTORY_APIS,
  },
  {
    source: "yearn",
    runnerKey: "VAULT_YEARN",
    availability: "module",
    note: "Kong daily pps + APY + TVL to inception",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "upshift",
    runnerKey: "VAULT_UPSHIFT",
    availability: "module",
    note: "daily pps + TVL + APY to inception, one call per vault",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "lagoon",
    runnerKey: "VAULT_LAGOON",
    availability: "module",
    note: "event-granular pps + TVL; ~1000-point cap keeps the NEWEST points",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "silo",
    runnerKey: "VAULT_SILO",
    availability: "module",
    note: "daily pps + APR + TVL from indexer genesis; hourly only for ~24h",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "gmx",
    runnerKey: "VAULT_GMX",
    availability: "module",
    note: "daily APR since 2023-09 (squid); no pps or TVL series exists",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.1`,
  },
  {
    source: "hypercore",
    runnerKey: "VAULT_HYPERCORE",
    availability: "module",
    note: "TVL only, ~weekly allTime; the fine buckets roll (24h/7d/30d)",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.2`,
  },
  {
    source: "gearbox",
    runnerKey: "VAULT_GEARBOX",
    availability: "module",
    note: "pps + APY + liquidity, 1-year rolling cap (no `all` period)",
    doc: HISTORY_APIS,
  },
  {
    source: "savings:cap",
    runnerKey: "VAULT_CAP",
    availability: "module",
    note: "stcUSD pps + APY + TVL, 365-point ROLLING (deeper combos WAF-403)",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §3`,
  },
  {
    source: "savings:hyperbeat",
    runnerKey: "VAULT_HYPERBEAT",
    availability: "module",
    note: "daily APY to inception; pps has no route and must be recorded forward",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §3`,
  },
  {
    source: "savings:yieldbasis",
    runnerKey: "VAULT_YIELDBASIS",
    availability: "module",
    note: "daily pps + signed trading APY, current-gen inception; no Llama fallback",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §3`,
  },

  // ── added to margin-fetcher 2026-09-10, history found and wired 2026-09-11 ─
  {
    source: "savings:venus-hub",
    runnerKey: "VAULT_VENUS_HUB",
    availability: "module",
    note: "`api.venus.io/liquidity-hub/hubs/{hub}/history?range=all` — daily pps + APY + TVL since the 2026-08-07 inception; absent from the lending `/markets` routes, roster fetched from `/liquidity-hub/hubs`",
    doc: "packages/fetchers/vaults/src/venusHub.ts (probed 2026-09-11)",
  },
  {
    source: "lst:slisBNB",
    runnerKey: "VAULT_LISTA",
    availability: "module",
    note: "`api.lista.org/api/datachart/history?name=slisBNBRate&cycle=1` — daily APR to 2024-03-13, paged in ≤500-day windows (730 is `Time range too large`)",
    doc: "packages/fetchers/vaults/src/lista.ts (probed 2026-09-11)",
  },
  {
    source: "savings:saturn",
    runnerKey: "VAULT_LLAMA",
    availability: "module",
    note: "no official history; DefiLlama `saturn` pool since 2026-04-15 carries APY (the STRC income leg) AND pricePerShare (the mark) on 136 of 150 points — wired into the generic Llama roster",
    doc: "packages/fetchers/vaults/src/defillama.ts · margin-fetcher `saturn.ts`",
  },
  // ── savings-registry and earn sources, collected here since 2026-09-09 ───
  {
    source: "euler-earn",
    runnerKey: "VAULT_EULER_EARN",
    availability: "module",
    note: "`/earn/vaults/{chain}/{addr}/totals` — shallow and patchy per vault, 2026-04-23 floor, totalAssetsUsd always null; archival 4626 is the trustworthy series",
    doc: `${VAULT_PLAN} §2.3 · HISTORY_GAPS §3.3`,
  },
  {
    source: "savings:re",
    runnerKey: "VAULT_RE",
    availability: "module",
    note: "`api.re.xyz/price` daily NAV since 2025-04, ~10 months deeper than the DefiLlama pool the live fetcher still reads",
    doc: `${VAULT_PLAN} §3 · ${APR_BACKFILL}`,
  },
  {
    source: "savings:sdola",
    runnerKey: "VAULT_SDOLA",
    availability: "module",
    note: "`inverse.finance/api/dola-staking/history` — full snapshots since 2024-02-08 inception",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:spark",
    runnerKey: "VAULT_SPARK",
    availability: "module",
    note: "`spark.data.blockanalitica.com` — all 7 vault symbols in ONE call, 365d (covers V2's whole life)",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:sky-maker",
    runnerKey: "VAULT_SKY",
    availability: "module",
    note: "Blockanalitica ssr/dsr/stusds 365d (larger `days_ago` → HTTP 500), chi accumulator exact beyond",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:sfrxusd",
    runnerKey: "VAULT_SFRXUSD",
    availability: "module",
    note: "`api.frax.finance/v2/sfrxusd/summary-stats/history?range=all` daily since 2025-05",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:usdd",
    runnerKey: "VAULT_USDD",
    availability: "module",
    note: "`openapi.usdd.io` per chain, daily since 2025-09 (full earn life)",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:wren",
    runnerKey: "VAULT_WREN",
    availability: "module",
    note: "the fetcher's own `wstgbp.com/api/nav-growth` already returns the full-life NAV series — no new endpoint needed",
    doc: `${VAULT_PLAN} §3`,
  },
  {
    source: "savings:strata",
    runnerKey: "VAULT_STRATA",
    availability: "module",
    note: "`s3.strata.money/tranches/analytics-v18.json` — full-life WEEKLY per CDO; URL is version-pinned, a bump strands the job",
    doc: `${VAULT_PLAN} §3`,
  },
  {
    source: "defillama-chart",
    runnerKey: "VAULT_LLAMA",
    availability: "module",
    note: "universal daily fallback `/chart/{poolUuid}` since pool listing — no generic module exists for it",
    doc: `${APR_BACKFILL} · HISTORY_GAPS §3.3`,
  },

  // ── rolling windows, now captured daily (see DECAYING in fetchers.ts) ────
  {
    source: "aave-earn",
    availability: "no-api",
    note: "the Earn `Vault` type has NO history fields — vault APR and balance must be self-recorded. The reserve-level route this row used to point at (`supplyAPYHistory`, 365d enum) is NOT missing: the AAVE_V3 lender module has always collected it, and it is in the daily set as of 2026-09-09 because that window rolls.",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.3 · packages/fetchers/aave-v3/src/hist`,
  },
  {
    source: "savings:falcon",
    runnerKey: "VAULT_FALCON",
    availability: "module",
    note: "`api.falcon.finance` apy history, 365-point rolling cap",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:tori",
    runnerKey: "VAULT_TORI",
    availability: "module",
    note: "`app.tori.finance/api/apy/history` — 30 points, window vs full life indistinguishable",
    doc: APR_BACKFILL,
  },
  {
    source: "savings:yo",
    runnerKey: "VAULT_YO",
    availability: "module",
    note: "yield timeseries is a fixed 30-day window (params ignored); the TVL route is full-depth",
    doc: APR_BACKFILL,
  },

  // ── no upstream history at all ───────────────────────────────────────────
  {
    source: "spectra",
    availability: "no-api",
    note: "`/pools/history` answers 200 `{data:[]}` for every param — self-archive the pools listing or reconstruct on-chain",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.2`,
  },
  {
    source: "termmax",
    availability: "no-api",
    note: "the `chart/apy` endpoint returns ONE current point — a live snapshot wearing a chart costume; vault is 4626 so archival works",
    doc: `${HISTORY_APIS} · ${VAULT_PLAN} §2.2`,
  },
  {
    source: "lista",
    availability: "no-api",
    note: "the Moolah VAULTS have no series anywhere public — DefiLlama's `lista-lending` pools are per-underlying aggregates with no vault identity, so they cannot be joined to a vault uid. (The earlier \"every api.lista.org route 404'd\" note was wrong in general: `datachart/history` is real and serves slisBNB — see `lst:slisBNB` — it just has no vault-level series.) Moolah is a MetaMorpho-fork 4626 → archival is exact.",
    doc: `${VAULT_PLAN} §2.3 · packages/fetchers/vaults/src/lista.ts`,
  },
  {
    source: "lst",
    availability: "no-api",
    note: "27 on-chain readers, no single API; exchange-rate LSTs are exactly reconstructible, operator-pushed ones need a recorder",
    doc: `${VAULT_PLAN} §2.3 · HISTORY_GAPS §3.3`,
  },
] as const;
