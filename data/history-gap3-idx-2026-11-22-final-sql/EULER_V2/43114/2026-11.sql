-- Generated from EULER_V2/43114/2026-11.ndjson (61 rows)
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
EULER_V2:43114:0xca71ac6c9c628d79b5183491a25cc7476dd20c2c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x258ee5a9f669de89fa59aadf83960fc285783c3e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x0bb742091dac1858eaf967196a293fe3ed001bcd	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x6c718a70239fa548c0bd268fe88f37ebe8b6e2ea	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.014082007572433337188070840776	\N	assets_per_share
EULER_V2:43114:0xaba9d2d4b6b93c3dc8976d8eb0690cca56431fe4	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	3.386373244792854522661384216707	\N	assets_per_share
EULER_V2:43114:0x38a559c2b6ef3ff7cdc40a800d6351a2b70b2243	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xb52a9c3aea75939a78287f81b53a9e965e058eec	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x7485484dab196c615ae21453c3abd732977562f2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000332108164275569406435318304	\N	assets_per_share
EULER_V2:43114:0x4ec5b9a4d4fd9e35d4f881d35aab9877bfda5803	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x72f92a966f1874f74e1b601bee7cf57031b53a03	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x2137568666f12fc5a026f5430ae7194f1c1362ab	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.047646961587264209770102268846	\N	assets_per_share
EULER_V2:43114:0x39de0f00189306062d79edec6dca5bb6bfd108f9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.051288761169228098815721017344	\N	assets_per_share
EULER_V2:43114:0xa45189636c04388adbb4d865100dd155e55682ec	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.042356366768397073095530344484	\N	assets_per_share
EULER_V2:43114:0xfecebf56f150a68ddd197c3a6101da35c46693ac	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xdfed1b334a1b78e7b109fe1ff34c4da0ccb317fc	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000000881246771294267166600666	\N	assets_per_share
EULER_V2:43114:0xa429273b892c2c90b1d90778f4786e6470f402ec	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000403731778422350806817741827	\N	assets_per_share
EULER_V2:43114:0x69b07db605d0a08fbe9245c1466880aa36c8e1a7	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.118061935583228881027040670091	\N	assets_per_share
EULER_V2:43114:0x152179bfc75f780bfe5b0d3c0d3c797108fb24c3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x91bfd7192990c2a56df4aceff5fe063b75b636a5	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x6fc9b3a52944a577cd8971fd8fde0819001bc595	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	2.090140591004022150337852539103	\N	assets_per_share
EULER_V2:43114:0x5030183b3dd0105d69d7d45595c120fc4b542ec3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x03ef14425cf0d7af62cdb8d6e0acb0b0512ae35c	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.752530302569546586364000616235	\N	assets_per_share
EULER_V2:43114:0xe91841f707936faf515ff6d478624a325a4f9199	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.846215793906958076527119836384	\N	assets_per_share
EULER_V2:43114:0x6072a6d18446278bb5a43eb747de8f61e34cb77f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.74475969237849037101207048112	\N	assets_per_share
EULER_V2:43114:0xe1e549c965a4a0514d9bf80161d32924b8694822	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.082349106271952253589241203313	\N	assets_per_share
EULER_V2:43114:0xb9cc370a8f19322fc4bf69da80c6c39ff8f2db90	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xa4284e26ae6469aee8ec38aa9db96fc62d6315a1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.402541774419104748514207595675	\N	assets_per_share
EULER_V2:43114:0xa446938b0204aa4055cdfed68ddf0e0d1bab3e9e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.372417710320429578304844263774	\N	assets_per_share
EULER_V2:43114:0x38ea4c0724b20b02e5fde235f657a3afc184f5ac	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x4d758ab40abb122402f01e1ec4c71acb06a1f620	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x1ff92f8c033a365de2d82d390a1799abfcad7394	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xa6f3fbc837d38b741abe2374d4b6da1ab38f3397	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x902714c7661697c873c76dec426b63b2593ecc0a	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.037340587422653138805664976285	\N	assets_per_share
EULER_V2:43114:0x76de251bee4a3b902857f6a0fce8a320c4167e40	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x50b2323ecb8f41c7204099bab5df8c2da520d2a1	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.00146958673066349465458450233	\N	assets_per_share
EULER_V2:43114:0x833473522c89484bf4d7201431e2c1dcc7d7755f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x51b47b3013863c52ca28d603de3c2d7a5fef50b9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xa321a38b03a7218157668a724e186f3a81cf56c8	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.027777139046655476097403941226	\N	assets_per_share
EULER_V2:43114:0x8f23da78e3f31ab5deb75dc3282198bed630ffde	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.028024964339260513610255970418	\N	assets_per_share
EULER_V2:43114:0xea534105c2ccc0582d82b285aa47a6b446383d44	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x6de07d6cbd0c4e8fa93da3d7bdaa1d1505651a1e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xd058fbf3ac2e1bca615eb127c2b94af1b3be11a9	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x6e65eb6cac41a19e0b8bb16f3b5ad150f9124d3d	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xb29ccce25e5ff193df8625e381da8fa55dc85e1b	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.036174606352744996667931756851	\N	assets_per_share
EULER_V2:43114:0xf727df1b8f59fa9b254df26890a81f4a0a644420	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000000676683404374804375229116	\N	assets_per_share
EULER_V2:43114:0x019225e2ef9e715548f4a380559142756385f9c2	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x6e03ae179fab1c17401539c355cbc6e360735836	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x37ca03ad51b8ff79aad35fadacba4cedf0c3e74e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.062794046018600425612148302924	\N	assets_per_share
EULER_V2:43114:0x3f96e387ec6462dfbe9f05838943d19307dd2752	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xf983f92bd962a94eac85a8c58237c1cc1cdfbbba	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.017321725726497223633274361085	\N	assets_per_share
EULER_V2:43114:0xbac3983342b805e66f8756e265b3b0ddf4b685fc	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xf3acc3fc22e376fa3dd21cf883b60dde9cf4e34f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x973b34f3a1efe570995703dc1272c9ea07f9c390	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x5415f52931069facb2eee2bb494f61e3fb8b5e21	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x11b95fb3ea91ebe1809a7a122f519bc6aaf5d375	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000014600172282032927988550264	\N	assets_per_share
EULER_V2:43114:0xfdc2c299fb0eecbac9144c9ae3c3ffa7f3d27c26	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.000031912580079171219398365359	\N	assets_per_share
EULER_V2:43114:0xff5d48183f6089ac9da55f26761d5afc4d13222e	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x5b65459c1d3f544cb3b65ffb6db1fb9619f54bf6	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0x8b0c4190ef18ccc8d6b28156f0112e53673488b3	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:43114:0xa9b21f76a3cd97f3e886bf299abc5f7ccca58d5f	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1.014127565937804921089506348061	\N	assets_per_share
EULER_V2:43114:0x5db7b0dbcda67e4ff1b4d9b17a1cf2e6416bcc81	2026-11-21T20:00:00.000Z	archival-rpc	101007806	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
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
