# Earn history backfill — rows first stored Sep 15 → Oct 30 2026

Status: **collected, gated, exported and rehearsed 2026-10-30; NOT loaded.**
See §8 for what was built, the load commands and what is left. Task:
yield-tracer `tickets/0006-earn-history-backfill-2026-10.md`. Per-row input:
[`data/earn-backfill-2026-10/inventory.json`](data/earn-backfill-2026-10/inventory.json).

This covers the vault rows whose **first stored point in prod is on or after
2026-09-15**, although most of the vaults are older than that. These are the
rows the package releases of the last six weeks added: IPOR Fusion, the
Solana families, the 5.0.141 earn options, a Morpho listing expansion, Yearn,
the Alchemix Transmuters, and others. Each of them has a two-to-six-week
chart, a 30-day average over a partial window, and no realized-rate history,
while the protocol itself holds months or years of data.

## 1. Inventory (measured 2026-10-30)

Method:
- Every `/earn/latest` row on the 49 served chains, all filters off (13,933
  rows, of which 2,511 are vaults).
- `/earn/history?days=365` for each vault row whose 30-day rate-stats array
  started late.
- A cross-check of each vault against the NDJSON already on disk in
  `data/history/`.

The result is 980 rows and $13.2B of TVL. Rows older than 2026-09-15 with
ordinary gaps are out of scope; the 2026-10 vault gap has its own
`vault-gap-2026-10-sql`.

| lane | rows | TVL | what it needs |
| --- | ---: | ---: | --- |
| **A1** load from disk | 200 | $154M | Already collected: 191 Yearn, YO, jrDOLA/sINV and 2 Morpho. Export and load only. jrDOLA/sINV are already exported (`vault-inverse-2026-10-sql`). |
| **A2** re-run an existing module | 515 | $4.69B | The module exists but has never seen these vaults: Morpho 373 ($4.58B, listed in prod from 10-19), Yearn 93, Pendle 28, Upshift 8, GMX 4, Lagoon 4, Euler Earn 5. |
| **B** new module: IPOR Fusion | 12 | $45M | `VAULT_IPOR`, §3. |
| **C** DefiLlama `/chart` | 143 | $7.13B | One pinned UUID per row in `defillama.ts` (`VAULT_LLAMA`), after each candidate is verified (§4). This lane holds the large savings and LST rows. |
| **D** forward-only | 52 | $25M | TermMax (31), Kamino kVault (11), Loopscale (4), Spectra (3), Exponent PT (2), Lista vault (1). None has an upstream history surface (`HISTORY_GAPS.md` §3.1). Accept it. |
| **E** source to find | 58 | $1.16B | No module and no automatic Llama match. Jupiter Perps LP alone is $812M; then the ether.fi Optimism vaults, Noon sUSN, Yuzu, Nest nFALCON, Aegis sYUSD, the Exponent tranches, … |

Top rows by lane are in `inventory.json` (`lane`, `runnerKey`, `onDisk`,
`llamaCandidates`). Regenerate it before starting if more than a few days
have passed. The scripts that built it are summarised in §7.

## 2. Prerequisites — the backfill writes wrong or useless rows without these

### P1. Solana addresses are lower-cased on the way in

Both load paths fold the vault address to lower case and **write the folded
value**:

- `packages/history-runner/src/sql-vaults.ts`: `toVaultCopyLine`
  (`parts[2].toLowerCase()`) and `RESOLVE_DDL` (`lower(vl.vault_address) AS
  vault_address`);
- yield-tracer `app/src/integst/vaultHistory/index.ts`
  (`vaultAddress: r.addr.toLowerCase()`).

Live rows key Solana addresses verbatim. The fetcher's `addrKey` lower-cases
only EVM addresses, so a backfilled Solana row would land under a base58 key
that no live row and no `/earn` uid matches: invisible, with no error. This
is the CLAUDE.md Solana rule.

