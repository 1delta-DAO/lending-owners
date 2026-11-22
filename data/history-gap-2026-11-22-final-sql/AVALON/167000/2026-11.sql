-- Generated from AVALON/167000/2026-11.ndjson (18 rows)
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
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T19:00:00.000Z	archival-rpc	14321760	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42764233912	0.0000039932399999999996	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T19:00:00.000Z	archival-rpc	14321760	21.334031176461757	40.77522554343754	112.080293	118.992043	112.06421059875743	118.97496883174992	1.0616678437840985	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.001252638245560263	0.1509146806257378	10674.83080953211	161.41711341982565	638.6958365060766	9.657899045108204	0.01512128073034075	\N	\N	\N
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T20:00:00.000Z	archival-rpc	14323560	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42764233912	0.0000039932399999999996	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T20:00:00.000Z	archival-rpc	14323560	21.334031176461757	40.77522554343754	112.082814	118.997578	112.06715827254048	118.98095641830497	1.0616933475635257	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.001252638245560263	0.1509146806257378	10674.830824796536	161.41714122828455	638.6958374193769	9.657900708942247	0.015121283313767287	\N	\N	\N
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T08:00:00.000Z	archival-rpc	14345160	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42764233912	0.0000039932399999999996	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T08:00:00.000Z	archival-rpc	14345160	21.334031176461757	40.77522554343754	112.113055	119.064027	112.09739504847761	119.04739613670864	1.061999666318967	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.001252638245560263	0.1509146806257378	10674.831007969633	161.417474930165	638.6958483789786	9.657920674973138	0.015121314314920179	\N	\N	\N
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T10:00:00.000Z	archival-rpc	14348760	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42776392672	0.00000399344	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T10:00:00.000Z	archival-rpc	14348760	21.334031176461757	40.77522554343754	112.118096	119.075105	112.10243534435072	119.05847258933359	1.0620507237297359	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.001252638245560263	0.1509146806257378	10674.831038498482	161.41753054721212	638.6958502055788	9.657924002648963	0.015121319481785172	\N	\N	\N
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T09:00:00.000Z	archival-rpc	14346960	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42776392672	0.00000399344	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T09:00:00.000Z	archival-rpc	14346960	21.334031176461757	40.77522554343754	112.115575	119.069566	112.099914696484	119.05293436302112	1.0620252003345654	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.001252638245560263	0.1509146806257378	10674.831023234057	161.41750273868615	638.6958492922787	9.657922338810906	0.015121316898352452	\N	\N	\N
AVALON:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T11:00:00.000Z	archival-rpc	14350560	1.6528895e-11	0.000018271795980049	2.431752	0.000004	2.42776392672	0.00000399344	0.0000016449045790853673	\N	\N	\N
AVALON:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T11:00:00.000Z	archival-rpc	14350560	21.334031176461757	40.77522554343754	112.120616	119.080644	112.10495499235712	119.06401081564609	1.062076255449756	\N	\N	\N
AVALON:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.001252638245560263	0.1509146806257378	10674.831053762908	161.41755835574284	638.6958511188791	9.657925666487305	0.015121322065218325	\N	\N	\N
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
