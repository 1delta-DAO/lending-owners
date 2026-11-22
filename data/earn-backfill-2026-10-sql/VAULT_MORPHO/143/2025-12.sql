-- Generated from VAULT_MORPHO/143/2025-12.ndjson (93 vault rows)
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
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-01T00:00:00.000Z	morpho-api	6.3652938216307575	\N	6188300.003927402	1.000002250652687	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-02T00:00:00.000Z	morpho-api	11.573799087116754	\N	4389503.270710337	1.000003326738043	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-03T00:00:00.000Z	morpho-api	8.207064017184962	\N	7053423.966141929	1.000010759129125	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-04T00:00:00.000Z	morpho-api	0.2706980271938164	\N	8629383.69772181	1.000018175621698	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-05T00:00:00.000Z	morpho-api	5.446219894267301	\N	10199697.040607989	1.000037504007671	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-06T00:00:00.000Z	morpho-api	5.620380752802134	\N	9963764.635943629	1.00006039880823	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-07T00:00:00.000Z	morpho-api	5.474086639978282	\N	10159248.46948027	1.000083923099989	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-08T00:00:00.000Z	morpho-api	6.695793733868527	\N	8874254.876677977	1.000130205165751	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-09T00:00:00.000Z	morpho-api	6.245107451974263	\N	8728156.929176701	1.000148850726754	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-10T00:00:00.000Z	morpho-api	7.240838738198363	\N	7185987.595501676	1.000166046543728	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-11T00:00:00.000Z	morpho-api	7.004874709082287	\N	6827075.459057038	1.00017866980424	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-12T00:00:00.000Z	morpho-api	8.907853571571422	\N	8249753.7132776305	1.000287128656494	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-13T00:00:00.000Z	morpho-api	11.646425165068308	\N	10015396.90135607	1.000508292461739	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-14T00:00:00.000Z	morpho-api	7.6274859836189535	\N	10019347.266023668	1.00061585777055	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-15T00:00:00.000Z	morpho-api	7.24081773100238	\N	9578400.266271705	1.000721177742067	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-16T00:00:00.000Z	morpho-api	7.357439879740468	\N	10593399.907124761	1.000829912597584	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-17T00:00:00.000Z	morpho-api	6.481634473942677	\N	9858215.953606855	1.000897846111114	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-18T00:00:00.000Z	morpho-api	7.003543553096847	\N	9708110.535834368	1.000983566349667	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-19T00:00:00.000Z	morpho-api	6.437632100997348	\N	9811569.081767853	1.001073059495308	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-20T00:00:00.000Z	morpho-api	7.994561524782284	\N	9659501.913498625	1.001195326161342	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-21T00:00:00.000Z	morpho-api	6.106442452491478	\N	9983674.546980025	1.001267986119108	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-22T00:00:00.000Z	morpho-api	6.52597996442239	\N	9663144.34419924	1.001342583554046	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-23T00:00:00.000Z	morpho-api	6.5911968043508296	\N	9477226.515106885	1.001421363609519	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-24T00:00:00.000Z	morpho-api	7.522833034911969	\N	8664348.179267436	1.001518856526831	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-25T00:00:00.000Z	morpho-api	7.5824031405602454	\N	8155809.542772257	1.001603196906506	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-26T00:00:00.000Z	morpho-api	8.483331052033805	\N	8401723.664300172	1.001702625152938	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-27T00:00:00.000Z	morpho-api	7.641089543497515	\N	8475656.876700794	1.001780414594106	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-28T00:00:00.000Z	morpho-api	7.374330365550463	\N	8273520.927296799	1.001854801423081	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-29T00:00:00.000Z	morpho-api	7.405808948490744	\N	8278377.984615218	1.001933782636131	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-30T00:00:00.000Z	morpho-api	9.484633446632529	\N	8026110.629896209	1.002062284693739	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2025-12-31T00:00:00.000Z	morpho-api	9.502131740646291	\N	8582483.821553204	1.002193416100057	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-01T00:00:00.000Z	morpho-api	2.169703728682748	\N	1.3797275219331995	1.000366756176698	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-02T00:00:00.000Z	morpho-api	1.0680702658305563	\N	1.2399508465972953	1.000396011386254	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-03T00:00:00.000Z	morpho-api	1.0094987022313262	\N	1.3804847902919055	1.000423664752423	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-04T00:00:00.000Z	morpho-api	0.9257199039325315	\N	1.3796420638183609	1.000449038000249	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-05T00:00:00.000Z	morpho-api	1.1117603317956082	\N	1.380325953118792	1.000479485897639	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-06T00:00:00.000Z	morpho-api	1.2703870691410657	\N	1.380106070299971	1.000514283494656	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-07T00:00:00.000Z	morpho-api	1.2438766880507046	\N	1.3805184808628927	1.000548356141736	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-08T00:00:00.000Z	morpho-api	1.2174524364638728	\N	1.3805216861182974	1.000581703838878	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-09T00:00:00.000Z	morpho-api	1.2967216900250378	\N	1.3807112641842245	1.000617226385833	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-10T00:00:00.000Z	morpho-api	1.3551805150058271	\N	1.1357589650577116	1.000654351981747	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-11T00:00:00.000Z	morpho-api	1.3042639736227102	\N	1.1568543494584347	1.000690083824736	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-12T00:00:00.000Z	morpho-api	1.26373759137266	\N	1.156154240532275	1.000724706304965	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-13T00:00:00.000Z	morpho-api	1.263675970264444	\N	1.1565161428327981	1.000759328785195	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-14T00:00:00.000Z	morpho-api	1.2579234997645017	\N	1.1665194175928377	1.000793795403922	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-15T00:00:00.000Z	morpho-api	1.1901290768889794	\N	1.1661553079134799	1.000826404725042	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-16T00:00:00.000Z	morpho-api	1.1587800383239255	\N	1.1660500106308502	1.000858155906132	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-17T00:00:00.000Z	morpho-api	1.1587268200941025	\N	1.1662779747761203	1.000889907087223	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-18T00:00:00.000Z	morpho-api	1.1586757025838779	\N	1.1662260168010201	1.000921658268313	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-19T00:00:00.000Z	morpho-api	1.0960406470417183	\N	1.165804315547971	1.000951693169344	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-20T00:00:00.000Z	morpho-api	1.1272846496268585	\N	1.1657852039259173	1.000982586210405	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-21T00:00:00.000Z	morpho-api	1.0646558962434938	\N	1.166094043169804	1.001011762971407	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-22T00:00:00.000Z	morpho-api	1.03332296319536	\N	1.1662831689909439	1.001040081592379	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-23T00:00:00.000Z	morpho-api	1.0645690665000984	\N	1.1661322335702924	1.001069258353381	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-24T00:00:00.000Z	morpho-api	1.033238234171563	\N	1.165859606281171	1.001097576974353	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-25T00:00:00.000Z	morpho-api	0.932781822982065	\N	1.2296693228294344	1.001123142525035	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-26T00:00:00.000Z	morpho-api	1.0090414455987684	\N	1.2298187440527466	1.00115080075932	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-27T00:00:00.000Z	morpho-api	0.9200325557401356	\N	1.2298235712384762	1.001176018561169	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-28T00:00:00.000Z	morpho-api	0.9496548027954077	\N	1.2298950343807202	1.001202049840496	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-29T00:00:00.000Z	morpho-api	0.9199646324731248	\N	1.2300729227825051	1.001227267642344	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-30T00:00:00.000Z	morpho-api	0.8902772631103062	\N	1.229275458478842	1.001251671966713	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2025-12-31T00:00:00.000Z	morpho-api	0.8902457523163321	\N	1.2295603128275123	1.001276076291082	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-01T00:00:00.000Z	morpho-api	11.143005919578286	\N	16973040.30215971	1.000045738383589	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-02T00:00:00.000Z	morpho-api	8.252525690011225	\N	15110158.621901127	1.000052224998868	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-03T00:00:00.000Z	morpho-api	11.124283606278595	\N	16140325.669920437	1.000059016713985	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-04T00:00:00.000Z	morpho-api	3.26837027522231	\N	20139516.12514144	1.000073782498411	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-05T00:00:00.000Z	morpho-api	3.764341069256716	\N	12593961.137250045	1.000098710937141	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-06T00:00:00.000Z	morpho-api	1.8690445383384713	\N	8074073.511309349	1.000108900674649	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-07T00:00:00.000Z	morpho-api	1.993333613370396	\N	7682954.710829918	1.000122676023213	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-08T00:00:00.000Z	morpho-api	2.3080424163879343	\N	5040200.971939397	1.00014373820036	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-09T00:00:00.000Z	morpho-api	2.8180089046259127	\N	3278847.671365598	1.000172183941532	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-10T00:00:00.000Z	morpho-api	2.9721870181020904	\N	1718706.881340777	1.000202892942026	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-11T00:00:00.000Z	morpho-api	2.838420896722482	\N	1700262.9198711282	1.00023005601985	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-12T00:00:00.000Z	morpho-api	2.9888499259556056	\N	1621491.7125097835	1.000263407991439	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-13T00:00:00.000Z	morpho-api	3.461500631729564	\N	1490692.9189385534	1.000313549060462	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-14T00:00:00.000Z	morpho-api	4.381859499247298	\N	1594627.7986765264	1.000391071197342	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-15T00:00:00.000Z	morpho-api	5.543996487489267	\N	1304385.5223156896	1.000504549049248	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-16T00:00:00.000Z	morpho-api	4.062660057968515	\N	1633707.0332871715	1.000600441357483	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-17T00:00:00.000Z	morpho-api	6.715207884155916	\N	12055319.147602273	1.000634415425437	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-18T00:00:00.000Z	morpho-api	7.546474533270953	\N	13259277.156583244	1.000705692454598	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-19T00:00:00.000Z	morpho-api	5.593163829686887	\N	22740134.03670681	1.000778493309436	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-20T00:00:00.000Z	morpho-api	5.155702277903629	\N	22618899.103274286	1.000837668142639	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-21T00:00:00.000Z	morpho-api	5.526444275005815	\N	20731540.27981086	1.00090026030217	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-22T00:00:00.000Z	morpho-api	5.63830129145515	\N	20762737.044630583	1.000965493009099	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-23T00:00:00.000Z	morpho-api	5.772420333727268	\N	20754445.38914804	1.001034911966889	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-24T00:00:00.000Z	morpho-api	2.3420229563697603	\N	24369656.168791614	1.001090636031655	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-25T00:00:00.000Z	morpho-api	2.8030503806064644	\N	23439858.53600249	1.001158046533792	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-26T00:00:00.000Z	morpho-api	2.6953611918401066	\N	24383240.166403882	1.001221831063912	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-27T00:00:00.000Z	morpho-api	2.605404877442652	\N	24371910.187950324	1.001283205507542	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-28T00:00:00.000Z	morpho-api	2.7607825018094445	\N	24363759.783409286	1.001349039731775	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-29T00:00:00.000Z	morpho-api	3.372558964898076	\N	24373413.652084086	1.001432047545863	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-30T00:00:00.000Z	morpho-api	2.5059091953494317	\N	24309316.573280845	1.001496106762724	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2025-12-31T00:00:00.000Z	morpho-api	2.4131337152510923	\N	24300876.951636292	1.001557407892979	assets_per_share
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
