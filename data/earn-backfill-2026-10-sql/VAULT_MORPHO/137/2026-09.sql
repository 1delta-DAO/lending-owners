-- Generated from VAULT_MORPHO/137/2026-09.ndjson (109 vault rows)
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
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-01T00:00:00.000Z	morpho-api	1.4711619442664414	\N	73900.44627040019	1.0085226547890649	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-02T00:00:00.000Z	morpho-api	1.3486353729774692	\N	73565.28782880856	1.008559919303976	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-03T00:00:00.000Z	morpho-api	0.912251490348126	\N	73940.25456279557	1.0085851267444221	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-04T00:00:00.000Z	morpho-api	0.8223588977784857	\N	75488.78189229907	1.008607850798843	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-05T00:00:00.000Z	morpho-api	0.8021226658883052	\N	75466.18680768597	1.008630016163625	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-06T00:00:00.000Z	morpho-api	0.7977349628873753	\N	75379.87869789271	1.0086520607811567	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-07T00:00:00.000Z	morpho-api	0.7930013413925963	\N	75436.51309480704	1.0086739750619205	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-08T00:00:00.000Z	morpho-api	0.7971985791499492	\N	76265.23512370387	1.0086960058079215	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-09T00:00:00.000Z	morpho-api	2.4828537977583665	\N	69175.191377611	1.00876462306313	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-10T00:00:00.000Z	morpho-api	4.252357838652188	\N	69277.84139857467	1.008882153975283	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-11T00:00:00.000Z	morpho-api	4.83419624650594	\N	68908.62916888126	1.0090157829344573	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-12T00:00:00.000Z	morpho-api	5.388588752808232	\N	68348.69932614437	1.0091647575320777	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-13T00:00:00.000Z	morpho-api	6.33909994895987	\N	68225.56699587751	1.0093400384098703	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-14T00:00:00.000Z	morpho-api	7.25705349253758	\N	68198.3787501226	1.00954073876183	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-15T00:00:00.000Z	morpho-api	8.273375332024102	\N	68134.46492472646	1.0097695950891223	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-16T00:00:00.000Z	morpho-api	8.91245484773151	\N	67801.583543288	1.010016187553744	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-17T00:00:00.000Z	morpho-api	9.748464221459585	\N	67478.46833365288	1.0102859799263002	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-18T00:00:00.000Z	morpho-api	9.97237432152076	\N	58104.27071101957	1.0105620436600626	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-19T00:00:00.000Z	morpho-api	12.021979910770142	\N	54666.70733570348	1.0108949465973764	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-20T00:00:00.000Z	morpho-api	13.262606785602316	\N	54365.798568893246	1.0112623312073368	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-21T00:00:00.000Z	morpho-api	15.249932340921646	\N	54375.38816663061	1.0116849313263006	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-22T00:00:00.000Z	morpho-api	17.570205146810736	\N	54399.14863850448	1.0121720488746377	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-23T00:00:00.000Z	morpho-api	20.47617678293534	\N	54925.19634132942	1.0127400277375769	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-24T00:00:00.000Z	morpho-api	25.61222822947684	\N	42837.28650251824	1.013450921744027	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-25T00:00:00.000Z	morpho-api	33.38045612402141	\N	42780.46885087603	1.0143781800320104	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-26T00:00:00.000Z	morpho-api	38.86945577242784	\N	43161.754805880686	1.015458983570812	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-27T00:00:00.000Z	morpho-api	28.26214455424747	\N	43105.82657674473	1.016245563360708	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-28T00:00:00.000Z	morpho-api	7.929449020593893	\N	43040.58023080636	1.0164663617830436	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-29T00:00:00.000Z	morpho-api	5.31697102026385	\N	42945.02543311041	1.0166144416685363	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-09-30T00:00:00.000Z	morpho-api	0.2687702668424663	\N	10338.494403573857	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-01T00:00:00.000Z	morpho-api	0.011570763547297247	\N	192155.03885661822	1.0000037822561276	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-02T00:00:00.000Z	morpho-api	0.01157216402702943	\N	193387.71334836987	1.000004099302863	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-03T00:00:00.000Z	morpho-api	0.011573564506761613	\N	195482.96317215823	1.0000044163833455	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-04T00:00:00.000Z	morpho-api	0.011574964986493796	\N	194134.96767118413	1.000004733504829	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-05T00:00:00.000Z	morpho-api	0.01157636546622598	\N	194012.98135923553	1.0000050506612959	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-06T00:00:00.000Z	morpho-api	0.02065987700916594	\N	193776.93147768124	1.0000056166858193	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-07T00:00:00.000Z	morpho-api	0.031835705271987536	\N	193288.16696520738	1.0000064888999411	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-08T00:00:00.000Z	morpho-api	0.03170896185622496	\N	193118.95403842092	1.0000073576424577	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-09T00:00:00.000Z	morpho-api	0.031582918680328476	\N	194831.24286176031	1.0000082229381029	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-10T00:00:00.000Z	morpho-api	0.031458275984164175	\N	195446.3603834927	1.0000090848116416	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-11T00:00:00.000Z	morpho-api	0.031334333527865965	\N	196015.58093499145	1.0000099432878924	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-12T00:00:00.000Z	morpho-api	0.031211091311433847	\N	195473.61069023027	1.0000107983916946	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-13T00:00:00.000Z	morpho-api	0.03108854933486782	\N	195187.70235514364	1.0000116501479328	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-14T00:00:00.000Z	morpho-api	0.030967407838033978	\N	195187.8971806556	1.0000124985815182	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-15T00:00:00.000Z	morpho-api	0.030846966581066226	\N	194468.75923015125	1.0000133437174186	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-16T00:00:00.000Z	morpho-api	0.030727925803830658	\N	194495.42230296283	1.0000141855806164	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-17T00:00:00.000Z	morpho-api	0.03060888502659509	\N	193670.6987766714	1.0000150241961396	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-18T00:00:00.000Z	morpho-api	0.030491244729091704	\N	194764.76063023458	1.0000158595890498	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-19T00:00:00.000Z	morpho-api	0.03037430467145441	\N	194168.57899865365	1.0000166917844358	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-20T00:00:00.000Z	morpho-api	0.0302587650935493	\N	194369.68271606468	1.000017520807443	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-21T00:00:00.000Z	morpho-api	0.03014392575551028	\N	194369.87156553974	1.0000183466832293	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-22T00:00:00.000Z	morpho-api	0.030029786657337354	\N	195687.8307501226	1.00001916943699	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-23T00:00:00.000Z	morpho-api	0.02991704803889661	\N	195657.3886970203	1.000019989093964	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-24T00:00:00.000Z	morpho-api	0.02996606482952302	\N	193750.81907056228	1.000020810104791	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-25T00:00:00.000Z	morpho-api	0.030128520478456267	\N	192487.0937755256	1.0000216355587794	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-26T00:00:00.000Z	morpho-api	12.930019458323727	\N	193504.83478371464	1.0000224552514976	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-27T00:00:00.000Z	morpho-api	12.869928374215078	\N	194393.4099829251	1.0000233520318946	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-28T00:00:00.000Z	morpho-api	12.86899985615264	\N	194342.8791339445	1.0000242397570267	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-29T00:00:00.000Z	morpho-api	12.806878076432326	\N	194088.4064965472	1.0000251213201026	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-09-30T00:00:00.000Z	morpho-api	12.806639994877855	\N	194655.50424162621	1.000025995799448	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-01T00:00:00.000Z	morpho-api	0	\N	0.999980999311826	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-02T00:00:00.000Z	morpho-api	0	\N	0.99961854867496	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-03T00:00:00.000Z	morpho-api	0	\N	0.9995670043018463	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-04T00:00:00.000Z	morpho-api	0	\N	0.9997604629608813	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-05T00:00:00.000Z	morpho-api	0	\N	1.0000068962224338	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-06T00:00:00.000Z	morpho-api	0	\N	0.9998983022510055	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-07T00:00:00.000Z	morpho-api	0	\N	0.9999945686551331	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-08T00:00:00.000Z	morpho-api	0	\N	0.9996219065055056	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-09T00:00:00.000Z	morpho-api	0	\N	0.9997506386401204	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-10T00:00:00.000Z	morpho-api	0	\N	0.9996916328929855	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-11T00:00:00.000Z	morpho-api	0	\N	0.9997492133948382	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-12T00:00:00.000Z	morpho-api	0	\N	0.9996966120536183	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-13T00:00:00.000Z	morpho-api	0	\N	0.9996982592332557	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-14T00:00:00.000Z	morpho-api	0	\N	0.9997166059498648	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-15T00:00:00.000Z	morpho-api	0	\N	0.9997206136490627	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-16T00:00:00.000Z	morpho-api	0	\N	0.9999294454334392	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-17T00:00:00.000Z	morpho-api	0	\N	0.9999751448435259	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-18T00:00:00.000Z	morpho-api	0	\N	0.999756286273694	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-19T00:00:00.000Z	morpho-api	0	\N	1.000180760414373	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-20T00:00:00.000Z	morpho-api	0	\N	0.9999314620576348	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-21T00:00:00.000Z	morpho-api	0	\N	0.9999953682604732	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-22T00:00:00.000Z	morpho-api	0	\N	0.9998713347546603	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-23T00:00:00.000Z	morpho-api	0	\N	0.9999240598014387	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-24T00:00:00.000Z	morpho-api	0	\N	0.9999846623314876	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-25T00:00:00.000Z	morpho-api	0	\N	0.999908526865942	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-26T00:00:00.000Z	morpho-api	0	\N	0.9999430554185886	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-27T00:00:00.000Z	morpho-api	0	\N	0.9999034370004497	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-28T00:00:00.000Z	morpho-api	0	\N	1.0000036937909238	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-29T00:00:00.000Z	morpho-api	0	\N	1.0000262675391618	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-09-30T00:00:00.000Z	morpho-api	0	\N	0.9999008770271004	1	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-12T00:00:00.000Z	morpho-api	\N	\N	291.9027543395161	1.0000953722076715	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-13T00:00:00.000Z	morpho-api	6.031483175306107	\N	291.3767385202751	1.0002606477367078	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-14T00:00:00.000Z	morpho-api	6.867851772085487	\N	291.2600346357946	1.0004488748176197	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-15T00:00:00.000Z	morpho-api	7.876284709240622	\N	290.9866700541298	1.0006647835999178	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-16T00:00:00.000Z	morpho-api	9.02023156648113	\N	289.56889436002655	1.0009121080838006	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-17T00:00:00.000Z	morpho-api	10.138271649395847	\N	288.19528974509	1.0011901609059688	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-18T00:00:00.000Z	morpho-api	11.92283925028903	\N	302.67272918067755	1.0015172562315673	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-19T00:00:00.000Z	morpho-api	13.687562753617044	\N	284.7831092467218	1.0018928973438095	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-20T00:00:00.000Z	morpho-api	15.718366202222	\N	283.23916198355795	1.0023244455790594	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-21T00:00:00.000Z	morpho-api	18.2241913687875	\N	283.3173714200065	1.0028250240366825	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-22T00:00:00.000Z	morpho-api	20.85872692489943	\N	283.47250592722384	1.0033982742138003	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-23T00:00:00.000Z	morpho-api	24.741176752129945	\N	286.25395872504697	1.004078648722317	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-24T00:00:00.000Z	morpho-api	27.90201119111657	\N	285.81744942047	1.0048464987126249	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-25T00:00:00.000Z	morpho-api	32.2289592805447	\N	285.43790664077756	1.0057341551193713	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-26T00:00:00.000Z	morpho-api	38.14168667624074	\N	287.9862245175199	1.006785674197917	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-27T00:00:00.000Z	morpho-api	41.99730191132289	\N	287.7322824851786	1.0079447595762743	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-28T00:00:00.000Z	morpho-api	47.09074586273232	\N	287.61735919735014	1.0092460062085018	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-29T00:00:00.000Z	morpho-api	54.21189540157911	\N	287.3773855249057	1.0107461100417845	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-09-30T00:00:00.000Z	morpho-api	62.79235672543848	\N	288.64803658224815	1.0124864320520475	assets_per_share
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
