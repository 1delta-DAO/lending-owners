# Lending history backfill & share-price indexing

Analysis + plan for reconstructing historical lending data (rates, totals) and
introducing **share-price / index** history so realized return can be measured
against quoted rates.

Status: **analysis complete, nothing built.** All source claims below were
probed live on 2026-07-27 — numbers are measured, not estimated, except where
explicitly marked. **Re-probed end-to-end on 2026-08-11 — see §0 for the deltas,
four corrections and the run plan; where §0 and the body disagree, §0 wins.**

**This document moved here from the `lending-sdks` repo on 2026-08-11**, because
§0.8 puts the collection half of the work in THIS repo. Paths are written from
this repo's root; the two sibling checkouts it refers to are `../lending-sdks`
(margin-fetcher, the lender/chain registries, `worker-api/wrangler.toml`) and
`../yield-tracer` (the ingest routes, migrations and `computeMarketUid`).

---

## 0. Re-run — 2026-08-11

Every source below was re-probed live. Nothing from the plan has been built:
`lending-owners` still has one `hist/` directory (`compound-v3`), its
`fetchCompoundV3HistoricalApy` is **still called from nowhere**, `yield-tracer`
migrations have advanced to `0106` with no `market_index_snapshots` (`0088` went
to `expired_pt_intrinsic_zero`), and there is still **no read route** for
lending history — whatever the hourly cron writes is write-only today.

### 0.1 What it cost to wait 15 days

Compound V3's window is **confirmed still a hard 30-day roll**: 840 points = 28
markets × 30 days, now `2026-07-13 → 2026-08-11`. The window the 2026-07-27 pass
measured (`2026-06-28 → 2026-07-27`) is **gone**; **15 days × 28 markets are
permanently unrecoverable from the first-party API** (DefiLlama still holds
supply-side for ~106 of those comets, borrow-side is lost). This is the only
part of the plan that gets strictly worse every day it is not started.

### 0.2 The universe grew — and the new families are the worst-covered

**14,893 markets / 47 chains / 5,290 (chain, lender) pairs** (was 14,079 / 47 /
1,826). New since the last pass, none of which appear in §3's table:

```
TERMMAX  190    RESUPPLY  44    INVERSE     32
LLAMALEND 84    CURVANCE  52    FRANKENCOIN 22
```

Of those, only Curvance (45), Resupply (22), LlamaLend (26) and Inverse (13)
have any DefiLlama presence; TermMax and Frankencoin have none.

### 0.3 Four corrections to §3

1. **Euler is NOT decaying — the "95-day hard cap" was a misread.** The floor is
   `max(vault createdAt, 2026-04-23)` and it **accumulates**. Measured: a vault
   created 2025-08-16 serves 111 daily points back to 2026-04-24; created
   2026-07-01 → floor 2026-07-01; created 2026-07-13 → floor 2026-07-13. The
   2026-07-27 measurement of "95 days" is exactly `2026-07-27 − 2026-04-23`,
   i.e. the same fixed genesis. What is capped is the **request**, not the data:
   `732` buckets at `1d` (2 years) and `744` at `1h` (31 days), enforced with an
   explicit `maxBuckets` error. **Euler moves off the Phase-0 urgency list.**
   Pre-2026-04-23 Euler history is permanently lost to their indexer — only
   DefiLlama (140 pools) or archival replay recovers it.
2. **`api.morpho.org` is the wrong host and `uniqueKey` is the wrong field.**
   The endpoint we already use everywhere is `blue-api.morpho.org/graphql`;
   `marketByUniqueKey` does not exist there and `Market.uniqueKey` is spelled
   **`marketId`**. Otherwise the tier-A claim holds and is stronger than
   recorded: `MarketHistory` exposes 39 series including
   `supplyAssets`/`supplyShares`/`borrowAssets`/`borrowShares` (→ exact share
   price both sides), `utilization`, `rateAtTarget` and pre-aggregated
   daily/weekly/monthly/quarterly/yearly/all-time APYs. Measured depth: **712
   daily points, to market creation**, free and keyless. **Series come back
   newest-first — sort before differencing.**
3. **Morpho API coverage is 94.6 %, not 100 %.** The API indexes 7,456 markets;
   our book holds **3,459 distinct Morpho market ids** (each is 2 rows in the
   14,893 count), of which **3,271 are covered**. The 188 misses are entirely
   small-chain (Sei 29, Lisk 25, Abstract 17, Celo 15, Plume 14, Scroll 13, Hemi
   11, Soneium 10, Flare 9, Sonic 9) — Blue instances their API doesn't index.
   Those fall to tier C like any fork.
4. **DefiLlama coverage fell to 26.7 %** (3,978 / 14,893; was 29.2 %) — not
   because llama shrank (15,612 pools, 2,427 lendBorrow rows, 2,004 joinable)
   but because everything we onboarded since has no adapter. The free/paid
   matrix is **unchanged**: `/pools`, `/lendBorrow`, `/chart/{pool}` free;
   `/poolsBorrow` and `/chartLendBorrow/{pool}` still HTTP 402. Families at
   **zero** llama coverage now total **2,439 markets**.

### 0.4 Three free first-party sources the last pass missed

| Family              | Mkts | Source                                                               | Depth measured                                             | Carries                                                                             |
| ------------------- | ---: | -------------------------------------------------------------------- | ---------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **Venus**           |  111 | `api.venus.io/markets/history?asset=<vToken>&period=year&limit=1000` | **365 daily pts**, `period` ∈ year/halfyear/month          | `supplyApy`, `borrowApy`, `totalSupplyCents`, `totalBorrowCents`, **`blockNumber`** |
| **Moonwell**        |   47 | `ponder.moonwell.fi` GraphQL `marketDailySnapshots`                  | back to **2025-08-21** (~356 d), keyless, all chains       | totals + USD + `baseSupplyApy`/`baseBorrowApy` (no `exchangeRate`)                  |
| **Curve LlamaLend** |   84 | `prices.curve.finance/v1/lending/markets/{chain}/{ctrl}/snapshots`   | **hard 100-point cap** (~100 d rolling) — a decaying asset | rates, `total_debt`, `total_assets`, `n_loans`, bands, oracle price, `max_ltv`      |

Venus is the best-shaped of the three: it hands back the **block number** with
each point, which makes the archival `exchangeRateStored` read for the index
column a pinned single call instead of a search.

Unchanged: **Aave V3** still 365 daily points, `LAST_YEAR` still the max window
(enum: DAY/WEEK/MONTH/SIX_MONTHS/YEAR), and `avgRate` now needs a `{ value }`
subselection. **Aave V4**'s `api.v4.aave.com/graphql` is live but introspection
is disabled — still unprobed, still 82 markets, still low priority. **Fluid**,
**Silo** (`api-v3.silo.finance` serves only the GraphQL surface we already use)
and **Gearbox** still have no public history endpoint → tier C.

