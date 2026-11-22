-- Generated from MOONWELL/1/2026-11.ndjson (24 rows)
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
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-21T19:00:00.000Z	archival-rpc	26465427	1.0731245971840053	1.776553355625765	582.7047821042311	414.09253461927057	979551.2123180608	696106.9425814478	0.7106386412754717	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-21T19:00:00.000Z	archival-rpc	26465427	4.798248032500396	5.976352590408851	172971.02199399992	154301.55842	172946.202382054	154279.4176893823	0.8920659463141315	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-21T19:00:00.000Z	archival-rpc	26465427	3.761711668559542	5.29161953615187	149991.6797239993	118471.1131	149738.19378526573	118270.896918861	0.789851232535028	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-21T19:00:00.000Z	archival-rpc	26465427	1.2943268696830046	3.217745033623487	4.9006430299999995	2.31907586	293984.54240930814	139118.97915049177	0.47321868697708436	\N	\N	\N
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-21T20:00:00.000Z	archival-rpc	26465727	1.1309104916534807	1.8237579254787306	582.711564437004	425.1005138342975	979950.3629737543	714894.6893386819	0.7295213271509637	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-21T20:00:00.000Z	archival-rpc	26465727	4.798248032500396	5.976352590408851	172971.02199399992	154301.55842	172946.8614016478	154280.0055783199	0.8920659463141315	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-21T20:00:00.000Z	archival-rpc	26465727	3.761711668559542	5.29161953615187	149991.6797239993	118471.1131	149738.19378526573	118270.896918861	0.789851232535028	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-21T20:00:00.000Z	archival-rpc	26465727	1.1823165007029957	3.0753680626105506	5.127711659999999	2.31915659	308535.94889569795	139544.347767277	0.45227905619014475	\N	\N	\N
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-22T09:00:00.000Z	archival-rpc	26469617	1.1309104916534807	1.8237579254787306	582.711564437004	425.1005138342975	981595.4411469747	716094.8089508767	0.7295213271509637	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-22T09:00:00.000Z	archival-rpc	26469617	4.795412061042725	5.974586585466568	172990.60055899952	154273.414708	172966.43723191344	154251.8657974336	0.8918022956708801	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-22T09:00:00.000Z	archival-rpc	26469617	3.765244378683974	5.294103987196763	149993.61425399978	118528.262576	149747.62472662324	118333.87622537535	0.7902220582223172	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-22T09:00:00.000Z	archival-rpc	26469617	1.181546937090161	3.0743674198419058	5.12941107	2.31917037	306484.876138035	138571.589192685	0.4521318994229098	\N	\N	\N
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-22T10:00:00.000Z	archival-rpc	26469915	1.1306556043422233	1.8235520549580997	582.7950448815328	425.1135239993021	999361.3278846131	728973.2807045559	0.7294391531515453	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-22T10:00:00.000Z	archival-rpc	26469915	4.8034879274183595	5.979615007944972	172993.9942159993	154406.302865	172969.8304148872	154384.73539261584	0.8925529673140513	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-22T10:00:00.000Z	archival-rpc	26469915	3.765244378683974	5.294103987196763	149993.61425399978	118528.262576	149747.62472662324	118333.87622537535	0.7902220582223172	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-22T10:00:00.000Z	archival-rpc	26469915	1.181546937090161	3.0743674198419058	5.12941107	2.31917037	313093.8247958879	141559.70570254856	0.4521318994229098	\N	\N	\N
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-22T08:00:00.000Z	archival-rpc	26469318	1.1309104916534807	1.8237579254787306	582.711564437004	425.1005138342975	966333.0290024903	704960.5537877076	0.7295213271509637	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-22T08:00:00.000Z	archival-rpc	26469318	4.795412061042725	5.974586585466568	172990.60055899952	154273.414708	172966.43723191344	154251.8657974336	0.8918022956708801	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-22T08:00:00.000Z	archival-rpc	26469318	3.765244378683974	5.294103987196763	149993.61425399978	118528.262576	149740.12504591054	118327.94981224656	0.7902220582223172	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-22T08:00:00.000Z	archival-rpc	26469318	1.181546937090161	3.0743674198419058	5.12941107	2.31917037	302830.3480569094	136919.26046987134	0.4521318994229098	\N	\N	\N
MOONWELL:1:0xb85ca1decc4971f8094da7676f8b71002a9590c4	2026-11-22T11:00:00.000Z	archival-rpc	26470215	1.1304434316627976	1.8233811964307733	582.8498658441341	425.1136803444863	999455.3334024402	728973.5488010887	0.7293708127200124	\N	\N	\N
MOONWELL:1:0xe655790552c68f2871eb44b2cfe3dcfe6a63e62e	2026-11-22T11:00:00.000Z	archival-rpc	26470215	4.809402853567235	5.983295468681149	172994.1776239995	154501.506651	172970.013797269	154479.925880551	0.8931023504548629	\N	\N	\N
MOONWELL:1:0xeddc25b67d474eeecfa4f69227b81d870c467011	2026-11-22T11:00:00.000Z	archival-rpc	26470215	3.765244378683974	5.294103987196763	149993.61425399978	118528.262576	149747.62472662324	118333.87622537535	0.7902220582223172	\N	\N	\N
MOONWELL:1:0x636080eb65f1b665b646f47d31f21901cdaaee9f	2026-11-22T11:00:00.000Z	archival-rpc	26470215	1.181546937090161	3.0743674198419058	5.12941107	2.31917037	313093.8247958879	141559.70570254856	0.4521318994229098	\N	\N	\N
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
