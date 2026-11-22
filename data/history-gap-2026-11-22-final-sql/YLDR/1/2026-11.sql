-- Generated from YLDR/1/2026-11.ndjson (36 rows)
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
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	473.464986	552.802515	473.3970485091589	552.7231933671226	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	4.768504	5.091756	4.76044522824	5.083150932360001	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.3588741888525296	0.44345599730624874	603.282584177034	745.4681566236909	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.02258014578282892	0.000148026088700348	47.3559834659676	0.310446224592413	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.010882268199090502	0.000001047318068236	20.937972204157337	0.0020150869469905035	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.009108498609782191	9.8083298243e-7	18.010003516815928	0.001939376204548355	0.00010768327739289784	\N	\N	\N
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	473.464986	552.802515	473.3988524107555	552.7252995447047	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	4.768504	5.091756	4.76044522824	5.083150932360001	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.3588741888525296	0.44345599730624874	603.5213870651909	745.7632421333673	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.02258014578282892	0.000148026088700348	47.3559834659676	0.310446224592413	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.010882268199090502	0.000001047318068236	20.94840366220814	0.0020160908787347667	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.009108498609782191	9.8083298243e-7	18.016096226876986	0.0019400322875359345	0.00010768327739289784	\N	\N	\N
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	473.464986	552.802515	473.3988524107555	552.7252995447047	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	4.768504	5.091756	4.76068365344	5.08340552016	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.3588741888525296	0.44345599730624874	604.5345402803392	747.015181903358	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.02258014578282892	0.000148026088700348	47.53891432155961	0.3116454435574422	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.010882268199090502	0.000001047318068236	20.98357050629908	0.0020194753635264903	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.009108498609782191	9.8083298243e-7	18.04723644982112	0.0019433855688013044	0.00010768327739289784	\N	\N	\N
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	473.464986	552.802515	473.3988524107555	552.7252995447047	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	4.768504	5.091756	4.76068365344	5.08340552016	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.3588741888525296	0.44345599730624874	615.3878435738599	760.4264624735334	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.02258014578282892	0.000148026088700348	48.29757043499877	0.3166188789914333	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.010882268199090502	0.000001047318068236	21.358830360812803	0.002055590667682354	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.009108498609782191	9.8083298243e-7	18.37905379902721	0.00197911674845964	0.00010768327739289784	\N	\N	\N
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	473.464986	552.802515	473.3988524107555	552.7252995447047	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	4.768504	5.091756	4.76044522824	5.083150932360001	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.3588741888525296	0.44345599730624874	595.1348885271142	735.4001589453521	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.02258014578282892	0.000148026088700348	46.79975185909913	0.3067998004298701	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.010882268199090502	0.000001047318068236	20.657305847851372	0.001988075395655115	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.009108498609782191	9.8083298243e-7	17.766627607090207	0.0019131686889506117	0.00010768327739289784	\N	\N	\N
YLDR:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	473.464986	552.802515	473.3988524107555	552.7252995447047	1.1675678906486233	\N	\N	\N
YLDR:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	4.768504	5.091756	4.76068365344	5.08340552016	1.0677889753264336	\N	\N	\N
YLDR:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.3588741888525296	0.44345599730624874	615.3878435738599	760.4264624735334	1.2356865193458533	\N	\N	\N
YLDR:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.02258014578282892	0.000148026088700348	48.29757043499877	0.3166188789914333	0.006555586049976457	\N	\N	\N
YLDR:1:0xbe9895146f7af43049ca1c1ae358b0541ea49704	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.010882268199090502	0.000001047318068236	21.358830360812803	0.002055590667682354	0.00009624078814042929	\N	\N	\N
YLDR:1:0xae78736cd615f374d3085123a210448e74fc6393	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.009108498609782191	9.8083298243e-7	18.37905379902721	0.00197911674845964	0.00010768327739289784	\N	\N	\N
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
