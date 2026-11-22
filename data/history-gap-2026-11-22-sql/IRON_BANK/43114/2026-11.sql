-- Generated from IRON_BANK/43114/2026-11.ndjson (22 rows)
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
IRON_BANK:43114:0xb3c68d69e95b095ab4b33b4cb67dbc0fbf3edf56	2026-11-21T20:00:00.000Z	archival-rpc	101007806	87.69877117948965	96.48373545552147	4791.081022712371	5122.732767226692	31749.8709532495	33947.68393946957	1.069222737612265	\N	\N	\N
IRON_BANK:43114:0x338eee1f7b89ce6272f302bdc4b952c13b221f1d	2026-11-21T20:00:00.000Z	archival-rpc	101007806	95.93229516049462	109.4654914361115	3.969308297288994	4.347423018039281	6675.215224947876	7311.093557314526	1.0952596000186068	\N	\N	\N
IRON_BANK:43114:0xceb1ce674f38398432d20bc8f90345e91ef46fd3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	253.5139770238004	250.4125964506443	14585.261716999968	17372.387583	14560.612624698239	17343.02824798473	1.191091933767049	\N	\N	\N
IRON_BANK:43114:0xe28965073c49a02923882b8329d3e8c1d805e832	2026-11-21T20:00:00.000Z	archival-rpc	101007806	115.13740774233838	129.13938449798934	54689.85323999985	57353.803042	54682.21416129929	57345.79186279109	1.048710128921168	\N	\N	\N
IRON_BANK:43114:0x085682716f61a72bf8c573fbaf88cca68c60e99b	2026-11-21T20:00:00.000Z	archival-rpc	101007806	217.68798078376506	221.722918345435	4258.457292711607	4918.5060104187	4258.0190974561865	4917.999896150228	1.1549971438804312	\N	\N	\N
IRON_BANK:43114:0xb09b75916c5f4097c8b5812e63e216fef97661fc	2026-11-21T20:00:00.000Z	archival-rpc	101007806	165.9900438347961	170.39777719709548	1.24545639	1.51645808	75209.75237571595	91574.81353879735	1.2175922755512942	\N	\N	\N
IRON_BANK:43114:0x18931772adb90e7f214b6cbc78ddd6e0f090d4b1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	326.13859357475405	362.196984721308	0.25643248593988704	0.5320910776803187	2.2157995388655047	4.597729340871744	2.074975312624983	\N	\N	\N
IRON_BANK:43114:0xec5aa19566aa442c8c50f3c6734b6bb23ff21cd7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	227.20041515356115	227.91272995590361	182755.41524200002	214332.300075	182729.88796559902	214302.36213932553	1.1727822116307016	\N	\N	\N
IRON_BANK:43114:0xbf1430d9ec170b7e97223c7f321782471c587b29	2026-11-21T20:00:00.000Z	archival-rpc	101007806	244.0795619794045	242.9920768630467	9509.779026531047	11238.213499584144	221.3732959713127	261.6086405679345	1.1817533791511863	\N	\N	\N
IRON_BANK:43114:0x02c9133627a14214879175a7a222d0a7f7404efb	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.017891828818505928	0.7722511334407045	43793.42659635316	1690.9946547578643	18121.024104953773	699.7067204320332	0.03861297884597776	\N	\N	\N
IRON_BANK:43114:0x3af7c11d112c1c730e5cee339ca5b48f9309acbc	2026-11-21T20:00:00.000Z	archival-rpc	101007806	240.77482684745632	240.3707303248126	91461.64232999999	107783.423082	91307.0721544623	107601.26909699141	1.1784549275105938	\N	\N	\N
IRON_BANK:43114:0xb3c68d69e95b095ab4b33b4cb67dbc0fbf3edf56	2026-11-21T19:00:00.000Z	archival-rpc	101004130	87.69355229176767	96.47887298989133	4790.645470456227	5122.220352807699	31718.463161929343	33913.792738318276	1.0692129869338662	\N	\N	\N
IRON_BANK:43114:0x338eee1f7b89ce6272f302bdc4b952c13b221f1d	2026-11-21T19:00:00.000Z	archival-rpc	101004130	95.92438455072738	109.45797156018955	3.968921386585426	4.346939379659822	6671.923545548337	7307.387668662105	1.095244515135034	\N	\N	\N
IRON_BANK:43114:0xceb1ce674f38398432d20bc8f90345e91ef46fd3	2026-11-21T19:00:00.000Z	archival-rpc	101004130	253.51767008885417	250.41548283937232	14581.638697999959	17368.125207	14556.99572860034	17338.77307540017	1.1910955666033778	\N	\N	\N
IRON_BANK:43114:0xe28965073c49a02923882b8329d3e8c1d805e832	2026-11-21T19:00:00.000Z	archival-rpc	101004130	115.12546024974313	129.12777662172914	54683.62072599985	57346.470673	54675.774173261874	57338.24202792313	1.0486955675510725	\N	\N	\N
IRON_BANK:43114:0x085682716f61a72bf8c573fbaf88cca68c60e99b	2026-11-21T19:00:00.000Z	archival-rpc	101004130	217.68355806877082	221.71928760172932	4257.552018325723	4917.4409817294245	4257.113916223037	4916.934977052404	1.154992578026845	\N	\N	\N
IRON_BANK:43114:0xb09b75916c5f4097c8b5812e63e216fef97661fc	2026-11-21T19:00:00.000Z	archival-rpc	101004130	165.98815948931644	170.39626747994419	1.2453394700000002	1.51631194	74738.05202047402	91000.24802954799	1.2175892409480924	\N	\N	\N
IRON_BANK:43114:0x18931772adb90e7f214b6cbc78ddd6e0f090d4b1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	326.13859357475405	362.196984721308	0.25632739109268227	0.5319159196016442	2.2067999823075857	4.579424918118095	2.075142720152429	\N	\N	\N
IRON_BANK:43114:0xec5aa19566aa442c8c50f3c6734b6bb23ff21cd7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	227.19960217507662	227.9120738311491	182714.551748	214284.225377	182688.33403696967	214253.47773350065	1.172781386742206	\N	\N	\N
IRON_BANK:43114:0xbf1430d9ec170b7e97223c7f321782471c587b29	2026-11-21T19:00:00.000Z	archival-rpc	101004130	244.08006685234795	242.99247670001023	9508.873435900985	11237.148098842894	221.3522151888867	261.5838396474333	1.1817538822650395	\N	\N	\N
IRON_BANK:43114:0x02c9133627a14214879175a7a222d0a7f7404efb	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.017891828818505928	0.7722504332008384	43793.4257160474	1690.9931875816092	18101.7140324972	698.9605086154902	0.038612946119946305	\N	\N	\N
IRON_BANK:43114:0x3af7c11d112c1c730e5cee339ca5b48f9309acbc	2026-11-21T19:00:00.000Z	archival-rpc	101004130	240.77529320720714	240.37110145194163	91440.134917	107758.120243	91285.60108899028	107576.00901978933	1.1784553942403058	\N	\N	\N
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
