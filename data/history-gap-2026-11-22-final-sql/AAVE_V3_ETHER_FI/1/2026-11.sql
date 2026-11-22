-- Generated from AAVE_V3_ETHER_FI/1/2026-11.ndjson (24 rows)
-- Apply with:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <this file>
--
-- Safe to re-run: every insert upserts on (market_id, data_ts).
-- Safe against the markets FK: rows for unknown markets are skipped, not
-- fatal, and the count is echoed before COMMIT.
\set ON_ERROR_STOP on
BEGIN;

DO $$
BEGIN
  IF (SELECT relkind FROM pg_class WHERE oid = to_regclass('lending_snapshots')) IS DISTINCT FROM 'v'
     OR (SELECT relkind FROM pg_class WHERE oid = to_regclass('market_index_snapshots')) IS DISTINCT FROM 'v' THEN
    RAISE EXCEPTION 'this file writes the compact history layout (yield-tracer 0205); lending_snapshots / market_index_snapshots are not views here';
  END IF;
END $$;

CREATE TEMP TABLE _hist_stage (
  market_uid           text,
  data_ts              timestamptz,
  source               text,
  block_number         bigint,
  deposit_rate         numeric,
  variable_borrow_rate numeric,
  total_deposits       numeric,
  total_debt           numeric,
  total_deposits_usd   numeric,
  total_debt_usd       numeric,
  utilization          numeric,
  supply_index         numeric(60,30),
  borrow_index         numeric(60,30),
  index_kind           text
) ON COMMIT DROP;

COPY _hist_stage (market_uid, data_ts, source, block_number, deposit_rate, variable_borrow_rate, total_deposits, total_debt, total_deposits_usd, total_debt_usd, utilization, supply_index, borrow_index, index_kind) FROM stdin;
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	3.930201773743903	0	7324.234681372671	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.41566278082147745	1.681103487555347	8701.641102	2390.891609	8700.392503518273	2390.5485399630243	0.27476329820710177	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-21T19:00:00.000Z	archival-rpc	26465427	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.57145494131855	0.00008397790044	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-21T19:00:00.000Z	archival-rpc	26465427	2.283811680034728	20.837614501006204	1863.955802410947	261.336865633819	1863.955802410947	261.336865633819	0.1402055055682066	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	3.930201773743903	0	7327.6850598252295	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.41566278082147745	1.681103487555347	8701.64523	2390.896197	8700.429784194273	2390.5622366192033	0.2747636951179174	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-21T20:00:00.000Z	archival-rpc	26465727	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.57145494131855	0.00008397790044	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-21T20:00:00.000Z	archival-rpc	26465727	2.283811680034728	20.837614501006204	1863.9606496848837	261.34308217582424	1863.9606496848837	261.34308217582424	0.14020847608559023	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	3.930201773743903	0	7340.242012281974	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.41566278082147745	1.681103487555347	8701.698906	2390.955846	8700.48345269681	2390.621877287431	0.27476885511993376	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-22T09:00:00.000Z	archival-rpc	26469617	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.59886186971183	0.00008399852915999999	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-22T09:00:00.000Z	archival-rpc	26469617	2.283811680034728	20.837614501006204	1864.0236642460604	261.42391067637624	1864.0236642460604	261.42391067637624	0.1402470986236723	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	3.930201773743903	0	7471.7622341319575	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.41566278082147745	1.681103487555347	8701.703035	2390.960434	8700.487581120073	2390.626464646579	0.27476925199390007	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-22T10:00:00.000Z	archival-rpc	26469915	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.59886186971183	0.00008399852915999999	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-22T10:00:00.000Z	archival-rpc	26469915	2.283811680034728	20.837614501006204	1864.028511519997	261.4301292884224	1864.028511519997	261.4301292884224	0.14025007003527146	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	3.930201773743903	0	7226.111695306551	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.41566278082147745	1.681103487555347	8701.694777	2390.951258	8700.479324273549	2390.617289928283	0.27476845824559076	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-22T08:00:00.000Z	archival-rpc	26469318	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.57145494131855	0.00008397790044	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-22T08:00:00.000Z	archival-rpc	26469318	2.283811680034728	20.837614501006204	1864.0188169721237	261.4176922122125	1864.0188169721237	261.4176922122125	0.14024412727595442	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	3.930201773743903	0	7471.7622341319575	0	0	\N	\N	\N
AAVE_V3_ETHER_FI:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.41566278082147745	1.681103487555347	8701.707164	2390.965023	8700.491709543332	2390.6310530055875	0.27476964898240974	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x6c3ea9036406852006290770bedfcaba0e23a0e8	2026-11-22T11:00:00.000Z	archival-rpc	26470215	6.145806e-12	0.000010329473434616	111.600816	0.000084	111.59886186971183	0.00008399852915999999	7.526826685568321e-7	\N	\N	\N
AAVE_V3_ETHER_FI:1:0x853d955acef822db058eb8505911ed77f175b99e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	2.283811680034728	20.837614501006204	1864.0333587939338	261.4363480483544	1864.0333587939338	261.4363480483544	0.14025304151075324	\N	\N	\N
\.

