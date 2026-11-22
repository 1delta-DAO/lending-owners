-- Generated from POLTER/8453/2026-11.ndjson (24 rows)
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
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.006515688570279368	0.4502336183309262	0.401884824460726	0.011633174009204588	675.8526922053354	19.563595076186804	0.028946537169734398	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.1279393561316634	1.2548458986316926	758.838582	154.740849	758.7325874268662	154.7192347982117	0.20391800400048715	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.13019241069685603	1.820436386122868	0.012290839999999999	0.00175856	739.5435300519999	105.813082768	0.14307891079861101	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.9309003735441019	4.786906175536897	882.5279740132969	343.2743412122648	350.6034944371752	136.37322229269745	0.3889670937582005	\N	\N	\N
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.006515688570279368	0.4502336183309262	0.40188481848167956	0.011633168030158183	675.5852590300796	19.55584405175317	0.028946522722874377	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.1279393561316634	1.2548458986316926	758.83836	154.740627	758.7294742837236	154.71842326743175	0.20391777110477124	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.13019241069685603	1.820436386122868	0.012290829999999999	0.00175855	737.3142690175899	105.49360846914999	0.14307821359501352	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.9309003735441019	4.786906175536897	882.5260981941519	343.27246539311983	352.565593172605	137.13595623834186	0.38896579500088774	\N	\N	\N
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.006515688570279368	0.4502336183309262	0.40188490218860884	0.011633251737087484	676.9874015376329	19.59656812693084	0.028946724979551173	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.1279393561316634	1.2548458986316926	758.841463	154.74373	758.7354680244482	154.7221153957936	0.203921026387036	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.13019241069685603	1.820436386122868	0.01229088	0.0017586	734.3862254400001	105.0772293	0.14308169960165584	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.9309003735441019	4.786906175536897	882.5523605949729	343.29872779394094	358.1965489993679	139.33271844490204	0.3889839777466642	\N	\N	\N
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.006515688570279368	0.4502336183309262	0.4018848962095225	0.011633245758001133	666.461200988373	19.29185946621953	0.028946710532600225	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.1279393561316634	1.2548458986316926	758.841242	154.743509	758.7352470553175	154.72189442666289	0.20392079454216064	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.13019241069685603	1.820436386122868	0.01229088	0.0017586	725.6293982938098	103.82428758880518	0.14308169960165584	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.9309003735441019	4.786906175536897	882.5504846425708	343.2968518415388	350.07367550698126	136.17259613518328	0.3889826789688666	\N	\N	\N
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.006515688570279368	0.4502336183309262	0.4018849081693591	0.011633257717837768	689.1414726536619	19.94839863967187	0.028946739430522166	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.1279393561316634	1.2548458986316926	758.841685	154.743952	758.7356899934392	154.72233736478466	0.20392125928084726	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.13019241069685603	1.820436386122868	0.01229089	0.00175861	750.2229218383801	107.34369379062001	0.14308239679958082	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.9309003735441019	4.786906175536897	882.5542370787282	343.3006042776961	358.19731059724626	139.3334800427804	0.3889852768868096	\N	\N	\N
POLTER:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.006515688570279368	0.4502336183309262	0.4018849141467908	0.011633263695269404	689.1414829036016	19.948408889611482	0.028946753873474056	\N	\N	\N
POLTER:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.1279393561316634	1.2548458986316926	758.841907	154.744174	758.7359119624302	154.72255933377568	0.20392149217452218	\N	\N	\N
POLTER:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.13019241069685603	1.820436386122868	0.01229089	0.00175861	750.2229218383801	107.34369379062001	0.14308239679958082	\N	\N	\N
POLTER:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.9309003735441019	4.786906175536897	882.55611253053	343.3024797294979	358.1980717762915	139.33424122182564	0.3889865753069861	\N	\N	\N
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
