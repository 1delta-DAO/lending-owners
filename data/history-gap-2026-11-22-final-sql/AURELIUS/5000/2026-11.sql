-- Generated from AURELIUS/5000/2026-11.ndjson (11 rows)
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
AURELIUS:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.267517101127162	1.6355950022152856	681.575613	223.279699	681.4804105183762	223.24851129164367	0.32759343899823484	\N	\N	\N
AURELIUS:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.08684300587828897	0.9318959484743401	857.710833	159.914223	856.30418723388	159.65196367427998	0.1864430491575708	\N	\N	\N
AURELIUS:5000:0xcabae6f6ea1ecab08ad02fe02ce9a44f09aebfa2	2026-11-22T11:00:00.000Z	archival-rpc	103607444	1.052283416528813	4.103234658712724	0.00451218	0.00236798	276.022233486	144.85573014599998	0.5247973263477964	\N	\N	\N
AURELIUS:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.7080090356040836	3.3657309116543077	1.1676377570100382	0.49168894885571973	2002.2339407003058	843.1350354643553	0.4210971646846914	\N	\N	\N
AURELIUS:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.000720691166936455	0.1497381146246887	1112.240567676957	10.707188803830778	440.3785394553982	4.2393851691207995	0.009626684293842995	\N	\N	\N
AURELIUS:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.000010561110815016	0.012999145088822994	5.359213587297834	0.008708175715419443	10129.283945732146	16.459053746220967	0.0016248980514714264	\N	\N	\N
AURELIUS:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.031143110335435275	0.5580601252144367	281.5798977352136	31.586808718984578	281.11810670292783	31.535006352685443	0.11217707291266774	\N	\N	\N
AURELIUS:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.027806199597609733	0.5273158408165806	1246.8375473982326	131.7396401377839	1439.000773622022	152.04341934563925	0.10565902543814479	\N	\N	\N
AURELIUS:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T11:00:00.000Z	archival-rpc	103607444	3.913172994842241	12.413801805478162	0.031038740000000002	0.02100493	1883.968137701576	1274.9428248263932	0.6767326895357222	\N	\N	\N
AURELIUS:5000:0xe6829d9a7ee3040e1276fa75293bde931859e8fa	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.000007905915084561	0.011246983655761943	0.5130873361474169	0.000721340264883874	963.928393186139	1.35516960463472	0.0014058820283894577	\N	\N	\N
AURELIUS:5000:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-22T11:00:00.000Z	archival-rpc	103607444	44.60306664165228	93.4490690152346	49.100541993828195	46.9827005940502	61.74487919769943	59.081652763139594	0.9568672500591908	\N	\N	\N
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
