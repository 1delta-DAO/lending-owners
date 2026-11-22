-- Generated from VAULT_LLAMA/8453/2026-03.ndjson (116 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-01T23:00:00.000Z	defillama-api	24.944501900847627	\N	488143	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-03T23:00:00.000Z	defillama-api	40.117860211452694	\N	518982	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-04T23:00:00.000Z	defillama-api	40.117860211452694	\N	557820	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-05T23:00:00.000Z	defillama-api	40.117860211452694	\N	507201	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-06T23:00:00.000Z	defillama-api	40.117860211452694	\N	504706	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-07T23:00:00.000Z	defillama-api	40.117860211452694	\N	491595	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-08T23:00:00.000Z	defillama-api	40.117860211452694	\N	484119	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-09T23:00:00.000Z	defillama-api	40.117860211452694	\N	457626	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-12T23:00:00.000Z	defillama-api	42.04758823682653	\N	515294	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-13T23:00:00.000Z	defillama-api	42.04758823682653	\N	547780	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-14T23:00:00.000Z	defillama-api	42.04758823682653	\N	880788	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-15T23:00:00.000Z	defillama-api	42.04758823682653	\N	721709	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-16T23:00:00.000Z	defillama-api	80.92657287335214	\N	653960	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-17T23:00:00.000Z	defillama-api	80.92657287335214	\N	662869	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-18T23:00:00.000Z	defillama-api	80.92657287335214	\N	620368	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-19T23:00:00.000Z	defillama-api	38.87895102501204	\N	641976	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-20T23:00:00.000Z	defillama-api	38.87895102501204	\N	646915	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-21T23:00:00.000Z	defillama-api	38.87895102501204	\N	680909	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-22T23:00:00.000Z	defillama-api	38.87895102501204	\N	668444	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-27T23:00:00.000Z	defillama-api	38.9115513922178	\N	762426	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-28T23:00:00.000Z	defillama-api	38.9115513922178	\N	813269	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-29T23:00:00.000Z	defillama-api	38.9115513922178	\N	784174	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-30T23:00:00.000Z	defillama-api	38.9115513922178	\N	769992	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-03-31T23:00:00.000Z	defillama-api	38.9115513922178	\N	1110152	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-01T23:00:00.000Z	defillama-api	0.004200038716817289	\N	42971	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-02T23:00:00.000Z	defillama-api	0.003899635814264002	\N	45641	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-03T23:00:00.000Z	defillama-api	0.0034997988507257105	\N	44977	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-04T23:00:00.000Z	defillama-api	0.003700067452427902	\N	51935	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-05T23:00:00.000Z	defillama-api	0.0033996645498746147	\N	50851	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-06T23:00:00.000Z	defillama-api	0.0033002304888896106	\N	50435	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-07T23:00:00.000Z	defillama-api	0.003200096188038515	\N	49577	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-08T23:00:00.000Z	defillama-api	0.003200096188038515	\N	48804	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-09T23:00:00.000Z	defillama-api	0.0033002304888896106	\N	52474	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-10T23:00:00.000Z	defillama-api	0.0033002304888896106	\N	53548	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-11T23:00:00.000Z	defillama-api	0.0029998275863363233	\N	54045	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-12T23:00:00.000Z	defillama-api	0.0029998275863363233	\N	53877	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-13T23:00:00.000Z	defillama-api	0.0028002592245002234	\N	19212	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-14T23:00:00.000Z	defillama-api	0.0028996932854852275	\N	19200	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-15T23:00:00.000Z	defillama-api	0.0028996932854852275	\N	19768	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-16T23:00:00.000Z	defillama-api	0.0028002592245002234	\N	20294	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-17T23:00:00.000Z	defillama-api	0.0027001249236491276	\N	20173	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-18T23:00:00.000Z	defillama-api	0.0028002592245002234	\N	19883	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-19T23:00:00.000Z	defillama-api	0.003099961887187419	\N	13383	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-20T23:00:00.000Z	defillama-api	0.003700067452427902	\N	28057	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-21T23:00:00.000Z	defillama-api	0.004200038716817289	\N	47084	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-22T23:00:00.000Z	defillama-api	0.004200038716817289	\N	51186	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-23T23:00:00.000Z	defillama-api	0.004300173017668385	\N	52958	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-24T23:00:00.000Z	defillama-api	0.004899578343042776	\N	100738	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-25T23:00:00.000Z	defillama-api	0.004800144282057772	\N	67765	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-26T23:00:00.000Z	defillama-api	0.004499741379504485	\N	111292	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-27T23:00:00.000Z	defillama-api	0.003899635814264002	\N	138322	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-28T23:00:00.000Z	defillama-api	0.0033002304888896106	\N	152950	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-29T23:00:00.000Z	defillama-api	0.0029998275863363233	\N	151946	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-30T23:00:00.000Z	defillama-api	0.0028002592245002234	\N	153927	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-03-31T23:00:00.000Z	defillama-api	0.001999885057557549	\N	157087	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-01T23:00:00.000Z	defillama-api	2.707903188081673	\N	241634	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-02T23:00:00.000Z	defillama-api	0.8384749182965834	\N	248967	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-04T23:00:00.000Z	defillama-api	4.278550310843343	\N	233617	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-05T23:00:00.000Z	defillama-api	4.470850883109279	\N	233627	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-06T23:00:00.000Z	defillama-api	4.418241861969818	\N	237481	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-07T23:00:00.000Z	defillama-api	4.204364798710003	\N	232834	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-08T23:00:00.000Z	defillama-api	5.286755670041998	\N	226374	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-09T23:00:00.000Z	defillama-api	5.626028887562029	\N	229675	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-10T23:00:00.000Z	defillama-api	6.875337336254006	\N	232822	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-11T23:00:00.000Z	defillama-api	2.2159650754360882	\N	233155	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-12T23:00:00.000Z	defillama-api	2.2469653945478285	\N	233195	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-13T23:00:00.000Z	defillama-api	2.0959803748610284	\N	233294	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-14T23:00:00.000Z	defillama-api	2.1061639632335982	\N	234697	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-15T23:00:00.000Z	defillama-api	2.1579481018108027	\N	250366	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-16T23:00:00.000Z	defillama-api	3.442365176908879	\N	262063	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-17T23:00:00.000Z	defillama-api	3.52522736122296	\N	270503	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-18T23:00:00.000Z	defillama-api	3.6548879762676734	\N	391827	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-19T23:00:00.000Z	defillama-api	3.51933834394913	\N	517097	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-20T23:00:00.000Z	defillama-api	3.503504520097067	\N	761560	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-21T23:00:00.000Z	defillama-api	3.529088483844589	\N	992568	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-22T23:00:00.000Z	defillama-api	3.700190694644334	\N	1200499	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-23T23:00:00.000Z	defillama-api	3.834918245360086	\N	1251393	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-24T23:00:00.000Z	defillama-api	3.891585856763413	\N	1326677	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-25T23:00:00.000Z	defillama-api	3.6211385154416575	\N	2487762	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-26T23:00:00.000Z	defillama-api	3.698745399560721	\N	2112624	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-27T23:00:00.000Z	defillama-api	3.73478044330966	\N	2323553	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-28T23:00:00.000Z	defillama-api	3.8641700655261957	\N	2190705	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-29T23:00:00.000Z	defillama-api	3.796126357258345	\N	1952419	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-30T23:00:00.000Z	defillama-api	3.9514899768278156	\N	2065943	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-03-31T23:00:00.000Z	defillama-api	3.925051720443662	\N	2094655	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-01T23:00:00.000Z	defillama-api	2.0929441348016553	\N	243392	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-02T23:00:00.000Z	defillama-api	2.0888309258282334	\N	157307	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-03T23:00:00.000Z	defillama-api	2.037599276505375	\N	152109	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-04T23:00:00.000Z	defillama-api	1.9548673368063874	\N	163228	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-05T23:00:00.000Z	defillama-api	1.8932644348268468	\N	159691	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-06T23:00:00.000Z	defillama-api	1.8772688555657169	\N	153732	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-07T23:00:00.000Z	defillama-api	1.8456621287299413	\N	152957	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-08T23:00:00.000Z	defillama-api	1.7779013173679914	\N	151099	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-09T23:00:00.000Z	defillama-api	0.4083651848674208	\N	155691	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-10T23:00:00.000Z	defillama-api	0.39691136137776084	\N	157586	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-11T23:00:00.000Z	defillama-api	3.6081175551316846	\N	160307	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-12T23:00:00.000Z	defillama-api	3.529378383149151	\N	160482	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-13T23:00:00.000Z	defillama-api	2.9001365373204635	\N	162607	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-14T23:00:00.000Z	defillama-api	2.8313365699972337	\N	174748	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-15T23:00:00.000Z	defillama-api	2.7768852177700865	\N	401247	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-16T23:00:00.000Z	defillama-api	3.982437777949599	\N	436544	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-17T23:00:00.000Z	defillama-api	3.9898365123747226	\N	435768	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-18T23:00:00.000Z	defillama-api	0.7799502707683814	\N	530085	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-19T23:00:00.000Z	defillama-api	0.7456133086947148	\N	515586	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-20T23:00:00.000Z	defillama-api	1.286094149577366	\N	629057	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-21T23:00:00.000Z	defillama-api	1.3324829399863347	\N	692841	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-22T23:00:00.000Z	defillama-api	1.3672106359052805	\N	707109	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-23T23:00:00.000Z	defillama-api	1.356754654224801	\N	734580	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-24T23:00:00.000Z	defillama-api	1.3164957636035979	\N	810358	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-25T23:00:00.000Z	defillama-api	1.2186442447159607	\N	789905	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-26T23:00:00.000Z	defillama-api	1.2987299779609884	\N	835479	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-27T23:00:00.000Z	defillama-api	1.2463016187069798	\N	767042	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-28T23:00:00.000Z	defillama-api	1.2356341645869406	\N	776926	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-29T23:00:00.000Z	defillama-api	1.2276339241168444	\N	767942	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-30T23:00:00.000Z	defillama-api	1.3337657794210145	\N	810284	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-03-31T23:00:00.000Z	defillama-api	1.3596151340777851	\N	793568	\N	\N
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
