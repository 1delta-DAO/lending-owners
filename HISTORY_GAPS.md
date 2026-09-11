# Historical data — gaps, checklist, full picture

Status date: **2026-09-11**. This is the operational checklist for the
history axis (both the lender side and the vault-provider side). The design
docs stay where they are — [LENDING_HISTORY_BACKFILL_PLAN.md](LENDING_HISTORY_BACKFILL_PLAN.md)
for the lender side, margin-fetcher's `src/vaults/HISTORY_APIS.md` for the
curl-verified vault-provider source matrix, and its
`src/vaults/savings/APR_BACKFILL.md` for the savings registry. This file
answers only: **what do we hold, what decays, what is missing, and who has
to do what next.**

> **Generate the current numbers instead of trusting this file's date:**
> `pnpm coverage:history` writes `data/coverage/COVERAGE.md` (gitignored) —
> held markets per key/chain/market, the missing side of the live book split
> into "backfill run" vs "no module", the earn-side sources that are fetched
> live but never backfilled (§3b, from the roster in
> `packages/history-runner/src/vault-providers.ts`), and the rows that will not
> join `markets`. This file stays the narrative: why a gap exists and who has to do
> what. The tables below are a snapshot; the report is the measurement.

## 1. What is captured (on disk in `data/history/`)

### Lender side (`hist/` modules, `pnpm fetch:history -- --lender <KEY>`)

| key | module | depth held | notes |
| --- | --- | --- | --- |
| MORPHO_BLUE | ✅ | full depth + share price | one-shot backfill is cheap at ANY depth (complexity is per-page, not per-window) |
| COMPOUND_V3 | ✅ | 30-day rolling → committed daily | ratchet; one unmapped Base comet dropped (`0x2c7760…`) |
| LLAMALEND | ✅ | 100-snapshot rolling → committed daily | ratchet; no share-price series (archival A6 still open) |
| AAVE_V3 | ✅ | on disk | |
| EULER | ✅ | on disk | API floor 2026-04-23 (mainnet) — pre-floor is NOT recoverable from the API |
| MOONWELL | ✅ | on disk | |
| VENUS | ✅ | on disk | |

### Vault-provider side (`@lending-owners/fetcher-vaults`, BUILT + backfilled 2026-08-25)

