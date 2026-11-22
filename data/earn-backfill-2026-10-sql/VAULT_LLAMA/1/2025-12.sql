-- Generated from VAULT_LLAMA/1/2025-12.ndjson (118 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-01T23:00:00.000Z	defillama-api	4.610675479810311	\N	27012916	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-02T23:00:00.000Z	defillama-api	4.565525413724458	\N	28867876	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-03T23:00:00.000Z	defillama-api	4.5405009416299436	\N	29285827	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-04T23:00:00.000Z	defillama-api	4.449667226680276	\N	28767747	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-05T23:00:00.000Z	defillama-api	4.43148339783761	\N	27292800	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-06T23:00:00.000Z	defillama-api	4.3649255985656055	\N	27412193	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-07T23:00:00.000Z	defillama-api	4.3963677690328495	\N	28194310	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-08T23:00:00.000Z	defillama-api	4.207816281009968	\N	28262987	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-09T23:00:00.000Z	defillama-api	4.364427728020814	\N	29995956	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-10T23:00:00.000Z	defillama-api	4.3712725727118595	\N	29741535	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-11T23:00:00.000Z	defillama-api	4.382988285911438	\N	29454595	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-12T23:00:00.000Z	defillama-api	4.375139297252417	\N	27886347	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-13T23:00:00.000Z	defillama-api	4.2510490903424625	\N	28107168	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-14T23:00:00.000Z	defillama-api	4.171116709628109	\N	27914446	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-15T23:00:00.000Z	defillama-api	4.065660585794717	\N	26401573	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-16T23:00:00.000Z	defillama-api	4.264838914025404	\N	26660325	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-17T23:00:00.000Z	defillama-api	4.243391267166885	\N	25563868	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-18T23:00:00.000Z	defillama-api	3.9867715624808397	\N	25802201	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-19T23:00:00.000Z	defillama-api	3.9318013325129186	\N	26465767	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-20T23:00:00.000Z	defillama-api	3.9874823059449227	\N	26673875	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-21T23:00:00.000Z	defillama-api	3.9955343641651098	\N	26733295	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-22T23:00:00.000Z	defillama-api	3.9273597110422998	\N	27376043	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-23T23:00:00.000Z	defillama-api	3.937906723905371	\N	26398846	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-24T23:00:00.000Z	defillama-api	3.958574303553064	\N	25959175	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-25T23:00:00.000Z	defillama-api	4.008812312505938	\N	26013517	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-26T23:00:00.000Z	defillama-api	3.943655693205983	\N	25997272	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-27T23:00:00.000Z	defillama-api	4.023279968379256	\N	26011434	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-28T23:00:00.000Z	defillama-api	4.011924878710715	\N	26106825	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-29T23:00:00.000Z	defillama-api	3.9897216730366836	\N	27039835	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-30T23:00:00.000Z	defillama-api	3.9973892995703864	\N	26567406	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-12-31T23:00:00.000Z	defillama-api	3.9528358378504436	\N	26950910	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-01T21:00:00.000Z	defillama-api	22.228878568242294	\N	8563492	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-02T21:00:00.000Z	defillama-api	22.76332964363803	\N	8942959	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-03T23:00:00.000Z	defillama-api	22.868131043196627	\N	9668208	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-04T22:00:00.000Z	defillama-api	22.67433825977605	\N	9705120	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-05T22:00:00.000Z	defillama-api	22.70132550421522	\N	9199317	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-06T23:00:00.000Z	defillama-api	22.721150695304004	\N	9185330	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-07T22:00:00.000Z	defillama-api	22.31770749645534	\N	9659543	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-08T21:00:00.000Z	defillama-api	22.236492976546174	\N	10222152	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-09T23:00:00.000Z	defillama-api	22.01885492496558	\N	10399547	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-10T23:00:00.000Z	defillama-api	22.018060852957433	\N	10641590	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-11T22:00:00.000Z	defillama-api	21.967923678545276	\N	9370844	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-12T23:00:00.000Z	defillama-api	21.778104056124903	\N	9327123	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-13T22:00:00.000Z	defillama-api	21.68104170756635	\N	9953022	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-14T23:00:00.000Z	defillama-api	21.582346399640073	\N	9136756	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-15T21:00:00.000Z	defillama-api	21.546172008157782	\N	9247472	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-16T23:00:00.000Z	defillama-api	21.532595757634	\N	9203556	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-17T22:00:00.000Z	defillama-api	21.285318653241347	\N	9097932	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-18T21:00:00.000Z	defillama-api	21.17513030839291	\N	8532725	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-19T22:00:00.000Z	defillama-api	21.21431082962033	\N	8686685	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-20T23:00:00.000Z	defillama-api	21.132001134560596	\N	8826949	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-21T23:00:00.000Z	defillama-api	20.92749468118882	\N	8594096	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-22T21:00:00.000Z	defillama-api	20.820720005687576	\N	9323924	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-23T20:00:00.000Z	defillama-api	20.801975984952037	\N	8915408	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-24T19:00:00.000Z	defillama-api	20.35550234609218	\N	8791170	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-25T21:00:00.000Z	defillama-api	20.142247095833454	\N	9379832	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-26T12:00:00.000Z	defillama-api	19.997317750508614	\N	9368795	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-27T23:00:00.000Z	defillama-api	19.777847871438325	\N	9222678	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-28T23:00:00.000Z	defillama-api	19.703445985186363	\N	9019308	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-29T22:00:00.000Z	defillama-api	20.01642589597452	\N	9244379	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-30T18:00:00.000Z	defillama-api	19.911500553959627	\N	8699167	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-12-31T23:00:00.000Z	defillama-api	19.272888098242902	\N	8290582	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-01T23:00:00.000Z	defillama-api	6.56388534885366	\N	5114	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-02T23:00:00.000Z	defillama-api	8.206272746136278	\N	5114	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-03T23:00:00.000Z	defillama-api	5.079292103715716	\N	5114	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-04T23:00:00.000Z	defillama-api	6.004290060346307	\N	5123	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-05T23:00:00.000Z	defillama-api	11.207253627532054	\N	5123	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-06T23:00:00.000Z	defillama-api	11.283311581067323	\N	8123	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-07T23:00:00.000Z	defillama-api	11.283311581067323	\N	8125	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-08T23:00:00.000Z	defillama-api	10.281170299109021	\N	8130	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-09T23:00:00.000Z	defillama-api	12.749193016503568	\N	8135	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-10T23:00:00.000Z	defillama-api	15.741904765320669	\N	8135	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-11T23:00:00.000Z	defillama-api	6.365747577063985	\N	8135	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-12T23:00:00.000Z	defillama-api	6.910358432676844	\N	8140	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-13T23:00:00.000Z	defillama-api	9.374650272064855	\N	8140	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-14T23:00:00.000Z	defillama-api	9.374650272064855	\N	8140	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-15T23:00:00.000Z	defillama-api	7.313121698615532	\N	8150	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-16T23:00:00.000Z	defillama-api	12.330120463843741	\N	8156	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-17T23:00:00.000Z	defillama-api	14.108402711698886	\N	8159	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-18T23:00:00.000Z	defillama-api	16.70596000096225	\N	23588	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-19T23:00:00.000Z	defillama-api	15.661512327014293	\N	24188	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-20T23:00:00.000Z	defillama-api	15.664488346445182	\N	24188	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-21T23:00:00.000Z	defillama-api	15.664488346445182	\N	32887	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-22T23:00:00.000Z	defillama-api	10.76904982149074	\N	32921	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-23T23:00:00.000Z	defillama-api	12.274448593529996	\N	32950	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-24T23:00:00.000Z	defillama-api	10.46370952764164	\N	32961	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-25T23:00:00.000Z	defillama-api	8.494969738848113	\N	32961	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-26T23:00:00.000Z	defillama-api	9.674042728491372	\N	32983	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-27T23:00:00.000Z	defillama-api	11.926149984375911	\N	32983	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-28T23:00:00.000Z	defillama-api	11.926149984375911	\N	32983	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-29T23:00:00.000Z	defillama-api	6.805884745375579	\N	32989	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-30T23:00:00.000Z	defillama-api	7.124799189028863	\N	33009	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2025-12-31T23:00:00.000Z	defillama-api	8.70250402940087	\N	33525	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-01T23:00:00.000Z	defillama-api	3.3944701705479474	\N	491898170	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-02T23:00:00.000Z	defillama-api	3.5072024868298968	\N	491428398	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-03T23:00:00.000Z	defillama-api	3.4635411306993547	\N	491325871	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-04T23:00:00.000Z	defillama-api	3.3527519800458094	\N	491109066	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-05T23:00:00.000Z	defillama-api	3.299570162695886	\N	492738771	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-06T23:00:00.000Z	defillama-api	3.471848076230799	\N	493200378	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-07T23:00:00.000Z	defillama-api	3.4068329053837942	\N	492860155	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-08T23:00:00.000Z	defillama-api	3.4231751033786395	\N	492322403	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-09T23:00:00.000Z	defillama-api	3.363185554050574	\N	492031196	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-10T17:00:00.000Z	defillama-api	3.295584397378093	\N	491992680	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-17T23:00:00.000Z	defillama-api	3.431804159248486	\N	493614113	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-18T23:00:00.000Z	defillama-api	3.0629780184199262	\N	495411862	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-19T23:00:00.000Z	defillama-api	3.112563403817603	\N	495157986	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-20T23:00:00.000Z	defillama-api	3.239796987486443	\N	495713379	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-21T23:00:00.000Z	defillama-api	3.211795095481307	\N	496765432	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-22T23:00:00.000Z	defillama-api	3.174650171544613	\N	497235009	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-23T23:00:00.000Z	defillama-api	3.188124887287813	\N	496818479	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-24T23:00:00.000Z	defillama-api	3.2300958643816102	\N	497870383	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-25T23:00:00.000Z	defillama-api	3.1955348255507943	\N	497000510	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-26T23:00:00.000Z	defillama-api	3.250271875643307	\N	496856719	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-27T23:00:00.000Z	defillama-api	3.2978286661489165	\N	497063762	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-28T23:00:00.000Z	defillama-api	3.262138840653961	\N	497014906	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-29T23:00:00.000Z	defillama-api	3.260067531130062	\N	497021039	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-30T23:00:00.000Z	defillama-api	3.45790910145638	\N	497227959	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-12-31T23:00:00.000Z	defillama-api	3.4029955909176124	\N	496967189	\N	\N
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
