-- Generated from TECTONIC/25/2026-11.ndjson (18 rows)
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
TECTONIC:25:0xb3bbf1be947b245aef26e3b6a9d777d7703f4c8e	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.001095611144491826	\N	exchange_rate
TECTONIC:25:0x67fd498e94d95972a4a2a44acce00a000af7fe00	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.100955781577248836	\N	exchange_rate
TECTONIC:25:0x543f4db9bd26c9eb6ad4dd1c33522c966c625774	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1013250565.514488084861078228	\N	exchange_rate
TECTONIC:25:0xeadf7c01da7e93fdb5f16b0aa9ee85f978e89e95	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1087145302.663197958517551155	\N	exchange_rate
TECTONIC:25:0xe1c4c56f772686909c28c319079d41adfd6ec89b	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1088771224.457358752857022789	\N	exchange_rate
TECTONIC:25:0xa683fdfd9286eedfea81cf6da14703da683c44e5	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.001098787844630773	\N	exchange_rate
TECTONIC:25:0xfe6934fdf050854749945921faa83191bccf20ad	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1370972834.995940921473197555	\N	exchange_rate
TECTONIC:25:0x4bd41f188f6a05f02b46bb2a1f8ba776e528f9d2	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1134385447.067767110428531268	\N	exchange_rate
TECTONIC:25:0x0d9706531b517d24623118934de69108968ba266	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.001205891047718694	\N	exchange_rate
TECTONIC:25:0x29984c47b0bac5a59290ef082e1f651a7019ec4a	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.001001093600870915	\N	exchange_rate
TECTONIC:25:0xb075a3590c9ffc8332c47db49f5c6ee1dbcdf804	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1230192458.200395656403734754	\N	exchange_rate
TECTONIC:25:0x53b4112cba389302b065d2a92bb249d27f51c680	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.001001235406670398	\N	exchange_rate
TECTONIC:25:0xe3e2cea8dffa592eadab7d9c7f1e0cc6700490aa	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.100556280921778741	\N	exchange_rate
TECTONIC:25:0x6b986d5109cd065e4098664b3e2e34b4028967cd	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1000000000	\N	exchange_rate
TECTONIC:25:0xf4f21a4990acd891d05dface12a2b8f57e61d1ee	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1002984197.089054346088904496	\N	exchange_rate
TECTONIC:25:0xecd4bea6ed20a4a820ae2c4900e5501a985a3fe3	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	0.100149318322426991	\N	exchange_rate
TECTONIC:25:0xbffcd14ed8cb224b26b692d7eb4118ffedfabdbd	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1002766270.187148383494208847	\N	exchange_rate
TECTONIC:25:0x6d1861c723f2ec35d5ae13f470bf197a8258de3e	2026-11-22T11:00:00.000Z	archival-rpc	107368155	\N	\N	\N	\N	\N	\N	\N	1062256065.133859719403345654	\N	exchange_rate
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
