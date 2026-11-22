-- Generated from COMPOUND_V3_AERO/8453/2026-11.ndjson (30 rows)
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
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	7.902116808919272	0	13289.048489441131	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	14230.70325	0	14228.71550537004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	3.315198178788329	0	6952.766011833834	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	1.04563347	0	62916.079579941004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.801251934297311	2.871153710045662	268703.71703197947	53530.63195735161	106748.41470605948	21266.211583447235	0.19921512809869674	\N	\N	\N
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	7.902116808919272	0	13283.79024469927	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	14230.70325	0	14228.661286390658	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	3.315198178788329	0	6952.766011833834	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	1.04563347	0	62726.47799972631	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.801251934297311	2.871153710045662	268703.4726048529	53530.45747196095	107345.94636953996	21385.200426391064	0.19921512809869674	\N	\N	\N
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	7.902116808919272	0	13311.357296538774	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	14230.70325	0	14228.71550537004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	3.315198178788329	0	6979.623767542569	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	1.04563347	0	62477.122649235	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.8012678018772197	2.871166761796043	268706.38964796875	53532.9003270819	109058.34686238346	21727.096330194887	0.19921907262201935	\N	\N	\N
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	7.902116808919272	0	13104.384634741495	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	14230.70325	0	14228.71550537004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	3.315198178788329	0	6871.100551043182	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	1.04563347	0	61732.14494584345	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.8012678018772197	2.871166761796043	268706.14521476516	53532.72583656063	106585.34500124624	21234.36383483728	0.19921907262201935	\N	\N	\N
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	7.902116808919272	0	13550.338179121196	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	14230.70325	0	14228.71550537004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	3.315198178788329	0	7091.009025626808	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	1.04563347	0	63824.36072858875	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.8012678018772197	2.871166761796043	268706.63414907025	53533.07486607271	109058.44609666654	21727.167169350687	0.19921907262201935	\N	\N	\N
COMPOUND_V3_AERO:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	7.902116808919272	0	13550.338179121196	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	14230.70325	0	14228.71550537004	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	3.315198178788329	0	7091.009025626808	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	1.04563347	0	63824.36072858875	0	0	\N	\N	\N
COMPOUND_V3_AERO:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.8012678018772197	2.871166761796043	268706.87851437565	53533.2493081244	109058.54527583483	21727.237969162354	0.19921907262201935	\N	\N	\N
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
