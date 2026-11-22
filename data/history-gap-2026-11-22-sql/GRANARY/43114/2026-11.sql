-- Generated from GRANARY/43114/2026-11.ndjson (14 rows)
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
GRANARY:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.06498664966328695	0.6182834380638389	113.4485976707196	14.041565424510427	113.43692381001928	14.040120547428245	0.12377028639230568	\N	\N	\N
GRANARY:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.09791796802064334	0.7589387637881301	1243.252634	188.712694	1243.0789764720828	188.6863346109021	0.15178949864183439	\N	\N	\N
GRANARY:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.688265282744454	3.1513445148758277	192.783927	121.850694	192.45812216337	121.64476632714	0.6320583665670427	\N	\N	\N
GRANARY:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.001737240473358145	0.17830489649227294	0.0050539	0.00005794	305.1913905485128	3.4988403348663075	0.011464413621163853	\N	\N	\N
GRANARY:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.03201597327662422	0.7654496955613432	0.00310064571433366	0.000152856449591638	5.214378911717601	0.2570598258246834	0.04929826354717453	\N	\N	\N
GRANARY:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.05729859273322352	1.0240125473247876	114.72996125413749	7.55273108539722	760.3005348943074	50.05096682130434	0.06583050323417455	\N	\N	\N
GRANARY:43114:0xd1c3f94de7e5b45fa4edbba472491a9f4b166fc4	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.004683280227911	4.2879319821925215	333.1190978053756	93.45013532267329	27.42833695676217	7.694490700688801	0.2805307048990371	\N	\N	\N
GRANARY:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.06498664966328695	0.6182834380638389	113.44858776290229	14.04155551669313	113.4369139032215	14.040110640630463	0.1237702098684451	\N	\N	\N
GRANARY:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.09791796802064334	0.7589387637881301	1243.2524709999998	188.712531	1243.074076702936	188.68545263892682	0.15178938743488735	\N	\N	\N
GRANARY:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.688265282744454	3.1513445148758277	192.783489	121.850256	192.45768490359	121.64432906736	0.6320575306114519	\N	\N	\N
GRANARY:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.001737240473358145	0.17830489649227294	0.0050539	0.00005794	303.30576537999997	3.4772227479999995	0.011464413621163853	\N	\N	\N
GRANARY:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.03201597327662422	0.7654496955613432	0.003100645580804949	0.000152856316062927	5.212315448447512	0.25695788726705493	0.049298222605385446	\N	\N	\N
GRANARY:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.05729859273322352	1.0240125473247876	114.72995242772366	7.552722258983385	759.6174235999354	50.00594266914814	0.06583043136657245	\N	\N	\N
GRANARY:43114:0xd1c3f94de7e5b45fa4edbba472491a9f4b166fc4	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.004683280227911	4.2879319821925215	333.1186404803292	93.44967799762686	27.42829930156451	7.694453045491141	0.28052971716887487	\N	\N	\N
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
