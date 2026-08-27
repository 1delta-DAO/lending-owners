# Vault history backfill & capture

Reconstructing historical vault data (APY/rate series, share price, TVL) for
every earn-surface provider — the vault-side sibling of
[LENDING_HISTORY_BACKFILL_PLAN.md](LENDING_HISTORY_BACKFILL_PLAN.md), which
covers the lending markets. Lives in this repo for the same reason: the
collection half plugs into `packages/history-runner`.

Status: **analysis complete (2026-08-26), nothing vault-specific built.** Every
endpoint below marked ✓ was **curl-verified live on 2026-08-26**; everything
else is explicitly marked inferred. Sibling checkouts referenced:
`../lending-sdks` (margin-fetcher — the fetchers whose APIs are audited here,
and `packages/margin-fetcher/src/vaults/savings/APR_BACKFILL.md`, the
savings-side matrix this extends) and `../yield-tracer` (the ingest routes and
the `vaults_snapshots` store).

The headline: **most of the vault surface can be backfilled to inception from
the same APIs the fetchers already call**, the storage/read side already
exists in yield-tracer, and the only genuinely new work is the fetcher layer
plus a vault-shaped point type. A small set of sources decays daily and needs a
self-archive started NOW (§4).

---

## 1. What already exists (do not rebuild)

| Piece | Where | State |
| --- | --- | --- |
| **Durable store** | yield-tracer `vaults_snapshots` (`app/migrations/0055_vaults.sql`, share-price columns added in `0059`), plus dedicated `pendle_vaults_snapshots` / `gmx_vaults_snapshots` / `hypercore_vaults_snapshots` | **Built and populated** (hourly live cron). UNIQUE `(chain_id, provider, vault_address, data_ts)`, `onConflictDoNothing` — already idempotent, exactly what a backfill needs. **No FK gate** (unlike the lending side's `market_index_snapshots` → `markets` FK), so backfilled rows can be inserted directly. |
| **Read surface** | yield-tracer `GET /earn/history?earnUid=vault.<provider>:<chainId>:<address>&days=` (`app/src/routes/earn.ts`) | **Built.** Serves `{t, apr, tvlUsd, sharePrice?}` from the snapshot tables. Backfilled rows light it up immediately. |
| **Live ingest** | yield-tracer `app/src/integst/vaults.ts` → `vaultsLatest` upsert + `vaultsSnapshots` insert, hourly bucket (`LENDING_BUCKET_MIN`) | **Built.** The bucket convention a backfill must match. |
| **Runner harness** | this repo, `packages/history-runner` — `FETCHERS` registry, `NdjsonSink` (dedup-on-disk, `manifest.json`), `capture-history.yml` (daily 03:10 UTC, commits `data/history/`) | **Built** for lending. Registry is a one-line-per-source extension point; the sink shards on `(family, chainId, month)` and is reusable verbatim. |
| **Replay** | yield-tracer `app/scripts/ingest-history.ts --dir … [--url <prod> --token …]` | **Built** for lending NDJSON. A vault replay needs the vault-shaped row type + target (§5). |
| **KV recorder** | lending-sdks `worker-api/src/data/recorders/vaultYields.ts` | A **48-point (~2-day) ring buffer** of `convertToAssets(1e18)` — a sparkline cache, NOT history. Leave as-is. |
| **TradingStrategy dumps** | lending-sdks `scratch/tradingstrategy/` (`vault-historical.parquet` 168 MB + `vault-metadata.json` 40 MB, 2026-06-01) | Unreferenced local dataset, schema undocumented in-repo. Not a backfill source until verified against TradingStrategy. |

What does NOT exist: any vault history fetcher, a `VaultHistoryPoint` type, a
vault ingest path, and any self-archive for the decaying sources.

---

## 2. Per-provider matrix — earn-vault providers

All rates/units per the provider's own API; verify units at wiring time (the
`APR_BACKFILL.md` percent-vs-fraction discipline applies here too).

### 2.1 Official full-depth history — one-shot backfill works

