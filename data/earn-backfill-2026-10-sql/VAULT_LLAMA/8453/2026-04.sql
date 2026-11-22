-- Generated from VAULT_LLAMA/8453/2026-04.ndjson (120 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-01T23:00:00.000Z	defillama-api	38.9115513922178	\N	1107067	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-02T23:00:00.000Z	defillama-api	38.9115513922178	\N	1162430	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-03T23:00:00.000Z	defillama-api	24.909118080174153	\N	1202994	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-04T23:00:00.000Z	defillama-api	24.909118080174153	\N	1137016	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-05T23:00:00.000Z	defillama-api	24.909118080174153	\N	1247077	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-06T23:00:00.000Z	defillama-api	24.909118080174153	\N	1441832	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-07T23:00:00.000Z	defillama-api	24.909118080174153	\N	1557020	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-08T23:00:00.000Z	defillama-api	24.909133485451207	\N	1486513	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-09T23:00:00.000Z	defillama-api	49.68010404340362	\N	1494846	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-10T23:00:00.000Z	defillama-api	24.770971958432142	\N	1480114	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-11T23:00:00.000Z	defillama-api	24.770971958432142	\N	1421559	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-12T23:00:00.000Z	defillama-api	24.770971958432142	\N	1380961	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-13T23:00:00.000Z	defillama-api	24.770971958432142	\N	1352370	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-14T23:00:00.000Z	defillama-api	24.770971958432142	\N	1348252	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-15T23:00:00.000Z	defillama-api	50.26634485929549	\N	1352152	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-16T23:00:00.000Z	defillama-api	25.49537220062348	\N	1290773	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-17T23:00:00.000Z	defillama-api	25.49537220062348	\N	1343905	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-18T23:00:00.000Z	defillama-api	25.49537220062348	\N	1335300	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-19T23:00:00.000Z	defillama-api	25.49537220062348	\N	1276052	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-20T23:00:00.000Z	defillama-api	76.739915040136	\N	1277791	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-21T23:00:00.000Z	defillama-api	76.739915040136	\N	1254379	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-22T23:00:00.000Z	defillama-api	59.976184549981326	\N	1276272	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-23T22:00:00.000Z	defillama-api	59.976184549981326	\N	1259760	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-24T23:00:00.000Z	defillama-api	59.976184549981326	\N	1344693	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-25T23:00:00.000Z	defillama-api	59.976184549981326	\N	1383002	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-26T23:00:00.000Z	defillama-api	59.976184549981326	\N	1610205	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-27T23:00:00.000Z	defillama-api	34.41500450698243	\N	1583261	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-28T22:00:00.000Z	defillama-api	34.41500450698243	\N	2203728	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-29T23:00:00.000Z	defillama-api	25.683361396033888	\N	2485660	1.08034	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-04-30T23:00:00.000Z	defillama-api	25.683361396033888	\N	2769858	1.08034	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-01T23:00:00.000Z	defillama-api	0.001800316695721449	\N	143466	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-02T23:00:00.000Z	defillama-api	0.0014999137931681616	\N	137893	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-03T23:00:00.000Z	defillama-api	0.0013997794923170659	\N	137935	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-04T23:00:00.000Z	defillama-api	0.0013997794923170659	\N	139932	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-05T23:00:00.000Z	defillama-api	0.0013997794923170659	\N	134964	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-06T23:00:00.000Z	defillama-api	0.0012996451914659701	\N	136407	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-07T23:00:00.000Z	defillama-api	0.0012996451914659701	\N	140991	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-08T23:00:00.000Z	defillama-api	5.692800960233058	\N	178703	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-09T23:00:00.000Z	defillama-api	5.582034917495093	\N	220856	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-10T23:00:00.000Z	defillama-api	5.340530590558501	\N	210090	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-11T23:00:00.000Z	defillama-api	5.0244437154844945	\N	211549	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-12T23:00:00.000Z	defillama-api	4.945898509944868	\N	204336	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-13T23:00:00.000Z	defillama-api	4.975721725841709	\N	213734	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-14T23:00:00.000Z	defillama-api	4.929051439006571	\N	213090	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-15T23:00:00.000Z	defillama-api	5.038926776634867	\N	214565	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-16T23:00:00.000Z	defillama-api	4.827459938994139	\N	198448	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-17T23:00:00.000Z	defillama-api	4.915609634537077	\N	205772	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-18T23:00:00.000Z	defillama-api	5.389473155759106	\N	201725	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-19T23:00:00.000Z	defillama-api	5.454424604778296	\N	193962	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-20T23:00:00.000Z	defillama-api	5.798405534918061	\N	133529	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-21T23:00:00.000Z	defillama-api	5.89275585447524	\N	134178	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-22T23:00:00.000Z	defillama-api	5.917934379340295	\N	122501	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-23T22:00:00.000Z	defillama-api	6.006182808704352	\N	120475	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-24T23:00:00.000Z	defillama-api	6.328291746626746	\N	120931	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-25T23:00:00.000Z	defillama-api	6.367671135976138	\N	121333	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-26T23:00:00.000Z	defillama-api	7.364963957101622	\N	122643	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-27T23:00:00.000Z	defillama-api	7.223238209164151	\N	120700	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-28T22:00:00.000Z	defillama-api	8.775882865208473	\N	154070	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-29T23:00:00.000Z	defillama-api	10.45808029935813	\N	170917	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-04-30T23:00:00.000Z	defillama-api	10.779626944668053	\N	434818	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-01T23:00:00.000Z	defillama-api	4.267340170827083	\N	2636880	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-02T23:00:00.000Z	defillama-api	4.106132349335212	\N	2609200	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-03T23:00:00.000Z	defillama-api	4.318400261382749	\N	2579866	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-04T23:00:00.000Z	defillama-api	4.276346655984753	\N	2410637	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-05T23:00:00.000Z	defillama-api	4.260248841703174	\N	2342241	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-06T23:00:00.000Z	defillama-api	4.166292056950738	\N	2266670	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-07T23:00:00.000Z	defillama-api	3.916879220966507	\N	2311677	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-08T23:00:00.000Z	defillama-api	9.429566583563087	\N	2309528	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-09T23:00:00.000Z	defillama-api	9.706019181976444	\N	2257795	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-10T23:00:00.000Z	defillama-api	9.468862644368414	\N	2268629	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-11T23:00:00.000Z	defillama-api	9.209656953856893	\N	2219119	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-12T23:00:00.000Z	defillama-api	9.128892688181622	\N	2219613	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-13T23:00:00.000Z	defillama-api	9.186671580252437	\N	2238311	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-14T23:00:00.000Z	defillama-api	9.077336127560898	\N	2200364	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-15T23:00:00.000Z	defillama-api	9.211873213033073	\N	2173164	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-16T23:00:00.000Z	defillama-api	8.983723160582713	\N	2220543	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-17T23:00:00.000Z	defillama-api	9.092394085641331	\N	2119437	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-18T23:00:00.000Z	defillama-api	9.536435791446252	\N	1989175	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-19T23:00:00.000Z	defillama-api	9.745614945444458	\N	1547880	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-20T23:00:00.000Z	defillama-api	10.22142023181516	\N	1416589	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-21T23:00:00.000Z	defillama-api	10.8887495244403	\N	1300710	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-22T23:00:00.000Z	defillama-api	11.102630789139312	\N	1291850	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-23T22:00:00.000Z	defillama-api	11.301854632961295	\N	1281382	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-24T23:00:00.000Z	defillama-api	11.684481801310653	\N	1271808	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-25T23:00:00.000Z	defillama-api	11.794035728840413	\N	1287603	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-26T23:00:00.000Z	defillama-api	12.684504857674028	\N	1280516	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-27T23:00:00.000Z	defillama-api	12.510178742530798	\N	1311399	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-28T22:00:00.000Z	defillama-api	13.801328623941345	\N	1363878	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-29T23:00:00.000Z	defillama-api	14.556965166079294	\N	1505782	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-04-30T23:00:00.000Z	defillama-api	14.802225579657602	\N	1734109	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-01T23:00:00.000Z	defillama-api	1.4280544778699777	\N	908289	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-02T23:00:00.000Z	defillama-api	1.2290168978523752	\N	1094310	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-03T23:00:00.000Z	defillama-api	1.2822442307935944	\N	1089690	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-04T23:00:00.000Z	defillama-api	1.2491655997592943	\N	1101685	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-05T23:00:00.000Z	defillama-api	1.2719759133972275	\N	1111931	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-06T23:00:00.000Z	defillama-api	1.281454360224643	\N	1149833	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-07T23:00:00.000Z	defillama-api	1.1493695147635208	\N	1201785	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-08T23:00:00.000Z	defillama-api	6.812545426981842	\N	1091234	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-09T23:00:00.000Z	defillama-api	6.913960466548019	\N	1094153	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-10T23:00:00.000Z	defillama-api	6.723939875286078	\N	1117717	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-11T23:00:00.000Z	defillama-api	6.489595500980272	\N	1147343	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-12T23:00:00.000Z	defillama-api	6.422547533802003	\N	1097332	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-13T23:00:00.000Z	defillama-api	6.462611057500567	\N	1174093	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-14T23:00:00.000Z	defillama-api	6.327691641061506	\N	922749	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-15T23:00:00.000Z	defillama-api	6.412718967041542	\N	930280	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-16T23:00:00.000Z	defillama-api	6.189591034910791	\N	922308	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-17T23:00:00.000Z	defillama-api	6.275881593609256	\N	881826	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-18T23:00:00.000Z	defillama-api	6.686122721077936	\N	724125	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-19T23:00:00.000Z	defillama-api	6.377138378965697	\N	435802	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-20T23:00:00.000Z	defillama-api	6.492369851329727	\N	233095	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-21T23:00:00.000Z	defillama-api	6.616753458743574	\N	235863	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-22T23:00:00.000Z	defillama-api	6.632813460072384	\N	320501	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-23T22:00:00.000Z	defillama-api	6.553330633352061	\N	344980	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-24T23:00:00.000Z	defillama-api	6.841481438968344	\N	345147	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-25T23:00:00.000Z	defillama-api	6.8535647780976205	\N	375452	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-26T23:00:00.000Z	defillama-api	8.153159552293232	\N	364726	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-27T23:00:00.000Z	defillama-api	8.12164175592045	\N	383950	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-28T22:00:00.000Z	defillama-api	9.692605387101594	\N	383438	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-29T23:00:00.000Z	defillama-api	11.070444263694412	\N	377657	1.00365	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-04-30T23:00:00.000Z	defillama-api	11.422944312045047	\N	370671	1.00366	assets_per_share
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
