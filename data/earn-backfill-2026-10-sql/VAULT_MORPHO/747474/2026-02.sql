-- Generated from VAULT_MORPHO/747474/2026-02.ndjson (56 vault rows)
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
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-01T00:00:00.000Z	morpho-api	-0.5939357517803501	\N	10.972726416352504	0.999493129595227	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-02T00:00:00.000Z	morpho-api	-0.47781007310732093	\N	11.027513469488344	0.999480045631977	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-03T00:00:00.000Z	morpho-api	-0.5574529046370458	\N	10.986298787746895	0.999464781008186	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-04T00:00:00.000Z	morpho-api	4.260847546788682	\N	11.009215859897548	0.999455149757461	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-05T00:00:00.000Z	morpho-api	-0.5408754260471937	\N	11.007590494169598	0.999440339437949	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-06T00:00:00.000Z	morpho-api	5.700688462084713	\N	10.989570238551021	0.999434524343171	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-07T00:00:00.000Z	morpho-api	7.47460961605384	\N	10.995819039662013	0.999449788966962	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-08T00:00:00.000Z	morpho-api	8.340628469483136	\N	11.012073359607566	0.999491130656397	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-09T00:00:00.000Z	morpho-api	8.67739272756296	\N	11.040610450859798	0.999542557900837	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-10T00:00:00.000Z	morpho-api	2.0703354902451565	\N	11.004292390561444	0.99959925507492	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-11T00:00:00.000Z	morpho-api	8.98660814883101	\N	11.008866295080368	0.999659132378958	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-12T00:00:00.000Z	morpho-api	8.170194287515642	\N	10.989843705855101	0.999725642525478	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-13T00:00:00.000Z	morpho-api	8.237286369805474	\N	11.013184606231157	0.999789790289744	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-14T00:00:00.000Z	morpho-api	7.357972062038698	\N	11.011393667708443	0.999822136754445	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-15T00:00:00.000Z	morpho-api	0.7927569576793303	\N	11.032052622215168	0.999843852499005	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-16T00:00:00.000Z	morpho-api	7.126992340289462	\N	11.017167174945863	0.999863660165592	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-17T00:00:00.000Z	morpho-api	7.360511832033012	\N	11.0179896606292	0.999893735108895	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-18T00:00:00.000Z	morpho-api	8.657440793058413	\N	11.010754120193063	0.999941527919099	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-19T00:00:00.000Z	morpho-api	2.7294719764370257	\N	11.019360124680606	1.000016306403506	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-20T00:00:00.000Z	morpho-api	7.881871923132167	\N	7.022564710745345	1.000031227792635	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-21T00:00:00.000Z	morpho-api	8.275258277024022	\N	7.02549855902128	1.000037070261834	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-22T00:00:00.000Z	morpho-api	8.459675548877499	\N	7.032089464145951	1.000044907720514	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-23T00:00:00.000Z	morpho-api	8.560514291033883	\N	7.006550430239033	1.000053600174687	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-24T00:00:00.000Z	morpho-api	1.0869809436542255	\N	7.014559474265267	1.000083382517674	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-25T00:00:00.000Z	morpho-api	1.9710456786725672	\N	7.018540642547602	1.000137389732945	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-26T00:00:00.000Z	morpho-api	12.118131947502775	\N	7.0177336931660825	1.000238564199549	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-27T00:00:00.000Z	morpho-api	12.06214847044862	\N	99866.84386160933	1.000329544432291	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-02-28T00:00:00.000Z	morpho-api	12.069604624542762	\N	100071.90685898717	1.00042855068117	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-01T00:00:00.000Z	morpho-api	1.8130855696796289	\N	2833483.0253747106	1.000949737737266	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-02T00:00:00.000Z	morpho-api	1.823431613701132	\N	2847731.9010129534	1.000999691974478	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-03T00:00:00.000Z	morpho-api	1.9563217350082596	\N	2837206.452160174	1.001053344844468	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-04T00:00:00.000Z	morpho-api	9.134545024380714	\N	3403596.5921761165	1.001183287899085	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-05T00:00:00.000Z	morpho-api	8.984235035924826	\N	3403389.0234010066	1.001282608712239	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-06T00:00:00.000Z	morpho-api	10.347099282981276	\N	3048735.3364266264	1.001411554855437	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-07T00:00:00.000Z	morpho-api	11.451736074619134	\N	4879015.843223311	1.001543382227616	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-08T00:00:00.000Z	morpho-api	9.921679055935329	\N	4886320.056236934	1.001631101610232	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-09T00:00:00.000Z	morpho-api	9.864874897758114	\N	4901074.258026628	1.001717356163616	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-10T00:00:00.000Z	morpho-api	3.1633139883524564	\N	4944911.9294355195	1.001804174898842	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-11T00:00:00.000Z	morpho-api	10.519420611387886	\N	4352572.561025672	1.001909041591846	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-12T00:00:00.000Z	morpho-api	9.220632513518012	\N	3348984.6995958793	1.002006040176098	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-13T00:00:00.000Z	morpho-api	9.379179423518735	\N	3359840.605047832	1.002103397922675	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-14T00:00:00.000Z	morpho-api	10.259726153449833	\N	2099413.37804434	1.002220248763199	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-15T00:00:00.000Z	morpho-api	4.083055944548164	\N	2103484.1583433244	1.00233236794725	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-16T00:00:00.000Z	morpho-api	10.32289199081049	\N	2103384.467677064	1.002445452851237	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-17T00:00:00.000Z	morpho-api	10.231773278235323	\N	2103659.1801067814	1.002559238436906	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-18T00:00:00.000Z	morpho-api	10.585366401016927	\N	2087883.666546531	1.002663683293285	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-19T00:00:00.000Z	morpho-api	3.596221180046655	\N	2089507.8653488744	1.00276247720501	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-20T00:00:00.000Z	morpho-api	10.791374168661605	\N	1285108.5584489338	1.002863155055943	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-21T00:00:00.000Z	morpho-api	11.70142760607007	\N	1280623.3569469554	1.002970674663051	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-22T00:00:00.000Z	morpho-api	12.074443982257321	\N	1287179.8704515435	1.003085901000553	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-23T00:00:00.000Z	morpho-api	12.297345036671459	\N	1282642.0263265593	1.003205675201399	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-24T00:00:00.000Z	morpho-api	3.9967177695388045	\N	1683287.6982740494	1.003315531354684	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-25T00:00:00.000Z	morpho-api	3.7323366061770002	\N	2108259.8238730235	1.003418131433763	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-26T00:00:00.000Z	morpho-api	12.707732514272152	\N	1804734.1497396126	1.003536995674514	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-27T00:00:00.000Z	morpho-api	12.666734870592222	\N	1579045.1826782061	1.003646413948893	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-02-28T00:00:00.000Z	morpho-api	12.428759052340865	\N	1582261.2190954622	1.003756556588876	assets_per_share
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