| Provider | History source (✓ = curl-verified 2026-08-26) | Granularity / depth | Notes |
| --- | --- | --- | --- |
| **morpho** | same `blue-api.morpho.org/graphql` the fetcher uses: `vaultByAddress { historicalState { apy netApy sharePriceUsd sharePriceNumber totalAssetsUsd (options:{startTimestamp, interval}) { x y } } }` ✓ | HOUR/DAY/WEEK/MONTH/QUARTER/YEAR; steakUSDC = 960 daily pts to **2024-01-04 inception**, no cap | Best in class; serves the netApy/rewards split. **Field is `sharePriceUsd`/`sharePriceNumber` — `sharePrice` fails GraphQL validation.** |
| **silo** | same `api-v3.silo.finance` GraphQL: `vaultTimeseriess(where:{vaultId, chainId}, orderBy:"timestamp")` → `apr, userApr, totalAssetsUsd, assetRatio, blockNumber` ✓ | hourly recent / daily older, back to vault creation, no cap | Also `marketTimeseries`, `feeTimeseries`, `oracleTimeseries`. |
| **pendle** | `api-v2.pendle.finance/core/v1/{chainId}/markets/{addr}/apy-history` (hourly `{underlyingApy, impliedApy}`, paginated `limit=1440`) ✓ + `…/historical-data?time_frame=day` ✓ + `/core/v4/{chain}/prices/{addr}/ohlcv` ✓ | hourly + daily, inception → **maturity** (matured markets keep their full life) | |
| **yearn** | NOT yDaemon — the official **Kong** GraphQL `kong.yearn.farm/api/gql`: `timeseries(chainId, address, label:"apy-bwd-delta-pps", component:"net", limit)` + `tvls(...)` ✓ | daily; probed vault 891 pts to **2024-03-12 inception** | yDaemon's `apr.points` are trailing averages, not history. |
| **upshift** | upstream `api.upshift.finance/api/v1` (openapi at the nonstandard `/api/v1/openapi.json` ✓): `GET /upshift/historical_apy/chart?vault_address=&days_ago=` + `GET /upshift/historical_asset_share_ratio/chart/{vault_address}?days_ago=` ✓, unauth | daily; `days_ago=2000` reached **Nov-2024 inception** — not rolling | The fetcher's `app.upshift.finance/api/proxy/vaults` proxy forwards ONLY that exact path — history guesses fall through to SPA HTML with HTTP 200. |
| **gmx** | NOT gmxinfra — the official subsquid `gmx.squids.live/gmx-synthetics-{chain}:prod/api/graphql`: `aprSnapshots { address aprByFee aprByBorrowingFee snapshotTimestamp entityType }` + `pnlAprSnapshots`, `cumulativePoolValues`, `prices` ✓ | first snapshot **2023-09-26** → today | Field-name gotcha: `aprByFee` singular. gmxinfra has zero history routes. |
| **lagoon** | same `api.lagoon.finance/query` GraphQL: `vaults { items { stateHistory { pricePerShare { x y } totalAssetsUsd { x y } } } }` ✓ | event-driven per settlement (~daily median), pricePerShare to inception | **Dense series trimmed to ~1000 newest points** (one vault's `totalAssetsUsd` started 2.5 months after its own pps series) — back it up soon. APR not in history; derive from pps. Filter is `chainId_eq`, points are `{x,y}`. |

### 2.2 No usable API history — DefiLlama + archival, and self-archive NOW

| Provider | Situation (✓ verified) | Fallback |
| --- | --- | --- |
| **hypercore** | **Worst case.** `vaultDetails.portfolio` windows are **downsampled to fixed point-counts** — HLP `allTime` = 97 pts over 3.3 years (~12-day spacing); the fine data exists only in the rolling `day`/`week`/`month` windows ✓. `apr` is a single spot number. | **None on-chain** (HyperCore ≠ EVM, no archival read; no DefiLlama vault pools). A daily self-archive loses nothing; a later backfill loses everything but the coarse curve. **Start first.** |
| **fluid (fTokens)** | `api.fluid.instadapp.io/v2/{chain}/vaults/{id}/apr-history` answers **200 `[]` for every vault and every param** — a stub ✓. | fToken is 4626 → archival `convertToAssets` ✓; DefiLlama `fluid-lending` (136 pools). |
| **spectra** | `/api/v1/{network}/pools/history` returns **200 `{"data":[]}` for every param combination** — same stub class ✓. | DefiLlama `spectra-v2` (19) + `spectra-metavaults` (4) — partial vs our 33 rows; archival reconstruction is heavy (Curve-SNG pool + `previewRate` replay). Self-archive the pools listing. |
| **termmax** | `/vault/item` is spot; `/v2/market/chart/apy?…&timeFrame=` exists but `timeFrame` is a RESOLUTION (1m/1h/1d) not a window, keys per-(market, ORDER), and returned only today's points on a live pair ✓. Join on the order's own `marketAddress`, not the market row's. | Vault is 4626 → archival ✓; DefiLlama `termmax` (11). Self-archive `vault/list` APRs. |

### 2.3 Archival on-chain reconstruction is the canonical series

| Provider | Why | Notes |
| --- | --- | --- |
| **lista** | On-chain fetcher, no API (`api.lista.org` exists but every guessed route 404'd ✓) | Moolah vault is a MetaMorpho-fork 4626 → exact. DefiLlama `lista-lending` (20). |
| **gearbox** | `charts-server.fly.dev` is **dead** (connection timeout ✓); successor `charts-legacy.gearbox.foundation` is alive (`/api/v1/` prefix confirmed) but route shapes not recovered from the minified bundle — read the `Gearbox-protocol/charts-server` repo source before more blind probing. | PoolV3 is 4626 → archival ✓ (+ `supplyRate()` point reads). DefiLlama `gearbox` (11). |
| **aave-earn** | The Aave GraphQL `Vault` type is spot-only ✓. `supplyAPYHistory(request:{chainId, market, underlyingToken, window})` ✓ is **reserve-level, ≤ LAST_YEAR**, and can't net out the vault fee (fee has no history). **Silently returns `[]` for a wrong `market` address** — it wants the Pool (`0x87870Bca…`), not the PoolAddressesProvider. | Archival `convertToAssets` over the 4626 wrapper is exact and captures the fee → canonical. No DefiLlama coverage (aave-v3/v4 pools are reserves, not these vaults). |
| **euler-earn** | `GET v3.euler.finance/v3/earn/vaults/{chainId}/{address}/totals?resolution=1h\|1d&from=&to=` ✓ exists but is **shallow and patchy per vault** — one Jun-2026 vault had 65 daily pts, a Dec-2025 vault had only 2 zeroed creation rows; the no-param call silently serves ~31 days; `totalAssetsUsd` is always null (their own `note` admits it). | Archival 4626 is the trustworthy series; API as cross-check only. DefiLlama under `euler-v2` (154). |
| **lst (class)** | 27 on-chain readers, no single API. (a) **exchange-rate LSTs** (wstETH `stEthPerToken`, rETH, weETH, rsETH, cbETH, ankr ratio, …): rate is on-chain state → **exact, arbitrarily far back**. (b) **operator-pushed / off-chain rates** (`offChain.ts` reader, Veda/BoringVault-style, bridged mirrors): point reads only. (c) official APR APIs are mostly rolling (Lido SMA = 7d). | DefiLlama for the majors (`lido`, `rocket-pool`, `ether.fi-stake`, `binance-staked-eth`, …). Self-archive the off-chain-rate subset. |

---

## 3. Per-source matrix — savings sources added after APR_BACKFILL.md (2026-08-04)

These rows extend `../lending-sdks/packages/margin-fetcher/src/vaults/savings/APR_BACKFILL.md`
(same column semantics). All ✓ probes 2026-08-26.

| Asset | Official history API | Granularity / retention | DefiLlama | On-chain backfill | Verdict |
| --- | --- | --- | --- | --- | --- |
| wstGBP (Wren) | **the fetcher's own URL** `wstgbp.com/api/nav-growth` ✓ already returns a `history` array — the full-life NAV restatement series (starts exactly 1e18 on 2026-04-10, ~weekly steps). `windowDays` is ignored. | per-restatement, since inception | none | `wren-nav` step NAV — archival reads carry the documented +17 % step-function bias; API is canonical | official — no new endpoint needed |
| stcUSD (Cap) | `api.cap.app/v1/vaults/1/0xcCcc…cccC/timeseries/1d_1Y` ✓ — 365 daily pts with `stakingApr/Apy` + pps ratio + TVL decomposition. Fetcher only pulls `1d_1M`. | daily, **365-pt ROLLING** — `1d_ALL`/`1d_2Y` are Cloudflare-403'd (error 1020), not truncated; window opens 2025-08-20 mid-life | `bf6ca887-…` (2025-08-21, pps on last ~102 pts) ✓ | plain 4626 ✓ | official (windowed) + archival; **pull `1d_1Y` once now** — history >365d is lost daily |
| hbUSDT / hbUSDC / lstHYPE / liquidHYPE (Hyperbeat) | the fetcher's exact URL `api.hyperbeat.org/api/v1/vaults/apy/<vault>` with **`?limit=N` raised** pages the whole store ✓ — hbUSDT 625 daily pts to **2025-05-06** (predates the live Vault-Infra periphery; early rows 0 = the retired Midas era); each row carries `apy_1d/3d/7d/30d/since_launch` | daily, since 2025-05-06 | none | `Pricer.getRate()` point reads — realized curve, no accumulator (Native-wNLP class) | official — one call per vault, full depth |
| wiTRY (Brix) | **none** — `apy-snapshot` is a trailing-window aggregate; `windowDays=365` → HTTP 503 body `null` (re-confirmed ✓; the boundary moves with vault age); `/api/witry/apy-history` is SPA shell | — | `da8c4ac9-…` (2026-06-03, **pps ✓ all 78 pts**) — starts ~6 weeks AFTER the 2026-04-23 launch | plain 4626 ✓ — **only source for the first 6 weeks** | DefiLlama + archival |
| Strata sr/jr tranches (7 CDOs) | the fetcher's exact URL `s3.strata.money/tranches/analytics-v18.json` ✓ — each CDO carries `all` (**full-life WEEKLY**, 7-day spacing verified; ethenaCdo since 2025-10-05), `d30` (30 daily), `d7`; every point has `blockNr` + `jrt/srt .apr/.apy/.price` + tvl + coverage | weekly full-life; daily only last 30 d | 15 `strata-markets` pools ✓ (daily, deeper than `d30`, shallower than `all`) | plain 4626 ✓ (`previewRedeem` nets the exit fee, `convertToAssets` doesn't) | official (weekly) + DefiLlama (daily) + archival. **URL is version-pinned (`-v18`)** — a bump silently strands the job |
| yb-* (Yield Basis) | the fetcher's exact URL `api.yieldbasis.com/v1/analytics/markets/snapshots/1/{idx}?window=all&timeframeSeconds=86400` ✓ — daily since 2026-05-25 (current-gen inception), full raw state (`ppsRaw`, `virtualPriceRaw`, `sampleBlockNumber`); sister `…/markets/trading-apy/…` ✓ same depth | daily, current-gen life | still none | `yieldbasis-lt` reader — NOT 4626; archival `preview_withdraw` point reads (inferred) | official — canonical, no Llama fallback exists. **Trading-APY values are WAD fractions, negatives routine** |
| apyUSD (Apyx) | none — `/v1/rewards/seasons/2/discover` ✓ is a spot rewards listing; `/v1/stats/history` + `/v1/vaults/apyusd/history` → 404 ✓ | — | `cb6139f9-…` (2026-04-09, no pps) ✓ | plain 4626 ✓ + the `ApyUSDRateView` formula is reconstructible at archival blocks | DefiLlama + archival |
| reUSD/reUSDe (Re) — re-check | `api.re.xyz/price` ✓ — still full daily NAV since inception, and **deeper than the matrix recorded**: reUSDe 492 pts since **2025-04-01** (not 2025-05-26); reUSD 437 pts | daily, inception, unauth | reUSD pool only 140 pts since 2026-04-02 — **10 months shallower than the official API** | still none (NAV oracle keeps no rounds) | official — matrix verdict confirmed. Note: the live fetcher still reads DefiLlama, not `api.re.xyz` — the matrix's "official replaces DefiLlama" is not yet wired |

---

## 4. Traps (hard-won, do not rediscover)

1. **200-with-empty-body stub endpoints**: Fluid `apr-history` → `[]` always;
   Spectra `pools/history` → `{"data":[]}` always. Both look like history
   routes; both are dead stores (the Angle `/v2/historical/savings` class).
2. **yDaemon looks historical but isn't** — `apr.points.{weekAgo,monthAgo,inception}`
   are trailing averages. The real series is Kong, a different service.
3. **Upshift's app proxy forwards only `/vaults`** — every other path answers
   the SPA with HTTP 200. Use `api.upshift.finance` directly.
4. **Hyperliquid `portfolio` arrays are downsampled to fixed point-counts** —
   fine granularity exists only in the rolling windows. No on-chain fallback.
5. **Lagoon trims dense series to ~1000 newest points**; pps (sparser) still
   reaches inception. Schema: `chainId_eq`, `items`, `{x,y}` points.
6. **Morpho's field is `sharePriceUsd`/`sharePriceNumber`**, not `sharePrice`.
7. **Aave `supplyAPYHistory` returns `[]` for a wrong `market` address**
   (wants the Pool, not the AddressesProvider) — empty ≠ no data.
8. **Cap's range token is a whitelist** (`1d_1M`/`1d_1Y` work, `1d_ALL` →
   Cloudflare 403 error 1020) and the 1Y window is ROLLING.
