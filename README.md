# lending-owners

Snapshots **supply-side ownership** for lending markets across several protocols. Morpho Blue additionally records the **borrow** and **collateral** sides (`borrowers`, `collateralOwners`), since its isolated markets have a collateral asset distinct from the loan asset. A scheduled runner queries subgraphs or HTTP APIs, aggregates positions per market, and writes JSON under [`data/`](data/) (one file per lender, e.g. `data/MORPHO_BLUE.json`).

The repo is a **pnpm workspace**: shared types live in `@lending-owners/core`, protocol-specific logic in `@lending-owners/fetcher-*`, and the CLI in `@lending-owners/runner`.

## Second axis: historical backfill

Ownership is the repo's first axis. The second — **historical rates, totals and share-price/index series** — is documented in [LENDING_HISTORY_BACKFILL_PLAN.md](LENDING_HISTORY_BACKFILL_PLAN.md). It lives as a `hist/` module beside each fetcher's `index.ts` plus the `@lending-owners/history-runner` CLI. Output is **NDJSON**, one line per `(market_uid, data_ts)`, replayed into `yield-tracer` through an authed ingest route — this side never writes to Postgres.

**Vault providers** (the earn surface — MetaMorpho, Pendle PTs, Fluid, Yearn,
Lagoon, Upshift, Silo managed vaults, GMX GM/GLV, Hyperliquid vaults, Yield
Basis, Cap, Hyperbeat, Gearbox pools) live in one shared package,
[`@lending-owners/fetcher-vaults`](packages/fetchers/vaults/), registered as
`VAULT_<PROVIDER>` runner keys. Their uids (`VAULT_MORPHO:1:0x…`) deliberately
do NOT join the lending `markets` table — the SQL export skips them until a
vault ingest exists. The curl-verified source matrix (endpoints, retention,
units, traps) is margin-fetcher's `src/vaults/HISTORY_APIS.md`; every module
cites its row.

```bash
# the daily ratchet: the sources whose windows roll (Compound V3 = 30 days,
# LlamaLend = 100 snapshots, Cap = 1 year, Gearbox = 1 year). Uncaptured
# days are gone for good.
pnpm capture:daily

# vault-provider examples
pnpm fetch:history -- --lender VAULT_MORPHO --days 730 --chain 1
pnpm fetch:history -- --lender VAULT_PENDLE --days 3650   # full life, one call/market

# backfill one lender
pnpm fetch:history -- --lender MORPHO_BLUE --days 730
pnpm fetch:history -- --lender COMPOUND_V3 --days 35 --dry-run
pnpm fetch:history -- --lender LLAMALEND --chain 1 --resolution 1d --out /tmp/hist
```

Flags: `--lender KEY[,KEY]` / `--decaying` / `--all`, `--from ISO` or `--days N`, `--to ISO`, `--resolution 1d|1h`, `--chain id[,id]`, `--out DIR` (default `data/history/`), `--dry-run`.

Runs are **idempotent** — re-running writes nothing and reports every point as a duplicate, which is what makes the daily job safe to retry. Output lands in `data/history/<LENDER>/<chainId>/<yyyy-mm>.ndjson`; note that [`data/history/.gitignore`](data/history/.gitignore) commits only the two rolling-window sources, because 30 days of Morpho on one chain is already 50 MB.

### Converting to SQL

For an operator who would rather run `psql` than a Node script:

```bash
pnpm export:history-sql --dir data/history --out data/history-sql
# then, from yield-tracer/app:
./scripts/apply-history-sql.sh ../../lending-owners/data/history-sql
```

Each generated file is one transaction that stages into a `TEMP` table, joins `markets` (so rows for markets the live cron never saw are **skipped, not fatal** — both target tables have an FK), de-duplicates on `(market_uid, data_ts)`, then upserts with `COALESCE`. Safe to run against production and safe to run twice; the skip count is echoed before `COMMIT`.

Rates in the output are **percent** (`4.90` = 4.90 % APY), matching `lending_snapshots`. Sources disagree on this among themselves, so each `hist/` module normalizes on the way out.

The operational checklist — what is held, what decays daily, what has no source and needs our own recorder, and the ingest gaps — is [HISTORY_GAPS.md](HISTORY_GAPS.md). Start at plan §0.9 for the A0–A7 plan, §0.10 for the things that will bite, and §0.11 for what is already built and what the first runs measured.

## Requirements

- **Node.js** (see workflows: Node 24)
- **pnpm** 10

## Local usage

Install dependencies:

```bash
pnpm install
```

Copy or create a [`.env`](.env) at the repo root (the runner loads it via `tsx --env-file=../../.env`). Then either:

```bash
pnpm fetch:owners
```

to run **all** lenders in sequence, or target one or more:

```bash
pnpm fetch:owners -- --lender MORPHO_BLUE
pnpm fetch:owners -- --lenders AAVE_V3,COMPOUND_V3
```

Per-lender shortcuts from the root [`package.json`](package.json):

