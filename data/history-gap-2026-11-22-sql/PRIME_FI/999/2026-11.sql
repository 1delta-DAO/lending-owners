-- Generated from PRIME_FI/999/2026-11.ndjson (42 rows)
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
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-21T19:00:00.000Z	archival-rpc	51881095	46.9312	64	8152.029792	8152.029792	8150.860057245146	8150.860057245146	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-21T19:00:00.000Z	archival-rpc	51881095	46.9312	64	1259.712359	1259.712359	1257.58344511329	1257.58344511329	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-21T19:00:00.000Z	archival-rpc	51881095	46.9310214031232	63.999779922578085	1898.8454731407924	1898.8447824985217	115511.18921928176	115511.14720590514	0.999999636283057	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-21T19:00:00.000Z	archival-rpc	51881095	46.9312	64	0.16719825406301128	0.16719825406301128	280.3905469189466	280.3905469189466	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-21T19:00:00.000Z	archival-rpc	51881095	46.9312	64	0.00236342	0.00236342	141.7711636649717	141.7711636649717	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-21T19:00:00.000Z	archival-rpc	51881095	1.8986211e-11	0.000037555349470635	247811.43141239716	0.5011270370037074	243.92574816785074	0.0004932693650634893	0.0000020222111391211542	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-21T19:00:00.000Z	archival-rpc	51881095	0	0	5084605.665931748	0	135977.10086344616	0	0	\N	\N	\N
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-21T20:00:00.000Z	archival-rpc	51884755	46.9312	64	8152.62529	8152.62529	8151.4865312994925	8151.4865312994925	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-21T20:00:00.000Z	archival-rpc	51884755	46.9312	64	1259.804395	1259.804395	1257.6753255724502	1257.6753255724502	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-21T20:00:00.000Z	archival-rpc	51884755	46.9310214031232	63.999779922578085	1898.8454731407924	1898.8447824985217	116092.66513010513	116092.62290523587	0.999999636283057	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-21T20:00:00.000Z	archival-rpc	51884755	46.9312	64	0.16719825406301128	0.16719825406301128	281.4855431019145	281.4855431019145	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-21T20:00:00.000Z	archival-rpc	51884755	46.9312	64	0.00236342	0.00236342	142.51694357756529	142.51694357756529	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-21T20:00:00.000Z	archival-rpc	51884755	1.8986211e-11	0.000037555349470635	247811.43141239716	0.5011270370037074	243.92574816785074	0.0004932693650634893	0.0000020222111391211542	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-21T20:00:00.000Z	archival-rpc	51884755	0	0	5084605.665931748	0	135860.51085552634	0	0	\N	\N	\N
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-22T08:00:00.000Z	archival-rpc	51928675	46.9312	64	8159.774643	8159.774643	8158.634885677866	8158.634885677866	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-22T08:00:00.000Z	archival-rpc	51928675	46.9312	64	1260.90936	1260.90936	1258.7784231816001	1258.7784231816001	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-22T08:00:00.000Z	archival-rpc	51928675	46.9310214031232	63.999779922578085	1898.8484018430267	1898.847711200756	114070.39434967429	114070.35286040316	0.999999636283618	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-22T08:00:00.000Z	archival-rpc	51928675	46.9312	64	0.16719851194333915	0.16719851194333915	277.19194069312067	277.19194069312067	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-22T08:00:00.000Z	archival-rpc	51928675	46.9312	64	0.00236342	0.00236342	139.807204093153	139.807204093153	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T08:00:00.000Z	archival-rpc	51928675	1.8986211e-11	0.000037555349470635	247811.43141239716	0.501127037004161	251.29070390942718	0.0005081628606036994	0.0000020222111391229843	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T08:00:00.000Z	archival-rpc	51928675	0	0	5084605.665931748	0	132274.33847934467	0	0	\N	\N	\N
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-22T10:00:00.000Z	archival-rpc	51935995	46.9312	64	8163.636728	8163.636728	8162.4964312218335	8162.4964312218335	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-22T10:00:00.000Z	archival-rpc	51935995	46.9312	64	1261.506265	1261.506265	1259.4373947254	1259.4373947254	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-22T10:00:00.000Z	archival-rpc	51935995	46.9310214031232	63.999779922578085	1898.2272712776587	1898.226580635388	115693.82937272477	115693.78727921456	0.9999996361646042	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-22T10:00:00.000Z	archival-rpc	51935995	46.9312	64	0.16714381967814287	0.16714381967814287	281.98322066981024	281.98322066981024	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-22T10:00:00.000Z	archival-rpc	51935995	46.9312	64	0.00236265	0.00236265	141.0325549523647	141.0325549523647	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T10:00:00.000Z	archival-rpc	51935995	1.8986211e-11	0.000037555349470635	247811.43141239704	0.5011270369079543	251.83093282990612	0.0005092553174466014	0.0000020222111387347603	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T10:00:00.000Z	archival-rpc	51935995	0	0	5084605.665931748	0	133180.36436295704	0	0	\N	\N	\N
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-22T09:00:00.000Z	archival-rpc	51932335	46.9312	64	8163.636728	8163.636728	8162.4964312218335	8162.4964312218335	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-22T09:00:00.000Z	archival-rpc	51932335	46.9312	64	1261.506265	1261.506265	1259.4373947254	1259.4373947254	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-22T09:00:00.000Z	archival-rpc	51932335	46.9310214031232	63.999779922578085	1898.0885936135214	1898.0879029712507	115685.377197237	115685.33510372679	0.9999996361380217	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-22T09:00:00.000Z	archival-rpc	51932335	46.9312	64	0.16713160872553354	0.16713160872553354	281.9626199455306	281.9626199455306	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-22T09:00:00.000Z	archival-rpc	51932335	46.9312	64	0.00236248	0.00236248	141.0224072223404	141.0224072223404	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T09:00:00.000Z	archival-rpc	51932335	1.8986211e-11	0.000037555349470635	247811.43141239704	0.5011270368864703	251.83093282990612	0.0005092553174247689	0.000002022211138648065	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T09:00:00.000Z	archival-rpc	51932335	0	0	5084605.665931748	0	133180.36436295704	0	0	\N	\N	\N
PRIME_FI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-22T11:00:00.000Z	archival-rpc	51939655	46.9312	64	8161.562956	8161.562956	8160.422948886306	8160.422948886306	1	\N	\N	\N
PRIME_FI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-22T11:00:00.000Z	archival-rpc	51939655	46.9312	64	1261.185753	1261.185753	1259.11740836508	1259.11740836508	1	\N	\N	\N
PRIME_FI:999:0x5555555555555555555555555555555555555555	2026-11-22T11:00:00.000Z	archival-rpc	51939655	46.9310214031232	63.999779922578085	1898.8488642701084	1898.8481736278377	115731.7144430195	115731.6723495093	0.9999996362837066	\N	\N	\N
PRIME_FI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-22T11:00:00.000Z	archival-rpc	51939655	46.9312	64	0.167198552661322	0.167198552661322	282.0755590099501	282.0755590099501	1	\N	\N	\N
PRIME_FI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-22T11:00:00.000Z	archival-rpc	51939655	46.9312	64	0.00236342	0.00236342	141.0785182001218	141.0785182001218	1	\N	\N	\N
PRIME_FI:999:0x7bbcf1b600565ae023a1806ef637af4739de3255	2026-11-22T11:00:00.000Z	archival-rpc	51939655	1.8986211e-11	0.000037555349470635	247811.43141239716	0.5011270370042326	251.83093282990623	0.0005092553175444412	0.000002022211139123273	\N	\N	\N
PRIME_FI:999:0x98d916f5773ac0482b49856f2659d6c32114c4ba	2026-11-22T11:00:00.000Z	archival-rpc	51939655	0	0	5084605.665931748	0	133180.36436295704	0	0	\N	\N	\N
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
