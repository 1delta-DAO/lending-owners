-- Generated from AVALON_SOLVBTC/1/2026-11.ndjson (30 rows)
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
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.014300733016637876	0.28586443357085867	0.003172902495179961	0.000227681205368301	191.02436122912502	13.707530214189614	0.07175802146904214	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	78.48316719511689	0.7637974978666178	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	98.686750338	8.882101599999999	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-21T19:00:00.000Z	archival-rpc	26465427	2.6507566319e-8	0.000917338564490733	0.006111534860453914	0.000001456140240401	367.9445065271453	0.0876668160163078	0.0002382609726769766	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	40.17849166866234	0.955222944624394	0.023774484928448192	\N	\N	\N
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.014300733016637876	0.28586443357085867	0.00317290254697049	0.000227681279667065	191.71598631181703	13.757164126514219	0.07175804371440803	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	78.97118248833256	0.7685468584390842	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	99.30027715310334	8.93732084156392	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-21T20:00:00.000Z	archival-rpc	26465727	2.6507566319e-8	0.000917338564490733	0.006111534860454099	0.000001456140241926	367.68039501512123	0.08760388864230173	0.00023826097292649754	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	40.339868163596	0.9590595876710001	0.023774484928448192	\N	\N	\N
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.014300733016637876	0.28586443357085867	0.00317290322024736	0.000227682245553194	190.00816091598867	13.634668865636645	0.07175833290479117	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	78.73039992563358	0.766203564641292	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	98.4712466318229	8.86270562428	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-22T09:00:00.000Z	archival-rpc	26469617	2.6507566319e-8	0.000917338564490733	0.006111534860456503	0.000001456140261749	365.9870530557068	0.08720043252661326	0.00023826097616994255	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	40.03441585348053	0.9517976163278002	0.023774484928448192	\N	\N	\N
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.014300733016637876	0.28586443357085867	0.003172903272037888	0.000227682319852296	193.54434092726822	13.88842355358065	0.07175835515025346	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	80.0816077636512	0.7793535075228001	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	100.59177615299998	9.0535596	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-22T10:00:00.000Z	archival-rpc	26469915	2.6507566319e-8	0.000917338564490733	0.006111534860456688	0.000001456140263274	373.3150246331568	0.088946402281152	0.0002382609764194635	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	40.9296568177928	0.9730815091411716	0.023774484928448192	\N	\N	\N
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.014300733016637876	0.28586443357085867	0.003172903168456831	0.000227682171254116	187.83365864032157	13.47862602899182	0.07175831065933576	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	77.47071346571911	0.7539443070123647	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	97.29707471006937	8.75702665249136	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-22T08:00:00.000Z	archival-rpc	26469318	2.6507566319e-8	0.000917338564490733	0.006111534860456318	0.000001456140260224	360.76646965737785	0.08595657113993202	0.0002382609759204216	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	39.52657164458867	0.939723881837501	0.023774484928448192	\N	\N	\N
AVALON_SOLVBTC:1:0x7a56e1c57c7475ccf742a1832b028f0456652f97	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.014300733016637876	0.28586443357085867	0.003172903323828416	0.000227682394151423	193.5443440864454	13.888428085762795	0.07175837739572288	\N	\N	\N
AVALON_SOLVBTC:1:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.000221546046618042	0.03558057627776699	0.00131936	0.00001284	80.0816077636512	0.7793535075228001	0.009731991268493815	\N	\N	\N
AVALON_SOLVBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.020596120204861453	0.3430628447608008	0.00164439	0.000148	100.59177615299998	9.0535596	0.0900029798283862	\N	\N	\N
AVALON_SOLVBTC:1:0xd9d920aa40f578ab794426f5c90f6c731d159def	2026-11-22T11:00:00.000Z	archival-rpc	26470215	2.6507566319e-8	0.000917338564490733	0.006111534860456873	0.000001456140264798	373.3150246331681	0.08894640237424352	0.00023826097666882078	\N	\N	\N
AVALON_SOLVBTC:1:0x23e479ddcda990e8523494895759bd98cd2fdbf6	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.001556936640507891	0.09432274805698666	0.00078824	0.00001874	40.9296568177928	0.9730815091411716	0.023774484928448192	\N	\N	\N
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