### 0.5 Open question 3 answered — the archival audit, run

`coins.llama.fi/block/{chain}/{timestamp}` is **free, keyless and exact to the
second**, and answered for 16 of 17 chains probed (only Plume missing). **This
deletes "the one genuinely new piece of infrastructure" from §7** — no binary
search, no per-chain block index to build; just cache its answers.

With it, every configured RPC in `worker-api/wrangler.toml` was probed with
`eth_getBalance` at the block 365 days ago:

| Reachability                    |   Mkts |      % | Detail                                                                                                          |
| ------------------------------- | -----: | -----: | --------------------------------------------------------------------------------------------------------------- |
| **Archival ≥ 365 d, confirmed** | 10,477 | 70.3 % | chains 1, 8453, 42161, 999, 43114, 130, 10, 59144, 534352, 50, 25                                               |
| **Pruned — confirmed unusable** |  1,305 |  8.8 % | **137 Polygon (856)** and **143 Monad (449)**, both dwellir `-full`; Monad answers only ≈7 d                    |
| **Gateway-only, still unknown** |  1,555 | 10.4 % | 13 chains whose only entry is `rpc-gateway.1delta.io/<id>` — must be probed from inside the worker              |
| **No RPC configured at all**    |  1,556 | 10.4 % | incl. **BSC = 1,040 markets**; `RPC_56` is commented out and `api-bsc-mainnet.n.dwellir.com` no longer resolves |

So tier C is viable for ~70 % of the book **today**, and the two concrete
blockers are named: a BSC archival endpoint (1,040 markets, the single largest
gap) and Polygon/Monad archival (1,305).

### 0.6 The worked example, refreshed

Same market, fresh blocks — the thesis is stable, and the whole stack (llama
block index → archival `getReserveNormalizedIncome` → Aave API) ran end to end
in about three seconds:

```
Aave V3 Ethereum USDC, block 23,117,599 → 25,731,545 (365.0 days)
liquidityIndex  1.139690312 → 1.181587098
realized (annualized, from index)                 3.6762 %
quoted  (365 daily avgRate, compounded, same win) 3.7526 %
gap                                              −0.0764 pp   (−2.0 % relative)
```

### 0.7 What to actually run, and what each run buys

Coverage is cumulative over our 14,893 rows. Every source in runs 1–3 is free
and keyless — no API key, no archival node, no schema migration is needed to
_collect_; land NDJSON in object storage and ingest later.

| #   | Run                                                                                                                                                           |  Adds |   Cum. | Cost                                                                                                                                            |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----: | -----: | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| 0   | **Daily capture of the two decaying sources** — Compound V3 `historical/summary` (28 comets, 1 request) + Curve `snapshots?agg=day` (84 markets, 84 requests) |     — |      — | ~1 h. A GH Action in `lending-owners`. **Every day this slips loses data that cannot be bought back.**                                          |
| 1   | **Morpho** `blue-api` `historicalState`, batched ~10 markets/query                                                                                            | 6,536 | 43.9 % | ~350 requests for full depth to creation. Rates + totals **+ exact share price both sides**.                                                    |
| 2   | **Euler** `/evk/vaults/{c}/{a}/apy` + `/totals`, `resolution=1d`, ≤732 buckets                                                                                | 2,485 | 60.5 % | ~5,000 requests. Rates + totals; **no shares field → index still needs archival**.                                                              |
| 3   | **Aave V3 + Compound V3 + Venus + Moonwell + Curve** (5 free APIs)                                                                                            |   738 | 65.5 % | ~600 requests. Rates + totals only; Aave/Venus give a block number for the index leg.                                                           |
| 4   | **Dolomite + Silo subgraphs** (keys already in `lending-owners` secrets)                                                                                      |   740 | 70.5 % | 1–2 wks. **Still blocked on the unverified claim** that `marketDailySnapshots.exchangeRate` exists — one query with an existing key settles it. |
| 5   | **Archival block-grid replay** for the tail + **every index column**                                                                                          | 4,390 |  100 % | Bounded by §0.5: ~70 % of the book reachable now; needs a BSC endpoint (+1,040) and Polygon/Monad archival (+1,305) to go further.              |

Runs 1–3 are ~6,000 free HTTP requests total and take **65 % of the book from
zero history to a year or more of daily rates and totals**. They do not require
Phase 1's schema — but they also do not deliver the _primary_ product for
anything but Morpho, because only Morpho publishes shares. **The
realized-vs-quoted gap for the other 60 % of covered markets comes only from
run 5.** Sequence accordingly: run 0 today, then 1, then 5 restricted to the 11
confirmed-archival chains, then 2–4.

Still open after this pass: Aave V4's API (82 markets), the Messari
`exchangeRate` question (blocking run 4), the 13 gateway-only chains, and a BSC
archival endpoint.

### 0.8 Where the code goes — decided

**No new repo.** Both halves already exist and are in production; the backfill
is a second axis on each, not a new system.

- **Collection → `lending-owners`.** It is already the batch-job repo:
  per-lender fetcher packages, a runner CLI, subgraph keys in GH Actions
  secrets, one cron workflow per lender, and
  `fetchLenderMetaFromDirAndInitialize` wired once at startup.
  `packages/fetchers/compound-v3/src/hist/index.ts` is the stub of exactly this
  axis.
- **Ingestion → `yield-tracer`.** `POST /ingest/*` behind `ingestAuth` (Bearer
  `INGEST_TOKEN`), a 32 MB body limit, drizzle migrations, and `app-fetcher/` —
  a separate deployable that already does _fetch elsewhere, POST to an authed
  route_, with size-chunking, retries and redirect handling solved in
  `app-fetcher/src/ingest/client.ts`.

**Why not a separate repo.** It would have to duplicate four things it cannot
own: `margin-fetcher`'s per-family multicall builders (tier C needs them),
`initializer-sdk`'s metadata init, the subgraph API keys, and
`computeMarketUid`. The last is the live hazard — two implementations across
three repos already — and a fourth copy makes the most likely silent failure
more likely, not less.

**Why not a script in `yield-tracer`.** Collection is a multi-hour, resumable,
rate-limited, key-holding job. In the app repo it either runs on the app box
competing with the live hourly cron for CPU and the same Postgres, or it becomes
a script nobody runs reproducibly. §7's rule stands: **never write to prod
Postgres from a backfill job.**

