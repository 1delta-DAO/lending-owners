-- Generated from MOONCAKE/59144/2026-11.ndjson (24 rows)
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
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0.08015371147111766	1.1770186025967575	0.07274742377637211	0.005505173785521675	122.33988251792847	9.258091616163188	0.07567517170703877	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-21T20:00:00.000Z	archival-rpc	32675911	57.6	64	194.588554	195.293564	194.56137387077726	195.26628539498049	1.00362308052302	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-21T20:00:00.000Z	archival-rpc	32675911	53.93687588651457	60.30156450689719	49.43972089926173	49.17690645523238	49.43972089926173	49.17690645523238	0.9946841438574286	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-21T20:00:00.000Z	archival-rpc	32675911	57.6	64	19.353758	19.383265	19.32105014898	19.35050728215	1.0015246134626672	\N	\N	\N
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0.08015371147111766	1.1770186025967575	0.07274741712777369	0.00550516639683927	122.29146358330694	9.25441593007548	0.07567507705696254	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-21T19:00:00.000Z	archival-rpc	32675585	57.6	64	194.575863	195.279313	194.54794330941812	195.25129237137762	1.0036152993961025	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-21T19:00:00.000Z	archival-rpc	32675585	53.93687588651457	60.30156450689719	49.43670006252517	49.17352512258906	49.43670006252517	49.17352512258906	0.9946765269606739	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-21T19:00:00.000Z	archival-rpc	32675585	57.6	64	19.352496	19.38185	19.31979028176	19.3490946735	1.0015168069276439	\N	\N	\N
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0.08015371147111766	1.1770186025967575	0.07274751029504924	0.005505269935867018	122.54540465385394	9.273795478131058	0.0756764034059551	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T09:00:00.000Z	archival-rpc	32679553	57.6	64	194.753692	195.479117	194.72648880430145	195.45181247693745	1.0037248331086839	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-22T09:00:00.000Z	archival-rpc	32679553	53.93687588651457	60.30156450689719	49.47903125940838	49.220929178686006	49.47903125940838	49.220929178686006	0.9947836068299478	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T09:00:00.000Z	archival-rpc	32679553	57.6	64	19.370183	19.401681	19.33841589988	19.36986224316	1.0016261075076058	\N	\N	\N
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0.08015371147111766	1.1770186025967575	0.07274750364645081	0.005505262547055673	120.63998698732598	9.129588903371422	0.07567630875433155	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T08:00:00.000Z	archival-rpc	32679102	57.6	64	194.741002	195.464852	194.71380057684064	195.43754946947266	1.0037169881666728	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-22T08:00:00.000Z	archival-rpc	32679102	53.93687588651457	60.30156450689719	49.47601042267182	49.217544819196114	49.47601042267182	49.217544819196114	0.9947759408798801	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T08:00:00.000Z	archival-rpc	32679102	57.6	64	19.368921	19.400265	19.336187523510002	19.36747855215	1.0016182625764234	\N	\N	\N
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0.08015371147111766	1.1770186025967575	0.07274751696213652	0.005505277345235619	124.7454929311683	9.44030208634686	0.0756764983209117	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T10:00:00.000Z	archival-rpc	32679970	57.6	64	194.766418	195.493423	194.73921302673375	195.46611647867536	1.0037327020102615	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-22T10:00:00.000Z	archival-rpc	32679970	53.93687588651457	60.30156450689719	49.48206049669204	49.224323183314965	49.48206049669204	49.224323183314965	0.9947912978806873	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T10:00:00.000Z	archival-rpc	32679970	57.6	64	19.371449	19.403101	19.339679823639997	19.37127991436	1.0016339510792405	\N	\N	\N
MOONCAKE:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.08015371147111766	1.1770186025967575	0.07274752362737492	0.005505284752559447	124.74550436054054	9.440314788227292	0.0756765932096664	\N	\N	\N
MOONCAKE:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T11:00:00.000Z	archival-rpc	32680425	57.6	64	194.77914	195.507726	194.75193324972483	195.48041748083233	1.0037405750944377	\N	\N	\N
MOONCAKE:59144:0x7d43aabc515c356145049227cee54b608342c0ad	2026-11-22T11:00:00.000Z	archival-rpc	32680425	53.93687588651457	60.30156450689719	49.485088893920995	49.22771648065998	49.485088893920995	49.22771648065998	0.9947989905845631	\N	\N	\N
MOONCAKE:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T11:00:00.000Z	archival-rpc	32680425	57.6	64	19.372714	19.404521	19.34094274904	19.37269758556	1.001641845329467	\N	\N	\N
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
