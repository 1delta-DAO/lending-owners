-- Generated from LAYERBANK_V3/98866/2026-11.ndjson (16 rows)
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
LAYERBANK_V3:98866:0x11113ff3a60c2450f4b22515cb760417259ee94b	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.00289460698305284903794649	9.447637990691912961054510399	ray
LAYERBANK_V3:98866:0xa5f78b2a0ab85429d2dfbf8b60abc70f4cec066c	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.014068590390908243101079013	1.051844891475345667176950848	ray
LAYERBANK_V3:98866:0xdea736937d464d288ec80138bcd1a2e109a200e3	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0xbfc5770631641719cd1cf809d8325b146aed19de	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0xb52b090837a035f93a84487e5a7d3719c32aa8a9	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0xea237441c92cae6fc17caaf9a7acb3f953be4bd1	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0xca59ca09e5602fae8b629dee83ffa819741f14be	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.000090042234751271650242638	1.001710181955241120537212246	ray
LAYERBANK_V3:98866:0x39d1f90ef89c52dda276194e9a832b484ee45574	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.063350889359165929226425641	11.709771709545966958601663332	ray
LAYERBANK_V3:98866:0x78add880a697070c1e765ac44d65323a0dcce913	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.030027333777551948875632232	1.055604818877056582091587005	ray
LAYERBANK_V3:98866:0xda6087e69c51e7d31b6dbad276a3c44703dfdcad	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.000326006600308837965945154	1.004902005392126330620092954	ray
LAYERBANK_V3:98866:0x593ccca4c4bf58b7526a4c164ceef4003c6388db	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.000830191677156135557839955	10.409463763840628924128748189	ray
LAYERBANK_V3:98866:0xe72fe64840f4ef80e3ec73a1c749491b5c938cb9	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.000204048771453139510079272	1.006658380680295715124911049	ray
LAYERBANK_V3:98866:0x9fbc367b9bb966a2a537989817a088afcaffdc4c	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
LAYERBANK_V3:98866:0x4772d2e014f9fc3a820c444e3313968e9a5c8121	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1.00029541483010971733047733	1.001163138442801316503912572	ray
LAYERBANK_V3:98866:0x222365ef19f7947e5484218551b56bb3965aa7af	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	1	1	ray
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
