-- Generated from PAXO/59144/2026-11.ndjson (24 rows)
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
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-21T20:00:00.000Z	archival-rpc	32675911	8.062687161114468	10.870674232776878	1260.561126	1038.790623	1260.3850508219205	1038.6455247257795	0.8240700126111933	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0	0	0.00001897500773181578	0	0.03191041134079449	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0	0	0.00028411	0	17.15663665065355	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-21T20:00:00.000Z	archival-rpc	32675911	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-21T19:00:00.000Z	archival-rpc	32675585	8.062646547202235	10.8706469234221	1260.55192	1038.780394	1260.3710434049992	1038.6313394012648	0.8240679162187939	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0	0	0.00001897500773181578	0	0.031897784947507064	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0	0	0.00028411	0	17.050634362	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-21T19:00:00.000Z	archival-rpc	32675585	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-22T09:00:00.000Z	archival-rpc	32679553	8.063633185173558	10.871640563792084	1260.663966	1038.90489	1260.4878764572293	1038.7597757649648	0.8240934285576303	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0	0	0.00001897500773181578	0	0.03196398050427326	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0	0	0.00028411	0	17.013400641312103	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-22T09:00:00.000Z	archival-rpc	32679553	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-22T08:00:00.000Z	archival-rpc	32679102	8.063576465744404	10.871602750839315	1260.651231	1038.89074	1260.475143236054	1038.745627741437	0.8240905291274808	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0	0	0.00001897500773181578	0	0.03146698609722463	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0	0	0.00028411	0	16.810532717833247	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-22T08:00:00.000Z	archival-rpc	32679102	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-22T10:00:00.000Z	archival-rpc	32679970	8.063685703163515	10.871676276025255	1260.675742	1038.917974	1260.4996508123575	1038.7728579373916	0.8240961092436092	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0	0	0.00001897500773181578	0	0.03253783485297629	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0	0	0.00028411	0	17.379775797	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-22T10:00:00.000Z	archival-rpc	32679970	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
PAXO:59144:0x54ecc8832b65c2db0c53235cde94991c5cdcabf9	2026-11-22T11:00:00.000Z	archival-rpc	32680425	8.063742422592668	10.87171478921789	1260.68859	1038.93225	1260.5124970177487	1038.78713194332	0.8240990346394743	\N	\N	\N
PAXO:59144:0xce39ec58257c790f622fa7dfd5b4cc372f41ed9e	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.00001897500773181578	0	0.03253783485297629	0	0	\N	\N	\N
PAXO:59144:0x48014ede3ec0cfa64dfb50eb7a2e74e4ad536cb3	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.00028411	0	17.379775797	0	0	\N	\N	\N
PAXO:59144:0xf9a65e52dec5b525a44d0bd2986a97ff3bd72d13	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	184560.21246782964	0	0	0	0	\N	\N	\N
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
