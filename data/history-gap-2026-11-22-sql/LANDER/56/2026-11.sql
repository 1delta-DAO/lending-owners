-- Generated from LANDER/56/2026-11.ndjson (18 rows)
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
LANDER:56:0x617dd78f430aa23756d3336997d168bd8a6843fe	2026-11-21T20:00:00.000Z	archival-rpc	134947363	5.380095543472407	12.968751125796985	3092.8219701757416	1425.4733515828152	3087.595101046145	1423.0643016186402	0.460897318154338	\N	\N	\N
LANDER:56:0x0a30a5ff808f1a144f2b392d59cabd56d96050e8	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.0143723201471175	7.935841510331443	4.094140619512263	1.1546006883469582	2246.024622805862	633.4080376176238	0.28201295354738115	\N	\N	\N
LANDER:56:0x1fcbd267d4b5858e5094e94ce65d94783f49967d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	3.1463079629645563	9.917799026837315	0.03206846998920348	0.01130267966039819	1931.5343911530183	680.7781750608888	0.352454596811244	\N	\N	\N
LANDER:56:0x9e0847584e6a107784cbeedf585282a281400703	2026-11-21T20:00:00.000Z	archival-rpc	134947363	8.634157817510868	16.428663613510253	1.0809936968198701	0.6311782418751868	1817.9151234014914	1061.4571341557662	0.5838870695842385	\N	\N	\N
LANDER:56:0x6a9008650f1c58ae819f140585d238263b5087e9	2026-11-21T20:00:00.000Z	archival-rpc	134947363	119.60271902786701	132.65189760396368	11184.372208929999	11202.60467754	617.1327414758522	618.1387749953892	1.0016301736270403	\N	\N	\N
LANDER:56:0xb10bde77fca1786eb2693a180b9916600074b815	2026-11-21T20:00:00.000Z	archival-rpc	134947363	5.584121632296046	13.212340767054798	2822.472298480493	1325.3083340492733	2822.0780555498413	1325.1232149811733	0.46955583399800477	\N	\N	\N
LANDER:56:0xfd4aace5e61fb10e017c699e18c79d409651d661	2026-11-21T20:00:00.000Z	archival-rpc	134947363	45.066696227635816	59.798954540113414	2.6367536536880865	2.2075040596534294	523.272859374506	438.0867965272289	0.8372052719319243	\N	\N	\N
LANDER:56:0x6eb2903bd6f8f0f8171d2cb7836e13a599cd9818	2026-11-21T20:00:00.000Z	archival-rpc	134947363	83.55893698563932	100.02834195503851	2159.7236591972487	2004.137399108054	2159.5014236327174	2003.931173369686	0.9279601075690281	\N	\N	\N
LANDER:56:0xdb1d85e89a68fd23ddef13b48634c3105aecfb3f	2026-11-21T20:00:00.000Z	archival-rpc	134947363	11.039387225153519	18.576295781613794	15.027323133249018	9.921563913702496	600.8251384317263	396.68575427915766	0.6602349484154189	\N	\N	\N
LANDER:56:0x617dd78f430aa23756d3336997d168bd8a6843fe	2026-11-22T08:00:00.000Z	archival-rpc	135043334	5.3806165219327795	12.96865869413466	3093.0498862395534	1425.7265916537176	3087.8226319318087	1423.317113713823	0.46094523014210986	\N	\N	\N
LANDER:56:0x0a30a5ff808f1a144f2b392d59cabd56d96050e8	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.014460550370245	7.935574018702596	4.094248342277774	1.1547203803086372	2203.370882558579	621.4271951206432	0.28203476774597064	\N	\N	\N
LANDER:56:0x1fcbd267d4b5858e5094e94ce65d94783f49967d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	3.1465103322858567	9.917566547201773	0.03206977551900952	0.011304130249071564	1893.042150730415	667.2698730352727	0.3524854809903794	\N	\N	\N
LANDER:56:0x9e0847584e6a107784cbeedf585282a281400703	2026-11-22T08:00:00.000Z	archival-rpc	135043334	8.634897971049327	16.428455642270023	1.081111507846088	0.6313091430154288	1792.848849800547	1046.9242651747952	0.583944522312221	\N	\N	\N
LANDER:56:0x6a9008650f1c58ae819f140585d238263b5087e9	2026-11-22T08:00:00.000Z	archival-rpc	135043334	119.6822004541076	132.7163735901138	11202.678494920001	11222.94499531	606.1381384844934	607.2346886377053	1.0018090763203806	\N	\N	\N
LANDER:56:0xb10bde77fca1786eb2693a180b9916600074b815	2026-11-22T08:00:00.000Z	archival-rpc	135043334	5.584668519631464	13.212253937311402	2822.6881792126487	1325.5482015294467	2822.293906127776	1325.3630489566572	0.46960490049566533	\N	\N	\N
LANDER:56:0xfd4aace5e61fb10e017c699e18c79d409651d661	2026-11-22T08:00:00.000Z	archival-rpc	135043334	45.10468704133075	59.84144299446825	2.637820417122513	2.208689352358348	514.2932616623676	430.62599851374176	0.8373160424498169	\N	\N	\N
LANDER:56:0x6eb2903bd6f8f0f8171d2cb7836e13a599cd9818	2026-11-22T08:00:00.000Z	archival-rpc	135043334	83.64589487293017	100.10988628792461	2162.192440615236	2006.8804895724847	2161.9699510130968	2006.6739815701078	0.9281692285453748	\N	\N	\N
LANDER:56:0xdb1d85e89a68fd23ddef13b48634c3105aecfb3f	2026-11-22T08:00:00.000Z	archival-rpc	135043334	11.040249220428677	18.575989076552446	15.029404144192952	9.923876148084645	585.3632687157876	386.5138314627045	0.6602973779182738	\N	\N	\N
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
