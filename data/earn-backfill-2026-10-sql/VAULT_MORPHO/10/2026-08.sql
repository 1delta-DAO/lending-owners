-- Generated from VAULT_MORPHO/10/2026-08.ndjson (62 vault rows)
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
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-01T00:00:00.000Z	morpho-api	0.0028716836908415644	\N	2465.515987582119	1.011739246473583	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-02T00:00:00.000Z	morpho-api	0.0029010937652174107	\N	2465.4484281938016	1.011739326894059	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-03T00:00:00.000Z	morpho-api	0.0029010937652174107	\N	2465.2344841382733	1.011739407314535	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-04T00:00:00.000Z	morpho-api	0.009222159036426092	\N	448.157829013592	1.011739662942144	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-05T00:00:00.000Z	morpho-api	0.022636654151142466	\N	448.1852100050044	1.011740290408801	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-06T00:00:00.000Z	morpho-api	0.01661109010342443	\N	448.0679803736688	1.01174075085196	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-07T00:00:00.000Z	morpho-api	0.016692317927891054	\N	448.08714071081863	1.011741213552192	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-08T00:00:00.000Z	morpho-api	0.016936701641157015	\N	448.1173065972734	1.011741683023648	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-09T00:00:00.000Z	morpho-api	0.017725871970242224	\N	422.95611199358103	1.011742174363119	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-10T00:00:00.000Z	morpho-api	0.018116605815521325	\N	422.94582364948866	1.011742676533049	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-11T00:00:00.000Z	morpho-api	0.018461824069504473	\N	422.948414920355	1.01174318826812	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-12T00:00:00.000Z	morpho-api	0.018720212580092266	\N	422.93683506922895	1.011743707177048	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-13T00:00:00.000Z	morpho-api	0.018720212580092266	\N	422.9044464514518	1.011744226085975	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-14T00:00:00.000Z	morpho-api	0.018893171827016886	\N	422.9139197645942	1.011744749777474	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-15T00:00:00.000Z	morpho-api	0.019410649088058562	\N	422.94217870593815	1.011745287816684	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-16T00:00:00.000Z	morpho-api	0.019496778591587827	\N	422.9460716422243	1.01174582824718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-17T00:00:00.000Z	morpho-api	0.019841996845570975	\N	422.90541510747676	1.011746378242817	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-18T00:00:00.000Z	morpho-api	0.020014255852629503	\N	422.9576137131186	1.011746933021026	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-19T00:00:00.000Z	morpho-api	0.02018651485968803	\N	422.99552376632255	1.011747492581804	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-20T00:00:00.000Z	morpho-api	0.020445603610141916	\N	422.9613056264014	1.01174805931644	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-21T00:00:00.000Z	morpho-api	0.0207046923605958	\N	423.01130284326183	1.011748633224931	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-22T00:00:00.000Z	morpho-api	0.020963080871183593	\N	423.0632509676355	1.011749214307278	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-23T00:00:00.000Z	morpho-api	0.021136040118108212	\N	423.04886659888854	1.011749800172196	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-24T00:00:00.000Z	morpho-api	0.02130829912516674	\N	423.05579849000475	1.011750390819685	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-25T00:00:00.000Z	morpho-api	0.021739646882679153	\N	423.065363609697	1.011750993423601	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-26T00:00:00.000Z	morpho-api	0.021825776386208418	\N	423.04339438324115	1.011751598418802	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-27T00:00:00.000Z	morpho-api	0.0220848651366623	\N	423.0904766220507	1.011752210587859	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-28T00:00:00.000Z	morpho-api	0.02242938315077936	\N	423.1138682998573	1.011752832322058	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-29T00:00:00.000Z	morpho-api	0.02260234239770398	\N	423.08182932898876	1.011753458838828	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-30T00:00:00.000Z	morpho-api	0.02286073090829177	\N	423.0831850655401	1.011754092529453	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-08-31T00:00:00.000Z	morpho-api	0.023119819658745655	\N	423.05364027964737	1.011754733393935	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-01T00:00:00.000Z	morpho-api	0.7418586225327317	\N	116351.06363477255	1.0031351619296924	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-02T00:00:00.000Z	morpho-api	0.741692665684468	\N	115232.49019518332	1.0031555461983444	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-03T00:00:00.000Z	morpho-api	0.7415057016402216	\N	117166.87748896926	1.0031759257322288	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-04T00:00:00.000Z	morpho-api	0.7413222387953056	\N	115824.64410967249	1.0031963006441433	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-05T00:00:00.000Z	morpho-api	0.7411562819470419	\N	116886.32476865475	1.003216671407852	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-06T00:00:00.000Z	morpho-api	0.7409917255785103	\N	119314.93696546025	1.003237038062004	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-07T00:00:00.000Z	morpho-api	0.7408271692099788	\N	118998.8726029893	1.0032574005971113	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-08T00:00:00.000Z	morpho-api	0.7406619126015812	\N	119592.83166004122	1.003277759013127	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-09T00:00:00.000Z	morpho-api	0.7404973562330497	\N	120102.64783004468	1.0032981133100876	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-10T00:00:00.000Z	morpho-api	0.7403320996246521	\N	119534.31597239403	1.003318463489663	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-11T00:00:00.000Z	morpho-api	0.7401675432561206	\N	117375.1291899105	1.0033388095525726	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-12T00:00:00.000Z	morpho-api	0.740002986887589	\N	116114.52152656559	1.0033591514997406	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-13T00:00:00.000Z	morpho-api	0.7398384305190575	\N	117227.14607282555	1.0033794893315364	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-14T00:00:00.000Z	morpho-api	0.7397670060527162	\N	118061.17228437062	1.003399825617844	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-15T00:00:00.000Z	morpho-api	0.7396332602382927	\N	117642.13305233045	1.0034201586424427	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-16T00:00:00.000Z	morpho-api	0.7394785072278864	\N	117631.06053999797	1.0034404878253596	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-17T00:00:00.000Z	morpho-api	0.7393237542174802	\N	117249.96699184604	1.0034608131673861	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-18T00:00:00.000Z	morpho-api	0.7392649340687285	\N	119562.73315285846	1.0034811372921235	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-19T00:00:00.000Z	morpho-api	0.7393174520586854	\N	119957.55435903862	1.0035014632741404	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-20T00:00:00.000Z	morpho-api	0.7391577973692165	\N	140801.57879707878	1.0035217852788885	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-21T00:00:00.000Z	morpho-api	0.73897083332497	\N	145600.546684736	1.0035421025649238	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-22T00:00:00.000Z	morpho-api	0.7388083776760368	\N	157420.46651251317	1.0035624157864205	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-23T00:00:00.000Z	morpho-api	1.060551790388331	\N	151662.31007233678	1.00359157592653	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-24T00:00:00.000Z	morpho-api	1.347715958033291	\N	154127.03740130438	1.0036286329586925	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-25T00:00:00.000Z	morpho-api	1.1580924027754236	\N	157779.91791983196	1.0036604771455353	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-26T00:00:00.000Z	morpho-api	1.0315744642497293	\N	155173.30797892183	1.0036888433111069	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-27T00:00:00.000Z	morpho-api	1.0447102638977412	\N	159345.02442769267	1.0037175715034286	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-28T00:00:00.000Z	morpho-api	1.058028826150803	\N	159803.56069961892	1.0037466667706263	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-29T00:00:00.000Z	morpho-api	1.0715294507690487	\N	155141.18979659776	1.0037761341630944	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-30T00:00:00.000Z	morpho-api	1.0852128379923442	\N	156340.43856909804	1.0038059787313098	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-08-31T00:00:00.000Z	morpho-api	1.0990782875808236	\N	152823.2090862265	1.0038362055278343	assets_per_share
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
