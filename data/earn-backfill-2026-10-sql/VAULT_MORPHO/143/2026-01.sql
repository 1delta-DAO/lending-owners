-- Generated from VAULT_MORPHO/143/2026-01.ndjson (132 vault rows)
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
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-01T00:00:00.000Z	morpho-api	13.541205619205243	\N	8623683.49983458	1.002445662310618	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-02T00:00:00.000Z	morpho-api	8.405218594731423	\N	8828391.89732103	1.00254738659823	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-03T00:00:00.000Z	morpho-api	8.728974496818864	\N	9527247.557171613	1.002644968211128	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-04T00:00:00.000Z	morpho-api	7.826350604389631	\N	10356578.739410406	1.002717685265009	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-05T00:00:00.000Z	morpho-api	7.884973285499086	\N	9833265.244927468	1.002789611535697	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-06T00:00:00.000Z	morpho-api	7.567285662091194	\N	10379720.084229974	1.002861750058019	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-07T00:00:00.000Z	morpho-api	7.426050082059987	\N	10740694.68043952	1.002929743865143	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-08T00:00:00.000Z	morpho-api	7.320556145273827	\N	10588681.74132531	1.003003786779502	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-09T00:00:00.000Z	morpho-api	7.622789474837077	\N	10497416.378936358	1.003080858712164	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-10T00:00:00.000Z	morpho-api	7.315665670049043	\N	10407009.402798407	1.003155949535031	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-11T00:00:00.000Z	morpho-api	7.930491677754503	\N	10296033.369296195	1.003259444724644	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-12T00:00:00.000Z	morpho-api	6.951454109938027	\N	10553039.76516746	1.003336730167585	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-13T00:00:00.000Z	morpho-api	10.10596818389331	\N	10546235.3563316	1.00348277122471	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-14T00:00:00.000Z	morpho-api	7.9473240436556125	\N	11555420.52436838	1.003573174966924	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-15T00:00:00.000Z	morpho-api	7.83731916165209	\N	13257052.201838221	1.003675667456104	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-16T00:00:00.000Z	morpho-api	7.171873514266736	\N	11426394.356145382	1.003764668513198	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-17T00:00:00.000Z	morpho-api	6.814274319211222	\N	12684612.892453192	1.003844694515084	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-18T00:00:00.000Z	morpho-api	7.176794099805761	\N	12941048.7042749	1.003938409787343	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-19T00:00:00.000Z	morpho-api	7.472918536777229	\N	12716293.037090925	1.004036341725807	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-20T00:00:00.000Z	morpho-api	7.097136213118915	\N	12587203.524983207	1.004135048565124	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-21T00:00:00.000Z	morpho-api	6.888784042402563	\N	11709507.845991848	1.004234760816322	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-22T00:00:00.000Z	morpho-api	7.979116334055902	\N	11818205.15322554	1.004361638525494	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-23T00:00:00.000Z	morpho-api	7.802492031672159	\N	11739349.773923654	1.004486234356136	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-24T00:00:00.000Z	morpho-api	6.997485077775423	\N	11524484.342947818	1.004585930756817	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-25T00:00:00.000Z	morpho-api	6.6856745675636375	\N	11283379.441579446	1.004677211827568	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-26T00:00:00.000Z	morpho-api	6.203254815417836	\N	11164292.550964065	1.004760948600117	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-27T00:00:00.000Z	morpho-api	6.501787377288792	\N	12176062.800864663	1.004846885233349	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-28T00:00:00.000Z	morpho-api	7.376231516786902	\N	11475376.54126237	1.004942957450578	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-29T00:00:00.000Z	morpho-api	7.883345928050289	\N	11518124.180762345	1.005056958707694	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-30T00:00:00.000Z	morpho-api	7.467752167045205	\N	11323652.399860587	1.005164357441176	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-01-31T00:00:00.000Z	morpho-api	6.9755955795614	\N	10909643.982776493	1.005260135948791	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-01T00:00:00.000Z	morpho-api	0.890214241522358	\N	1.2291072076259917	1.001300480615451	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-02T00:00:00.000Z	morpho-api	0.8308787162292219	\N	1.2292388444597222	1.001323257984863	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-03T00:00:00.000Z	morpho-api	0.8308507066345783	\N	1.2299253630747975	1.001346035354274	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-04T00:00:00.000Z	morpho-api	0.8308233972798007	\N	1.2302956068714415	1.001368812723685	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-05T00:00:00.000Z	morpho-api	0.801143030315643	\N	1.2304734935586104	1.001390776615617	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-06T00:00:00.000Z	morpho-api	0.41512039885560625	\N	1.2305145366685717	1.001402165300323	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-07T00:00:00.000Z	morpho-api	0.14826458780703433	\N	1.230118256863126	1.001406232687718	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-08T00:00:00.000Z	morpho-api	0.14826388756716824	\N	1.2300583656619113	1.001410300075113	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-09T00:00:00.000Z	morpho-api	0.17791344397721787	\N	1.2299006569337907	1.001415180939987	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-10T00:00:00.000Z	morpho-api	0.14826248708743606	\N	1.2290911475877797	1.001419248327381	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-11T00:00:00.000Z	morpho-api	0.14826248708743606	\N	1.2293322737321266	1.001423315714776	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-12T00:00:00.000Z	morpho-api	0.14826178684756997	\N	1.2291820460291167	1.001427383102171	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-13T00:00:00.000Z	morpho-api	0.1779106430177535	\N	1.2299530402954486	1.001432263967045	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-14T00:00:00.000Z	morpho-api	0.14826038636783778	\N	1.2303133241143447	1.00143633135444	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-15T00:00:00.000Z	morpho-api	0.1482596861279717	\N	1.23072024529431	1.001440398741835	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-16T00:00:00.000Z	morpho-api	0.17790784205828913	\N	1.230580657332025	1.001445279606709	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-17T00:00:00.000Z	morpho-api	0.1482582856482395	\N	1.2305213568341455	1.001449346994103	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-18T00:00:00.000Z	morpho-api	0.14825758540837342	\N	1.230624921917073	1.001453414381498	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-19T00:00:00.000Z	morpho-api	0.11860872923818988	\N	1.2308260657749233	1.001456668291414	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-20T00:00:00.000Z	morpho-api	0.17790504109882477	\N	1.2301416358196546	1.001461549156288	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-21T00:00:00.000Z	morpho-api	0.14825618492864123	\N	1.2286048099349884	1.001465616543683	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-22T00:00:00.000Z	morpho-api	0.14826528804690042	\N	1.2299112828789132	1.001469683931078	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-23T00:00:00.000Z	morpho-api	0.23720975583785275	\N	1.2301677667077795	1.00147619175091	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-24T00:00:00.000Z	morpho-api	0.20756089966766922	\N	1.2295407575281307	1.001481886093262	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-25T00:00:00.000Z	morpho-api	0.20756019942780313	\N	1.2290691598889647	1.001487580435615	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-26T00:00:00.000Z	morpho-api	0.20755949918793704	\N	1.229475577269805	1.001493274777968	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-27T00:00:00.000Z	morpho-api	0.2372062546385223	\N	1.2299928693320836	1.0014997825978	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-28T00:00:00.000Z	morpho-api	0.20755809870820485	\N	1.2294594968666392	1.001505476940153	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-29T00:00:00.000Z	morpho-api	0.2668516096093754	\N	1.2294616699223624	1.001512798237463	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-30T00:00:00.000Z	morpho-api	0.20755599798860658	\N	1.229087243216438	1.001518492579816	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-01-31T00:00:00.000Z	morpho-api	0.23720205319932575	\N	1.2295074512546613	1.001525000399648	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-01T00:00:00.000Z	morpho-api	2.760335748774878	\N	24304308.85103399	1.001628237577587	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-02T00:00:00.000Z	morpho-api	2.5662516655700074	\N	24211438.804309193	1.001693553726389	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-03T00:00:00.000Z	morpho-api	2.4879221339091373	\N	24212300.281092066	1.001755813153193	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-04T00:00:00.000Z	morpho-api	2.567196289149365	\N	24212957.99812599	1.001819914355392	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-05T00:00:00.000Z	morpho-api	3.196312792042022	\N	24048839.67390943	1.001901331821033	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-06T00:00:00.000Z	morpho-api	3.780346451875971	\N	24058452.185987066	1.001999040486536	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-07T00:00:00.000Z	morpho-api	3.604191310202509	\N	23996649.007956404	1.002091737894014	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-08T00:00:00.000Z	morpho-api	2.831997596430824	\N	23950596.130438346	1.002163676534684	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-09T00:00:00.000Z	morpho-api	2.666768297387989	\N	23940367.755054787	1.002230888664604	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-10T00:00:00.000Z	morpho-api	2.8129629761508568	\N	23935552.0303179	1.002302408764264	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-11T00:00:00.000Z	morpho-api	3.142466447059178	\N	23936733.065308765	1.002383464855062	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-12T00:00:00.000Z	morpho-api	2.9742135122745594	\N	23814929.19618169	1.002459987501169	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-13T00:00:00.000Z	morpho-api	2.7106068142046524	\N	23817099.95935583	1.002534309189235	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-14T00:00:00.000Z	morpho-api	2.9545003595643493	\N	23824915.242915712	1.002615250233983	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-15T00:00:00.000Z	morpho-api	5.936984404897316	\N	21459759.688054927	1.002777763953626	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-16T00:00:00.000Z	morpho-api	3.7790208978094597	\N	24321217.60450513	1.002881518014326	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-17T00:00:00.000Z	morpho-api	3.972466362256455	\N	19569781.766912457	1.002990566404923	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-18T00:00:00.000Z	morpho-api	2.792940317419834	\N	19570144.145672042	1.003067196276148	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-19T00:00:00.000Z	morpho-api	6.210556916741439	\N	17535651.848203134	1.003237597645109	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-20T00:00:00.000Z	morpho-api	3.405433125891477	\N	17534667.287261963	1.0033310891969	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-21T00:00:00.000Z	morpho-api	5.602218631395317	\N	15517570.478335038	1.003484620620524	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-22T00:00:00.000Z	morpho-api	4.798855140464298	\N	15186203.459161097	1.003616454338902	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-23T00:00:00.000Z	morpho-api	9.034073908154028	\N	12694862.611505937	1.003864679082257	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-24T00:00:00.000Z	morpho-api	3.5503708740947104	\N	12636928.3119314	1.003962170771951	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-25T00:00:00.000Z	morpho-api	3.2537023507472895	\N	12639112.731201164	1.004051510981492	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-26T00:00:00.000Z	morpho-api	3.309782460902966	\N	12539608.453325892	1.004142360345204	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-27T00:00:00.000Z	morpho-api	9.827383355087704	\N	11534219.895847717	1.004412651714651	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-28T00:00:00.000Z	morpho-api	4.014559181086952	\N	9636275.870764708	1.004522940155709	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-29T00:00:00.000Z	morpho-api	5.568245093812152	\N	8648136.476396145	1.004676043924049	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-30T00:00:00.000Z	morpho-api	3.8932384228473893	\N	8389151.389091043	1.004783012268227	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-01-31T00:00:00.000Z	morpho-api	8.179770067684444	\N	8379072.092354944	1.00500800943907	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-10T00:00:00.000Z	morpho-api	\N	\N	0.009997742936757217	1	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-11T00:00:00.000Z	morpho-api	4.317055800839853	\N	0.010003281845152631	1	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-12T00:00:00.000Z	morpho-api	4.239313770426634	\N	0.009998229074237957	1	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-13T00:00:00.000Z	morpho-api	5.045447410267911	\N	0.00999873067040237	1	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-14T00:00:00.000Z	morpho-api	7.138666739336941	\N	499849.46090510127	1.000066866786085	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-15T00:00:00.000Z	morpho-api	7.519471883554729	\N	499895.2585516835	1.000159573786009	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-16T00:00:00.000Z	morpho-api	7.124765577515291	\N	499981.63779161545	1.000246923478168	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-17T00:00:00.000Z	morpho-api	6.70716632953372	\N	500832.5066139618	1.000323750646076	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-18T00:00:00.000Z	morpho-api	6.770331466654511	\N	504293.56334083894	1.000405603996512	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-19T00:00:00.000Z	morpho-api	7.439557709076894	\N	500114.412764119	1.000502231507839	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-20T00:00:00.000Z	morpho-api	7.112093336658631	\N	503096.21801588184	1.000601015597518	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-21T00:00:00.000Z	morpho-api	6.892871342500939	\N	950063.5112137625	1.000700492813193	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-22T00:00:00.000Z	morpho-api	7.9471713913648045	\N	950190.7335639375	1.000827078972157	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-23T00:00:00.000Z	morpho-api	7.810385135442743	\N	974008.3386827396	1.000951464453128	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-24T00:00:00.000Z	morpho-api	7.419199635450013	\N	1227261.6895919584	1.001062690427708	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-25T00:00:00.000Z	morpho-api	7.161329302363129	\N	2125338.9728034483	1.001167098850838	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-26T00:00:00.000Z	morpho-api	6.710063922099607	\N	2129307.1158490065	1.001264834278683	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-27T00:00:00.000Z	morpho-api	3.842723118907543	\N	1759208.6953863797	1.00137025307841	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-28T00:00:00.000Z	morpho-api	7.913827369421256	\N	1664982.5569916265	1.001479331088473	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-29T00:00:00.000Z	morpho-api	8.02154036634306	\N	1707516.6082129297	1.001596822689122	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-30T00:00:00.000Z	morpho-api	7.76845477226118	\N	1731048.1594365113	1.001712346679414	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-01-31T00:00:00.000Z	morpho-api	7.276825465396541	\N	2689346.6343114534	1.001816339842947	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-15T00:00:00.000Z	morpho-api	\N	\N	1.0068431020983726	1.00000129231798	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-16T00:00:00.000Z	morpho-api	0.4930977098638323	\N	0.9957306279185291	1.00001479822548	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-17T00:00:00.000Z	morpho-api	0.4505714425562246	\N	0.9872419986811243	1.00002713949581	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-18T00:00:00.000Z	morpho-api	0.41301617805800106	\N	0.9926417674004955	1.0000384522438532	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-19T00:00:00.000Z	morpho-api	0.37457440988930557	\N	0.9859913838052109	1.0000487121247232	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-20T00:00:00.000Z	morpho-api	0.34783645084246473	\N	0.9560522555757366	1.0000582397546067	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-21T00:00:00.000Z	morpho-api	0.32043606488230125	\N	0.8830914464372602	1.00006701692358	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-22T00:00:00.000Z	morpho-api	0.2963506144482153	\N	0.8942414369555823	1.0000751344214334	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-23T00:00:00.000Z	morpho-api	0.25270816479405767	\N	0.8838690059989074	1.0000820563830133	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-24T00:00:00.000Z	morpho-api	0.25043938762792095	\N	0.8854065340709686	1.0000889163841067	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-25T00:00:00.000Z	morpho-api	0.23244322306936738	\N	0.8842173373472416	1.00009528346346	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-26T00:00:00.000Z	morpho-api	0.216933610275305	\N	0.84432986368199	1.0001012257410167	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-27T00:00:00.000Z	morpho-api	0.1935841119404813	\N	0.8783088222384284	1.00010652996532	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-28T00:00:00.000Z	morpho-api	0.18621898902893008	\N	0.9055909923709344	1.0001116309278932	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-29T00:00:00.000Z	morpho-api	11.749730852272933	\N	5726476.148836843	1.000113370329387	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-30T00:00:00.000Z	morpho-api	6.606650397955605	\N	9773122.943785345	1.0001133703299336	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-01-31T00:00:00.000Z	morpho-api	4.450193807059577	\N	14890943.457866164	1.0001133750508908	assets_per_share
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
