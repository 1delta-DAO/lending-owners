-- Generated from VAULT_PENDLE/4663/2026-09.ndjson (50 vault rows)
-- Apply with:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <this file>
--
-- Requires yield-tracer migration 0141 (the `source` column on the vault
-- snapshot tables). Safe to re-run: every insert upserts on the table's
-- unique index, live-cron rows are never overwritten or relabelled.
-- Rows for vaults the live surface does not list are skipped, not fatal,
-- and the counts are echoed before COMMIT.
\set ON_ERROR_STOP on
BEGIN;

CREATE TEMP TABLE _vault_stage (
  runner_key       text,
  chain_id         text,
  address          text,
  data_ts          timestamptz,
  source           text,
  rate             numeric,
  total_assets     numeric,
  total_assets_usd numeric,
  -- text, NOT numeric: a wad index is a raw integer string that must land
  -- in share_price_raw verbatim, and numeric(60,30)::text would print it
  -- with thirty zero decimals. Only the assets_per_share kind is cast.
  share_index      text,
  index_kind       text
) ON COMMIT DROP;

CREATE TEMP TABLE _vault_provider (runner_key text PRIMARY KEY, provider text NOT NULL) ON COMMIT DROP;
INSERT INTO _vault_provider VALUES
  ('VAULT_MORPHO', 'morpho'),
  ('VAULT_FLUID', 'fluid'),
  ('VAULT_YEARN', 'yearn'),
  ('VAULT_TERMMAX', 'termmax'),
  ('VAULT_UPSHIFT', 'upshift'),
  ('VAULT_LAGOON', 'lagoon'),
  ('VAULT_SILO', 'silo'),
  ('VAULT_GEARBOX', 'gearbox'),
  ('VAULT_EULER_EARN', 'euler-earn'),
  ('VAULT_LISTA', 'lst'),
  ('VAULT_PENDLE', 'pendle'),
  ('VAULT_GMX', 'gmx'),
  ('VAULT_HYPERCORE', 'hypercore'),
  ('VAULT_CAP', 'savings'),
  ('VAULT_HYPERBEAT', 'savings'),
  ('VAULT_YIELDBASIS', 'savings'),
  ('VAULT_RE', 'savings'),
  ('VAULT_SDOLA', 'savings'),
  ('VAULT_JRDOLA', 'savings'),
  ('VAULT_SINV', 'savings'),
  ('VAULT_SKY', 'savings'),
  ('VAULT_SPARK', 'savings'),
  ('VAULT_SFRXUSD', 'savings'),
  ('VAULT_WREN', 'savings'),
  ('VAULT_STRATA', 'savings'),
  ('VAULT_USDD', 'savings'),
  ('VAULT_YO', 'savings'),
  ('VAULT_FALCON', 'savings'),
  ('VAULT_TORI', 'savings'),
  ('VAULT_LLAMA', 'savings'),
  ('VAULT_LLAMA_LST', 'lst'),
  ('VAULT_IPOR', 'savings'),
  ('VAULT_ETHERFI_LIQUID', 'savings'),
  ('VAULT_VENUS_HUB', 'savings'),
  ('VAULT_BITFI', 'savings'),
  ('VAULT_RPC_FLUID', 'fluid'),
  ('VAULT_RPC_GEARBOX', 'gearbox'),
  ('VAULT_RPC_MORPHO', 'morpho'),
  ('VAULT_RPC_LISTA', 'lista'),
  ('VAULT_RPC_SILO', 'silo'),
  ('VAULT_RPC_EULER_EARN', 'euler-earn'),
  ('VAULT_RPC_LST', 'lst'),
  ('VAULT_RPC_SAVINGS', 'savings'),
  ('VAULT_RPC_LAGOON', 'lagoon'),
  ('VAULT_RPC_AAVE_EARN', 'aave-earn'),
  ('VAULT_RPC_UPSHIFT', 'upshift'),
  ('VAULT_RPC_YEARN', 'yearn'),
  ('VAULT_RPC_TERMMAX', 'termmax');


