-- Generated from VAULT_LLAMA/solana/2026-04.ndjson (117 vault rows)
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
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-03T23:00:00.000Z	defillama-api	9.719022636289765	\N	131801112	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-04T23:00:00.000Z	defillama-api	9.716436650464289	\N	131977480	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-05T23:00:00.000Z	defillama-api	9.713850664638812	\N	132214793	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-06T23:00:00.000Z	defillama-api	9.711264678813336	\N	132453176	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-07T23:00:00.000Z	defillama-api	9.708677992747994	\N	132508558	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-08T23:00:00.000Z	defillama-api	9.706101110040777	\N	131793427	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-09T23:00:00.000Z	defillama-api	9.703514423975435	\N	132546647	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-10T23:00:00.000Z	defillama-api	9.700936841028351	\N	133623681	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-11T23:00:00.000Z	defillama-api	9.698359958321134	\N	135177085	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-12T23:00:00.000Z	defillama-api	9.695782375374051	\N	134334038	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-13T23:00:00.000Z	defillama-api	9.693213895545227	\N	133335807	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-14T23:00:00.000Z	defillama-api	9.690636312598144	\N	136240504	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-15T23:00:00.000Z	defillama-api	9.688067132529454	\N	136863551	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-16T23:00:00.000Z	defillama-api	9.685489549582371	\N	139988990	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-17T23:00:00.000Z	defillama-api	9.682921069753547	\N	148314441	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-18T23:00:00.000Z	defillama-api	9.680360992803116	\N	150182119	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-19T23:00:00.000Z	defillama-api	9.677791812734426	\N	148097508	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-20T23:00:00.000Z	defillama-api	9.675223332905603	\N	143573747	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-21T23:00:00.000Z	defillama-api	9.672663255955172	\N	141611206	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-22T23:00:00.000Z	defillama-api	9.670094075886482	\N	141682795	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-23T23:00:00.000Z	defillama-api	9.667533998936051	\N	140546259	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-24T23:00:00.000Z	defillama-api	9.66497392198562	\N	141354479	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-25T23:00:00.000Z	defillama-api	9.662422247913582	\N	141541812	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-26T23:00:00.000Z	defillama-api	9.659862170963152	\N	141601927	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-27T23:00:00.000Z	defillama-api	9.65730209401272	\N	141697830	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-28T23:00:00.000Z	defillama-api	9.654750419940683	\N	142147210	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-29T23:00:00.000Z	defillama-api	9.652198745868645	\N	143665092	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-04-30T23:00:00.000Z	defillama-api	9.649647772036474	\N	142763135	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-01T23:00:00.000Z	defillama-api	9.546061988885413	\N	116142	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-02T23:00:00.000Z	defillama-api	9.415232673504192	\N	123208	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-03T23:00:00.000Z	defillama-api	9.304734822634941	\N	126218	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-04T23:00:00.000Z	defillama-api	9.304580069624535	\N	126219	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-05T23:00:00.000Z	defillama-api	9.3062473407457	\N	126219	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-06T23:00:00.000Z	defillama-api	6.365118761664235	\N	126369	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-07T23:00:00.000Z	defillama-api	9.942869014523126	\N	126407	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-08T23:00:00.000Z	defillama-api	8.97631882423866	\N	126442	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-09T23:00:00.000Z	defillama-api	9.661387293391499	\N	160757	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-10T23:00:00.000Z	defillama-api	11.30869597645301	\N	160803	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-11T23:00:00.000Z	defillama-api	12.297027127772253	\N	220498	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-12T23:00:00.000Z	defillama-api	12.299520681935405	\N	220498	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-13T23:00:00.000Z	defillama-api	6.370842522329667	\N	220702	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-14T23:00:00.000Z	defillama-api	9.492892775853079	\N	210791	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-15T23:00:00.000Z	defillama-api	9.321334708900508	\N	226264	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-16T23:00:00.000Z	defillama-api	9.758712932139701	\N	226333	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-17T23:00:00.000Z	defillama-api	9.70617393498685	\N	226405	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-18T23:00:00.000Z	defillama-api	11.261557229147456	\N	226459	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-19T23:00:00.000Z	defillama-api	11.261557229147456	\N	226459	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-20T23:00:00.000Z	defillama-api	7.580852809496719	\N	226672	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-21T23:00:00.000Z	defillama-api	11.326868601457818	\N	226674	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-22T23:00:00.000Z	defillama-api	7.7147687822076705	\N	226563	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-23T23:00:00.000Z	defillama-api	9.419382995190517	\N	226890	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-24T23:00:00.000Z	defillama-api	10.057104745797574	\N	226960	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-25T23:00:00.000Z	defillama-api	11.390441278180674	\N	227011	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-26T23:00:00.000Z	defillama-api	11.391056789022969	\N	227011	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-27T23:00:00.000Z	defillama-api	7.009679755043408	\N	227219	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-28T23:00:00.000Z	defillama-api	11.929681994260477	\N	227289	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-29T23:00:00.000Z	defillama-api	15.72260335365172	\N	227359	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-04-30T23:00:00.000Z	defillama-api	10.204210436626227	\N	227686	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-02T23:00:00.000Z	defillama-api	7.143245607821314	\N	375191852	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-03T23:00:00.000Z	defillama-api	7.384415220101914	\N	364475305	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-04T23:00:00.000Z	defillama-api	7.384025186496501	\N	366806643	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-05T23:00:00.000Z	defillama-api	7.391687211111275	\N	359528830	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-06T23:00:00.000Z	defillama-api	7.4845005041623835	\N	354021761	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-07T23:00:00.000Z	defillama-api	7.48595770332372	\N	361679890	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-08T23:00:00.000Z	defillama-api	7.5224254953099035	\N	358657936	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-09T23:00:00.000Z	defillama-api	6.870809585279858	\N	356920071	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-10T23:00:00.000Z	defillama-api	6.907008485157462	\N	353468180	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-11T23:00:00.000Z	defillama-api	6.85863521496799	\N	358042325	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-12T23:00:00.000Z	defillama-api	6.858775262941208	\N	358412016	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-13T23:00:00.000Z	defillama-api	6.885904656073194	\N	356517241	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-14T23:00:00.000Z	defillama-api	6.911338768489372	\N	352979373	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-15T23:00:00.000Z	defillama-api	6.9014457796612305	\N	351999750	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-16T23:00:00.000Z	defillama-api	6.808771834343474	\N	360865355	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-17T23:00:00.000Z	defillama-api	6.674551957530639	\N	366528498	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-18T23:00:00.000Z	defillama-api	6.606008277998399	\N	367788152	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-19T23:00:00.000Z	defillama-api	6.608535443675123	\N	366787446	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-20T23:00:00.000Z	defillama-api	6.697720093740145	\N	360827503	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-21T23:00:00.000Z	defillama-api	6.80896790150598	\N	350845302	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-22T23:00:00.000Z	defillama-api	6.9411220707138455	\N	340188930	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-23T23:00:00.000Z	defillama-api	6.967437084881567	\N	335513022	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-24T23:00:00.000Z	defillama-api	7.038744611165271	\N	331674288	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-25T23:00:00.000Z	defillama-api	7.037384045105455	\N	331778577	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-26T23:00:00.000Z	defillama-api	7.041214357172976	\N	331608251	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-27T23:00:00.000Z	defillama-api	7.092796826668746	\N	326312377	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-28T23:00:00.000Z	defillama-api	7.075385362398379	\N	326384406	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-29T23:00:00.000Z	defillama-api	7.074546475038801	\N	326453910	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-04-30T23:00:00.000Z	defillama-api	7.070903827255393	\N	326264652	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-01T23:00:00.000Z	defillama-api	5.646879930054638	\N	168528691	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-02T23:00:00.000Z	defillama-api	5.646879930054638	\N	164194000	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-03T23:00:00.000Z	defillama-api	5.646879930054638	\N	166362788	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-04T23:00:00.000Z	defillama-api	5.646879930054638	\N	168114759	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-05T23:00:00.000Z	defillama-api	5.646879930054638	\N	166431665	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-06T23:00:00.000Z	defillama-api	5.646879930054638	\N	167007772	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-07T23:00:00.000Z	defillama-api	5.646879930054638	\N	175555774	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-08T23:00:00.000Z	defillama-api	5.646879930054638	\N	171963783	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-09T23:00:00.000Z	defillama-api	5.646879930054638	\N	175300950	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-10T23:00:00.000Z	defillama-api	5.646879930054638	\N	176581974	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-11T23:00:00.000Z	defillama-api	5.646879930054638	\N	178525832	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-12T23:00:00.000Z	defillama-api	5.646879930054638	\N	171746592	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-13T23:00:00.000Z	defillama-api	5.646879930054638	\N	181521298	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-14T23:00:00.000Z	defillama-api	5.646879930054638	\N	175170334	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-15T23:00:00.000Z	defillama-api	5.646879930054638	\N	179148635	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-16T23:00:00.000Z	defillama-api	5.646879930054638	\N	186901386	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-17T23:00:00.000Z	defillama-api	5.646879930054638	\N	184061982	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-18T23:00:00.000Z	defillama-api	5.646879930054638	\N	177595694	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-19T23:00:00.000Z	defillama-api	5.646879930054638	\N	172515229	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-20T23:00:00.000Z	defillama-api	5.646879930054638	\N	174677914	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-21T23:00:00.000Z	defillama-api	5.646879930054638	\N	173847969	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-22T23:00:00.000Z	defillama-api	5.646879930054638	\N	178375018	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-23T23:00:00.000Z	defillama-api	5.646879930054638	\N	175134335	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-24T23:00:00.000Z	defillama-api	5.646879930054638	\N	175101997	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-25T23:00:00.000Z	defillama-api	5.646879930054638	\N	174942086	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-26T23:00:00.000Z	defillama-api	5.646879930054638	\N	175980273	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-27T23:00:00.000Z	defillama-api	5.646879930054638	\N	171856896	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-28T23:00:00.000Z	defillama-api	5.646879930054638	\N	170248081	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-29T23:00:00.000Z	defillama-api	5.646879930054638	\N	169024458	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-04-30T23:00:00.000Z	defillama-api	5.646879930054638	\N	167481197	\N	\N
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
