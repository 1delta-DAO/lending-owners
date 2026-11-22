-- Generated from COMPOUND_V3_USDC/534352/2026-11.ndjson (18 rows)
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
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-21T19:00:00.000Z	archival-rpc	35813204	0	0	31.147487972074206	0	52360.23547555156	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-21T19:00:00.000Z	archival-rpc	35813204	0	0	0.06436057566312231	0	134.979569497763	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-21T19:00:00.000Z	archival-rpc	35813204	0	10.055109075342466	17685.947496	12062.510197	17683.4097393938	12060.779347411832	0.6819236987290443	\N	\N	\N
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-21T20:00:00.000Z	archival-rpc	35813499	0	0	31.147487972074206	0	52380.961708637165	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-21T20:00:00.000Z	archival-rpc	35813499	0	0	0.06436057566312231	0	134.979569497763	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-21T20:00:00.000Z	archival-rpc	35813499	0	10.055109075342466	17685.947496	12062.646764	17683.47712285376	12060.961853500005	0.6819236987290443	\N	\N	\N
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-22T09:00:00.000Z	archival-rpc	35817884	0	0	31.147487972074206	0	52468.89552656819	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T09:00:00.000Z	archival-rpc	35817884	0	0	0.06436057566312231	0	135.50098044371902	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T09:00:00.000Z	archival-rpc	35817884	0	10.055109075342466	17685.947496	12064.43698	17683.47712285376	12062.751819442634	0.6819236987290443	\N	\N	\N
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-22T08:00:00.000Z	archival-rpc	35817296	0	0	31.147487972074206	0	51653.0788726556	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T08:00:00.000Z	archival-rpc	35817296	0	0	0.06436057566312231	0	133.39413303670608	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T08:00:00.000Z	archival-rpc	35817296	0	10.055109075342466	17685.947496	12064.29808	17683.47712285376	12062.612938844186	0.6819236987290443	\N	\N	\N
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-22T10:00:00.000Z	archival-rpc	35818485	0	0	31.147487972074206	0	53410.87782647419	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T10:00:00.000Z	archival-rpc	35818485	0	0	0.06436057566312231	0	137.66339093747334	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T10:00:00.000Z	archival-rpc	35818485	0	10.055109075342466	17685.947496	12064.57523	17683.47712285376	12062.890050131875	0.6819236987290443	\N	\N	\N
COMPOUND_V3_USDC:534352:0x5300000000000000000000000000000000000004	2026-11-22T11:00:00.000Z	archival-rpc	35818810	0	0	31.147487972074206	0	53410.87782647419	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T11:00:00.000Z	archival-rpc	35818810	0	0	0.06436057566312231	0	137.66339093747334	0	0	\N	\N	\N
COMPOUND_V3_USDC:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	0	10.055109075342466	17685.947496	12064.713022	17683.47712285376	12063.027822885088	0.6819236987290443	\N	\N	\N
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
