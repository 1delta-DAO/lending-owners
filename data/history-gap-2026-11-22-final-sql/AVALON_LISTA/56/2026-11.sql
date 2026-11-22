-- Generated from AVALON_LISTA/56/2026-11.ndjson (54 rows)
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
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-21T19:00:00.000Z	archival-rpc	134939365	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	9.8166320889e-7	0.005582464634311591	0.030000000512490983	0.000007537030855372	16.457846981149935	0.004134776613029408	0.00025123435755388854	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.0101	0	16.98524496523	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	11.000555754578897	0	10.999019196951098	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	17.009981134873794	0	16.98123426675586	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.001121468263858065	0	67.5477976017503	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	49.46761043783172	0	3.2844821325487468	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	11.210124206399911	0	11.147795915812328	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.07059301286831755	0	40.27424530360028	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.8582244279919717	4.288417360398918	12.055145092322839	3.5810985806954987	12.011560806232175	3.5681514428664154	0.2970597660393216	\N	\N	\N
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	9.8166320889e-7	0.005582464634311591	0.030000000512894406	0.000007537031431744	16.14487497602053	0.004056147602515617	0.0002512343767629098	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.0101	0	16.749218976553	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	11.000555754578897	0	10.999019196951098	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	17.009981134873794	0	16.98123426675586	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.001121468263858065	0	66.19898829448822	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	49.46761043783172	0	3.350255256739096	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	11.210124206399911	0	11.142302954951191	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.07059301286831755	0	39.501936620452554	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.8582244279919717	4.288417360398918	12.055286176477619	3.581308948863681	12.014148856564796	3.569088131391631	0.29707373980483043	\N	\N	\N
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-22T09:00:00.000Z	archival-rpc	135051330	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-22T10:00:00.000Z	archival-rpc	135059326	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x2170ed0880ac9a755fd29b2688956bd959f933f8	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xfceb31a79f71ac9cbdcf853519c1b12d379edc46	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xc5f0f7b66764f6ec8c8dff7ba683102295e16409	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0xb0b84d294e0c75a6abe60171b70edeb2efd14a1b	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
AVALON_LISTA:56:0x0782b6d8c4551b9760e74c0545a9bcd90bdc41e5	2026-11-22T11:00:00.000Z	archival-rpc	135067324	0	0	0	0	0	0	0	\N	\N	\N
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
