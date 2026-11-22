-- Generated from AAVE_V3/43114/2026-11.ndjson (18 rows)
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
AAVE_V3:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.169695520784059579650107129	1.284238500509140479651860544	ray
AAVE_V3:43114:0x5947bb275c521040051d82396192181b413227a3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.003080563115562410756593287	1.036232496873943704291680104	ray
AAVE_V3:43114:0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.219836427397381376807744027	1.305430257811264171810869071	ray
AAVE_V3:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.003842665187534433940459642	1.042965748094204436489405046	ray
AAVE_V3:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.063803283276421012532232396	1.139079526013975472358744442	ray
AAVE_V3:43114:0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.22821738053487635954210376	1.323352009053373256950172252	ray
AAVE_V3:43114:0x63a72806098bd3d9520cc43356dd78afe5d386d9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000629242504075329188490954	1	ray
AAVE_V3:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.0857659859556462009248382	1.243648933270916008970739566	ray
AAVE_V3:43114:0x2b2c81e08f1af8835a78bb2a90ae924ace0ea4be	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.00140270675835283087481267	1	ray
AAVE_V3:43114:0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.535518217509525462689516174	1.7606478810836496489321346	ray
AAVE_V3:43114:0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.094722181319873292822805331	5.644760641189324758929781135	ray
AAVE_V3:43114:0x152b9d0fdc40c096757f570a51e494bd4b943e50	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.003625517335774352988914166	1.029930627454415132399725793	ray
AAVE_V3:43114:0x00000000efe302beaa2b3e6e1b18d08d69a9012a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.089396223384510524309121412	1.120570113315306341243226096	ray
AAVE_V3:43114:0xfc421ad3c883bf9e7c4f42de845c4e4405799e73	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.072421285450068585808347777	1.096026847956883683388089221	ray
AAVE_V3:43114:0xc891eb4cbdeff6e073e859e987815ed1505c2acd	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.038770342275282118920542522	1.059596208708675389828144176	ray
AAVE_V3:43114:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.03090351587132798224948724	1.064516687904862614051734693	ray
AAVE_V3:43114:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	1	ray
AAVE_V3:43114:0x7bfd4ca2a6cf3a3fddd645d10b323031afe47ff0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	1	ray
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
