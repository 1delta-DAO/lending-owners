-- Generated from VAULT_MORPHO/999/2026-05.ndjson (58 vault rows)
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
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-01T00:00:00.000Z	morpho-api	10.7649163055612	\N	1512009.4399522906	1.000727996159258	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-02T00:00:00.000Z	morpho-api	18.27426902281104	\N	2143561.4550007433	1.000971268817655	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-03T00:00:00.000Z	morpho-api	15.146905349183726	\N	2231396.5005797003	1.001134743951684	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-04T00:00:00.000Z	morpho-api	17.124987738270647	\N	2421593.1219022707	1.001375350131404	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-05T00:00:00.000Z	morpho-api	15.197225986440799	\N	2587993.7758309976	1.001584802011199	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-06T00:00:00.000Z	morpho-api	18.31172625372801	\N	2628668.163464339	1.001890363243361	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-07T00:00:00.000Z	morpho-api	15.777445439724147	\N	2485327.442579569	1.002106489248443	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-08T00:00:00.000Z	morpho-api	13.843040512284688	\N	2950397.9953332455	1.002308122704203	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-09T00:00:00.000Z	morpho-api	14.650836521568067	\N	2974635.715205973	1.002535252856325	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-10T00:00:00.000Z	morpho-api	16.72552470282085	\N	2785052.275166253	1.002808385705439	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-11T00:00:00.000Z	morpho-api	16.739168176371777	\N	2843057.4076244948	1.003086838061044	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-12T00:00:00.000Z	morpho-api	18.8821150395313	\N	2938787.11075646	1.003424625826866	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-13T00:00:00.000Z	morpho-api	13.531615834239119	\N	2990023.508151949	1.003620281528172	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-14T00:00:00.000Z	morpho-api	13.1665968975625	\N	3128936.162972226	1.003814905853385	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-15T00:00:00.000Z	morpho-api	11.138039118208098	\N	3631949.34358279	1.003978474430261	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-16T00:00:00.000Z	morpho-api	11.059531025381375	\N	4059997.133123963	1.004157376363656	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-17T00:00:00.000Z	morpho-api	13.317163874049243	\N	4137925.8981128256	1.004403966415302	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-18T00:00:00.000Z	morpho-api	14.606168920749951	\N	4342590.472428732	1.004694079949066	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-19T00:00:00.000Z	morpho-api	15.143245895643531	\N	4035149.883238534	1.004991452103081	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-20T00:00:00.000Z	morpho-api	9.893692569207246	\N	4374374.554819406	1.005206290206496	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-21T00:00:00.000Z	morpho-api	13.38779356814257	\N	4149116.411842564	1.005515944254841	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-22T00:00:00.000Z	morpho-api	10.721479026187808	\N	4695126.381168089	1.005755934868014	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-23T00:00:00.000Z	morpho-api	11.498527502951106	\N	5388783.452784665	1.00602604044318	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-24T00:00:00.000Z	morpho-api	12.580719506161131	\N	5135115.016506421	1.006323870222955	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-25T00:00:00.000Z	morpho-api	9.868473430429958	\N	5785792.6434245575	1.006552137802677	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-26T00:00:00.000Z	morpho-api	8.653104907807574	\N	5934442.025780705	1.006747671396906	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-27T00:00:00.000Z	morpho-api	10.63026928243005	\N	5812563.121794298	1.006997605824077	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-28T00:00:00.000Z	morpho-api	10.60097614811184	\N	5899406.988594588	1.007247740290208	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-29T00:00:00.000Z	morpho-api	12.509868536270119	\N	5705459.983783624	1.007549576257498	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-30T00:00:00.000Z	morpho-api	10.926961613932917	\N	6515774.5439148955	1.00781311888294	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-05-31T00:00:00.000Z	morpho-api	9.684600244952435	\N	6482281.399263074	1.008041900146041	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-05T00:00:00.000Z	morpho-api	\N	\N	0.9999125234137785	1.000116999883	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-06T00:00:00.000Z	morpho-api	7.188943961722316	\N	1.0001248277303905	1.000313999686	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-07T00:00:00.000Z	morpho-api	8.756191419934112	\N	1.0003717592870736	1.000553999446	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-08T00:00:00.000Z	morpho-api	6.711657668034832	\N	1.0005335155269623	1.000737999262	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-09T00:00:00.000Z	morpho-api	5.652884486906373	\N	1.0008453090130969	1.000892999107	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-10T00:00:00.000Z	morpho-api	5.287390087360677	\N	1.0009971349895155	1.001037998962001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-11T00:00:00.000Z	morpho-api	5.395994489632017	\N	1.0012160122346045	1.001185998814001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-12T00:00:00.000Z	morpho-api	6.342919057189533	\N	1.0013670771595444	1.001359998640001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-13T00:00:00.000Z	morpho-api	5.758707536429597	\N	1.0015184995760191	1.001517998482001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-14T00:00:00.000Z	morpho-api	5.3934085038065405	\N	1.0016140688804622	1.001665998334001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-15T00:00:00.000Z	morpho-api	5.356177450366317	\N	1.0016804881005372	1.001812998187001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-16T00:00:00.000Z	morpho-api	5.391820359790245	\N	1.0020594189305987	1.001960998039001	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-17T00:00:00.000Z	morpho-api	4.589706096780333	\N	1.0021996301912086	1.002086997913002	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-18T00:00:00.000Z	morpho-api	4.734806300632499	\N	1.0024490070375527	1.002216997783002	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-19T00:00:00.000Z	morpho-api	5.15335507387249	\N	2.002093174849449	1.002358508594453	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-20T00:00:00.000Z	morpho-api	5.322089773684979	\N	2.063357409787627	1.002504673820748	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-21T00:00:00.000Z	morpho-api	5.298920236995741	\N	3.0733017246766385	1.002650223891582	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-22T00:00:00.000Z	morpho-api	5.670920565137294	\N	5049.002507825635	1.002806015435516	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-23T00:00:00.000Z	morpho-api	4.19369804482983	\N	5050.7370484829935	1.002921240294408	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-24T00:00:00.000Z	morpho-api	3.6048271280009203	\N	5051.303107212788	1.003020296083804	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-25T00:00:00.000Z	morpho-api	3.6605928304567215	\N	5051.672357802467	1.003120894251534	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-26T00:00:00.000Z	morpho-api	3.4595392598646413	\N	5120.434617864618	1.003215976459402	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-27T00:00:00.000Z	morpho-api	3.8544640407423003	\N	5120.534830712685	1.003321923414851	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-28T00:00:00.000Z	morpho-api	4.319900175175917	\N	5121.288399881917	1.003440677025163	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-29T00:00:00.000Z	morpho-api	4.530676576308679	\N	5121.620629576591	1.003565239963091	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-30T00:00:00.000Z	morpho-api	4.4839250616490745	\N	5054.783931481792	1.003688532768715	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-05-31T00:00:00.000Z	morpho-api	3.8162253421347714	\N	5054.715587989046	1.003793478016048	assets_per_share
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