```
lending-owners/
  packages/fetchers/<lender>/src/hist/index.ts   # the new axis (compound-v3 exists)
  packages/history-runner/                       # CLI --lender --from --to --resolution --out
  .github/workflows/capture-history.yml          # daily, decaying sources only

yield-tracer/
  app/migrations/0107_market_index_snapshots.sql
  app/src/routes/ingest/lendingHistory.ts        # POST /ingest/lending-history
  app/scripts/ingest-history.ts                  # streams NDJSON (file|url) → that route
  app/src/routes/lendingHistory.ts               # GET /lending/history — the read side
```

Transport between them is **NDJSON in object storage**, one line per
`(market_uid, data_ts)`, two record kinds (`spot`, `index`), every line carrying
`source`; key layout
`lending-history/v1/<lender>/<chain>/<yyyy-mm>/<run>.ndjson` with a per-shard
manifest so a re-run skips completed shards. **Git is not the store for the time
series** — `data/<LENDER>.json` is right for current-state ownership, but a
daily grid is 5.1 M rows/year. The one exception is A0 below: 28 comets × 1
request/day is ~1 MB/month and a data branch buys the decaying window today
without waiting on a bucket.

### 0.9 Action plan

Blocking edges only where stated; everything else parallelises.

| #      | Task                                                                                                                                                                                                                                     | Repo            | Effort | Done when                                                                                                       |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- | ------ | --------------------------------------------------------------------------------------------------------------- |
| **A0** | **Stop the bleeding.** `capture-history.yml` daily: Compound V3 `historical/summary` (1 request, 28 comets × 30 d) + Curve `snapshots?agg=day` (84 requests, 100-pt cap). Append NDJSON to a data branch.                                | lending-owners  | ~1 h   | Two consecutive days land and diff cleanly. **Do this first — it is the only task that gets worse by waiting.** |
| **A1** | **Lift `computeMarketUid` into `data-sdk`**; delete `lending-owners`' `makeMarketUid`; import it in all three repos.                                                                                                                     | data-sdk → both | ~½ d   | The three repos produce byte-identical uids for a Venus/Moonwell/Aave-V4/Dolomite fixture. **Blocks A4–A7.**    |
| **A2** | **Schema.** `0107_market_index_snapshots` (§5) + `source varchar(32) DEFAULT 'live-cron'` on `lending_snapshots` + the partition/rollup decision (§6).                                                                                   | yield-tracer    | 1 d    | Migration applies; a hand-written index row upserts twice without duplicating. **Blocks A3.**                   |
| **A3** | **Ingest + read surface.** `POST /ingest/lending-history` registered inside the existing `ingestAuth` scope; `app/scripts/ingest-history.ts` streaming NDJSON; **`GET /lending/history`** — without it, nothing can consume any of this. | yield-tracer    | 1 d    | A0's captured NDJSON replays end-to-end and re-replays idempotently.                                            |
| **A4** | **Run 1 — Morpho.** `history-runner` + `fetchers/morpho-blue/src/hist`. Batch ~10 markets/query against `blue-api`. Rates + totals **+ share price both sides**.                                                                         | lending-owners  | 1 wk   | 3,271 market ids × full depth in the bucket; spot-check 5 realized-vs-quoted gaps.                              |
| **A5** | **Runs 2–3 — Euler + Aave V3 + Compound V3 + Venus + Moonwell + Curve.** Six `hist/` modules, one shared paginator.                                                                                                                      | lending-owners  | 1 wk   | 65.5 % of rows carry ≥ 90 d of daily history.                                                                   |
| **A6** | **Run 5 — archival replay.** `coins.llama.fi/block` cached to a `(chain_id, date) → block` table; replay `margin-fetcher`'s per-family builders at pinned blocks. **Start with the 11 confirmed-archival chains (70.3 %).**              | lending-owners  | 2–4 wk | Every reachable market has an `index` series; Aave USDC reproduces §0.6 from our own rows.                      |
| **A7** | **Run 4 — Dolomite + Silo subgraphs.** Gated on one query proving `marketDailySnapshots.exchangeRate` exists.                                                                                                                            | lending-owners  | 1–2 wk | 740 more markets, or the gate fails and they drop to A6.                                                        |

**Unblockers to buy in parallel** (none need code): a BSC archival endpoint —
**1,040 markets, the single largest gap**, `RPC_56` is commented out and
`api-bsc-mainnet.n.dwellir.com` no longer resolves; Polygon + Monad archival
(1,305); and a probe of the 13 gateway-only chains from inside the worker
(1,555).

### 0.10 Five things that will bite

1. **`lending_snapshots.market_uid` has an FK to `markets` with
   `ON DELETE CASCADE`** — unlike `market_owners_*`, which has none. Backfilled
   rows for a market the live cron has never seen are **rejected, not silently
   orphaned**. Either pre-seed `markets` from the backfill's own market list, or
   accept that history starts at first-sighting for anything delisted earlier.
   Decide in A2, not in A4.
2. **Morpho series come back newest-first.** Sort before differencing, or every
   realized return is signed backwards.
3. **Euler enforces `maxBuckets`** — 732 at `1d`, 744 at `1h` — with a
   `BAD_REQUEST`, not a truncation. Page by window, not by row count.
4. **`/ingest/lending` treats Postgres `40P01` as expected, not exceptional**
   and retries three times with jittered backoff. The history route must do the
   same, and a bulk replay makes deadlocks _more_ likely, not less.
5. **A degenerate market is not a broken fetcher.** The largest Morpho market by
   `supplyAssetsUsd` on Ethereum is a PAXG/USDC book pinned at 100 % utilization
   quoting ~297,900 % APY, whose share price has moved 45,000× since 2024. It is
   real data. Do not add a sanity filter that silently drops it — flag it.

### 0.11 Build log — 2026-08-12

**A0 is done and A4 is working.** What exists in this repo now:

```
packages/core/src/history.ts        HistoryPoint / HistoryFetcher contract
packages/core/src/http.ts           PacedClient — concurrency, pacing, 429/5xx backoff
packages/history-runner/            CLI + NdjsonSink (append-time dedup, manifest)
packages/fetchers/compound-v3/src/hist/   30-day rolling window  → 810 pts/run
packages/fetchers/llamalend/src/hist/     100-snapshot window    → 18,936 pts/run
packages/fetchers/morpho-blue/src/hist/   full depth + share price
.github/workflows/capture-history.yml     daily, 03:10 UTC, no secrets
data/history/.gitignore                   commits A0 only, ignores the rest
```

Measured on the first real runs:

| Run                              |     Points | Wall clock | Note                                    |
| -------------------------------- | ---------: | ---------- | --------------------------------------- |
| `COMPOUND_V3 --days 35`          |        810 | 0.8 s      | 27 of 28 comets resolve to a uid        |
| `LLAMALEND --days 100`           |     18,936 | 21 s       | 198 uids = 99 markets × 2 sides         |
| `MORPHO_BLUE --chain 1 --days 30` |    102,508 | 100 s      | 1,714 markets, 1,336 with a share price |

