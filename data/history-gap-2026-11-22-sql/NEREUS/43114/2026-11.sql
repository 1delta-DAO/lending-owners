-- Generated from NEREUS/43114/2026-11.ndjson (22 rows)
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
NEREUS:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.45651762513055255	2.5710328579466823	1.1449378782610462	0.2403569693220711	1925.4505279440152	404.21009931046035	0.20993014021610493	\N	\N	\N
NEREUS:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.026109058457177578	0.3808547292106239	8312.418176226507	633.2175925590566	8311.562828396172	633.1524344687823	0.07617730233664821	\N	\N	\N
NEREUS:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.4771754311484342	1.5350641296748777	4906.616427	1695.631822	4898.32424523837	1692.76620422082	0.3455806760580105	\N	\N	\N
NEREUS:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.11166135638218204	0.742572626475702	30690.532157	5127.741194	30686.245303468313	5127.024951110023	0.16707892739586946	\N	\N	\N
NEREUS:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.07023678982136934	1.0395027644272135	0.05376256	0.00454764	3246.5759998907483	274.6197145400659	0.08458748988143422	\N	\N	\N
NEREUS:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	4.83672003019991	13.702553438890629	1550.5768990761248	782.6640559264335	10275.471488663294	5186.612928817283	0.5047566853296768	\N	\N	\N
NEREUS:43114:0x249848beca43ac405b8102ec90dd5f22ca513c06	2026-11-21T20:00:00.000Z	archival-rpc	101007806	169.6	212	10275.290027022224	10275.290027022224	1820.009101989907	1820.009101989907	1	\N	\N	\N
NEREUS:43114:0x6e84a6216ea6dacc71ee8e6b0a5b7322eebc0fdd	2026-11-21T20:00:00.000Z	archival-rpc	101007806	33.317934978370054	65.67143604660487	79893.08466841135	50876.92661410662	1542.388728959562	982.2126470568935	0.6368126456159061	\N	\N	\N
NEREUS:43114:0xb599c3590f42f8f995ecfa0f85d2980b76862fc1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.3112658898390234	1.2398046238734124	2376.3358900000003	664.333331	9.232302566239001	2.5810014242681	0.2795620492017229	\N	\N	\N
NEREUS:43114:0x47536f17f4ff30e64a96a7555826b8f9e66ec468	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0.001010182730947456	0.17408469757110673	47543.34525962235	344.857087452958	8421.107422175368	61.0827564379712	0.007253530132761577	\N	\N	\N
NEREUS:43114:0xfcde4a87b8b6fa58326bb462882f1778158b02f1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	0	0	241805.9251232933	0	5.9895327653039745	0	0	\N	\N	\N
NEREUS:43114:0x49d5c2bdffac6ce2bfdb6640f4f80f226bc10bab	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.45651762513055255	2.5710328579466823	1.1449371730062872	0.24035626406731214	1924.687475184835	404.04897486024254	0.2099296535513851	\N	\N	\N
NEREUS:43114:0xd586e7f844cea2f87f50152665bcbc2c279d8d70	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.026109058457177578	0.3808547292106239	8312.417901001769	633.2173173343175	8311.562553199756	633.1521592723637	0.07617727174881396	\N	\N	\N
NEREUS:43114:0xc7198437980c041c805a1edcba50c1ce5db95118	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.4771754311484342	1.5350641296748777	4906.613457	1695.628852	4898.321280257671	1692.7632392401201	0.3455802799344093	\N	\N	\N
NEREUS:43114:0xa7d7079b0fead91f3e65f86e8915cb59c1a4c664	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.1111987667755771	0.7410328686853138	30690.527813999997	5117.175138	30686.124030163966	5116.440874539448	0.16673467361045888	\N	\N	\N
NEREUS:43114:0x50b7545627a5162f82a992c33b87adc75187b218	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.07023678982136934	1.0395027644272135	0.05376256	0.00454764	3226.517028352	272.922976488	0.08458748988143422	\N	\N	\N
NEREUS:43114:0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7	2026-11-21T19:00:00.000Z	archival-rpc	101004130	4.83672003019991	13.702553438890629	1550.5646599971883	782.6518168474971	10266.158986635808	5181.87224965539	0.5047527762234155	\N	\N	\N
NEREUS:43114:0x249848beca43ac405b8102ec90dd5f22ca513c06	2026-11-21T19:00:00.000Z	archival-rpc	101004130	169.6	212	10274.54507363612	10274.54507363612	1819.877152240586	1819.877152240586	1	\N	\N	\N
NEREUS:43114:0x6e84a6216ea6dacc71ee8e6b0a5b7322eebc0fdd	2026-11-21T19:00:00.000Z	archival-rpc	101004130	33.317934978370054	65.67143604660487	79889.27176119786	50873.113706893135	1550.6507648848506	987.4471370507957	0.6367953116278393	\N	\N	\N
NEREUS:43114:0xb599c3590f42f8f995ecfa0f85d2980b76862fc1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.3112658898390234	1.2398046238734124	2376.33495	664.332391	9.232298914245	2.5809977722741	0.2795617642201492	\N	\N	\N
NEREUS:43114:0x47536f17f4ff30e64a96a7555826b8f9e66ec468	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0.001011669849674368	0.17421278796411888	47508.29507250141	344.85701892684546	8414.8991633896	61.08274430029447	0.007258880126103587	\N	\N	\N
NEREUS:43114:0xfcde4a87b8b6fa58326bb462882f1778158b02f1	2026-11-21T19:00:00.000Z	archival-rpc	101004130	0	0	241805.9251232933	0	5.9895327653039745	0	0	\N	\N	\N
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
