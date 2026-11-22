-- Generated from VAULT_MORPHO/4217/2026-10.ndjson (160 vault rows)
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
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-01T00:00:00.000Z	morpho-api	\N	\N	122.81482472378529	1.000298603005982	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-02T00:00:00.000Z	morpho-api	\N	\N	125.28770839019468	1.000299353850459	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-03T00:00:00.000Z	morpho-api	\N	\N	123.53823531491511	1.000300153136515	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-04T00:00:00.000Z	morpho-api	\N	\N	124.5888584478641	1.000301008937746	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-05T00:00:00.000Z	morpho-api	\N	\N	123.96690908380161	1.000301630604679	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-06T00:00:00.000Z	morpho-api	\N	\N	123.85779579105416	1.000301872812575	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-07T00:00:00.000Z	morpho-api	\N	\N	123.40324612669426	1.000302123094067	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-08T00:00:00.000Z	morpho-api	\N	\N	123.9864137959405	1.000302365301963	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-09T00:00:00.000Z	morpho-api	\N	\N	124.41593506318982	1.000302607509858	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-10T00:00:00.000Z	morpho-api	\N	\N	123.86101661000275	1.000302833570561	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-11T00:00:00.000Z	morpho-api	\N	\N	123.86433520952316	1.00030309192565	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-12T00:00:00.000Z	morpho-api	\N	\N	124.31346633006754	1.000303366427932	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-13T00:00:00.000Z	morpho-api	\N	\N	123.25407878994082	1.000303632856617	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-14T00:00:00.000Z	morpho-api	\N	\N	128.78888262076165	1.000303889382665	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-15T00:00:00.000Z	morpho-api	\N	\N	129.512792438748	1.000304161289143	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-16T00:00:00.000Z	morpho-api	\N	\N	128.79173190644337	1.000304472039402	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-17T00:00:00.000Z	morpho-api	\N	\N	128.53739404175786	1.000304977008574	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-18T00:00:00.000Z	morpho-api	\N	\N	128.6183027509906	1.000305505284016	assets_per_share
VAULT_MORPHO	4217	0x9bdd1acb0498029ec7a980804a0bad46f56664c7	2026-10-19T00:00:00.000Z	morpho-api	\N	\N	129.0697030322928	1.000306041328213	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-01T00:00:00.000Z	morpho-api	3.4283218663944126	\N	37662169.353023395	1.999598931315531	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-02T00:00:00.000Z	morpho-api	3.430428187911616	\N	38716630.63874159	1.999600617804516	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-03T00:00:00.000Z	morpho-api	3.4316227971231683	\N	38578728.14710607	1.999602385436608	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-04T00:00:00.000Z	morpho-api	3.434275305735923	\N	39022632.52335333	1.9996042855942	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-05T00:00:00.000Z	morpho-api	3.451204304738553	\N	38977931.5904159	1.999605659110297	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-06T00:00:00.000Z	morpho-api	3.436445349080941	\N	39131875.866899624	1.999606193643035	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-07T00:00:00.000Z	morpho-api	3.437103574555067	\N	39262752.21661919	1.999606757328642	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-08T00:00:00.000Z	morpho-api	3.436881598517516	\N	39739269.28931787	1.999607297369829	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-09T00:00:00.000Z	morpho-api	3.445581378613838	\N	39659399.56520018	1.999607846959123	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-10T00:00:00.000Z	morpho-api	3.436163152414906	\N	39727421.94418261	1.999608342253924	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-11T00:00:00.000Z	morpho-api	3.437378068582575	\N	39833240.39401091	1.999608905412276	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-12T00:00:00.000Z	morpho-api	3.4382841789692975	\N	40020099.308315605	1.999609520489464	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-13T00:00:00.000Z	morpho-api	3.437835325215133	\N	39729926.376398645	1.999610115819457	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-14T00:00:00.000Z	morpho-api	3.4372842364405187	\N	39817950.193355426	1.999610675547016	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-15T00:00:00.000Z	morpho-api	3.437675670525664	\N	38770392.111804865	1.999611290090106	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-16T00:00:00.000Z	morpho-api	3.433533051477866	\N	23261783.208659876	1.999611973968146	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-17T00:00:00.000Z	morpho-api	3.437936859995716	\N	22966687.14625898	1.999613097062034	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-18T00:00:00.000Z	morpho-api	3.438814260547929	\N	22983379.037450444	1.999614270190484	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-10-19T00:00:00.000Z	morpho-api	3.439176284558698	\N	23063074.08403587	1.999615463989116	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-01T00:00:00.000Z	morpho-api	3.356853985181374	\N	278952.39587539	1.998639238002942	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-02T00:00:00.000Z	morpho-api	3.368147453741699	\N	284570.5118525975	1.998650700632277	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-03T00:00:00.000Z	morpho-api	3.3820318098065627	\N	278604.1515909254	1.998662832759283	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-04T00:00:00.000Z	morpho-api	3.3997681853747963	\N	280975.1277622002	1.998676151275334	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-05T00:00:00.000Z	morpho-api	3.40092848283291	\N	278393.2927952663	1.998689406655338	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-06T00:00:00.000Z	morpho-api	3.373148566865325	\N	278149.72756487987	1.99870051059532	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-07T00:00:00.000Z	morpho-api	3.3736492383695804	\N	277354.61767623655	1.998712294875257	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-08T00:00:00.000Z	morpho-api	3.370732739327309	\N	278867.9601215534	1.998723615381845	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-09T00:00:00.000Z	morpho-api	3.415549491236902	\N	278395.80266083236	1.998735086477696	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-10T00:00:00.000Z	morpho-api	3.3381323721215495	\N	272178.67858596967	1.998745050745116	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-11T00:00:00.000Z	morpho-api	3.3768157230440465	\N	272187.5668063698	1.998757406905601	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-12T00:00:00.000Z	morpho-api	3.400308770551419	\N	273176.29058838735	1.998770998223498	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-13T00:00:00.000Z	morpho-api	3.399345240495677	\N	270850.0001442005	1.998784081001649	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-14T00:00:00.000Z	morpho-api	3.3727326243848665	\N	271421.1787090374	1.998796247536515	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-15T00:00:00.000Z	morpho-api	3.402924866691137	\N	272487.73688323743	1.99880952534054	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-16T00:00:00.000Z	morpho-api	3.3682062738904506	\N	270061.6838050243	1.998821565928891	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-17T00:00:00.000Z	morpho-api	2.7436399296476566	\N	68928.80604120123	1.998845240603486	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-18T00:00:00.000Z	morpho-api	3.38161306636664	\N	67945.02260313935	1.998904424049869	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-10-19T00:00:00.000Z	morpho-api	3.3965904968624727	\N	68185.52726198152	1.998965543139828	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-01T00:00:00.000Z	morpho-api	\N	\N	15110390.435011093	1.000405805583327	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-02T00:00:00.000Z	morpho-api	\N	\N	15709676.865152728	1.000406649339212	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-03T00:00:00.000Z	morpho-api	\N	\N	15891285.784738226	1.000407533691296	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-04T00:00:00.000Z	morpho-api	\N	\N	16116215.028756883	1.000408484346284	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-05T00:00:00.000Z	morpho-api	\N	\N	16188263.78476437	1.000409171520799	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-06T00:00:00.000Z	morpho-api	\N	\N	16362140.337205784	1.000409438949273	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-07T00:00:00.000Z	morpho-api	\N	\N	16576643.08059847	1.00040972096301	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-08T00:00:00.000Z	morpho-api	\N	\N	16945941.349110533	1.000409991147326	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-09T00:00:00.000Z	morpho-api	\N	\N	15884627.432767577	1.000410266108606	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-10T00:00:00.000Z	morpho-api	\N	\N	215107.89568286767	1.000410513908519	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-11T00:00:00.000Z	morpho-api	\N	\N	217935.89849827584	1.00041079565528	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-12T00:00:00.000Z	morpho-api	\N	\N	218675.73621230962	1.000411103383054	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-13T00:00:00.000Z	morpho-api	\N	\N	211638.17409064912	1.000411401224845	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-14T00:00:00.000Z	morpho-api	\N	\N	212796.15850672944	1.000411681259055	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-15T00:00:00.000Z	morpho-api	\N	\N	213992.26594348045	1.000411988720759	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-16T00:00:00.000Z	morpho-api	\N	\N	212800.86553429705	1.000412330866832	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-17T00:00:00.000Z	morpho-api	\N	\N	212380.6269070855	1.000412892752684	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-18T00:00:00.000Z	morpho-api	\N	\N	212514.3121010456	1.000413479673729	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-10-19T00:00:00.000Z	morpho-api	\N	\N	213260.15449225833	1.000414076935193	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-01T00:00:00.000Z	morpho-api	3.439328936849506	\N	5715.490145600814	1.000008008322011	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-02T00:00:00.000Z	morpho-api	3.4392799200588797	\N	5830.566980266263	1.000008008495444	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-03T00:00:00.000Z	morpho-api	3.4394087641942406	\N	5749.145908965246	1.000008008495444	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-04T00:00:00.000Z	morpho-api	3.4393107306129878	\N	5798.033635895113	1.000008008495444	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-05T00:00:00.000Z	morpho-api	3.439426970430759	\N	5769.085812203724	1.000008008668877	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-06T00:00:00.000Z	morpho-api	3.439366049562409	\N	5764.006438448397	1.000008008668877	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-07T00:00:00.000Z	morpho-api	3.4394451766672773	\N	5742.851305604169	1.000008008668877	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-08T00:00:00.000Z	morpho-api	3.4394941934579037	\N	5769.98880638085	1.000008008842311	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-09T00:00:00.000Z	morpho-api	3.4394759872213854	\N	5789.975963291333	1.000008008842311	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-10T00:00:00.000Z	morpho-api	3.43899142123405	\N	3247.939027462618	1.000008009093198	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-11T00:00:00.000Z	morpho-api	3.438961310919808	\N	3248.0251317425736	1.000008009093198	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-12T00:00:00.000Z	morpho-api	3.4387442365613197	\N	3259.8014459462984	1.000008009093198	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-13T00:00:00.000Z	morpho-api	3.439036936825346	\N	3232.020762799214	1.000008009093198	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-14T00:00:00.000Z	morpho-api	3.4387876514330173	\N	3249.690031301208	1.000008009093198	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-15T00:00:00.000Z	morpho-api	3.4381770422697855	\N	2261.1019979012976	1.000008009648146	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-16T00:00:00.000Z	morpho-api	3.4396160351946037	\N	2248.512560562941	1.000008009648146	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-17T00:00:00.000Z	morpho-api	3.438723929605203	\N	1233.8205369677235	1.000008011181826	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-18T00:00:00.000Z	morpho-api	3.4393541454846854	\N	1234.5964543041757	1.000008011181826	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-10-19T00:00:00.000Z	morpho-api	3.438983718595523	\N	1238.9286673903478	1.000008011181826	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-01T00:00:00.000Z	morpho-api	\N	\N	151.62820652467096	1.000401381292248	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-02T00:00:00.000Z	morpho-api	\N	\N	145.60062374394215	1.000402223273006	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-03T00:00:00.000Z	morpho-api	\N	\N	145.07310588705542	1.000403108848978	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-04T00:00:00.000Z	morpho-api	\N	\N	146.43176132694225	1.000404057133531	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-05T00:00:00.000Z	morpho-api	\N	\N	145.70077197703012	1.000404744122021	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-06T00:00:00.000Z	morpho-api	\N	\N	166.04265880035308	1.000405012994044	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-07T00:00:00.000Z	morpho-api	\N	\N	166.64839077093978	1.000405295721338	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-08T00:00:00.000Z	morpho-api	\N	\N	167.43592278866737	1.000405564777855	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-09T00:00:00.000Z	morpho-api	\N	\N	168.0159645701422	1.000405839813405	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-10T00:00:00.000Z	morpho-api	\N	\N	167.26658192752816	1.000406090932821	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-11T00:00:00.000Z	morpho-api	\N	\N	167.27106322407005	1.000406371947406	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-12T00:00:00.000Z	morpho-api	\N	\N	167.87758648666363	1.000406676878125	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-13T00:00:00.000Z	morpho-api	\N	\N	166.44694969034424	1.000406975829811	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-14T00:00:00.000Z	morpho-api	\N	\N	154.95415502171647	1.000407254215366	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-15T00:00:00.000Z	morpho-api	\N	\N	155.82513838099752	1.000407564180447	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-16T00:00:00.000Z	morpho-api	\N	\N	157.01809192131546	1.00040790439976	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-17T00:00:00.000Z	morpho-api	\N	\N	130.56328850474816	1.000408467787572	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-18T00:00:00.000Z	morpho-api	\N	\N	130.645473243608	1.000409056760754	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-10-19T00:00:00.000Z	morpho-api	\N	\N	131.10398789177066	1.000409653382938	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-01T00:00:00.000Z	morpho-api	\N	\N	298.79110724057324	1.000493769984066	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-02T00:00:00.000Z	morpho-api	\N	\N	304.8072846236217	1.000494573237978	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-03T00:00:00.000Z	morpho-api	\N	\N	300.5510633134189	1.000495413003432	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-04T00:00:00.000Z	morpho-api	\N	\N	303.10707979782154	1.000496315834276	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-05T00:00:00.000Z	morpho-api	\N	\N	301.5939651255648	1.000496969722791	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-06T00:00:00.000Z	morpho-api	\N	\N	301.3285086246159	1.000497225303581	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-07T00:00:00.000Z	morpho-api	\N	\N	300.22265339690665	1.000497490842064	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-08T00:00:00.000Z	morpho-api	\N	\N	301.6414186150742	1.000497746422855	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-09T00:00:00.000Z	morpho-api	\N	\N	302.6863834271208	1.000498008642107	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-10T00:00:00.000Z	morpho-api	\N	\N	301.336344851489	1.000498244307511	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-11T00:00:00.000Z	morpho-api	\N	\N	301.3444183850071	1.000498513165225	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-12T00:00:00.000Z	morpho-api	\N	\N	302.4370904630155	1.000498805257557	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-13T00:00:00.000Z	morpho-api	\N	\N	299.8597503186408	1.000499087392196	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-14T00:00:00.000Z	morpho-api	\N	\N	301.49915105703565	1.00049935624991	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-15T00:00:00.000Z	morpho-api	\N	\N	303.193849246511	1.000499645023011	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-16T00:00:00.000Z	morpho-api	\N	\N	301.505819684387	1.000499970307653	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-17T00:00:00.000Z	morpho-api	\N	\N	300.9104075458893	1.000500508023082	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-18T00:00:00.000Z	morpho-api	\N	\N	301.0998180057149	1.000501062334666	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-10-19T00:00:00.000Z	morpho-api	\N	\N	302.15656114544663	1.000501629923174	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-03T00:00:00.000Z	morpho-api	\N	\N	3.0000468107543443	1.000017999988777	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-04T00:00:00.000Z	morpho-api	2.8997766140292924	\N	3.999539333859233	1.000097450518225	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-05T00:00:00.000Z	morpho-api	2.700662707866286	\N	3.9998871324219647	1.000171451217502	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-06T00:00:00.000Z	morpho-api	2.7004624392645837	\N	4.000955181790837	1.000245451916779	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-07T00:00:00.000Z	morpho-api	2.417511614893897	\N	9.013155587693916	1.000311703570927	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-08T00:00:00.000Z	morpho-api	1.2002594470317263	\N	9.012154482196532	1.000344598179254	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-09T00:00:00.000Z	morpho-api	1.1098038616097483	\N	24989309.087610535	1.000375014702263	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-10T00:00:00.000Z	morpho-api	3.528720857914891	\N	24989388.439554878	1.000375014714108	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-11T00:00:00.000Z	morpho-api	3.5304609539821286	\N	24950221.014124934	1.000375014726022	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-12T00:00:00.000Z	morpho-api	3.5319447622583766	\N	24919392.954538055	1.000375014737866	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-13T00:00:00.000Z	morpho-api	3.52626651718424	\N	24978728.49457184	1.00037501474975	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-14T00:00:00.000Z	morpho-api	3.531941261059046	\N	24990830.18635303	1.000375014761589	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-15T00:00:00.000Z	morpho-api	3.5367666139762832	\N	26543981.666659206	1.000375014773062	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-16T00:00:00.000Z	morpho-api	3.5336274386565947	\N	41971725.81761483	1.000375014782917	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-17T00:00:00.000Z	morpho-api	3.5366608777565034	\N	42336900.572044194	1.000375014790191	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-18T00:00:00.000Z	morpho-api	3.5366370696010563	\N	42420067.88602508	1.00037501479118	assets_per_share
VAULT_MORPHO	4217	0x0d136e26b4d9e4836fc5cb202baeb49cb6f5df48	2026-10-19T00:00:00.000Z	morpho-api	3.536627266242931	\N	42362548.33459214	1.000375014792089	assets_per_share
VAULT_MORPHO	4217	0xce81991a8aa5e47af4d6174ca362ce9d2c2ea442	2026-10-20T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xce81991a8aa5e47af4d6174ca362ce9d2c2ea442	2026-10-21T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xce81991a8aa5e47af4d6174ca362ce9d2c2ea442	2026-10-22T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xce81991a8aa5e47af4d6174ca362ce9d2c2ea442	2026-10-23T00:00:00.000Z	morpho-api	\N	\N	0.9983246466020381	1	assets_per_share
VAULT_MORPHO	4217	0xce81991a8aa5e47af4d6174ca362ce9d2c2ea442	2026-10-24T00:00:00.000Z	morpho-api	\N	\N	0.9992648586513004	1	assets_per_share
VAULT_MORPHO	4217	0xb86b3ccce82f6cb767c45afb9fb032ae5fde3592	2026-10-15T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xb86b3ccce82f6cb767c45afb9fb032ae5fde3592	2026-10-16T00:00:00.000Z	morpho-api	0	\N	1.9980614636931793	1	assets_per_share
VAULT_MORPHO	4217	0xb86b3ccce82f6cb767c45afb9fb032ae5fde3592	2026-10-17T00:00:00.000Z	morpho-api	0	\N	199962.25895269527	1	assets_per_share
VAULT_MORPHO	4217	0xb86b3ccce82f6cb767c45afb9fb032ae5fde3592	2026-10-18T00:00:00.000Z	morpho-api	0	\N	199991.8963463367	1	assets_per_share
VAULT_MORPHO	4217	0xb86b3ccce82f6cb767c45afb9fb032ae5fde3592	2026-10-19T00:00:00.000Z	morpho-api	0	\N	199567.58340293038	1	assets_per_share
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