Re-running any of them writes **0 rows and reports every point as a duplicate** —
the idempotency the daily job depends on, verified rather than assumed.

**Sanity check of the actual product.** Over the 30-day Ethereum Morpho window,
1,145 markets have both a computable realized return (from `supplyAssets` /
`supplyShares`) and a quoted series: **median gap +0.0000 pp**, which is what a
correct pipeline should show over a short window, with the interesting mass in
the tails (one market at −95.4 % realized against +3.2 % quoted). 141 markets
were excluded as degenerate — see §0.10.5, they are real, not broken.

**Four things learned in the build, none of which were in the analysis:**

1. **Rates are PERCENT, not fractions.** `lending_snapshots.deposit_rate` holds
   `4.90` for 4.90 % (`yield-tracer/app/src/integst/lending/index.ts`), and the
   sources disagree with each other — Compound and Morpho return fractions,
   Curve returns percent. Every fetcher normalizes on the way out. This was a
   silent 100× error waiting to happen across the whole backfill.
2. **Morpho's complexity budget scales with `first × series`, not with the
   window.** Charged before execution, so asking for two years costs exactly
   what asking for 30 days costs: 20 markets × 9 series = 1,804,300 and 50 × 11
   = 5,519,250 both give ~10,035 per market-series against a 1,000,000 cap. So
   **a full-depth run is no more expensive than a shallow one** — page size is a
   constant ~6, and the first backfill should just ask for everything.
3. **Morpho appends a trailing "as of now" point** on top of the aligned daily
   grid, so the current bucket always arrives twice (31 points for a 30-day
   window). Collapsed to the aligned sample; left alone it would have collided
   on `(marketUid, dataTs)` and hidden real duplicates behind constant noise.
4. **`orderBy` must be immutable when paging.** `SupplyAssetsUsd` re-orders
   between requests as values move, which both duplicates and *skips* markets.
   `UniqueKey` is the only stable choice. **The ownership fetcher's
   `fetchAllPages` has the same latent bug** — it pages `SupplyAssetsUsd` too.

Compound V3 has one unmapped comet on Base
(`0x2c776041ccfe903071af44aa147368a9c8eea518`) whose rows are dropped until the
registry picks it up.

### 0.12 A2 + A3 — the ingest half, built and tested

In `../yield-tracer/app`:

```
migrations/0107_market_index_snapshots.sql   new table + `source` on lending_snapshots
migrations/meta/_journal.json                journaled (see the warning below)
src/db/schema/index.ts                       marketIndexSnapshots + source column
src/integst/lendingHistory/index.ts          the ingest logic
src/routes/ingest/lendingHistory.ts          POST /ingest/lending-history (authed)
src/routes/lendingHistory.ts                 GET  /lending/history  — the read side
scripts/ingest-history.ts                    NDJSON replay, direct-DB or over HTTP
test/ingest-lending-history.test.ts          9 unit tests, no container needed
```

**`0106_earn_unified.sql` is not in `meta/_journal.json`, so it has never run.**
Drizzle's migrator reads the journal and ignores un-listed files. Unrelated to
this work, but it means the earn-unified table and view do not exist on any
database that was migrated by the app. Worth checking prod.

#### The local test, reproducible

A throwaway Postgres on port **55432** so the compose stack — which mounts real
local data — is never touched:

```bash
docker run -d --name yt_hist_test -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=appdb -p 55432:5432 postgres:16-alpine
export DATABASE_URL=postgres://postgres:postgres@localhost:55432/appdb

cd ../yield-tracer/app
npx tsx -e 'import{drizzle}from"drizzle-orm/node-postgres";import{migrate}from"drizzle-orm/node-postgres/migrator";import pg from"pg";const p=new pg.Pool({connectionString:process.env.DATABASE_URL});await migrate(drizzle(p),{migrationsFolder:"./migrations"});await p.end()'

# markets rows must exist first — both tables have an FK (§0.10.1)
npx tsx scripts/ingest-history.ts --dir ../../lending-owners/data/history/MORPHO_BLUE
```

The container is currently **stopped, not removed** — `docker start yt_hist_test`
brings it back with the test data intact.

#### What the run proved

All 105 migrations applied clean, then a real replay of the Morpho Ethereum
NDJSON (30 days, 3,370 uids — 80 % seeded into `markets`, 20 % deliberately not):

```
done in 7.0s — spot=81802 index=32303 unknownMarkets=20582 invalid=0 filesFailed=0
```

- **The FK path behaves.** 20,582 rows for unseeded markets were dropped,
  counted and sampled in the response instead of aborting the batch — which is
  what would happen on a real backfill containing delisted or untracked markets.
- **Idempotent end to end.** Two full replays leave `lending_snapshots` at
  81,802 rows, not 163,604.
- **Provenance works.** `SELECT source, count(*)` → `morpho-api 81802`,
  `compound-api 12`; live-cron rows would be untouched and distinguishable.
- **Auth and validation.** No token → 401, malformed body → 400, and the same
  script replays over HTTP through the authed route.
- **The product, end to end.** `GET /lending/history` on a real Morpho USDC
  market, straight out of the database:

  ```
  realizedApy  5.6320 %      (from supplyAssets/supplyShares, exact)
  quotedApy    5.7133 %      (daily-compounded deposit_rate)
  gapPp       -0.0813 pp
  ```

  Independently close to the −0.0764 pp measured on Aave V3 USDC in §0.6 — two
  different protocols, two different sources, the same direction and magnitude.
  The 30-decimal share price survives as a string the whole way.

`npx vitest run` — 9 new tests pass. The suite has 7 pre-existing failures in
`test/pairs.test.ts` (error-message drift, unrelated), and `src/routes/earn.ts`
has one pre-existing typecheck error.

Still to do: **A1** (`computeMarketUid` into `data-sdk`) — now the last thing
between this and trusting these uids in prod; **§6's partitioning decision**,
which 0107 does not make: `market_index_snapshots` is a plain table, and the
plan's own advice is to decide partitioning before the bulk load, not after;
**A5** (Euler, Aave V3, Venus, Moonwell), **A6** (archival), **A7** (subgraphs).

### 0.13 Backdated depth per lender — probed 2026-08-12

Reframing: the cron secures history **forward** from today, so what matters for
the remaining families is **how far back a one-time run reaches**, not cadence.
That inverts part of the earlier ranking — a 30-day rolling window is now worth
almost nothing as a backfill (its content is already captured), while a source
with two years of depth is worth a single run and never touching again.

#### Newly found, all free and keyless

