-- Generated from KINZA/1/2026-11.ndjson (15 rows)
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
KINZA:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.084189863334717731870247476	1.289745878803266840132577662	ray
KINZA:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.293563832293331175980785779	1.461092633869669736712241597	ray
KINZA:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0xd9a442856c234a39a81a089c06451ebaa4306a72	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.074372486266148668104826161	1.132816821663604066734438968	ray
KINZA:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.201085244378832050695081535	1.279086861858146990121250438	ray
KINZA:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.000012144971382353303290878	1.000272418699047057261812554	ray
KINZA:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	2.857352040322871761801285124	4.215817255110502164035067649	ray
KINZA:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.605249553755206696566120614	1.807946767660401452688400844	ray
KINZA:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0x40d16fc0246ad3160ccc09b8d0d3a2cd28ae6c2f	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.003059297605289807805956883	1.014912081783437323966355464	ray
KINZA:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	1	ray
KINZA:1:0x73a15fed60bf67631dc6cd7bc5b6e8da8190acf5	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.000006643456030449069487661	1.000007959944072804557158149	ray
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
