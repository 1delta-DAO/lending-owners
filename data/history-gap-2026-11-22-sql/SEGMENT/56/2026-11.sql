-- Generated from SEGMENT/56/2026-11.ndjson (16 rows)
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
SEGMENT:56:0x8969b89d5f38359fbe95bbe392f5ad82dd93e226	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.11911150146204363	2.4622723476142028	314.16075597959235	16.88551267808677	314.11687400519713	16.883154109675896	0.05374800116403985	\N	\N	\N
SEGMENT:56:0x44b1e0f4533fd155b9859a9db292c90e5b300119	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1.5658469784796125	8.926869985614871	16728.846855304884	3260.0920192495446	16700.57510411942	3254.582463737013	0.19487846636695924	\N	\N	\N
SEGMENT:56:0x3821175e59cd0acda6c5fd3ebb618b204e5d7eed	2026-11-21T20:00:00.000Z	archival-rpc	134947363	19.13423850403717	37.85919801018167	0.36850189233393416	0.23274379195956688	619.7123674695725	391.4069624326507	0.6315945638310478	\N	\N	\N
SEGMENT:56:0x12cd46b96fe0d86e396248a623b81fd84dd0f61d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.14147856326474084	3.2565677322793363	0.002654021750150377	0.000144120471407785	159.85590478777019	8.680602694392416	0.054302671558595604	\N	\N	\N
SEGMENT:56:0x5fcea94b96858048433359bb5278a402363328c3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	5.897020315259738	21.709669614011773	3.7215946672907987	1.3475756855126024	2041.647817126982	739.2731349604607	0.36209630709020607	\N	\N	\N
SEGMENT:56:0x24a8117bf6f4a5be6759918f7c111f279a999ef3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.2573717623022276	5.670296651416606	0.10046945443254268	0.005699891005841781	172.03977294721295	9.760259573493377	0.05673257646351418	\N	\N	\N
SEGMENT:56:0xf8adf750633b8f95aa00bdbe2ed2924b6c386004	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.00152582266821355	0.27871017174163626	50015.58005874466	304.27847259000936	50015.58005874466	304.27847259000936	0.006083673771905195	\N	\N	\N
SEGMENT:56:0x07b4fbc9b123ac8eed171372969dd55410946d75	2026-11-21T20:00:00.000Z	archival-rpc	134947363	1594.5268833370108	1599.9799109632563	337.965524608585	420.98541720728997	615644.7289700875	766875.4183643666	1.2456460394735662	\N	\N	\N
SEGMENT:56:0x8969b89d5f38359fbe95bbe392f5ad82dd93e226	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.1191058995431149	2.4620783811712954	314.16126865622914	16.886082318794315	314.11738661022326	16.88372367081603	0.05374972666433909	\N	\N	\N
SEGMENT:56:0x44b1e0f4533fd155b9859a9db292c90e5b300119	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1.565989127172429	8.92677895443228	16729.20574545993	3260.490786088484	16700.933387750105	3254.980556659995	0.19489812222396363	\N	\N	\N
SEGMENT:56:0x3821175e59cd0acda6c5fd3ebb618b204e5d7eed	2026-11-22T08:00:00.000Z	archival-rpc	135043334	19.141918734888463	37.86469139193116	0.3685983664908352	0.23286438465569323	611.2608668073995	386.16797727113607	0.6317564206066093	\N	\N	\N
SEGMENT:56:0x12cd46b96fe0d86e396248a623b81fd84dd0f61d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.1414743618255443	3.256345056001919	0.002654026893618053	0.000144126900742381	156.66417046832683	8.50764602320773	0.05430498880359975	\N	\N	\N
SEGMENT:56:0x5fcea94b96858048433359bb5278a402363328c3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	5.895736775585192	21.706101891894036	3.7212302656556555	1.3473718935889774	2002.6265456286092	725.1050132098592	0.3620770007231949	\N	\N	\N
SEGMENT:56:0x24a8117bf6f4a5be6759918f7c111f279a999ef3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.25738086542048677	5.670087279696645	0.10046980859234776	0.005700333705598119	175.52409281494886	9.958672325904995	0.0567367827754803	\N	\N	\N
SEGMENT:56:0xf8adf750633b8f95aa00bdbe2ed2924b6c386004	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.00152582266821355	0.2786800614273943	50015.58110404213	304.27963403165063	50015.58110404213	304.27963403165063	0.006083696866356303	\N	\N	\N
SEGMENT:56:0x07b4fbc9b123ac8eed171372969dd55410946d75	2026-11-22T08:00:00.000Z	archival-rpc	135043334	1594.4758421529314	1599.8800847679463	340.9953631613095	424.7727153981956	612476.3757665836	762952.4660971587	1.2456847256226613	\N	\N	\N
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
