-- Generated from AAVE_V3/43114/2026-11.ndjson (36 rows)
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
AAVE_V3:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.5433313936276298	3.3832372802075934	3074069.2909259545	1869733.3361825151	3073752.969195918	1869540.940622222	0.6082274533308663	\N	\N	\N
AAVE_V3:43114:0x5947bb275c521040051d82396192181b413227a3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.003434133277272905	0.3268673580518944	67936.00607015546	1427.5451038132994	587026.1342702986	12335.230347845729	0.021013085496063996	\N	\N	\N
AAVE_V3:43114:0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.721943845930075	4.597784678669948	60602476.882148	54509502.689203	60594011.9281771	54501888.80186737	0.8994599807398328	\N	\N	\N
AAVE_V3:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.019736362038114068	0.8929385014040109	39.69931292	1.75494612	2397334.437538404	105976.46306822795	0.04420595700324781	\N	\N	\N
AAVE_V3:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.04565420142830763	0.38626009237303477	9917.112481238104	1379.0094550129052	16677681.66748209	2319090.4359170804	0.13905352567310425	\N	\N	\N
AAVE_V3:43114:0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.193289207849293	4.276456762360232	24140500.644493	20029512.2181	24099703.198403805	19995662.342451412	0.8297057510557135	\N	\N	\N
AAVE_V3:43114:0x63a72806098bd3d9520cc43356dd78afe5d386d9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	1289.4905646122454	0	126261.77101947827	0	0	\N	\N	\N
AAVE_V3:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.9864640138432362	3.299730305183456	14940091.110791348	5583003.1040210435	99006041.13116713	36997835.61245384	0.37369270793726256	\N	\N	\N
AAVE_V3:43114:0x2b2c81e08f1af8835a78bb2a90ae924ace0ea4be	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	6609978.024275582	0	56776321.83009574	0	0	\N	\N	\N
AAVE_V3:43114:0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64	2026-11-21T20:00:00.000Z	archival-rpc	101007806	51.64655850937989	64.69935459168492	6974.448907238008	6972.34691768594	6974.448907238008	6972.34691768594	0.9996986156784535	\N	\N	\N
AAVE_V3:43114:0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.2598657708090157	24.281619298161594	21100.724374517205	4599.290740951652	20108.990328914897	4383.124076126924	0.2179683815265648	\N	\N	\N
AAVE_V3:43114:0x152b9d0fdc40c096757f570a51e494bd4b943e50	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.001346898647707289	0.1160563223001726	1146.96152769	26.62229733	69096986.81088567	1603820.6017174025	0.02321115110427266	\N	\N	\N
AAVE_V3:43114:0x00000000efe302beaa2b3e6e1b18d08d69a9012a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.2359434191604572	3.9974951742403695	127032.738539	114259.759884	126986.65233178544	114218.3075857117	0.8994512847483124	\N	\N	\N
AAVE_V3:43114:0xfc421ad3c883bf9e7c4f42de845c4e4405799e73	2026-11-21T20:00:00.000Z	archival-rpc	101007806	7.407938316707776	9.113572216181675	609370.7291273371	550373.5988743501	609370.7291273371	550373.5988743501	0.9031835179588045	\N	\N	\N
AAVE_V3:43114:0xc891eb4cbdeff6e073e859e987815ed1505c2acd	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.3523343918524033	4.773579722766876	938281.968457	732152.937775	1026524.797932148	801009.9008306306	0.7803122754016277	\N	\N	\N
AAVE_V3:43114:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.6862085573923362	7.040610149712449	13761.248775104405	1788.5231710722842	13737.992264674478	1785.5005669131722	0.12996808649429528	\N	\N	\N
AAVE_V3:43114:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	5969.1256481676255	0	7505.250168712811	0	0	\N	\N	\N
AAVE_V3:43114:0x7bfd4ca2a6cf3a3fddd645d10b323031afe47ff0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	0.05182877145604638	0	94.55950901553284	0	0	\N	\N	\N
AAVE_V3:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.5438234611589292	3.383776588008152	3074063.8760143784	1870026.527642779	3073747.5548415366	1869834.1019130845	0.6083239005649186	\N	\N	\N
AAVE_V3:43114:0x5947bb275c521040051d82396192181b413227a3	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.003434133277272905	0.3268673580518944	67936.00580390386	1427.5445712925305	584881.6069442024	12290.162675328622	0.021013077739852913	\N	\N	\N
AAVE_V3:43114:0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.7199830601847594	4.59657340112187	60606872.152687	54499066.747071	60598175.672601804	54491246.67598346	0.8992225602695912	\N	\N	\N
AAVE_V3:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.019736362038114068	0.8929385014040109	39.69931203	1.75494433	2382522.452030826	105321.580009486	0.04420591290533757	\N	\N	\N
AAVE_V3:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.04565420142830763	0.38626009237303477	9917.11196453484	1379.0088471267843	16671081.731085576	2318171.7903917036	0.13905347162140932	\N	\N	\N
AAVE_V3:43114:0x9702230a8ea53601f5cd2dc00fdbc13d4df4a8c7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.1954547753500258	4.277906049712322	24141226.164703	20036900.139808	24100427.49248465	20003037.778571725	0.8299868450387182	\N	\N	\N
AAVE_V3:43114:0x63a72806098bd3d9520cc43356dd78afe5d386d9	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	1289.4905646122454	0	126796.82030657075	0	0	\N	\N	\N
AAVE_V3:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.9864583647149928	3.299722544394002	14940080.710676808	5582982.079795056	98917025.39464372	36964457.613021195	0.37369156083642996	\N	\N	\N
AAVE_V3:43114:0x2b2c81e08f1af8835a78bb2a90ae924ace0ea4be	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	6609593.812093227	0	56722016.86312451	0	0	\N	\N	\N
AAVE_V3:43114:0xd24c2ad096400b6fbcd2ad8b24e7acbc21a1da64	2026-11-21T19:00:00.000Z	archival-rpc	101004130	51.64655850937989	64.69935459168492	6974.038225221763	6971.83211815518	6974.038225221763	6971.83211815518	0.9996836686299475	\N	\N	\N
AAVE_V3:43114:0x5c49b268c9841aff1cc3b0a418ff5c3442ee3f3b	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.2598657708090157	24.281619298161594	21100.71811791403	4599.16329168907	20108.98436637207	4383.002616979684	0.21796240611282727	\N	\N	\N
AAVE_V3:43114:0x152b9d0fdc40c096757f570a51e494bd4b943e50	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.001346900088645262	0.11605638438003421	1146.96076428	26.62229381	68804997.17349152	1597044.0379438633	0.023211163484491152	\N	\N	\N
AAVE_V3:43114:0x00000000efe302beaa2b3e6e1b18d08d69a9012a	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.2359434191604572	3.9974951742403695	127032.269416	114259.238623	126995.69936628052	114226.3456733852	0.8994505029964363	\N	\N	\N
AAVE_V3:43114:0xfc421ad3c883bf9e7c4f42de845c4e4405799e73	2026-11-21T19:00:00.000Z	archival-rpc	101004130	7.407938316707776	9.113572216181675	609365.5776456493	550367.8746161707	609365.5776456493	550367.8746161707	0.9031817595319007	\N	\N	\N
AAVE_V3:43114:0xc891eb4cbdeff6e073e859e987815ed1505c2acd	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.3523343918524033	4.773579722766876	938278.378905	732148.949179	1026611.3887597705	801076.1692844699	0.7803110096530632	\N	\N	\N
AAVE_V3:43114:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.6862085573923362	7.040610149712449	13761.237998457893	1788.508800357722	13738.119118620483	1785.504105573121	0.1299671439850212	\N	\N	\N
AAVE_V3:43114:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	5969.1256481676255	0	7505.316067859966	0	0	\N	\N	\N
AAVE_V3:43114:0x7bfd4ca2a6cf3a3fddd645d10b323031afe47ff0	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	0.05182877145604638	0	94.51905488790398	0	0	\N	\N	\N
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
