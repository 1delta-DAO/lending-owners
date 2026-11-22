-- Generated from EULER_V2/59144/2026-11.ndjson (25 rows)
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
EULER_V2:59144:0xa8a02e6a894a490d04b6cd480857a19477854968	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.016044452302095299196511244466	\N	assets_per_share
EULER_V2:59144:0x359e363c11fc619be76eec8baaa01e61d521aa18	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.000909240251439161871024750227	\N	assets_per_share
EULER_V2:59144:0x9ac2f0a564b7396a8692e1558d23a12d5a2abb1f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0xf4712fc5e6483de9e1ff661d95dd686664327086	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.02317540646860926411714314865	\N	assets_per_share
EULER_V2:59144:0x179dfd3ecdc6f5b8f8788584f3289d10c6f1afb8	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.003215080268475692584183299401	\N	assets_per_share
EULER_V2:59144:0x8bf8edc911ab3f0ea4a27c51cb88b57cce5356f1	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.001222063875262731202027980479	\N	assets_per_share
EULER_V2:59144:0xf3c6598a9bc60771dcd4dd448fb56122b7f8588a	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x8955d7dcde9bd9694b64732ad28ff2113eb217b4	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.001218396098253521771593327933	\N	assets_per_share
EULER_V2:59144:0x14efcc1ae56e2ff75204ef2fb0de43378d0beada	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x085f80df643307e04f23281f6fdbfaa13865e852	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x873fea936c29c8a9f3e0d7cacfc1dc46e2a93e56	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.000000165892388349482279547782	\N	assets_per_share
EULER_V2:59144:0x5df4080d8d1a85457d699e6a85255fc4087b8abf	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.000012280747216764956225923776	\N	assets_per_share
EULER_V2:59144:0xfb6448b96637d90fcf2e4ad2c622a487d0496e6f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.037815433540426242075335612177	\N	assets_per_share
EULER_V2:59144:0xb135dcf653dafb5ddaa93f926d7000aa3222efee	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.015732796589940505575823587311	\N	assets_per_share
EULER_V2:59144:0xb11fd944cf5e8678b5db42305aff03b7942a3cab	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0xcbef9be95738290188b25ca9a6dd2bec417a578c	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.13834888059192665943605876358	\N	assets_per_share
EULER_V2:59144:0xa7ada0d422a8b5fa4a7947f2cb0ee2d32435647d	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.025117544792667344684114309975	\N	assets_per_share
EULER_V2:59144:0x5464cc940beff4301ed21df535761546f19de2d3	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x9947f3d2ae676be4612eb4d80e94f6441e47a2a9	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x92ba0ded54184ab00f7edd1bc5eba488cc8d9de0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0xb747b627c3b67cdc0aeaf78fd7174ae5e5bfa796	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0xe27c2571f6d1b942bbb438a37b0171c64b469e1f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.075927929525804379176517665777	\N	assets_per_share
EULER_V2:59144:0x4789d8066cac17fd24f24206a49abc72830604f1	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1.009102897335726803144745409995	\N	assets_per_share
EULER_V2:59144:0x3cc7963fa503fe32053f177c444855a71068a839	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:59144:0x42267dc26fcece525f04e75da3fa596f88cedde0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
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
