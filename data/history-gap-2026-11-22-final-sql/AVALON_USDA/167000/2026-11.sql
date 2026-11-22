-- Generated from AVALON_USDA/167000/2026-11.ndjson (24 rows)
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
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0	0	1	0	1.1181941599	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-21T19:00:00.000Z	archival-rpc	14321760	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432694735	45.29104670406237	0.10197542157645398	0.002251558067155629	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T19:00:00.000Z	archival-rpc	14321760	14.712510995687884	28.435510685369593	5.306616	5.421379	5.29764781896	5.41221686949	1.0216263999505524	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T19:00:00.000Z	archival-rpc	14321760	35.2	64	31.502037	44.401579	31.49751677271087	44.39520781742929	1.409482789954186	\N	\N	\N
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0	0	1	0	1.118199245	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-21T20:00:00.000Z	archival-rpc	14323560	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432705461	45.29104670406237	0.10197542157655952	0.002251558067157959	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-21T20:00:00.000Z	archival-rpc	14323560	14.712510995687884	28.435510685369593	5.306699	5.421555	5.29773067869	5.41239257205	1.0216435867193523	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T20:00:00.000Z	archival-rpc	14323560	35.2	64	31.503036	44.404785	31.498635655931523	44.3985825396312	1.4095398614914447	\N	\N	\N
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0	0	1	0	1.1182600792	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-22T08:00:00.000Z	archival-rpc	14345160	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432834177	45.29104670406237	0.10197542157782591	0.0022515580671859203	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T08:00:00.000Z	archival-rpc	14345160	14.712510995687884	28.435510685369593	5.307685	5.423666	5.298715012350001	5.41450000446	1.0218515228390532	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0	0	0	0	0	0	0	\N	\N	\N
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0	0	1	0	1.1182704357	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-22T10:00:00.000Z	archival-rpc	14348760	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432855629	45.29104670406237	0.10197542157803698	0.0022515580671905806	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T10:00:00.000Z	archival-rpc	14348760	14.712510995687884	28.435510685369593	5.30785	5.424018	5.299145126	5.41512261048	1.0218860743992388	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T10:00:00.000Z	archival-rpc	14348760	35.2	64	31.517024	44.449691	31.51262170208768	44.44348226716112	1.410339091660431	\N	\N	\N
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0	0	1	0	1.1182653507	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-22T09:00:00.000Z	archival-rpc	14346960	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432844903	45.29104670406237	0.10197542157793145	0.0022515580671882505	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T09:00:00.000Z	archival-rpc	14346960	14.712510995687884	28.435510685369593	5.307767	5.423842	5.2990622621200005	5.414946899119999	1.021868895149316	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T09:00:00.000Z	archival-rpc	14346960	35.2	64	31.516025	44.446482	31.511622841628	44.44027371539424	1.4102819755981284	\N	\N	\N
AVALON_USDA:167000:0x5d5c8aec46661f029a5136a4411c73647a5714a7	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0	0	1	0	1.1182704357	0	0	\N	\N	\N
AVALON_USDA:167000:0xff12470a969dd362eb6595ffb44c82c959fe9acc	2026-11-22T11:00:00.000Z	archival-rpc	14350560	1.01703e-13	9.06556160104e-7	46.03324064294863	0.10364651432866355	45.29104670406237	0.1019754215781425	0.002251558067192911	\N	\N	\N
AVALON_USDA:167000:0x2def195713cf4a606b49d07e520e22c17899a736	2026-11-22T11:00:00.000Z	archival-rpc	14350560	14.712510995687884	28.435510685369593	5.307932	5.424194	5.29922699152	5.41529832184	1.0219034456357015	\N	\N	\N
AVALON_USDA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T11:00:00.000Z	archival-rpc	14350560	35.2	64	31.518023	44.4529	31.51362056254736	44.446690818928	1.4103962041020148	\N	\N	\N
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
