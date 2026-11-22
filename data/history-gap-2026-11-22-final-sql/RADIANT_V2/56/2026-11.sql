-- Generated from RADIANT_V2/56/2026-11.ndjson (16 rows)
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
RADIANT_V2:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.3903246316604207	3.1484927375428216	13000.43935513678	2305.201485943188	12978.468612626599	2301.305695431944	0.17731719851701386	\N	\N	\N
RADIANT_V2:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.00123863211428258	0.16291751512537483	7.032692629726849	0.06683595123978625	3858.0992396088113	36.6658613184359	0.009503607616416212	\N	\N	\N
RADIANT_V2:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.723523111e-9	0.000202574096468932	0.05552075157298369	7.87294634893e-7	3344.1022013830316	0.047419994274066075	0.000014180186913681774	\N	\N	\N
RADIANT_V2:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.009211752259598496	0.39182802902120417	0.06561132533219481	0.001931330475767084	110.33905279809203	3.2479327960116953	0.029435931464402224	\N	\N	\N
RADIANT_V2:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.000207017605181489	0.07250924060327225	17045.475646372164	69.52272141796882	17043.094734333878	69.51301048424116	0.0040786612741290995	\N	\N	\N
RADIANT_V2:56:0xa2e3356610840701bdf5611a53974510ae27e2e1	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.8982641616321336	9.742340995962248	1.0694647176876462	0.35779861795399964	2000.5955622042886	669.3164490636922	0.3345585993034137	\N	\N	\N
RADIANT_V2:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T20:00:00.000Z	archival-rpc	134947363	6.61293228765e-7	0.002925390977674872	419.51016710611816	0.11156782950120463	417.17769057700815	0.11094751236917792	0.0002659478559740907	\N	\N	\N
RADIANT_V2:56:0x26c5e01524d2e6280a48f2c50ff6de7e52e9611c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.2354583867542135	0	493.81273164920117	0	0	\N	\N	\N
RADIANT_V2:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.3903246316604207	3.1484927375428216	13000.538780707848	2305.300911514256	12978.567870168452	2301.4049529737968	0.17732349023374383	\N	\N	\N
RADIANT_V2:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.00123863211428258	0.16291751512537483	7.0326927788879345	0.06683610040087182	3784.7314572913506	35.968682213623175	0.009503628624516779	\N	\N	\N
RADIANT_V2:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.723523111e-9	0.000202574096468932	0.055520751572985874	7.87294637078e-7	3277.32643172366	0.04647310150796744	0.000014180186953035868	\N	\N	\N
RADIANT_V2:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.009211752259598496	0.39182802902120417	0.06561133569863777	0.001931340842210042	108.80580484758543	3.2028168994590382	0.02943608481133453	\N	\N	\N
RADIANT_V2:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.000207017605181489	0.07250924060327225	17045.475715427536	69.52279047334194	17043.094803379605	69.51307952996862	0.004078665308848975	\N	\N	\N
RADIANT_V2:56:0xa2e3356610840701bdf5611a53974510ae27e2e1	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.8982641616321336	9.742340995962248	1.0695124701070058	0.35784637037335915	1972.599221744297	660.0086407892794	0.3345883104453717	\N	\N	\N
RADIANT_V2:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T08:00:00.000Z	archival-rpc	135043334	6.61293228765e-7	0.002925390977674872	419.5101671105891	0.1115678339721571	416.97213059957005	0.11089284857662554	0.0002659478666288108	\N	\N	\N
RADIANT_V2:56:0x26c5e01524d2e6280a48f2c50ff6de7e52e9611c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.2354583867542135	0	488.01253008829946	0	0	\N	\N	\N
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