**Fix:** join case-insensitively as today, but **write the stored
`vaults_latest.vault_address`** as it is. That changes nothing on EVM, where
the live value is already lower case. The inventory holds 74 Solana rows,
about $4.74B: every LST, Jupiter Perps LP, OnRe, Hastra, Perena, Reflect and
the Exponent tranches.

### P2. DefiLlama rates are APY; `total_rate` is APR

`defillama.ts` emits `depositRate: apy`. yield-tracer stores a savings row's
`depositRate` verbatim as `vaults_snapshots.total_rate`, and the live
fetchers write APR there. `inverseStaking.ts` converts with
`apyToAprPercent` for this reason. Llama rows would read slightly high: 10%
APY is 9.53% APR.

**Fix:** convert in `defillama.ts` as `inverseStaking.ts` does. Decide
separately whether to re-export the existing `VAULT_LLAMA` rows (sUSDe, USD3,
sUSD3, wiTRY, apyUSD, sUSDat), which carry the same bias.

### P3. Port 5432 is no longer reachable from your machine

Since 2026-10-30, `port-guard.sh` drops every swarm-published port on the
public interface. The `DATABASE_URL=…@152.53.188.219:5432` lines in
yield-tracer `app/scripts/PROD_HISTORY_INGEST.md` now time out. Use one of:

- `ssh -L 55432:127.0.0.1:5432 root@152.53.188.219` and
  `DATABASE_URL=postgres://…@127.0.0.1:55432/…`;
- `scp` the SQL directory to the box and run `apply-history-sql.sh` there;
- the HTTP path, `scripts/ingest-history.ts --url https://<primary> --token …`.

Update the runbook while you are at it.

## 3. Lane B: `VAULT_IPOR` (new module)

Source, verified 2026-10-30:
`GET https://api.ipor.io/v2/fusion/vault-history/{chainId}/{vault}-1y`

- A static S3 object, gzip. `-30d`, `-1y` and `-all` exist; `-90d` and
  `-365d` are `NoSuchKey`.
- The `-1y` window is **hourly back to vault inception**: rETHLPC has 4,566
  points from 2026-04-22.
- Each point has `blockNumber`, `blockTimestamp`, `tvl` (USD),
  `totalBalance` (asset units), `apy`, `netApy`, `grossApy` and
  `assetsToSharesRatio`.
- The file is rebuilt periodically: `createdAt` was a day old when read.

Mapping, following lending-sdks `docs/earn/IPOR_FUSION.md` §2.3 and §5:

| HistoryPoint | from | note |
| --- | --- | --- |
| `supplyIndex` (`indexKind: assets_per_share`) | `assetsToSharesRatio` | Equals on-chain `convertToAssets(10**decimals)` to the wei. |
| `depositRate` | the realized rate over the trailing 30 days of `assetsToSharesRatio` | **Not** `apy` / `netApy`. §2.3 measured both overstating the realized rate by up to 2×, and the live row is the realized 30-day rate. The first 30 days after inception get a shorter window, or no rate. |
| `totalDeposits` / `totalDepositsUsd` | `totalBalance` / `tvl` | |
| `dataTs` | `blockTimestamp` bucketed to the hour | |

The address list is calldata-sdk `IPOR_FUSION_VAULTS` (12 vaults on chains 1
and 8453). Use the same `-1y` file on both chains. Add `VAULT_IPOR: "savings"`
to `PROVIDER_OF` in **both** repos (`sql-vaults.ts` and yield-tracer
`integst/vaultHistory`), and a roster row in `vault-providers.ts`.

## 4. Lane C: DefiLlama pins

