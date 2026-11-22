-- Generated from AVALON/8453/2026-11.ndjson (18 rows)
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
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.9468868524067747	4.246874149988828	0.004789728798490523	0.002028723391689973	289.4093238525379	122.58135893995842	0.42355704822563706	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.3535990887253044	2.507230747614425	0.14956225860468605	0.02851453403582306	8997.921402519618	1715.4831605074971	0.19065327243546754	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	16.285086954378173	26.1389091601358	0.00412261	0.00498762	248.058680483	300.106591686	1.2098209629336756	\N	\N	\N
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.9468868524067747	4.246874149988828	0.004789723621854277	0.002028713556402566	288.3649581790474	122.1385503706399	0.42355545258312355	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.3535990887253044	2.507230747614425	0.1495621982386038	0.028514452423492206	9004.381138706447	1716.7105097841759	0.19065280371181573	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	16.285086954378173	26.1389091601358	0.00412253	0.00498747	247.30634086169	299.19320316831	1.209808054762488	\N	\N	\N
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.9468868524067747	4.246874149988828	0.004789796094761728	0.00202885125476492	286.83520547384006	121.4970230513129	0.4235777921702629	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.3535990887253044	2.507230747614425	0.14956304336375517	0.02851559501736799	8956.528717673871	1707.6460864295816	0.19065936595054875	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	16.285086954378173	26.1389091601358	0.0041236	0.00498955	246.3871618	298.128107275	1.209998544960714	\N	\N	\N
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.9468868524067747	4.246874149988828	0.004789790918125481	0.002028841418857701	283.552287765297	120.10599954438791	0.4235761964431847	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.3535990887253044	2.507230747614425	0.14956298299767293	0.028515513402002306	8828.765702805491	1683.282732635825	0.1906588972115245	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	16.285086954378173	26.1389091601358	0.00412352	0.0049894	243.44451629602523	294.56436966654417	1.2099856433338505	\N	\N	\N
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.9468868524067747	4.246874149988828	0.004789801272835929	0.002028861093452036	292.17371317096695	123.75876271606117	0.4235793883471067	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.3535990887253044	2.507230747614425	0.14956310374660578	0.028515676655638155	9135.86439973334	1741.8423973998592	0.1906598348209613	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	16.285086954378173	26.1389091601358	0.00412368	0.0049897	251.70506434656002	304.56600889739997	1.2100114460869902	\N	\N	\N
AVALON:8453:0x3b86ad95859b6ab773f55f8d94b4b9d443ee931f	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.9468868524067747	4.246874149988828	0.004789806448034221	0.002028870926722398	292.1740288535632	123.75936253700375	0.4235809836439351	\N	\N	\N
AVALON:8453:0xc26c9099bd3789107888c35bb41178079b282561	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.3535990887253044	2.507230747614425	0.14956316409591966	0.028515758248799705	9135.868086091368	1741.847381410228	0.1906603034321448	\N	\N	\N
AVALON:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	16.285086954378173	26.1389091601358	0.00412375	0.00498985	251.7093370725	304.5751647387	1.2100272809942407	\N	\N	\N
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
