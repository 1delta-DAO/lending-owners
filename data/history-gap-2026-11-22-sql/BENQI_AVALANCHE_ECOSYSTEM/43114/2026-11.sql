-- Generated from BENQI_AVALANCHE_ECOSYSTEM/43114/2026-11.ndjson (14 rows)
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
BENQI_AVALANCHE_ECOSYSTEM:43114:0x6b35eb18bca06bd7d66a428eeb45ac7d200c1e4e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0.00003851319263503683	24014.955386	0.074116	24011.600977031685	0.07410564747712	0.0000030862435015476817	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x0ebfebd41e1ea83be5e911cdcd2730a0ccee344d	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	559044859597.1798	0	45841.67848696875	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x4036cb0d6bf6b5f17aa4e05191f86d4b1655b0d9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	12351.95956429916	0	238.46273168210772	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x545356e396350d40cdea888ad73534517399bf96	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	80076105.6919139	0	122966.46942261682	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0xb7cfb8ae67e20059021a0d20fc30311a6c67c734	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0.000024508395313205256	5763.803951	0.011447	5761.712900564617	0.011442847142870001	0.0000019860148085040236	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x0ffac5aae14e28e79c5ccc7a335d8c70ee458a3a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0.000030810554108029464	0.01195964691906278	1.17876628495e-7	722.6365988512441	0.00712244821909456	0.000009856196365388805	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x51758d811696acb994aa993bd3dd088b6c3320f3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	43295.68325571826	0	12846.00240470463	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x6b35eb18bca06bd7d66a428eeb45ac7d200c1e4e	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0.00003851319263503683	24014.955386	0.074116	24011.509480051664	0.07410536509516	0.0000030862435015476817	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x0ebfebd41e1ea83be5e911cdcd2730a0ccee344d	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	559044859597.1798	0	45841.67848696875	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x4036cb0d6bf6b5f17aa4e05191f86d4b1655b0d9	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	12351.95956429916	0	239.7515351430467	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x545356e396350d40cdea888ad73534517399bf96	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	80776105.6919139	0	124016.36282985234	0	0	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0xb7cfb8ae67e20059021a0d20fc30311a6c67c734	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0.000024508395313205256	5763.803951	0.011447	5762.144667118586	0.01144370463764	0.0000019860148085040236	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x0ffac5aae14e28e79c5ccc7a335d8c70ee458a3a	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0.000030810554108029464	0.01195964691906278	1.17876628495e-7	720.0296626544344	0.007096753744026765	0.000009856196365388805	\N	\N	\N
BENQI_AVALANCHE_ECOSYSTEM:43114:0x51758d811696acb994aa993bd3dd088b6c3320f3	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	43295.68325571826	0	12846.00240470463	0	0	\N	\N	\N
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
