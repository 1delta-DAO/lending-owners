# Solana history backfill — implementation plan

The Solana sibling of [LENDING_HISTORY_BACKFILL_PLAN.md](LENDING_HISTORY_BACKFILL_PLAN.md)
(the Aave/Morpho/EVM backfill) and [VAULT_HISTORY_BACKFILL_PLAN.md](VAULT_HISTORY_BACKFILL_PLAN.md).
The architecture is unchanged:

- **Collection** happens here: `packages/history-runner` → NDJSON in `data/history/<KEY>/solana/<yyyy-mm>.ndjson`.
- **Ingestion** happens in yield-tracer: `app/scripts/ingest-history.ts`, or `pnpm export:history-sql` + `app/scripts/apply-history-sql.sh`.
- **Runbook:** `yield-tracer/app/scripts/PROD_HISTORY_INGEST.md`.

Status: **analysis and design complete 2026-10-03. Nothing built.** Every
endpoint marked ✓ was curl-verified live on 2026-10-03. Every mapping marked
**[checked]** was compared against prod live-cron rows the same day. Anything
marked *inferred* was not checked.

---

## Contents

0. Summary and decisions
1. What prod holds, and the universe
2. Source matrix
3. Mapping rules, per family (the unit contract)
4. Work packages
5. Run order, sizing and schedule
6. Ingest and verification
7. Rollback
8. Permanently lost data
9. Open questions
10. Appendix: request templates

---

## 0. Summary and decisions

- **Prod has almost no Solana history.**
  - `lending_snapshots`: from **2026-09-30**.
  - `vaults_snapshots`: from **2026-10-02 20:00**.
  - Everything before that is backfill.
- **Solana has no tier-C replay.** RPC cannot read account state at a past slot, and transaction parsing cannot rebuild share values (§8). Whatever the APIs below do not serve is gone.
- **Four sources roll and lose a day every day.** WP0 captures them, and it ships before anything else:

  | source | window | oldest point on 2026-10-03 |
  | --- | --- | --- |
  | Project 0 banks | 30 d | 2026-09-03 |
  | Save rates + exchange rate | 90 d | 2026-07-06 |
  | Jupiter Lend (Fluid backend) | 1 y | 2025-10-03 (the launch month is already gone) |
  | Loopscale term ladder | 30 d | — |

- **Kamino is the core of the backfill.**
  - Reserves and kvaults are served to inception with no window cap.
  - 266 + 183 objects, ~275 requests at daily resolution.
  - Kamino is ~60 % of Solana TVL in the book.
- **Decisions taken in this plan:**
  1. **One new package, `packages/fetchers/solana`.** It holds all Solana `hist/` modules. They share a paced HTTP client, and none needs margin-fetcher-sol at runtime.
  2. **Lending rows resolve by uid lookup against the live book, verbatim.** Nothing derives a uid locally, and `makeMarketUid` is never called (it lower-cases, §4 WP1).
  3. **Daily resolution is the default; hourly is an opt-in second pass.**
     - Daily: Kamino, kvaults, Project 0 `all`, Save `90d`.
     - Hourly where the source is hourly anyway and the volume is small: Jupiter `1y`, Project 0 `1w`.
  4. **DefiLlama fills only the days the first-party source cannot.** Every DefiLlama run is capped at the first-party floor, so it never competes for a `(uid, ts)` key.
  5. **No first-party key is ever reused for a different source.** Provenance lives in `source`, and rollback is per source.

## 1. What prod holds, and the universe

Measured through the public read API (`yields.1delta.io`) on 2026-10-03.

| family | rows in `/pools/latest` | lender keys | TVL | live shape | uid leaf |
| --- | ---: | ---: | ---: | --- | --- |
| Kamino | 200 | 42 | $2.56B | Compound V2 | **reserve** address |
| Jupiter Lend | 220 | 110 | $1.55B | Fluid, one key per vault | token **mint**. Two rows per vault: `Collateral X` and `Loan Y` |
| Project 0 | 86 | 1 group | $7M | generic | bank address *(inferred from the leaf; confirm in WP1)* |
| Save | 6 | 2 | $8M | Compound V2 | reserve address |
| Loopscale | — (hidden: fixed-term) | 196 pairs | — | Morpho Midnight | — |

- The registry endpoint the runner already loads, `yields-r0.1delta.io/meta/lending/complete`, carries **371 Solana lender keys / 1,250 uids**. No new uid source is needed.
- Earn surface (`/earn/latest?chainId=solana`):

  | provider | vaults | `vault_address` is | table |
  | --- | ---: | --- | --- |
  | `kamino-kvault` | 45 (Kamino lists 183) | VaultState account | `vaults_snapshots` |
  | `loopscale` | 24 | **LP mint**; the vault account is in `vault_loopscale_meta` | `vaults_snapshots` |
  | `exponent` | 18 | **PT mint**; the Exponent vault account is `exponent_vaults_latest.vault_account` | **`exponent_vaults_snapshots`** |
  | `jupiter-lend` | 9 | jl token mint | `vaults_snapshots` |
  | `savings` | 4 | eUSX, SR-/JR-strcUSX, Huma PST | `vaults_snapshots` |
  | `lst` | 2 | JitoSOL, bSOL mint | `vaults_snapshots` |

