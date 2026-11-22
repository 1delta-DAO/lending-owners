-- Generated from GEARBOX_V3/42793/2026-11.ndjson (42 rows)
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
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0.41318566091911857	1.3040475904254247	1194104.571192	501745.829557	1193937.778665496	501675.7456995275	0.3805128868726423	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-21T20:00:00.000Z	archival-rpc	58586904	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0.41318566091911857	1.3040475904254247	1194104.571192	501745.829557	1193933.2291270797	501673.83404791687	0.3805128868726423	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-21T19:00:00.000Z	archival-rpc	58584250	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0.413185654910013	1.3040475904254247	1194104.569253	501745.829557	1193937.7767267667	501675.7456995275	0.3805128958820629	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-22T10:00:00.000Z	archival-rpc	58630943	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0.413185654910013	1.3040475904254247	1194104.569253	501745.829557	1193937.7767267667	501675.7456995275	0.3805128958820629	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-22T11:00:00.000Z	archival-rpc	58635123	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0.413185654910013	1.3040475904254247	1194104.569253	501745.829557	1193937.7767267667	501675.7456995275	0.3805128958820629	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-22T08:00:00.000Z	archival-rpc	58621598	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x796ea11fa2dd751ed01b53c372ffdb4aaa8f00f9	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0.413185654910013	1.3040475904254247	1194104.569253	501745.829557	1193937.7767267667	501675.7456995275	0.3805128958820629	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x2247b5a46bb79421a314ab0f0b67ffd11dd37ee4	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0xdd629e5241cbc5919847783e6c96b2de4754e438	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x0714027e44802b2ff76389daf5371990cc3a4c24	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x942644106b073e30d72c2c5d7529d5c296ea91ab	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x733d504435a49fc8c4e9759e756c2846c92f0160	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
GEARBOX_V3_F6F9BB0BE5128BF6D02DE00BBA9C34B132C2C8EE:42793:0x5d37f9b272ca7cda2a05245b9a503746eefac88f	2026-11-22T09:00:00.000Z	archival-rpc	58626519	0	0	0	0	0	0	0	\N	\N	\N
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
