-- Generated from VAULT_MORPHO/143/2026-02.ndjson (144 vault rows)
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
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-01T00:00:00.000Z	morpho-api	6.450099871813109	\N	11187440.41400003	1.005352534833706	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-02T00:00:00.000Z	morpho-api	7.337702218634945	\N	10759403.450620651	1.005469877968681	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-03T00:00:00.000Z	morpho-api	7.486989156646473	\N	10854312.732063206	1.005586205255806	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-04T00:00:00.000Z	morpho-api	7.437699272472287	\N	11261881.020717232	1.00570868432445	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-05T00:00:00.000Z	morpho-api	4.382140295433601	\N	10795134.947334725	1.005829435597385	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-06T00:00:00.000Z	morpho-api	9.163407511181276	\N	10965506.851182269	1.006001706300677	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-07T00:00:00.000Z	morpho-api	8.389325250490742	\N	10878685.0212231	1.006146147221882	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-08T00:00:00.000Z	morpho-api	6.14973128101326	\N	10781000.604662213	1.006242055421284	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-09T00:00:00.000Z	morpho-api	5.4852330581667275	\N	10376774.66004086	1.006318431342324	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-10T00:00:00.000Z	morpho-api	6.162305488288666	\N	8103759.481249789	1.00640707384111	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-11T00:00:00.000Z	morpho-api	6.63723057314769	\N	8393907.205794811	1.00650710716422	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-12T00:00:00.000Z	morpho-api	6.723764815319555	\N	8514161.041700026	1.006612950266153	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-13T00:00:00.000Z	morpho-api	6.938538885847834	\N	8153222.452444736	1.006721930884876	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-14T00:00:00.000Z	morpho-api	9.260250684661742	\N	8936737.451196807	1.006880479943586	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-15T00:00:00.000Z	morpho-api	6.907215756157825	\N	8977716.529314954	1.006969206046677	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-16T00:00:00.000Z	morpho-api	6.672818863862062	\N	8888422.936597446	1.007050086859482	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-17T00:00:00.000Z	morpho-api	6.158445065906903	\N	8526820.823886735	1.007132889524787	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-18T00:00:00.000Z	morpho-api	4.875903933410086	\N	9428144.026455723	1.007208165949224	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-19T00:00:00.000Z	morpho-api	5.162525415158825	\N	7495775.016862884	1.007282809554098	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-20T00:00:00.000Z	morpho-api	6.372036431301353	\N	8412031.087357553	1.007401795911693	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-21T00:00:00.000Z	morpho-api	7.965153551126036	\N	8094864.0552689005	1.007541027120205	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-22T00:00:00.000Z	morpho-api	9.436290986997165	\N	8662728.772316834	1.007720270635543	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-23T00:00:00.000Z	morpho-api	9.018385734194112	\N	8842062.860672893	1.00789331892266	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-24T00:00:00.000Z	morpho-api	8.400663534402497	\N	9336090.678624434	1.008046987053326	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-25T00:00:00.000Z	morpho-api	6.787108513606199	\N	8785467.455830669	1.0081577048156	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-26T00:00:00.000Z	morpho-api	7.492974807021824	\N	9341780.794684105	1.008282105330957	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-27T00:00:00.000Z	morpho-api	4.409560288110015	\N	8976325.74324545	1.008403923129008	assets_per_share
VAULT_MORPHO	143	0xbeeff443c3cba3e369da795002243beac311ab83	2026-02-28T00:00:00.000Z	morpho-api	3.2844015667166104	\N	8492186.774379399	1.008494667023852	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-01T00:00:00.000Z	morpho-api	0.2668474081701788	\N	1.231077846655557	1.001532321696959	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-02T00:00:00.000Z	morpho-api	0.23719995247972747	\N	1.2303580160896996	1.00153882951679	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-03T00:00:00.000Z	morpho-api	0.23719925223986138	\N	1.2302276214170722	1.001545337336622	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-04T00:00:00.000Z	morpho-api	0.26684390697084837	\N	1.2290960479603832	1.001552658633933	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-05T00:00:00.000Z	morpho-api	0.2668425064911162	\N	1.229005684740964	1.001559979931244	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-06T00:00:00.000Z	morpho-api	0.266841106011384	\N	1.2291174824846443	1.001567301228555	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-07T00:00:00.000Z	morpho-api	0.2668397055316518	\N	1.2303756681540825	1.001574622525865	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-08T00:00:00.000Z	morpho-api	0.2964836600227727	\N	1.2309193041965625	1.001582757300655	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-09T00:00:00.000Z	morpho-api	0.26683690457218745	\N	1.2303701043892867	1.001590078597966	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-10T00:00:00.000Z	morpho-api	0.23755077265263935	\N	556.6871975501648	1.00159659720586	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-11T00:00:00.000Z	morpho-api	0.0002436834733998694	\N	21169.039663186708	1.001596603890663	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-12T00:00:00.000Z	morpho-api	5.5793480971289	\N	4331676.368902788	1.001596603916072	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-13T00:00:00.000Z	morpho-api	7.350456387555937	\N	3433732.4038179377	1.001596603921315	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-14T00:00:00.000Z	morpho-api	8.16481434462446	\N	3536533.637894038	1.001596603926212	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-15T00:00:00.000Z	morpho-api	7.499068294336553	\N	3964925.4643084416	1.001596603930105	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-16T00:00:00.000Z	morpho-api	7.5065216474712315	\N	3723788.798902069	1.001596603934124	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-17T00:00:00.000Z	morpho-api	4.584975276245018	\N	6456951.096248795	1.001596603936898	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-18T00:00:00.000Z	morpho-api	5.362153997623409	\N	3013511.3309971783	1.001596603942484	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-19T00:00:00.000Z	morpho-api	6.236045647867172	\N	4287363.434161084	1.001605551385738	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-20T00:00:00.000Z	morpho-api	5.812630907797711	\N	5367312.548836223	1.001633386347132	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-21T00:00:00.000Z	morpho-api	9.224609875957412	\N	3465475.3355875225	1.001679796227357	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-22T00:00:00.000Z	morpho-api	7.920861278876146	\N	3909583.576211711	1.00171763714411	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-23T00:00:00.000Z	morpho-api	7.790213325620243	\N	3910645.9959579674	1.001757945542	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-24T00:00:00.000Z	morpho-api	8.12537543488645	\N	3656801.845294664	1.001802606126152	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-25T00:00:00.000Z	morpho-api	7.550708883741208	\N	4636491.903107717	1.001862417476614	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-26T00:00:00.000Z	morpho-api	6.921269570270283	\N	4877035.55190823	1.001897251082421	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-27T00:00:00.000Z	morpho-api	1.994809018768251	\N	3871162.6161459717	1.001952008573592	assets_per_share
VAULT_MORPHO	143	0xbeeff300e9a9caec7beea740ab8758d33b777509	2026-02-28T00:00:00.000Z	morpho-api	1.5451282813216949	\N	4956789.585035382	1.00199442438939	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-01T00:00:00.000Z	morpho-api	6.775569961092742	\N	8308475.89268843	1.005194163656789	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-02T00:00:00.000Z	morpho-api	4.454960339828062	\N	8309744.396299424	1.005316660127215	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-03T00:00:00.000Z	morpho-api	6.497308643105271	\N	7310273.175808181	1.005495460258908	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-04T00:00:00.000Z	morpho-api	7.6804213165360125	\N	6062276.601171727	1.005706808485512	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-05T00:00:00.000Z	morpho-api	4.954720832017756	\N	5639999.916587191	1.005843073149886	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-06T00:00:00.000Z	morpho-api	8.515952426435547	\N	5351228.188106747	1.006075862811582	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-07T00:00:00.000Z	morpho-api	4.959432746076686	\N	4645232.206291221	1.006212336445852	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-08T00:00:00.000Z	morpho-api	3.969652098234633	\N	4644977.777465834	1.006321491980803	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-09T00:00:00.000Z	morpho-api	4.2673821852190486	\N	4641281.242522202	1.006438889163643	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-10T00:00:00.000Z	morpho-api	4.488787527279214	\N	4315872.975813669	1.006562459646274	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-11T00:00:00.000Z	morpho-api	4.084410208449185	\N	4315693.649247394	1.006674829614414	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-12T00:00:00.000Z	morpho-api	4.257454184397602	\N	4317347.095372575	1.006791976404787	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-13T00:00:00.000Z	morpho-api	5.637329358521015	\N	4316102.867877209	1.00694684171492	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-14T00:00:00.000Z	morpho-api	4.58823559306154	\N	4313557.5159460595	1.007073139335229	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-15T00:00:00.000Z	morpho-api	4.3017212480123135	\N	4315154.474469855	1.00719155127801	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-16T00:00:00.000Z	morpho-api	4.341952129038873	\N	4318148.830294625	1.007311087835261	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-17T00:00:00.000Z	morpho-api	4.51363273796801	\N	4317408.282801876	1.00743534813791	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-18T00:00:00.000Z	morpho-api	4.540698409272181	\N	4318530.2026065765	1.007560374540443	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-19T00:00:00.000Z	morpho-api	4.66033579087366	\N	4319046.567284606	1.007688565970342	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-20T00:00:00.000Z	morpho-api	4.6470522406139025	\N	4319443.773711137	1.007816629970545	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-21T00:00:00.000Z	morpho-api	4.182804413233043	\N	4318422.173274482	1.007931853316337	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-22T00:00:00.000Z	morpho-api	4.194842236771024	\N	4320616.825858301	1.008047436197703	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-23T00:00:00.000Z	morpho-api	4.466145971449009	\N	4321695.170286251	1.008170505431944	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-24T00:00:00.000Z	morpho-api	4.234295151306355	\N	4319750.135920065	1.00828719699808	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-25T00:00:00.000Z	morpho-api	4.393557706450224	\N	4382000.51866404	1.008408316769741	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-26T00:00:00.000Z	morpho-api	4.2152948427798265	\N	4322949.085120376	1.008524326903386	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-27T00:00:00.000Z	morpho-api	4.736459566956341	\N	6707681.514469084	1.008655207586714	assets_per_share
VAULT_MORPHO	143	0xbeeffea75cfc4128ebe10c8d7ae22016d215060d	2026-02-28T00:00:00.000Z	morpho-api	3.6801743380721064	\N	6708506.087317289	1.00875691208693	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-01T00:00:00.000Z	morpho-api	6.773894987333051	\N	2686454.277717629	1.001917559814497	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-02T00:00:00.000Z	morpho-api	7.624660515759274	\N	2725490.919220538	1.002042573798977	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-03T00:00:00.000Z	morpho-api	7.949639036652911	\N	2546596.667357784	1.002171531861604	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-04T00:00:00.000Z	morpho-api	7.472131467167742	\N	2615662.6609930946	1.002294572269332	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-05T00:00:00.000Z	morpho-api	4.1657850832876875	\N	2616131.4938845993	1.002408971784805	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-06T00:00:00.000Z	morpho-api	7.856862856314706	\N	2909418.1911309613	1.00254416063373	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-07T00:00:00.000Z	morpho-api	8.184666845068023	\N	3065831.7429756764	1.002682304827654	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-08T00:00:00.000Z	morpho-api	7.0059404741584785	\N	6119518.044217049	1.002801937885457	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-09T00:00:00.000Z	morpho-api	6.600619932228824	\N	6263892.797601495	1.002909435125371	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-10T00:00:00.000Z	morpho-api	6.816639029239013	\N	6993002.727988478	1.003016221932306	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-11T00:00:00.000Z	morpho-api	7.416771903834274	\N	7579641.596908963	1.003137885659449	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-12T00:00:00.000Z	morpho-api	7.335008395870091	\N	7495648.246762154	1.003260586680237	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-13T00:00:00.000Z	morpho-api	7.377431027677517	\N	8036214.7878774665	1.003381558945939	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-14T00:00:00.000Z	morpho-api	8.799327596165085	\N	8369933.703881197	1.003526317791384	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-15T00:00:00.000Z	morpho-api	7.988077303622276	\N	9530087.340171877	1.00364546054514	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-16T00:00:00.000Z	morpho-api	7.710006450878382	\N	9879225.524310082	1.003755581231726	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-17T00:00:00.000Z	morpho-api	7.205537545829088	\N	9289468.585631914	1.00386772313406	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-18T00:00:00.000Z	morpho-api	5.2584589770532375	\N	15825839.2751772	1.003953503830974	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-19T00:00:00.000Z	morpho-api	5.307576602220365	\N	12925551.97274831	1.004031975407775	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-20T00:00:00.000Z	morpho-api	5.908871174753472	\N	15401221.00343854	1.00413756501551	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-21T00:00:00.000Z	morpho-api	8.39283555293946	\N	8976203.469671471	1.004288356166931	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-22T00:00:00.000Z	morpho-api	8.192696495612495	\N	7912418.743812495	1.004432489771342	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-23T00:00:00.000Z	morpho-api	8.02601419884752	\N	7914433.488463678	1.004577011584153	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-24T00:00:00.000Z	morpho-api	7.840839267458932	\N	7576959.961811366	1.004714409736331	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-25T00:00:00.000Z	morpho-api	7.243547966240271	\N	8269787.928764284	1.004837646517603	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-26T00:00:00.000Z	morpho-api	7.594275707489828	\N	8383097.694706252	1.004964445570415	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-27T00:00:00.000Z	morpho-api	5.324513303861522	\N	8416163.547535652	1.005111057545969	assets_per_share
VAULT_MORPHO	143	0x78999cc96d2ba0341588c60ccb0e91c6c33cf371	2026-02-28T00:00:00.000Z	morpho-api	4.7727572006550645	\N	11280293.847861588	1.00524249492817	assets_per_share
VAULT_MORPHO	143	0xe09a93786275546690247d70f1767cf0b69e8ea0	2026-02-25T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	143	0xe09a93786275546690247d70f1767cf0b69e8ea0	2026-02-26T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	143	0xe09a93786275546690247d70f1767cf0b69e8ea0	2026-02-27T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	143	0xe09a93786275546690247d70f1767cf0b69e8ea0	2026-02-28T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-01T00:00:00.000Z	morpho-api	4.371037292116853	\N	13447742.758436374	1.0001134313187963	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-02T00:00:00.000Z	morpho-api	4.615335576119151	\N	12494728.664372224	1.0001134842518427	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-03T00:00:00.000Z	morpho-api	8.403549923130527	\N	7058874.045738361	1.0001135697298535	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-04T00:00:00.000Z	morpho-api	6.642237988430111	\N	8509811.319977663	1.0001138132573517	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-05T00:00:00.000Z	morpho-api	6.366281159841947	\N	9940881.635322532	1.0001140714661487	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-06T00:00:00.000Z	morpho-api	8.71560621753531	\N	6306369.418154619	1.0001143764696252	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-07T00:00:00.000Z	morpho-api	6.433238095837623	\N	9452098.59203073	1.0001159978142096	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-08T00:00:00.000Z	morpho-api	6.896660340416361	\N	9544623.062440582	1.0001327896960226	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-09T00:00:00.000Z	morpho-api	6.5130213254605	\N	10150408.023859348	1.0001531020777343	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-10T00:00:00.000Z	morpho-api	4.949457128944346	\N	10215100.999684364	1.0001669300210931	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-11T00:00:00.000Z	morpho-api	5.669026416299516	\N	10859689.698858956	1.0001973462138167	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-12T00:00:00.000Z	morpho-api	5.796237592292641	\N	11211949.868530842	1.000239490878425	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-13T00:00:00.000Z	morpho-api	5.775663844787005	\N	12237989.344951479	1.0002844535895978	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-14T00:00:00.000Z	morpho-api	6.002554165718266	\N	13465179.161275882	1.0003307555099978	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-15T00:00:00.000Z	morpho-api	5.570789765485529	\N	13677800.34322017	1.0003662564405589	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-16T00:00:00.000Z	morpho-api	6.398725373557568	\N	12325964.194726942	1.0004091285754437	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-17T00:00:00.000Z	morpho-api	6.322650614265513	\N	12240252.75785843	1.0004511264545242	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-18T00:00:00.000Z	morpho-api	5.457644307682585	\N	13360701.162054798	1.0004858838433557	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-19T00:00:00.000Z	morpho-api	5.372869768294208	\N	12947702.968901016	1.0005253585877982	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-20T00:00:00.000Z	morpho-api	6.898038412472829	\N	10782116.514656428	1.000584966703008	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-21T00:00:00.000Z	morpho-api	5.415974433731208	\N	12817560.3557825	1.0006194534048036	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-22T00:00:00.000Z	morpho-api	6.404151532279911	\N	11447514.93557793	1.0006705934227869	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-23T00:00:00.000Z	morpho-api	5.497924905739637	\N	12282759.635629483	1.0007099107783444	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-24T00:00:00.000Z	morpho-api	6.716431203201978	\N	10766746.6722336	1.0007638463379094	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-25T00:00:00.000Z	morpho-api	5.738029453183913	\N	12426048.870421642	1.0008101569127514	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-26T00:00:00.000Z	morpho-api	5.138188578612812	\N	13444936.04967879	1.000841905162934	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-27T00:00:00.000Z	morpho-api	4.681835955722136	\N	14676442.136057898	1.0008710767286082	assets_per_share
VAULT_MORPHO	143	0xbeef04b01e0275d4ac2e2986256bb14e3ff6ef42	2026-02-28T00:00:00.000Z	morpho-api	4.759569583256962	\N	14804344.22915504	1.0009046107534199	assets_per_share
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
