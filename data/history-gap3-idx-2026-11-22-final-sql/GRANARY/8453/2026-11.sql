-- Generated from GRANARY/8453/2026-11.ndjson (35 rows)
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
GRANARY:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.048380106407064945192756009	1.072154096660647423041538929	ray
GRANARY:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.194407212045829922145934651	1.285986719618303707330831577	ray
GRANARY:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.01126098166347660837017839	1.026991062476324073381314286	ray
GRANARY:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.058485716273119487846178775	1.101209232025719693668318183	ray
GRANARY:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	5267.141069343933569890642535565	1.010880532569824196295933969	ray
GRANARY:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.011168558149740163434328583	1.023648990203366884196348771	ray
GRANARY:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	1.054849797087832822962513947	1.087241363002316962139246529	ray
GRANARY:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.048380106407064945192756009	1.072154096660647423041538929	ray
GRANARY:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.194407212045829922145934651	1.285986719618303707330831577	ray
GRANARY:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.01126098166347660837017839	1.026991062476324073381314286	ray
GRANARY:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.058485716273119487846178775	1.101209232025719693668318183	ray
GRANARY:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	5267.141069343933569890642535565	1.010880532569824196295933969	ray
GRANARY:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.011168558149740163434328583	1.023648990203366884196348771	ray
GRANARY:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	1.054849797087832822962513947	1.087241363002316962139246529	ray
GRANARY:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.048380106407064945192756009	1.072154096660647423041538929	ray
GRANARY:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.194407212045829922145934651	1.285986719618303707330831577	ray
GRANARY:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.01126098166347660837017839	1.026991062476324073381314286	ray
GRANARY:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.058485716273119487846178775	1.101209232025719693668318183	ray
GRANARY:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	5267.141069343933569890642535565	1.010880532569824196295933969	ray
GRANARY:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.011168558149740163434328583	1.023648990203366884196348771	ray
GRANARY:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	1.054849797087832822962513947	1.087241363002316962139246529	ray
GRANARY:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.048380106407064945192756009	1.072154096660647423041538929	ray
GRANARY:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.194407212045829922145934651	1.285986719618303707330831577	ray
GRANARY:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.01126098166347660837017839	1.026991062476324073381314286	ray
GRANARY:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.058485716273119487846178775	1.101209232025719693668318183	ray
GRANARY:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	5267.141069343933569890642535565	1.010880532569824196295933969	ray
GRANARY:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.011168558149740163434328583	1.023648990203366884196348771	ray
GRANARY:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	1.054849797087832822962513947	1.087241363002316962139246529	ray
GRANARY:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.048380106407064945192756009	1.072154096660647423041538929	ray
GRANARY:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.194407212045829922145934651	1.285986719618303707330831577	ray
GRANARY:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.01126098166347660837017839	1.026991062476324073381314286	ray
GRANARY:8453:0x2ae3f1ec7f1f5012cfeab0185bfc7aa3cf0dec22	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.058485716273119487846178775	1.101209232025719693668318183	ray
GRANARY:8453:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	5267.141069343933569890642535565	1.010880532569824196295933969	ray
GRANARY:8453:0x940181a94a35a4569e4529a3cdfb74e38fd98631	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.011168558149740163434328583	1.023648990203366884196348771	ray
GRANARY:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	1.054849797087832822962513947	1.087241363002316962139246529	ray
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
