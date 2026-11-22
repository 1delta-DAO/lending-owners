-- Generated from AVALON_EBTC_LBTC/1/2026-11.ndjson (36 rows)
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
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	100.87066707599999	3.918327118	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.8668540703811549	2.2256351522092843	0.00553335	0.00314876	333.66687015517476	189.87356557416538	0.5690512980382589	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00110131	0	66.04285147494409	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00118479	0	71.04894171395792	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00116972	0	70.14523088619153	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.00103	0	62.1614812066855	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	101.49777110867436	3.942687011795327	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.8668540703811549	2.2256351522092843	0.00553336	0.00314877	333.04989476221795	189.5227343115989	0.569052076857461	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00110131	0	66.30811190269	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00118479	0	71.33430905121	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00116972	0	70.42696847827999	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.00103	0	62.349374986808	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	100.6503943187658	3.9097706095219005	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.8668540703811549	2.2256351522092843	0.00553343	0.00314887	332.0679948091968	188.96759276160276	0.5690629501050886	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00110131	0	65.8060288051994	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00118479	0	70.79416773489045	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00116972	0	69.8936975184261	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.00103	0	61.9143718769778	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	102.817850706	3.993965583	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.8668540703811549	2.2256351522092843	0.00553343	0.00314888	337.58435512165	192.1073591164	0.5690647573024328	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00110131	0	67.27756901452166	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00118479	0	72.37725163007246	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00116972	0	71.45664529302944	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.00103	0	63.249474966161	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	99.4502382228002	3.8631504739267633	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.8668540703811549	2.2256351522092843	0.00553342	0.00314887	326.02768367078795	185.53061077605423	0.5690639785159991	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00110131	0	64.97126676543559	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00118479	0	69.89613020041625	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00116972	0	69.00708262057486	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.00103	0	61.17610441823631	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.004557686092118933	0.16138128926928214	0.00168078	0.00006529	102.817850706	3.993965583	0.03884506003165197	\N	\N	\N
AVALON_EBTC_LBTC:1:0x657e8c867d8b37dcc18fa4caead9c45eb088c642	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.8668540703811549	2.2256351522092843	0.00553344	0.00314889	337.5849652032	192.10796919795	0.5690655360860514	\N	\N	\N
AVALON_EBTC_LBTC:1:0x332a8ee60edff0a11cf3994b1b846bbc27d3dcd6	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00110131	0	67.27756901452166	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xb997b3418935a1df0f914ee901ec83927c1509a0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00118479	0	72.37725163007246	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0xec5a52c685cc3ad79a6a347abace330d69e0b1ed	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00116972	0	71.45664529302944	0	0	\N	\N	\N
AVALON_EBTC_LBTC:1:0x8236a87084f8b84306f72007f36f2618a5634494	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.00103	0	63.249474966161	0	0	\N	\N	\N
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