```bash
pnpm fetch:morpho-blue
pnpm fetch:euler
# …see package.json "fetch:*" scripts
```

Outputs are written to `data/<LENDER_KEY>.json`.

## Environment variables

### The Graph (subgraph) API keys

These are **[The Graph](https://thegraph.com/docs/en/querying/querying-the-graph/)** gateway keys for decentralized-network subgraphs. Required **when that lender is included** in a run (full `fetch:owners` or explicit `--lender` / `--lenders`).

| Variable | Used by |
|----------|---------|
| `AAVE_V3_SUBGRAPH_API_KEY` | AAVE_V3 |
| `COMPOUND_V3_SUBGRAPH_API_KEY` | COMPOUND_V3 |
| `SILO_SUBGRAPH_API_KEY` | SILO |
| `SPARK_SUBGRAPH_API_KEY` | SPARK |
| `VENUS_SUBGRAPH_API_KEY` | VENUS |
| `DFORCE_SUBGRAPH_API_KEY` | DFORCE |
| `MOONWELL_SUBGRAPH_API_KEY` | MOONWELL |

### No subgraph key in this repo

| Lender | Notes |
|--------|--------|
| **AAVE_V4** | Uses the public Aave v4 GraphQL API; workflows use an empty `.env`. |
| **EULER** | Uses public Goldsky subgraph URLs; workflows use an empty `.env`. |
| **MORPHO_BLUE** | Uses Morpho's own API (`blue-api.morpho.org`); workflows use an empty `.env`. The Messari subgraphs it used before are unmaintained — mainnet, Base, OP and Unichain all stopped resolving in Aug 2026. |

### Placeholder values

If a subgraph env var is set to **`xxx`**, that value is **not** treated as a real key: the runner **skips** that lender and logs a warning. The same placeholder is rejected if passed into a fetcher config directly.

If you select only lenders that are all skipped this way, the process exits with code **1**.

### Partial snapshots

A fetcher reports chains whose data source failed via `failedChains`. Because each run **overwrites** `data/<LENDER>.json`, writing a snapshot that is missing a chain silently deletes every market on it — so the runner **refuses to write** in that case, logs the failed chains and exits with code **1**, leaving the previous file in place. Pass `--allow-partial` to overwrite anyway.

## GitHub Actions

Workflows live under [`.github/workflows/`](.github/workflows/). Each fetch workflow:

- Runs on **schedule** (below) and **`workflow_dispatch`**
- Checks out the repo, installs with pnpm, writes `.env` from **repository secrets** (or `touch .env` for AAVE_V4 / EULER / MORPHO_BLUE)
- Runs the runner for one lender, then commits `data/<LENDER>.json` if it changed

### Repository secrets (subgraph lenders)

Configure these in **Settings → Secrets and variables → Actions** (names must match):

`AAVE_V3_SUBGRAPH_API_KEY`, `COMPOUND_V3_SUBGRAPH_API_KEY`, `SILO_SUBGRAPH_API_KEY`, `SPARK_SUBGRAPH_API_KEY`, `VENUS_SUBGRAPH_API_KEY`, `DFORCE_SUBGRAPH_API_KEY`, `MOONWELL_SUBGRAPH_API_KEY`

### Scheduled runs (UTC)

Cron uses **GitHub’s UTC** interpretation. Jobs can be delayed during high load ([docs](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule)).

| Workflow | Schedule | Meaning |
|----------|----------|---------|
| [`fetch-aave-v3.yml`](.github/workflows/fetch-aave-v3.yml) | `0 0 * * *` | Daily at **00:00** |
| [`fetch-aave-v4.yml`](.github/workflows/fetch-aave-v4.yml) | `0 1 * * *` | Daily at **01:00** |
| [`fetch-compound-v3.yml`](.github/workflows/fetch-compound-v3.yml) | `0 2 * * *` | Daily at **02:00** |
| [`fetch-dforce.yml`](.github/workflows/fetch-dforce.yml) | `0 3 * * *` | Daily at **03:00** |
| [`fetch-euler.yml`](.github/workflows/fetch-euler.yml) | `0 4 * * *` | Daily at **04:00** |
| [`fetch-moonwell.yml`](.github/workflows/fetch-moonwell.yml) | `0 5 * * *` | Daily at **05:00** |
| [`fetch-silo.yml`](.github/workflows/fetch-silo.yml) | `0 6 * * *` | Daily at **06:00** |
| [`fetch-spark.yml`](.github/workflows/fetch-spark.yml) | `0 7 * * *` | Daily at **07:00** |
| [`fetch-venus.yml`](.github/workflows/fetch-venus.yml) | `0 8 * * *` | Daily at **08:00** |
| [`fetch-morpho-blue.yml`](.github/workflows/fetch-morpho-blue.yml) | `0 16 */2 * *` | **16:00** on **odd** calendar days (approx. every 2 days) |

Hours are staggered so workflows do not all start at the same instant.

## Development

```bash
pnpm typecheck
pnpm build
```