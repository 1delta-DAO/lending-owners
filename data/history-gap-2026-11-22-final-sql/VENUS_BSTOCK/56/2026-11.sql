-- Generated from VENUS_BSTOCK/56/2026-11.ndjson (10 rows)
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
VENUS_BSTOCK:56:0xea0096142fbb56aac0f594ed1d4de3e4de638f22	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.7044735163219684	2.6107323023438767	25268.187343869165	7575.699088676055	25225.484107258028	7562.8961572161925	0.29981173503188197	\N	\N	\N
VENUS_BSTOCK:56:0x6adb5e462ac6ea880246f24e3c47d23f70fccbf6	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.661613831733689	4.153778070303815	7034.978380339271	5008.5626411025705	7033.995734559106	5007.8630450728615	0.7119513906538866	\N	\N	\N
VENUS_BSTOCK:56:0x713bbaa44dc99e691f1f9fe8086fc328e94b6f27	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.7177913783351642	2.625513665677204	15011.441344956056	4559.871853104857	14990.941396408252	4553.644793609025	0.30375976219212314	\N	\N	\N
VENUS_BSTOCK:56:0xea32b70f4106d9ef6f0ff95f7422fa679494c362	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	11.502230169879146	0	7145.72052970502	0	0	\N	\N	\N
VENUS_BSTOCK:56:0x259311a868b49cda457c1843f89d4dda33be0390	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	24.755651188351237	0	17343.622613853706	0	0	\N	\N	\N
VENUS_BSTOCK:56:0xea0096142fbb56aac0f594ed1d4de3e4de638f22	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.7044237992914759	2.610473913833289	25268.451059152703	7575.992105657766	25225.747376862735	7563.188678999205	0.29982020219294764	\N	\N	\N
VENUS_BSTOCK:56:0x6adb5e462ac6ea880246f24e3c47d23f70fccbf6	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.6614107621725225	4.153373331661214	7035.244461760491	5008.858287126149	7034.261778814072	5008.158649800603	0.7119664873554	\N	\N	\N
VENUS_BSTOCK:56:0x713bbaa44dc99e691f1f9fe8086fc328e94b6f27	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.7177122512302958	2.6252223658929097	15011.441344956056	4559.871853104857	14992.707042139244	4554.181125736387	0.30375976219212314	\N	\N	\N
VENUS_BSTOCK:56:0xea32b70f4106d9ef6f0ff95f7422fa679494c362	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	11.502230169879146	0	7123.007028590309	0	0	\N	\N	\N
VENUS_BSTOCK:56:0x259311a868b49cda457c1843f89d4dda33be0390	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	24.755651188351237	0	17319.744391442448	0	0	\N	\N	\N
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
