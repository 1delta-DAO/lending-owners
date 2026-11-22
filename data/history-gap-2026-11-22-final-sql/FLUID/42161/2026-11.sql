-- Generated from FLUID/42161/2026-11.ndjson (56 rows)
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
FLUID_42161_39:42161:0x0a1a1a107e45b7ced86833863f482bc5f4ed82ef	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	30.000000000004718	0	29.995695300004716	0	0	\N	\N	\N
FLUID_42161_39:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	4.24	0	10.781115813230878	0	10.781115813230878	0	\N	\N	\N
FLUID_42161_28:42161:0x5979d7b546e38e414f7e9822514be443a4800529	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0.015002413654690771	0	31.463661032755944	0	0	\N	\N	\N
FLUID_42161_28:42161:0xddb46999f8891663a8f2828d25298f70416d7610	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	7.000000007	0	7.819311507819311	0	\N	\N	\N
FLUID_42161_42:42161:0x0a1a1a107e45b7ced86833863f482bc5f4ed82ef	2026-11-21T20:00:00.000Z	archival-rpc	526327423	2.05	0	12496.370772495227	0	12494.577668253081	0	0	\N	\N	\N
FLUID_42161_42:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	2.05	0	16051.034468	0	16048.79245950551	0	0	\N	\N	\N
FLUID_42161_42:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	0	26259.461488	0	26215.082998085283	0	\N	\N	\N
FLUID_42161_31:42161:0x0000000000000000000000000000000000000000	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.55	0	161.06591529535106	0	270865.745231735	0	0	\N	\N	\N
FLUID_42161_31:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	4.24	0	153767.2876359702	0	153767.2876359702	0	\N	\N	\N
FLUID_42161_33:42161:0x35751007a407ca6feffe80b3cb397736d2cf4dbe	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	6.1004791064502815	0	11374.069877213526	0	0	\N	\N	\N
FLUID_42161_33:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	4.24	0	8288.130693815847	0	8288.130693815847	0	\N	\N	\N
FLUID_42161_21:42161:0x35751007a407ca6feffe80b3cb397736d2cf4dbe	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0.019990248438671438	0	37.270922272957144	0	0	\N	\N	\N
FLUID_42161_21:42161:0x2f2a2543b76a4166549f7aab2e75bef0aefc5b0f	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	1.03	0	0.00031829	0	19.220674666630945	0	\N	\N	\N
FLUID_42161_75:42161:0x0a1a1a107e45b7ced86833863f482bc5f4ed82ef	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0.09999999999999949	0	0.0999856509999995	0	0	\N	\N	\N
FLUID_42161_75:42161:0x46850ad61c2b7d64d08c9c754f45254596696984	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0.35	0	0.020063	0	0.02005772162533	0	\N	\N	\N
FLUID_42161_64:42161:0x0a1a1a107e45b7ced86833863f482bc5f4ed82ef	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	9.75066542522991	0	9.749266302248044	0	0	\N	\N	\N
FLUID_42161_64:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	13.076003	10.497561	13.05390455493	10.47982012191	0	\N	\N	\N
FLUID_42161_92:42161:0x0b2b2b2076d95dda7817e785989fe353fe955ef9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	20.763470781413393	0	23.414187691879377	0	0	\N	\N	\N
FLUID_42161_92:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	4.24	0	14.64324506917858	0	14.64324506917858	0	\N	\N	\N
FLUID_42161_68:42161:0x0b2b2b2076d95dda7817e785989fe353fe955ef9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	10944387.289586773	0	12341575.301581647	0	0	\N	\N	\N
FLUID_42161_68:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	-0.62	0	9970716.57544	0	9969323.865748744	0	\N	\N	\N
FLUID_42161_68:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	-0.62	0	565395.281834	0	564439.7638077006	0	\N	\N	\N
FLUID_42161_73:42161:0x0b2b2b2076d95dda7817e785989fe353fe955ef9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0.09999999999999999	0	0.11276625154999999	0	0	\N	\N	\N
FLUID_42161_73:42161:0x46850ad61c2b7d64d08c9c754f45254596696984	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0.35	0	0.020064	0	0.020058721362239997	0	\N	\N	\N
FLUID_42161_58:42161:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	3621.8811308855284	0	4553.954058075642	0	0	\N	\N	\N
FLUID_42161_58:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	4.24	0	2488.339913034336	0	2488.339913034336	0	\N	\N	\N
FLUID_42161_60:42161:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	14884.093111626464	0	18714.439755756113	0	0	\N	\N	\N
FLUID_42161_60:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	52068.846431	63826.3099	51980.85008053161	63718.443436269	0	\N	\N	\N
FLUID_42161_13:42161:0x2f2a2543b76a4166549f7aab2e75bef0aefc5b0f	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.01	0	18.34047854	0	1107532.0344580933	0	0	\N	\N	\N
FLUID_42161_13:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	0	621183.804209	0	620134.0035798867	0	\N	\N	\N
FLUID_42161_89:42161:0x76ce01f0ef25aa66cc5f1e546a005e4a63b25609	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	1913183.298341366	0	2133076.836921136	0	0	\N	\N	\N
FLUID_42161_89:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	0	1830270.026163	0	1827176.8698187845	0	\N	\N	\N
FLUID_42161_67:42161:0x0b2b2b2076d95dda7817e785989fe353fe955ef9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.58	0	6285812.934294274	0	7088275.625448717	0	0	\N	\N	\N
FLUID_42161_67:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.58	6.83	708.400137	6175177.518144	708.3011876688638	6174314.969348266	0	\N	\N	\N
FLUID_42161_70:42161:0x0000000000000000000000000000000000000000	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.55	0	0.00010014871288023	0	0.1684208337844744	0	0	\N	\N	\N
FLUID_42161_70:42161:0x46850ad61c2b7d64d08c9c754f45254596696984	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0.35	0	0.020062	0	0.02005672188842	0	\N	\N	\N
FLUID_42161_20:42161:0x5979d7b546e38e414f7e9822514be443a4800529	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	32.00765391304709	0	67127.73000089871	0	0	\N	\N	\N
FLUID_42161_20:42161:0x2f2a2543b76a4166549f7aab2e75bef0aefc5b0f	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	1.03	0	0.88860009	0	53660.162866030914	0	\N	\N	\N
FLUID_42161_97:42161:0x6760e0064eee21c89c21f6c00b752e37cb1cd6de	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0.0650369572	0	40.12225096629681	0	0	\N	\N	\N
FLUID_42161_97:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	6.07	0	24.670574	0	24.62888072994	0	\N	\N	\N
FLUID_42161_41:42161:0x0a1a1a107e45b7ced86833863f482bc5f4ed82ef	2026-11-21T20:00:00.000Z	archival-rpc	526327423	2.05	0	35456.595121412225	0	35451.507454578255	0	0	\N	\N	\N
FLUID_42161_41:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	2.05	6.83	45542.42514	74234.433668	45536.06377405645	74224.06460230525	0	\N	\N	\N
FLUID_42161_93:42161:0x004b506865409877c9fa29bfb1eba929984b9bbc	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.06	0	2482983.406975	0	2482759.9384683724	0	0	\N	\N	\N
FLUID_42161_93:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0.06	6.83	2541259.654151	4046654.725533	2540904.691002508	4046089.488800938	0	\N	\N	\N
FLUID_42161_24:42161:0x5979d7b546e38e414f7e9822514be443a4800529	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	44.942134135979956	0	94254.43845837415	0	0	\N	\N	\N
FLUID_42161_24:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	-0.62	0	52265.471828	0	52258.17138689507	0	\N	\N	\N
FLUID_42161_24:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	-0.62	0	2963.743974	0	2958.73524668394	0	\N	\N	\N
FLUID_42161_29:42161:0x35751007a407ca6feffe80b3cb397736d2cf4dbe	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0.017	0	31.68081354376	0	0	\N	\N	\N
FLUID_42161_29:42161:0xddb46999f8891663a8f2828d25298f70416d7610	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	7.000000007	0	7.819311507819311	0	\N	\N	\N
FLUID_42161_47:42161:0x66cfbd79257dc5217903a36293120282548e2254	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0.016999999996382718	0	0.00963021234945087	0	0	\N	\N	\N
FLUID_42161_47:42161:0x7dff72693f6a4149b17e7c6314655f6a9f7c8b33	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	4.24	0	0.0150993087181835	0	0.0150993087181835	0	\N	\N	\N
FLUID_42161_25:42161:0x35751007a407ca6feffe80b3cb397736d2cf4dbe	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	9.161744734243593	0	17073.6192153586	0	0	\N	\N	\N
FLUID_42161_25:42161:0xaf88d065e77c8cc2239327c5edb3a432268e5831	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	-0.62	0	4512.157768	0	4511.51031848187	0	\N	\N	\N
FLUID_42161_25:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	-0.62	0	255.86453	0	255.43211894430002	0	\N	\N	\N
FLUID_42161_11:42161:0x912ce59144191c1204e64559fe8253a0e49e6548	2026-11-21T19:00:00.000Z	archival-rpc	526315886	1.48	0	206672.89609362846	0	23419.53396608105	0	0	\N	\N	\N
FLUID_42161_11:42161:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	6.07	0	11787.941005	0	11768.01938470155	0	\N	\N	\N
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
