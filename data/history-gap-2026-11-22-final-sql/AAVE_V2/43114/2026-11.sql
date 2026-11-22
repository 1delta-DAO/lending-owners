-- Generated from AAVE_V2/43114/2026-11.ndjson (14 rows)
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
AAVE_V2:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.033373657699227316	6.927128084852631	530.1991557077853	17.03139253021673	891639.8554509759	28641.819230170255	0.03212263231064713	\N	\N	\N
AAVE_V2:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	2.2758554225186205	19.550862963933163	963455.7506423199	747709.5006475747	963356.6110455788	747632.561339958	0.7760704112763759	\N	\N	\N
AAVE_V2:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.2184113767823483	19.143559827435077	558021.5992160001	236813.189798	557078.542713325	236412.97550724138	0.4243799704719564	\N	\N	\N
AAVE_V2:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.110776861786785	20.723967527227234	942259.000527	336724.309254	942127.3857898065	336677.2756024834	0.35735854904614556	\N	\N	\N
AAVE_V2:43114:0x63a72806098bd3d9520cc43356dd78afe5d386d9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	1986.9303937189536	0	194552.296300689	0	0	\N	\N	\N
AAVE_V2:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.000003274006551105	20	67.49333256999999	0.11052726	4075740.323273418	6674.443137560502	0.0016376026459408836	\N	\N	\N
AAVE_V2:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.08479725844557319	8.837894238485624	34768.55907855353	2224.174715386617	230406.7200578373	14739.316629428871	0.06397086259345634	\N	\N	\N
AAVE_V2:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.033373657699227316	6.927128084852631	530.1990210669184	17.03125788934987	891286.8227723745	28630.259824828485	0.03212238652398472	\N	\N	\N
AAVE_V2:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T19:00:00.000Z	archival-rpc	101004130	2.2758554225186205	19.550862963933163	963439.0678315389	747692.8178367935	963339.9299514589	747615.8802458381	0.7760665337348874	\N	\N	\N
AAVE_V2:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.2184113767823483	19.143559827435077	558016.425542	236808.016124	557073.377782834	236407.81057675043	0.42437463358536254	\N	\N	\N
AAVE_V2:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.110776861786785	20.723967527227234	942251.03678	336716.345507	942115.8331787324	336668.03007858316	0.35735311754888277	\N	\N	\N
AAVE_V2:43114:0x63a72806098bd3d9520cc43356dd78afe5d386d9	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	1986.9303937189536	0	195376.7348191526	0	0	\N	\N	\N
AAVE_V2:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.000003274006551105	20	67.49333005	0.11052474	4050558.2082867096	6633.053851307999	0.001637565370061334	\N	\N	\N
AAVE_V2:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.08479725844557319	8.837894238485624	34768.53664537831	2224.152282211403	230199.57447938624	14725.926321390905	0.06397025865358223	\N	\N	\N
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
