-- Generated from VENUS/1/2026-11.ndjson (23 rows)
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
VENUS:1:0x8716554364f20bca783cb2baa744d39361fd1d8d	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.009543133009009387	\N	exchange_rate
VENUS:1:0x7c8ff7d2a1372433726f879bd945ffb250b94c65	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10217695562.600183891954241034	\N	exchange_rate
VENUS:1:0x17c07e0c232f2f80dfdbd7a95b942d893a4c5acb	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	0.011355523035890826	\N	exchange_rate
VENUS:1:0x8c3e3821259b82ffb32b2450a95d2dcbf161c24e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	0.011323888869732585	\N	exchange_rate
VENUS:1:0x672208c10aaaa2f9a6719f449c4c8227bc0bc202	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10650277256.40232885997007865	\N	exchange_rate
VENUS:1:0xd8add9b41d4e1cd64edad8722ab0ba8d35536657	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10960768423.395663000065356697	\N	exchange_rate
VENUS:1:0x13eb80fdbe5c5f4a7039728e258a6f05fb3b912b	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10219848909.890596306655678352	\N	exchange_rate
VENUS:1:0x4fafbdc4f2a9876bd1764827b26fb8dc4fd1db95	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10376229658.408346230243906568	\N	exchange_rate
VENUS:1:0x17142a05fe678e9584fa1d88efac1bf181bf7abe	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10429732304.807929977103820112	\N	exchange_rate
VENUS:1:0x256addbe0a387c98f487e44b85c29eb983413c5e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10020586723.837245553871093537	\N	exchange_rate
VENUS:1:0x325ceb02fe1c2ff816a83a5770ea0e88e2faecf2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1	\N	exchange_rate
VENUS:1:0x25c20e6e110a1ce3febacc8b7e48368c7b2f0c91	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	1.000001180428031073	\N	exchange_rate
VENUS:1:0x0c6b19287999f1e31a5c0a44393b24b62d2c0468	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10028248291.715510911032126166	\N	exchange_rate
VENUS:1:0xe36ae842dbbd7ae372eba02c8239cd431cc063d6	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000000000.000797717396006967	\N	exchange_rate
VENUS:1:0x0ec5488e4f8f319213a14cab188e01fb8517faa8	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10086171526.551967855412186094	\N	exchange_rate
VENUS:1:0xf87c0a64dc3a8622d6c63265fa29137788163879	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	0.01	\N	exchange_rate
VENUS:1:0x475d0c68a8cd275c15d1f01f4f291804e445f677	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	0.01	\N	exchange_rate
VENUS:1:0x520d67226bc904ac122dce66ed2f8f61aa1ed764	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000000000	\N	exchange_rate
VENUS:1:0xba3916302cba4abcb51a01e706fc6051aaf272a0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000000000	\N	exchange_rate
VENUS:1:0xc42e4bfb996ed35235bda505430cbe404eb49f77	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000000008.071489656481407509	\N	exchange_rate
VENUS:1:0xa836ce315b7a6bb19397ee996551659b1d92298e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000000002.511858761686116867	\N	exchange_rate
VENUS:1:0xa0ee2baa024cc3aa1bc9395522d07b7970ca75b3	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10389948693.779572228855495089	\N	exchange_rate
VENUS:1:0x5e35c312862d53fd566737892adcf010cb4928f7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	\N	\N	\N	\N	\N	\N	\N	10000004799.103553970141366098	\N	exchange_rate
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
