-- Generated from EULER_V2/60808/2026-11.ndjson (16 rows)
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
EULER_V2:60808:0x54743f05cba7b05214bd7f4db4722c02e2f513fe	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0xb615d3123410ee89542b027dc71e87b4fc05ea80	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0x33cc3800574c4bee6d7428e707db82d1543d639d	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.000000035226428928464033971705	\N	assets_per_share
EULER_V2:60808:0x11da346d3fdb62641bdbfebfd54b81caa871aef6	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.00006714746828301134727855387	\N	assets_per_share
EULER_V2:60808:0xc8cc610709a72ce957abc043baf3c408a62c20d7	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0xe1cecd3644fdcfab4c6206e693a5a4fa90e9c710	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.129983997618250158163075434483	\N	assets_per_share
EULER_V2:60808:0x80e0d452da8eb37c8db9c8e89103dc92ad477773	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.009123646021152847178481586365	\N	assets_per_share
EULER_V2:60808:0x6f421f025dd9e3eff6097536b7991029859c888a	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0xf168679179aa9b6e7772c8eca4f8afb0b75ed346	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.029283979592123888077489144597	\N	assets_per_share
EULER_V2:60808:0xced95f4cf51de12f0a0af62f1b53828491d21ca9	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.325192105527517321686029319173	\N	assets_per_share
EULER_V2:60808:0xa61837d6745de6198456165191298075eca0b9a0	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0x1a681ed31ea68455a73d187929973e7095c31932	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.024790604856793884604884712887	\N	assets_per_share
EULER_V2:60808:0x2780f244825c77ff6967925c6f6ed69c53d33d77	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0xc282e68852f52a9cf493b8a85dff55b871f4757b	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:60808:0x615a898ca1f70b1d15545dade04b7d04ed856539	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.000001183576923327295118396158	\N	assets_per_share
EULER_V2:60808:0xf004756aedd7375e4039e942bab6cccfd1e165bb	2026-11-22T11:00:00.000Z	archival-rpc	41241606	\N	\N	\N	\N	\N	\N	\N	1.000001686921707645034544770416	\N	assets_per_share
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