`llamaCandidates` in the inventory holds up to three pools per row: same
chain, TVL within ±30% of ours today, and a pool symbol contained in the
row's name or asset symbol. Of the 143 rows, most top candidates are right:
BNSOL, LsETH, bUSD0, JupSOL, sUSDai, liquidETH, ONyc, dSOL, mSOL, INF, PRIME,
AUTO, earnETH/earnUSD, sUSDX and gtUSDa match on project, symbol and rate.
**Some are wrong**:
- Phase, Helius and JagPool staked SOL all resolve to `jupiter-lend` WSOL;
- Aster asBNB resolves to `lista-cdp`;
- Kinetiq vkHYPE resolves to `morpho-blue`.

Pin a UUID only when all three of these hold:

1. **The project is the row's protocol.** Not a venue that holds the token.
2. **Llama's latest `apy`, converted to APR, is within ~0.5 pp or 10% of our
   live rate**, and its `tvlUsd` is within 15%.
3. **The chart's last 7 daily points sit within the same band of our stored
   rows for those days.** This is the anchor check in §5, done by hand once
   per pin.

Pin with the yield-tracer row's own address, never a symbol join. This is
`defillama.ts`'s existing "ticker collisions" rule. Lane E rows move into
lane C when a pool passes these checks.

## 5. Collect → gate → export → load

All of this follows the existing runbooks. Only the inputs are new.

```bash
# lending-owners
pnpm fetch:history -- --lender VAULT_MORPHO,VAULT_YEARN,VAULT_PENDLE,VAULT_UPSHIFT,VAULT_GMX,VAULT_LAGOON,VAULT_EULER_EARN \
  --out $PWD/data/earn-backfill-2026-10/history      # A2; only the inventory's vaults are needed
pnpm fetch:history -- --lender VAULT_IPOR,VAULT_LLAMA --out $PWD/data/earn-backfill-2026-10/history   # B + C

# gate every series on the live overlap: share price and rate must meet the
# live rows where both exist; a vault with no overlap is dropped, not trusted
node ~/yield-tracer/app/scripts/check-vault-backfill.mjs --dirs data/earn-backfill-2026-10/history \
  --from <series start> --to 2026-10-30T00:00Z --out data/earn-backfill-2026-10/gated

pnpm validate:history -- --dir $PWD/data/earn-backfill-2026-10/gated
pnpm export:history-sql -- --dir $PWD/data/earn-backfill-2026-10/gated --out $PWD/data/earn-backfill-2026-10-sql
```

- **Gate on the overlap.** Each row has one to six weeks of live points, so
  every backfilled series can be checked against them. This is the
  `check-vault-backfill.mjs` rule from the 2026-10 vault gap.
  - Morpho's blue-api share prices failed it on chain 1 for 106 of 163 vaults
    last time. Expect the gate to drop some vaults, and list them rather than
    loosening it.
  - `check-vault-backfill.mjs` was written for a bracketed gap (two anchor
    hours). Here the anchor is the series' tail against the live head, so it
    may need a `--tail-anchor` mode.
- **Live rows win.** `sql-vaults.ts` keeps `live-cron` values and fills only
  NULLs, so loading over the live weeks is safe and changes nothing there.
- **Size.** Morpho's 373 vaults dominate. The 2026-09 full Morpho run was
  575k rows for ~1k vaults, so this is in the hundreds of thousands. Pace it
  per chain and watch `pg_replication_slots.wal_status`
  (`PROD_HISTORY_INGEST.md` "When the load gets big").
- **Load is operator-run.** Auto mode denies prod psql. Dry-run first:

```bash
cd ~/yield-tracer/app
./scripts/backfill-lending-gap.sh --dir ../../lending-owners/data/earn-backfill-2026-10-sql             # dry run
./scripts/backfill-lending-gap.sh --dir ../../lending-owners/data/earn-backfill-2026-10-sql --execute
npx tsx scripts/recompute-earn-rate-days.ts <earliest day> 2026-10-30
npx tsx scripts/backfill-asset-exchange-rate-daily.ts <earliest day> 2026-10-30
```

The derived days must be recomputed: rows that land after a day has settled
are invisible to the hourly jobs.

