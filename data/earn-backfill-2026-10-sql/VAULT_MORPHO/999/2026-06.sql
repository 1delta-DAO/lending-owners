-- Generated from VAULT_MORPHO/999/2026-06.ndjson (87 vault rows)
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
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-01T00:00:00.000Z	morpho-api	9.420819887395737	\N	6434945.557236387	1.008263022688166	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-02T00:00:00.000Z	morpho-api	11.408373720911413	\N	6603892.842275813	1.008541041887552	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-03T00:00:00.000Z	morpho-api	10.80781299975797	\N	6546981.404922716	1.008801875920845	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-04T00:00:00.000Z	morpho-api	13.068425369056058	\N	6392178.895816649	1.009127985263311	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-05T00:00:00.000Z	morpho-api	11.917590252252808	\N	5244254.435185101	1.009409340323475	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-06T00:00:00.000Z	morpho-api	17.17686921018924	\N	6121597.782472787	1.00969220039748	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-07T00:00:00.000Z	morpho-api	14.408814717370433	\N	6219677.87406874	1.009886603763609	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-08T00:00:00.000Z	morpho-api	14.084892158194862	\N	6432367.172838723	1.010079143437806	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-09T00:00:00.000Z	morpho-api	12.99483786176836	\N	6882994.3348825	1.010291317752727	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-10T00:00:00.000Z	morpho-api	12.883383483242028	\N	6633965.935219252	1.010493903648546	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-11T00:00:00.000Z	morpho-api	18.94687322234745	\N	7768003.989975823	1.010885133575029	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-12T00:00:00.000Z	morpho-api	15.387611402672974	\N	7758407.728957548	1.01117275967623	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-13T00:00:00.000Z	morpho-api	14.5278575953256	\N	8462190.857729364	1.011449438998265	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-14T00:00:00.000Z	morpho-api	13.756219872007591	\N	8499933.695643952	1.011704487074613	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-15T00:00:00.000Z	morpho-api	13.762795124350191	\N	8672008.346055558	1.011963219418733	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-16T00:00:00.000Z	morpho-api	13.957311955792306	\N	9755061.77713457	1.012243156130674	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-17T00:00:00.000Z	morpho-api	13.247121681203566	\N	10401468.344868017	1.01251068495963	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-18T00:00:00.000Z	morpho-api	12.12756207777943	\N	10456718.897727361	1.012746929404727	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-19T00:00:00.000Z	morpho-api	11.278748117860005	\N	10675909.814671038	1.012967592385597	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-20T00:00:00.000Z	morpho-api	14.138546637454397	\N	10388953.799795927	1.013267416284296	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-21T00:00:00.000Z	morpho-api	15.94579780856975	\N	8975391.560389265	1.013603704758192	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-22T00:00:00.000Z	morpho-api	30.493158484645733	\N	5811139.022130873	1.01407001283327	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-23T00:00:00.000Z	morpho-api	36.0099184423035	\N	5606447.456466083	1.014695304651823	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-24T00:00:00.000Z	morpho-api	35.92766336595332	\N	5640196.338374581	1.015320976523844	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-25T00:00:00.000Z	morpho-api	22.498305660079154	\N	5646947.413064529	1.015947005102364	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-26T00:00:00.000Z	morpho-api	13.73482264241943	\N	5646259.565391278	1.016329374343944	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-27T00:00:00.000Z	morpho-api	0	\N	4659345.581406389	1.016329374343944	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-28T00:00:00.000Z	morpho-api	0	\N	4189260.793700056	1.016329374343944	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-29T00:00:00.000Z	morpho-api	8.216222454393574	\N	3456427.1639103107	1.016558177855281	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-06-30T00:00:00.000Z	morpho-api	16.703409727369944	\N	2779241.214453297	1.01702348946311	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-04T00:00:00.000Z	morpho-api	\N	\N	40.560228773112534	1.000083757793659	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-05T00:00:00.000Z	morpho-api	7.001059102051954	\N	40.57087748944483	1.000275602086786	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-06T00:00:00.000Z	morpho-api	6.580652592447223	\N	40.576941082191546	1.000455959878488	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-07T00:00:00.000Z	morpho-api	6.173061172631833	\N	40.585996620454864	1.00062517625679	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-08T00:00:00.000Z	morpho-api	6.396761200733181	\N	40.58772270149707	1.000800554921264	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-09T00:00:00.000Z	morpho-api	6.49990303180914	\N	40.59363463247016	1.000978792886523	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-10T00:00:00.000Z	morpho-api	9.071501728996623	\N	40.611169026500264	1.00122760135303	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-11T00:00:00.000Z	morpho-api	8.206804228194642	\N	40.621502203337975	1.001452746640635	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-12T00:00:00.000Z	morpho-api	8.571417725988795	\N	40.62877129021558	1.001687948779274	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-13T00:00:00.000Z	morpho-api	10.074367058976463	\N	40.64309831809275	1.001964462884414	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-14T00:00:00.000Z	morpho-api	7.965563891687566	\N	40.65108615780886	1.00218315009611	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-15T00:00:00.000Z	morpho-api	8.310274471767798	\N	40.6553033074947	1.002411351877657	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-16T00:00:00.000Z	morpho-api	7.922530650716908	\N	40.66900015822453	1.002628954526986	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-17T00:00:00.000Z	morpho-api	12.18287472504187	\N	40.68260027115974	1.002963665262741	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-18T00:00:00.000Z	morpho-api	5.619493548891796	\N	40.68752835279449	1.003118092154229	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-19T00:00:00.000Z	morpho-api	5.51998456224112	\N	40.70240099136017	1.0032698076398	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-20T00:00:00.000Z	morpho-api	6.115401321338254	\N	40.700960313998536	1.00343791480659	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-21T00:00:00.000Z	morpho-api	6.122445034151269	\N	40.71040387460159	1.003606243815683	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-22T00:00:00.000Z	morpho-api	5.986075420949533	\N	40.71517732438694	1.003770850803928	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-23T00:00:00.000Z	morpho-api	7.2020678572926045	\N	40.722683817417035	1.003968931330662	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-24T00:00:00.000Z	morpho-api	6.360226885959719	\N	40.72950754224376	1.004143890959677	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-25T00:00:00.000Z	morpho-api	6.406597470132169	\N	40.73628818716473	1.00432015699336	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-26T00:00:00.000Z	morpho-api	6.436821223232414	\N	40.73883797769476	1.004497285747107	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-27T00:00:00.000Z	morpho-api	6.734784490092238	\N	40.74829532369302	1.004682647315181	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-28T00:00:00.000Z	morpho-api	9.141915048971327	\N	40.76023528429752	1.004934315082473	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-29T00:00:00.000Z	morpho-api	7.903538044828906	\N	40.765476270607344	1.005151942380948	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-06-30T00:00:00.000Z	morpho-api	8.261569988121664	\N	40.77250896870224	1.005379478635588	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-01T00:00:00.000Z	morpho-api	3.1779581046720295	\N	5055.128108045204	1.003880879449942	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-02T00:00:00.000Z	morpho-api	3.745181806280584	\N	5056.02657552857	1.003983890664797	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-03T00:00:00.000Z	morpho-api	6.559906585934527	\N	5057.225357032791	1.004164346338928	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-04T00:00:00.000Z	morpho-api	7.005702392604007	\N	7460.303362477733	1.004357101182527	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-05T00:00:00.000Z	morpho-api	5.790777822056725	\N	5059.708335822204	1.004516456529806	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-06T00:00:00.000Z	morpho-api	5.998620218150563	\N	5060.476237729739	1.004681558123016	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-07T00:00:00.000Z	morpho-api	5.75751012625858	\N	5061.63663487894	1.004840049094475	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-08T00:00:00.000Z	morpho-api	6.491453237345013	\N	6061.6281574109435	1.005018773806504	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-09T00:00:00.000Z	morpho-api	5.428129197326825	\N	5812.468539237243	1.005168247158452	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-10T00:00:00.000Z	morpho-api	6.043824202706105	\N	5468.512316787328	1.005334700949567	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-11T00:00:00.000Z	morpho-api	7.058331720699584	\N	8470.288364978653	1.005529130318663	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-12T00:00:00.000Z	morpho-api	6.762633729806566	\N	5471.20881062319	1.005715449631873	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-13T00:00:00.000Z	morpho-api	8.677950818736235	\N	6020.668837417387	1.005954588998614	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-14T00:00:00.000Z	morpho-api	5.10220605285383	\N	6720.353221162268	1.006095217660672	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-15T00:00:00.000Z	morpho-api	6.918991689985887	\N	6598.51638835234	1.006285952562582	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-16T00:00:00.000Z	morpho-api	5.941116520347123	\N	7051.5415340905765	1.006449759379969	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-17T00:00:00.000Z	morpho-api	7.360182019056083	\N	7554.006769210784	1.006652729243361	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-18T00:00:00.000Z	morpho-api	5.054192705955529	\N	6506.332571090318	1.006792131137887	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-19T00:00:00.000Z	morpho-api	4.711295747128474	\N	5879.465880840755	1.006922092829202	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-20T00:00:00.000Z	morpho-api	4.853850579067398	\N	5701.656429797326	1.007056004452755	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-21T00:00:00.000Z	morpho-api	5.073427594837199	\N	5702.90350732148	1.007195992959671	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-22T00:00:00.000Z	morpho-api	5.065830692529971	\N	5703.5163258595785	1.007335791277047	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-23T00:00:00.000Z	morpho-api	4.9800947238054505	\N	5704.307039037399	1.007473242510706	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-24T00:00:00.000Z	morpho-api	5.032913116664872	\N	5705.142773913326	1.007612170582912	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-25T00:00:00.000Z	morpho-api	5.602979792129759	\N	5505.827052883884	1.007766857266546	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-26T00:00:00.000Z	morpho-api	5.068541321051612	\N	5516.047066503773	1.00790680966183	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-27T00:00:00.000Z	morpho-api	5.157599227700871	\N	5517.17580565579	1.008049241081867	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-28T00:00:00.000Z	morpho-api	5.037909328109436	\N	7673.7913497108475	1.008188386591818	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-29T00:00:00.000Z	morpho-api	6.259525390817089	\N	7723.310108500514	1.008361299519634	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-06-30T00:00:00.000Z	morpho-api	6.311168080941343	\N	7767.286873673364	1.008535669043524	assets_per_share
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
