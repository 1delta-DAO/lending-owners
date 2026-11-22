-- Generated from SUMER/56/2026-11.ndjson (54 rows)
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
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-21T20:00:00.000Z	archival-rpc	134947363	58.09849274953649	103.52356403799945	1.8326872954054472	1.1420922138957186	1005.4028852273487	626.5459524519781	0.6231789879042362	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.12481825242141796	3e-18	0.12480081780791974	2.99958096e-18	2.4034946346398457e-17	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	1.2857322751560671	1.68e-16	1.2835593876110534	1.6771608e-16	1.3066483843194144e-16	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.000089493778188782	0	5.39035103402343	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.002603593586776124	0.003305111543417701	157.31668560715755	199.70443782520297	1.2694421895201489	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0.00001750599665228947	0.000089709370363665	1.00044797e-10	5.397069228108657	0.000006018866180112807	0.000001115210112326473	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.000089548894990891	0	5.393670805713185	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.002305866971361518	0	3.877793600575086	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.4313050428805809	3.096214203424097	0.00349272	0.00069503	208.2142395335772	41.43336508595655	0.19899390732724068	\N	\N	\N
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-22T08:00:00.000Z	archival-rpc	135043334	58.24024160538954	103.71794362242781	1.833999901966999	1.1435506656307761	986.9899539023162	615.416073657016	0.6235282043386681	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.12481825242141796	3e-18	0.12480081780791974	2.99958096e-18	2.4034946346398457e-17	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	1.2857322751560671	1.68e-16	1.2835593876110534	1.6771608e-16	1.3066483843194144e-16	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.000089493778188782	0	5.282715316764868	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.002603593586776124	0.003305111543417701	154.13092775046363	195.66030239632045	1.2694421895201489	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0.00001750599665228947	0.000089709370363665	1.00044797e-10	5.295581810502697	0.000005905686385724739	0.000001115210112326473	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.000089548894990891	0	5.2859687985219805	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.002305866971361518	0	3.8239080033797155	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.4313372539144211	3.096329743002002	0.00349274	0.00069506	205.0468115213402	40.80459376192408	0.19900135710072894	\N	\N	\N
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x23811c17bac40500decd5fb92d4feb972ae1e607	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xbc6590a7b15513e4d649b158393175a839f27ed8	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xe550a6f792a8b6c07555378ea74063021885a33e	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xf7bb299dc8e627eaec4282ffc236e085aef8faf3	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x86208af42580823401b504b341150c92cc99c69a	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0xdca98947c3c9cf0b3cf448b6a03f991598fb9460	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x218c9349e8522466bd57fb878a1a479aeaef02a4	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x2509bd3b69440d39238b464d09f9f04a61fd62c6	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
SUMER:56:0x35c840655d3a2e77d79f179c34e547726b963314	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
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
