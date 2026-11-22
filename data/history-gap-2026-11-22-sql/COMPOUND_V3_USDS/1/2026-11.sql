-- Generated from COMPOUND_V3_USDS/1/2026-11.ndjson (66 rows)
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
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	73.443026282308	0	123460.8117876636	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	273.44902161051607	0	272.9896272542104	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	11.01769561	0	660940.2444705085	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	8.16262e-13	0	4.8966719078926e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	595.4715348479995	0	1248846.6828305537	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	177149.83125584573	0	197884.24468027055	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	7.19207e-12	0	1.340297815668647e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	53260.57741585047	0	2348.575183486236	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-21T19:00:00.000Z	archival-rpc	26465427	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-21T19:00:00.000Z	archival-rpc	26465427	9.296054674023338	10.82353983384069	1566171.0705627108	1438990.8351321504	1566062.4096138352	1438890.997948009	0.9187894422935993	\N	\N	\N
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	73.443026282308	0	123509.68241513133	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	273.44902161051607	0	272.9868927639943	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	11.01769561	0	662938.050162383	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	8.16262e-13	0	4.9114729418600006e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	595.4715348479995	0	1248846.6828305537	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	177149.83125584573	0	197884.24468027055	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	7.19207e-12	0	1.3409292174333876e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	53260.57741585047	0	2348.354375784385	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-21T20:00:00.000Z	archival-rpc	26465727	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-21T20:00:00.000Z	archival-rpc	26465727	9.296054674023338	10.82353983384069	1566187.5989212815	1439008.5165208918	1566078.9368256684	1438908.6781100156	0.9187894422935993	\N	\N	\N
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	73.443026282308	0	123717.02259316437	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	273.44902161051607	0	273.00056521507486	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	11.01769561	0	658312.8215453051	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	8.16262e-13	0	4.8772062631e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	595.4715348479995	0	1253670.8375724272	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	177149.83125584573	0	197913.1531412088	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	7.19207e-12	0	1.3432270760741045e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	53260.57741585047	0	2343.92693050496	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-22T09:00:00.000Z	archival-rpc	26469617	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-22T09:00:00.000Z	archival-rpc	26469617	9.296054674023338	10.82353983384069	1566402.4675827075	1439238.3745745292	1565799.5906009842	1438684.440508923	0.9187894422935993	\N	\N	\N
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	73.443026282308	0	125938.13367831807	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	273.44902161051607	0	273.00056521507486	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	11.01769561	0	672508.4833124446	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	8.16262e-13	0	4.9823768874804e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	595.4715348479995	0	1273677.711072552	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	177149.83125584573	0	197903.22454862125	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	7.19207e-12	0	1.367294609916255e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	53260.57741585047	0	2393.015351241055	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-22T10:00:00.000Z	archival-rpc	26469915	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-22T10:00:00.000Z	archival-rpc	26469915	9.303614925799087	10.832055761669203	1566429.0004430076	1439256.0615792687	1565826.113249317	1438702.120706288	0.9188129679945294	\N	\N	\N
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	73.443026282308	0	121793.39896070433	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	273.44902161051607	0	272.9868927639943	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	11.01769561	0	650463.0942673469	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	8.16262e-13	0	4.819050417139389e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	595.4715348479995	0	1234178.0402159959	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	177149.83125584573	0	197884.24468027055	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	7.19207e-12	0	1.3223418066639412e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	53260.57741585047	0	2348.354375784385	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-22T08:00:00.000Z	archival-rpc	26469318	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-22T08:00:00.000Z	archival-rpc	26469318	9.296054674023338	10.82353983384069	1566385.9392241368	1439220.6931857879	1566277.2633676734	1439120.8400540946	0.9187894422935993	\N	\N	\N
COMPOUND_V3_USDS:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	73.443026282308	0	125938.13367831807	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x4c9edd5852cd905f086c759e8383e09bff1e68b3	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	273.44902161051607	0	273.00056521507486	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcbb7c0000ab88b473b1f5afd9ef808440eed33bf	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	11.01769561	0	672508.4833124446	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x18084fba666a33d37592fa2633fd49a74dd93a88	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	8.16262e-13	0	4.9823768874804e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	595.4715348479995	0	1273677.711072552	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xa3931d71877c0e7a3148cb7eb4463524fec27fbd	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	177149.83125584573	0	197903.22454862125	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xcd5fe23c85820f7b72d0926fc9b05b43e359b7ee	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	7.19207e-12	0	1.367294609916255e-8	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x56072c95faa701256059aa122697b133aded9279	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	53260.57741585047	0	2393.015351241055	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x15700b564ca08d9439c58ca5053166e8317aa138	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	0.007730126854674023	0	7.730126854674023e-11	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0x5c5b196abe0d54485975d1ec29617d42d9198326	2026-11-22T11:00:00.000Z	archival-rpc	26470215	0	0	71.509230992451	0	7.651487716192256e-7	0	0	\N	\N	\N
COMPOUND_V3_USDS:1:0xdc035d45d973e3ec169d2276ddab16f1e407384f	2026-11-22T11:00:00.000Z	archival-rpc	26470215	9.303614925799087	10.832055761669203	1566445.545570271	1439273.7608914115	1565842.652008692	1438719.8132063195	0.9188129679945294	\N	\N	\N
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
