-- Generated from FLUX_FINANCE/1/2026-11.ndjson (30 rows)
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
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-21T19:00:00.000Z	archival-rpc	26465427	4.143878079077012	4.808451227589217	10165617.985981999	8760553.779564	10164159.32145719	8759296.72770217	0.8617827063386084	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-21T19:00:00.000Z	archival-rpc	26465427	4.687442076090065	5.071787633070812	9306610.013043756	8601299.538488928	9305652.362873413	8600414.464766417	0.9242140292151176	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-21T19:00:00.000Z	archival-rpc	26465427	4.544852232157837	4.971471970094399	19164705.01521694	17520010.43792	19132316.663741224	17490401.620279916	0.9141810648277113	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0.03203737435342191	4.333848953308461	593.5549251155538	4.387477705640956	593.5549251155538	4.387477705640956	0.007391864712076642	\N	\N	\N
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-21T20:00:00.000Z	archival-rpc	26465727	4.143881580276343	4.808451927829083	10165666.073176973	8760601.866759	10164246.132939871	8759378.185890252	0.8617833601552818	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-21T20:00:00.000Z	archival-rpc	26465727	4.6874476780089935	5.071791834510009	9306659.77136209	8601349.296807263	9305702.116071617	8600464.217964621	0.924214434406943	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-21T20:00:00.000Z	archival-rpc	26465727	4.5448585343166314	4.971476171533595	19164804.440075967	17520109.862779	19132415.92057224	17490500.877110902	0.9141815100467339	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0.03203737435342191	4.333849653548327	593.5549464975888	4.387499087675939	593.5549464975888	4.387499087675939	0.007391900469477028	\N	\N	\N
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-22T09:00:00.000Z	archival-rpc	26469617	4.143930597066969	4.808456829508145	10166279.607832989	8761225.401415	10164859.581897367	8760001.633450931	0.8617926851691732	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-22T09:00:00.000Z	archival-rpc	26469617	4.687523303914531	5.071844352499966	9307304.970889825	8601994.496334996	9308310.159826681	8602923.5117406	0.9242196880019719	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-22T09:00:00.000Z	archival-rpc	26469617	4.544939762141098	4.971534291442481	19166093.649072997	17521399.071776	19134661.25548852	17492663.977298286	0.9141872826351056	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0.032039475073020185	4.333849653548327	593.5552237513091	4.3877763413962265	593.5552237513091	4.3877763413962265	0.007392364123535437	\N	\N	\N
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-22T10:00:00.000Z	archival-rpc	26469915	4.1439340982663	4.808457529748011	10166327.381516984	8761273.175099	10164907.348908333	8760049.400461903	0.8617933346340528	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-22T10:00:00.000Z	archival-rpc	26469915	4.68752890583346	5.071848553939162	9307354.397486035	8602043.92293121	9305136.6410802	8599994.227905253	0.924220090432429	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-22T10:00:00.000Z	archival-rpc	26469915	4.544946064299893	4.9715384928816775	19166192.41109898	17521497.833802	19134759.855544776	17492762.577354565	0.9141877248219343	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0.032039475073020185	4.333849653548327	593.5552449907972	4.38779758088431	593.5552449907972	4.38779758088431	0.007392399642517423	\N	\N	\N
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-22T08:00:00.000Z	archival-rpc	26469318	4.143922894428442	4.808456129268279	10166241.67689696	8761177.470479	10164821.656259531	8759953.709209925	0.8617911858606506	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-22T08:00:00.000Z	archival-rpc	26469318	4.687517701995603	5.071840151060769	9307255.378432551	8601944.903877724	9306297.66185411	8601059.763747115	0.9242192842167817	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-22T08:00:00.000Z	archival-rpc	26469318	4.544933459982303	4.971530090003284	19165994.55563098	17521299.978334	19133604.02483196	17491688.981370613	0.914186838959851	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0.032039475073020185	4.333849653548327	593.5552024405476	4.387755030634693	593.5552024405476	4.387755030634693	0.007392328485359682	\N	\N	\N
FLUX_FINANCE:1:0x1dd7950c266fb1be96180a8fdb0591f70200e018	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	4.329743446973566	336339.56172586576	0	39465254.086874746	0	0	\N	\N	\N
FLUX_FINANCE:1:0x465a5a630482f3abd6d3b84b39b29b07214d19e5	2026-11-22T11:00:00.000Z	archival-rpc	26470215	4.14393759946563	4.808457529748011	10166375.47582896	8761321.269411	10164955.436502498	8760097.488056088	0.861793988451583	\N	\N	\N
FLUX_FINANCE:1:0xe2ba8693ce7474900a045757fe0efca900f6530b	2026-11-22T11:00:00.000Z	archival-rpc	26470215	4.687534507752389	5.071852755378359	9307404.15580437	8602093.681249542	9305186.387542125	8600043.974367173	0.9242204955594439	\N	\N	\N
FLUX_FINANCE:1:0x81994b9607e06ab3d5cf3afff9a67374f05f27d7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	4.544952366458688	4.97154339456074	19166291.835956953	17521597.25866	19134859.117345985	17492861.839155797	0.9141881699718554	\N	\N	\N
FLUX_FINANCE:1:0x1c9a2d6b33b4826757273d47ebee0e2dddcd978b	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0.032039475073020185	4.333849653548327	593.5552663728322	4.387818962919294	593.5552663728322	4.387818962919294	0.007392435399879269	\N	\N	\N
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