Full backfill run 2026-08-25 (~1.06M points, ~290 MB NDJSON, all exit 0;
Pendle's 195 rate-limited markets re-run to zero skips).

| key | series | depth held | oldest point |
| --- | --- | --- | --- |
| VAULT_MORPHO | pps + netApy + TVL | inception | per-vault (earliest 2025-01 on chain 10; chain 1 vaults reach Jan-2024) |
| VAULT_PENDLE | impliedApy + TVL | inception | 2023-08 |
| VAULT_FLUID | supply+borrow APR (block-pinned) | inception | 2024-02 |
| VAULT_YEARN | pps + APY + TVL | inception | 2024-01 |
| VAULT_GMX | daily APR (GM + GLV) | 2023-09 (squid genesis) | 2023-09-27 |
| VAULT_UPSHIFT | pps + APY + TVL | inception | 2024-08 |
| VAULT_LAGOON | pps + TVL | inception | 2025-10 |
| VAULT_SILO | pps + APR + TVL | indexer genesis | 2025-05 |
| VAULT_YIELDBASIS | pps + trading APY (signed) | inception | 2025-09 |
| VAULT_HYPERCORE | TVL only | inception (~weekly) | 2023-05 (HLP) |
| VAULT_HYPERBEAT | APY only | inception | 2025-05 |
| VAULT_CAP | pps + APY + TVL | **1y rolling cap** | now−365d |
| VAULT_GEARBOX | pps + APY + liquidity | **1y rolling cap** | now−365d |

### Savings-registry and earn sources (BUILT 2026-09-09)

Thirteen modules that close §3.1/§3.3 below. Every endpoint was re-curled
before the module was written — all thirteen were still live — and each module
header cites the matrix row it implements.

| key | series | depth held | note |
| --- | --- | --- | --- |
| VAULT_RE | NAV (pps) + trailing APY | inception (reUSD 2025-05, reUSDe 2025-04) | one call serves both tokens; ~10 months deeper than the Llama pool the live fetcher still reads |
| VAULT_SDOLA | pps + APY + TVL | inception 2024-02-08 | schema drifts across the archive; early rows carry `apr` only |
| VAULT_SKY | rate + total (+util/borrow for stUSDS) | **365d rolling** | sUSDS, sDAI, stUSDS; `days_ago` is a whitelist — bigger is a 500 |
| VAULT_SPARK | rate + TVL | **365d rolling** | 6 vaults in one call; `sUSDS` in that feed is Sky's and is skipped here |
| VAULT_SFRXUSD | pps + APR + APY + supply | inception 2025-05 | block-stamped both sides (Ethereum + Fraxtal) |
| VAULT_WREN | NAV (wad) | inception 2026-04-10 | the spot fetcher's own URL already carried `history` |
| VAULT_STRATA | pps + APR/APY + TVL per tranche | inception (weekly) | 5 CDOs × sr/jr; mm1usd + nopal have no pinned tranche tokens and are skipped |
| VAULT_USDD | APY | since 2025-09 (Ethereum) | bsc/tron skipped — no verified share-token address |
| VAULT_EULER_EARN | pps + APY + TVL | **2026-04-23 floor**, patchy per vault | `visibility=` is mandatory (every Earn vault is hidden); `totalAssetsUsd` is populated, contrary to the plan's note |
| VAULT_YO | APY (30d) + TVL (full) | TVL to inception, APY 30d rolling | two routes with different depths, merged into one series |
| VAULT_FALCON | APY | **365-point rolling** | `share_price`/`tvl` measurements are rejected by the API |
| VAULT_TORI | APY | **30-point rolling** | the vault is now older than the series — that settles the matrix's open question: the window ROLLS |
| VAULT_LLAMA | APY + TVL + pps when present | since pool listing | the generic `/chart/{poolUuid}` fallback, seeded with 5 no-official-API assets; adding one is a line. 2026-09-11: + Saturn sUSDat (the INCOME leg — see VAULT_ONCHAIN for why both are kept) and f(x) fxSAVE |

### The "no upstream history" rows (BUILT 2026-09-11)

The savings registry is per-asset and the roster above was per-source, so
every brand without a module was fetched daily and invisible to §3b. Three
modules close that, and the roster now carries a row per brand.

| key | series | depth held | note |
| --- | --- | --- | --- |
| VAULT_ONCHAIN | pps (+ size) at ONE block per day, archival `eth_call` | archival where a chain's public endpoints serve old state; head-only where they do not | **167 vaults / 14 chains**, generated from margin-fetcher's `SAVINGS_REGISTRY`: Saturn sUSDat, the Venus Liquidity Hub ×3, Vesper ×11 (`pricePerShare`), Hyperbeat's Pricer ×4 (the §3.1 share-price gap), Bitway ×6, Native ×108, Theo's RedStone feed on Stable, and every plain-4626 row with a current-only API (Neutrl, Parallel, Angle, Avant, OpenEden, Maple, YieldFi, Resolv, Reservoir, Resupply, InfiniFi, Hastra, f(x), scrvUSD). Blocks pinned by `coins.llama.fi/block`, bisection elsewhere; every point carries its `blockNumber`. Archival probed per run: 5/13 Ethereum and 2/27 BNB endpoints on the `rpc-tester` list serve 30–90-day-old state; Robinhood has none (head-only), Stable is reached through `rpc.stable.xyz`. In `DECAYING` because a day nobody samples on a pruned chain is gone |
| VAULT_BITFI | pps per EPOCH from the contracts' own ledgers | full life (vaults 2025-11-03 →; bfBTC datable from the vaults' launch) | `epochRatios(e)` self-timestamped; bfBTC `ratio(e)` dated through the vaults' clock via a pinned epoch offset (416 ↔ 281, re-checked every run) and emitted under all 6 registered chains — one NAV, one product. No archival needed, ~20 s for everything |
| VAULT_LISASTER | reward APY (a weekly Merkle CLAIM, not an accrual) + staked size | **self-archive** — the API serves only the current value | `api.lista.org/api/lisaster/overview`; in `DECAYING`, the daily run IS the archive |

**Saturn specifically**: VAULT_LLAMA carries the vault's income leg (~13 %,
the STRC dividend vesting in) and VAULT_ONCHAIN its share price, which also
carries the STRC mark — 96.5 % of NAV is a preferred stock held outright, and
over the vault's life the two disagree by ~8.5 pp with a −22.8 % drawdown
between them. Both are kept because neither alone is the return
(lending-sdks `SATURN.md` §1).

## 2. The daily ratchet (loses data every day it does not run)

