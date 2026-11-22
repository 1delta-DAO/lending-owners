-- Generated from AAVE_V3/56/2026-11.ndjson (16 rows)
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
AAVE_V3:56:0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.008921700004297393	0.5268436663965811	268880.591544669	9106.632240134219	398263.2433900483	13488.652607764403	0.03386868567871824	\N	\N	\N
AAVE_V3:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.002443519185458854	0.217974479972056	118190.12452382362	1656.1562648757995	64838498.36223331	908558.86395235	0.014012645062760447	\N	\N	\N
AAVE_V3:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.005414755830172293	0.6596180161928162	1140.6479573276063	11.704373123577922	68703020.7090786	704972.8042120215	0.010261161691815752	\N	\N	\N
AAVE_V3:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.5016627479206203	1.3580678712164442	8021.516975948285	3486.0156294608605	13489844.636557681	5862458.358318135	0.4345830894472117	\N	\N	\N
AAVE_V3:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	3.3992026783145293	4.345625347956076	12241426.838057686	10639418.789880339	12239716.955556946	10637932.675863769	0.869132245009477	\N	\N	\N
AAVE_V3:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.3209405510769447	3.5908375722356594	65770296.46963799	47234358.38856855	65659144.66860431	47154532.32289187	0.7181715899725902	\N	\N	\N
AAVE_V3:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T20:00:00.000Z	archival-rpc	134947363	20.051979763587738	40.461887899861935	434453.95188026835	430745.2714629973	432038.38790781406	428350.32775366306	0.9914635822709857	\N	\N	\N
AAVE_V3:56:0x26c5e01524d2e6280a48f2c50ff6de7e52e9611c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	7.33377723116e-7	0.004776630175165006	873.7778167044297	0.26831063365318963	1832521.731203818	562.7117757887155	0.00030706963317649695	\N	\N	\N
AAVE_V3:56:0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.008921700004297393	0.5268436663965811	268880.6425686582	9106.697963268887	391950.0014787588	13274.92468803669	0.033868923684022764	\N	\N	\N
AAVE_V3:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.002108147254714085	0.2024642016010315	117305.78669319439	1526.7999513216278	63129574.25821836	821666.4635351261	0.0130155552795948	\N	\N	\N
AAVE_V3:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.005495239044544756	0.6615238396323225	1134.8174248306307	11.783576160516917	66986973.990957245	695571.016547282	0.010383675737333337	\N	\N	\N
AAVE_V3:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.49747547401803693	1.3523882406428986	8042.530523080231	3480.5205989630294	13337238.104621993	5771881.352914374	0.43276436302911475	\N	\N	\N
AAVE_V3:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	3.257752421495457	4.25424786426254	12238814.066681806	10413397.511703737	12237104.549132973	10411942.968339302	0.8508502094212322	\N	\N	\N
AAVE_V3:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.31034469445253	3.582631518589023	65925946.525225885	47237695.97371012	65814531.67559826	47157864.26751455	0.7165266251525885	\N	\N	\N
AAVE_V3:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T08:00:00.000Z	archival-rpc	135043334	20.392611185282213	41.08469100247202	434041.38546953	430987.1920230682	431415.4350874394	428379.7195113286	0.9929633589129804	\N	\N	\N
AAVE_V3:56:0x26c5e01524d2e6280a48f2c50ff6de7e52e9611c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	7.33377723116e-7	0.004776630175165006	873.7778167132079	0.2683106512096377	1810997.386618306	556.1023395744955	0.0003070696532659891	\N	\N	\N
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
