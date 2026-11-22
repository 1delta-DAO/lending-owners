-- Generated from VAULT_MORPHO/999/2026-07.ndjson (139 vault rows)
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
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-01T00:00:00.000Z	morpho-api	16.702777410770864	\N	2740348.0510680676	1.0174889964215	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-02T00:00:00.000Z	morpho-api	16.70116405811939	\N	2742320.599898254	1.017954671463434	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-03T00:00:00.000Z	morpho-api	16.699241899686967	\N	2742384.66344364	1.018420506007363	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-04T00:00:00.000Z	morpho-api	16.700854552098576	\N	2745116.9458382525	1.018886598727812	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-05T00:00:00.000Z	morpho-api	16.700358782273383	\N	2745481.9034462343	1.019352890915747	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-06T00:00:00.000Z	morpho-api	16.693442513115997	\N	2747487.2766043455	1.019819203259013	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-07T00:00:00.000Z	morpho-api	16.697844921154115	\N	2749659.943227932	1.020285851987866	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-08T00:00:00.000Z	morpho-api	16.699627731853184	\N	2750283.7337980056	1.020752764110892	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-09T00:00:00.000Z	morpho-api	16.696060709975313	\N	2752235.390691678	1.021219790104506	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-10T00:00:00.000Z	morpho-api	16.702089775222362	\N	2365340.540067951	1.02168719854098	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-11T00:00:00.000Z	morpho-api	16.701402839913726	\N	2366710.9362468524	1.022154801662966	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-12T00:00:00.000Z	morpho-api	16.700339175557133	\N	2367026.364254582	1.02262258900295	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-13T00:00:00.000Z	morpho-api	16.701454657663817	\N	2369043.5303593576	1.023090621687857	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-14T00:00:00.000Z	morpho-api	16.70080903650728	\N	2362598.323371603	1.023558850470614	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-15T00:00:00.000Z	morpho-api	16.702273938307144	\N	1749486.055865563	1.024027334650511	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-16T00:00:00.000Z	morpho-api	16.702726993500505	\N	1198460.8989852192	1.02449604596298	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-17T00:00:00.000Z	morpho-api	16.70368282091772	\N	990949.8756009353	1.024964998653791	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-18T00:00:00.000Z	morpho-api	16.703016892805067	\N	989427.4749151778	1.025434147289199	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-19T00:00:00.000Z	morpho-api	16.70315974173775	\N	960944.9849747821	1.025903514689796	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-20T00:00:00.000Z	morpho-api	16.702368470689066	\N	961429.7525907692	1.026373074683091	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-21T00:00:00.000Z	morpho-api	16.701693439458154	\N	955610.6197304315	1.026842830607276	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-22T00:00:00.000Z	morpho-api	16.700958187598758	\N	913639.815768094	1.02731278083346	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-23T00:00:00.000Z	morpho-api	16.702900652987296	\N	860913.8690423687	1.027783000838488	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-24T00:00:00.000Z	morpho-api	16.70295387121712	\N	847318.4104909027	1.028253437564199	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-25T00:00:00.000Z	morpho-api	16.70301479208547	\N	834563.2985939588	1.028724091335686	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-26T00:00:00.000Z	morpho-api	16.70142874878877	\N	832748.9239861729	1.029194915817976	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-27T00:00:00.000Z	morpho-api	16.701163357879523	\N	833294.5821772061	1.029665948289668	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-28T00:00:00.000Z	morpho-api	16.698167731732383	\N	833767.131594411	1.030137111795717	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-29T00:00:00.000Z	morpho-api	16.70221931959759	\N	831648.2567858942	1.030608605299395	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-30T00:00:00.000Z	morpho-api	16.701797074958336	\N	829151.71709989	1.031080302675251	assets_per_share
VAULT_MORPHO	999	0x242572d6f1af7111bca807ecdd0f74108ceaed5d	2026-07-31T00:00:00.000Z	morpho-api	16.699916230678014	\N	829637.7855730727	1.031552162795928	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-01T00:00:00.000Z	morpho-api	8.1353405484208	\N	40.78159403824009	1.005603588659115	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-02T00:00:00.000Z	morpho-api	7.499335085725534	\N	40.79414177661822	1.005810222439058	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-03T00:00:00.000Z	morpho-api	8.4180308835613	\N	40.80694031171241	1.006042220188886	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-04T00:00:00.000Z	morpho-api	10.353518381833737	\N	40.82487771784191	1.00632763263526	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-05T00:00:00.000Z	morpho-api	9.184176625609553	\N	40.82688321606712	1.006580877947812	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-06T00:00:00.000Z	morpho-api	8.347247136697433	\N	40.8330508059998	1.006811100959223	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-07T00:00:00.000Z	morpho-api	8.463267079150683	\N	40.854094465560706	1.007044577657734	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-08T00:00:00.000Z	morpho-api	9.577780053859897	\N	40.86144232508428	1.007308865787107	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-09T00:00:00.000Z	morpho-api	10.142274220470426	\N	40.872565522972536	1.00758880612336	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-10T00:00:00.000Z	morpho-api	8.682792277170392	\N	40.878782192284824	1.007828524618144	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-11T00:00:00.000Z	morpho-api	9.005392083238917	\N	40.892966096980494	1.008077209840301	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-12T00:00:00.000Z	morpho-api	8.98532530939633	\N	40.898421543003025	1.008325402079562	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-13T00:00:00.000Z	morpho-api	8.622725701457057	\N	40.90882282975066	1.008563636064312	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-14T00:00:00.000Z	morpho-api	8.386133557181097	\N	40.92103369830289	1.008795387323973	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-15T00:00:00.000Z	morpho-api	8.75525099779395	\N	11151.360032987815	1.00903739598141	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-16T00:00:00.000Z	morpho-api	10.416978319938153	\N	11154.222759380082	1.009325412986426	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-17T00:00:00.000Z	morpho-api	10.117127906639212	\N	11157.962369645216	1.009605218178376	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-18T00:00:00.000Z	morpho-api	7.153198817277939	\N	11160.175039935071	1.009803098038353	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-19T00:00:00.000Z	morpho-api	7.681256002456394	\N	11161.987130513615	1.010015628789762	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-20T00:00:00.000Z	morpho-api	8.228252575293027	\N	11163.972668984043	1.010243343863439	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-21T00:00:00.000Z	morpho-api	7.773847319469951	\N	11166.777753831591	1.010458530550334	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-22T00:00:00.000Z	morpho-api	8.578610589893287	\N	11170.244323822983	1.010696046963258	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-23T00:00:00.000Z	morpho-api	7.604756897805487	\N	11173.185161042684	1.010906646923033	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-24T00:00:00.000Z	morpho-api	7.787039838547116	\N	11174.449580234548	1.011122340351127	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-25T00:00:00.000Z	morpho-api	7.816131303783891	\N	11178.351912371594	1.011338885857176	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-26T00:00:00.000Z	morpho-api	7.032278596241781	\N	11179.78848158851	1.011533754402372	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-27T00:00:00.000Z	morpho-api	7.17636065132865	\N	11182.1110172616	1.011732654258829	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-28T00:00:00.000Z	morpho-api	7.8319637271562215	\N	10683.344164986904	1.011949769420819	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-29T00:00:00.000Z	morpho-api	10.214994830803903	\N	10686.49019760581	1.012233016230241	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-30T00:00:00.000Z	morpho-api	10.059384026561702	\N	10713.876711352274	1.012512025657342	assets_per_share
VAULT_MORPHO	999	0x54e24c904cfc563af7a1ee9dfaf1354d034e44e4	2026-07-31T00:00:00.000Z	morpho-api	8.273070727682352	\N	10905.332668925052	1.012741547106945	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-18T00:00:00.000Z	morpho-api	\N	\N	9.205865474487885	1.000152910959322	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-19T00:00:00.000Z	morpho-api	10.761258252500738	\N	9.210619957964846	1.000447828512686	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-20T00:00:00.000Z	morpho-api	11.157939935202421	\N	9.213400415299239	1.000753709140355	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-21T00:00:00.000Z	morpho-api	8.486022073839194	\N	20.211652287389278	1.000986405186373	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-22T00:00:00.000Z	morpho-api	6.7729832750274	\N	20.214322353181412	1.001172166639493	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-23T00:00:00.000Z	morpho-api	6.896214987861526	\N	20.220451616265137	1.001361343371128	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-24T00:00:00.000Z	morpho-api	6.737978284121482	\N	20.21998851153477	1.001546213882027	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-25T00:00:00.000Z	morpho-api	6.712897092597814	\N	999.4804193612115	1.001730430173756	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-26T00:00:00.000Z	morpho-api	7.155044649564957	\N	999.4380873385657	1.001926817260084	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-27T00:00:00.000Z	morpho-api	6.497967568819263	\N	999.7806189245063	1.002105202672511	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-28T00:00:00.000Z	morpho-api	6.429927361750742	\N	1000.015386549203	1.002281751465559	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-29T00:00:00.000Z	morpho-api	6.802350634771415	\N	1000.0594263870685	1.002468559890847	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-30T00:00:00.000Z	morpho-api	7.937669836621808	\N	1000.1114412497358	1.002686590845557	assets_per_share
VAULT_MORPHO	999	0xb851d568d123077e787860a34da286255249d983	2026-07-31T00:00:00.000Z	morpho-api	6.265354887702301	\N	1000.4793040748301	1.002858720335817	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-01T00:00:00.000Z	morpho-api	6.785903400796656	\N	7730.9736118605915	1.008723188536603	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-02T00:00:00.000Z	morpho-api	6.554117702961548	\N	7734.784664122019	1.008904336040268	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-03T00:00:00.000Z	morpho-api	8.062208897285927	\N	7705.28683605741	1.009127209905941	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-04T00:00:00.000Z	morpho-api	8.309913147996895	\N	7776.1595537634175	1.009356982899483	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-05T00:00:00.000Z	morpho-api	8.512669001703443	\N	7776.59995106307	1.009592416435529	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-06T00:00:00.000Z	morpho-api	7.2492227101150775	\N	7777.712366824635	1.009792950337759	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-07T00:00:00.000Z	morpho-api	7.738840928084301	\N	39374.55488539172	1.010007072401204	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-08T00:00:00.000Z	morpho-api	7.4284063892093855	\N	49214.85789475183	1.010212647931015	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-09T00:00:00.000Z	morpho-api	6.482317207812116	\N	41778.49234022634	1.010392075340533	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-10T00:00:00.000Z	morpho-api	7.532169333046568	\N	42619.99402592302	1.0106006021678	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-11T00:00:00.000Z	morpho-api	7.686769691161999	\N	42569.99666416746	1.010813453452651	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-12T00:00:00.000Z	morpho-api	8.445545408619637	\N	49575.415466555205	1.011047367389745	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-13T00:00:00.000Z	morpho-api	7.43836520058494	\N	50797.11771440751	1.0112534305641	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-14T00:00:00.000Z	morpho-api	7.137558259628918	\N	77496.6510430554	1.011451200048137	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-15T00:00:00.000Z	morpho-api	7.194294494539122	\N	77429.4619159256	1.011650580730545	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-16T00:00:00.000Z	morpho-api	11.255007185440036	\N	83832.06684431045	1.011962577727895	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-17T00:00:00.000Z	morpho-api	9.218763573315414	\N	177665.80827607046	1.012218200247164	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-18T00:00:00.000Z	morpho-api	6.39898656302762	\N	76926.14358819809	1.012395672531794	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-19T00:00:00.000Z	morpho-api	5.647356793403446	\N	131770.51194759758	1.012552324647223	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-20T00:00:00.000Z	morpho-api	6.516432894088098	\N	130290.44780419151	1.012733114185542	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-21T00:00:00.000Z	morpho-api	6.886880790446526	\N	120319.29282966851	1.012924216389982	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-22T00:00:00.000Z	morpho-api	8.875883420245145	\N	130361.41032668078	1.013170564067825	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-23T00:00:00.000Z	morpho-api	7.885690331121964	\N	141641.69767464258	1.013389479467828	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-24T00:00:00.000Z	morpho-api	7.557473901087519	\N	198493.58633061778	1.013599327623845	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-25T00:00:00.000Z	morpho-api	6.401440203518405	\N	209613.44609258705	1.013777110210574	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-26T00:00:00.000Z	morpho-api	5.573383453949532	\N	205095.35163725237	1.01393192116569	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-27T00:00:00.000Z	morpho-api	6.58724254982701	\N	205151.87291419232	1.014114924404802	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-28T00:00:00.000Z	morpho-api	7.3055072903116525	\N	172294.37353277337	1.014317920710171	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-29T00:00:00.000Z	morpho-api	9.31263072736499	\N	165943.26195430895	1.014576747377101	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-30T00:00:00.000Z	morpho-api	8.882788485564674	\N	279539.86373867025	1.014823688943095	assets_per_share
VAULT_MORPHO	999	0x9fa2074e43ef6f6db4a1bb5eeb72e4bc8558bfde	2026-07-31T00:00:00.000Z	morpho-api	7.470077663640495	\N	291074.822036505	1.015031403678424	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-09T00:00:00.000Z	morpho-api	\N	\N	6.762990887274201e-8	1.0000228109423568	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-10T00:00:00.000Z	morpho-api	0.9319870507340511	\N	6.713370221389544e-8	1.0000483457406735	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-11T00:00:00.000Z	morpho-api	0.7844745205431991	\N	6.750945169783693e-8	1.0000698394586045	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-12T00:00:00.000Z	morpho-api	0.782263863285948	\N	6.695398924738762e-8	1.0000912730750386	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-13T00:00:00.000Z	morpho-api	0.7030856409073749	\N	6.730700798890904e-8	1.000110537643261	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-14T00:00:00.000Z	morpho-api	0.6771949720985049	\N	6.355105199262203e-8	1.0001290931494498	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-15T00:00:00.000Z	morpho-api	0.7544727434805054	\N	6.54646169679958e-8	1.0001497665092332	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-16T00:00:00.000Z	morpho-api	0.6953717985425101	\N	6.688091221272024e-8	1.0001688208351158	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-17T00:00:00.000Z	morpho-api	0.6630970428744831	\N	6.070618260055074e-8	1.0001869911169425	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-18T00:00:00.000Z	morpho-api	0.6570980879416766	\N	5.9579238465197916e-8	1.0002049973330307	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-19T00:00:00.000Z	morpho-api	0.6319419707523366	\N	6.022986775525092e-8	1.000222314511277	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-20T00:00:00.000Z	morpho-api	0.6148883290535423	\N	6.115268329814467e-8	1.000239164647787	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-21T00:00:00.000Z	morpho-api	0.6015935749559276	\N	6.250159223655081e-8	1.0002556507418199	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-22T00:00:00.000Z	morpho-api	0.6059966832339114	\N	6.081972530534813e-8	1.0002722577682863	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-23T00:00:00.000Z	morpho-api	0.6028098916033287	\N	5.938079167235843e-8	1.000288777738898	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-24T00:00:00.000Z	morpho-api	0.6596070473818827	\N	5.7571916441579406e-8	1.0003068545433178	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-25T00:00:00.000Z	morpho-api	0.6756460415147103	\N	5.740468546663867e-8	1.0003253712430356	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-26T00:00:00.000Z	morpho-api	0.6668377242391443	\N	5.81230079596009e-8	1.000343646885404	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-27T00:00:00.000Z	morpho-api	0.616820991083955	\N	45.38966498743145	1.0003605520327432	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-28T00:00:00.000Z	morpho-api	1.044640239911132	\N	0.0011414251687567086	1.0003891830416298	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-29T00:00:00.000Z	morpho-api	1.7839948046827203	\N	0.0011230984616456868	1.000438079821403	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-30T00:00:00.000Z	morpho-api	1.8810347455655574	\N	0.0010977384396031857	1.0004896389291704	assets_per_share
VAULT_MORPHO	999	0x62bbfaa81f70dfc66fc5e03d5de64ceaad8473ad	2026-07-31T00:00:00.000Z	morpho-api	2.0253506807677013	\N	0.0011357110697446827	1.0005451567083496	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-23T00:00:00.000Z	morpho-api	\N	\N	20.99935140470967	1	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-24T00:00:00.000Z	morpho-api	12.312327368846354	\N	21.004331773028373	1.000337380936315	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-25T00:00:00.000Z	morpho-api	7.916514890027315	\N	977.6675030649919	1.000554368458279	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-26T00:00:00.000Z	morpho-api	6.938182463755993	\N	977.7906258230411	1.00074457910518	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-27T00:00:00.000Z	morpho-api	7.039716544099406	\N	977.9900948304448	1.000937610280239	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-28T00:00:00.000Z	morpho-api	7.707924637756491	\N	978.0905780771113	1.001149006614148	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-29T00:00:00.000Z	morpho-api	9.637615550417422	\N	978.3631298487024	1.00141338916897	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-30T00:00:00.000Z	morpho-api	9.773909537713621	\N	978.5741041355842	1.001681581892997	assets_per_share
VAULT_MORPHO	999	0x7ee335d7bd6355c5fa651776b0ebdb726f929766	2026-07-31T00:00:00.000Z	morpho-api	8.438477887651175	\N	978.6939714235966	1.001913188600657	assets_per_share
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
