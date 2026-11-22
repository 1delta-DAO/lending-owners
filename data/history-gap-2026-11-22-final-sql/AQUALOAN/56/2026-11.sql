-- Generated from AQUALOAN/56/2026-11.ndjson (66 rows)
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
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	71.1	79	2722.944661036927	2910.243386023476	2722.664470031306	2909.9439219790543	1.068785358610712	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-21T20:00:00.000Z	archival-rpc	134947363	245.6	307	1.5576018274497259	1.5894929141870635	13.459033469761831	13.734600175078091	1.0204744795334204	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	57.6	64	1682.0062661350687	1923.57232584061	1681.771323499815	1923.3036412581366	1.1436178119957985	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	245.6	307	0.00708319	0.00857214	427.7347406199807	517.6484153973227	1.2102089595224752	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	57.6	64	16292.180263868635	16369.854528996519	16264.646479222698	16342.189474842515	1.0047675795301714	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-21T20:00:00.000Z	archival-rpc	134947363	307	307	0.04882520283922033	0.04902420184123396	4.780769049457127	4.800254237728283	1.0040757434775833	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	276.3	307	0.7073336051566314	0.7388661319736575	1189.5281738341246	1242.556658226191	1.044579427001837	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T20:00:00.000Z	archival-rpc	134947363	57.6	64	135.15768525036094	135.79474214728722	134.40620852036892	135.03972338094832	1.00471343450242	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	276.3	307	0.6192009580926587	0.6890510447672218	339.6904814927367	378.00988210845907	1.112806812976718	\N	\N	\N
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	71.1	79	2725.5711932176414	2913.3945314566404	2725.290731941859	2913.0947431593536	1.0689115509829212	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-22T08:00:00.000Z	archival-rpc	135043334	245.6	307	1.562671890360002	1.5961914773443255	13.380580067802786	13.667595864433064	1.0214501759397498	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	57.6	64	1683.3230645250064	1925.2594846454965	1683.0879379593537	1924.9905644006813	1.1437254827781729	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	245.6	307	0.00710625	0.00860826	420.4704097923427	509.3429881863194	1.2113646437994723	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	57.6	64	16304.937685169338	16384.212473380234	16277.382340481403	16356.523154300221	1.004862011112315	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-22T08:00:00.000Z	archival-rpc	135043334	307	307	0.049022262026057584	0.04923080339908729	4.680949516272539	4.700862339525928	1.004254013674825	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	276.3	307	0.7099133278147564	0.741979918392969	1177.2766120735453	1230.4538741949268	1.0451697261085653	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T08:00:00.000Z	archival-rpc	135043334	57.6	64	135.2634966411439	135.91384725801967	134.44515248646496	135.09156848210864	1.0048080275390276	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	276.3	307	0.6214592513928485	0.6919548966188115	334.44605816311133	372.3841701320722	1.1134356678542707	\N	\N	\N
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1af3f329e8be154074d8769d1ffa4ee058b1dbc3	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xfb6115445bff7b52feb98650c87f44907e58f802	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xba2ae424d960c26247dd6c32edc70b295c744c43	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AQUALOAN:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
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