| Family     | Mkts | Source                                                      | Backdated depth                                          | Index?                                                                 |
| ---------- | ---: | ----------------------------------------------------------- | -------------------------------------------------------- | ---------------------------------------------------------------------- |
| **Silo**   |  570 | `api-v3.silo.finance` GraphQL `marketTimeseriess`           | **daily to 2025-05-09 (~460 d)** ✔ measured               | ✅ **both** — `collateralAssetsSupply`/`collateralSharesSupply` + `debtIndex` |
| **Fluid**  |  512 | `api.fluid.instadapp.io` `…/apr-history` (4 route families) | **hourly, ~31-day rolling** ✔ measured (741 pts)          | ❌ — but **every point carries `blocknumber`**                          |
| **Aave V4**|   82 | `api.v4.aave.com` `supplyApyHistory` / `assetSupplyHistory`  | exists, keyed by `ReserveId`, mirrors V3 — window unmeasured | ❌                                                                    |

**Silo is the find of this round**: 570 markets, ~15 months of daily history,
and it publishes shares *and* a debt index — the only source besides Morpho that
delivers both halves. It also carries `totalBadDebtAssets`, which is exactly
what explains a negative realized return. Note its API serves 550 markets across
chains 1/42161/43114/50/1776/56/5000 — **Sonic is absent**, so the Sonic Silos
fall to archival. Fluid's window is too short to be a backfill, but the block
numbers make its archival index reads pinned single calls rather than searches.

#### DefiLlama is the deepest backdated source for the Compound-fork tail

For a one-time backdated fill this reverses §3a's conclusion in one specific
way: llama holds **years** where first-party APIs hold months. Measured on the
largest pool per family:

```
COMPOUND_V2  1,644 d (2022-02)    VENUS      1,499 d (2022-07)
BENQI        1,464 d (2022-08)    TECTONIC   1,462 d (2022-08)
COMPOUND_V3  1,403 d (2022-10)    KINZA        895 d (2024-03)
AAVE_V3        851 d (2024-04)    MORPHO_BLUE  698 d (2024-09)
FLUID          584 d (2024-12)    MOONWELL     489 d (2025-04)
LISTA_DAO      450 d (2025-05)    LLAMALEND    337 d (2025-09)
```

Everything else about §3a still holds — 26.7 % coverage, no borrow-side history
without Pro, and no non-heuristic join for Morpho/Euler. Use it **only** for the
head of the Compound-fork families, where the identity is unambiguous
(chain + protocol + one underlying) and the depth is otherwise unreachable.