## 2. Source matrix

### 2.1 Lending

| family | endpoint ✓ | carries | resolution | depth | requests |
| --- | --- | --- | --- | --- | ---: |
| **Kamino** | `GET api.kamino.finance/kamino-market/{market}/reserves/{reserve}/metrics/history?start&end&frequency=day\|hour` | `supplyInterestAPY`, `borrowInterestAPY` (APY fractions, bucket mean); `totalSupply`, `totalBorrows` (tokens, mean); `depositTvl`, `borrowTvl` (USD); `exchangeRate` (**last** snapshot in bucket); `assetPriceUSD`; `mintTotalSupply`; `borrowCurve`; LTV/LT/limits | hour or day; buckets labelled by **start** | **inception**, no window cap | 266 (daily) |
| **Jupiter Lend** | `GET api.solana.fluid.io/v2/{m}/borrowing/vaults/{id}/charts/{supply-rate\|borrow-rate\|total-supply\|total-borrow}?range=1y` | rates = `*RateLiquidity + *RateMagnifier` (bps); totals normalised to 1e9 | hourly, with holes | **rolling 1 y** | 4 × 92 vaults |
| Jupiter Lend (layer) | `GET api.solana.fluid.io/v1/{m}/liquidity/tokens/{mint}/reserves/charts/{supply-rate\|borrow-rate\|utilization\|total-supply\|total-borrow}?range=1y` | layer rates (bps), utilization (×1e2), raw totals + `assetPriceUsd` | hourly | rolling 1 y | 5 × 39 tokens |
| **Save** | `GET api.save.finance/reserves/historical-interest-rates?ids={≤100 csv}&span=90d` | `supplyAPR`, `borrowAPR`, `*APY` (fractions); `cTokenExchangeRate` | daily 00:00 UTC | **rolling 90 d** | 7 |
| Save (deep) | DefiLlama `yields.llama.fi/chart/{pool}` | supply `apy` %, `tvlUsd` (= available liquidity) | daily | 2022-05-13 | ≤ 58 |
| **Project 0** | `GET app.0.xyz/api/banks/db/{bank}/historic/{all\|1w}`; needs browser UA **and** `Origin` + `Referer: https://app.0.xyz` | `assetShareValue`, `liabilityShareValue`; `totalAssetShares`, `totalLiabilityShares` (raw); `lendingRate`, `borrowingRate` (APR fractions); `integrationRatio`; `oraclePrice` | `all` daily, `1w` hourly | **rolling 30 d** | 86 × 2 |
| Project 0 (deep) | DefiLlama `project-0` | supply APY + liquidity | daily | 2026-01-21 | ≤ 71 |
| **Loopscale** | `POST tars.loopscale.com/v1/markets/rates/principal_collateral/history` | `wAvgBorrowRate`, `avgBorrowRate`, `wAvgActiveBorrowRate` (percent); `totalPrincipalDeployedUsd`; `collateralDepositedUsd` | 3 h | 2026-01-13 | 1 per principal mint |
| Loopscale ladder | `POST …/markets/rates/history` | per-duration `borrowApy`, `lendApy` | 5 min | **30 d**, no paging | 1 per principal mint |

### 2.2 Earn

| provider | endpoint ✓ | carries | depth |
| --- | --- | --- | --- |
| kamino-kvault | `GET api.kamino.finance/kvaults/vaults/metrics/history?vaults={≤25 csv}&start&end` | `sharePrice` (**USD**), `tvl` (USD), `solTvl`, `apy`, `apyActual` (fractions); buckets labelled by **end** | inception (earliest 2025-03-25); all 183 vaults in 8 calls |
| jupiter-lend | `GET api.solana.fluid.io/v1/{m}/lending/tokens/{jl}/charts/exchange-price?range=1y` | `tokenExchangePrice` (1e12) | rolling 1 y |
| loopscale | `POST tars…/markets/lending_vaults/history {vaultAddress, timeLookback, sampleIntervalSecs}` | `netAssetValue`, `lpSupply` (raw); `wAvgApy` (**CBPS**); `externalRewardsApy` | inception (2025-02-28) |
| loopscale earn | `POST tars…/markets/earn/vaults/history {address, timeLookback}` | `navPerShareE18`, `totalAumAssets`, `realizedApyBps*` | inception (2026-06) |
| exponent | `GET app.exponent.finance/api/implied-apy-chart?vaultAddress&timeframeSeconds` | `impliedApy` (fraction), `ptPrice` (in asset), `yearsToMaturity`; per trade | first trade of each maturity |
| exponent (underlying) | `GET app.exponent.finance/api/underlying-apy-chart/{syMint}?timeframeSeconds` | `exchange_rate`, `underlying_apy` | eUSX SY from 2025-10-14 |
| savings: eUSX | the Exponent SY row above; today it equals Solstice `eusxPrice` to 6 digits | | 2025-10-14 |
| savings: Huma PST | Ethereum Chainlink `0x4BE50bE32dB1510240d542f77c5B36Ca0D0965E6` `getRoundData` (6 dec) | PST/USDC | 2026-05-25 |
| lst: JitoSOL | `POST kobe.mainnet.jito.network/api/v1/stake_pool_stats {bucket_type:"Daily", range_filter, sort_by}` | `apy` (fraction), `tvl` (lamports), `supply` | 2022-11-03 |
| lst: bSOL | DefiLlama `blazestake` | apy, tvl | 2026-02-19 |

