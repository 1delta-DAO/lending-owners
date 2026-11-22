-- Generated from MERIDIAN/167000/2026-11.ndjson (25 rows)
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
MERIDIAN:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T19:00:00.000Z	archival-rpc	14321760	215.6	308	0.46466002276285334	0.46466002276285334	781.1130139853125	781.1130139853125	1	\N	\N	\N
MERIDIAN:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T19:00:00.000Z	archival-rpc	14321760	215.6	308	29274.52579439043	29274.52579439043	1751.5516708584205	1751.5516708584205	1	\N	\N	\N
MERIDIAN:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T19:00:00.000Z	archival-rpc	14321760	56	80	438.890072	438.890072	438.8270956635687	438.8270956635687	1	\N	\N	\N
MERIDIAN:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-21T19:00:00.000Z	archival-rpc	14321760	56	80	4443.233228	4443.233228	4442.595668464114	4442.595668464114	1	\N	\N	\N
MERIDIAN:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-21T19:00:00.000Z	archival-rpc	14321760	56	80	1345.88194	1345.88194	1343.6073995214	1343.6073995214	1	\N	\N	\N
MERIDIAN:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T08:00:00.000Z	archival-rpc	14345160	215.6	308	0.46665078623529344	0.46665078623529344	773.8649707163914	773.8649707163914	1	\N	\N	\N
MERIDIAN:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T08:00:00.000Z	archival-rpc	14345160	215.6	308	29407.767811740825	29407.767811740825	1759.5237992460084	1759.5237992460084	1	\N	\N	\N
MERIDIAN:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T08:00:00.000Z	archival-rpc	14345160	56	80	439.409478	439.409478	439.34810128411294	439.34810128411294	1	\N	\N	\N
MERIDIAN:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T08:00:00.000Z	archival-rpc	14345160	56	80	4448.491589	4448.491589	4447.870223694848	4447.870223694848	1	\N	\N	\N
MERIDIAN:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T08:00:00.000Z	archival-rpc	14345160	56	80	1347.474729	1347.474729	1345.19749670799	1345.19749670799	1	\N	\N	\N
MERIDIAN:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T10:00:00.000Z	archival-rpc	14348760	215.6	308	0.4669577007278907	0.4669577007278907	800.7265538097196	800.7265538097196	1	\N	\N	\N
MERIDIAN:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T10:00:00.000Z	archival-rpc	14348760	215.6	308	29428.317927888816	29428.317927888816	1760.753352562368	1760.753352562368	1	\N	\N	\N
MERIDIAN:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T10:00:00.000Z	archival-rpc	14348760	56	80	439.489439	439.489439	439.4280511151605	439.4280511151605	1	\N	\N	\N
MERIDIAN:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T10:00:00.000Z	archival-rpc	14348760	56	80	4449.301102	4449.301102	4448.679623622073	4448.679623622073	1	\N	\N	\N
MERIDIAN:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T10:00:00.000Z	archival-rpc	14348760	56	80	1347.719936	1347.719936	1345.50967530496	1345.50967530496	1	\N	\N	\N
MERIDIAN:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T09:00:00.000Z	archival-rpc	14346960	215.6	308	0.46680422202451943	0.46680422202451943	786.3459800907472	786.3459800907472	1	\N	\N	\N
MERIDIAN:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T09:00:00.000Z	archival-rpc	14346960	215.6	308	29418.041156314037	29418.041156314037	1760.1384733821121	1760.1384733821121	1	\N	\N	\N
MERIDIAN:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T09:00:00.000Z	archival-rpc	14346960	56	80	439.449457	439.449457	439.38807469984624	439.38807469984624	1	\N	\N	\N
MERIDIAN:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T09:00:00.000Z	archival-rpc	14346960	56	80	4448.896328	4448.896328	4448.274906160905	4448.274906160905	1	\N	\N	\N
MERIDIAN:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T09:00:00.000Z	archival-rpc	14346960	56	80	1347.597327	1347.597327	1345.38726738372	1345.38726738372	1	\N	\N	\N
MERIDIAN:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T11:00:00.000Z	archival-rpc	14350560	215.6	308	0.46711122235287933	0.46711122235287933	800.9898085788791	800.9898085788791	1	\N	\N	\N
MERIDIAN:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T11:00:00.000Z	archival-rpc	14350560	215.6	308	29438.598127333393	29438.598127333393	1761.368436838724	1761.368436838724	1	\N	\N	\N
MERIDIAN:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T11:00:00.000Z	archival-rpc	14350560	56	80	439.529425	439.529425	439.468031529916	439.468031529916	1	\N	\N	\N
MERIDIAN:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T11:00:00.000Z	archival-rpc	14350560	56	80	4449.705912	4449.705912	4449.084377078212	4449.084377078212	1	\N	\N	\N
MERIDIAN:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T11:00:00.000Z	archival-rpc	14350560	56	80	1347.842555	1347.842555	1345.6320932098	1345.6320932098	1	\N	\N	\N
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
