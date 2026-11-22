-- Generated from HYPURRFI/999/2026-11.ndjson (19 rows)
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
HYPURRFI:999:0x5555555555555555555555555555555555555555	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.019725033882715674886966383	1.032374861615993299334887064	ray
HYPURRFI:999:0x94e8396e0869c9f2200760af0621afd240e1cf38	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.0020064155684020228348886	1.023802084213393881608710618	ray
HYPURRFI:999:0xca79db4b49f608ef54a5cb813fbed3a6387bc645	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1	1.187453376898636692097396572	ray
HYPURRFI:999:0x9fdbda0a5e284c32744d2f17ee5c74b284993463	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.011661080859862528285018764	1.029730370318668334577497146	ray
HYPURRFI:999:0xbe6727b535545c67d5caa73dea54865b92cf7907	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.028292348410168936937395312	1.052131786245858048706097605	ray
HYPURRFI:999:0x5d3a1ff2b6bab83b63cd9ad0787074081a52ef34	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.125114677122625171255887218	1.213480931379708314426162901	ray
HYPURRFI:999:0x02c6a2fa58cc01a18b8d9e00ea48d65e4df26c70	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.080094883087290583174990677	1.202344596864666089896955355	ray
HYPURRFI:999:0xb8ce59fc3717ada4c02eadf9682a9e934f625ebb	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.079881993523781528191781223	1.156387560115964965653981842	ray
HYPURRFI:999:0xb50a96253abdf803d85efcdce07ad8becbc52bd5	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.058572624487776714472050539	1.166871706106423368703739505	ray
HYPURRFI:999:0x068f321fa8fb9f0d135f290ef6a3e2813e1c8a29	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.068755150580952150119003864	1.104686994364782460842447307	ray
HYPURRFI:999:0xfd739d4e423301ce9385c1fb8850539d657c296d	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.001886119735523395819846161	1.018763731999587134689100235	ray
HYPURRFI:999:0xf4d9235269a96aadafc9adae454a0618ebe37949	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.00204553346622749260332285	1.010221865565455623137688349	ray
HYPURRFI:999:0xfdd22ce6d1f66bc0ec89b20bf16ccb6670f55a5a	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.012294193309664330740609637	1.039433654071969466235142586	ray
HYPURRFI:999:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.000357378702464347011037759	1.000357606981387543217373891	ray
HYPURRFI:999:0x311db0fde558689550c68355783c95efdfe25329	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1	1	ray
HYPURRFI:999:0xd8fc8f0b03eba61f64d08b0bef69d80916e5dda9	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.001717910528733466041274159	1.008209413528872793396979873	ray
HYPURRFI:999:0xb88339cb7199b77e23db6e890353e22632ba630f	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.055320071522118881626793512	1.088244427399645868313491503	ray
HYPURRFI:999:0x111111a1a0667d36bd57c0a9f569b98057111111	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1.212187110601749408017074062	1.291885540080317879443879061	ray
HYPURRFI:999:0xea84ca9849d9e76a78b91f221f84e9ca065fc9f5	2026-11-22T11:00:00.000Z	archival-rpc	51939655	\N	\N	\N	\N	\N	\N	\N	1	1	ray
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
