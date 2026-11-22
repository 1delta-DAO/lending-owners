-- Generated from AVALON_USDX/56/2026-11.ndjson (24 rows)
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
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	49004414.23463123	0	39506378.66767501	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.8157e-14	6.05661958892e-7	20000103.536928218	1.0901972772093214	17300089.559442908	0.943020644786063	5.450958167273383e-8	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	38.5	70	14.25126511100366	20.65912128078501	14.227180472966063	20.62420736582048	1.4496341987795685	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	38.5	70	118.88407845806923	158.6368509744425	118.86747272999021	158.6146925790984	1.3343826442696798	\N	\N	\N
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	49004414.23463123	0	39506378.66767501	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.8157e-14	6.05661958892e-7	20000103.536928218	1.0901972772183663	17300089.559442908	0.9430206447938869	5.450958167318607e-8	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	38.5	70	14.256914751694955	20.67854595051755	14.232820565764591	20.643599207861175	1.4504222204217885	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	38.5	70	118.93306990994661	158.78702374404736	118.9164573387416	158.7648443725708	1.3350956455111875	\N	\N	\N
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x7788a3538c5fc7f9c7c8a74eac4c898fc8d87d92	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0xf3527ef8de265eaa3716fb312c12847bfba66cef	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDX:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
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
