-- Generated from MORPHO_BLUE/80094/2026-11.ndjson (12 rows)
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
MORPHO_BLUE_04D3B8B00C6F3B75481492B76139473E2368339EE58587DF65684FDB9103984E:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000356312354662065861525767009	\N	assets_per_share
MORPHO_BLUE_147B032DB82D765B9D971EAC37C8176260DDE0FE91F6A542F20CDD9EDE1054DF:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000001010722371484695553125459	0.000001013021194288980646611923	assets_per_share
MORPHO_BLUE_1BA7904C73D337C39CB88B00180DFFB215FC334A6FF47BBE829CD9EE2AF00C97:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000003325281104487183040791685	0.00000341134053193268071472998	assets_per_share
MORPHO_BLUE_1F05D324F604BD1654EC040311D2AC4F5820ECFD1801A3D19D2C6F09D4F7A614:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000001004127694931562743111416	0.000001004979945140071526472573	assets_per_share
MORPHO_BLUE_63C2A7C20192095C15D1D668CCCE6912999B01EA60EEAFCAC66ECA32015674DD:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000002000006480132062175579304	0.000001000003327721769206010545	assets_per_share
MORPHO_BLUE_950962C1CF2591F15806E938BFDE9B5F9FBBFCC5FB640030952C08B536F1F167:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.000001004447183604464080272106	0.000001005495475668704210663608	assets_per_share
MORPHO_BLUE_04D3B8B00C6F3B75481492B76139473E2368339EE58587DF65684FDB9103984E:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000356312354662065861525767009	\N	assets_per_share
MORPHO_BLUE_147B032DB82D765B9D971EAC37C8176260DDE0FE91F6A542F20CDD9EDE1054DF:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000001010722371484695553125459	0.000001013021194288980646611923	assets_per_share
MORPHO_BLUE_1BA7904C73D337C39CB88B00180DFFB215FC334A6FF47BBE829CD9EE2AF00C97:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000003325281104487183040791685	0.00000341134053193268071472998	assets_per_share
MORPHO_BLUE_1F05D324F604BD1654EC040311D2AC4F5820ECFD1801A3D19D2C6F09D4F7A614:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000001004127694931562743111416	0.000001004979945140071526472573	assets_per_share
MORPHO_BLUE_63C2A7C20192095C15D1D668CCCE6912999B01EA60EEAFCAC66ECA32015674DD:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000002000007976650996253655773	0.000001000004098249576806659311	assets_per_share
MORPHO_BLUE_950962C1CF2591F15806E938BFDE9B5F9FBBFCC5FB640030952C08B536F1F167:80094:0xfcbd14dc51f0a4d49d5e53c2e0950e0bc26d0dce	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.000001004447183604464080272106	0.000001005495475668704210663608	assets_per_share
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
