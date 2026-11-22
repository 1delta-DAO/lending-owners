-- Generated from VAULT_MORPHO/10/2026-06.ndjson (60 vault rows)
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
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-01T00:00:00.000Z	morpho-api	4.470481856699848	\N	54324.63248428342	1.006844276246062	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-02T00:00:00.000Z	morpho-api	4.632749141109116	\N	54332.26081576944	1.006913780856601	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-03T00:00:00.000Z	morpho-api	4.392786742357657	\N	54338.23831520634	1.006979598246089	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-04T00:00:00.000Z	morpho-api	4.253444610924362	\N	56350.489074267825	1.007038312721194	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-05T00:00:00.000Z	morpho-api	4.207196568728477	\N	56358.17659990334	1.00709787692466	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-06T00:00:00.000Z	morpho-api	4.023569867683818	\N	56360.06023479476	1.007156131300709	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-07T00:00:00.000Z	morpho-api	3.742588818056447	\N	56366.29333354219	1.007207409464761	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-08T00:00:00.000Z	morpho-api	3.8717550637556997	\N	64420.29082430736	1.007259294433709	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-09T00:00:00.000Z	morpho-api	3.7953427888481883	\N	64421.83013462525	1.007310357994394	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-10T00:00:00.000Z	morpho-api	3.7768494539847097	\N	64437.1141451843	1.007359223517254	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-11T00:00:00.000Z	morpho-api	3.8066607658038265	\N	64442.52674311456	1.007408572409617	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-12T00:00:00.000Z	morpho-api	1.8295706166071568	\N	64875.44017144185	1.007459070257633	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-13T00:00:00.000Z	morpho-api	0.00007002398660915787	\N	64589.633841513765	1.007459072181252	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-14T00:00:00.000Z	morpho-api	0.00006862350687697472	\N	64588.23124944895	1.007459074068315	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-15T00:00:00.000Z	morpho-api	0.00007002398660915787	\N	64580.22655968054	1.007459076002164	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-16T00:00:00.000Z	morpho-api	0.00007002398660915787	\N	64445.981872013064	1.007459077943627	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-17T00:00:00.000Z	morpho-api	0.10409625801344191	\N	56363.84647157427	1.007461951172628	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-18T00:00:00.000Z	morpho-api	4.441691494605493	\N	56369.61725082707	1.007584556864874	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-19T00:00:00.000Z	morpho-api	4.960882942839362	\N	56890.235271901336	1.00772151161695	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-20T00:00:00.000Z	morpho-api	4.863662340071073	\N	68856.94424650133	1.007855800487507	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-21T00:00:00.000Z	morpho-api	3.6192023522119143	\N	68875.5003495896	1.007955740615372	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-22T00:00:00.000Z	morpho-api	2.943473682393005	\N	68371.82715696421	1.008037028577223	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-23T00:00:00.000Z	morpho-api	3.0073005461872526	\N	68377.19988115029	1.008120085970155	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-24T00:00:00.000Z	morpho-api	5.216440383648546	\N	59733.689862922205	1.008264172926505	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-25T00:00:00.000Z	morpho-api	4.790682640987143	\N	59741.55186816543	1.008396517869192	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-26T00:00:00.000Z	morpho-api	6.151932835152252	\N	59745.9435720863	1.008566493490013	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-27T00:00:00.000Z	morpho-api	5.135854679139129	\N	59758.1294549137	1.008708417206953	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-28T00:00:00.000Z	morpho-api	4.92979509374436	\N	59769.638367129846	1.008844665475834	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-29T00:00:00.000Z	morpho-api	5.456874043829885	\N	59784.30709826147	1.008995502466066	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-06-30T00:00:00.000Z	morpho-api	6.389164998665819	\N	13470.595018860566	1.009172138162661	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-01T00:00:00.000Z	morpho-api	1.961355759405592	\N	124615.60204049731	1.001539082113908	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-02T00:00:00.000Z	morpho-api	1.605466550103074	\N	125017.47743431301	1.0015831361603562	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-03T00:00:00.000Z	morpho-api	1.6072493608021432	\N	116030.11562155667	1.001627241066607	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-04T00:00:00.000Z	morpho-api	1.6090342722208106	\N	113073.35787543288	1.0016713969005586	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-05T00:00:00.000Z	morpho-api	1.6108212843590763	\N	110469.5331995484	1.001715603729544	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-06T00:00:00.000Z	morpho-api	1.6126110974568064	\N	98715.96266144961	1.0017598616218695	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-07T00:00:00.000Z	morpho-api	1.6144023110342687	\N	97876.05538538432	1.001804170645528	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-08T00:00:00.000Z	morpho-api	1.6161963255711953	\N	105365.80803559873	1.001848530869054	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-09T00:00:00.000Z	morpho-api	1.6179924408277202	\N	105294.731182168	1.0018929423601086	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-10T00:00:00.000Z	morpho-api	1.6210903019953093	\N	102357.10572707138	1.001937440849002	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-11T00:00:00.000Z	morpho-api	1.6236174676720339	\N	101345.17329629208	1.0019820106956545	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-12T00:00:00.000Z	morpho-api	1.625514417469276	\N	103979.7086831661	1.0020266346019773	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-13T00:00:00.000Z	morpho-api	1.6274141682259824	\N	103839.3530380682	1.0020713126434204	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-14T00:00:00.000Z	morpho-api	1.6293160197022871	\N	104836.88960028697	1.0021160448965123	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-15T00:00:00.000Z	morpho-api	1.6312206721380562	\N	107612.935917233	1.0021608314358244	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-16T00:00:00.000Z	morpho-api	1.1663244226411962	\N	112111.10123072698	1.0021928550864496	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-17T00:00:00.000Z	morpho-api	0.749636886965277	\N	111665.04515068013	1.0022134383383092	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-18T00:00:00.000Z	morpho-api	0.7494639277183524	\N	109245.43263238722	1.0022340172579556	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-19T00:00:00.000Z	morpho-api	0.7492909684714277	\N	106753.1883381381	1.002254591846259	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-20T00:00:00.000Z	morpho-api	0.7491180092245031	\N	106564.20389239682	1.0022751621038104	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-21T00:00:00.000Z	morpho-api	0.7489450499775785	\N	108348.77895943895	1.0022957280320615	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-22T00:00:00.000Z	morpho-api	0.7487713904907878	\N	106384.97361028203	1.0023162896316733	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-23T00:00:00.000Z	morpho-api	0.7485984312438632	\N	107916.11752657914	1.0023368469035476	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-24T00:00:00.000Z	morpho-api	0.7484261722368046	\N	103539.58479579902	1.0023573998485864	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-25T00:00:00.000Z	morpho-api	0.74825321298988	\N	100845.31659140793	1.0023779484676916	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-26T00:00:00.000Z	morpho-api	0.7480802537429554	\N	97698.51326345322	1.0023984927624952	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-27T00:00:00.000Z	morpho-api	0.7479072944960308	\N	98580.9524162424	1.0024190327333098	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-28T00:00:00.000Z	morpho-api	0.7477210306916504	\N	98239.80889203677	1.0024395680039415	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-29T00:00:00.000Z	morpho-api	0.74753476688727	\N	98181.33570361741	1.0024600985750582	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-06-30T00:00:00.000Z	morpho-api	0.7473597069207472	\N	100318.18389850821	1.002480624765406	assets_per_share
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
