-- Generated from PRIME_FI/8453/2026-11.ndjson (30 rows)
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
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	46.58565789977178	63.57392974245351	4281.23724	4278.234454	4280.639236782317	4277.636870211466	0.9992986172380394	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	46.9312	64	8.97391504532064	8.97391504532064	15091.49953880536	15091.49953880536	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	46.9312	64	0.01211943	0.01211943	729.2297389290001	729.2297389290001	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-21T20:00:00.000Z	archival-rpc	60504126	1.96209081e-9	0.000381779147344025	122840.59838409546	2.525276330432685	120.91445780143283	0.0024856799975715004	0.00002055734312313184	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-21T20:00:00.000Z	archival-rpc	60504126	1.097e-15	8.1543485356e-8	1022691.3707644476	0.018763609234185408	27326.282746084915	0.0005013630758291571	1.8347284205751996e-8	\N	\N	\N
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T19:00:00.000Z	archival-rpc	60486126	46.58565789977178	63.57392974245351	4280.926768	4277.923982	4280.3124978180595	4277.310142687823	0.9992985663706172	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	46.9312	64	8.973259440838454	8.973259440838454	15084.425996945956	15084.425996945956	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	46.9312	64	0.01211854	0.01211854	726.97876885942	726.97876885942	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-21T19:00:00.000Z	archival-rpc	60486126	1.96209081e-9	0.000381779147344025	122840.59838409437	2.525276329332117	120.91445780143175	0.002485679996488189	0.000020557343114172704	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-21T19:00:00.000Z	archival-rpc	60486126	1.097e-15	8.1543485356e-8	1022691.3707644476	0.018763609234183663	27349.733059216545	0.0005017933253888502	1.834728420575029e-8	\N	\N	\N
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	46.58565789977178	63.57392974245351	4285.275438	4282.272652	4284.67687072682	4281.674504155968	0.9992992781809606	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	46.9312	64	8.982442263589425	8.982442263589425	15131.198545585921	15131.198545585921	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	46.9312	64	0.01213094	0.01213094	724.82973047	724.82973047	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.96209081e-9	0.000381779147344025	122840.59838410976	2.5252763447400732	124.83307288990002	0.002566236327051757	0.000020557343239600618	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.097e-15	8.1543485356e-8	1022691.3707644476	0.018763609234208115	26787.211897641268	0.0004914725897663204	1.83472842057742e-8	\N	\N	\N
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	46.58565789977178	63.57392974245351	4284.964673	4281.961887	4284.366149134476	4281.363782563624	0.999299227361448	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	46.9312	64	8.981786036159795	8.981786036159795	14894.841695067958	14894.841695067958	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	46.9312	64	0.01213005	0.01213005	716.134311194465	716.134311194465	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T08:00:00.000Z	archival-rpc	60720126	1.96209081e-9	0.000381779147344025	122840.59838410867	2.525276343639505	124.56528038542154	0.0025607312235042035	0.00002055734323064148	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T08:00:00.000Z	archival-rpc	60720126	1.097e-15	8.1543485356e-8	1022691.3707644476	0.01876360923420637	26604.978522284753	0.00048812910223683143	1.8347284205772493e-8	\N	\N	\N
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	46.58565789977178	63.57392974245351	4285.586313	4282.583527	4284.9877023038	4281.985335732948	0.9992993290110874	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	46.9312	64	8.983098721267762	8.983098721267762	15403.976999203187	15403.976999203187	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	46.9312	64	0.01213183	0.01213183	740.51406772386	740.51406772386	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T10:00:00.000Z	archival-rpc	60756127	1.96209081e-9	0.000381779147344025	122840.59838411087	2.5252763458409473	124.83307288990115	0.0025662363281704873	0.00002055734324856224	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T10:00:00.000Z	archival-rpc	60756127	1.097e-15	8.1543485356e-8	1022691.3707644476	0.018763609234209864	26787.211897641268	0.0004914725897663661	1.8347284205775908e-8	\N	\N	\N
PRIME_FI:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	46.58565789977178	63.57392974245351	4285.897038	4282.894252	4285.298383901732	4282.296017330881	0.9992993798093196	\N	\N	\N
PRIME_FI:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	46.9312	64	8.98375486228215	8.98375486228215	15405.102132234391	15405.102132234391	1	\N	\N	\N
PRIME_FI:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	46.9312	64	0.01213271	0.01213271	740.56778199282	740.56778199282	1	\N	\N	\N
PRIME_FI:8453:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.96209081e-9	0.000381779147344025	122840.59838411197	2.52527634694121	124.83307288990227	0.0025662363292885963	0.00002055734325751889	\N	\N	\N
PRIME_FI:8453:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.097e-15	8.1543485356e-8	1022691.3707644476	0.01876360923421161	26787.211897641268	0.0004914725897664119	1.8347284205777615e-8	\N	\N	\N
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