COPY _vault_stage (runner_key, chain_id, address, data_ts, source, rate, total_assets, total_assets_usd, share_index, index_kind) FROM stdin;
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-23T00:00:00.000Z	pendle-api	3.5000000000000004	\N	0.995	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-24T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49820.513	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-25T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49822.4673	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-26T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49825.7496	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-27T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49824.6312	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-28T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49825.868	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-29T00:00:00.000Z	pendle-api	3.5000000000000004	\N	49829.8784	\N	\N
VAULT_PENDLE	4663	0xc2b89e6eca583e2c232201ac557e9be58af55f4c	2026-09-30T00:00:00.000Z	pendle-api	3.47	\N	50867.6593	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-09T00:00:00.000Z	pendle-api	1.37	\N	7760.3337	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-10T00:00:00.000Z	pendle-api	3.9	\N	31733.9547	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-11T00:00:00.000Z	pendle-api	4.74	\N	45555.3278	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-12T00:00:00.000Z	pendle-api	4.87	\N	46076.4229	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-13T00:00:00.000Z	pendle-api	4.9	\N	46206.0841	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-14T00:00:00.000Z	pendle-api	5.42	\N	45640.9883	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-15T00:00:00.000Z	pendle-api	5.4	\N	47846.9572	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-16T00:00:00.000Z	pendle-api	5.35	\N	48321.3373	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-17T00:00:00.000Z	pendle-api	5.64	\N	83824.1005	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-18T00:00:00.000Z	pendle-api	5.93	\N	83682.9573	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-19T00:00:00.000Z	pendle-api	5.93	\N	83681.6329	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-20T00:00:00.000Z	pendle-api	6.11	\N	82690.2352	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-21T00:00:00.000Z	pendle-api	6.11	\N	82832.1407	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-22T00:00:00.000Z	pendle-api	6.11	\N	83026.8988	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-23T00:00:00.000Z	pendle-api	6.11	\N	83923.1558	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-24T00:00:00.000Z	pendle-api	6.43	\N	81331.2578	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-25T00:00:00.000Z	pendle-api	6.43	\N	81101.4877	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-26T00:00:00.000Z	pendle-api	6.43	\N	82021.2239	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-27T00:00:00.000Z	pendle-api	6.43	\N	81801.8063	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-28T00:00:00.000Z	pendle-api	6.43	\N	81427.146	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-29T00:00:00.000Z	pendle-api	6.43	\N	81013.3909	\N	\N
VAULT_PENDLE	4663	0x892defbf510d9baa96dbd2a51b13e879a857a79b	2026-09-30T00:00:00.000Z	pendle-api	6.43	\N	81151.8997	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-11T00:00:00.000Z	pendle-api	1	\N	1800.6758	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-12T00:00:00.000Z	pendle-api	1.1199999999999999	\N	9694.9349	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-13T00:00:00.000Z	pendle-api	2.29	\N	21755.6977	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-14T00:00:00.000Z	pendle-api	3.02	\N	16404.2518	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-15T00:00:00.000Z	pendle-api	2.94	\N	19405.4939	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-16T00:00:00.000Z	pendle-api	2.94	\N	19388.0831	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-17T00:00:00.000Z	pendle-api	3.06	\N	19638.0962	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-18T00:00:00.000Z	pendle-api	3.06	\N	19641.0828	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-19T00:00:00.000Z	pendle-api	3.06	\N	19632.5849	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-20T00:00:00.000Z	pendle-api	3.1300000000000003	\N	19635.0919	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-21T00:00:00.000Z	pendle-api	3.1300000000000003	\N	19641.4875	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-22T00:00:00.000Z	pendle-api	3.1199999999999997	\N	19663.5162	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-23T00:00:00.000Z	pendle-api	4.17	\N	13665.9795	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-24T00:00:00.000Z	pendle-api	3.2199999999999998	\N	22772.4432	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-25T00:00:00.000Z	pendle-api	3.2199999999999998	\N	22781.4245	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-26T00:00:00.000Z	pendle-api	4.760000000000001	\N	13673.8525	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-27T00:00:00.000Z	pendle-api	4.83	\N	13421.9552	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-28T00:00:00.000Z	pendle-api	4.83	\N	13424.901	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-29T00:00:00.000Z	pendle-api	4.83	\N	13428.0624	\N	\N
VAULT_PENDLE	4663	0xd6e26e957b3207a5c618213d928647ec84150ca0	2026-09-30T00:00:00.000Z	pendle-api	4.83	\N	13430.544	\N	\N
\.

ANALYZE _vault_stage;

