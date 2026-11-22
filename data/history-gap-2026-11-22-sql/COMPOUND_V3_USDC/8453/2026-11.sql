-- Generated from COMPOUND_V3_USDC/8453/2026-11.ndjson (36 rows)
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
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	458.3494619923238	0	882324.2886968729	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	2036.1395910899128	0	3424191.063174793	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	237.76153011334063	0	498642.9758771865	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	87.76938198	0	5281110.044551195	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	14.706623677512978	0	884901.9586630592	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	3.0933325057077625	3.895116089548453	7544311.960727	6446989.611912	7543258.171232326	6446089.096403008	0.8545496854581838	\N	\N	\N
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	458.3494619923238	0	881884.926874695	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	2036.1395910899128	0	3422836.170484969	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	237.76153011334063	0	498642.9758771865	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	87.76576873	0	5264978.330668215	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	14.706623677512978	0	882235.2507114867	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T19:00:00.000Z	archival-rpc	60486126	2.9925198566717404	3.817327929984779	7798285.466597	6446841.32951	7797166.490615398	6445916.272247628	0.826699651472434	\N	\N	\N
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	458.16903982572256	0	883457.5821049792	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	2038.1482308411544	0	3433322.99181053	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	237.76153011334063	0	500569.17779584613	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	87.77465634	0	5244579.603643171	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	14.706623677512978	0	878728.1180432392	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	3.148190889776763	3.937445427447996	7407487.445631	6442327.167811	7406452.767784595	6441427.3035522	0.8697046084363986	\N	\N	\N
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	458.16903982572256	0	869721.0740025096	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	2038.1482308411544	0	3379939.705448771	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	237.76153011334063	0	492786.03946860856	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	87.77465634	0	5182043.195071478	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	14.706623677512978	0	868250.1570308422	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	3.1430825279046166	3.933503760781329	7419996.008764	6442737.369561	7418959.583721496	6441837.44800522	0.8682933960229807	\N	\N	\N
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	458.16903982572256	0	899256.9029893938	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	2038.1482308411544	0	3494961.977264459	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	237.76153011334063	0	508557.5778751009	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	87.77579244	0	5357741.503749199	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	14.706623677512978	0	897676.7496675414	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	3.148203383434805	3.9374550672247586	7407486.447174	6442355.974157	7406451.769467059	6441456.10587453	0.8697080598881495	\N	\N	\N
COMPOUND_V3_USDC:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	458.16903982572256	0	899256.9029893938	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	2038.1482308411544	0	3494961.977264459	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	237.76153011334063	0	508557.5778751009	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	87.77579244	0	5357741.503749199	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x236aa50979d5f3de3bd1eeb40e81137f22ab794b	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	14.706623677512978	0	897676.7496675414	0	0	\N	\N	\N
COMPOUND_V3_USDC:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	3.149630768011162	3.9385564561136475	7404168.401634	6442384.764917	7403134.18739166	6441484.892613037	0.8701023826452051	\N	\N	\N
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
