-- Generated from VAULT_LLAMA/42161/2026-04.ndjson (60 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-01T23:00:00.000Z	defillama-api	4.143518155785841	\N	3649	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-02T23:00:00.000Z	defillama-api	4.39690345253041	\N	3650	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-03T23:00:00.000Z	defillama-api	4.051765726131862	\N	3649	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-04T23:00:00.000Z	defillama-api	4.085764472350206	\N	3650	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-05T23:00:00.000Z	defillama-api	4.051141812411174	\N	3650	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-06T23:00:00.000Z	defillama-api	4.130181387296261	\N	3651	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-07T23:00:00.000Z	defillama-api	4.2622130145275605	\N	3651	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-08T23:00:00.000Z	defillama-api	4.1855892671804895	\N	3652	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-09T23:00:00.000Z	defillama-api	4.2591081509613105	\N	3652	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-10T23:00:00.000Z	defillama-api	4.32368707237174	\N	3653	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-11T23:00:00.000Z	defillama-api	4.349703784356507	\N	3653	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-12T23:00:00.000Z	defillama-api	4.488349877362907	\N	3654	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-13T23:00:00.000Z	defillama-api	4.429167704600445	\N	3654	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-14T23:00:00.000Z	defillama-api	4.449504771031343	\N	3657	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-15T23:00:00.000Z	defillama-api	4.319798640395334	\N	3657	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-16T23:00:00.000Z	defillama-api	4.430966620816434	\N	3658	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-17T23:00:00.000Z	defillama-api	4.483301147928387	\N	3658	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-18T23:00:00.000Z	defillama-api	4.573130018670213	\N	3657	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-19T23:00:00.000Z	defillama-api	4.370669666187155	\N	3658	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-20T23:00:00.000Z	defillama-api	4.407640230397192	\N	3658	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-21T23:00:00.000Z	defillama-api	4.429138994765935	\N	3658	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-22T23:00:00.000Z	defillama-api	4.5135017931130506	\N	3659	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-23T23:00:00.000Z	defillama-api	4.545986620740905	\N	3659	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-24T23:00:00.000Z	defillama-api	4.515633323265433	\N	3660	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-25T23:00:00.000Z	defillama-api	4.62744342364374	\N	3660	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-26T23:00:00.000Z	defillama-api	4.707164331918534	\N	3661	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-27T23:00:00.000Z	defillama-api	4.648341382207377	\N	3661	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-28T23:00:00.000Z	defillama-api	4.7181629994952345	\N	3662	\N	\N
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-29T23:00:00.000Z	defillama-api	4.64284239853896	\N	3662	1.06405	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-04-30T23:00:00.000Z	defillama-api	4.764274494917231	\N	3663	1.06419	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-01T23:00:00.000Z	defillama-api	4.95106698039649	\N	555251	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-02T23:00:00.000Z	defillama-api	5.107241477730895	\N	555661	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-03T23:00:00.000Z	defillama-api	4.99694669642281	\N	556328	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-04T23:00:00.000Z	defillama-api	4.865329611192237	\N	556398	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-05T23:00:00.000Z	defillama-api	4.951428304167393	\N	553041	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-06T23:00:00.000Z	defillama-api	4.916066891169635	\N	553581	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-07T23:00:00.000Z	defillama-api	4.973619605763702	\N	553990	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-08T23:00:00.000Z	defillama-api	4.979641668612089	\N	554538	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-09T23:00:00.000Z	defillama-api	5.011756769590647	\N	555373	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-10T23:00:00.000Z	defillama-api	4.440580213938006	\N	555608	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-11T23:00:00.000Z	defillama-api	4.364562174075104	\N	555710	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-12T23:00:00.000Z	defillama-api	4.5330377851371395	\N	555880	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-13T23:00:00.000Z	defillama-api	4.517277486471016	\N	555900	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-14T23:00:00.000Z	defillama-api	4.5286031660651815	\N	556363	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-15T22:00:00.000Z	defillama-api	4.7892044346298235	\N	557531	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-16T23:00:00.000Z	defillama-api	4.586035439402281	\N	540253	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-17T23:00:00.000Z	defillama-api	4.431894438639006	\N	584261	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-18T23:00:00.000Z	defillama-api	4.58912069625228	\N	584340	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-19T23:00:00.000Z	defillama-api	6.1645091431472565	\N	545379	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-20T23:00:00.000Z	defillama-api	5.826938208741694	\N	544339	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-21T23:00:00.000Z	defillama-api	3.593705918447654	\N	534390	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-22T23:00:00.000Z	defillama-api	4.0564426281974875	\N	530078	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-23T23:00:00.000Z	defillama-api	4.562860300794114	\N	566832	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-24T23:00:00.000Z	defillama-api	4.197230754954262	\N	568336	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-25T22:00:00.000Z	defillama-api	3.462372430362848	\N	567446	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-26T23:00:00.000Z	defillama-api	3.689117801641828	\N	566136	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-27T23:00:00.000Z	defillama-api	3.619267474519461	\N	567504	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-28T23:00:00.000Z	defillama-api	3.5289827476248092	\N	567192	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-29T23:00:00.000Z	defillama-api	3.6542227483948864	\N	567073	\N	\N
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-04-30T23:00:00.000Z	defillama-api	3.9729908419161575	\N	585154	\N	\N
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