-- One resolved row per staged row: the live identity it joins, or NULLs.
-- Pendle re-keys market → PT; everything else keys on the address as-is.
CREATE TEMP TABLE _vault_resolved ON COMMIT DROP AS
SELECT s.*,
       p.provider,
       -- The STORED address, verbatim: live rows key Solana base58 as-is, so a
       -- lower()d copy would land under a key nothing reads. EVM is already
       -- lower case in *_latest, so this changes nothing there.
       CASE WHEN p.provider = 'pendle' THEN pl.vault_address
            WHEN p.provider = 'gmx'    THEN gl.vault_address
            WHEN p.provider = 'hypercore' THEN hl.vault_address
            ELSE vl.vault_address END AS vault_address,
       vl.underlying
  FROM _vault_stage s
  LEFT JOIN _vault_provider p ON p.runner_key = s.runner_key
  LEFT JOIN vaults_latest vl
         ON p.provider NOT IN ('pendle', 'gmx', 'hypercore')
        AND vl.chain_id = s.chain_id AND vl.provider = p.provider
        AND lower(vl.vault_address) = s.address
  LEFT JOIN pendle_vaults_latest pl
         ON p.provider = 'pendle'
        AND pl.chain_id = s.chain_id AND lower(pl.market_address) = s.address
  LEFT JOIN gmx_vaults_latest gl
         ON p.provider = 'gmx'
        AND gl.chain_id = s.chain_id AND lower(gl.vault_address) = s.address
  LEFT JOIN hypercore_vaults_latest hl
         ON p.provider = 'hypercore'
        AND hl.chain_id = s.chain_id AND lower(hl.vault_address) = s.address;

ANALYZE _vault_resolved;

INSERT INTO vaults_snapshots (
    chain_id, provider, vault_address, underlying, data_ts,
    total_rate, total_assets_formatted, total_assets_usd,
    share_price, share_price_raw, source
)
SELECT DISTINCT ON (s.chain_id, s.provider, s.vault_address, s.data_ts)
       s.chain_id, s.provider, s.vault_address, s.underlying, s.data_ts,
       -- The source's headline rate → total_rate. The base/rewards split is
       -- unknown, so deposit_rate stays NULL rather than asserting rewards = 0.
       CASE WHEN abs(s.rate) >= 1e10 THEN NULL ELSE s.rate END,
       CASE WHEN abs(s.total_assets) >= 1e22 THEN NULL ELSE s.total_assets END,
       CASE WHEN abs(s.total_assets_usd) >= 1e30 THEN NULL ELSE s.total_assets_usd END,
       -- assets_per_share is the formatted "1 share → X assets" the read
       -- surface plots; other kinds are the protocol's raw integer.
       CASE WHEN s.index_kind = 'assets_per_share' THEN s.share_index::numeric(40,18) END,
       CASE WHEN s.index_kind IS DISTINCT FROM 'assets_per_share' THEN s.share_index END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL
   AND s.provider NOT IN ('pendle', 'gmx', 'hypercore')
   AND (s.rate IS NOT NULL OR s.total_assets IS NOT NULL
        OR s.total_assets_usd IS NOT NULL OR s.share_index IS NOT NULL)
 ORDER BY s.chain_id, s.provider, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, provider, vault_address, data_ts) DO UPDATE SET
    total_rate             = CASE WHEN vaults_snapshots.source = 'live-cron'
        THEN COALESCE(vaults_snapshots.total_rate, excluded.total_rate)
        ELSE COALESCE(excluded.total_rate, vaults_snapshots.total_rate) END,
    total_assets_formatted = CASE WHEN vaults_snapshots.source = 'live-cron'
        THEN COALESCE(vaults_snapshots.total_assets_formatted, excluded.total_assets_formatted)
        ELSE COALESCE(excluded.total_assets_formatted, vaults_snapshots.total_assets_formatted) END,
    total_assets_usd       = CASE WHEN vaults_snapshots.source = 'live-cron'
        THEN COALESCE(vaults_snapshots.total_assets_usd, excluded.total_assets_usd)
        ELSE COALESCE(excluded.total_assets_usd, vaults_snapshots.total_assets_usd) END,
    share_price            = CASE WHEN vaults_snapshots.source = 'live-cron'
        THEN COALESCE(vaults_snapshots.share_price, excluded.share_price)
        ELSE COALESCE(excluded.share_price, vaults_snapshots.share_price) END,
    share_price_raw        = CASE WHEN vaults_snapshots.source = 'live-cron'
        THEN COALESCE(vaults_snapshots.share_price_raw, excluded.share_price_raw)
        ELSE COALESCE(excluded.share_price_raw, vaults_snapshots.share_price_raw) END,
    source                 = CASE WHEN vaults_snapshots.source = 'live-cron' THEN 'live-cron' ELSE excluded.source END;

