-- Generated from GRANARY/1/2026-11.ndjson (30 rows)
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
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-21T19:00:00.000Z	archival-rpc	26465427	64.23068262860727	76.14518925366663	431.1933464506436	429.8030619344025	431.14897665529384	429.75883519932944	0.9967757282720496	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T19:00:00.000Z	archival-rpc	26465427	39.5	79	13555.636793	13555.636793	13553.691694676572	13553.691694676572	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T19:00:00.000Z	archival-rpc	26465427	67.14999910190288	78.99999912727021	513.440351	513.44035	512.57263680681	512.5726358085	0.9999999980523541	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T19:00:00.000Z	archival-rpc	26465427	260.95	307	1.8e-7	1.8e-7	0.010802556	0.010802556	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T19:00:00.000Z	archival-rpc	26465427	153.5	307	48.89469061485151	48.89469061485151	82194.0285005712	82194.0285005712	1	\N	\N	\N
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-21T20:00:00.000Z	archival-rpc	26465727	64.23068262860727	76.14518925366663	431.22894336446285	429.8386588482217	431.18456990619063	429.79442845022623	0.9967759944279387	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-21T20:00:00.000Z	archival-rpc	26465727	39.5	79	13556.858367	13556.858367	13554.964745023299	13554.964745023299	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-21T20:00:00.000Z	archival-rpc	26465727	67.14999910190288	78.99999912727021	513.48662	513.486619	512.6188276122	512.6188266138901	0.9999999980525296	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-21T20:00:00.000Z	archival-rpc	26465727	260.95	307	1.8e-7	1.8e-7	0.0108697145370372	0.0108697145370372	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-21T20:00:00.000Z	archival-rpc	26465727	153.5	307	48.911803590885214	48.911803590885214	82255.34313687145	82255.34313687145	1	\N	\N	\N
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-22T09:00:00.000Z	archival-rpc	26469617	64.23068262860727	76.14518925366663	431.69193705926665	430.3016525430255	431.73855978846905	430.3481251215002	0.9967794522044773	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T09:00:00.000Z	archival-rpc	26469617	39.5	79	13572.748721	13572.748721	13570.852879458651	13570.852879458651	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T09:00:00.000Z	archival-rpc	26469617	67.14999910190288	78.99999912727021	514.088491	514.08849	513.24538587476	513.2453848764	0.9999999980548095	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T09:00:00.000Z	archival-rpc	26469617	260.95	307	1.8e-7	1.8e-7	0.0107789662998	0.0107789662998	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T09:00:00.000Z	archival-rpc	26469617	153.5	307	49.13480781424351	49.13480781424351	82769.0855915874	82769.0855915874	1	\N	\N	\N
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-22T10:00:00.000Z	archival-rpc	26469915	64.23068262860727	76.14518925366663	431.727569948814	430.33728543257286	431.6246979034466	430.2347446642	0.9967797180142886	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T10:00:00.000Z	archival-rpc	26469915	39.5	79	13573.971817	13573.971817	13572.075804616601	13572.075804616601	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T10:00:00.000Z	archival-rpc	26469915	67.14999910190288	78.99999912727021	514.134817	514.134816	513.29163590012	513.2916349017601	0.9999999980549849	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T10:00:00.000Z	archival-rpc	26469915	260.95	307	1.8e-7	1.8e-7	0.011011086	0.011011086	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T10:00:00.000Z	archival-rpc	26469915	153.5	307	49.15200323919032	49.15200323919032	84284.53820380541	84284.53820380541	1	\N	\N	\N
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-22T08:00:00.000Z	archival-rpc	26469318	64.23068262860727	76.14518925366663	431.65630674018786	430.2660222239467	431.61188930622427	430.2217478502599	0.9967791863699609	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T08:00:00.000Z	archival-rpc	26469318	39.5	79	13571.525733	13571.525733	13569.630062285616	13569.630062285616	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T08:00:00.000Z	archival-rpc	26469318	67.14999910190288	78.99999912727021	514.042168	514.042167	513.1734367360799	513.17343573777	0.9999999980546344	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T08:00:00.000Z	archival-rpc	26469318	260.95	307	1.8e-7	1.8e-7	0.010650437820597599	0.010650437820597599	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T08:00:00.000Z	archival-rpc	26469318	153.5	307	49.11761828944806	49.11761828944806	81453.63805313961	81453.63805313961	1	\N	\N	\N
GRANARY:1:0x6b175474e89094c44da98b954eedeac495271d0f	2026-11-22T11:00:00.000Z	archival-rpc	26470215	64.23068262860727	76.14518925366663	431.7632054089489	430.3729208927078	431.6603248723641	430.27037163311746	0.9967799837993969	\N	\N	\N
GRANARY:1:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48	2026-11-22T11:00:00.000Z	archival-rpc	26470215	39.5	79	13575.195022	13575.195022	13573.298838759327	13573.298838759327	1	\N	\N	\N
GRANARY:1:0xdac17f958d2ee523a2206206994597c13d831ec7	2026-11-22T11:00:00.000Z	archival-rpc	26470215	67.14999910190288	78.99999912727021	514.181148	514.181147	513.33789091728	513.33788991892	0.9999999980551602	\N	\N	\N
GRANARY:1:0x2260fac5e5542a773aa44fbcfedf7c193bc2c599	2026-11-22T11:00:00.000Z	archival-rpc	26470215	260.95	307	1.8e-7	1.8e-7	0.011011086	0.011011086	1	\N	\N	\N
GRANARY:1:0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2	2026-11-22T11:00:00.000Z	archival-rpc	26470215	153.5	307	49.16920456597208	49.16920456597208	84314.03457808823	84314.03457808823	1	\N	\N	\N
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
