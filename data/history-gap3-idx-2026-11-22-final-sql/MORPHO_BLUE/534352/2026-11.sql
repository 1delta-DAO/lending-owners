-- Generated from MORPHO_BLUE/534352/2026-11.ndjson (7 rows)
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
MORPHO_BLUE_084A1E5D5C80E16ED928935FFD063119B08BF4D6839D44C72923CAED271DAF3B:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.000001000062	0.000001000434485353669231002332	assets_per_share
MORPHO_BLUE_181389C6839C5ED785F73BA432D830534280C7833D6290C271EE33D44CAA4253:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_19FD7555891F7CF49099EFAE1EFD1F0FE7522D5B759ED27A8417727C792DADE5:534352:0x5300000000000000000000000000000000000004	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.000001	0.000001	assets_per_share
MORPHO_BLUE_7514C69D6D827D829B2655A6F13F0E6841D28EECE3294141039F81DBEFEC3FDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.0000010000001	0.000001000000477694318574140014	assets_per_share
MORPHO_BLUE_829550C087B1E5368CCF2E31D6FD3BE9320C836EC15B61EDAF182FA41DD2950A:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.000001000518194115778571091303	0	assets_per_share
MORPHO_BLUE_D1FBAFAD5913D8A1A475824BC5003DAD3337958CE7FAE4C7B9EBB5617533C80C:534352:0x5300000000000000000000000000000000000004	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.000001	0.000001	assets_per_share
MORPHO_BLUE_FFC5295C9CD29FF2BB615743DAC6E0A866A52F64144B6033F82BBC2C48420F38:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	\N	\N	\N	\N	\N	\N	\N	0.0000010013	0	assets_per_share
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
