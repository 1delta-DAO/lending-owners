-- Generated from AVALON_PUMPBTC/1/2026-11.ndjson (18 rows)
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
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00100528	0	59.928540140152805	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00388735	0	231.24207191057604	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	75.150981524	3.009111988	0.040040887384006	\N	\N	\N
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00100528	0	59.928540140152805	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00388735	0	232.67995561940603	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	75.61818854204846	3.0278193715946955	0.040040887384006	\N	\N	\N
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00100528	0	59.928540140152805	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00388735	0	231.9705161221438	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	74.9868732218642	3.0025409459554	0.040040887384006	\N	\N	\N
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00100528	0	61.00550589997697	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00388735	0	235.9517022950745	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	76.601678394	3.0671991779999996	0.040040887384006	\N	\N	\N
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00100528	0	59.01654823610487	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00388735	0	228.25898768415232	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	74.09272915393737	2.9667386240264646	0.040040887384006	\N	\N	\N
AVALON_PUMPBTC:1:0xf469fbd2abcd6b9de8e169d128226c0fc90a012e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00100528	0	61.00550589997697	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00388735	0	235.9517022950745	0	0	\N	\N	\N
AVALON_PUMPBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.004464842411589943	0.15972909944733732	0.00125222	0.00005014	76.601678394	3.0671991779999996	0.040040887384006	\N	\N	\N
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
