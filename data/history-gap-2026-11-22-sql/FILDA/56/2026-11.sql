-- Generated from FILDA/56/2026-11.ndjson (10 rows)
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
FILDA:56:0xab9cd8ac3d8a54d7faee07b4aa4914a57f4db578	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.360852509473375	23.105022890135274	0.6315580783054807	0.009860545343427061	346.46953449660657	5.409444788017381	0.015613046024023108	\N	\N	\N
FILDA:56:0x8aee1d27d906895cc771380ba5a49bbd421dd5a0	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	19.98564265122127	10.1	0	10.1	0	0	\N	\N	\N
FILDA:56:0x5480c79f4a02657e33586751a66c331f0230bb2d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	19.985644051701	15.598795387847629	9.2708842321e-8	15.572433423642167	9.255216437747751e-8	5.94333344440338e-9	\N	\N	\N
FILDA:56:0x5b07f2582d0cc26e400d56266aebb201c93560ed	2026-11-21T20:00:00.000Z	archival-rpc	134947363	36.47707436584824	103.03383518213138	29.356347721592353	12.215947182324246	29.352247226942602	12.21424085882182	0.41612625992091995	\N	\N	\N
FILDA:56:0x891672f0b855b55b20ea3732c1fbdf389e712829	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	19.98564265122127	0.004269363070127249	0	7.179819563526509	0	0	\N	\N	\N
FILDA:56:0xab9cd8ac3d8a54d7faee07b4aa4914a57f4db578	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.360936538257306	23.103402535085138	0.6315611128986994	0.009863579936645835	339.88250110473524	5.308208739019365	0.015617775913046002	\N	\N	\N
FILDA:56:0x8aee1d27d906895cc771380ba5a49bbd421dd5a0	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	19.983423591085625	10.1	0	10.1	0	0	\N	\N	\N
FILDA:56:0x5480c79f4a02657e33586751a66c331f0230bb2d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	19.983424991565357	15.598795387868394	9.2733273067e-8	15.572433423662897	9.257655383551677e-8	5.944899638796543e-9	\N	\N	\N
FILDA:56:0x5b07f2582d0cc26e400d56266aebb201c93560ed	2026-11-22T08:00:00.000Z	archival-rpc	135043334	36.53303053354762	103.09796454954778	29.370990045782225	12.233173446077032	29.36688750589263	12.231464716410084	0.4165053144959871	\N	\N	\N
FILDA:56:0x891672f0b855b55b20ea3732c1fbdf389e712829	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	19.983423591085625	0.004269363070127249	0	7.080049203165335	0	0	\N	\N	\N
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
