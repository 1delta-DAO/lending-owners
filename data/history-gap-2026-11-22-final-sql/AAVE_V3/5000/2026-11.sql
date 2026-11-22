-- Generated from AAVE_V3/5000/2026-11.ndjson (20 rows)
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
AAVE_V3:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0.009633020665184303	0.17742733636659483	105.3931559728065	6.733063914974078	177240.45265909025	11323.043560632203	0.06388521012418814	\N	\N	\N
AAVE_V3:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	432325.4456997198	0	160532.20422012435	0	0	\N	\N	\N
AAVE_V3:5000:0x779ded0c9e1022225f8e0630b35a9b54be713736	2026-11-21T20:00:00.000Z	archival-rpc	103580444	3.0273626329296746	3.914548173320769	31247773.46364	26851346.645361	31194964.72648645	26805967.86953034	0.8593043173653734	\N	\N	\N
AAVE_V3:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-21T20:00:00.000Z	archival-rpc	103580444	1.8238981891806632	3.0011505523597446	348770.766773	235513.804266	348722.0504722972	235480.90769782013	0.6752681896051393	\N	\N	\N
AAVE_V3:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0.001568543094086449	7.000087872459613	7017256.641822453	2096.6314557131986	7005397.478097773	2093.0881485530435	0.0002987822111589013	\N	\N	\N
AAVE_V3:5000:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	322980.38124037045	0	406097.760991066	0	0	\N	\N	\N
AAVE_V3:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	155.94767357	0	9334353.16223577	0	0	\N	\N	\N
AAVE_V3:5000:0x051665f2455116e929b9972c36d23070f5054ce0	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	16965630.153294	0	19542509.348799855	0	0	\N	\N	\N
AAVE_V3:5000:0x93e855643e940d025be2e529272e4dbd15a2cf74	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	15.313343808745556	0	27938.579890303423	0	0	\N	\N	\N
AAVE_V3:5000:0xfc421ad3c883bf9e7c4f42de845c4e4405799e73	2026-11-21T20:00:00.000Z	archival-rpc	103580444	1.5830617616905804	3.6197694001505387	1397542.9935739748	679128.5435929038	1397542.9935739748	679128.5435929038	0.4859446519467353	\N	\N	\N
AAVE_V3:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.009633104944164184	0.17742811251785232	105.39317886621318	6.733084371001096	180725.39927502192	11545.712676967902	0.06388539033961695	\N	\N	\N
AAVE_V3:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	432325.52066318254	0	171174.1927886985	0	0	\N	\N	\N
AAVE_V3:5000:0x779ded0c9e1022225f8e0630b35a9b54be713736	2026-11-22T11:00:00.000Z	archival-rpc	103607444	3.034892469915872	3.919413398830518	29169618.09775	25096493.154661	29121779.92406969	25055334.905887358	0.8603641319732197	\N	\N	\N
AAVE_V3:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T11:00:00.000Z	archival-rpc	103607444	1.7961014393061066	2.978193535906306	348782.733267	233719.840137	348734.0152948173	233687.19414972965	0.670101521218606	\N	\N	\N
AAVE_V3:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.002157733657976637	7.000120879350019	5101434.936960234	2096.8827836609744	5093068.58366362	2093.4438958957703	0.00041103783730905196	\N	\N	\N
AAVE_V3:5000:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	322980.38124037045	0	406154.0629311238	0	0	\N	\N	\N
AAVE_V3:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	155.94767362	0	9465604.861819925	0	0	\N	\N	\N
AAVE_V3:5000:0x051665f2455116e929b9972c36d23070f5054ce0	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	16965630.153294	0	19545598.790050767	0	0	\N	\N	\N
AAVE_V3:5000:0x93e855643e940d025be2e529272e4dbd15a2cf74	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	15.313343808745556	0	28487.90912751741	0	0	\N	\N	\N
AAVE_V3:5000:0xfc421ad3c883bf9e7c4f42de845c4e4405799e73	2026-11-22T11:00:00.000Z	archival-rpc	103607444	1.5830617616905804	3.6197694001505387	1397582.3894109486	679170.6388824191	1397582.3894109486	679170.6388824191	0.48596107394332233	\N	\N	\N
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