**Rejected sources:**

- Sanctum `extra-api`: stale `sol-value`, `apy` 0.0 for every LST, no history routes.
- The marginfi API: dead.
- `lite-api.jup.ag/lend/v1`: no history routes.
- DefiLlama `chartLendBorrow`: returns 402.
- Kamino `/yields/{mint}/history`: this is the native yield of a yield-bearing token (syrupUSDC, USDe, PTs), not reserve rates, and it caps requests at 366 days. It feeds `intrinsicYield`, so it is out of scope here.
- The Save 15-minute series: its APR reads ~40 % below the exchange-rate growth (likely unscaled slot time). Only the daily `90d` rows are used.

## 3. Mapping rules (the unit contract)

The target types are the existing ones: `HistoryPoint` (lending) and the vault
point consumed by `sql-vaults.ts` / `integst/vaultHistory`. The rules that
already hold for EVM still hold:

- rates are **percent nominal APR**;
- `dataTs` is an exact hour in UTC;
- the index is a decimal **string**;
- `observedTs` is set whenever the sample instant differs from the bucket label.

### 3.1 Kamino — [checked] against live-cron, main SOL reserve, 2026-10-03 12:00–13:00

| field | from | check |
| --- | --- | --- |
| `depositRate` | `ln(1 + supplyInterestAPY) × 100` | API 5.6614 vs live 5.6616 |
| `variableBorrowRate` | `ln(1 + borrowInterestAPY) × 100` | API 7.3098 vs live 7.3100 |
| `totalDeposits` / `totalDebt` | `totalSupply` / `totalBorrows` | 2,313,127 vs live 2,316,223 (bucket mean vs point sample) |
| `totalDepositsUsd` / `totalDebtUsd` | `depositTvl` / `borrowTvl` | |
| `utilization` | `totalBorrows / totalSupply` | |
| `supplyIndex` | **`1 / exchangeRate`**, computed in decimal (not float) to 30 digits | `exchangeRate` is cTokens per liquidity and only falls. 1/0.86624472 = 1.154408 vs live 1.154402 |
| `borrowIndex` | none (`cumulativeBorrowRate` is present only before 2024-06) | leave unset |
| `indexKind` | `exchange_rate` | same as live |
| `observedTs` | bucket **end** for the index | API `exchangeRate` at hour H matches live at H+1 (1.1548307 @11:00 vs live 1.1548324 @12:00). Without this, every daily step is mislabelled by up to a day (see `alignToObservation`) |

- Rates are converted with `ln(1+x)`, never `×100` alone. A bare `apy × 100` reads ~3 % high at 6 % APY.
- The historic field renames do not touch any field above (`loanToValuePct` vs `loanToValue`, `*LimitCrossedSlot`).
- `exchangeRate` is a JSON number in early rows and a string later. Parse both.
- A wrong `(market, reserve)` pair returns HTTP 200 `history: []`. That is counted as **empty**, not as success.

### 3.2 Jupiter Lend — [checked] against live-cron, `JUPITER_LEND_main_1`

| row | uid | fields |
| --- | --- | --- |
| collateral | `JUPITER_LEND_{m}_{id}:solana:{collateralMint}` | `depositRate = (supplyRateLiquidity + supplyRateMagnifier) / 100`. Checked: 394 bps vs live 3.94. `totalDeposits = total-supply / 1e9`. Checked: 1.780 M SOL vs live 1.779 M |
| loan | `JUPITER_LEND_{m}_{id}:solana:{debtMint}` | `variableBorrowRate = (borrowRateLiquidity + borrowRateMagnifier) / 100`. Checked: live 4.80. `totalDebt = total-borrow / 1e9`. Checked: 65.38 M vs live 65.36 M |

- Fluid rates are already APR. **No `ln` conversion.**
- The uid is **constructed**: the leaf (a mint) is shared by dozens of vaults, so `forFamily` would return nothing. The constructed uid is then verified with the new `registry.has(uid)` (WP1). A uid not in the book is dropped and counted.
- No index. Live writes NULL here, and the backfill matches live.
- USD: `assetPriceUsd` from the layer `total-supply` chart of the same mint and hour. If that is missing, leave USD unset; never price it from another source.
- Use `/v2` for the totals; `/v1` returns 404. Allow a 180 s timeout (cold cache) and concurrency 4.

### 3.3 Save — direction [checked] in margin-fetcher-sol source

- `supplyIndex = cTokenExchangeRate` (liquidity per cToken), **not inverted**. Live writes `saveExchangeRateWad / 1e18`, the same number to the last digit (`save/convertPublic.ts:65`).
- The live value of 0.9338 on one market is a genuine sub-1 rate (*inferred*: a socialised loss), not an inversion.
- `depositRate = supplyAPR × 100` and `variableBorrowRate = borrowAPR × 100`. These are APR already, so no `ln`.
- No totals and no borrow index: the API has neither.
- DefiLlama rows: supply `apy` → `ln(1 + apy/100) × 100`, no index, no totals. The existing `createDefiLlamaLendingHistoryFetcher` is reused, with `to` capped at the first-party floor.

