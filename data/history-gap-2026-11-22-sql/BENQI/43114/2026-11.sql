-- Generated from BENQI/43114/2026-11.ndjson (30 rows)
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
BENQI:43114:0x5c0401e81bc07ca70fad469b451682c0d747ef1c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.5485146413141138	3.797281753037396	686553.3893405442	349956.0016234806	4549700.038622571	2319112.9179799147	0.5097287509710267	\N	\N	\N
BENQI:43114:0xe194c4c5ac32a3c9ffdb358d9bfd523a0b6d1568	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.01484088372194492	2.100855444808758	21.58542801	0.21783179	1303485.781269261	13154.274302176858	0.010091613189188737	\N	\N	\N
BENQI:43114:0x334ad834cd4481bb02d09615e7c11a00579a7909	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.5003872068698456	2.4160929289251953	1295.313027310947	357.68000524757844	2178337.532230702	601513.1196331556	0.2761340291544179	\N	\N	\N
BENQI:43114:0xc9e5999b8e75c3feb117f6f73e664b9f3c8ca65c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	4.588928130289105	9.27501734295788	211303.436354	130672.802747	210946.33354656174	130451.96571035757	0.6184130509268282	\N	\N	\N
BENQI:43114:0x4e9f683a27a6bdad3fc2764003759277e93696e6	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.01920057712823109	2.1287831113880884	70355.14287399958	906.4925178205741	607929.5786789253	7832.8831684871475	0.012884523871183513	\N	\N	\N
BENQI:43114:0x835866d37afb8cb8f8334dccdaf66cf01832ff5d	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.109345101393046	7.406888718364257	156735.67278174433	77402.76873200493	156719.54468101508	77394.80398710241	0.49384270573674	\N	\N	\N
BENQI:43114:0xbeb5d47a3f720ec0a390d04b4d41ed7d9688bc7f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.8047863267867115	5.643140649169709	176954.234123	66576.990012	176929.51715557772	66567.69053803512	0.37623846833595775	\N	\N	\N
BENQI:43114:0x35bd6aeda81a7e5fc7a7832490e71f757b0cd9ce	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	1.9999452781860327	29102608.219458584	0	44690.547233964986	0	0	\N	\N	\N
BENQI:43114:0xb715808a78f6041e46d61cb123c9b4a27056ae9c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	9.937788074054765	12.670262679037592	15439217.149235	14246041.228064	15437060.599383596	14244051.341025265	0.9227178483443947	\N	\N	\N
BENQI:43114:0xd8fcda6ec4bdc547c0827b8804e89acd817d56ef	2026-11-21T20:00:00.000Z	archival-rpc	101007806	7.91107822770698	10.804094726069025	3153820.494876	2886536.654648	3148490.5382396597	2881658.407701645	0.9152507757932783	\N	\N	\N
BENQI:43114:0xf362fea9659cf036792c9cb02f8ff8198e21b4cb	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.002087415040818996	2.01043207042062	7506663.5958066685	7872.7732172943515	64478391.096087255	67623.08501463584	0.0010487712839152932	\N	\N	\N
BENQI:43114:0x89a415b3d20098e6a6c8f7a59001c67bd3129821	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.636609718147497	2.725085673915828	207.05072724	165.79599915	12473462.294851568	9988132.722845333	0.8007506245453553	\N	\N	\N
BENQI:43114:0x872670ccae8c19557cc9443eff587d7086b8043a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.1712806173089803	7.188864834617448	35658.87913789167	18505.433899104282	35658.87913789167	18505.433899104282	0.518957251223304	\N	\N	\N
BENQI:43114:0x190d94613a09ad7931fcd17cd6a8f9b6b47ad414	2026-11-21T20:00:00.000Z	archival-rpc	101007806	4.004246048339155	6.6174691038867195	128769.089799	97394.601052	128722.37366091182	97359.26726468434	0.7563507764481873	\N	\N	\N
BENQI:43114:0x7fa9442f28948e948e86c0258e361f1208699b41	2026-11-21T20:00:00.000Z	archival-rpc	101007806	2.0987484230516884	6.0853617313227915	39769.825405	16135.596698	43510.06771962214	17653.105033200016	0.40572460486515927	\N	\N	\N
BENQI:43114:0x5c0401e81bc07ca70fad469b451682c0d747ef1c	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.549472569450927	3.7984553550529654	686427.4485452642	349999.9897466151	4544778.751483495	2317320.6721131955	0.5098863550523294	\N	\N	\N
BENQI:43114:0xe194c4c5ac32a3c9ffdb358d9bfd523a0b6d1568	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.01484088372194492	2.100855444808758	21.58542801	0.21783179	1295432.193677742	13073.000611418	0.010091613189188737	\N	\N	\N
BENQI:43114:0x334ad834cd4481bb02d09615e7c11a00579a7909	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.4986996287925649	2.412014731945078	1297.4984424407323	357.6787049540827	2181149.3766774535	601272.9255334211	0.2756679262606675	\N	\N	\N
BENQI:43114:0xc9e5999b8e75c3feb117f6f73e664b9f3c8ca65c	2026-11-21T19:00:00.000Z	archival-rpc	101004130	4.588928130289105	9.27501734295788	211303.436354	130672.802747	210946.33354656174	130451.96571035757	0.6184130509268282	\N	\N	\N
BENQI:43114:0x4e9f683a27a6bdad3fc2764003759277e93696e6	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.01920057712823109	2.1287831113880884	70355.14287399958	906.4925178205741	605708.6891406446	7804.268064215908	0.012884523871183513	\N	\N	\N
BENQI:43114:0x835866d37afb8cb8f8334dccdaf66cf01832ff5d	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.109345101393046	7.406888718364257	156735.67278174433	77402.76873200493	156719.54468101508	77394.80398710241	0.49384270573674	\N	\N	\N
BENQI:43114:0xbeb5d47a3f720ec0a390d04b4d41ed7d9688bc7f	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.8047863267867115	5.643140649169709	176954.234123	66576.990012	176928.8429599457	66567.43687970318	0.37623846833595775	\N	\N	\N
BENQI:43114:0x35bd6aeda81a7e5fc7a7832490e71f757b0cd9ce	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	1.9999452781860327	29102608.219458584	0	44681.525425416956	0	0	\N	\N	\N
BENQI:43114:0xb715808a78f6041e46d61cb123c9b4a27056ae9c	2026-11-21T19:00:00.000Z	archival-rpc	101004130	10.08906439352586	12.852946156982625	15440094.873583	14258137.678663	15437879.37436959	14256091.778487489	0.9234488385856844	\N	\N	\N
BENQI:43114:0xd8fcda6ec4bdc547c0827b8804e89acd817d56ef	2026-11-21T19:00:00.000Z	archival-rpc	101004130	5.975690163495528	8.253057172069589	3189367.466841	2886517.764859	3183977.435822039	2881639.549836389	0.9050439608697814	\N	\N	\N
BENQI:43114:0xf362fea9659cf036792c9cb02f8ff8198e21b4cb	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.002087415040818996	2.010431370180754	7507163.576070368	7872.753281637911	64424754.54043702	67562.16147250075	0.0010486987797538989	\N	\N	\N
BENQI:43114:0x89a415b3d20098e6a6c8f7a59001c67bd3129821	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.6445287307931267	2.738122039502855	207.03883351	165.79547265	12420046.786344051	9945899.966527617	0.8007940821497724	\N	\N	\N
BENQI:43114:0x872670ccae8c19557cc9443eff587d7086b8043a	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.1712806173089803	7.188864834617448	35658.87913789167	18505.433899104282	35658.87913789167	18505.433899104282	0.518957251223304	\N	\N	\N
BENQI:43114:0x190d94613a09ad7931fcd17cd6a8f9b6b47ad414	2026-11-21T19:00:00.000Z	archival-rpc	101004130	4.004246048339155	6.6174691038867195	128769.089799	97394.601052	128732.01975342866	97366.56309424914	0.7563507764481873	\N	\N	\N
BENQI:43114:0x7fa9442f28948e948e86c0258e361f1208699b41	2026-11-21T19:00:00.000Z	archival-rpc	101004130	2.0987484230516884	6.0853617313227915	39769.825405	16135.596698	43513.90441012654	17654.6616729389	0.40572460486515927	\N	\N	\N
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