Rehearse on `yt_clean` first, as the Inverse and gap loads were:
- migrated to head;
- a planted `live-cron` row keeps its values;
- a re-run inserts 0;
- one **Solana** row lands under its base58 key (P1).

## 6. What will stay missing

- **Lane D** (52 rows, $25M): no history surface upstream.
- **Rows whose source is shallower than the vault.** Llama only reaches back
  to the pool's listing; Euler Earn's floor is 2026-04-23.
- **Lane E rows with no Llama pool and no provider API.** For an EVM 4626,
  archival `convertToAssets` replay
  (`app-fetcher/scripts/replay-vault-history.ts`) can give a share-price
  series. Public RPCs hold about 19 days of state, so anything deeper needs
  a keyed archive RPC. Solana has no equivalent.
- `/earn/history` serves 365 days, so nothing older than 2025-10-31 shows in
  the product even when loaded. Load to inception anyway: it is cheap, and
  the realized-rate work in ticket 0002 reads further back.

## 7. Reproducing the inventory

The scripts are one-offs, not committed:

1. Pull `/earn/latest?chainId=<c>&includeHighRisk=true&minTvlUsd=0&passthrough=include&illiquid=include&includeFixedTerm=true`
   for every chain in `lending-buckets.json` (`vault_chains` ∪
   `lending_chains`), paging by `start`.
2. For `venueKind == "vault"`, request `/earn/rate-history?uids=` (up to
   1,000 per request). A row whose `base` array has no sample in its first 3
   days is a candidate.
3. For each candidate, `/earn/history?earnUid=&days=365`. The first point is
   the "first stored" date. Morpho's rate-stats array alone is misleading:
   old Steakhouse vaults look new there.
4. Join to `data/history/VAULT_*/**/*.ndjson` `marketUid`s for `onDisk`, and
   to `yields.llama.fi/pools` for `llamaCandidates`.

## 8. Status 2026-10-30 — built, rehearsed, waiting for the operator load

**Export:** `data/earn-backfill-2026-10-sql/` — 371,917 rows, 541 files, 62 MB,
plus the earlier `vault-inverse-2026-10-sql/` (jrDOLA/sINV, 867 rows). Gated
from `data/earn-backfill-2026-10/history` (+ `history-hourly`, a Morpho tail
for vaults listed after 10-28) with
`check-vault-backfill.mjs --tail-anchor --only inventory.json`; per-series
verdicts in `data/earn-backfill-2026-10/gated/GATE_SERIES.json`.

| key | series written | rows | from |
| --- | ---: | ---: | --- |
| VAULT_YEARN | 267 | 193,629 | 2024-01 |
| VAULT_IPOR | 12 | 90,226 | 2025-03 (rETHLPC 2026-04-22) |
| VAULT_MORPHO | 373 | 67,497 | per vault (V2 vaults from late 2025) |
| VAULT_LLAMA / _LST | 80 | 19,679 | 2022-10 |
| VAULT_ETHERFI_LIQUID | 3 | 627 | 2026-04 |
| VAULT_PENDLE | 27 | 207 | (new markets — little before listing) |
| VAULT_YO | 4 | 52 | |

767 inventory rows ($10.95B) get history.

**Rehearsed on `yt_clean`** (migrated to 0197, `*_latest` planted for the 767
vaults): every file applied, 0 unknown-vault / unmapped-key rows; a planted
`live-cron` row kept its values; a re-run left row counts unchanged (it does
rewrite backfill rows in place — the merge lets a backfill correct a backfill);
JupSOL landed as `jupSoLaHX…` under `lst`.

