-- Generated from NEREUS/43114/2026-11.ndjson (11 rows)
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
NEREUS:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.01464890541476500053673911	1.063854361999840327488613934	ray
NEREUS:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.257698702737512767224040405	1.372562214818017642374362182	ray
NEREUS:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.340999843138741829119253114	1.445608745258454409989986492	ray
NEREUS:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.173855910718501740846862293	1.237327259251795800743874846	ray
NEREUS:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.015385608268079279795727152	1.077818892298533972538181472	ray
NEREUS:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.123689962054350805383681499	1.519106404902027196672190607	ray
NEREUS:43114:0x249848beca43ac405b8102ec90dd5f22ca513c06	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.913697582785520084339930501	2.444150467608346427538228669	ray
NEREUS:43114:0x6e84a6216ea6dacc71ee8e6b0a5b7322eebc0fdd	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.931158583147845012890960433	4.090467718759630216743845109	ray
NEREUS:43114:0xb599c3590f42f8f995ecfa0f85d2980b76862fc1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.042554150361395645429844001	1.090400514563799387862878223	ray
NEREUS:43114:0x47536f17f4ff30e64a96a7555826b8f9e66ec468	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.089685681616550786683284537	1.142328646680453839072273271	ray
NEREUS:43114:0xfcde4a87b8b6fa58326bb462882f1778158b02f1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	1	ray
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
