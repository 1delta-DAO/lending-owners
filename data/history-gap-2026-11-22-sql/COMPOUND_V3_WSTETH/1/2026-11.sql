-- Generated from COMPOUND_V3_WSTETH/1/2026-11.ndjson (48 rows)
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
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.001714411358330192	0	3.1265364145449603	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.38215738813310063	0	698.57817974077	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	2.5409129467929077	0	5378.130002698108	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	274.163063	0	274.12372334209016	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	44.833251	0	44.75748280581	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.4044169925721691	0	679.8419500275043	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	2.3397226513e-8	0	0.0000436025394470277	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.026831903221714866	1.0204175164890918	162.4014271648221	2.167205102169612	340594.7584942183	4545.149086847344	0.013342424124339086	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.001714411358330192	0	3.127874571208718	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.38215738813310063	0	702.3012395275643	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	2.5409129467929077	0	5383.913742004473	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	274.163063	0	274.1247679033602	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	44.833251	0	44.75748280581	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.4044169925721691	0	680.1110581128607	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	2.3397226513e-8	0	0.000043623080195533135	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.026831903221714866	1.0204175164890918	162.40143211189599	2.167207612376743	340594.7688694192	4545.154351353984	0.013342424124339086	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.001714411358330192	0	3.1332433670258775	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.38215738813310063	0	699.4274333684292	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	2.5409129467929077	0	5392.951913044842	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	274.163063	0	274.1247679033602	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	44.833251	0	44.75972446836	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.4044169925721691	0	681.2527851832729	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	2.3397226513e-8	0	0.000043697834082955954	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.026831903221714866	1.0204175164890918	162.4014964238556	2.16724024506943	341910.58368000947	4562.780476064922	0.013342424124339086	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.001714411358330192	0	3.1893749394826063	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.38215738813310063	0	715.9776064764335	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	2.5409129467929077	0	5492.106983870189	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	274.163063	0	274.1247679033602	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	44.833251	0	44.75972446836	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.4044169925721691	0	693.4834231443743	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	2.3397226513e-8	0	0.00004448079857150249	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.026831903221714866	1.0204175164890918	162.40150137092948	2.1672427552765594	347367.019976314	4635.601586873222	0.013342424124339086	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.001714411358330192	0	3.084525891760286	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.38215738813310063	0	690.3500736269357	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	2.5409129467929077	0	5308.817412896454	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	274.163063	0	274.1247679033602	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	44.833251	0	44.75748280581	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.4044169925721691	0	670.660273903987	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	2.3397226513e-8	0	0.00004301839495183707	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.026831903221714866	1.0204175164890918	162.40149147678173	2.167237734862299	336594.35044217814	4491.83053053454	0.013342424124339086	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa1290d69c65a6fe4df752f95823fae25cb99e5a7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.001714411358330192	0	3.1893749394826063	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xbf5495efe5db9ce00f80364c8b423567e58d2110	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.38215738813310063	0	715.9776064764335	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xd11c452fc99cf405034ee446803b6f6c1f6d5ed8	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	2.5409129467929077	0	5492.106983870189	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	274.163063	0	274.1247679033602	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	44.833251	0	44.75972446836	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.4044169925721691	0	693.4834231443743	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	2.3397226513e-8	0	0.00004448079857150249	0	0	\N	\N	\N
COMPOUND_V3_WSTETH:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.026831903221714866	1.0204175164890918	162.4015063180032	2.1672452654836887	347367.03055780637	4635.606956054927	0.013342424124339086	\N	\N	\N
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
