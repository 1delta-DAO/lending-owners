-- Generated from COMPOUND_V3_WETH/8453/2026-11.ndjson (54 rows)
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
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	144.20789836279005	0	277600.6996808705	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	74.58397572200504	0	137065.04237519662	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	221.61389179434983	0	464777.50394431443	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	870485.863034	0	870364.2735686515	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	382.16403211658326	0	712527.7097098305	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	6.796118857034488	0	12399.245520943461	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	2.89958111	0	174468.665263033	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	693.4534265336446	0	1300780.3120148415	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	2.3663427860223236	2.629269761542364	1766.1603249165512	1720.8124262601616	2970164.927383944	2893903.029627785	0.9743239678635476	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	144.20789836279005	0	277462.46575621027	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	74.58397572200504	0	136338.42918028665	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	221.61389179434983	0	464777.50394431443	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	872165.06527	0	872039.9183047845	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	382.16403211658326	0	712192.2026245283	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	6.796118857034488	0	12393.940917884203	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	2.89958111	0	173942.89291910004	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	693.4534265336446	0	1296375.5620777693	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	2.367045157914764	2.6300501712328765	1766.0613162160316	1720.8072883829539	2968823.24713443	2892749.3256778573	0.9743757102177322	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	144.20789836279005	0	278066.71803160646	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	74.58397572200504	0	136504.17427357554	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	221.45854226406374	0	466245.8235533075	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	870420.863034	0	870299.2826478515	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	382.16403211658326	0	713748.7196880012	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	6.796118857034488	0	12420.528029552192	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	2.89958111	0	173251.42111305502	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	693.4534265336446	0	1297520.528354169	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	2.1289690892947744	2.3655212075088787	1798.4179011824638	1720.7930065285461	3029489.9240302662	2898728.4163443535	0.9568370995100738	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	144.20789836279005	0	273743.17629894364	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	74.58397572200504	0	134732.58591861313	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	221.45854226406374	0	458996.364537091	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	870430.863034	0	870309.2812510515	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	382.16403211658326	0	702650.9428732189	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	6.796118857034488	0	12227.406495031984	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	2.89958111	0	171185.5698008114	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	693.4534265336446	0	1284438.9250746712	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	2.128882768899036	2.3654252949010655	1798.4281295171731	1720.7914014265389	2982402.629195619	2853654.6530161	0.9568307404210754	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	144.20789836279005	0	283039.526454383	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	74.58397572200504	0	139734.19872845395	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	221.45854226406374	0	473686.46979969804	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	870420.863034	0	870299.2826478515	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	382.16403211658326	0	726537.4519670509	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	6.796118857034488	0	12643.03987666205	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	2.89958111	0	176987.36319758563	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	693.4534265336446	0	1297520.528354169	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	2.128970335489599	2.3655225900558094	1798.4224577118837	1720.7976291215198	3083886.6445781067	2950777.668346762	0.9568371912832788	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	144.20789836279005	0	283039.526454383	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x2416092f143378750bb29b79ed961ab195cceea5	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	74.58397572200504	0	139734.19872845395	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	221.45854226406374	0	473686.46979969804	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	870420.863034	0	870299.2826478515	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x04c0599ae5a44757c0af6f9ec3b93da8976c150a	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	382.16403211658326	0	726537.4519670509	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xedfa23602d0ec14714057867a78d01e94176bea0	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	6.796118857034488	0	12643.03987666205	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	2.89958111	0	176987.36319758563	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x7fcd174e80f264448ebee8c88a7c4476aaf58ea6	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	693.4534265336446	0	1297520.528354169	0	0	\N	\N	\N
COMPOUND_V3_WETH:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	2.1290493467782854	2.3656103849568746	1798.4164804033676	1720.802249167707	3083876.394849616	2950785.590678177	0.9568430120217445	\N	\N	\N
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