### 3.4 Project 0 — semantics [checked] in margin-fetcher-sol source

The live accumulator (`project0/convertPublic.ts:665–690`) has two cases:

| bank kind | live `supplyIndex` | live `borrowIndex` | backfill from |
| --- | --- | --- | --- |
| plain bank | `assetShareValue` | `liabilityShareValue` | same fields |
| wrapped bank (Kamino / Drift / Jupiter-integrated; `assetShareValue` pinned at 1) | `cache.priceMultiplier` | — | `integrationRatio`. This is the same quantity (1.15 on Kamino-wrapped banks) *(inferred equal: verify on the overlap)* |

The live rows that read 1.0/1.0 are plain banks with no accrual yet, which is
consistent with the code. **This is not a live bug** (it was an open question
in the first draft).

- Rates: `lendingRate × 100` and `borrowingRate × 100` (APR).
- `totalDeposits = totalAssetShares × assetShareValue × (wrapped ? integrationRatio : 1) / 10^mintDecimals`. This mirrors `convertPublic.ts:595`.
- `totalDebt` is the liabilities analogue, without the multiplier.
- USD is the total × `oraclePrice`.
- Ignore `lendingPositionCount`; the API returns negative values.

### 3.5 Loopscale lending

Lowest priority. These rows are hidden from every variable-rate listing, and a
fixed-term book has no single rate.

- If it is done at all:
  - one point per pair lender;
  - `variableBorrowRate = wAvgActiveBorrowRate` (percent);
  - `totalDebtUsd = totalPrincipalDeployedUsd`;
  - no index.
- The ladder (30 d) goes into WP0 as raw JSON only, so the option stays open.

### 3.6 Earn