**One correction to §3a:** `pricePerShare` is no longer null on every lending
pool. Measured non-null and moving: Fraxlend 71/71, Gearbox 106/293, Resupply
95/342 (Dolomite's 106/346 are a flat `1`, i.e. useless). But every one of those
series **begins ~2026-04-29** — llama started populating the field recently, so
it is a forward asset, not backdated depth. It does not change the verdict.

#### Still no public history API

**Gearbox (305)**, **Lista/Moolah (480)**, **Teller (554)**, **Term Finance
(203)**, **TermMax (190)**, **Morpho Midnight (54)** — probed, nothing found.
Lista is a Morpho Blue fork but is not on `blue-api`; Teller/Term/TermMax are
fixed-term and have no utilization curve to serve in the first place. These are
archival-only, and for the fixed-term three the spot series is not even
meaningful.

#### One-time backfill, ranked by markets × depth

| Order | Run                              |  Mkts | Depth        | Gets the index? |
| ----- | -------------------------------- | ----: | ------------ | --------------- |
| 1     | Morpho (built)                   | 6,910 | to creation  | ✅ exact        |
| 2     | **Silo** ← best new              |   570 | ~460 d       | ✅ both sides   |
| 3     | Euler                            | 2,485 | to 2026-04-23 | ❌ → archival   |
| 4     | Aave V3                          |   307 | 365 d        | ❌ → archival   |
| 5     | Venus                            |   111 | 365 d        | ❌, has block № |
| 6     | Moonwell                         |    47 | ~356 d       | ❌              |
| 7     | Fluid                            |   512 | 31 d hourly  | ❌, has block № |
| 8     | llama, Compound forks only       |  ~600 | 2–4 y        | ❌              |
| 9     | Aave V4                          |    82 | unmeasured   | ❌              |

Compound V3 and LlamaLend are deliberately absent: their windows are already
captured and the cron holds them from here. Nothing above needs re-running once
done — which is the point.

---

## 1. The problem, stated precisely

`yield-tracer` writes `lending_snapshots` only from the live hourly cron
(`LENDING_BUCKET_MINUTES=60`). Every market's history therefore begins at the
moment we first fetched it. There is no path to data before that, and every new
lender/chain we onboard starts from zero again.

Two things are missing, and they are **not the same problem**:

|                                                                                                                                                     | What it is                                          | Reconstructible later?                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Spot state** — `deposit_rate`, `variable_borrow_rate`, totals, utilization                                                                        | A point sample of a continuously-varying quantity   | **No.** Not recoverable from any later state. Must be sampled at the time, or read from an indexer that sampled it.  |
| **Accumulators** — Aave `liquidityIndex`, cToken `exchangeRate`, ERC-4626 share price, Morpho `supplyAssets/supplyShares`, Dolomite `InterestIndex` | Monotone, path-independent cumulative growth factor | **Yes, exactly.** Two samples give the _exact_ realized return between them, regardless of what happened in between. |

This distinction drives everything:

- The accumulator series is what actually answers _"real gain vs. quoted rate"_
  — and it is both **cheaper to backfill** and **lossless at daily
  granularity**, because it's an integral, not a sample.
- The spot-rate series is decorative by comparison. Its main value is explaining
  _why_ realized differed from quoted.

**We currently store no accumulator at all**, anywhere. That's the bigger gap.

### Worked example (measured)

Aave V3 Ethereum USDC, block 23,292,824 → 25,625,694 (325.8 days):

```
liquidityIndex  1.143039500 → 1.179892620
realized (annualized, from index)                 3.6192 %
quoted  (365 daily avgRate, compounded, same win) 3.6986 %
gap                                              −0.0794 pp   (≈ −2.1 % relative)
```

Both numbers came from free sources in under a second. The gap is the product we
can't build today.

---

## 2. Scale

From `/meta/lending/complete` and `/lending/lenders` on `yields-r0.1delta.io`:

- **14,079 markets** across **47 chains**
- **1,761 distinct lender keys** / 1,826 (lender, chain) pairs

Concentration (markets per family):

```
MORPHO_BLUE    6672      AVALON        152      MOONWELL       47
EULER          2471      DOLOMITE      151      RIVER          40
SILO            566      TERM_FINANCE  120      LENDLE         39
TELLER          550      VENUS         111      SPARK          27
FLUID           510      SUMER         103      COMPOUND_V2    19
LISTA_DAO       468      AAVE_V4        78      … ~60 more families
AAVE_V3         306      AAVE_V2        57
GEARBOX         296      MORPHO_MIDNIGHT 54
COMPOUND_V3     189      EXACTLY        52
```

**Morpho + Euler alone are 65 % of all markets** — and both have first-party
history APIs. That is the single most important fact for sequencing.

Row-count consequences (one year):

| Grid            | Rows  |
| --------------- | ----- |
| daily × 14,079  | 5.1 M |
| hourly × 14,079 | 123 M |

`lending_snapshots` today is **hourly with no retention policy and no
partitioning**. It is already accruing ~123 M rows/year. A backfill at hourly
granularity doubles that in one shot. See §6.

---

## 3. Source availability — verified per family

Three tiers, in ascending cost:

- **A — first-party history API.** Free or keyed HTTP, no archival node, minutes
  to backfill.
- **B — subgraph.** Messari-standard or native; block-pinned queries possible.
- **C — archival RPC block-grid replay.** Universal, exact, works for _every_
  fork, but needs archival nodes and a block↔timestamp index.

| Family                                            |  Mkts | Tier  | Source                                                                        | Rates                      | Totals       | **Index / share price**                                  | Depth verified                                       |
| ------------------------------------------------- | ----: | ----- | ----------------------------------------------------------------------------- | -------------------------- | ------------ | -------------------------------------------------------- | ---------------------------------------------------- |
| **Morpho Blue** (+ Lista/Moolah forks)            | 7,140 | **A** | `api.morpho.org` GraphQL `historicalState`                                    | ✅ `supplyApy`/`borrowApy` | ✅           | ✅ **`supplyAssets`+`supplyShares` → exact share price** | **365 daily pts to market creation** ✔ measured      |
| **Euler**                                         | 2,471 | A     | `v3.euler.finance/v3/.../apy` + `/totals`                                     | ✅                         | ✅           | ⚠️ derive from `totalAssets`/shares                      | **hard 95-day cap** — asked 365 d, got 95 ✔ measured |
| **Silo**                                          |   566 | B     | `api-v3.silo.finance` has _positions only_; use Messari subgraph (key exists) | via subgraph               | via subgraph | via subgraph `exchangeRate`                              | schema not probed (needs key)                        |
| **Fluid**                                         |   510 | C     | no public history API found                                                   | —                          | —            | on-chain                                                 | —                                                    |
| **Teller**                                        |   550 | C     | fixed-term, per-bid; no curve                                                 | n/a                        | on-chain     | n/a                                                      | —                                                    |
| **Aave V3 canonical**                             |   306 | A + C | `api.v3.aave.com` `supplyAPYHistory`/`borrowAPYHistory`                       | ✅ daily avg               | ❌           | ❌ → **C**                                               | **365 daily pts, LAST_YEAR max** ✔ measured          |
| **Aave V2/V3 forks** (~100 keys)                  |  ~700 | C     | none — forks aren't on Aave's API                                             | —                          | —            | `getReserveData().liquidityIndex`                        | ✔ archival call verified                             |
| **Gearbox**                                       |   296 | C     | —                                                                             | —                          | —            | on-chain                                                 | —                                                    |
| **Compound V3**                                   |   189 | A     | `v3-api.compound.finance/.../historical/summary`                              | ✅                         | ✅           | ❌ → C                                                   | **30-day rolling window only** ✔ measured            |
| **Dolomite**                                      |   151 | **B** | Dolomite subgraph (public, key in URL)                                        | `InterestRate`             | ✅           | ✅ **`InterestIndexSnapshot`**                           | entity confirmed ✔                                   |
| **Venus / Moonwell / dForce / Compound V2 forks** |  ~350 | B + C | Messari subgraphs (keys exist in `lending-owners`)                            | ✅                         | ✅           | ✅ `exchangeRate`                                        | schema not probed (needs key)                        |
| **Aave V4**                                       |    78 | A?    | `api.v4.aave.com` GraphQL                                                     | unprobed                   | unprobed     | unprobed                                                 | —                                                    |
| **Term / Midnight / Exactly / Liquity / River**   |  ~290 | C     | fixed-term or CDP — no utilization curve                                      | n/a                        | on-chain     | n/a for fixed-term                                       | —                                                    |

### 3a. DefiLlama — evaluated in detail

Worth a full assessment, since it is the only candidate for a single universal
source. **Verdict: a useful supplement for long-depth supply-side rates on the
head of the distribution; it cannot be the backbone, and it cannot deliver the
share-price half of this project at all.**

#### What is actually free

| Endpoint                             | Status       | Content                                                          |
| ------------------------------------ | ------------ | ---------------------------------------------------------------- |
| `yields.llama.fi/pools`              | free         | 16,085 pools, supply-side **current**                            |
| `yields.llama.fi/chart/{pool}`       | free         | supply-side **history**: `tvlUsd`, `apy`, `apyBase`, `apyReward` |
| `yields.llama.fi/lendBorrow`         | **free**     | 2,452 lending pools, borrow-side **current** — rates, LTV, caps  |
| `yields.llama.fi/poolsBorrow`        | **HTTP 402** | paid                                                             |
| `yields.llama.fi/chartLendBorrow/{}` | **HTTP 402** | paid — this is the borrow-rate **history**                       |

`/lendBorrow` being free is worth knowing independently of backfill: it gives
current `apyBaseBorrow`, `totalSupplyUsd`, `totalBorrowUsd`, `debtCeilingUsd`,
`ltv` for 2,452 pools at no cost. Useful for cross-checking the live cron.

#### Blocker 1 — no share price, at all

`pricePerShare` exists in the `/chart` schema but is **null on every point of
every lending pool tested**, across eight protocols:

```
project            chain     symbol    pts   first        pricePerShare non-null
aave-v3            Ethereum  WEETH      836  2024-04-14   0 / 836
morpho-blue        Base      CBBTC      683  2024-09-13   0 / 683
euler-v2           Ethereum  PYUSD      265  2025-11-06   0 / 265
compound-v3        Ethereum  WBTC      1388  2022-10-06   0 / 1388
fluid-lending      Ethereum  WSTETH     569  2024-12-30   0 / 569
venus-core-pool    BSC       BTCB      1484  2022-07-06   0 / 1484
moonwell-lending   Base      MORPHO     452  2025-04-09   0 / 452
silo-v2            Sonic     USDC       499  2025-01-29   0 / 499
```

The field is populated for LP/vault pools, not lending pools. Since the
accumulator series is the thing that actually answers _"real gain vs quoted
rate"_ (§1), **DefiLlama contributes nothing to the primary goal.**

#### Blocker 2 — 29 % coverage, with whole families at zero

Joining llama's lending universe to ours on (chain + protocol + underlying
asset):