**What changed to get here** (uncommitted, lending-owners + yield-tracer):
- P1 both load paths write the stored address verbatim; P2 APY→APR in
  `defillama.ts` — **and in `morpho.ts`, `yearn.ts`, `upshift.ts`,
  `eulerEarn.ts`, `yo.ts`**, which all wrote APY where live stores APR (the
  gate's 50 % band cannot see that). Rows exported from these modules before
  2026-10-30 carry the APY; re-exporting them corrects backfill rows in place.
- `morpho.ts` reads Vault V2 (`vaultV2s` / `vaultV2ByAddress`, rate =
  `avgNetApy` 24 h): 372 of the 375 Morpho rows are V2, the V1-only roster
  found 3.
- `upshift.ts` roster → August `tokenized_vault` (the app proxy 307s to itself).
- New: `ipor.ts` (`VAULT_IPOR`, `-all`+`-1y`+`-30d`+`-7d` merged, hourly,
  realized 30 d rate), `etherfiLiquid.ts` (`VAULT_ETHERFI_LIQUID`, sevenseas
  daily), `VAULT_LLAMA_LST` key (→ `lst`), 81 new Llama pins (71 lane C +
  10 lane E, decisions in `llama-pins.json` / `lane-e-findings.json`), Llama
  0 % days dropped as missing, per-pool `rateField: "apyBase"`.
- Runner `--only <inventory.json | chain:addr list>` (`ctx.onlyVaults`).
- yield-tracer: `check-vault-backfill.mjs --tail-anchor --only`,
  PROD_HISTORY_INGEST.md uses the ssh tunnel (P3).

**Load (operator):**

```bash
ssh -N -L 55432:127.0.0.1:5432 root@152.53.188.219 &
export DATABASE_URL=postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@127.0.0.1:55432/$POSTGRES_DB
cd ~/yield-tracer/app
./scripts/backfill-lending-gap.sh --dir ../../lending-owners/data/earn-backfill-2026-10-sql --execute --only VAULT_YO   # canary
./scripts/backfill-lending-gap.sh --dir ../../lending-owners/data/earn-backfill-2026-10-sql --execute
./scripts/apply-history-sql.sh ../../lending-owners/data/vault-inverse-2026-10-sql
npx tsx scripts/recompute-earn-rate-days.ts 2025-10-01 2026-10-30
npx tsx scripts/backfill-asset-exchange-rate-daily.ts 2026-07-11 2026-10-30   # not earlier: share-price scale repair
```

Then check `/earn/history?days=365` for the three acceptance uids.

**Left over** (named per row in the JSON files):
- Lane D, 52 rows: accepted.
- Gate: 24 series dropped whole ($5.1M), 6 without overlap (4 dust Upshift
  vaults whose API stops 2026-08-07, one Morpho on 5042, one Pendle listed
  10-30); share price dropped on 81 Yearn vaults (Kong `pps` 2–23 % off live
  or a 2× step) — their rates load where they matched.
- Lane C rejected 72 ($1.23B): no own-protocol pool, constant offsets, broken
  Llama series. sUSDai ($476M) and PlasmaUSD are borderline — re-check.
- Upshift: USPC Custody ($28M), Doma HYPE ($19M), Spark Earn Flare, Protected
  USD are listed live but unknown to August's API (`Tokenized Vault not
  found`) — source unknown.
- Lane E: 24 archival-4626 rows ($82.7M) need a keyed archive RPC; JLP
  ($812M): price/TVL via CoinGecko 365 d, rate not recoverable in band; Yuzu
  syzUSD (rate-only API), Origin wOUSD (squid), Tangent sUSG (Kong) — modules
  not written; 17 unrecoverable ($11.9M, Exponent tranches etc.; Exponent and
  Noon sUSN serve rolling windows worth recording daily from now).
- **Live-side:** Superform, BNSOL, bUSD0, DFDV, The Vault, JPool, Hastra AUTO,
  gtUSDa (Arb/Eth) look like they STORE APY in `total_rate` (they match
  Llama's raw apy, not its APR). Backfilled history sits below live by the
  gap (≈0.1 pp at 4.5 %, 1.5–2 pp on the ~20 % Superform stock vaults). Fix in
  margin-fetcher.
