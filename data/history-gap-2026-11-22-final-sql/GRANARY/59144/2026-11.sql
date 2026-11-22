-- Generated from GRANARY/59144/2026-11.ndjson (30 rows)
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
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0.18360430852365867	0.9581823177003888	39.503962475208965	7.479798143107235	39.49989751747027	7.479028471878309	0.18934298420826123	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0.9416488720323365	2.169957426237863	1058.467385	459.485202	1058.319538275663	459.42102110698465	0.4341042610396541	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-21T20:00:00.000Z	archival-rpc	32675911	1.841274248121342	3.034351985153286	111.250646	67.581518	111.06263240826	67.46730523458001	0.6074707916752232	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-21T20:00:00.000Z	archival-rpc	32675911	1.0924531908228665	4.122549677477927	1.6352006599339275	0.4334233435502414	2749.929086760744	728.8912538465238	0.26505819999348246	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	12.160795074825286	1.135281296090552	0.09335584467176482	\N	\N	\N
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0.18360430852365867	0.9581823177003888	39.50395430278795	7.479789970686222	39.499889345890196	7.479020300298239	0.18934281650276066	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0.9416488720323365	2.169957426237863	1058.466248	459.484065	1058.3143686780745	459.4181336315131	0.434103653156827	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-21T19:00:00.000Z	archival-rpc	32675585	1.841274248121342	3.034351985153286	111.250412	67.581284	111.06239880372	67.46707163004	0.6074699660438111	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-21T19:00:00.000Z	archival-rpc	32675585	1.0924531908228665	4.122549677477927	1.6351986224684913	0.4334213060848054	2748.8375627116775	728.5994192234134	0.2650572842524254	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	12.085659596	1.12826696	0.09335584467176482	\N	\N	\N
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0.18360430852365867	0.9581823177003888	39.5040688243098	7.479904492208063	39.50833526374282	7.480712321893222	0.18934516658205902	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0.9416488720323365	2.169957426237863	1058.48218	459.499997	1058.3343312090976	459.4358140404191	0.4341121708822722	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T09:00:00.000Z	archival-rpc	32679553	1.841274248121342	3.034351985153286	111.253689	67.584561	111.07123295004	67.47372231995999	0.6074815280956661	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T09:00:00.000Z	archival-rpc	32679553	1.0924531908228665	4.122549677477927	1.6352271744877043	0.4334498581040182	2754.590156911683	730.1595345748531	0.26507011678044823	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	12.0592679636318	1.125803146868	0.09335584467176482	\N	\N	\N
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0.18360430852365867	0.9581823177003888	39.50406065177268	7.479896319670947	39.499995683931616	7.479126638339652	0.18934499887507888	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0.9416488720323365	2.169957426237863	1058.481043	459.49886	1058.3331943679138	459.4346771992352	0.43411156301643844	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T08:00:00.000Z	archival-rpc	32679102	1.841274248121342	3.034351985153286	111.253455	67.584327	111.06543666105	67.47010948737001	0.6074807025094187	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T08:00:00.000Z	archival-rpc	32679102	1.0924531908228665	4.122549677477927	1.6352251368976296	0.43344782051394365	2711.7568211744806	718.8032139304637	0.2650692010130706	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	11.91547315728858	1.112379061262416	0.09335584467176482	\N	\N	\N
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0.18360430852365867	0.9581823177003888	39.50407701958262	7.4799126874808834	39.49466398811039	7.47813037388571	0.18934533475552426	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0.9416488720323365	2.169957426237863	1058.48332	459.501137	1058.3354710498625	459.43695388118385	0.4341127803506625	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T10:00:00.000Z	archival-rpc	32679970	1.841274248121342	3.034351985153286	111.253924	67.584796	111.07146756464	67.47395693456	0.6074823572065646	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T10:00:00.000Z	archival-rpc	32679970	1.0924531908228665	4.122549677477927	1.6352292177536651	0.43345190136997924	2804.047249204405	743.2717068060626	0.26507103509648483	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	12.318958325999999	1.15004676	0.09335584467176482	\N	\N	\N
GRANARY:59144:0x4af15ec2a0bd43db75dd04e62faa3b8ef36b00d5	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.18360430852365867	0.9581823177003888	39.504085212591725	7.479920880489994	39.49467217916727	7.47813856494259	0.18934550288246663	\N	\N	\N
GRANARY:59144:0x176211869ca2b568f2a7d4ee941e073a821ee1ff	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.9416488720323365	2.169957426237863	1058.48446	459.502277	1058.336610890627	459.43809372194863	0.43411338981774	\N	\N	\N
GRANARY:59144:0xa219439258ca9da29e9cc4ce5596924745e12b93	2026-11-22T11:00:00.000Z	archival-rpc	32680425	1.841274248121342	3.034351985153286	111.254158	67.58503	111.07170118088001	67.4741905508	0.6074831827858514	\N	\N	\N
GRANARY:59144:0xe5d7c2a44ffddf6b295a15c148167daaaf5cf34f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	1.0924531908228665	4.122549677477927	1.6352312604626245	0.4334539440789384	2804.0507519869975	743.2752095886547	0.26507195315989107	\N	\N	\N
GRANARY:59144:0x3aab2285ddcddad8edf438c1bab47e1a9d05a9b4	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.1313997902446956	1.4297556285022712	0.00020138	0.0000188	12.318958325999999	1.15004676	0.09335584467176482	\N	\N	\N
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
