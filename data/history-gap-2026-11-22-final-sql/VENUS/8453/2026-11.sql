-- Generated from VENUS/8453/2026-11.ndjson (30 rows)
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
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.004419914034770045	0.28787491110904284	0.36226499	0.0069522	21797.593127797	418.31595966000003	0.019190924301020644	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-21T20:00:00.000Z	archival-rpc	60504126	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8217.933095984043	6718.578013732482	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-21T20:00:00.000Z	archival-rpc	60504126	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.45647716614	8620.816324155887	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	298.7738512242544	0.042185346294921225	0	79.13129536363958	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6427.854515863489	3.237482481573114	0.0005036645545699949	\N	\N	\N
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.004419914034770045	0.28787491110904284	0.36226499	0.0069522	21731.90470395527	417.0553380906	0.019190924301020644	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-21T19:00:00.000Z	archival-rpc	60486126	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8214.681403169072	6715.919589576564	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-21T19:00:00.000Z	archival-rpc	60486126	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.359908918304	8620.783474257218	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	298.7738512242544	0.042185346294921225	0	78.86333807288574	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6427.854515863489	3.237482481573114	0.0005036645545699949	\N	\N	\N
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.004185333679629366	0.28014286250765963	0.37226500999999995	0.00695222	22243.020480004998	415.39862111	0.01867545918430529	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8231.728837968529	6729.856734025956	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.45647716614	8620.816324155887	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	298.7738512242544	0.042185346294921225	0	78.93299062202284	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6452.684597305107	3.249988513482343	0.0005036645545699949	\N	\N	\N
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.004185333679629366	0.28014286250765963	0.37226500999999995	0.00695222	21977.79452831197	410.44540467453834	0.01867545918430529	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-22T08:00:00.000Z	archival-rpc	60720126	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8103.737169588418	6625.217039460934	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-22T08:00:00.000Z	archival-rpc	60720126	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.45647716614	8620.816324155887	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	298.7738512242544	0.042185346294921225	0	78.13718813071938	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6352.35453498684	3.199455817334833	0.0005036645545699949	\N	\N	\N
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.004185333679629366	0.28014286250765963	0.37226500999999995	0.00695222	22722.66235401942	424.35615335124004	0.01867545918430529	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-22T10:00:00.000Z	archival-rpc	60756127	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8379.514355181595	6850.678906109712	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-22T10:00:00.000Z	archival-rpc	60756127	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.45647716614	8620.816324155887	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	298.7738512242544	0.042185346294921225	0	78.93299062202284	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6555.660626263767	3.3018538892391938	0.0005036645545699949	\N	\N	\N
VENUS:8453:0x7bbd1005bb24ec84705b04e1f2dfccad533b6d72	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.004185333679629366	0.28014286250765963	0.37226500999999995	0.00695222	22722.66235401942	424.35615335124004	0.01867545918430529	\N	\N	\N
VENUS:8453:0xeb8a79bd44cf4500943bf94a2b4434c95c008599	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.704356524712125	2.4525747257087005	4.886660418460141	3.9950932752284385	8379.514355181595	6850.678906109712	0.8175508288106812	\N	\N	\N
VENUS:8453:0x3cb752d175740043ec463673094e06acda2f9a2e	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.0415017648313096	3.401760367793827	25345.996806	8622.020648	25342.45647716614	8620.816324155887	0.3401728767660447	\N	\N	\N
VENUS:8453:0x75201d81b3b0b9d17b179118837be37f64fc4930	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	298.7738512242544	0.042185346294921225	0	78.93299062202284	0	0	\N	\N	\N
VENUS:8453:0x133d3bcd77158d125b75a17cb517ffd4b4be64c5	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.0000014004797321831575	0.004557161048523994	3.0649113673949793	0.001543687218655506	6555.660626263767	3.3018538892391938	0.0005036645545699949	\N	\N	\N
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