9. **TermMax `timeFrame` is a resolution, not a window**, keyed per-(market,
   order); join on the order's own `marketAddress` field.
10. **Strata's full-life series is WEEKLY** (daily only in rolling `d30`) and
    the URL is version-pinned (`analytics-v18.json`).
11. **Euler-earn `/totals` is patchy per vault** — don't treat one good vault
    as proof of coverage; always pass explicit unix `from`/`to`.
12. **Hyperbeat's history predates its own live periphery** (early zeros from
    the retired Midas era) — a realized-since-launch join must handle them.

---

## 5. Build plan

The lending pipeline is the template: fetch → NDJSON → replay to the prod
origin. Reuse everything except the point type.

**A. Core type** (`packages/core/src/`): a `VaultHistoryPoint` +
`VaultHistoryFetcher` sibling of `history.ts` — do NOT bend `HistoryPoint`:
its `marketUid` doc-contract ("must match `computeMarketUid` … or the row will
not join `markets`") and the closed `HistorySource` union are lending-side
guarantees. Vault rows key on `vaultUid = vault.<provider>:<chainId>:<address>`
(the exact uid `earn.ts` already parses), carry
`sharePriceRaw` (integer string), `apr`/`rewardsRate` (percent — match
`vaults_snapshots` units, NOT the lending fractions), `totalAssets`,
`totalAssetsUsd`, `blockNumber?`, `dataTs` (hourly bucket via `bucketStart`),
`source`. Reuse `bucketStart`, `realizedApy`, `pointKey` (accepts any uid
string), and `NdjsonSink` verbatim.

**B. Fetchers** (`packages/fetchers/vault-*` or one `vault-history` package
with per-provider modules): wrap the §2.1/§3 verified endpoints. Registry
entries in `packages/history-runner/src/index.ts` (`FETCHERS` +, for the
decaying set, `DECAYING`, which inherits the 03:10 UTC `capture-history.yml`
ratchet for free). Note the runner's `main()` bootstrap
(`fetchLenderMetaFromDirAndInitialize`) is lender-specific — vault fetchers
need a skip flag or their own init (the vault roster can come from
margin-fetcher's registries or yield-tracer's `vaults_latest`).

**C. Ingest** (yield-tracer): lowest-friction is a replay script writing
directly into `vaults_snapshots` — no FK to satisfy, unique index is the
idempotency key, `onConflictDoNothing` is the established write mode, and
`/earn/history` reads it immediately. Consider mirroring migration `0107`'s
`source varchar(32) DEFAULT 'live-cron'` column onto `vaults_snapshots` so
backfilled rows are distinguishable. A `POST /ingest/vault-history` route
(clone of `ingest/lendingHistory.ts`, minus the markets-existence check) is
the remote-origin variant, matching `ingest-history.ts --url` semantics.

**D. Ranked order** (what decays first):

1. **Self-archives NOW** (lose data every day): HyperCore fine windows (no
   fallback at all), Cap `1d_1Y` (one-shot now, then daily), Spectra pools
   listing, TermMax `vault/list` APRs, Fluid fTokens, the off-chain-rate LST
   subset, Lagoon dense series (~1000-pt cap).
2. **One-shot full-depth backfills**: Morpho GraphQL, Silo `vaultTimeseriess`,
   Kong (yearn), Upshift charts, Pendle apy-history, GMX squid, Lagoon pps,
   Hyperbeat (`limit=`), Strata S3, Yield Basis snapshots, Re `api.re.xyz`,
   Wren nav-growth; DefiLlama `/chart/{poolUuid}` for the rest.
3. **Archival-reconstruction jobs**: lista, gearbox, aave-earn, euler-earn,
   fluid, exchange-rate LSTs, Brix's first 6 weeks (see APR_BACKFILL.md for
   the savings archival classes).