| provider | `share_price` | `share_price_usd` | `apr` (percent) | tvl |
| --- | --- | --- | --- | --- |
| kamino-kvault [checked] | SOL vaults: `sharePrice × solTvl / tvl`. Others: `sharePrice / assetPriceUSD` of the vault token (from that token's Kamino reserve history, same day) | `sharePrice` as served | `apy × 100`. Checked: live stores percent, 7.0e-5 vs API 7.0e-7 | `tvl` |
| jupiter-lend | `tokenExchangePrice / 1e12` | — | `Δp/p × 365.25·86400/Δt × 100` over consecutive points (the frontend's method) | from the layer `total-supply` of the underlying, *inferred*. Leave unset if unclear |
| loopscale | `netAssetValue / lpSupply` *(derived; verify against live)* | — | `wAvgApy / 1e4` (CBPS → percent) | `netAssetValue` ÷ 10^dec × price |
| exponent | → `exponent_vaults_snapshots`: `implied_apy` (fraction, as live), `underlying_apy`, `supply_rate` via margin-fetcher's `apyToAprPercent` (the Pendle rule) | `pt_price_usd` / `price_usd` only if a same-instant asset price exists; otherwise leave both NULL (the column comment requires the same instant) | | `liquidity_usd` from `30d-timeseries` (last 30 d only) |
| savings eUSX | Exponent SY `exchange_rate` | | `underlying_apy × 100` | |
| savings PST | Chainlink answer / 1e6 | | from Δ share price | |
| lst JitoSOL | `tvl / 1e9 / supply` [checked against on-chain] | | `apy × 100` | `tvl / 1e9` × SOL price |

- **Kvault buckets are labelled by their end.** Subtract one bucket before setting `dataTs`, and set `observedTs` to the served label.
- **Exponent PTs aggregate per trade.** Bucket to the hour by taking the **last** trade in each hour, with `observedTs` set to that trade's timestamp.

## 4. Work packages

Each WP lists its files, what "done" means, and its rough size. Do them in
this order; WP0 does not depend on anything.

### WP0 — Capture the rolling windows (ship first, ~½ day)

- **New** `packages/history-runner/src/capture-raw.ts`. A raw capture that stores responses verbatim, so no parser is needed yet:
  `data/raw/solana/<source>/<yyyy-mm-dd>/<object>.json.gz`
  - P0: `historic/all` + `historic/1w` for every bank in the P0 group. Enumerate the banks from the book registry (`PROJECT_0_*` leaves).
  - Save: `span=90d` over every reserve in `/v1/markets/configs`, 100 ids per call.
  - Jupiter: the full `range=1y` set (§2.1) on the first run; afterwards `range=30d`.
  - Loopscale: `rates/history` for every principal mint, at 30 d.
- `capture-history.yml`: add a step `pnpm capture:raw-solana` after the existing `--decaying` step, and `git add data/raw/solana`.
- Size control: gzip. Jupiter `1y` is captured **once**, then `30d` daily.
  - Measure the size of the first run.
  - If it is over 50 MB, write to object storage instead of git (the README already discusses this for `data/history`).
- **Done when** two consecutive daily runs commit, and the second one's P0 `all` file overlaps the first by 29 days.

### WP1 — Fix the address-case paths (blocker for any Solana export, ~1 day)

All four failures are silent; CLAUDE.md says to never lower-case a base58 address.

| file | today | change |
| --- | --- | --- |
| `packages/core/src/types.ts:55–59` `makeMarketUid` | `underlying.toLowerCase()` | lower-case only when `/^\d+$/.test(chainId)` (mirrors `toAddressKey`) |
| `packages/history-runner/src/sql-vaults.ts:115` | `address: parts[2]!.toLowerCase()` | chain-aware |
| `sql-vaults.ts:155–174` | joins **and writes** `lower(vl.vault_address)` | `CASE WHEN s.chain_id ~ '^\d+$' THEN lower(x) ELSE x END` on both sides, and write the **live** row's `vault_address` verbatim |
| yield-tracer `app/src/integst/vaultHistory/index.ts:228, 242, 275–315` | `toLowerCase()` / `lower(...)` | `toAddressKey(chainId, …)` and the same SQL `CASE` |
| `packages/history-runner/src/registry.ts:44` `key()` | lower-cases the leaf | symmetric, so lookups work, but a lower-case collision between two base58 leaves would now resolve wrongly. Make it chain-aware too |

Also add **`registry.has(uid)`**: an exact-uid membership check, needed by
Jupiter (§3.2). Fill it from the same `/meta/lending/complete` walk.

Tests:

- `makeMarketUid("K", "solana", "So111…")` keeps its case; the EVM case is unchanged.
- `sql-vaults` on a scratch Postgres: a planted `vaults_latest` row with base58 `vault_address` plus one backfill row → the landed `vaults_snapshots.vault_address` is byte-equal.
- The yield-tracer TS path: the same check through `ingestVaultHistory`.
- `/earn/history?earnUid=vault.kamino-kvault:solana:<vault>` returns the backfilled points. This is the end-to-end check that would have caught the bug.

### WP2 — Schema: `source` on `exponent_vaults_snapshots` (~1 h)

`exponent_vaults_snapshots` was created in `0155`, after `0141` added `source`
to the other four snapshot tables. It has **no `source` column**, so
backfilled rows could not be rolled back apart from live ones.

- `app/migrations/0167_exponent_snapshots_source.sql`:

  ```sql
  ALTER TABLE exponent_vaults_snapshots
    ADD COLUMN IF NOT EXISTS "source" VARCHAR(32) NOT NULL DEFAULT 'live-cron';
  CREATE INDEX IF NOT EXISTS exponent_vaults_snap_source_idx
    ON exponent_vaults_snapshots (source) WHERE source <> 'live-cron';
  ```

- **Journal it** in `app/migrations/meta/_journal.json`, then run `node app/scripts/check-migration-journal.mjs` (CLAUDE.md: an unjournalled `.sql` is silently never applied).
- Add `source` to `exponentVaultsSnapshots` in `app/src/db/schema/index.ts`.
- `PROVIDER_OF` (both copies) += `VAULT_EXPONENT: "exponent"`. Teach both vault ingest paths a fifth target table, gated on `exponent_vaults_latest` and re-keyed from the Exponent vault account to the PT mint through `exponent_vaults_latest.vault_account`. This is exactly the Pendle market→PT re-key pattern.
- The other Solana providers need only `PROVIDER_OF` lines (`VAULT_KAMINO_KVAULT: "kamino-kvault"`, `VAULT_JUPITER_LEND: "jupiter-lend"`, `VAULT_LOOPSCALE: "loopscale"`, `VAULT_LST_SOLANA: "lst"`, `VAULT_SOLSTICE` / `VAULT_HUMA: "savings"`), plus the Loopscale re-key from vault account to LP mint through `vault_loopscale_meta`.

### WP3 — Package scaffold `packages/fetchers/solana` (~½ day)

- `src/http.ts`: reuse `PacedClient` from `fetcher-lending-apis`, with per-host limits:

  | host | concurrency | min interval | timeout | note |
  | --- | ---: | ---: | ---: | --- |
  | api.kamino.finance | 4 | 150 ms | 60 s | 429s start at ~8 concurrent |
  | api.solana.fluid.io | 4 | 250 ms | 180 s | cold cache 56–121 s |
  | api.save.finance | 2 | 500 ms | 60 s | |
  | app.0.xyz | 2 | 500 ms | 30 s | send `User-Agent`, `Origin`, `Referer` |
  | tars.loopscale.com | 1 | 500 ms | 60 s | the venue limit is 2/s per IP |
  | app.exponent.finance | 2 | 300 ms | 60 s | |
  | kobe.mainnet.jito.network | 1 | 500 ms | 60 s | |

- `src/decimal.ts`: `invertDecimal(x, digits=30)` for the Kamino index, built on big-integer arithmetic, so that no float touches the index (core `history.ts` requires decimal strings).
- `HistorySource` += `kamino-api`, `jupiter-fluid-api`, `save-api`, `p0-api`, `loopscale-api`, `exponent-api`, `jito-api`, `chainlink-rpc`.
- `CHAIN_BY_LLAMA_NAME` in `fetcher-lending-apis/src/defillama.ts` += `Solana: "solana"`.

### WP4 — Kamino lending + kvaults (~1½ days) — first real backfill

- `src/kamino/hist/lending.ts` → `createKaminoHistoryFetcher()`:
  - **Universe:** `GET /v2/kamino-market` → for each market, `GET /kamino-market/{m}/reserves/metrics` → (market, reserve).
  - **Resolve:** `ctx.resolveUid("solana", reserve)` via `forFamily("KAMINO")`. The leaf is unique, so this works.
  - **Fetch:** one call per reserve with `frequency=day&start=<ctx.from>&end=<ctx.to>`. For `--resolution 1h`, use windows of ≤ 366 days (~36 MB per mature reserve for the full history).
  - **Map:** per §3.1.
  - `earliest`: undefined (inception).
- `src/kamino/hist/kvaults.ts` → `createKaminoKvaultHistoryFetcher()`:
  - **Universe:** `GET /kvaults/vaults` (183).
  - **Fetch:** batches of 25.
  - **Map:** per §3.6. Non-SOL share-price conversion needs the vault token's daily price, so load the reserve history for those mints first, or cache it from the lending run.
- Register `KAMINO` and `VAULT_KAMINO_KVAULT` in `FETCHERS`. Neither is in `DECAYING`.
- **Done when:**
  - `pnpm validate:history` exits 0;
  - the overlap check (§6.1) passes for 5 named reserves (main USDC, SOL, JitoSOL; Ethena USDe; one small market) and 3 kvaults (one SOL, one USDC, one other);
  - the coverage report shows ≥ 195 / 200 Kamino rows resolved.

### WP5 — Jupiter Lend vaults + jl tokens (~1½ days)

- `src/jupiter/hist/lending.ts`:
  - **Universe:** `/v2/{main,ethena}/borrowing/vaults` gives id, supply token and borrow token.
  - Four charts per vault, each `range=1y` (the server ignores dates). Filter to `[ctx.from, ctx.to]` client-side.
  - Join the four series on hour.
  - Construct both uids; keep each only if `registry.has(uid)`.
  - Vault types 2/3 (smart collateral/debt): check what the live rows look like before mapping. If unclear, skip and count them.
- `src/jupiter/hist/earn.ts`: the jl tokens, per §3.6.
- Register `JUPITER_LEND` and `VAULT_JUPITER_LEND`, **both in `DECAYING`** (1 y rolling).
- **Done when** the overlap passes on 5 vaults (SOL/USDC id 1 plus 4 others, incl. one ethena) and 2 jl tokens, and ≥ 210 / 220 rows resolve.

### WP6 — Project 0 + Save (~1 day)

- `src/project0/hist.ts`:
  - **Universe:** P0 bank leaves from the registry.
  - Fetch `historic/all` (daily); with `--resolution 1h`, also `historic/1w`.
  - Wrapped-bank detection: `integrationRatio ≠ 1` or `assetShareValue == 1` for the whole series → wrapped.
  - **Register in `DECAYING`.**
- `src/save/hist.ts`:
  - **Universe:** `/v1/markets/configs` filtered to reserves that resolve (`forFamily("SAVE")`, leaf = reserve).
  - Batches of 100 ids at `span=90d`.
  - **Register in `DECAYING`.**
- DefiLlama fills:
  - Add `["SAVE", ["save"]]` and `["PROJECT_0", ["project-0"]]` to the existing DefiLlama family list, **but under distinct runner keys** `SAVE_LLAMA` / `PROJECT_0_LLAMA`, with `family: "SAVE"` / `"PROJECT_0"` for uid scoping.
  - Add an `outFamily` option to `NdjsonSink` so they write their own trees and coverage rows (today the directory is the family, and the dedup is first-writer, so ordering alone would decide which source wins).
  - Cap `to` at the first-party floor (`now − 90 d` / `now − 30 d`).
- **Done when** the overlap passes on P0 USDC, SOL, JitoSOL and one wrapped bank, and on Save main USDC and SOL.

### WP7 — Earn tail: Loopscale, Exponent, JitoSOL, eUSX, PST, bSOL (~2 days)

- **Loopscale lending vaults:** universe `/markets/lending_vaults/info` (`lendVaults`, ≤ 50 per page). Fetch daily from inception. Re-key to the LP mint (WP2). Verify `netAssetValue / lpSupply` against live `share_price` before the full run.
- **Loopscale earn vaults:** `/markets/earn/vaults` (9 vaults), hourly to inception.
- **Exponent:**
  - universe `/vaults` (88 incl. matured), mapped to PT mints through `exponent_vaults_latest.vault_account`;
  - `implied-apy-chart` per vault;
  - `underlying-apy-chart` per SY mint.
- **JitoSOL:** one POST, daily since 2022-11-03.
- **eUSX:** the Exponent SY series (savings).
- **PST:** Chainlink `getRoundData` walk on an Ethereum RPC from round `(1<<64)+1` upward. It is roughly hourly, so bucket to the hour taking the last round in each hour.
- **bSOL:** the existing `VAULT_LLAMA` path with the `blazestake` pool id added.
- **DECAYING:** none of these, except Exponent `30d-timeseries` liquidity, if it is used at all.

### WP8 — Loopscale lending (optional, ~½ day)

Only if someone needs it. See §3.5.

### WP9 — Coverage, docs, runbook (~½ day)

- `pnpm coverage:history` includes `solana`. It already iterates the registry's chains; confirm that the per-chain table prints `solana`.
- `HISTORY_GAPS.md`: a Solana section listing what is held, what decays and what is lost (§8).
- yield-tracer `PROD_HISTORY_INGEST.md`: a "Solana" subsection with the §6 checks.
- yield-tracer `SOLANA.md` §15: link to this plan.

**Total: ~9 working days.** WP0 must ship in the first hours; WP1 and WP2 come before any export.

## 5. Run order, sizing and schedule

| step | when | what | requests | rows (est.) |
| --- | --- | --- | ---: | ---: |
| 0 | day 0 | WP0 capture live, daily from then on | ~700 first run, ~400/day | raw |
| 1 | after WP1–4 | `KAMINO` daily, from 2023-10-01 | 266 | ~200 k |
| 2 | | `VAULT_KAMINO_KVAULT` daily | 8 | ~45 k (only the 45 vaults in the book land) |
| 3 | after WP5 | `JUPITER_LEND` hourly `1y`, `VAULT_JUPITER_LEND` | ~572 | ~1.9 M (220 rows × 8,760 h). **Pace per §6.3** |
| 4 | after WP6 | `PROJECT_0` daily + hourly, `SAVE` daily, then `*_LLAMA` | ~180 + ≤130 | ~25 k |
| 5 | after WP7 | Loopscale, Exponent, JitoSOL, eUSX, PST, bSOL | ~200 | ~60 k |
| 6 | optional | `KAMINO --resolution 1h` in yearly windows | ~800 | ~5 M. **Pace per §6.3** |

- **Replay the WP0 raw capture.** Once a family's parser exists, the parser also reads `data/raw/solana/<source>/*` (an `--from-raw` flag), so days captured before the module existed are not lost. Without this, WP0 would buy nothing.
- **Schedule:** the cron writes `lending_snapshots` on the hour. Start each apply just after the top of the hour (as on EVM).

## 6. Ingest and verification

### 6.1 Overlap gate (before every export, per family)

Live-cron rows exist from 2026-09-30 (lending) and 2026-10-02 20:00 (vaults).
A small script, `pnpm check:overlap --key <KEY> --chain solana`:

1. pulls `/lending/history?market_uid=…&resolution=1h&days=5` or `/earn/history?earnUid=…&days=5` from `yields.1delta.io` for N sampled uids;
2. compares those hours against the NDJSON;
3. fails the family if any of these does not hold:

   | quantity | tolerance |
   | --- | --- |
   | rates | ≤ 5 bp absolute, or ≤ 2 % relative |
   | totals | ≤ 1 % (means vs point samples) |
   | index / share price | ≤ 1e-5 relative, after the `observedTs` shift |
   | share price, no index (P0 wrapped, Loopscale) | ≤ 1e-4 |

This is the check that settles every *inferred* mapping in §3. Nothing is
exported while it fails.

### 6.2 Apply

Unchanged from PROD_HISTORY_INGEST.md:

```bash
# lending-owners
pnpm validate:history && pnpm export:history-sql --dir data/history --out /tmp/history-sql
# yield-tracer/app — canary: smallest family first
./scripts/apply-history-sql.sh /tmp/history-sql/SAVE
./scripts/apply-history-sql.sh /tmp/history-sql/PROJECT_0
./scripts/apply-history-sql.sh /tmp/history-sql/KAMINO
./scripts/apply-history-sql.sh /tmp/history-sql/VAULT_KAMINO_KVAULT
# … then the rest, one key at a time
```

### 6.3 Pacing the two large runs

Jupiter hourly (~1.9 M rows) and optional Kamino hourly (~5 M rows) are in the
range where PROD_HISTORY_INGEST's "When the load gets big" section applies:

- apply one month file at a time;
- check `pg_stat_replication.replay_lag` and `pg_replication_slots.wal_status` between files;
- stop if `wal_status` leaves `reserved`.

**Check whether `PRIMARY_SLOT_NAME` is set before starting.**

### 6.4 Post-apply checks

```sql
-- what landed, per family and source
SELECT split_part(split_part(market_uid, ':', 1), '_', 1) AS fam, source,
       count(*), count(DISTINCT market_uid), min(data_ts)::date, max(data_ts)::date
  FROM lending_snapshots WHERE chain_id = 'solana' GROUP BY 1, 2 ORDER BY 1, 2;

-- index rows
SELECT source, count(*), count(DISTINCT market_uid)
  FROM market_index_snapshots WHERE market_uid LIKE '%:solana:%' GROUP BY 1;

-- must be 0: every timestamp on an exact hour
SELECT count(*) FROM lending_snapshots
 WHERE chain_id = 'solana' AND date_trunc('hour', data_ts) <> data_ts;

-- must be 0: a backfilled vault address with no byte-equal live row (WP1 regression)
SELECT count(*) FROM vaults_snapshots v
 WHERE v.chain_id = 'solana' AND v.source <> 'live-cron'
   AND NOT EXISTS (SELECT 1 FROM vaults_latest l
                    WHERE l.chain_id = 'solana' AND l.vault_address = v.vault_address);

SELECT source, count(*) FROM exponent_vaults_snapshots GROUP BY 1;
```

Then check the product itself:

- `/lending/history?market_uid=KAMINO_7u3HeHxYDLhnCoErrtycNokbQYbWGzLs6JSDqGAv5PfF:solana:d4A2prbA2whesmvHaL88BH6Ewn5N4bTSU2Ze8P6Bc4Q&days=1100`:
  - reaches 2023-10-12;
  - `gapPp` (realized vs quoted) is within ±0.3 pp. A gap near the APY/APR spread means the `ln` was skipped; a hugely negative one means the index was not inverted.
- `/earn/history?earnUid=vault.kamino-kvault:solana:A1so1bPD3W1TfeFwboDh8yfAAVaVtcdAYBYCjhg2mJQ&days=600` reaches 2025-04-15, and the share price is continuous into the live tail (no step at 2026-10-02).
- `/earn/history` for one Exponent PT and for JitoSOL (`vault.lst`).

## 7. Rollback

Provenance is first-writer, so these never delete a live measurement:

```sql
DELETE FROM lending_snapshots         WHERE chain_id = 'solana' AND source <> 'live-cron';
DELETE FROM market_index_snapshots    WHERE market_uid LIKE '%:solana:%' AND source <> 'live-cron';
DELETE FROM vaults_snapshots          WHERE chain_id = 'solana' AND source <> 'live-cron';
DELETE FROM exponent_vaults_snapshots WHERE source <> 'live-cron';            -- needs WP2
-- or one source only, e.g. DefiLlama:
DELETE FROM lending_snapshots WHERE chain_id = 'solana' AND source = 'defillama-api';
```

## 8. Permanently lost data

| gap | why |
| --- | --- |
| Jupiter Lend before 2025-10-03 (launch month) | 1-year rolling window |
| Project 0 indices, borrow rates and totals before 2026-09-03 | 30-day window. DefiLlama has supply APY only, from 2026-01 |
| Save borrow rates and index before 2026-07-06; Save totals entirely | 90-day window, and no totals in the API. DefiLlama has supply APY back to 2022 |
| Loopscale term ladder before 2026-09 | 30-day window, no paging |
| SR/JR-strcUSX entirely; Huma PST before 2026-05; bSOL before 2026-02 | no source found |
| Kamino reserves no longer in the roster | the history routes need the reserve key, and no listing returns it |
| Some older Exponent maturities | the API returns `[]` (*inferred*: legacy AMM) |

**On-chain is not a way out.**

- `api.mainnet-beta.solana.com` serves old blocks.
- But the P0 USDC bank alone is ~40 k signatures per day.
- And the marginfi accrue events carry no share value.

Transaction parsing can at most recover vault balances. It might be viable
for the low-volume Solstice and Huma programs (*inferred*), and that is out of
scope here.

## 9. Open questions

Each is settled by the §6.1 overlap gate, not by argument:

1. P0 wrapped banks: does `integrationRatio` equal the live `cache.priceMultiplier`?
2. Kvault non-SOL share price: is `sharePrice / assetPriceUSD` within 1e-4 of the live `share_price`?
3. Loopscale: does `netAssetValue / lpSupply` equal the live `share_price`?
4. Jupiter vault types 2/3: what do their live rows look like?
5. Keep Jupiter hourly, or downsample to daily? Hourly is ~1.9 M rows and needs paced apply; daily is ~80 k.

## 10. Appendix — request templates

```bash
UA='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129 Safari/537.36'

# Kamino reserve, daily to inception
curl -s "https://api.kamino.finance/kamino-market/7u3HeHxYDLhnCoErrtycNokbQYbWGzLs6JSDqGAv5PfF/reserves/d4A2prbA2whesmvHaL88BH6Ewn5N4bTSU2Ze8P6Bc4Q/metrics/history?start=2023-10-01&end=2026-10-04&frequency=day"

# Kamino kvaults, ≤25 per call
curl -s "https://api.kamino.finance/kvaults/vaults/metrics/history?vaults=A1so1bPD3W1TfeFwboDh8yfAAVaVtcdAYBYCjhg2mJQ&start=2025-01-01&end=2026-10-04"

# Jupiter Lend vault 1 (main), 1 year hourly
curl -s "https://api.solana.fluid.io/v2/main/borrowing/vaults/1/charts/total-borrow?range=1y"

# Save, 90 days daily
curl -s "https://api.save.finance/reserves/historical-interest-rates?ids=<reserve>[,<reserve>…]&span=90d   # reserve ids from /v1/markets/configs"

# Project 0 bank, 30 days daily
curl -s -A "$UA" -H 'Origin: https://app.0.xyz' -H 'Referer: https://app.0.xyz/' \
  "https://app.0.xyz/api/banks/db/2s37akK2eyBbp8DZgCm7RtsaEz8eJP3Nxd4urLHQv7yB/historic/all"

# Loopscale lending vault, daily to inception
curl -s -X POST https://tars.loopscale.com/v1/markets/lending_vaults/history -H 'content-type: application/json' \
  -d '{"vaultAddress":"AXanCP4dJHtWd7zY4X7nwxN5t5Gysfy2uG3XTxSmXdaB","timeLookback":63072000,"sampleIntervalSecs":86400}'

# Exponent PT implied APY
curl -s "https://app.exponent.finance/api/implied-apy-chart?vaultAddress=<exponent vault account>&timeframeSeconds=63072000"

# JitoSOL
curl -s -X POST https://kobe.mainnet.jito.network/api/v1/stake_pool_stats -H 'content-type: application/json' \
  -d '{"bucket_type":"Daily","range_filter":{"start":"2022-10-01T00:00:00Z","end":"2026-10-04T00:00:00Z"},"sort_by":{"field":"BlockTime","order":"Asc"}}'
```
