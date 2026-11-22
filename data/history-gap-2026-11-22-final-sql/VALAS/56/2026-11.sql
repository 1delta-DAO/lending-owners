-- Generated from VALAS/56/2026-11.ndjson (20 rows)
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
VALAS:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	54	108	1858.746166021376	1858.746166021376	1019698.6484864184	1019698.6484864184	1	\N	\N	\N
VALAS:56:0xe9e7cea3dedca5984780bafc599bd69add087d56	2026-11-21T20:00:00.000Z	archival-rpc	134947363	532	1064	27041225765315.36	27041225765315.36	27041225765315.36	27041225765315.36	1	\N	\N	\N
VALAS:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	32	64	49742.460661972116	49742.460661972116	49735.51263506685	49735.51263506685	1	\N	\N	\N
VALAS:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	32	64	22559.476451682905	22559.476451682905	22521.35093647956	22521.35093647956	1	\N	\N	\N
VALAS:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	39.5	79	14491.111424005674	14491.111424005674	14489.620288640144	14489.620288640144	1	\N	\N	\N
VALAS:56:0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82	2026-11-21T20:00:00.000Z	archival-rpc	134947363	153.5	307	15445.591487080115	15445.591487080115	22877.855654748197	22877.855654748197	1	\N	\N	\N
VALAS:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	54	108	13.03310454528234	13.03310454528234	21917.868649413176	21917.868649413176	1	\N	\N	\N
VALAS:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	154	308	6.284929917807912	6.284929917807912	378551.2151443313	378551.2151443313	1	\N	\N	\N
VALAS:56:0x14016e85a25aeb13065688cafb43044c2ef86784	2026-11-21T20:00:00.000Z	archival-rpc	134947363	532	1064	5277432837250.1875	5277432837250.1875	5263500414559.847	5263500414559.847	1	\N	\N	\N
VALAS:56:0x40af3827f39d0eacbf4a168f8d4ee67c121d11c9	2026-11-21T20:00:00.000Z	archival-rpc	134947363	32	64	6406.114456051004	6406.114456051004	6389.202313887029	6389.202313887029	1	\N	\N	\N
VALAS:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	54	108	1861.4712259948528	1861.4712259948528	1001773.9900447428	1001773.9900447428	1	\N	\N	\N
VALAS:56:0xe9e7cea3dedca5984780bafc599bd69add087d56	2026-11-22T08:00:00.000Z	archival-rpc	135043334	532	1064	27178914995517.934	27178914995517.934	27178914995517.934	27178914995517.934	1	\N	\N	\N
VALAS:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	32	64	49786.085739621245	49786.085739621245	49779.131619165135	49779.131619165135	1	\N	\N	\N
VALAS:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	32	64	22579.261335351934	22579.261335351934	22541.10238369519	22541.10238369519	1	\N	\N	\N
VALAS:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	39.5	79	14506.664498201988	14506.664498201988	14505.171762425123	14505.171762425123	1	\N	\N	\N
VALAS:56:0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82	2026-11-22T08:00:00.000Z	archival-rpc	135043334	153.5	307	15510.456850822593	15510.456850822593	22609.748056012602	22609.748056012602	1	\N	\N	\N
VALAS:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	54	108	13.052031029749132	13.052031029749132	21644.685723369577	21644.685723369577	1	\N	\N	\N
VALAS:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	154	308	6.307167100070432	6.307167100070432	372304.8564856997	372304.8564856997	1	\N	\N	\N
VALAS:56:0x14016e85a25aeb13065688cafb43044c2ef86784	2026-11-22T08:00:00.000Z	archival-rpc	135043334	532	1064	5293811533935.633	5293811533935.633	5280261811562.063	5280261811562.063	1	\N	\N	\N
VALAS:56:0x40af3827f39d0eacbf4a168f8d4ee67c121d11c9	2026-11-22T08:00:00.000Z	archival-rpc	135043334	32	64	6411.721629245299	6411.721629245299	6395.31057126638	6395.31057126638	1	\N	\N	\N
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
