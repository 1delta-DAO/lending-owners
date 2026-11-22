-- Generated from VAULT_LLAMA_LST/1/2024-12.ndjson (62 vault rows)
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
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-01T23:00:00.000Z	defillama-api	2.739811718299734	\N	409275570	1.06519	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-02T23:00:00.000Z	defillama-api	2.73952041851544	\N	398656824	1.0653	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-03T23:00:00.000Z	defillama-api	2.740093914965769	\N	399831888	1.0653	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-04T23:00:00.000Z	defillama-api	2.740385914989929	\N	423227324	1.06542	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-05T23:00:00.000Z	defillama-api	2.7406877183722145	\N	420416246	1.06553	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-06T23:00:00.000Z	defillama-api	3.279917930854026	\N	439465346	1.06564	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-07T23:00:00.000Z	defillama-api	3.280604866162662	\N	436203761	1.06576	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-08T23:00:00.000Z	defillama-api	3.28094378225785	\N	432795360	1.06587	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-09T23:00:00.000Z	defillama-api	3.2805950628045366	\N	401317074	1.06598	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-10T23:00:00.000Z	defillama-api	3.2812918014712977	\N	393885416	1.06598	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-11T23:00:00.000Z	defillama-api	3.2816405209246113	\N	415323471	1.0661	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-12T23:00:00.000Z	defillama-api	3.2819787367799336	\N	419706581	1.06621	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-13T23:00:00.000Z	defillama-api	2.7424096082029337	\N	421697426	1.06633	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-14T23:00:00.000Z	defillama-api	2.7426918048689686	\N	417554702	1.06633	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-15T23:00:00.000Z	defillama-api	2.742993608251254	\N	417566361	1.06644	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-16T23:00:00.000Z	defillama-api	2.742701608227094	\N	427368155	1.06655	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-17T23:00:00.000Z	defillama-api	2.743275804917289	\N	408687076	1.06655	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-18T23:00:00.000Z	defillama-api	2.743567804941449	\N	386975533	1.06667	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-19T23:00:00.000Z	defillama-api	2.743850001607484	\N	363115702	1.06678	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-20T23:00:00.000Z	defillama-api	2.743558001583324	\N	365010147	1.06689	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-21T23:00:00.000Z	defillama-api	2.7441420016316442	\N	349249635	1.06689	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-22T23:00:00.000Z	defillama-api	2.7444333014159383	\N	344665949	1.06701	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-23T23:00:00.000Z	defillama-api	3.2843882621591547	\N	363598461	1.06712	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-24T23:00:00.000Z	defillama-api	3.285085000825916	\N	367343228	1.06724	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-25T23:00:00.000Z	defillama-api	2.7450074981061334	\N	365197268	1.06735	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-26T23:00:00.000Z	defillama-api	2.7452994981302936	\N	351280548	1.06735	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-27T23:00:00.000Z	defillama-api	3.285423916921104	\N	349148114	1.06746	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-28T23:00:00.000Z	defillama-api	2.7455816947963285	\N	358474801	1.06758	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-29T23:00:00.000Z	defillama-api	2.7458736948204887	\N	350648862	1.06758	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-30T23:00:00.000Z	defillama-api	2.746164994604783	\N	353500805	1.06769	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2024-12-31T23:00:00.000Z	defillama-api	2.746456994628943	\N	350609418	1.06781	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-01T23:00:00.000Z	defillama-api	3.060048915060065	\N	131337394	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-02T23:00:00.000Z	defillama-api	2.885214425774052	\N	127377432	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-03T23:00:00.000Z	defillama-api	2.861456687597297	\N	127815076	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-04T23:00:00.000Z	defillama-api	2.85285634156196	\N	131142642	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-05T23:00:00.000Z	defillama-api	2.848978413183545	\N	129498447	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-06T23:00:00.000Z	defillama-api	2.8450129548218683	\N	137238684	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-07T23:00:00.000Z	defillama-api	2.837013414591638	\N	115647100	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-08T23:00:00.000Z	defillama-api	3.1886479664677836	\N	116373851	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-09T23:00:00.000Z	defillama-api	3.641138766496965	\N	107884935	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-10T23:00:00.000Z	defillama-api	3.380559905608038	\N	105785795	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-11T23:00:00.000Z	defillama-api	3.053502372551975	\N	111280483	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-12T23:00:00.000Z	defillama-api	3.0727827770249405	\N	112806875	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-13T23:00:00.000Z	defillama-api	3.0349558194586734	\N	113362494	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-14T23:00:00.000Z	defillama-api	2.988370261647333	\N	112060761	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-15T23:00:00.000Z	defillama-api	2.9792461361921596	\N	112617205	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-16T23:00:00.000Z	defillama-api	2.9735097712091374	\N	116900754	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-17T23:00:00.000Z	defillama-api	3.2287696100752328	\N	113949374	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-18T23:00:00.000Z	defillama-api	3.635256751621796	\N	106775304	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-19T23:00:00.000Z	defillama-api	3.348090483257238	\N	99065908	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-20T23:00:00.000Z	defillama-api	3.0148141199504153	\N	99341566	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-21T23:00:00.000Z	defillama-api	2.977528447800637	\N	95877380	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-22T23:00:00.000Z	defillama-api	2.9508318029058955	\N	93958754	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-23T23:00:00.000Z	defillama-api	2.9368396099016536	\N	98756946	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-24T23:00:00.000Z	defillama-api	2.9397820178189704	\N	100735507	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-25T23:00:00.000Z	defillama-api	2.92289433296844	\N	99996729	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-26T23:00:00.000Z	defillama-api	2.9190773254583746	\N	100267034	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-27T23:00:00.000Z	defillama-api	3.3248299153854077	\N	99635636	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-28T23:00:00.000Z	defillama-api	3.650587803250005	\N	100885905	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-29T23:00:00.000Z	defillama-api	3.204357847863548	\N	99212620	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-30T23:00:00.000Z	defillama-api	2.9188833590154672	\N	98504730	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2024-12-31T23:00:00.000Z	defillama-api	2.9330912258984654	\N	99415603	\N	\N
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
