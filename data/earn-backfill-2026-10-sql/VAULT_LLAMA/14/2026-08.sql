-- Generated from VAULT_LLAMA/14/2026-08.ndjson (31 vault rows)
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
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-01T23:00:00.000Z	defillama-api	5.518652005775948	\N	760600	1.00746	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-02T23:00:00.000Z	defillama-api	5.46904351246269	\N	760750	1.00755	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-03T23:00:00.000Z	defillama-api	5.365583072247659	\N	760502	1.00764	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-04T23:00:00.000Z	defillama-api	6.167160251280279	\N	761898	1.00792	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-05T23:00:00.000Z	defillama-api	10.733432820941857	\N	762638	1.00892	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-06T23:00:00.000Z	defillama-api	10.059274789142592	\N	762598	1.0089	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-07T23:00:00.000Z	defillama-api	9.955887173873634	\N	762786	1.00896	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-08T23:00:00.000Z	defillama-api	9.831629609635684	\N	762710	1.00902	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-09T23:00:00.000Z	defillama-api	9.617280584706123	\N	762872	1.00908	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-10T23:00:00.000Z	defillama-api	9.52431744032367	\N	762838	1.00916	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-11T23:00:00.000Z	defillama-api	8.644335103724643	\N	763271	1.00926	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-12T23:00:00.000Z	defillama-api	3.8850645228905023	\N	733177	1.00934	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-13T23:00:00.000Z	defillama-api	4.389668574233951	\N	738968	1.00941	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-14T23:00:00.000Z	defillama-api	4.396913255888535	\N	741005	1.00949	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-15T23:00:00.000Z	defillama-api	4.554442717363827	\N	736614	1.00957	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-16T23:00:00.000Z	defillama-api	4.641028777285783	\N	737498	1.00964	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-17T23:00:00.000Z	defillama-api	4.6761156962560335	\N	738460	1.00972	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-18T23:00:00.000Z	defillama-api	4.448280751745415	\N	739073	1.00979	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-19T23:00:00.000Z	defillama-api	4.4653140864880925	\N	740031	1.00987	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-20T23:00:00.000Z	defillama-api	4.45883966868621	\N	739773	1.00995	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-21T23:00:00.000Z	defillama-api	4.526012978800509	\N	760091	1.01002	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-22T23:00:00.000Z	defillama-api	4.515337121802077	\N	759983	1.0101	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-23T23:00:00.000Z	defillama-api	4.623528382552422	\N	762758	1.01018	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-24T23:00:00.000Z	defillama-api	4.616414645752798	\N	763133	1.01026	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-25T23:00:00.000Z	defillama-api	4.875901832690488	\N	762116	1.01039	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-26T23:00:00.000Z	defillama-api	4.953265033336152	\N	762323	1.01048	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-27T23:00:00.000Z	defillama-api	5.126148654355234	\N	761380	1.01061	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-28T23:00:00.000Z	defillama-api	5.5605270500080906	\N	756369	1.01076	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-29T23:00:00.000Z	defillama-api	5.672734186390471	\N	757553	1.01087	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-30T23:00:00.000Z	defillama-api	5.832815321937801	\N	758262	1.01097	assets_per_share
VAULT_LLAMA	14	0xb7c1c8f7191c7d76b5c6650a6fb20f6f8027bf0d	2026-08-31T23:00:00.000Z	defillama-api	5.959406785649435	\N	756546	1.01109	assets_per_share
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
