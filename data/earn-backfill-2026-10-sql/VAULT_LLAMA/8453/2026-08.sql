-- Generated from VAULT_LLAMA/8453/2026-08.ndjson (163 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-01T23:00:00.000Z	defillama-api	18.337266802603835	\N	907416	1.14812	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-02T23:00:00.000Z	defillama-api	18.337266802603835	\N	891261	1.14812	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-03T23:00:00.000Z	defillama-api	18.337109248633965	\N	885687	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-04T23:00:00.000Z	defillama-api	18.337109248633965	\N	848144	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-05T23:00:00.000Z	defillama-api	18.337109248633965	\N	841786	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-06T23:00:00.000Z	defillama-api	18.337109248633965	\N	812676	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-07T23:00:00.000Z	defillama-api	18.337109248633965	\N	807734	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-08T23:00:00.000Z	defillama-api	18.337109248633965	\N	810506	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-09T23:00:00.000Z	defillama-api	18.337109248633965	\N	797942	1.15217	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-10T23:00:00.000Z	defillama-api	18.337325622752587	\N	793100	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-11T23:00:00.000Z	defillama-api	18.337325622752587	\N	764275	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-12T23:00:00.000Z	defillama-api	18.337325622752587	\N	763851	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-13T23:00:00.000Z	defillama-api	18.337325622752587	\N	753838	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-14T23:00:00.000Z	defillama-api	18.337325622752587	\N	705137	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-15T23:00:00.000Z	defillama-api	18.337325622752587	\N	732515	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-16T23:00:00.000Z	defillama-api	18.337325622752587	\N	721897	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-17T21:00:00.000Z	defillama-api	\N	\N	744437	1.15623	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-18T23:00:00.000Z	defillama-api	18.35381487111931	\N	693913	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-19T23:00:00.000Z	defillama-api	18.35381487111931	\N	702312	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-20T23:00:00.000Z	defillama-api	18.35381487111931	\N	718319	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-21T23:00:00.000Z	defillama-api	18.35381487111931	\N	757435	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-22T23:00:00.000Z	defillama-api	18.35381487111931	\N	743854	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-23T23:00:00.000Z	defillama-api	18.35381487111931	\N	758082	1.16031	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-24T23:00:00.000Z	defillama-api	18.339689632540512	\N	758444	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-25T23:00:00.000Z	defillama-api	18.339689632540512	\N	693716	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-26T23:00:00.000Z	defillama-api	18.339689632540512	\N	685990	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-27T23:00:00.000Z	defillama-api	18.339689632540512	\N	692652	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-28T23:00:00.000Z	defillama-api	18.339689632540512	\N	737771	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-29T23:00:00.000Z	defillama-api	18.339689632540512	\N	723908	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-30T23:00:00.000Z	defillama-api	18.339689632540512	\N	729385	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-08-31T23:00:00.000Z	defillama-api	\N	\N	712523	1.16439	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-24T23:00:00.000Z	defillama-api	177.48570385549556	\N	5839	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-25T23:00:00.000Z	defillama-api	70.84925920501917	\N	29366	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-26T23:00:00.000Z	defillama-api	42.751253676343026	\N	62102	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-27T23:00:00.000Z	defillama-api	32.09012832421365	\N	97828	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-28T23:00:00.000Z	defillama-api	31.464912157375124	\N	102461	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-29T23:00:00.000Z	defillama-api	28.780076971202107	\N	117418	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-30T23:00:00.000Z	defillama-api	28.551279897115478	\N	119123	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-08-31T23:00:00.000Z	defillama-api	27.654417578304447	\N	123016	1	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-01T23:00:00.000Z	defillama-api	0.8055664455497435	\N	356742	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-02T23:00:00.000Z	defillama-api	0.793771605245297	\N	360012	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-03T23:00:00.000Z	defillama-api	0.7723792773361993	\N	361110	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-04T23:00:00.000Z	defillama-api	0.7382082721107963	\N	368181	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-05T23:00:00.000Z	defillama-api	0.7232679543278664	\N	370182	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-06T23:00:00.000Z	defillama-api	0.7095068404794347	\N	368707	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-07T23:00:00.000Z	defillama-api	0.6976209689923962	\N	384280	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-08T23:00:00.000Z	defillama-api	0.7074019194419634	\N	394176	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-09T23:00:00.000Z	defillama-api	0.6921689013950072	\N	395010	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-10T23:00:00.000Z	defillama-api	0.6942248056418521	\N	388040	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-11T23:00:00.000Z	defillama-api	0.6996271562087486	\N	389568	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-12T23:00:00.000Z	defillama-api	0.6749570054864762	\N	397962	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-13T23:00:00.000Z	defillama-api	0.6872532175350443	\N	398744	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-14T23:00:00.000Z	defillama-api	0.6494864805972611	\N	400835	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-15T23:00:00.000Z	defillama-api	0.6758512117954751	\N	388051	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-16T23:00:00.000Z	defillama-api	0.6923775728751025	\N	407284	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-17T23:00:00.000Z	defillama-api	0.6958829736447569	\N	418761	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-18T23:00:00.000Z	defillama-api	0.6581890616530472	\N	431423	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-19T23:00:00.000Z	defillama-api	1.0480784176536417	\N	320256	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-20T23:00:00.000Z	defillama-api	1.0354208818341704	\N	291170	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-21T23:00:00.000Z	defillama-api	1.026968286410579	\N	314455	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-22T23:00:00.000Z	defillama-api	1.041092124509646	\N	300752	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-23T23:00:00.000Z	defillama-api	0.986458709917315	\N	363999	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-24T23:00:00.000Z	defillama-api	0.9437524809641218	\N	422800	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-25T23:00:00.000Z	defillama-api	0.9032681131060372	\N	440407	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-26T23:00:00.000Z	defillama-api	0.9246912515692429	\N	409272	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-27T23:00:00.000Z	defillama-api	1.1940924345310577	\N	75009	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-28T23:00:00.000Z	defillama-api	1.2471608130226741	\N	72605	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-29T23:00:00.000Z	defillama-api	1.2234058758053834	\N	72645	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-30T23:00:00.000Z	defillama-api	1.221429798903273	\N	72866	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-08-31T23:00:00.000Z	defillama-api	1.1962267656429049	\N	72961	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-01T23:00:00.000Z	defillama-api	5.683816882751103	\N	1044502	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-02T23:00:00.000Z	defillama-api	5.639724879102914	\N	1042641	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-03T23:00:00.000Z	defillama-api	5.602365681767196	\N	992378	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-04T23:00:00.000Z	defillama-api	5.4707668027731415	\N	874281	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-05T23:00:00.000Z	defillama-api	5.400653185461124	\N	872934	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-06T23:00:00.000Z	defillama-api	5.3181460227591515	\N	1282857	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-07T23:00:00.000Z	defillama-api	5.502790872569108	\N	899766	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-08T23:00:00.000Z	defillama-api	5.598167043530111	\N	851465	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-09T23:00:00.000Z	defillama-api	5.556222675551226	\N	816426	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-10T23:00:00.000Z	defillama-api	5.558937505512063	\N	794822	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-11T23:00:00.000Z	defillama-api	5.569512527969778	\N	795987	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-12T23:00:00.000Z	defillama-api	5.490126334350975	\N	800345	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-13T23:00:00.000Z	defillama-api	5.356095522301985	\N	798346	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-14T23:00:00.000Z	defillama-api	5.202160392059341	\N	797447	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-15T23:00:00.000Z	defillama-api	5.242469699950902	\N	796162	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-16T23:00:00.000Z	defillama-api	5.202359960421177	\N	795665	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-17T23:00:00.000Z	defillama-api	5.17700077367067	\N	795840	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-18T23:00:00.000Z	defillama-api	5.016360146470333	\N	795078	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-19T23:00:00.000Z	defillama-api	4.998031367975386	\N	799699	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-20T23:00:00.000Z	defillama-api	5.021600741628163	\N	799057	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-21T23:00:00.000Z	defillama-api	5.068322846213391	\N	854827	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-22T23:00:00.000Z	defillama-api	5.072619518031729	\N	873053	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-23T23:00:00.000Z	defillama-api	5.185109551320011	\N	836956	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-24T23:00:00.000Z	defillama-api	5.162756494314635	\N	878558	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-25T23:00:00.000Z	defillama-api	5.2489315134351955	\N	815335	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-26T23:00:00.000Z	defillama-api	5.244898832046374	\N	840039	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-27T23:00:00.000Z	defillama-api	5.179203728289394	\N	988755	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-28T23:00:00.000Z	defillama-api	5.323579183880156	\N	800219	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-29T23:00:00.000Z	defillama-api	5.30386533093008	\N	800701	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-30T23:00:00.000Z	defillama-api	5.362076270998273	\N	783615	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-08-31T23:00:00.000Z	defillama-api	5.356313296900339	\N	782306	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-01T23:00:00.000Z	defillama-api	2.7102489916330796	\N	275935	1.00625	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-02T23:00:00.000Z	defillama-api	2.6613204312297967	\N	285409	1.00628	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-03T23:00:00.000Z	defillama-api	2.6351531676738205	\N	281249	1.00632	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-04T23:00:00.000Z	defillama-api	2.554834254553384	\N	271397	1.00635	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-05T23:00:00.000Z	defillama-api	2.515309215311845	\N	274065	1.00638	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-06T23:00:00.000Z	defillama-api	2.4834258937289633	\N	275428	1.00641	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-07T23:00:00.000Z	defillama-api	2.474363389382006	\N	276409	1.00645	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-08T23:00:00.000Z	defillama-api	2.504893847543599	\N	277126	1.00648	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-09T23:00:00.000Z	defillama-api	2.478529116345385	\N	281669	1.00651	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-10T23:00:00.000Z	defillama-api	2.502660782610633	\N	270455	1.00655	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-11T23:00:00.000Z	defillama-api	2.5037531568017357	\N	274517	1.00658	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-12T23:00:00.000Z	defillama-api	2.4573776709502226	\N	279947	1.00661	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-13T23:00:00.000Z	defillama-api	2.4452096027971493	\N	281789	1.00664	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-14T23:00:00.000Z	defillama-api	2.377462796232521	\N	280271	1.00668	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-15T23:00:00.000Z	defillama-api	2.432591280410179	\N	272470	1.00671	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-16T23:00:00.000Z	defillama-api	2.4418330461628557	\N	271321	1.00675	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-17T23:00:00.000Z	defillama-api	2.551529822625298	\N	275305	1.00678	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-18T23:00:00.000Z	defillama-api	2.4921270743050172	\N	276179	1.00681	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-19T23:00:00.000Z	defillama-api	2.291708621271482	\N	356818	1.00685	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-20T23:00:00.000Z	defillama-api	2.329993535710173	\N	360532	1.00688	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-21T23:00:00.000Z	defillama-api	2.3550012020479016	\N	322690	1.00692	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-22T23:00:00.000Z	defillama-api	2.3692699897992497	\N	308919	1.00695	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-23T23:00:00.000Z	defillama-api	2.3500000889242756	\N	314681	1.00699	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-24T23:00:00.000Z	defillama-api	2.4069884101862726	\N	317456	1.00702	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-25T23:00:00.000Z	defillama-api	2.4607339206283996	\N	329573	1.00706	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-26T23:00:00.000Z	defillama-api	2.4361828106833627	\N	334853	1.0071	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-27T23:00:00.000Z	defillama-api	1.298482793288258	\N	337573	1.00713	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-28T23:00:00.000Z	defillama-api	2.50568371811255	\N	325321	1.00717	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-29T23:00:00.000Z	defillama-api	2.4835722438609764	\N	326715	1.00721	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-30T23:00:00.000Z	defillama-api	2.479738430594125	\N	328965	1.00724	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-08-31T23:00:00.000Z	defillama-api	2.455475119234052	\N	324904	1.00728	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-01T23:00:00.000Z	defillama-api	7.488610912176341	\N	737945	1.00807	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-02T23:00:00.000Z	defillama-api	6.790057923922177	\N	740194	1.00824	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-03T23:00:00.000Z	defillama-api	6.100487612670236	\N	741269	1.00842	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-04T23:00:00.000Z	defillama-api	6.854442178649833	\N	732989	1.00865	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-05T23:00:00.000Z	defillama-api	6.8475700246040105	\N	743277	1.00886	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-06T23:00:00.000Z	defillama-api	6.557067813517392	\N	743070	1.00905	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-07T23:00:00.000Z	defillama-api	6.451389713646449	\N	1094175	1.0092	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-08T23:00:00.000Z	defillama-api	6.31964658523998	\N	1094526	1.00936	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-09T23:00:00.000Z	defillama-api	6.264995664650996	\N	1096453	1.00954	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-10T23:00:00.000Z	defillama-api	6.31937419193207	\N	1096721	1.0097	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-11T23:00:00.000Z	defillama-api	6.582088784412576	\N	1096840	1.00987	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-12T23:00:00.000Z	defillama-api	5.879131987640562	\N	1118401	1.01006	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-13T23:00:00.000Z	defillama-api	6.337546816936879	\N	1123393	1.01023	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-14T23:00:00.000Z	defillama-api	6.358128267081042	\N	1119658	1.0104	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-15T23:00:00.000Z	defillama-api	6.298653394054554	\N	1118641	1.01057	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-16T23:00:00.000Z	defillama-api	6.259435059874363	\N	1127220	1.01078	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-17T23:00:00.000Z	defillama-api	6.570992783494489	\N	1110921	1.01096	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-18T23:00:00.000Z	defillama-api	6.406772530098692	\N	1111671	1.01114	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-19T23:00:00.000Z	defillama-api	6.159450610354611	\N	1080220	1.01132	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-20T23:00:00.000Z	defillama-api	6.528058976584816	\N	1080806	1.0115	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-21T23:00:00.000Z	defillama-api	4.996556662817397	\N	730929	1.01168	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-22T23:00:00.000Z	defillama-api	6.049331589252915	\N	722686	1.01189	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-23T23:00:00.000Z	defillama-api	5.99682200217444	\N	1080376	1.01202	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-24T23:00:00.000Z	defillama-api	6.244959001122652	\N	1101049	1.01215	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-25T23:00:00.000Z	defillama-api	5.809058984240778	\N	729265	1.01227	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-26T23:00:00.000Z	defillama-api	5.7330353424589475	\N	1099638	1.01237	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-27T23:00:00.000Z	defillama-api	5.909243702362232	\N	746263	1.01252	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-28T23:00:00.000Z	defillama-api	5.689740211778371	\N	744833	1.01268	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-29T23:00:00.000Z	defillama-api	5.521954336984436	\N	744704	1.01281	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-30T23:00:00.000Z	defillama-api	5.64628472616846	\N	735556	1.01293	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-31T23:00:00.000Z	defillama-api	5.7176048567697535	\N	634966	1.01306	assets_per_share
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
