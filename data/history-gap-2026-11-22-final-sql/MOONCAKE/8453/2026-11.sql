-- Generated from MOONCAKE/8453/2026-11.ndjson (18 rows)
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
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.008944619484144984	0.21016888546007667	617.205615	37.77247	617.1657311731587	37.7700291429886	0.061199167800830845	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0	2.9818933477625005	0	2.981586510937016	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-21T20:00:00.000Z	archival-rpc	60504126	1.342039568195362	4.816196177807723	0.06471128685181629	0.020614746729407666	108.82545140528386	34.66797258367952	0.31856493252272666	\N	\N	\N
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.008944619484144984	0.21016888546007667	617.205609	37.772461	617.1657251735464	37.77002014357018	0.06119915381391163	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0	2.9818933477625005	0	2.981586510937016	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-21T19:00:00.000Z	archival-rpc	60486126	1.342039568195362	4.816196177807723	0.06471118777226656	0.0206146333911017	108.78222451506652	34.654064545044385	0.31856366883033116	\N	\N	\N
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.008944619484144984	0.21016888546007667	617.205697	37.772588	617.1553453592387	37.76950651227096	0.061199350854339245	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	0	2.9818933477625005	0	2.9822153922440586	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.342039568195362	4.816196177807723	0.06471257488596271	0.02061622018407191	109.01031036567049	34.728653044528684	0.31858136104771084	\N	\N	\N
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.008944619484144984	0.21016888546007667	617.205691	37.772579	617.1553393597283	37.76949751300518	0.06119933686742367	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0	2.9818933477625005	0	2.981586510937016	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-22T08:00:00.000Z	archival-rpc	60720126	1.342039568195362	4.816196177807723	0.06471247580641298	0.02061610683766777	107.31519087094051	34.18848394733753	0.3185800972804802	\N	\N	\N
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.008944619484144984	0.21016888546007667	617.205703	37.772597	617.1553513587493	37.76951551153674	0.06119936484125455	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0	2.9818933477625005	0	2.9811828222155956	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-22T10:00:00.000Z	archival-rpc	60756127	1.342039568195362	4.816196177807723	0.06471267399303453	0.02061633356258438	110.96755948875486	35.35233641082953	0.318582625171747	\N	\N	\N
MOONCAKE:8453:0xd9aaec86b65d86f6a7b5b1b0c42ffa531710b6ca	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.008944619484144984	0.21016888546007667	617.20571	37.772606	617.1553583581781	37.76952451080252	0.061199378729014035	\N	\N	\N
MOONCAKE:8453:0x50c5725949a6f0c72e6c4a641f24049a917db0cb	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	0	2.9818933477625005	0	2.9811828222155956	0	0	\N	\N	\N
MOONCAKE:8453:0x4200000000000000000000000000000000000006	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.342039568195362	4.816196177807723	0.06471277304506216	0.020616446878749063	110.9677293405179	35.3525307223526	0.3185838885994421	\N	\N	\N
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
