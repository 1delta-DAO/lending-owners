-- Generated from VAULT_LLAMA/1/2023-03.ndjson (31 vault rows)
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
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-01T23:00:00.000Z	defillama-api	32.04984072375794	\N	29242599	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-02T23:00:00.000Z	defillama-api	32.00276919947953	\N	28649605	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-03T23:00:00.000Z	defillama-api	31.395453264337903	\N	26913801	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-04T23:00:00.000Z	defillama-api	31.017218700668536	\N	26467049	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-05T23:00:00.000Z	defillama-api	31.2546574349426	\N	27102322	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-06T23:00:00.000Z	defillama-api	31.48259251375407	\N	27721212	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-07T23:00:00.000Z	defillama-api	31.71727650439493	\N	28036858	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-08T23:00:00.000Z	defillama-api	31.94438600040428	\N	25847689	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-09T23:00:00.000Z	defillama-api	31.72065586198869	\N	24072328	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-10T23:00:00.000Z	defillama-api	32.536903766455794	\N	25557379	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-11T23:00:00.000Z	defillama-api	33.57997967050608	\N	26170638	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-12T23:00:00.000Z	defillama-api	33.32180193211798	\N	27471455	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-13T23:00:00.000Z	defillama-api	33.09808999993891	\N	29017440	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-14T23:00:00.000Z	defillama-api	32.337057409392855	\N	29202380	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-15T23:00:00.000Z	defillama-api	31.565629758034675	\N	26575445	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-16T23:00:00.000Z	defillama-api	30.583945283524372	\N	27428027	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-17T23:00:00.000Z	defillama-api	29.94180641984201	\N	30890255	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-18T23:00:00.000Z	defillama-api	29.324847481504435	\N	31386210	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-19T23:00:00.000Z	defillama-api	28.68542344778291	\N	33820697	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-20T23:00:00.000Z	defillama-api	28.395977898654223	\N	31924690	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-21T23:00:00.000Z	defillama-api	28.466489952450047	\N	33351747	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-22T23:00:00.000Z	defillama-api	28.537990044696926	\N	31655390	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-23T23:00:00.000Z	defillama-api	28.414404710730423	\N	33480083	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-24T23:00:00.000Z	defillama-api	28.194273805226544	\N	31371448	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-25T23:00:00.000Z	defillama-api	28.038242156824822	\N	31516704	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-26T23:00:00.000Z	defillama-api	27.879469769587217	\N	32401889	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-27T23:00:00.000Z	defillama-api	27.671722606115168	\N	30734139	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-28T23:00:00.000Z	defillama-api	27.622036386176774	\N	32105018	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-29T23:00:00.000Z	defillama-api	27.553567632310205	\N	34525671	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-30T23:00:00.000Z	defillama-api	27.4929758766973	\N	33843938	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2023-03-31T23:00:00.000Z	defillama-api	27.61095929173507	\N	35593742	\N	\N
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
