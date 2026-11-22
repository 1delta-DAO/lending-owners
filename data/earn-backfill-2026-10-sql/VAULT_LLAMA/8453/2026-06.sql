-- Generated from VAULT_LLAMA/8453/2026-06.ndjson (140 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-01T23:00:00.000Z	defillama-api	\N	\N	1419226	1.10829	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-02T23:00:00.000Z	defillama-api	77.77471761016841	\N	1357473	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-03T23:00:00.000Z	defillama-api	77.77471761016841	\N	1291055	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-04T23:00:00.000Z	defillama-api	77.77471761016841	\N	1129953	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-05T23:00:00.000Z	defillama-api	77.77471761016841	\N	1093736	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-06T23:00:00.000Z	defillama-api	77.77471761016841	\N	1101675	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-07T23:00:00.000Z	defillama-api	77.77471761016841	\N	1134314	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-08T23:00:00.000Z	defillama-api	77.77471761016841	\N	1086096	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-09T23:00:00.000Z	defillama-api	\N	\N	1020370	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-10T23:00:00.000Z	defillama-api	\N	\N	1075094	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-11T23:00:00.000Z	defillama-api	\N	\N	1076913	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-12T23:00:00.000Z	defillama-api	\N	\N	1074567	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-13T23:00:00.000Z	defillama-api	\N	\N	1059524	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-14T23:00:00.000Z	defillama-api	\N	\N	1075964	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-15T23:00:00.000Z	defillama-api	\N	\N	1166958	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-16T23:00:00.000Z	defillama-api	\N	\N	1084360	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-17T23:00:00.000Z	defillama-api	\N	\N	1030268	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-18T23:00:00.000Z	defillama-api	\N	\N	1008029	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-19T23:00:00.000Z	defillama-api	\N	\N	1012955	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-20T23:00:00.000Z	defillama-api	\N	\N	992547	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-21T23:00:00.000Z	defillama-api	\N	\N	996397	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-22T23:00:00.000Z	defillama-api	\N	\N	985082	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-23T23:00:00.000Z	defillama-api	\N	\N	910973	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-24T23:00:00.000Z	defillama-api	\N	\N	842680	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-25T23:00:00.000Z	defillama-api	\N	\N	1707758	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-26T23:00:00.000Z	defillama-api	\N	\N	1055498	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-27T23:00:00.000Z	defillama-api	\N	\N	1146540	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-28T23:00:00.000Z	defillama-api	\N	\N	1012509	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-29T23:00:00.000Z	defillama-api	\N	\N	1034844	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-06-30T23:00:00.000Z	defillama-api	\N	\N	914652	1.12494	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-01T23:00:00.000Z	defillama-api	2.4934435252532694	\N	212972	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-02T23:00:00.000Z	defillama-api	2.667922292687308	\N	197775	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-03T23:00:00.000Z	defillama-api	2.6872089993190684	\N	193354	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-04T23:00:00.000Z	defillama-api	2.398572927475584	\N	189968	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-05T23:00:00.000Z	defillama-api	2.4055046019100246	\N	184010	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-06T23:00:00.000Z	defillama-api	2.479563370627602	\N	180532	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-07T23:00:00.000Z	defillama-api	2.444701928894233	\N	187441	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-08T23:00:00.000Z	defillama-api	2.457777507913761	\N	188534	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-09T23:00:00.000Z	defillama-api	2.2545041769461704	\N	183453	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-10T23:00:00.000Z	defillama-api	2.387393598013432	\N	182668	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-11T23:00:00.000Z	defillama-api	2.351845921211293	\N	175462	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-12T23:00:00.000Z	defillama-api	2.3906154016373193	\N	174420	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-13T23:00:00.000Z	defillama-api	2.363820022921459	\N	176498	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-14T23:00:00.000Z	defillama-api	2.3845135114441973	\N	179207	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-15T23:00:00.000Z	defillama-api	2.70237479433888	\N	236401	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-16T23:00:00.000Z	defillama-api	2.410180103495918	\N	249533	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-17T23:00:00.000Z	defillama-api	2.3090745699505533	\N	264761	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-18T23:00:00.000Z	defillama-api	2.2606536834501867	\N	303856	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-19T23:00:00.000Z	defillama-api	2.274349674991072	\N	306016	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-20T23:00:00.000Z	defillama-api	2.23414610331929	\N	180817	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-21T23:00:00.000Z	defillama-api	2.2263419300116993	\N	170301	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-22T23:00:00.000Z	defillama-api	2.220718303647118	\N	170511	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-23T23:00:00.000Z	defillama-api	2.2272319348815017	\N	165954	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-24T23:00:00.000Z	defillama-api	2.1389702009599887	\N	175005	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-25T23:00:00.000Z	defillama-api	3.970165374056478	\N	172041	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-26T23:00:00.000Z	defillama-api	2.7227734818779936	\N	186360	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-27T23:00:00.000Z	defillama-api	3.0089047957204684	\N	158328	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-28T23:00:00.000Z	defillama-api	0.005519990864399915	\N	160963	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-29T23:00:00.000Z	defillama-api	1.806877243026861	\N	164305	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-06-30T23:00:00.000Z	defillama-api	1.6386502171172879	\N	159710	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-01T23:00:00.000Z	defillama-api	7.938883352309745	\N	2931599	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-02T23:00:00.000Z	defillama-api	7.8562256380365625	\N	2700268	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-03T23:00:00.000Z	defillama-api	7.80517395035929	\N	2642927	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-04T23:00:00.000Z	defillama-api	7.299624575196617	\N	2916614	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-05T23:00:00.000Z	defillama-api	7.116333989287682	\N	2738074	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-06T23:00:00.000Z	defillama-api	7.073018551650989	\N	2911535	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-07T23:00:00.000Z	defillama-api	6.534335226504595	\N	2924364	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-08T23:00:00.000Z	defillama-api	6.499650945457347	\N	2839957	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-09T23:00:00.000Z	defillama-api	6.264535607058974	\N	2849069	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-10T23:00:00.000Z	defillama-api	6.257199193981933	\N	2694840	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-11T23:00:00.000Z	defillama-api	6.286249345066608	\N	2683291	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-12T23:00:00.000Z	defillama-api	6.415447801799701	\N	2312701	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-13T23:00:00.000Z	defillama-api	6.574241896473154	\N	2636180	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-14T23:00:00.000Z	defillama-api	6.70037610355223	\N	2563118	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-15T23:00:00.000Z	defillama-api	7.333902717121532	\N	2626199	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-16T23:00:00.000Z	defillama-api	7.14676501338829	\N	2474471	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-17T23:00:00.000Z	defillama-api	7.140703737107401	\N	2237005	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-18T23:00:00.000Z	defillama-api	7.041829167775404	\N	1832384	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-19T23:00:00.000Z	defillama-api	6.974590735353559	\N	2103537	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-20T23:00:00.000Z	defillama-api	6.73772059585076	\N	1921433	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-21T23:00:00.000Z	defillama-api	6.6384657962714755	\N	2115439	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-22T23:00:00.000Z	defillama-api	6.310521059305074	\N	2138522	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-23T23:00:00.000Z	defillama-api	6.189835418624057	\N	2130265	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-24T23:00:00.000Z	defillama-api	5.9051150881117564	\N	2105798	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-25T23:00:00.000Z	defillama-api	7.684196309654112	\N	2031799	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-26T23:00:00.000Z	defillama-api	6.410298938064329	\N	2103992	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-27T23:00:00.000Z	defillama-api	6.744217421328358	\N	2152775	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-28T23:00:00.000Z	defillama-api	3.5997447870528276	\N	2198452	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-29T23:00:00.000Z	defillama-api	5.408318011035362	\N	2202929	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-06-30T23:00:00.000Z	defillama-api	5.29572784344623	\N	1836459	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-01T23:00:00.000Z	defillama-api	3.1809565317786337	\N	796714	1.00432	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-02T23:00:00.000Z	defillama-api	3.228672976973712	\N	754322	1.00435	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-03T23:00:00.000Z	defillama-api	3.259525545473707	\N	758418	1.00438	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-04T23:00:00.000Z	defillama-api	2.9972310969128557	\N	753146	1.0044	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-05T23:00:00.000Z	defillama-api	3.1675973556133386	\N	688661	1.00443	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-06T23:00:00.000Z	defillama-api	3.2483357124135637	\N	672672	1.00445	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-07T23:00:00.000Z	defillama-api	3.1827680523122126	\N	679712	1.00448	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-08T23:00:00.000Z	defillama-api	3.1187381189567986	\N	689128	1.0045	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-09T23:00:00.000Z	defillama-api	2.9451808671865365	\N	672131	1.00453	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-10T23:00:00.000Z	defillama-api	3.074285491777573	\N	654193	1.00456	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-11T23:00:00.000Z	defillama-api	3.085776427980136	\N	678172	1.00459	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-12T23:00:00.000Z	defillama-api	3.1504092678602547	\N	672042	1.00462	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-13T23:00:00.000Z	defillama-api	3.1745633418012176	\N	680259	1.00465	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-14T23:00:00.000Z	defillama-api	3.2196293791031394	\N	696061	1.00468	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-15T23:00:00.000Z	defillama-api	3.5246097496610673	\N	723748	1.00471	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-16T23:00:00.000Z	defillama-api	3.289933461658734	\N	725749	1.00474	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-17T23:00:00.000Z	defillama-api	3.2119211386572033	\N	704168	1.00477	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-18T23:00:00.000Z	defillama-api	3.152133958650438	\N	686228	1.0048	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-19T23:00:00.000Z	defillama-api	3.1717343727422076	\N	686443	1.00484	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-20T23:00:00.000Z	defillama-api	3.112553600459478	\N	700797	1.00486	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-21T23:00:00.000Z	defillama-api	3.1112742622241285	\N	689949	1.0049	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-22T23:00:00.000Z	defillama-api	3.110634242986521	\N	692461	1.00493	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-23T23:00:00.000Z	defillama-api	3.1271024841572626	\N	668808	1.00496	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-24T23:00:00.000Z	defillama-api	3.063657251090035	\N	649559	1.00499	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-25T23:00:00.000Z	defillama-api	4.800642852842429	\N	630999	1.00502	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-26T23:00:00.000Z	defillama-api	3.6768474984683053	\N	634308	1.00505	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-27T23:00:00.000Z	defillama-api	3.9867617591227145	\N	569559	1.00508	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-28T23:00:00.000Z	defillama-api	1.1310596427449582	\N	560876	1.00511	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-29T23:00:00.000Z	defillama-api	2.7796084506093166	\N	619618	1.00514	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-06-30T23:00:00.000Z	defillama-api	2.638308448510429	\N	594771	1.00517	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-11T22:00:00.000Z	defillama-api	7.73103325357738	\N	55352	1.00023	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-12T23:00:00.000Z	defillama-api	8.154929758674712	\N	163226	1.00029	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-13T23:00:00.000Z	defillama-api	6.946523721040876	\N	166698	1.0004	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-14T23:00:00.000Z	defillama-api	6.069699466237921	\N	168336	1.00054	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-15T23:00:00.000Z	defillama-api	6.817421897409304	\N	170447	1.00063	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-16T23:00:00.000Z	defillama-api	6.832384622867949	\N	297196	1.00082	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-17T23:00:00.000Z	defillama-api	6.74909739295515	\N	306913	1.00095	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-18T23:00:00.000Z	defillama-api	5.110281919229465	\N	301113	1.00106	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-19T23:00:00.000Z	defillama-api	5.588228539110673	\N	303658	1.00118	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-20T23:00:00.000Z	defillama-api	5.5299412728970765	\N	307143	1.00132	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-21T23:00:00.000Z	defillama-api	4.6186302046891115	\N	306143	1.00145	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-22T23:00:00.000Z	defillama-api	5.344445631649819	\N	306013	1.00156	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-23T23:00:00.000Z	defillama-api	4.9440806872524945	\N	305522	1.00164	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-24T23:00:00.000Z	defillama-api	5.226146408432442	\N	447746	1.00177	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-25T23:00:00.000Z	defillama-api	5.073170606806343	\N	447710	1.00184	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-26T23:00:00.000Z	defillama-api	5.022827561873555	\N	451796	1.00203	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-27T23:00:00.000Z	defillama-api	5.0667354024369615	\N	462345	1.0022	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-28T23:00:00.000Z	defillama-api	5.250240961984787	\N	461646	1.00234	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-29T23:00:00.000Z	defillama-api	4.839665820099981	\N	505548	1.00246	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-06-30T23:00:00.000Z	defillama-api	5.539733427184501	\N	632705	1.00248	assets_per_share
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
