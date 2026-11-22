-- Generated from MORPHO_BLUE/43111/2026-11.ndjson (11 rows)
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
MORPHO_BLUE_08ABB2B634EB6454A5819DBAA5C0229136989A9990ED757727C406DBCB4E606B:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.00000236236142216135287347561	0.000002615888811488316196318504	assets_per_share
MORPHO_BLUE_3338CACEEC16C79D7A1C1252A7331929A47E26D33BAAEBD80ED43CE3A8DD62C1:43111:0xaa40c0c7644e0b2b224509571e10ad20d9c4ef28	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000001584518276914159298536639	0.000014520447694443315076290432	assets_per_share
MORPHO_BLUE_36931AB4FFE6FED55AB0624AFD2BF6EB1CEBDBD6D5C98334E949841E402F86FF:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.00000133590752578485593837777	0.000001340101903776328103967459	assets_per_share
MORPHO_BLUE_40A80A386FBCCFC41F593000833753226897D3D06A2ACCD012DD263FFCEB70A2:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000001	0.000001	assets_per_share
MORPHO_BLUE_4B670128DFAA02A92F833BB9B99949262B685C2D3F55D4F7C97DA1849D2B6355:43111:0xaa40c0c7644e0b2b224509571e10ad20d9c4ef28	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.00000331	\N	assets_per_share
MORPHO_BLUE_6B17E90837B92F5D7339CEB02218F63B14CAF63C6658B704B65B512CD2BA74D0:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000000479878824207823803310749	0.000001098643575762038857465883	assets_per_share
MORPHO_BLUE_7BED4E4AC7B65E9C59011D7ED0D34D1D4ED7E16F578F97C3A3D2236C03C5C1A2:43111:0xbf7d0f62b64b23053949b3a88a03da5bfd35b2e2	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000001002751224775013896227274	0.000001003363256853616770129099	assets_per_share
MORPHO_BLUE_7C985A3BA92FA76A362F661B37A68C9955490EB659B7905AAB6019B91042B452:43111:0xaa40c0c7644e0b2b224509571e10ad20d9c4ef28	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.00000100724825645599036726569	0.000001000556387826642423119993	assets_per_share
MORPHO_BLUE_B412AFB8F34CAC60ABCB456047402FDD3B538836F3F56CE6E3062C11816015FF:43111:0xbf7d0f62b64b23053949b3a88a03da5bfd35b2e2	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000029069165510568241523566835	0.000029117572796974684269236111	assets_per_share
MORPHO_BLUE_B7DD4C2E7C164DE474B28C354CDDB137DEB0CE2583B925D20C33322074C22178:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000001925759367370892581083633	0.000001931254696833331848168643	assets_per_share
MORPHO_BLUE_F1B97D86BAA12EF4622EECA186A49FA7F7EA1AC2AA55EA4C20A26E815DDD6BC6:43111:0xad11a8beb98bbf61dbb1aa0f6d6f2ecd87b35afa	2026-11-22T11:00:00.000Z	archival-rpc	5789874	\N	\N	\N	\N	\N	\N	\N	0.000001882237733210020400335597	0.000001887522197119720339534581	assets_per_share
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
