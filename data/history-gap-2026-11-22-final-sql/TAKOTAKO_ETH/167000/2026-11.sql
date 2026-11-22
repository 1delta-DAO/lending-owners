-- Generated from TAKOTAKO_ETH/167000/2026-11.ndjson (12 rows)
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
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T19:00:00.000Z	archival-rpc	14321760	1.587836710573723	2.9700698743872853	0.34599891642278197	0.23249790413077284	581.6387104611862	390.83874175580263	0.6719613648924834	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0	0	0.010000000000000004	0	18.635772672800005	0	0	\N	\N	\N
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T20:00:00.000Z	archival-rpc	14323560	1.587836710573723	2.9700698743872853	0.34599970472673525	0.23249869243472612	581.8702715525591	390.99477674252375	0.6719621122750659	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0	0	0.010000000000000004	0	18.644551811000007	0	0	\N	\N	\N
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T08:00:00.000Z	archival-rpc	14345160	1.587836710573723	2.9700698743872853	0.34600916458329284	0.23250815229128372	573.8003233168058	385.57722342182615	0.6719710807986802	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0	0	0.010000000000000004	0	18.38610868170001	0	0	\N	\N	\N
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T10:00:00.000Z	archival-rpc	14348760	1.587836710573723	2.9700698743872853	0.3460107412635872	0.23250972897157807	593.3299483042241	398.70145350731457	0.6719725755405226	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0	0	0.010000000000000004	0	19.011141575600007	0	0	\N	\N	\N
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T09:00:00.000Z	archival-rpc	14346960	1.587836710573723	2.9700698743872853	0.34600995292209946	0.23250894063009034	582.8643416541123	391.66841723643677	0.6719718281700333	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0	0	0.010000000000000004	0	18.676501703600007	0	0	\N	\N	\N
TAKOTAKO_ETH:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T11:00:00.000Z	archival-rpc	14350560	1.587836710573723	2.9700698743872853	0.34601152960775605	0.23251051731574693	593.3313001356823	398.70280533877286	0.6719733229101481	\N	\N	\N
TAKOTAKO_ETH:167000:0x756b6574b3162077a630895995b443aa68cd2015	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0	0	0.010000000000000004	0	19.011141575600007	0	0	\N	\N	\N
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
