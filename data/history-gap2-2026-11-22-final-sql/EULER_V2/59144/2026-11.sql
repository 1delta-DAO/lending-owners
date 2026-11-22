-- Generated from EULER_V2/59144/2026-11.ndjson (65 rows)
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
EULER_V2:59144:0x64623f8617f0019fc155a84c5061b472577d23d0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x9ac2f0a564b7396a8692e1558d23a12d5a2abb1f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.458193141814852	0	785.6973230182365	0	\N	\N	\N	\N
EULER_V2:59144:0x8bf8edc911ab3f0ea4a27c51cb88b57cce5356f1	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.9619953508906988	0	1649.6038525522758	0	\N	\N	\N	\N
EULER_V2:59144:0x14efcc1ae56e2ff75204ef2fb0de43378d0beada	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	26.987772	0	26.98400234800704	0	\N	\N	\N	\N
EULER_V2:59144:0x085f80df643307e04f23281f6fdbfaa13865e852	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	1765.509995	0	1762.6145586082	0	\N	\N	\N	\N
EULER_V2:59144:0x873fea936c29c8a9f3e0d7cacfc1dc46e2a93e56	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.006956070672766425	0	13.032302882061806	0	\N	\N	\N	\N
EULER_V2:59144:0xf1666e72928012694c38201f895deac55c3b567f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xf29ac58e23904ce3057afe2f9c430c87703da982	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xd890507bb7f760294acc0d99ac7243144d6dc5d3	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xad3b410283f74a7528f5a5056493b9e24b68b082	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xba28cf86c3186f93398b44624842693a2a0c3b24	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x573d66781facc83d6b6914f7e327c82e3182af6a	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xfb6448b96637d90fcf2e4ad2c622a487d0496e6f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.3199339928983136	2.0490194884814628	16573.522995	3206.840418	16571.208005308057	3206.392486530414	\N	\N	\N	\N
EULER_V2:59144:0xcbef9be95738290188b25ca9a6dd2bec417a578c	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0.003643348023274484	0.21949718842506627	11522.017886	238.816382	11503.12177666696	238.42472313352002	\N	\N	\N	\N
EULER_V2:59144:0xa7ada0d422a8b5fa4a7947f2cb0ee2d32435647d	2026-11-22T11:00:00.000Z	archival-rpc	32680425	2.196143385546634	5.349074217164684	23408.351874	11824.242825	23408.351874	11824.242825	\N	\N	\N	\N
EULER_V2:59144:0xb747b627c3b67cdc0aeaf78fd7174ae5e5bfa796	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0.001159202303322273	0	2.156501564249735	0	\N	\N	\N	\N
EULER_V2:59144:0x35fb89b7f433d580119512c4e2bb09169674e01e	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x54a4dc1df3861166c976eaa5a66b4d2dcc7e7f55	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x86f10df5901e4428573239c63e85186958b01002	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x489f9875c30967391f377e6de1f0f41a4a494178	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x0e1d589b053261249728fb9214f8aba5847a55e8	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x625cf245c3121cc9e440b34b2bd22c1db3f54469	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xa65f2a6876d40d8c33b6dbd9813d7fc30ae5251a	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x8438d8f83b75ee1bb50adf1c7e5cad0e7dd0e432	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x6ab15158a60df56536ef63e6adbec3fc6d7be0e2	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x87f33a398e1db823cdf25854b3ac8ad46f507be0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xd9990f3c4ed2ef8eee4648bf626eeae735b84b42	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xc5a62bce1f0533fadeec3b69cde75d5011b82c44	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x319822233a2a40be9d134181537b71b65fd2c8d0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x62110fbaf43ca64987c381d2d6a4030b24d0186d	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x5f542a5fee3884b93f910511becd7ce5884ab70e	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x03236ecef0c71f210bc7bed3daac2ae63bd93116	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xf7960a8381a5ddb9621fb7843e2c600e0c47524b	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x19347ac0a1b48438d8630953ed61f6436c4e7b2a	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x593a29c978e0e7202c2d9bd2068a3b7079130fb7	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x55ed7723348beaee5f8f2c6dd261f772c16c42c0	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xb9b416a4ddf4a9addc994bacf1c26699b5ad0903	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x6f056f9335a06f8142277991f6c1a42d93ecbf23	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x7489d8a3c56e4f99402d6bb2d6fdbe43305b0e45	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x6bdd7e583e8c87a123cccdeb5d6843a961bf82ec	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x344f23586d38b04ad9dcb6930049398fe236664f	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x1357689457f3df40df36583783e63bc84080f6a2	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xbc1ad67a0211596136feeef520a9b327cd7d33a3	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xfd3f8e5eb0581f5ed17b57d94b969a0c2f6734af	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x1578f3ed6e088820d190a3114d04146b2493a32b	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x4874694878f426d00719aae7386b9b60725ec030	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x795275906ecf6d885ff3ac319779148060d4fe84	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xb24ddf2c722cb6cbf230e2d1e2a9407799a01a8b	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x57e36400431b4a57d43123e0394a5d0a59941612	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x046dbb9bc7ebbe644c09f25fb6e1ce6a742854fb	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xb21b86a7b7da3d57c4a16be84bd8b3b6332b6daf	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xf5bf847af527ef40682b828f40f62a2e17ddd8c5	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xfcc031e7fe1720bf126987eff9f3600df46a4709	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x8677298be252aa964009c5c9ce4b5b55fd84710b	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x54b1b5c393c5312d35917760fdf2abe8d2485a38	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x0d953a0c870cbc95f6dc076af60e312209f46559	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xc64940f04a288bb22a3a02ab5dde62c9fe57a3b6	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x9e52437e0e8d173816352106c7b86ef363f15f1d	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x6e1ad0ac17d5519fd259ac6563b37a904b788ed8	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xd93dda33225d3a2e5947ac6bace7933f5b64b72c	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0xfd598df5050a4a4041c5a6d1cdb41244f3e33551	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x65a15ca90dbb099877b5b0e9bfd110270daaaccc	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x3174a21ba5c45f3bd8bdc67c1fef32f7de4514dd	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x2af52aa09c7462d92f5d740c445319f6f3d1e434	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
EULER_V2:59144:0x9d0f1fbb7538e1b59059dc0978ee598c46bc9f78	2026-11-22T11:00:00.000Z	archival-rpc	32680425	0	0	0	0	0	0	\N	\N	\N	\N
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