```
markets matched: 4,108 / 14,083 = 29.2 %

family           ourMkts  matched     %   llamaPools
MORPHO_BLUE         6676     2113    32%     362
EULER               2471      939    38%     141
SILO                 566      116    20%      24
TELLER               550        0     0%       0
FLUID                510      243    48%     113
LISTA_DAO            468        0     0%       0
AAVE_V3              306      204    67%     200
GEARBOX              296       95    32%      11
COMPOUND_V3          189      135    71%     106
DOLOMITE             151       46    30%      61
VENUS                111       42    38%      43
MOONWELL              47       36    77%      36
```

Families with **zero** llama lending pools: Teller, Lista, Avalon, Term Finance,
Sumer, Aave V4, Aave V2, Cream, Granary, Midnight, Radiant V2, River, Lendle,
LayerBank V3, xLend, WePiggy, YLDR, Ebisu, Enclabs, Segment, Yei, Phiat — about
**2,000 markets** with no llama presence whatsoever.

The gap is structural: llama's lending set has a median pool TVL of ~$337 k and
64 % of its pools are under $1 M, so it is not simply a size cutoff — it is
protocol-by-protocol adapter coverage, and our long tail is exactly what nobody
writes adapters for.

#### Blocker 3 — no stable join key

Llama's `morpho-blue` pools _are_ per-market (`symbol` = collateral,
`mintedCoin` = loan asset, `ltv` = LLTV), which is better than it first looks.
But they carry **no `marketId`, no oracle, no IRM address**, and `poolMeta` is
empty on all 368. The identity is therefore (chain, collateral address, loan
symbol, LLTV) — which is **ambiguous in practice**. On Ethereum wstETH alone:

```
symbol=WSTETH  mintedCoin=USDC  ltv=0.86  tvl=$55,082,072  apyBaseBorrow=4.646
symbol=WSTETH  mintedCoin=USDC  ltv=0.86  tvl=$ 1,555,651  apyBaseBorrow=4.182
symbol=WSTETH  mintedCoin=USDC  ltv=0.86  tvl=$15,235,934  apyBaseBorrow=4.636
```

Three distinct Morpho markets, identical on every field llama exposes. There is
no non-heuristic way to attribute a llama series to one of our `market_uid`s,
and any mapping we hand-build breaks silently whenever llama re-keys a pool (the
`pool` UUID is not derived from on-chain identity).

#### Where DefiLlama genuinely wins: depth

This is the one thing it does that nothing else does — **history far longer than
any first-party API**:

| Market               | llama depth             | first-party depth   |
| -------------------- | ----------------------- | ------------------- |
| Compound V3 WBTC/ETH | **1,388 d, to 2022-10** | **30 d** (rolling)  |
| Venus BTCB/BSC       | **1,484 d, to 2022-07** | —                   |
| Aave V3 weETH/ETH    | 836 d, to 2024-04       | 365 d (`LAST_YEAR`) |
| Euler PYUSD/ETH      | 265 d, to 2025-11       | **95 d** (hard cap) |

For Compound V3 and Euler — the two decaying sources in §3 — llama holds years
of history that their own APIs have already dropped.

#### Recommendation

Use llama as a **narrow, targeted supplement**, not a tier:

- **Do** use `/chart` to backfill supply-side rates + TVL for the head of the
  distribution where first-party retention is short — Compound V3 and Euler
  above all, where it recovers years we otherwise cannot get.
- **Do** map only the few hundred large, unambiguously-identifiable pools by
  hand (Aave V3 reserves, Compound V3 comets, Moonwell, Venus). Do not attempt a
  general Morpho/Euler mapping.
- **Do not** treat it as the backbone: 29 % coverage, no accumulator, no stable
  identity.
- **Paying for Pro is probably not worth it for this project.** It buys
  borrow-rate history on the _same_ ~29 % of markets and still yields no share
  price. The block-grid replay (§7) serves 100 % of markets and both halves of
  the problem; the engineering cost is bounded and one-time. Revisit only if the
  archival-depth audit comes back badly.

### Two findings that need action regardless of the plan

1. **Compound V3's history API is a 30-day rolling window.** Verified: 840
   points = 28 markets × exactly 30 days, `2026-06-28 → 2026-07-27`. Anything
   older is already gone.
   [`packages/fetchers/compound-v3/src/hist/index.ts`](packages/fetchers/compound-v3/src/hist/index.ts)
   already fetches it but nothing persists the result. **This is a decaying asset —
   start capturing it before anything else in this plan.**
2. **Euler's API caps at ~95 days** at `1d` resolution. Also a decaying asset,
   with a longer fuse.

---

## 4. Identity — reuse `computeMarketUid`, do not re-derive it

The backfill must key rows exactly as
[`computeMarketUid`](../yield-tracer/app/src/integst/lending/index.ts) does, or
the rows will not join `markets`:

| Family             | Leaf               |
| ------------------ | ------------------ |
| Compound V2 family | `cToken`           |
| Init               | `poolId`           |
| Euler              | `vault`            |
| Aave V4            | `reserveId`        |
| Silo               | `silo`             |
| Dolomite           | integer `marketId` |
| everything else    | `underlying`       |

**`lending-owners` does not follow this.** Its `makeMarketUid` is
unconditionally `` `${lenderKey}:${chainId}:${underlying}` ``. Spot-checking the
call sites: Euler correctly passes the vault address, but **Venus, Moonwell and
Aave V4 pass `underlying`** — which does not match the cToken / reserveId leaf
`yield-tracer` expects.

`market_owners_latest` / `market_owners_snapshots` have **no FK to `markets`**
(migration `0049`), so those rows insert successfully and then silently fail to
join forever. Worth confirming against prod before treating it as a live bug,
but the UID discipline is the lesson: **the backfiller must import the real
`computeMarketUid`, not reimplement it.** Best fix is to lift it into a shared
package (`data-sdk` or a new `market-uid` module) that all three repos consume.

---

## 5. Proposed schema

Two changes. Keep `lending_snapshots` as-is for spot state; add a **separate**
table for accumulators, because they have different cadence, different
provenance and a much longer useful life.

