-- Generated from WE_PIGGY/56/2026-11.ndjson (32 rows)
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
WE_PIGGY:56:0x33a32f0ad4aa704e28c93ed8ffa61d50d51622a7	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	31.760554344024033	0.05661108892491167	17423.677816698884	31.056554101542133	0.0017824339056463426	\N	\N	\N
WE_PIGGY:56:0x849c37a029b38d3826562697ccc40c34477c6293	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	1.5856714329574613	0.001599324812281609	2666.635418133639	2.689596407482536	0.0010086104719050672	\N	\N	\N
WE_PIGGY:56:0x311aea58ca127b955890647413846e351df32554	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0.05677351115746865	0.000022138523130194	3419.557881747387	1.3334380720284684	0.00038994458293745393	\N	\N	\N
WE_PIGGY:56:0x12d803497d1e58dd4d4a4f455d754f1d0f937c8b	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	124.24025921393827	21.840830443181677	124.22747489126516	21.83858302172907	0.17579511328588243	\N	\N	\N
WE_PIGGY:56:0x2a8cd78bfb91acf53f589961d213d87c956e0d7f	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	11426.110423009073	67.48158830318089	11406.800296394189	67.36754441894851	0.0059059107434574895	\N	\N	\N
WE_PIGGY:56:0x2b7f68170a598e507b19bca41ed745eabc936b3f	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	102.48261355657822	39.56079162834897	102.46829878511663	39.55526577697432	0.3860244216596643	\N	\N	\N
WE_PIGGY:56:0x2dd8ffa7923a17739f70c34759af7650e44ea3be	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	3831.494140087091	10.642658093346038	3831.494140087091	10.642658093346038	0.002777678290564768	\N	\N	\N
WE_PIGGY:56:0x811cd5cb4cc43f44600cfa5ee3f37a402c82aec2	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	18.298437044099824	0.8634331944484727	11.923791134703503	0.5626380572592722	0.04718617182263003	\N	\N	\N
WE_PIGGY:56:0x17933112e9780abd0f27f2b7d9dda9e840d43159	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	51.20931233020896	0.8282859426267654	239.63030124477376	3.875904614156987	0.01617451797215699	\N	\N	\N
WE_PIGGY:56:0x417fdfc74503d8008aeeb53248e5c0f1960c2c1d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	924.5991750924262	74.45672453226952	1369.5070521551509	110.2845558099523	0.08052865126645453	\N	\N	\N
WE_PIGGY:56:0x6a05bd123d780055c38526cc05d3c9b90d0e471c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	18.4089745420149	0.0198509056971874	736.0309337542573	0.7936824847479721	0.0010783276196010578	\N	\N	\N
WE_PIGGY:56:0x00ff07204c3b27d72cf83ef521adb7066167561a	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	90.83600678172901	0.8162768369903038	784.9020423509126	7.0533412814697165	0.008986269497202203	\N	\N	\N
WE_PIGGY:56:0xbc52bce2c73fec358abbf047c50377183b9ead0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	11707.738099446027	8.817458202193627	1697.8692918483343	1.2787176640353064	0.0007531308035162523	\N	\N	\N
WE_PIGGY:56:0xdf21d42a0fc6746718f2cfe2798f91c9d7277f32	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	1.9460999140243356	8.743116089253958	1.0026551771032552	4.504563485015202	4.492634744109354	\N	\N	\N
WE_PIGGY:56:0x23cf81eeaa61c1c7607ee1a3bfcff1f99ac26c85	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	4802.87854502	11.23666429	25.24392963262512	0.05905990750824001	0.0023395686950383227	\N	\N	\N
WE_PIGGY:56:0x33d295aaa719fd756310eb42de2847d0e7be294e	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	2.6065842282836416	0.17644756525898955	1.2128436414203785	0.08210105211500784	0.067693022670967	\N	\N	\N
WE_PIGGY:56:0x33a32f0ad4aa704e28c93ed8ffa61d50d51622a7	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	31.760554344024033	0.05661108892491167	17092.33900956029	30.46596457744189	0.0017824339056463426	\N	\N	\N
WE_PIGGY:56:0x849c37a029b38d3826562697ccc40c34477c6293	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	1.585611407993429	0.001599324812281609	2629.480463782422	2.6522219302514047	0.0010086486539003488	\N	\N	\N
WE_PIGGY:56:0x311aea58ca127b955890647413846e351df32554	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0.05677351115746865	0.000022138523130194	3351.275396435049	1.306811686771416	0.00038994458293745393	\N	\N	\N
WE_PIGGY:56:0x12d803497d1e58dd4d4a4f455d754f1d0f937c8b	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	124.12354470624075	18.841905293473012	124.11077239349048	18.839966461418314	0.1517996069002505	\N	\N	\N
WE_PIGGY:56:0x2a8cd78bfb91acf53f589961d213d87c956e0d7f	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	11421.064301522852	66.84269495804485	11401.762702853279	66.72973080356576	0.005852580214361654	\N	\N	\N
WE_PIGGY:56:0x2b7f68170a598e507b19bca41ed745eabc936b3f	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	102.0727084441516	37.565518663696125	102.05845092823613	37.560271512049184	0.36802705871422864	\N	\N	\N
WE_PIGGY:56:0x2dd8ffa7923a17739f70c34759af7650e44ea3be	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	3829.5393123286203	9.633538911358851	3829.5393123286203	9.633538911358851	0.002515586895882002	\N	\N	\N
WE_PIGGY:56:0x811cd5cb4cc43f44600cfa5ee3f37a402c82aec2	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	18.298437044099824	0.8284992133597403	11.77008682531425	0.5329147867901095	0.045277048054051305	\N	\N	\N
WE_PIGGY:56:0x17933112e9780abd0f27f2b7d9dda9e840d43159	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	51.20931233020896	0.8282859426267654	235.10385072510428	3.802691458876513	0.01617451797215699	\N	\N	\N
WE_PIGGY:56:0x417fdfc74503d8008aeeb53248e5c0f1960c2c1d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	924.5176302495902	74.26573622775174	1347.67859479113	108.257906356556	0.0803291725304388	\N	\N	\N
WE_PIGGY:56:0x6a05bd123d780055c38526cc05d3c9b90d0e471c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	18.4089745420149	0.016638070216062364	716.990334961693	0.6480173846785618	0.000903802119889362	\N	\N	\N
WE_PIGGY:56:0x00ff07204c3b27d72cf83ef521adb7066167561a	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	90.83600678172901	0.8162768369903038	777.7950504391514	6.989475936836195	0.008986269497202203	\N	\N	\N
WE_PIGGY:56:0xbc52bce2c73fec358abbf047c50377183b9ead0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	11707.738099446027	8.687469871099681	1657.656501351143	1.2300275928449378	0.0007420280328538221	\N	\N	\N
WE_PIGGY:56:0xdf21d42a0fc6746718f2cfe2798f91c9d7277f32	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	1.9460999140243356	8.743116089253958	0.998359511841031	4.485264630009071	4.492634744109354	\N	\N	\N
WE_PIGGY:56:0x23cf81eeaa61c1c7607ee1a3bfcff1f99ac26c85	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	4802.87854502	11.23666429	25.24392963262512	0.05905990750824001	0.0023395686950383227	\N	\N	\N
WE_PIGGY:56:0x33d295aaa719fd756310eb42de2847d0e7be294e	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	2.6065842282836416	0.17644756525898955	1.2128436414203785	0.08210105211500784	0.067693022670967	\N	\N	\N
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
