-- Generated from BENQI/43114/2026-11.ndjson (15 rows)
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
BENQI:43114:0x5c0401e81bc07ca70fad469b451682c0d747ef1c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	233808907.284259586203521378	\N	exchange_rate
BENQI:43114:0xe194c4c5ac32a3c9ffdb358d9bfd523a0b6d1568	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.02024890950685324	\N	exchange_rate
BENQI:43114:0x334ad834cd4481bb02d09615e7c11a00579a7909	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	214153223.79628892299758208	\N	exchange_rate
BENQI:43114:0xc9e5999b8e75c3feb117f6f73e664b9f3c8ca65c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.000434491820819539	\N	exchange_rate
BENQI:43114:0x4e9f683a27a6bdad3fc2764003759277e93696e6	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	202732489.403954601689899107	\N	exchange_rate
BENQI:43114:0x835866d37afb8cb8f8334dccdaf66cf01832ff5d	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	250429511.81957734707086325	\N	exchange_rate
BENQI:43114:0xbeb5d47a3f720ec0a390d04b4d41ed7d9688bc7f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.000278723884284159	\N	exchange_rate
BENQI:43114:0x35bd6aeda81a7e5fc7a7832490e71f757b0cd9ce	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	200015736.95555919078469745	\N	exchange_rate
BENQI:43114:0xb715808a78f6041e46d61cb123c9b4a27056ae9c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.000256173874907919	\N	exchange_rate
BENQI:43114:0xd8fcda6ec4bdc547c0827b8804e89acd817d56ef	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.000255554488147607	\N	exchange_rate
BENQI:43114:0xf362fea9659cf036792c9cb02f8ff8198e21b4cb	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	201633964.036811541416206493	\N	exchange_rate
BENQI:43114:0x89a415b3d20098e6a6c8f7a59001c67bd3129821	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.020529511584474378	\N	exchange_rate
BENQI:43114:0x872670ccae8c19557cc9443eff587d7086b8043a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	237269591.375422050029557014	\N	exchange_rate
BENQI:43114:0x190d94613a09ad7931fcd17cd6a8f9b6b47ad414	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.000213520839561654	\N	exchange_rate
BENQI:43114:0x7fa9442f28948e948e86c0258e361f1208699b41	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	0.00020396238929366	\N	exchange_rate
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
