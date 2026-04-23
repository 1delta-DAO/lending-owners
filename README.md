# lending-owners

Snapshots **supply-side ownership** for lending markets across several protocols. A scheduled runner queries subgraphs or HTTP APIs, aggregates positions per market, and writes JSON under [`data/`](data/) (one file per lender, e.g. `data/MORPHO_BLUE.json`).

The repo is a **pnpm workspace**: shared types live in `@lending-owners/core`, protocol-specific logic in `@lending-owners/fetcher-*`, and the CLI in `@lending-owners/runner`.

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
| `MORPHO_BLUE_SUBGRAPH_API_KEY` | MORPHO_BLUE |
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

### Placeholder values

If a subgraph env var is set to **`xxx`**, that value is **not** treated as a real key: the runner **skips** that lender and logs a warning. The same placeholder is rejected if passed into a fetcher config directly.

If you select only lenders that are all skipped this way, the process exits with code **1**.

## GitHub Actions

Workflows live under [`.github/workflows/`](.github/workflows/). Each fetch workflow:

- Runs on **schedule** (below) and **`workflow_dispatch`**
- Checks out the repo, installs with pnpm, writes `.env` from **repository secrets** (or `touch .env` for AAVE_V4 / EULER)
- Runs the runner for one lender, then commits `data/<LENDER>.json` if it changed

### Repository secrets (subgraph lenders)

Configure these in **Settings → Secrets and variables → Actions** (names must match):

`AAVE_V3_SUBGRAPH_API_KEY`, `COMPOUND_V3_SUBGRAPH_API_KEY`, `MORPHO_BLUE_SUBGRAPH_API_KEY`, `SILO_SUBGRAPH_API_KEY`, `SPARK_SUBGRAPH_API_KEY`, `VENUS_SUBGRAPH_API_KEY`, `DFORCE_SUBGRAPH_API_KEY`, `MOONWELL_SUBGRAPH_API_KEY`

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