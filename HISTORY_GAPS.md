# Historical data — gaps, checklist, full picture

Status date: **2026-08-25**. This is the operational checklist for the
history axis (both the lender side and the vault-provider side). The design
docs stay where they are — [LENDING_HISTORY_BACKFILL_PLAN.md](LENDING_HISTORY_BACKFILL_PLAN.md)
for the lender side, margin-fetcher's `src/vaults/HISTORY_APIS.md` for the
curl-verified vault-provider source matrix, and its
`src/vaults/savings/APR_BACKFILL.md` for the savings registry. This file
answers only: **what do we hold, what decays, what is missing, and who has
to do what next.**

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

## 2. The daily ratchet (loses data every day it does not run)

`pnpm capture:daily` → `--decaying --days 35` → **COMPOUND_V3, LLAMALEND,
VAULT_CAP, VAULT_GEARBOX**, scheduled by
`.github/workflows/capture-history.yml` (03:10 UTC).
`data/history/.gitignore` commits exactly these four (fixed 2026-08-25 —
before that the two vault entries were captured in CI and discarded with the
runner).

- [x] Compound V3 + LlamaLend in the daily set
- [x] Cap + Gearbox added to `DECAYING` + gitignore exceptions
- [ ] **Verify the next scheduled Action run actually commits
      `VAULT_CAP/` + `VAULT_GEARBOX/` rows**

## 3. Gaps — the checklist

### 3.1 No upstream history exists → needs OUR recorder (or on-chain reconstruction), loses data daily

- [ ] **Spectra** — no history API at all (their app doesn't chart from it).
      Record the `/api/v1/{network}/pools` snapshot (impliedApy/ptApy/tvl/
      ptPrice) daily, or reconstruct on-chain.
- [ ] **TermMax** — the `/v2/market/chart/apy` endpoint returns ONE current
      point. Record `/market/data` + `/vault/list` snapshots daily.
- [ ] **Aave Earn vaults** — the GraphQL `Vault` type has NO history fields
      (reserve APY history exists but is 365d-rolling, enum-windowed). Record
      `vaultApr` + `balance` per vault daily.
- [ ] **Hyperbeat share price** — API is APY-only; pps must be recorded
      forward from each vault's Pricer `getRate()`.
- [ ] **Fluid DEX trading-yield RATE** — the `historical-stats` route carries
      fees/shares, not the rate; record the spot `/v2/{chain}/vaults` field
      forward (or derive from fees/shares).
- [ ] **Silo hourly** — API keeps hourly only for the trailing ~24h, then
      daily forever; an hourly recorder must run live (daily is captured).
- [ ] **HyperCore fine-grained buckets** — day/week/month buckets roll
      (24h/7d/30d); only ~weekly allTime reaches inception. A recorder
      polling the `month` bucket daily would densify the series.
- [ ] **LlamaLend share price** — no accumulator in the API; archival
      `convertToAssets` replay (plan §0.9 A6) still open.

### 3.2 Rolling / floored sources — backfill impossible, only forward capture

- [x] Cap (1y) and Gearbox (1y) → daily set
- [ ] **Aave reserve APY history** (365d enum window) — not captured at all
      today; either add an AAVE_V3 hist extension reading
      `supplyAPYHistory`/`borrowAPYHistory` into the daily set, or accept
      the loss (the archival-RPC path can reconstruct indices anyway).
- [ ] **Euler pre-2026-04-23** — unrecoverable from the API; archival-RPC
      reconstruction is the only route if ever needed. Post-floor is held.

### 3.3 Providers/sources with NO hist module yet

- [ ] **Euler Earn vaults** (`VAULT_EULER_EARN`) — the Data API serves
      `/earn/vaults/{chain}/{addr}/totals` (pps + apy fields) from its
      2026-04-23 floor; roster needs the `visibility=` param (all Earn
      vaults are `hidden`/`pending_review` — the empty-default trap).
      Small module, floored depth.
- [ ] **Savings registry sources** — the whole `APR_BACKFILL.md` matrix has
      no collection modules here: one-shot backfills for Re (`/price`, full
      NAV), sDOLA (`/history`, since 2024-02), Spark data hub (7 vaults, one
      call), Sky/Maker Blockanalitica (≤365d) + accumulator beyond, sfrxUSD,
      USDD, Falcon (365d rolling!), plus the rolling savings sources (Tori
      30pt, YO 30pt) that belong in the daily set.
- [ ] **DefiLlama `/chart/{poolUuid}`** — the universal daily fallback
      (savings + anything with a pool UUID) has no generic fetcher module.
- [ ] **LST rows** — no history collection anywhere (yield-tracer records
      forward only); most are 4626/rate-getter archival-reconstructible.
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