`pnpm capture:daily` → `--decaying --days 35` → **COMPOUND_V3, LLAMALEND,
VAULT_CAP, VAULT_GEARBOX** and, since 2026-09-09, **AAVE_V3, VAULT_SKY,
VAULT_SPARK, VAULT_FALCON, VAULT_TORI, VAULT_YO**, scheduled by
`.github/workflows/capture-history.yml` (03:10 UTC).
`data/history/.gitignore` commits exactly these four (fixed 2026-08-25 —
before that the two vault entries were captured in CI and discarded with the
runner).

- [x] Compound V3 + LlamaLend in the daily set
- [x] Cap + Gearbox added to `DECAYING` + gitignore exceptions
- [x] **AAVE_V3 added to the daily set (2026-09-09)** — its `TimeWindow` enum
      caps at LAST_YEAR, so the source has always been a 365-day ROLL. The
      module existed from the first build but was never in the ratchet, so the
      tail was being lost the whole time.
- [x] Sky, Spark, Falcon, Tori, YO added with their modules — 365d, 365d,
      365-point, 30-point and 30-day windows respectively
- [ ] Add the new decaying keys to `data/history/.gitignore`'s exception list
      if the CI runner is to commit them (they are small; today only the
      original four are committed)
- [ ] **Verify the next scheduled Action run actually commits
      `VAULT_CAP/` + `VAULT_GEARBOX/` rows**

## 3. Gaps — the checklist

### 3.1 No upstream history exists → needs OUR recorder (or on-chain reconstruction), loses data daily

