-- Generated from COMPOUND_V3_INSTITUTIONAL_USDC/1/2026-11.ndjson (30 rows)
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
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	2337.419011507643	0	3929299.529942831	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	11293.712245574152	0	23685624.33186384	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	13.65253007	0	819001.257750918	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	107.55962009	0	6455104.552005277	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T19:00:00.000Z	archival-rpc	26465427	2.993623519152714	3.818179528158295	21480093.937309	17764148.039783	21477011.758629937	17761599.062180772	0.8270045439535754	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	2337.419011507643	0	3930854.9006775324	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	11293.712245574152	0	23685624.33186384	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	13.65253007	0	821476.830070921	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	107.55962009	0	6495235.367169286	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T20:00:00.000Z	archival-rpc	26465727	2.993623519152714	3.818179528158295	21480166.940415	17764225.042916	21477166.590696763	17761743.735962007	0.8270045439535754	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	2337.419011507643	0	3937453.7691952987	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	11293.712245574152	0	23777119.243533716	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	13.65253007	0	815745.4979475349	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	107.60962009	0	6444002.602691062	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T09:00:00.000Z	archival-rpc	26469617	2.994296613394216	3.8186988964992388	21481116.150873	17769084.085786	21478115.668569047	17766602.1001209	0.827190489823297	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	2337.419011507643	0	4008143.493460641	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	11293.712245574152	0	24156569.576624263	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	13.65253007	0	833335.991095986	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	107.60962009	0	6582771.006879543	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T10:00:00.000Z	archival-rpc	26469915	2.994296613394216	3.8186988964992388	21481189.172429	17769161.118858	21478188.679925393	17766679.122432917	0.827190489823297	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	2337.419011507643	0	3876231.9667029274	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	11293.712245574152	0	23407418.877820987	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	13.65253007	0	806018.5421940694	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	107.60962009	0	6367164.264814863	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T08:00:00.000Z	archival-rpc	26469318	2.994296613394216	3.8186988964992388	21481043.129317	17769007.052715	21478042.657212697	17766525.077809878	0.827190489823297	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	2337.419011507643	0	4008143.493460641	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	11293.712245574152	0	24156569.576624263	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	13.65253007	0	833335.991095986	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	107.60962009	0	6582771.006879543	0	0	\N	\N	\N
COMPOUND_V3_INSTITUTIONAL_USDC:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	2.994296613394216	3.8186988964992388	21481262.193986	17769238.151929	21478261.69128274	17766756.144743938	0.827190489823297	\N	\N	\N
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