```sql
-- 0088_market_index_snapshots.sql
CREATE TABLE IF NOT EXISTS "market_index_snapshots" (
  "market_uid"     varchar(256) NOT NULL REFERENCES "markets"("market_uid") ON DELETE CASCADE,
  "data_ts"        timestamptz  NOT NULL,
  "block_number"   bigint,                 -- NULL for API-sourced rows
  -- canonical, protocol-native accumulators, stored raw + a normalized view
  "supply_index"   numeric(60,30),         -- liquidityIndex / exchangeRate / assets-per-share
  "borrow_index"   numeric(60,30),         -- variableBorrowIndex / borrowIndex
  "index_kind"     varchar(32)  NOT NULL,  -- 'ray' | 'wad' | 'assets_per_share' | 'exchange_rate'
  "source"         varchar(32)  NOT NULL,  -- 'morpho-api' | 'euler-api' | 'subgraph' | 'archival-rpc' | 'live-cron'
  PRIMARY KEY ("market_uid","data_ts")
);
CREATE INDEX ON "market_index_snapshots" ("market_uid","data_ts" DESC);
```

Then realized return over any window is a single self-join — no rate
integration, no compounding assumptions:

```sql
SELECT market_uid,
       (last_ix / first_ix) ^ (365.0 / days) - 1 AS realized_apy
FROM   ...
```

Also add `source varchar(32)` to `lending_snapshots` (default `'live-cron'`) so
backfilled rows are distinguishable from live ones and can be re-derived or
dropped independently. Existing writes already `onConflictDoUpdate` on
`(market_uid, data_ts)`, so **backfill is idempotent for free** — a re-run
cannot double-count. That property must be preserved.

---

## 6. Retention — decide before, not after

`lending_snapshots` is hourly, unpartitioned, has **no pruning anywhere in the
codebase**, and 14,079 markets. Before adding 5–123 M backfilled rows:

- Partition `lending_snapshots` and `market_index_snapshots` by month
  (`PARTITION BY RANGE (data_ts)`), or adopt TimescaleDB hypertables.
- Roll up: keep hourly for ~90 days, daily beyond. A daily rollup is what almost
  every consumer of history actually reads.
- Backfill **daily-only**. Nobody needs hourly rates from 2025, and hourly would
  make the backfill 24× more expensive for near-zero analytic gain.

---

## 7. Where the backfiller lives

`lending-owners` is the right home: it already has per-lender fetcher packages,
subgraph plumbing with freshness checks, the API keys wired into GH Actions
secrets, and a runner CLI. Add a sibling axis rather than bending the ownership
fetchers:

```
packages/
  core/                     # + shared computeMarketUid, block-grid helper
  fetchers/<lender>/src/
    index.ts                # ownership (existing)
    hist/index.ts           # historical rates/totals/index  ← the new axis
  history-runner/           # CLI: --lender X --from ISO --to ISO --resolution 1d
```

Output contract: NDJSON per (lender, chain), one line per
`(market_uid, data_ts)`, shaped as the `/ingest/*` payload. Land it in object
storage or a staging table first — **do not write directly to prod Postgres from
a backfill job.** Then replay through a new `POST /ingest/lending-history` on
the yield-tracer app, reusing the existing idempotent upsert path.

### The one genuinely new piece of infrastructure

**A block↔timestamp index per chain.** No such helper exists in
`lending-sdks/packages/providers`. Tier C is impossible without it. Build it
once: binary-search `eth_getBlockByNumber` per chain per target timestamp, cache
`(chain_id, date) → block_number` in a small table. ~47 chains × 365 days =
17,155 cached entries, resolved in a few thousand RPC calls total, then reused
forever by every subsequent backfill.

### Archival RPC reality check

Of 34 configured chains in `worker-api/wrangler.toml`, only **6** have an
explicitly archival Dwellir endpoint (10, 25, 8453, 42161, 43114, 59144); two
are explicitly `-full`/pruned (137, 143); the rest are the 1delta gateway with
unknown depth. **Auditing archival depth per chain is a prerequisite for tier
C** and should be its own small task — it determines which of the ~2,000 fork
markets are reachable at all.

Cost, once archival is available: batching ~150 markets per multicall and ~5
calls per market, a daily grid over one year is roughly **170 k archival
multicalls** across all chains. At a throttled few requests/second that's days
of wall-clock, not weeks — and it is a one-time cost, resumable, and parallel
per chain.

---

## 8. Sequencing

Ordered by value-per-unit-effort, and front-loading the sources that are
actively decaying.

**Phase 0 — stop the bleeding (days).** Persist the Compound V3 30-day history
that `lending-owners` already fetches but discards. Start a daily Euler
`/totals` + `/apy` capture to outrun the 95-day cap. Neither needs the new
schema — dump to NDJSON now, ingest later.

**Phase 1 — schema + identity (1 week).** `market_index_snapshots` migration,
`source` column on `lending_snapshots`, partitioning/rollup decision, and lift
`computeMarketUid` into a shared package consumed by all three repos.

**Phase 2 — Morpho (1 week, covers 51 % of markets).** `api.morpho.org` gives
rates, totals **and** exact share price back to each market's creation, free and
keyless. Verified end-to-end. This alone makes the realized-vs-quoted product
real for half the universe.

**Phase 3 — Euler + Dolomite + Compound V3 (1 week, → 71 %).** Euler API to its
95-day floor; Dolomite `InterestIndexSnapshot`; Compound V3 rolling window. Then
extend Compound V3 and Euler backwards with DefiLlama `/chart` (§3a) — it holds
years of supply-side history their own APIs have already dropped. Rates and TVL
only; the index still comes from archival.

**Phase 4 — Messari subgraphs (1–2 weeks, → ~78 %).** Aave V3 canonical, Spark,
Silo, Venus, Moonwell, dForce. Keys already exist in `lending-owners` GH
secrets. Confirm `marketDailySnapshots` carries `exchangeRate` before committing
— unverified here for lack of a local key.

**Phase 5 — archival replay for the tail (2–4 weeks).** Block-grid index,
archival depth audit, then `margin-fetcher`'s existing per-family multicall
builders replayed at pinned blocks. This is the only path for the ~100 Aave
forks, Fluid, Gearbox and the long tail — and the only one that is exact for
every one of them.

---

## 9. Open questions

1. **How far back do we actually want?** One year covers the interesting range
   and bounds cost. Morpho would give us more for free; tier C cost scales
   linearly with the window.
2. ~~**Does DefiLlama Pro pay for itself?**~~ **Answered — probably not** (§3a).
   Pro buys borrow-rate history on the same ~29 % of markets llama already
   covers, and still yields no share price at any tier. Free `/chart` is worth
   using for its depth on Compound V3 / Euler; the subscription is not worth it
   for this project unless the archival-depth audit comes back badly.
3. **Archival depth per chain** — blocking for Phase 5, unknown today.
4. **Messari `exchangeRate` presence** — blocking for Phase 4's index column;
   needs one query with an existing key.
5. **Aave V4's API** — `api.v4.aave.com` unprobed for history; 78 markets, low
   priority but possibly free.
