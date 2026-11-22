-- Generated from AAVE_V4/43114/2026-11.ndjson (28 rows)
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
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.9473246786093341	3.2453802855669185	2472583.9193345397	4695.927942233722	16385492.123342965	31119.30386167255	0.36487429640462415	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	2.860892826270976e-11	0.000013810587782949125	112.32946189	0.00031031	6767120.918448996	18.69416319522892	0.0000027620285452808906	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.6329260303985222	4.542183591354731	7468048.385895	7378799.045628	7467128.098292406	7377889.756221607	0.8886880939606949	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.7871586644737905	4.683490123308888	101037357.875825	2137588.029632	100811034.19418316	2132799.8324456243	0.898465452226602	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:4	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.10065825055898413	0.573540348396266	359.4742991886951	74.2292519641997	604885.1754783377	124905.10225995794	0.2064745254226558	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:5	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.0686765333118575	2.6937790552037555	0	2397.602859	0	2625.864217612207	0.4408002089305326	\N	\N	\N
AAVE_V4_3B517594277C67307CF2D7CBE6FE1D4399B68C41:43114:0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	819901.5067242432	0	7042533.521865645	0	0	\N	\N	\N
AAVE_V4_3B517594277C67307CF2D7CBE6FE1D4399B68C41:43114:1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.9473246786093341	3.2453802855669185	162.22888259992428	897889.498107508	1075.0697103680939	5950196.951387017	0.36487429640462415	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	1.0686765333118575	2.6937790552037555	5427.859963	0.000018	5944.613888638852	0.000019713671819999997	0.4408002089305326	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.6329260303985222	4.542183591354731	806147.989531	33542.562833	806048.6479142501	33538.42938298209	0.8886880939606949	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.7871586644737905	4.683490123308888	205399.976219	76834.221142	204939.88027226945	76662.11248664191	0.898465452226602	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:0	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	97539186.59455566	0	97320698.81658386	0	0	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.7871586644737905	4.683490123308888	0	88799365.605834	0	88600455.02687694	0.898465452226602	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	3.6329260303985222	4.542183591354731	0	5.017242	0	5.0166237252683406	0.8886880939606949	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:0	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.947333852962823	3.2453931383919143	2472552.345376392	4695.910549784673	16370562.373361016	31091.231172002357	0.3648763849886862	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	2.860892826270976e-11	0.000013810587782949125	112.32946189	0.00031031	6738528.944094278	18.61517790132	0.0000027620285452808906	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:2	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.634405751158742	4.543108531615507	7468017.408657	7380275.847777	7467097.124871732	7379366.376384278	0.8888690605334555	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:3	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.787075451443782	4.683438669226879	101037850.824776	2137576.604502	100811526.0389285	2132788.432907915	0.8984555814435227	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:4	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.10065825055898413	0.573540348396266	359.47425789280646	74.22920337830757	603849.6942681433	124691.21440992014	0.2064745254226558	\N	\N	\N
AAVE_V4_435272CEFF93A1E657E8ABFDF0A13E95900A3A56:43114:5	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.0245212840525741	2.637541659293845	0	2347.595686	0	2571.096162213987	0.43159772596176277	\N	\N	\N
AAVE_V4_3B517594277C67307CF2D7CBE6FE1D4399B68C41:43114:0	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	819901.5067242432	0	7036206.522316587	0	0	\N	\N	\N
AAVE_V4_3B517594277C67307CF2D7CBE6FE1D4399B68C41:43114:1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.947333852962823	3.2453931383919143	162.22870715741266	897886.1725672656	1074.1027077693109	5944829.285283838	0.3648763849886862	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:0	2026-11-21T19:00:00.000Z	archival-rpc	101004130	1.0245212840525741	2.637541659293845	5427.853519	0.000018	5944.6068311443405	0.000019713671819999997	0.43159772596176277	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.634405751158742	4.543108531615507	806144.645653	33542.388959	806045.3044483161	33538.25553040858	0.8888690605334555	\N	\N	\N
AAVE_V4_6A37776B5E026DBDF043B4F933C323C84DD1B514:43114:2	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.787075451443782	4.683438669226879	205398.945437	76833.810473	204938.8517992211	76661.70273754049	0.8984555814435227	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:0	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	97539186.59455566	0	97320698.81658386	0	0	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.787075451443782	4.683438669226879	0	88798812.7086	0	88599903.36813274	0.8984555814435227	\N	\N	\N
AAVE_V4_AF22446124E566E54845F65B722E4DCBF12B650A:43114:2	2026-11-21T19:00:00.000Z	archival-rpc	101004130	3.634405751158742	4.543108531615507	0	5.017211	0	5.01659272908847	0.8888690605334555	\N	\N	\N
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
