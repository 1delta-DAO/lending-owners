-- Generated from VAULT_MORPHO/10/2026-09.ndjson (60 vault rows)
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
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-01T00:00:00.000Z	morpho-api	0.023520356862150038	\N	421.5711180855557	1.011755385365665	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-02T00:00:00.000Z	morpho-api	0.03262137440174229	\N	138.06887160929122	1.011756289616017	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-03T00:00:00.000Z	morpho-api	0.07321217871947283	\N	138.07004703940365	1.011758319017994	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-04T00:00:00.000Z	morpho-api	0.07426954091727112	\N	138.08775394180785	1.011760377725414	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-05T00:00:00.000Z	morpho-api	0.07479822201617026	\N	138.09945216545324	1.011762451085557	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-06T00:00:00.000Z	morpho-api	0.07559089354458592	\N	138.10021943167584	1.011764546424782	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-07T00:00:00.000Z	morpho-api	0.07664755550251812	\N	138.0897398528948	1.011766671069451	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-08T00:00:00.000Z	morpho-api	0.07717623660141726	\N	138.0843034744159	1.011768810366842	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-09T00:00:00.000Z	morpho-api	0.06607533400426746	\N	138.09980059753016	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-10T00:00:00.000Z	morpho-api	0	\N	138.08371452217816	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-11T00:00:00.000Z	morpho-api	0	\N	138.08574896069848	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-12T00:00:00.000Z	morpho-api	0	\N	138.07905982596313	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-13T00:00:00.000Z	morpho-api	0	\N	138.0881278688985	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-14T00:00:00.000Z	morpho-api	0	\N	138.07831144685676	1.011770641957074	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-15T00:00:00.000Z	morpho-api	0.00012674341576257575	\N	136.56694436537876	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-16T00:00:00.000Z	morpho-api	0	\N	136.5433861849011	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-17T00:00:00.000Z	morpho-api	0	\N	136.5391602459231	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-18T00:00:00.000Z	morpho-api	0	\N	136.53058597599633	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-19T00:00:00.000Z	morpho-api	0	\N	136.55114796593847	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-20T00:00:00.000Z	morpho-api	0	\N	136.5421250188455	1.011770645461126	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-21T00:00:00.000Z	morpho-api	0.0002674916288469831	\N	136.55011155893192	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-22T00:00:00.000Z	morpho-api	0	\N	136.5647586188613	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-23T00:00:00.000Z	morpho-api	0	\N	136.5654357920209	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-24T00:00:00.000Z	morpho-api	0	\N	136.5633843479637	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-25T00:00:00.000Z	morpho-api	0	\N	136.55822795093027	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-26T00:00:00.000Z	morpho-api	0	\N	136.57172058489792	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-27T00:00:00.000Z	morpho-api	0	\N	136.56695142008004	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-28T00:00:00.000Z	morpho-api	0	\N	136.55938298624145	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-29T00:00:00.000Z	morpho-api	0	\N	136.56712166856713	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-09-30T00:00:00.000Z	morpho-api	0	\N	136.56501902722428	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-01T00:00:00.000Z	morpho-api	1.1131264997743529	\N	156862.46372138866	1.0038668196067824	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-02T00:00:00.000Z	morpho-api	1.127357474572932	\N	153841.4164088225	1.0038978260207905	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-03T00:00:00.000Z	morpho-api	1.0388527574178852	\N	152039.3818654712	1.003926399089051	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-04T00:00:00.000Z	morpho-api	18.439083079613283	\N	436212.43608393427	1.0039466583740746	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-05T00:00:00.000Z	morpho-api	8.245430859687986	\N	976266.3267367091	1.0039545334268578	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-06T00:00:00.000Z	morpho-api	7.565763340622311	\N	1235357.9002810088	1.0039681929050603	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-07T00:00:00.000Z	morpho-api	6.796169617473424	\N	1411153.8175791854	1.0039770289710133	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-08T00:00:00.000Z	morpho-api	6.565353751852854	\N	1542627.7888282798	1.0039986567285089	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-09T00:00:00.000Z	morpho-api	6.045417248401463	\N	1753974.126773852	1.0040302791912166	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-10T00:00:00.000Z	morpho-api	9.088612790364436	\N	1850350.2231827036	1.004046488751504	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-11T00:00:00.000Z	morpho-api	4.1282032096745525	\N	2080456.9882419417	1.0040590782394803	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-12T00:00:00.000Z	morpho-api	4.591483305560473	\N	2297441.2314457335	1.0040914866101143	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-13T00:00:00.000Z	morpho-api	4.502425398911214	\N	2307984.5158349317	1.0041217975658305	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-14T00:00:00.000Z	morpho-api	4.507633783035203	\N	2269445.6744567747	1.004151518028381	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-15T00:00:00.000Z	morpho-api	4.210606736876343	\N	2515931.214270386	1.0041748057041537	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-16T00:00:00.000Z	morpho-api	4.73926542809977	\N	2281667.147609747	1.0042124023925298	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-17T00:00:00.000Z	morpho-api	5.698927358821493	\N	2276358.519425497	1.0042753344071502	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-18T00:00:00.000Z	morpho-api	6.751221220469006	\N	2192373.249074964	1.004359323974453	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-19T00:00:00.000Z	morpho-api	6.663766863113096	\N	2424645.4274343173	1.004432303010952	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-20T00:00:00.000Z	morpho-api	4.8389053596054055	\N	2648123.1683638967	1.0044625961560418	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-21T00:00:00.000Z	morpho-api	4.97080884294121	\N	2600237.8296466195	1.0044896155829977	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-22T00:00:00.000Z	morpho-api	6.839718935225392	\N	2385674.9473725855	1.0045602638262452	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-23T00:00:00.000Z	morpho-api	6.538736934302847	\N	2700279.375034251	1.0046271779352174	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-24T00:00:00.000Z	morpho-api	4.853677619820473	\N	2675846.034556221	1.004656206109046	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-25T00:00:00.000Z	morpho-api	5.333801985685227	\N	2619530.075894456	1.004689940018451	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-26T00:00:00.000Z	morpho-api	6.127061015348545	\N	2623253.231157136	1.0047343613329116	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-27T00:00:00.000Z	morpho-api	5.222879089217258	\N	2962660.435182281	1.0047693621552838	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-28T00:00:00.000Z	morpho-api	4.911269547847041	\N	3056777.9483715966	1.0047946817887634	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-29T00:00:00.000Z	morpho-api	4.5111846993961535	\N	3060824.4945496316	1.0048198525906173	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-09-30T00:00:00.000Z	morpho-api	5.397210106039552	\N	2610091.285091755	1.0048575128749426	assets_per_share
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
