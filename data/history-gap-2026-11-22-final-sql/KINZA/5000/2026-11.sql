-- Generated from KINZA/5000/2026-11.ndjson (48 rows)
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
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-21T20:00:00.000Z	archival-rpc	103580444	1.4355930847575533	3.559072604862718	144.970351	93.51759	144.72535110681	93.35954527290001	0.6450808000044091	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	6	0	5.98986	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0.000053241021770972	0.04424240619909541	0.11145393362169473	0.000161820736362601	187.43290741613555	0.2721351334230376	0.0014519069099154906	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0	0	0.025071509756623	0	46.54149410112141	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0.13369599762124515	1.7736369919810016	4259.388201818673	380.51558014766454	1581.6070589147525	141.29403075578338	0.08933573605364076	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T20:00:00.000Z	archival-rpc	103580444	0.000078016643637532	0.028563267637817767	0.00003112	1e-7	1.8627085852511136	0.0059855674333262	0.0032133676092544984	\N	\N	\N
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-21T19:00:00.000Z	archival-rpc	103578644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	5	0	5.770602500000001	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-22T09:00:00.000Z	archival-rpc	103603844	1.4355930847575533	3.559072604862718	144.97344	93.52253	144.7356835584	93.36915305080001	0.6451011302484096	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	6	0	5.99016	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0.000053241021770972	0.04424240619909541	0.1114539337097552	0.000161820842608531	187.74755797594983	0.27259215550418064	0.0014519078620404706	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	0.025071509756623	0	46.49685475926241	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T09:00:00.000Z	archival-rpc	103603844	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T10:00:00.000Z	archival-rpc	103605644	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T08:00:00.000Z	archival-rpc	103602044	3.4904656058118766	5.549614935617985	42.70336	47.108029	42.6973951946752	47.10144895050928	1.1031457243645464	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T08:00:00.000Z	archival-rpc	103602044	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5be26527e817998a7206475496fde1e68957c5a6	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	5	0	5.770602500000001	0	0	\N	\N	\N
KINZA:5000:0x09bc4e0d864854c6afb6eb9a9cdf58ac190d0df9	2026-11-22T11:00:00.000Z	archival-rpc	103607444	3.4904656058118766	5.549614935617985	42.70387	47.108924	42.6979051234384	47.10234382549568	1.1031535081012565	\N	\N	\N
KINZA:5000:0x201eba5cc46d216ce6dc03f6a759e8e766e956ae	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xdeaddeaddeaddeaddeaddeaddeaddeaddead1111	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0.000053241021770972	0.04424240619909541	0.11145393372330296	0.000161820858954064	191.1182193155485	0.27748607319857205	0.0014519080085212842	\N	\N	\N
KINZA:5000:0xcda86a272531e8640cd7f1a92c01839911b90bb0	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	0.025071509756623	0	47.386885619738	0	0	\N	\N	\N
KINZA:5000:0x78c1b0c915c4faa5fffa6cabf0219da63d7f4cb8	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	0	0	0	0	0	\N	\N	\N
KINZA:5000:0xc96de26018a54d51c097160568752c4e3bd6c364	2026-11-22T11:00:00.000Z	archival-rpc	103607444	0	0	0	0	0	0	0	\N	\N	\N
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
