-- Generated from AVALON_SOLVBTC/56/2026-11.ndjson (54 rows)
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
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.4538032634612314	0	248.95415140015524	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.010721037865224527	0	18.029648952707433	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	43.7166448361072	0	43.71053849515649	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	73.59802190937768	0	73.47364125235083	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.4525894653075286	2.783369148168005	0.9226054512211803	0.752411189459146	55746.500700569	45462.869143881464	0.8155286622935497	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.1363112605854644	2.548177231541305	0.03698004827099323	0.12005013268299568	2227.3664769778525	7230.8083303555395	3.246348728461822	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.02970584079556844	0.3980341077215599	0.0951946262842831	0.010305609243770573	5733.7220822495165	620.723055475642	0.10825830875153147	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.008251473416177893	0.2097805000938253	1.817151206394156	0.12361078662989697	109322.92601200411	7436.636441411612	0.06802449140992657	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.06602837048549699	0	5705.28539226731	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.4538032634612314	0	244.21989423442233	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.010721037865224527	0	17.779109986194246	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	43.7166448361072	0	43.71053849515649	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	73.59802190937768	0	73.47364125235083	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.4525894653075286	2.783369148168005	0.9226237393965807	0.7524398774230922	54618.68305409402	44543.91690496918	0.8155435908414918	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.1363112605854644	2.548177231541305	0.03698062389868496	0.120054323290581	2182.923910989736	7086.669323013247	3.2464115159195615	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.02970584079556844	0.3980341077215599	0.09519466501865982	0.010305665435452516	5619.232142681082	608.3316376528123	0.10825885498344288	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.008251473416177893	0.2097805000938253	1.8171514117938108	0.12361114185140237	107267.2110417816	7296.81762016786	0.06802467920346768	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.06602837048549699	0	5595.075031463886	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x4aae823a6a0b376de6a78e74ecc5b079d38cbcf7	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x53e63a31fd1077f949204b94f431bcab98f72bce	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x1346b618dc92810ec74163e4c27004c921d446a5	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_SOLVBTC:56:0x541b5eeac7d4434c8f87e2d32019d67611179606	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
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