- [ ] **Spectra** — no history API at all (their app doesn't chart from it).
      Record the `/api/v1/{network}/pools` snapshot (impliedApy/ptApy/tvl/
      ptPrice) daily, or reconstruct on-chain.
- [ ] **TermMax** — the `/v2/market/chart/apy` endpoint returns ONE current
      point. Record `/market/data` + `/vault/list` snapshots daily.
- [x] **Tori / YO / Falcon** — recorded daily since 2026-09-09 (`VAULT_TORI`,
      `VAULT_YO`, `VAULT_FALCON`). Tori and YO's yield route are 30-point
      windows, so the daily run IS the archive; nothing deeper exists.
- [ ] **Aave Earn vaults** — the GraphQL `Vault` type has NO history fields.
      Record `vaultApr` + `balance` per vault daily. (The reserve-level half of
      this row was never actually missing: `packages/fetchers/aave-v3/src/hist`
      has always read `supplyAPYHistory`/`borrowAPYHistory`, and AAVE_V3 is in
      the daily set as of 2026-09-09 so the 365-day window stops decaying.)
- [x] **Hyperbeat share price** — `VAULT_ONCHAIN` reads each vault's Pricer
      `getRate()` at a block (2026-09-11); HyperEVM's public endpoints served
      the probe, so it is a backfill, not only a forward record.
- [ ] **Fluid DEX trading-yield RATE** — the `historical-stats` route carries
      fees/shares, not the rate; record the spot `/v2/{chain}/vaults` field
      forward (or derive from fees/shares).
- [ ] **Silo hourly** — API keeps hourly only for the trailing ~24h, then
      daily forever; an hourly recorder must run live (daily is captured).
- [ ] **HyperCore fine-grained buckets** — day/week/month buckets roll
      (24h/7d/30d); only ~weekly allTime reaches inception. A recorder
      polling the `month` bucket daily would densify the series.
- [ ] **LlamaLend share price** — no accumulator in the API; the archival
      replay now EXISTS (`VAULT_ONCHAIN`, `kind: erc4626`) and only the
      LlamaLend vault roster has to be added to it — a generated row per
      vault, the same way the savings rows were.

### 3.2 Rolling / floored sources — backfill impossible, only forward capture

- [x] Cap (1y) and Gearbox (1y) → daily set
- [x] **Aave reserve APY history** (365d enum window) — the claim that it was
      "not captured at all" was wrong: the AAVE_V3 `hist/` module reads both
      `supplyAPYHistory` and `borrowAPYHistory`. What was true is that it sat
      outside the ratchet, so the rolling tail was being lost. Fixed
      2026-09-09 by adding AAVE_V3 to `DECAYING`.
- [ ] **Euler pre-2026-04-23** — unrecoverable from the API; archival-RPC
      reconstruction is the only route if ever needed. Post-floor is held.

### 3.3 Providers/sources with NO hist module yet

- [x] **Euler Earn vaults** (`VAULT_EULER_EARN`) — BUILT 2026-09-09. The
      `visibility=` trap is real and `visibility=all` is rejected outright;
      the module passes `visible,warning,hidden`. Depth is the 2026-04-23
      floor and is patchy per vault, so archival 4626 remains the canonical
      series — this is the cheap 80 %.
- [x] **Savings registry sources** — BUILT 2026-09-09: Re, sDOLA, Spark data
      hub, Sky/Maker, sfrxUSD, USDD, Wren and Strata as one-shot backfills;
      Falcon, Tori and YO in the daily set. Still open on this row: the
      accumulator (chi/ssr) reconstruction that reaches past Blockanalitica's
      365-day whitelist, USDD on BNB (no verified share-token address), and
      Strata's mm1usd + nopal CDOs (no pinned tranche tokens).
- [x] **DefiLlama `/chart/{poolUuid}`** — BUILT 2026-09-09 as `VAULT_LLAMA`,
      seeded with the five no-official-API assets whose UUID and vault address
      could both be pinned (sUSDe, USD3, sUSD3, wiTRY, apyUSD). Adding a pool
      is one line; the roster is deliberately UUID-keyed because a symbol join
      attaches Aegis's YUSD series to YieldFi's vault.
- [ ] **LST rows** — no history collection anywhere (yield-tracer records
      forward only); most are 4626/rate-getter archival-reconstructible —
      and `VAULT_ONCHAIN` is the module to do it in (add a `kind` per LST
      rate getter and generate the roster from the LST registry).
- [ ] Lender side without hist modules: **AAVE_V4, SPARK, DFORCE, SILO
      (lender), TELLER, TERMMAX (lender), …** — see the plan for which have
      a source worth building.

### 3.4 Ingestion (collection ≠ served)

- [ ] **Vault uids have NO ingest target**: `VAULT_*:<chain>:<addr>` rows
      deliberately do not join yield-tracer's lending `markets` (FK) — the
      SQL export skips them. A vault ingest (table + route keyed on the earn
      surface) is required before any of this history is served.
- [ ] **Replay the lender-side NDJSON into yield-tracer** (`A2/A3` are
      built: `POST /ingest/lending-history` + `scripts/ingest-history.ts`) —
      confirm what has actually been replayed into prod.
- [ ] **Off-box copy of the full backfill**: git is not the store and the
      ~290 MB vault NDJSON currently lives ONLY on this machine's disk.
      Push to object storage (plan §0.8) or re-run after loss (all durable
      sources are re-backfillable — that is their defining property).
- [ ] yield-tracer journal gap: `0106_earn_unified.sql` is not in
      `meta/_journal.json` → never ran anywhere (plan §0.12) — verify prod.

### 3.5 Refresh cadence for durable sources (nice-to-have)

- [ ] Inception-backfillable sources (Morpho, Pendle, Fluid, Yearn, Upshift,
      Lagoon, Silo daily, GMX, Yield Basis, Hyperbeat, HyperCore) need only
      an occasional catch-up run (`--days 40`, idempotent). Decide cadence:
      weekly cron here vs on-demand before ingest.

## 4. Known data quirks (so nobody re-diagnoses them)

- **Gearbox collector lags days** and one live pool's series just stops
  (Re7tBTC, 2026-05-10) — a missing tail is upstream, not us. Untracked
  pools answer `data: []` (skipped, counted).
- **Strata junior tranches carry astronomical APYs** — jrUSDat hits 5.4e11 %
  on 2026-07-05. Upstream truth, not a unit slip: a first-loss tranche whose
  share price moves 0.26 → 0.42 in a week annualizes to that. Passed through;
  the ingest nulls anything over `numeric(18,8)` and counts it. Use the share
  price for realized return.
- **Yield Basis has NO TVL series** — `withdrawableRaw` is per-share (the
  matrix's original derivation was wrong); negative trading APYs are
  legitimate.
- **GMX is APR-only** (no pps/TVL series exists publicly); **HyperCore is
  TVL-only** (pps not derivable — flows conflate with performance).
- **Upshift's history host is address-only** (no chain) — the module skips
  cross-chain address collisions loudly (zero today).
- **Unit zoo is normalized at the fetch boundary** (percent everywhere in
  NDJSON): Fluid 1e2, GMX 1e30 fractions, Kong/Morpho/Cap/Upshift fractions,
  Silo/Hyperbeat/Gearbox percent, Yield Basis 1e18 signed fractions
  (`supplyIndex` kept RAW as `wad` for Yield Basis, `assets_per_share`
  elsewhere).
- **Compound V3**: one unmapped Base comet (`0x2c776041…`) dropped until the
  registry carries it.
