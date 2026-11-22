-- Generated from GRANARY/56/2026-11.ndjson (12 rows)
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
GRANARY:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.030636516467933927	0.42451714070524	806.9990294543428	68.584328014007	806.9159892542119	68.57727068665436	0.08498687794008959	\N	\N	\N
GRANARY:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.00165352943830101	0.09862374843166237	576.9947985974741	11.382067315858473	576.914203964006	11.380477468695794	0.01972646433473118	\N	\N	\N
GRANARY:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.0132329842362188	0.27900015007605916	1116.0457229961405	62.27566582805897	1114.159605724277	62.17041995280955	0.055800281784937525	\N	\N	\N
GRANARY:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	249.93271821773337	298.62410584334197	0.006855315505201735	0.006805069443349326	412.9064362895902	409.8800369471643	0.9926704960823054	\N	\N	\N
GRANARY:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.5078022552658926	3.0484607867356113	0.002539594954479814	0.000504330933440711	4.270855684584333	0.848137074062731	0.19858715365262383	\N	\N	\N
GRANARY:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.1216686797526423	6.231205625802181	0.702881984331504	0.28157672393664496	385.5974648773231	154.4715518945841	0.4006031314125181	\N	\N	\N
GRANARY:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.030636516467933927	0.42451714070524	806.9994282939404	68.58472685360465	806.9163880527689	68.57766948521142	0.0849873301627959	\N	\N	\N
GRANARY:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.00165352943830101	0.09862374843166237	576.994813974774	11.382082693158438	576.9142193391581	11.380492843847858	0.019726490459680383	\N	\N	\N
GRANARY:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.0132329842362188	0.27900015007605916	1116.0459610091998	62.275903841118065	1114.1598433350944	62.17065756362658	0.05580048314928198	\N	\N	\N
GRANARY:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	249.93271821773337	298.62410584334197	0.006882254522526474	0.006832008460674065	406.2516089479639	403.2856414145013	0.9926991857554894	\N	\N	\N
GRANARY:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.5078022552658926	3.0484607867356113	0.0025396160159324548	0.000504351994893352	4.211543046258791	0.8363863370029796	0.19859379990095563	\N	\N	\N
GRANARY:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.1216686797526423	6.231205625802181	0.7029060204596035	0.28160076006474444	378.27765420653117	151.54696622233544	0.4006236280073635	\N	\N	\N
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
