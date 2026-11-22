-- Generated from VAULT_LLAMA/14/2026-09.ndjson (30 vault rows)
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
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-01T23:00:00.000Z	defillama-api	5.695087243395847	\N	756426	1.01117	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-02T23:00:00.000Z	defillama-api	5.806813314990222	\N	755741	1.01129	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-03T23:00:00.000Z	defillama-api	5.694057190552826	\N	754174	1.01139	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-04T23:00:00.000Z	defillama-api	5.64735259196425	\N	753654	1.01152	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-05T23:00:00.000Z	defillama-api	6.0906842545449535	\N	754415	1.01172	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-06T23:00:00.000Z	defillama-api	6.508674936611669	\N	755158	1.01189	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-07T23:00:00.000Z	defillama-api	6.576807575342514	\N	756168	1.01202	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-08T23:00:00.000Z	defillama-api	7.102233259104196	\N	756602	1.01221	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-09T23:00:00.000Z	defillama-api	11.109521149421653	\N	749461	1.0131	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-10T23:00:00.000Z	defillama-api	11.201085214551654	\N	688931	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-11T23:00:00.000Z	defillama-api	10.36701410477292	\N	688766	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-12T23:00:00.000Z	defillama-api	9.26778106418169	\N	687345	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-13T23:00:00.000Z	defillama-api	8.406647784298116	\N	685797	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-14T23:00:00.000Z	defillama-api	7.646916239423263	\N	684407	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-15T23:00:00.000Z	defillama-api	6.580618280693784	\N	681452	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-16T23:00:00.000Z	defillama-api	2.18504318318935	\N	148485	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-17T23:00:00.000Z	defillama-api	2.0264773667122427	\N	138303	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-18T23:00:00.000Z	defillama-api	2.2570950644507093	\N	138329	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-19T23:00:00.000Z	defillama-api	2.370295140963208	\N	138086	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-20T23:00:00.000Z	defillama-api	2.3215913575569402	\N	40735	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-21T23:00:00.000Z	defillama-api	2.3688008290889684	\N	38720	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-22T23:00:00.000Z	defillama-api	2.458314591891053	\N	37693	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-23T23:00:00.000Z	defillama-api	2.694072050246632	\N	37691	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-24T23:00:00.000Z	defillama-api	2.8443715351045284	\N	37692	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-25T23:00:00.000Z	defillama-api	2.900796863514188	\N	33670	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-26T23:00:00.000Z	defillama-api	\N	\N	33664	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-27T23:00:00.000Z	defillama-api	\N	\N	33466	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-28T23:00:00.000Z	defillama-api	2.48705453671505	\N	32762	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-29T23:00:00.000Z	defillama-api	2.8012073492789114	\N	31273	1.01314	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-09-30T23:00:00.000Z	defillama-api	3.082343852156555	\N	30853	1.01314	assets_per_share
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