INSERT INTO pendle_vaults_snapshots (
    chain_id, vault_address, data_ts, implied_apy, supply_rate, tvl_usd, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       CASE WHEN abs(s.rate) >= 1e10 THEN NULL ELSE s.rate END,
       -- nominal APR from the implied APY: margin-fetcher's apyToAprPercent
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= 1e10 THEN NULL
            ELSE 100 * (power(s.rate / 100 + 1, 1.0 / 31536000) - 1) * 31536000 END,
       CASE WHEN abs(s.total_assets_usd) >= 1e30 THEN NULL ELSE s.total_assets_usd END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'pendle'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    implied_apy = CASE WHEN pendle_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(pendle_vaults_snapshots.implied_apy, excluded.implied_apy)
        ELSE COALESCE(excluded.implied_apy, pendle_vaults_snapshots.implied_apy) END,
    supply_rate = CASE WHEN pendle_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(pendle_vaults_snapshots.supply_rate, excluded.supply_rate)
        ELSE COALESCE(excluded.supply_rate, pendle_vaults_snapshots.supply_rate) END,
    tvl_usd     = CASE WHEN pendle_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(pendle_vaults_snapshots.tvl_usd, excluded.tvl_usd)
        ELSE COALESCE(excluded.tvl_usd, pendle_vaults_snapshots.tvl_usd) END,
    source      = CASE WHEN pendle_vaults_snapshots.source = 'live-cron' THEN 'live-cron' ELSE excluded.source END;

INSERT INTO gmx_vaults_snapshots (
    chain_id, vault_address, data_ts, apy, tvl_usd, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       -- gmx_vaults_snapshots.apy is a FRACTION (rateIsFraction in earn.ts);
       -- the collector normalized to percent, so divide back down here.
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= 1e10 THEN NULL ELSE s.rate / 100 END,
       CASE WHEN abs(s.total_assets_usd) >= 1e30 THEN NULL ELSE s.total_assets_usd END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'gmx'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    apy     = CASE WHEN gmx_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(gmx_vaults_snapshots.apy, excluded.apy)
        ELSE COALESCE(excluded.apy, gmx_vaults_snapshots.apy) END,
    tvl_usd = CASE WHEN gmx_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(gmx_vaults_snapshots.tvl_usd, excluded.tvl_usd)
        ELSE COALESCE(excluded.tvl_usd, gmx_vaults_snapshots.tvl_usd) END,
    source  = CASE WHEN gmx_vaults_snapshots.source = 'live-cron' THEN 'live-cron' ELSE excluded.source END;

INSERT INTO hypercore_vaults_snapshots (
    chain_id, vault_address, data_ts, tvl_usd, apr, source
)
SELECT DISTINCT ON (s.chain_id, s.vault_address, s.data_ts)
       s.chain_id, s.vault_address, s.data_ts,
       CASE WHEN abs(s.total_assets_usd) >= 1e30 THEN NULL ELSE s.total_assets_usd END,
       CASE WHEN s.rate IS NULL OR abs(s.rate) >= 1e10 THEN NULL ELSE s.rate / 100 END,
       s.source
  FROM _vault_resolved s
 WHERE s.vault_address IS NOT NULL AND s.provider = 'hypercore'
   AND (s.rate IS NOT NULL OR s.total_assets_usd IS NOT NULL)
 ORDER BY s.chain_id, s.vault_address, s.data_ts, s.ctid DESC
ON CONFLICT (chain_id, vault_address, data_ts) DO UPDATE SET
    tvl_usd = CASE WHEN hypercore_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(hypercore_vaults_snapshots.tvl_usd, excluded.tvl_usd)
        ELSE COALESCE(excluded.tvl_usd, hypercore_vaults_snapshots.tvl_usd) END,
    apr     = CASE WHEN hypercore_vaults_snapshots.source = 'live-cron'
        THEN COALESCE(hypercore_vaults_snapshots.apr, excluded.apr)
        ELSE COALESCE(excluded.apr, hypercore_vaults_snapshots.apr) END,
    source  = CASE WHEN hypercore_vaults_snapshots.source = 'live-cron' THEN 'live-cron' ELSE excluded.source END;

SELECT
    (SELECT count(*) FROM _vault_stage)                                          AS staged_rows,
    (SELECT count(*) FROM _vault_resolved WHERE provider IS NULL)                AS rows_unmapped_key,
    (SELECT count(*) FROM _vault_resolved WHERE provider IS NOT NULL AND vault_address IS NULL)
                                                                                 AS rows_unknown_vault,
    (SELECT count(DISTINCT runner_key || ':' || chain_id || ':' || address)
       FROM _vault_resolved WHERE provider IS NOT NULL AND vault_address IS NULL) AS unknown_vaults
\gset _vault_
\echo '  staged=':_vault_staged_rows'  unmapped_key_rows=':_vault_rows_unmapped_key'  unknown_vault_rows=':_vault_rows_unknown_vault'  unknown_vaults=':_vault_unknown_vaults

COMMIT;
