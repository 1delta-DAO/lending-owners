-- Generated from VAULT_LLAMA/solana/2026-07.ndjson (124 vault rows)
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
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-01T23:00:00.000Z	defillama-api	11.108429475470416	\N	205951995	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-02T23:00:00.000Z	defillama-api	11.105046616677328	\N	209402293	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-03T23:00:00.000Z	defillama-api	11.101672861002498	\N	210694412	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-04T23:00:00.000Z	defillama-api	11.09829910532767	\N	212851218	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-05T23:00:00.000Z	defillama-api	11.094924649412974	\N	213514775	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-06T23:00:00.000Z	defillama-api	11.091550893738145	\N	214528687	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-07T23:00:00.000Z	defillama-api	11.08817643782345	\N	214701643	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-08T23:00:00.000Z	defillama-api	11.084811085027013	\N	214925697	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-09T23:00:00.000Z	defillama-api	11.081445732230577	\N	215498371	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-10T23:00:00.000Z	defillama-api	11.078088782312534	\N	218005078	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-11T23:00:00.000Z	defillama-api	11.074723429516098	\N	219237730	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-12T23:00:00.000Z	defillama-api	11.071366479598055	\N	220544512	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-13T23:00:00.000Z	defillama-api	11.068008829440146	\N	221101421	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-14T23:00:00.000Z	defillama-api	11.064651879522103	\N	219810146	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-15T23:00:00.000Z	defillama-api	11.06129492960406	\N	220171178	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-16T23:00:00.000Z	defillama-api	11.05794638256441	\N	224535836	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-17T23:00:00.000Z	defillama-api	11.05459783552476	\N	229414262	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-18T23:00:00.000Z	defillama-api	11.05124928848511	\N	229629515	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-19T23:00:00.000Z	defillama-api	11.047909144323853	\N	232197631	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-20T23:00:00.000Z	defillama-api	11.044560597284203	\N	233977497	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-21T23:00:00.000Z	defillama-api	11.041220453122946	\N	234724766	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-22T23:00:00.000Z	defillama-api	11.03788030896169	\N	240826108	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-23T23:00:00.000Z	defillama-api	11.034549267918692	\N	243912696	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-24T23:00:00.000Z	defillama-api	11.031208423517569	\N	244024117	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-25T23:00:00.000Z	defillama-api	11.027877382474571	\N	244443660	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-26T23:00:00.000Z	defillama-api	11.024545641191708	\N	245148478	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-27T23:00:00.000Z	defillama-api	11.021223003027103	\N	245462386	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-28T23:00:00.000Z	defillama-api	11.017890561504373	\N	246465093	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-29T23:00:00.000Z	defillama-api	11.014567923339769	\N	247264852	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-30T23:00:00.000Z	defillama-api	11.011244584935298	\N	247373613	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-07-31T23:00:00.000Z	defillama-api	11.007921246530827	\N	245805746	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-01T23:00:00.000Z	defillama-api	9.704657915676762	\N	6598851	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-02T23:00:00.000Z	defillama-api	9.59906734578908	\N	7632067	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-03T23:00:00.000Z	defillama-api	9.62880653290199	\N	7634357	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-04T23:00:00.000Z	defillama-api	10.9172828985038	\N	7609999	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-05T23:00:00.000Z	defillama-api	10.9172828985038	\N	7610834	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-06T23:00:00.000Z	defillama-api	7.134204110670339	\N	7611697	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-07T23:00:00.000Z	defillama-api	9.51091624976641	\N	8815822	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-08T23:00:00.000Z	defillama-api	9.42371467900216	\N	9168158	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-09T23:00:00.000Z	defillama-api	9.152210675722472	\N	11392516	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-10T23:00:00.000Z	defillama-api	12.725104765110018	\N	11395174	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-11T23:00:00.000Z	defillama-api	13.30783527855317	\N	11595059	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-12T23:00:00.000Z	defillama-api	13.30807195962791	\N	11683527	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-13T23:00:00.000Z	defillama-api	8.849052329296114	\N	11991234	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-14T23:00:00.000Z	defillama-api	10.908765180772662	\N	11994676	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-15T23:00:00.000Z	defillama-api	10.78090138122434	\N	11997376	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-16T23:00:00.000Z	defillama-api	9.78154915465268	\N	12000628	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-17T23:00:00.000Z	defillama-api	7.917895062803382	\N	11995156	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-18T23:00:00.000Z	defillama-api	7.596897405548475	\N	11994613	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-19T23:00:00.000Z	defillama-api	7.5389343503928785	\N	12804491	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-20T23:00:00.000Z	defillama-api	6.194835831507817	\N	12007989	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-21T23:00:00.000Z	defillama-api	8.580175625994002	\N	12824569	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-22T23:00:00.000Z	defillama-api	9.879573632787242	\N	12827806	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-23T23:00:00.000Z	defillama-api	9.746159031820412	\N	12831570	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-24T23:00:00.000Z	defillama-api	11.106442894970314	\N	12847340	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-25T23:00:00.000Z	defillama-api	11.179250335047186	\N	12848141	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-26T23:00:00.000Z	defillama-api	11.23730512162524	\N	12848141	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-27T23:00:00.000Z	defillama-api	7.4865795163248094	\N	12862324	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-28T23:00:00.000Z	defillama-api	8.71694997783834	\N	12875149	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-29T23:00:00.000Z	defillama-api	8.818586293202202	\N	12882521	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-30T23:00:00.000Z	defillama-api	9.170596873886439	\N	12886249	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-07-31T23:00:00.000Z	defillama-api	10.581391139297125	\N	12890604	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-01T23:00:00.000Z	defillama-api	5.575499578824861	\N	197026640	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-02T23:00:00.000Z	defillama-api	5.6980534594686105	\N	188890239	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-03T23:00:00.000Z	defillama-api	5.7285313996402465	\N	187405878	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-04T23:00:00.000Z	defillama-api	5.697665526582796	\N	189461451	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-05T23:00:00.000Z	defillama-api	5.716414448997398	\N	187913218	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-06T23:00:00.000Z	defillama-api	6.099876303267138	\N	184597380	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-07T23:00:00.000Z	defillama-api	6.349016045703593	\N	174343028	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-08T23:00:00.000Z	defillama-api	6.268762254890703	\N	170815702	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-09T23:00:00.000Z	defillama-api	6.3127555247177725	\N	171488184	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-10T23:00:00.000Z	defillama-api	6.247439250728348	\N	173328855	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-11T23:00:00.000Z	defillama-api	6.311000023373481	\N	171032194	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-12T23:00:00.000Z	defillama-api	6.316614546619803	\N	170932888	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-13T23:00:00.000Z	defillama-api	6.260871952079583	\N	169983378	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-14T23:00:00.000Z	defillama-api	6.0421681354227985	\N	165223012	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-15T23:00:00.000Z	defillama-api	5.961714776248073	\N	163607774	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-16T23:00:00.000Z	defillama-api	5.911034915939695	\N	162659456	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-17T23:00:00.000Z	defillama-api	5.7762366409974675	\N	162733130	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-18T23:00:00.000Z	defillama-api	5.758905704311701	\N	162902714	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-19T23:00:00.000Z	defillama-api	5.760812457467068	\N	163352199	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-20T23:00:00.000Z	defillama-api	5.56556877704395	\N	166351376	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-21T23:00:00.000Z	defillama-api	5.54091613231833	\N	166505449	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-22T23:00:00.000Z	defillama-api	5.447227539434607	\N	165833879	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-23T23:00:00.000Z	defillama-api	5.160068973708576	\N	164522017	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-24T23:00:00.000Z	defillama-api	5.03035864163337	\N	164561274	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-25T23:00:00.000Z	defillama-api	4.985759664322131	\N	164325583	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-26T23:00:00.000Z	defillama-api	5.013221671390511	\N	164326450	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-27T23:00:00.000Z	defillama-api	4.768555761458515	\N	167592512	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-28T23:00:00.000Z	defillama-api	4.735685101664444	\N	167639889	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-29T23:00:00.000Z	defillama-api	4.679045499855761	\N	167186732	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-30T23:00:00.000Z	defillama-api	4.827479545710389	\N	166371958	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-07-31T23:00:00.000Z	defillama-api	4.697031861056189	\N	165603752	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-01T23:00:00.000Z	defillama-api	5.65457276522352	\N	157976033	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-02T23:00:00.000Z	defillama-api	5.586772740429069	\N	163760536	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-03T23:00:00.000Z	defillama-api	5.586772740429069	\N	167216114	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-04T23:00:00.000Z	defillama-api	5.613455380526489	\N	166185736	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-05T23:00:00.000Z	defillama-api	5.613455380526489	\N	165858947	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-06T23:00:00.000Z	defillama-api	5.668378694423382	\N	167136382	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-07T23:00:00.000Z	defillama-api	5.668378694423382	\N	164632749	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-08T23:00:00.000Z	defillama-api	5.6966459773377665	\N	157452026	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-09T23:00:00.000Z	defillama-api	5.6966459773377665	\N	158565305	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-10T23:00:00.000Z	defillama-api	5.684128489491513	\N	158594134	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-11T23:00:00.000Z	defillama-api	5.684128489491513	\N	157950192	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-12T23:00:00.000Z	defillama-api	5.6745863208362834	\N	155591968	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-13T23:00:00.000Z	defillama-api	5.6745863208362834	\N	151253320	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-14T23:00:00.000Z	defillama-api	5.665033648583062	\N	157749741	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-15T23:00:00.000Z	defillama-api	5.665033648583062	\N	157276369	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-16T23:00:00.000Z	defillama-api	5.664154847551117	\N	153069310	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-17T23:00:00.000Z	defillama-api	5.664154847551117	\N	152236155	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-18T23:00:00.000Z	defillama-api	5.646350548715873	\N	153545742	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-19T23:00:00.000Z	defillama-api	5.646350548715873	\N	154700647	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-20T23:00:00.000Z	defillama-api	5.655678443972079	\N	157212009	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-21T23:00:00.000Z	defillama-api	5.655678443972079	\N	158095912	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-22T23:00:00.000Z	defillama-api	5.678488057370146	\N	158130985	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-23T23:00:00.000Z	defillama-api	5.678488057370146	\N	154105077	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-24T23:00:00.000Z	defillama-api	5.678488057370146	\N	149871296	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-25T23:00:00.000Z	defillama-api	5.63524474443966	\N	150792489	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-26T23:00:00.000Z	defillama-api	5.63524474443966	\N	140220608	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-27T23:00:00.000Z	defillama-api	5.588068184181338	\N	150967500	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-28T23:00:00.000Z	defillama-api	5.588068184181338	\N	148941783	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-29T23:00:00.000Z	defillama-api	5.565946906571639	\N	149586224	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-30T23:00:00.000Z	defillama-api	5.565946906571639	\N	151973041	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-07-31T23:00:00.000Z	defillama-api	5.56276851781945	\N	147886831	\N	\N
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
