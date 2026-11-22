-- Generated from VAULT_YEARN/8453/2024-11.ndjson (120 vault rows)
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
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-01T00:00:00.000Z	yearn-kong	1.5946828561652637	\N	17.011138613900002	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-02T00:00:00.000Z	yearn-kong	1.3027962708633822	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-03T00:00:00.000Z	yearn-kong	1.1516249873722018	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-04T00:00:00.000Z	yearn-kong	1.0004544041208874	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-05T00:00:00.000Z	yearn-kong	0.8857915265281235	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-06T00:00:00.000Z	yearn-kong	0.8284369798161606	\N	17.00804043	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-07T00:00:00.000Z	yearn-kong	0.8075649301275689	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-08T00:00:00.000Z	yearn-kong	0.9690689530827967	\N	17.0167873736	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-09T00:00:00.000Z	yearn-kong	1.109733137383273	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-10T00:00:00.000Z	yearn-kong	1.114909310473422	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-11T00:00:00.000Z	yearn-kong	1.1096582117176013	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-12T00:00:00.000Z	yearn-kong	1.0783714945006295	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-13T00:00:00.000Z	yearn-kong	0.9168646705859373	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-14T00:00:00.000Z	yearn-kong	0.7605669310351004	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-15T00:00:00.000Z	yearn-kong	0.5990713109582657	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-16T00:00:00.000Z	yearn-kong	0.5313329072720308	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-17T00:00:00.000Z	yearn-kong	0.5261112185905858	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-18T00:00:00.000Z	yearn-kong	0.5208846282300783	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-19T00:00:00.000Z	yearn-kong	0.5573314130202789	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-20T00:00:00.000Z	yearn-kong	0.7135871381791503	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-21T00:00:00.000Z	yearn-kong	0.8698253573413695	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-22T00:00:00.000Z	yearn-kong	1.0260656772231869	\N	24.1095820694	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-23T00:00:00.000Z	yearn-kong	1.0937431600410719	\N	24.1166	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-24T00:00:00.000Z	yearn-kong	1.093706747568035	\N	24.0794845526	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-25T00:00:00.000Z	yearn-kong	1.0884661524102057	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-26T00:00:00.000Z	yearn-kong	0.9999096175050681	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-27T00:00:00.000Z	yearn-kong	0.8436777005016438	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-28T00:00:00.000Z	yearn-kong	0.6874261767819689	\N	24.4756167552	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-29T00:00:00.000Z	yearn-kong	0.5311795547413567	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-11-30T00:00:00.000Z	yearn-kong	0.3749469374980663	\N	0	\N	\N
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-01T00:00:00.000Z	yearn-kong	4.803846450229798	\N	0	1.006248	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-02T00:00:00.000Z	yearn-kong	4.072015962819364	\N	0	1.006263	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-03T00:00:00.000Z	yearn-kong	4.382428794258431	\N	0	1.006482	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-04T00:00:00.000Z	yearn-kong	4.6823240229088015	\N	0	1.0067	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-05T00:00:00.000Z	yearn-kong	4.992455357921699	\N	0	1.006919	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-06T00:00:00.000Z	yearn-kong	5.297382510249804	\N	3.6490918949999998	1.007138	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-07T00:00:00.000Z	yearn-kong	5.747293626612304	\N	0	1.007357	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-08T00:00:00.000Z	yearn-kong	6.886717634557726	\N	0	1.007577	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-09T00:00:00.000Z	yearn-kong	7.942976954566916	\N	0	1.007796	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-10T00:00:00.000Z	yearn-kong	7.941250163057134	\N	0	1.008015	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-11T00:00:00.000Z	yearn-kong	7.949829501896488	\N	0	1.008235	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-12T00:00:00.000Z	yearn-kong	7.870491624828446	\N	0	1.008439	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-13T00:00:00.000Z	yearn-kong	6.735809641256196	\N	3.6547511	1.008439	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-14T00:00:00.000Z	yearn-kong	5.601329326765381	\N	0	1.008439	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-15T00:00:00.000Z	yearn-kong	4.467148014697386	\N	0	1.008439	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-16T00:00:00.000Z	yearn-kong	4.088493307108365	\N	0	1.008586	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-17T00:00:00.000Z	yearn-kong	4.294515779790231	\N	0	1.008845	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-18T00:00:00.000Z	yearn-kong	4.505556171352509	\N	0	1.009108	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-19T00:00:00.000Z	yearn-kong	4.799311696856989	\N	3.6651615	1.009367	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-20T00:00:00.000Z	yearn-kong	6.143195942343027	\N	3.6600683535	1.009627	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-21T00:00:00.000Z	yearn-kong	7.486628533115436	\N	0	1.009887	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-22T00:00:00.000Z	yearn-kong	8.82977542602248	\N	0	1.010147	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-23T00:00:00.000Z	yearn-kong	9.391272566006137	\N	0	1.010406	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-24T00:00:00.000Z	yearn-kong	9.399188777692302	\N	0	1.010667	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-25T00:00:00.000Z	yearn-kong	9.396769448954956	\N	0	1.010927	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-26T00:00:00.000Z	yearn-kong	8.625474843171332	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-27T00:00:00.000Z	yearn-kong	7.281792967006595	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-28T00:00:00.000Z	yearn-kong	5.938247637615746	\N	3.661382832	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-29T00:00:00.000Z	yearn-kong	4.595050327438344	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-11-30T00:00:00.000Z	yearn-kong	3.2574430321119507	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-01T00:00:00.000Z	yearn-kong	0.6555981741485084	\N	119.585004	1.001071018028386	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-02T00:00:00.000Z	yearn-kong	0.5411691766710192	\N	118.61445427999999	1.0010710527619158	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-03T00:00:00.000Z	yearn-kong	0.42668626072384086	\N	117.19626218999998	1.001071547799295	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-04T00:00:00.000Z	yearn-kong	0.3122824718815309	\N	114.32064384000002	1.0010720415253749	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-05T00:00:00.000Z	yearn-kong	0.19784787248511293	\N	115.766469	1.0010725353776915	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-06T00:00:00.000Z	yearn-kong	0.08343007884548115	\N	129.5911904	1.001073029377821	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-07T00:00:00.000Z	yearn-kong	0.013062974701938401	\N	137.94933152000002	1.0010735242755617	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-08T00:00:00.000Z	yearn-kong	0.015641958128753686	\N	140.900522	1.0010740191508805	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-09T00:00:00.000Z	yearn-kong	0.018040979909983434	\N	149.12175124	1.0010745140266883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-10T00:00:00.000Z	yearn-kong	0.018040979909983434	\N	151.97277703999998	1.0010750089258968	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-11T00:00:00.000Z	yearn-kong	0.018046581828912167	\N	159.732272	1.0010755039286967	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-12T00:00:00.000Z	yearn-kong	0.01787082162252318	\N	154.69866244000002	1.0010759639804532	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-13T00:00:00.000Z	yearn-kong	0.015295339395038354	\N	152.07390800000002	1.0010759639804532	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-14T00:00:00.000Z	yearn-kong	0.01271635596822307	\N	145.581744	1.0010759639804532	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-15T00:00:00.000Z	yearn-kong	0.010138072781273877	\N	147.1085378	1.0010759639804532	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-16T00:00:00.000Z	yearn-kong	0.008713084653777514	\N	149.485896	1.0010761857702375	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-17T00:00:00.000Z	yearn-kong	0.008164796838627808	\N	146.45274308	1.0010765753887434	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-18T00:00:00.000Z	yearn-kong	0.007610907104549369	\N	152.59271468	1.0010769691570414	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-19T00:00:00.000Z	yearn-kong	0.00726989028976277	\N	148.06081864	1.001077358857343	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-20T00:00:00.000Z	yearn-kong	0.00930128614129444	\N	146.178886	1.0010777485399065	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-21T00:00:00.000Z	yearn-kong	0.01133268199282611	\N	159.91089576000002	1.0010781382317941	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-22T00:00:00.000Z	yearn-kong	0.01336407784435778	\N	158.38032252	1.001078528005171	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-23T00:00:00.000Z	yearn-kong	0.014217670241123415	\N	161.70672	1.0010789177157067	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-24T00:00:00.000Z	yearn-kong	0.014217670241123415	\N	159.98034416000002	1.0010793073543807	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-25T00:00:00.000Z	yearn-kong	0.014217670241123415	\N	162.56000712000002	1.0010796971016058	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-26T00:00:00.000Z	yearn-kong	0.01304056702622347	\N	158.094832	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-27T00:00:00.000Z	yearn-kong	0.0110091711746918	\N	174.52873200000002	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-28T00:00:00.000Z	yearn-kong	0.008977775323160131	\N	170.44682256	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-29T00:00:00.000Z	yearn-kong	0.006946379471628461	\N	171.08678552	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-11-30T00:00:00.000Z	yearn-kong	0.004916384099828974	\N	176.482712	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-01T00:00:00.000Z	yearn-kong	2.0053273217968126	\N	0.753687	1.0025942641006549	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-02T00:00:00.000Z	yearn-kong	1.6862133097816923	\N	0.74757009	1.0025979275190022	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-03T00:00:00.000Z	yearn-kong	1.6125403732303312	\N	0.73708341	1.0026501510568597	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-04T00:00:00.000Z	yearn-kong	1.538936060185847	\N	0.71899776	1.0027023365291907	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-05T00:00:00.000Z	yearn-kong	1.4652421164385032	\N	0.72680037	1.0027545479808233	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-06T00:00:00.000Z	yearn-kong	1.3916532086710731	\N	0.815199	1.0028067503650033	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-07T00:00:00.000Z	yearn-kong	1.3774362386698158	\N	0.8694285600000001	1.0028589787357232	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-08T00:00:00.000Z	yearn-kong	1.6491384098316075	\N	0.8880285	1.0029112004569491	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-09T00:00:00.000Z	yearn-kong	1.9018500758249957	\N	0.93984297	1.0029634348719474	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-10T00:00:00.000Z	yearn-kong	1.9019495098859807	\N	0.9578116200000001	1.0030156735189932	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-11T00:00:00.000Z	yearn-kong	1.9020482437070996	\N	1.0130578799999999	1.0030679284924504	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-12T00:00:00.000Z	yearn-kong	1.8830472349407046	\N	0.9749915699999999	1.0031164986943812	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-13T00:00:00.000Z	yearn-kong	1.6113485649782433	\N	0.958449	1.0031164986943812	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-14T00:00:00.000Z	yearn-kong	1.3396758038908274	\N	0.917532	1.0031164986943812	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-15T00:00:00.000Z	yearn-kong	1.0681269852597097	\N	0.9271546500000001	1.0031164986943812	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-16T00:00:00.000Z	yearn-kong	1.0160389425806216	\N	0.9395008499999999	1.0031587590466486	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-17T00:00:00.000Z	yearn-kong	1.1305953837137395	\N	0.9230214899999999	1.0032330301599275	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-18T00:00:00.000Z	yearn-kong	1.246365340534794	\N	0.96171879	1.0033080947540176	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-19T00:00:00.000Z	yearn-kong	1.3828322870779175	\N	0.9333030000000001	1.003382386262574	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-20T00:00:00.000Z	yearn-kong	1.7692834653360023	\N	0.921426	1.003456702536022	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-21T00:00:00.000Z	yearn-kong	2.1556527155297545	\N	1.00784178	1.0035310229368395	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-22T00:00:00.000Z	yearn-kong	2.54218442137244	\N	0.9981953100000001	1.003605369834317	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-23T00:00:00.000Z	yearn-kong	2.7047829192383688	\N	1.0191599999999998	1.003678922313329	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-24T00:00:00.000Z	yearn-kong	2.704983187840071	\N	1.00827948	1.0037540588142624	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-25T00:00:00.000Z	yearn-kong	2.705183456441773	\N	1.02453786	1.0038284335994185	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-26T00:00:00.000Z	yearn-kong	2.4814022005159586	\N	0.9979586699999999	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-27T00:00:00.000Z	yearn-kong	2.094937717700418	\N	1.09736808	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-28T00:00:00.000Z	yearn-kong	1.7084284195334476	\N	1.0776270000000001	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-29T00:00:00.000Z	yearn-kong	1.32201715494773	\N	1.07827806	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-11-30T00:00:00.000Z	yearn-kong	0.9356710126695589	\N	1.112286	1.0038596940603606	assets_per_share
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
