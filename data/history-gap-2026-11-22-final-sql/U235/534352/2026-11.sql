-- Generated from U235/534352/2026-11.ndjson (24 rows)
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
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-21T19:00:00.000Z	archival-rpc	35813204	54.39999906231044	63.999999003164895	604.285322	606.573185	603.26407980582	605.54807631735	1.0037860641599368	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-21T19:00:00.000Z	archival-rpc	35813204	54.39999207970365	63.99999158012426	69.777499	71.812868	69.7674866266685	71.80256357157067	1.0291694174937396	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-21T19:00:00.000Z	archival-rpc	35813204	0.016762333984341148	0.5709065351857031	0.893332710328645	0.032805360588053674	1501.729806036286	55.14718897366292	0.036722444178703614	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-21T19:00:00.000Z	archival-rpc	35813204	238.4307825596871	301.2267499866449	0.08630559615035224	1.334526098038102	181.00354283029404	2798.8214266381488	15.462799141242654	\N	\N	\N
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-21T20:00:00.000Z	archival-rpc	35813499	54.39999906231044	63.999999003164895	604.322303	606.617146	603.3009983079301	605.5919630232601	1.0037973826029718	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-21T20:00:00.000Z	archival-rpc	35813499	54.39999207970365	63.99999158012426	69.78177	71.818072	69.7720228823664	71.80804045170304	1.0291810024308643	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-21T20:00:00.000Z	archival-rpc	35813499	0.016762333984341148	0.5709065351857031	0.8933327272846926	0.032805381795733585	1502.3242780581693	55.16905405727047	0.03672246722164358	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-21T20:00:00.000Z	archival-rpc	35813499	238.4307825596871	301.2267499866449	0.08632488848971015	1.3349803189702294	181.04400349482827	2799.77403691616	15.464605194704165	\N	\N	\N
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-22T09:00:00.000Z	archival-rpc	35817884	54.39999906231044	63.999999003164895	604.807077	607.193703	603.81519339372	606.1979053270801	1.0039460946982273	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T09:00:00.000Z	archival-rpc	35817884	54.39999207970365	63.99999158012426	69.837747	71.886331	69.82799206349904	71.87628991728592	1.0293334777824377	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-22T09:00:00.000Z	archival-rpc	35817884	0.016762333984341148	0.5709065351857031	0.893332949555636	0.03280565980111849	1504.8466586679385	55.262136655394585	0.036722769284886186	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T09:00:00.000Z	archival-rpc	35817884	238.4307825596871	301.2267499866449	0.08657778507265138	1.3409485065951738	182.27578981571716	2823.1543222864348	15.488366969308844	\N	\N	\N
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-22T08:00:00.000Z	archival-rpc	35817296	54.39999906231044	63.999999003164895	604.769464	607.148949	603.74740360584	606.12286727619	1.003934532316268	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T08:00:00.000Z	archival-rpc	35817296	54.39999207970365	63.99999158012426	69.833404	71.881033	69.82364967012929	71.87099265731057	1.0293216266530556	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-22T08:00:00.000Z	archival-rpc	35817296	0.016762333984341148	0.5709065351857031	0.8933329323099445	0.032805638230985354	1481.4484061609364	54.40285330656955	0.03672274584813284	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T08:00:00.000Z	archival-rpc	35817296	238.4307825596871	301.2267499866449	0.0865581631805909	1.3404845136896018	179.4009922341411	2778.296615752804	15.486517555748932	\N	\N	\N
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-22T10:00:00.000Z	archival-rpc	35818485	54.39999906231044	63.999999003164895	604.844514	607.238251	603.8525689970401	606.24238026836	1.003957607194235	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T10:00:00.000Z	archival-rpc	35818485	54.39999207970365	63.99999158012426	69.84207	71.891605	69.83231445966241	71.8815631806136	1.029345278569206	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-22T10:00:00.000Z	archival-rpc	35818485	0.016762333984341148	0.5709065351857031	0.8933329667206071	0.032805681270304185	1531.8634358781865	56.254303265592895	0.03672279261195593	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T10:00:00.000Z	archival-rpc	35818485	238.4307825596871	301.2267499866449	0.08659731512215539	1.3414104832112612	185.22643595041012	2869.1961477241134	15.490208689715711	\N	\N	\N
U235:534352:0xf55bec9cafdbe8730f096aa55dad6d22d44099df	2026-11-22T11:00:00.000Z	archival-rpc	35818810	54.39999906231044	63.999999003164895	604.881827	607.282654	603.8898208037201	606.28671044744	1.0039690843613325	\N	\N	\N
U235:534352:0x06efdbff2a14a7c8e15944d1f4a48f9f95f663a4	2026-11-22T11:00:00.000Z	archival-rpc	35818810	54.39999207970365	63.99999158012426	69.846378	71.896862	69.83662185792096	71.88681944631584	1.0293570555655727	\N	\N	\N
U235:534352:0x5300000000000000000000000000000000000004	2026-11-22T11:00:00.000Z	archival-rpc	35818810	0.016762333984341148	0.5709065351857031	0.893332983828599	0.03280570266823684	1531.8634652145126	56.25433995819449	0.03672281586160617	\N	\N	\N
U235:534352:0xf610a9dfb7c89644979b4a0f27063e9e7d7cda32	2026-11-22T11:00:00.000Z	archival-rpc	35818810	238.4307825596871	301.2267499866449	0.08661678034161956	1.3418710806843077	185.26807088125358	2870.1813379487735	15.492045252570254	\N	\N	\N
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
