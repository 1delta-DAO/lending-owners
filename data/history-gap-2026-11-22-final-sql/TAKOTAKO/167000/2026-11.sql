-- Generated from TAKOTAKO/167000/2026-11.ndjson (36 rows)
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
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T19:00:00.000Z	archival-rpc	14321760	494.99333724992306	549.9941936686291	130448.531852	130448.531852	130429.81379216455	130429.81379216455	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.046378948576902716	0.556051248099206	0.2863956703270587	0.2863956703270587	481.4431504379394	481.4431504379394	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.002102790410804926	0.24168335636650962	134.82500035311776	134.82500035311776	8.066841331627721	8.066841331627721	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T19:00:00.000Z	archival-rpc	14321760	494.99050449208966	549.9917250207196	55007.481422	55007.481422	54914.51877839682	54914.51877839682	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.34518781255029035	2.2613919428669504	0.001193326687916612	0.001193326687916612	71.66979686906971	71.66979686906971	1	\N	\N	\N
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T20:00:00.000Z	archival-rpc	14323560	494.99333724992306	549.9941936686291	130530.459202	130530.459202	130512.22670745867	130512.22670745867	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.046378948576902716	0.556051248099206	0.28639585212011753	0.28639585212011753	481.63403022633486	481.63403022633486	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.002102790410804926	0.24168335636650962	134.82503755056376	134.82503755056376	8.066843557223079	8.066843557223079	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T20:00:00.000Z	archival-rpc	14323560	494.99050449208966	549.9917250207196	55042.022778	55042.022778	54949.00175950518	54949.00175950518	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.34518781255029035	2.2613919428669504	0.001193329768479279	0.001193329768479279	71.7108230316482	71.7108230316482	1	\N	\N	\N
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T08:00:00.000Z	archival-rpc	14345160	494.99333724992306	549.9941936686291	131517.609032	131517.609032	131499.23865237043	131499.23865237043	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.046378948576902716	0.556051248099206	0.28639803364582306	0.28639803364582306	474.94488910773106	474.94488910773106	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.002102790410804926	0.24168335636650962	134.8254839207163	134.8254839207163	8.066870264415263	8.066870264415263	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T08:00:00.000Z	archival-rpc	14345160	494.99050449208966	549.9917250207196	55458.206544	55458.206544	55364.48217494064	55364.48217494064	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.34518781255029035	2.2613919428669504	0.001193366735849894	0.001193366735849894	70.45333873454108	70.45333873454108	1	\N	\N	\N
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T10:00:00.000Z	archival-rpc	14348760	494.99333724992306	549.9941936686291	131682.85805	131682.85805	131664.46458838758	131664.46458838758	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.046378948576902716	0.556051248099206	0.286398397235056	0.286398397235056	491.1082979832656	491.1082979832656	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.002102790410804926	0.24168335636650962	134.8255583158854	134.8255583158854	8.066874715622555	8.066874715622555	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T10:00:00.000Z	archival-rpc	14348760	494.99050449208966	549.9917250207196	55527.87425	55527.87425	55436.808536230004	55436.808536230004	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.34518781255029035	2.2613919428669504	0.001193372897189362	0.001193372897189362	72.80547868452766	72.80547868452766	1	\N	\N	\N
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T09:00:00.000Z	archival-rpc	14346960	494.99333724992306	549.9941936686291	131600.207614	131600.207614	131581.8256970005	131581.8256970005	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.046378948576902716	0.556051248099206	0.28639821544038185	0.28639821544038185	482.44654780538536	482.44654780538536	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.002102790410804926	0.24168335636650962	134.8255211182957	134.8255211182957	8.066872490018602	8.066872490018602	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T09:00:00.000Z	archival-rpc	14346960	494.99050449208966	549.9917250207196	55493.029523	55493.029523	55402.02095458228	55402.02095458228	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.34518781255029035	2.2613919428669504	0.001193369816515662	0.001193369816515662	71.30683324484949	71.30683324484949	1	\N	\N	\N
TAKOTAKO:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T11:00:00.000Z	archival-rpc	14350560	494.99333724992306	549.9941936686291	131765.560373	131765.560373	131747.1553595271	131747.1553595271	1	\N	\N	\N
TAKOTAKO:167000:0x9c2dc7377717603eb92b2655c5f2e7997a4945bd	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0	0	0	0	0	0	0	\N	\N	\N
TAKOTAKO:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.046378948576902716	0.556051248099206	0.28639857902984556	0.28639857902984556	491.1086097200998	491.1086097200998	1	\N	\N	\N
TAKOTAKO:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.002102790410804926	0.24168335636650962	134.8255955134853	134.8255955134853	8.066876941227122	8.066876941227122	1	\N	\N	\N
TAKOTAKO:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T11:00:00.000Z	archival-rpc	14350560	494.99050449208966	549.9917250207196	55562.74074	55562.74074	55471.6178451864	55471.6178451864	1	\N	\N	\N
TAKOTAKO:167000:0xf7fb2df9280eb0a76427dc3b34761db8b1441a49	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.34518781255029035	2.2613919428669504	0.001193375977870993	0.001193375977870993	72.80566663123011	72.80566663123011	1	\N	\N	\N
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
