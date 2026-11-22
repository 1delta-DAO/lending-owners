-- Generated from DEMETER/56/2026-11.ndjson (20 rows)
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
DEMETER:56:0x89bb17af665ec0607268c697bb294117992027cf	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.00006092086834996735	0.1648560711942082	252614.24282051335	312.4767144996925	252187.32475014668	311.948628852188	0.001236971878587671	\N	\N	\N
DEMETER:56:0xb275b6ae294159278547297dbe7617f66a7bc6e2	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.02811603110330907	3.5340300765795973	15864.269397501721	420.6932698062889	15864.269397501721	420.6932698062889	0.02651828831604051	\N	\N	\N
DEMETER:56:0x6c9fcbd7ad9dfb241f4fa2cc08faabb42d764606	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.8347985558951905	27.478557937854475	0.00783518791193252	0.001616073373044508	471.9256926862811	97.33864134188651	0.20625840646187	\N	\N	\N
DEMETER:56:0x4a345187bfae9a14da764c2222c4b7e816c18216	2026-11-21T20:00:00.000Z	archival-rpc	134947363	36.66403630937509	98.7482663671102	0.27969671936134494	0.20751939702338856	470.3680489429339	348.9869102454531	0.7419443370563483	\N	\N	\N
DEMETER:56:0x5c4e2b1e6e03ccf5f3c3356c008a69c7f93bd10b	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.7600263458584777	36.73164026700704	16.504459394724737	1.1377698364655573	9054.262086158484	624.1747182811404	0.06893711628199217	\N	\N	\N
DEMETER:56:0xb0568dbd78d3920903e71fc3f3034c0a4a7d1ccb	2026-11-21T20:00:00.000Z	archival-rpc	134947363	429.5651519836241	693.2820860146904	314.54533256193594	388.38226171916887	204.96684163928182	253.0811215188646	1.2347417733267239	\N	\N	\N
DEMETER:56:0x606bb7e9b80ba73d1303f1c3625cf7f09249d680	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.41253371279026396	10.484711121705459	23.208853197452886	1.8261092378009702	11.957493366789482	0.9408344700303637	0.07868157992405161	\N	\N	\N
DEMETER:56:0x511069c79dff79dfc0d0c69c4b4a40c4cade68f4	2026-11-21T20:00:00.000Z	archival-rpc	134947363	23.187649793854348	78.5448771271291	9.394537275523133	5.542616856030278	1864.3783334811662	1099.9514371073622	0.5899829542931522	\N	\N	\N
DEMETER:56:0x217d2c538628762981e18c32a0b789f94d2368df	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.031178180037727543	2.8826739555398717	57.46391102720234	1.2429742399523298	496.53813201082374	10.740377677240588	0.0216305193596017	\N	\N	\N
DEMETER:56:0x336dd5b84ca82f0d0ceb790d257f0e66dd3c5478	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.5618884709643908	26.1228291350335	12.833576538615608	2.5163878347754256	60.0538002183278	11.775256246512825	0.19607845304882368	\N	\N	\N
DEMETER:56:0x89bb17af665ec0607268c697bb294117992027cf	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.00006092086834996735	0.16483786495768982	252614.24303224182	312.4774202614254	252187.32496151736	311.94933342118355	0.001236974671382813	\N	\N	\N
DEMETER:56:0xb275b6ae294159278547297dbe7617f66a7bc6e2	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.02811603110330907	3.53380740030218	15864.275507353632	420.71363597932424	15864.275507353632	420.71363597932424	0.026519561878782877	\N	\N	\N
DEMETER:56:0x6c9fcbd7ad9dfb241f4fa2cc08faabb42d764606	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.8363958030297454	27.48477046594644	0.007835491782698665	0.001616681114576798	462.52011360535056	95.43083618934631	0.2063279701405019	\N	\N	\N
DEMETER:56:0x4a345187bfae9a14da764c2222c4b7e816c18216	2026-11-22T08:00:00.000Z	archival-rpc	135043334	36.722128908905916	98.82092115489627	0.27983665101954985	0.20779926033979837	464.063895603137	344.60151629673544	0.7425734248273331	\N	\N	\N
DEMETER:56:0x5c4e2b1e6e03ccf5f3c3356c008a69c7f93bd10b	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.7606901732515325	36.74562685809235	16.504630902241978	1.1383415281896958	8882.17326288149	612.6127112809719	0.06897103818511108	\N	\N	\N
DEMETER:56:0xb0568dbd78d3920903e71fc3f3034c0a4a7d1ccb	2026-11-22T08:00:00.000Z	archival-rpc	135043334	435.91309316113325	700.9334011609525	316.4253405528466	392.14227770099006	203.5339806924942	252.23731651471235	1.2392884748606217	\N	\N	\N
DEMETER:56:0x606bb7e9b80ba73d1303f1c3625cf7f09249d680	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.41260163605727485	10.484992618131628	23.208984297419534	1.8263714377342635	11.906331255923467	0.936938172535154	0.07869243282384084	\N	\N	\N
DEMETER:56:0x511069c79dff79dfc0d0c69c4b4a40c4cade68f4	2026-11-22T08:00:00.000Z	archival-rpc	135043334	23.22015142723899	78.59550306896779	9.397511473087151	5.548565251158316	1832.2236023465582	1081.7983294243909	0.5904292074607674	\N	\N	\N
DEMETER:56:0x217d2c538628762981e18c32a0b789f94d2368df	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.03117677955799536	2.8824666845395086	57.46393556940057	1.2430233243487794	492.04237667594344	10.643547900361563	0.021631364298874908	\N	\N	\N
DEMETER:56:0x336dd5b84ca82f0d0ceb790d257f0e66dd3c5478	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.5632567396627337	26.1283491258979	12.834026373872588	2.5172875052893864	58.92149071146646	11.556960227458518	0.19614168086907324	\N	\N	\N
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
