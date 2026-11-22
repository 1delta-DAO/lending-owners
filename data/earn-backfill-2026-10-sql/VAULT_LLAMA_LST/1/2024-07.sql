-- Generated from VAULT_LLAMA_LST/1/2024-07.ndjson (62 vault rows)
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
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-01T23:00:00.000Z	defillama-api	\N	\N	301679131	1.05219	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-02T23:00:00.000Z	defillama-api	3.770909319200655	\N	300523457	1.05219	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-03T23:00:00.000Z	defillama-api	3.771689386411481	\N	290055024	1.0523	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-04T23:00:00.000Z	defillama-api	3.7720745183378313	\N	275518373	1.05241	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-05T23:00:00.000Z	defillama-api	\N	\N	262035548	1.05252	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-06T23:00:00.000Z	defillama-api	3.7720836214560904	\N	269611533	1.05252	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-07T23:00:00.000Z	defillama-api	3.772468753382441	\N	259139644	1.05263	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-08T23:00:00.000Z	defillama-api	\N	\N	266063834	1.05274	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-09T23:00:00.000Z	defillama-api	3.7728636886669165	\N	270072385	1.05274	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-10T23:00:00.000Z	defillama-api	3.773248820593267	\N	272803234	1.05285	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-11T23:00:00.000Z	defillama-api	3.773633952519617	\N	272529090	1.05296	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-12T23:00:00.000Z	defillama-api	3.774038691162218	\N	275436720	1.05307	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-13T23:00:00.000Z	defillama-api	\N	\N	281213788	1.05319	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-14T23:00:00.000Z	defillama-api	3.7744238230885685	\N	288863818	1.05319	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-15T23:00:00.000Z	defillama-api	3.774808955014919	\N	308712748	1.0533	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-16T23:00:00.000Z	defillama-api	3.775589022225745	\N	304840415	1.05341	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-17T23:00:00.000Z	defillama-api	3.7759839575102205	\N	301610438	1.05352	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-18T23:00:00.000Z	defillama-api	\N	\N	304819428	1.05363	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-19T23:00:00.000Z	defillama-api	3.7759839575102205	\N	312047884	1.05363	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-20T23:00:00.000Z	defillama-api	3.776378892794696	\N	312167639	1.05374	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-21T23:00:00.000Z	defillama-api	3.777158960005522	\N	313978053	1.05385	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-22T23:00:00.000Z	defillama-api	3.7775531950501318	\N	306541299	1.05396	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-23T23:00:00.000Z	defillama-api	3.777938326976482	\N	308700336	1.05407	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-24T23:00:00.000Z	defillama-api	3.778333262260958	\N	296156391	1.05419	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-25T23:00:00.000Z	defillama-api	3.778718394187308	\N	281759397	1.0543	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-26T23:00:00.000Z	defillama-api	\N	\N	291930341	1.05441	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-27T23:00:00.000Z	defillama-api	3.779113329471784	\N	291373052	1.05441	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-28T23:00:00.000Z	defillama-api	3.779498461398134	\N	289692646	1.05452	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-29T23:00:00.000Z	defillama-api	\N	\N	296362507	1.05463	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-30T23:00:00.000Z	defillama-api	3.7795082647562595	\N	291334254	1.05463	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-07-31T23:00:00.000Z	defillama-api	3.779903200040735	\N	288246615	1.05474	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-01T23:00:00.000Z	defillama-api	2.848881079842158	\N	152819016	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-02T23:00:00.000Z	defillama-api	2.8325906995974037	\N	152260749	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-03T23:00:00.000Z	defillama-api	2.855111113930775	\N	146801084	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-04T23:00:00.000Z	defillama-api	3.314478969684842	\N	141024563	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-05T23:00:00.000Z	defillama-api	3.6151297571507257	\N	132397241	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-06T23:00:00.000Z	defillama-api	3.615332126472026	\N	135670453	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-07T23:00:00.000Z	defillama-api	3.1176520469244906	\N	116285760	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-08T23:00:00.000Z	defillama-api	2.960744398450288	\N	119824940	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-09T23:00:00.000Z	defillama-api	2.8163556383020705	\N	122177625	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-10T23:00:00.000Z	defillama-api	2.7948862840077027	\N	124578329	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-11T23:00:00.000Z	defillama-api	2.799874792813739	\N	123574965	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-12T23:00:00.000Z	defillama-api	2.7922995979423604	\N	124561459	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-13T23:00:00.000Z	defillama-api	3.21666596398984	\N	126549877	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-14T23:00:00.000Z	defillama-api	3.5751530631955575	\N	129584003	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-15T23:00:00.000Z	defillama-api	3.5937731414747986	\N	139301382	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-16T23:00:00.000Z	defillama-api	3.164633240260173	\N	137332533	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-17T23:00:00.000Z	defillama-api	2.983876122186757	\N	139414858	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-18T23:00:00.000Z	defillama-api	2.925351474658555	\N	141666944	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-19T23:00:00.000Z	defillama-api	2.926885700205162	\N	144593483	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-20T23:00:00.000Z	defillama-api	2.930352587782181	\N	146576035	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-21T23:00:00.000Z	defillama-api	2.920533824379845	\N	147411016	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-22T23:00:00.000Z	defillama-api	3.296426085697135	\N	144009799	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-23T23:00:00.000Z	defillama-api	3.6390555528953428	\N	144857525	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-24T23:00:00.000Z	defillama-api	3.6950250251521766	\N	140462498	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-25T23:00:00.000Z	defillama-api	3.2196391824612647	\N	134818888	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-26T23:00:00.000Z	defillama-api	2.989884180237823	\N	139579246	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-27T23:00:00.000Z	defillama-api	2.9350042812126276	\N	139494946	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-28T23:00:00.000Z	defillama-api	2.9103845477607138	\N	138720924	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-29T23:00:00.000Z	defillama-api	2.933324405773874	\N	143624150	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-30T23:00:00.000Z	defillama-api	2.908665458889459	\N	141099934	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-07-31T23:00:00.000Z	defillama-api	3.23579861785106	\N	139524571	\N	\N
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