ANALYZE _hist_stage;

INSERT INTO lending_snapshots_data AS t (
    market_id, data_ts, deposit_rate, variable_borrow_rate,
    total_deposits, total_debt, total_deposits_usd, total_debt_usd,
    utilization, source
)
SELECT DISTINCT ON (m.id, s.data_ts)
       m.id, s.data_ts,
       CASE WHEN abs(s.deposit_rate) >= 1e10 THEN NULL ELSE s.deposit_rate END,
       CASE WHEN abs(s.variable_borrow_rate) >= 1e10 THEN NULL ELSE s.variable_borrow_rate END,
       CASE WHEN abs(s.total_deposits) >= 1e22 THEN NULL ELSE s.total_deposits END,
       CASE WHEN abs(s.total_debt) >= 1e22 THEN NULL ELSE s.total_debt END,
       CASE WHEN abs(s.total_deposits_usd) >= 1e30 THEN NULL ELSE s.total_deposits_usd END,
       CASE WHEN abs(s.total_debt_usd) >= 1e30 THEN NULL ELSE s.total_debt_usd END,
       s.utilization, s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.deposit_rate         IS NOT NULL
    OR s.variable_borrow_rate IS NOT NULL
    OR s.total_deposits       IS NOT NULL
    OR s.total_debt           IS NOT NULL
    OR s.total_deposits_usd   IS NOT NULL
    OR s.total_debt_usd       IS NOT NULL
    OR s.utilization          IS NOT NULL
 ORDER BY m.id, s.data_ts, s.ctid DESC
ON CONFLICT (market_id, data_ts) DO UPDATE SET
    deposit_rate         = COALESCE(excluded.deposit_rate,         t.deposit_rate),
    variable_borrow_rate = COALESCE(excluded.variable_borrow_rate, t.variable_borrow_rate),
    total_deposits       = COALESCE(excluded.total_deposits,       t.total_deposits),
    total_debt           = COALESCE(excluded.total_debt,           t.total_debt),
    total_deposits_usd   = COALESCE(excluded.total_deposits_usd,   t.total_deposits_usd),
    total_debt_usd       = COALESCE(excluded.total_debt_usd,       t.total_debt_usd),
    utilization          = COALESCE(excluded.utilization,          t.utilization),
    -- First-writer provenance: a backfill row merging into a live-cron row must
    -- not relabel it, or DELETE ... WHERE source <> 'live-cron' would delete
    -- live measurements. Mirrors the TypeScript ingest path.
    source               = CASE WHEN t.source = 'live-cron'
                                THEN 'live-cron'
                                ELSE excluded.source END
-- A row the live cron measured is never overwritten by an API's version of
-- the same hour. Added for the 2026-08-26 → 09-14 fetcher-a gap, where ~30 %
-- of hours DO exist: without this guard every one of them would have taken
-- Morpho's / Euler's number in place of our own read. Backfill fills holes;
-- it does not re-measure.
 WHERE t.source <> 'live-cron';

INSERT INTO market_index_snapshots_data AS t (
    market_id, data_ts, block_number, supply_index, borrow_index, index_kind, source
)
SELECT DISTINCT ON (m.id, s.data_ts)
       m.id, s.data_ts, s.block_number, s.supply_index, s.borrow_index,
       COALESCE(s.index_kind, 'unknown'), s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.supply_index IS NOT NULL
    OR s.borrow_index IS NOT NULL
 ORDER BY m.id, s.data_ts, s.ctid DESC
ON CONFLICT (market_id, data_ts) DO UPDATE SET
    block_number = COALESCE(excluded.block_number, t.block_number),
    supply_index = COALESCE(excluded.supply_index, t.supply_index),
    borrow_index = COALESCE(excluded.borrow_index, t.borrow_index),
    index_kind   = excluded.index_kind,
    source       = excluded.source
 WHERE t.source <> 'live-cron';

SELECT
    (SELECT count(*) FROM _hist_stage)                                     AS staged_rows,
    (SELECT count(DISTINCT s.market_uid) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS unknown_markets,
    (SELECT count(*) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS rows_skipped
\gset _hist_
\echo '  staged=':_hist_staged_rows'  skipped_rows=':_hist_rows_skipped'  unknown_markets=':_hist_unknown_markets

COMMIT;
