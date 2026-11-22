-- Generated from VAULT_LLAMA/solana/2026-08.ndjson (146 vault rows)
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
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-01T23:00:00.000Z	defillama-api	11.004607011244616	\N	246503874	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-02T23:00:00.000Z	defillama-api	11.001283672840145	\N	246957482	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-03T23:00:00.000Z	defillama-api	10.997969437553934	\N	248239205	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-04T23:00:00.000Z	defillama-api	10.994663605146116	\N	248439757	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-05T23:00:00.000Z	defillama-api	10.991348669620038	\N	248361384	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-06T23:00:00.000Z	defillama-api	10.98804283721222	\N	249336266	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-07T23:00:00.000Z	defillama-api	10.984736304564535	\N	247393789	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-08T23:00:00.000Z	defillama-api	10.981430472156717	\N	247501297	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-09T23:00:00.000Z	defillama-api	10.978123939509032	\N	247916471	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-10T23:00:00.000Z	defillama-api	10.974826509979607	\N	250719376	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-11T23:00:00.000Z	defillama-api	10.971529080450182	\N	251731115	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-12T23:00:00.000Z	defillama-api	10.968231650920757	\N	251951908	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-13T23:00:00.000Z	defillama-api	10.964933521151465	\N	254352772	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-14T23:00:00.000Z	defillama-api	10.961644494500433	\N	256524539	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-15T23:00:00.000Z	defillama-api	10.958346364731142	\N	257157468	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-16T23:00:00.000Z	defillama-api	10.95505733808011	\N	257461058	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-17T23:00:00.000Z	defillama-api	10.951777414547337	\N	262674471	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-18T23:00:00.000Z	defillama-api	10.948487687656439	\N	264572659	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-19T23:00:00.000Z	defillama-api	10.9452070638838	\N	266115363	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-20T23:00:00.000Z	defillama-api	10.941927140351027	\N	266710685	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-21T23:00:00.000Z	defillama-api	10.938645816338521	\N	267032430	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-22T23:00:00.000Z	defillama-api	10.935365192565882	\N	267397738	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-23T23:00:00.000Z	defillama-api	10.932092971671636	\N	268979642	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-24T23:00:00.000Z	defillama-api	10.928821451017257	\N	270142153	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-25T23:00:00.000Z	defillama-api	10.92554923012301	\N	270062156	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-26T23:00:00.000Z	defillama-api	10.922277009228765	\N	270624040	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-27T23:00:00.000Z	defillama-api	10.922294515225417	\N	276171010	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-28T23:00:00.000Z	defillama-api	10.922294515225417	\N	277354691	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-29T23:00:00.000Z	defillama-api	10.922294515225417	\N	277468371	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-30T23:00:00.000Z	defillama-api	10.922294515225417	\N	277095955	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-08-31T23:00:00.000Z	defillama-api	10.922294515225417	\N	279840940	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-01T23:00:00.000Z	defillama-api	11.867774487939187	\N	12893379	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-02T23:00:00.000Z	defillama-api	13.09683480066326	\N	12896171	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-03T23:00:00.000Z	defillama-api	8.756938575871231	\N	12901152	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-04T23:00:00.000Z	defillama-api	10.637878789054867	\N	12904951	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-05T23:00:00.000Z	defillama-api	8.995267315015099	\N	12913492	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-06T23:00:00.000Z	defillama-api	9.017200228100819	\N	12916096	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-07T23:00:00.000Z	defillama-api	8.732758593055223	\N	12909653	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-08T23:00:00.000Z	defillama-api	9.153862541566582	\N	12912620	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-09T23:00:00.000Z	defillama-api	9.300361124431333	\N	12915533	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-10T23:00:00.000Z	defillama-api	8.787826856604397	\N	12926236	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-11T23:00:00.000Z	defillama-api	9.28791366057169	\N	12929938	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-12T23:00:00.000Z	defillama-api	9.125387287411968	\N	12933767	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-13T23:00:00.000Z	defillama-api	9.395635760611754	\N	12937607	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-14T23:00:00.000Z	defillama-api	9.352176073562646	\N	12941323	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-15T23:00:00.000Z	defillama-api	9.536917556474123	\N	12944433	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-16T23:00:00.000Z	defillama-api	9.435654468958887	\N	12947400	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-17T23:00:00.000Z	defillama-api	8.634089194003991	\N	12952847	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-18T23:00:00.000Z	defillama-api	9.447737808088164	\N	12955612	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-19T23:00:00.000Z	defillama-api	9.355746596639847	\N	12962260	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-20T23:00:00.000Z	defillama-api	9.362921954547687	\N	12965941	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-21T23:00:00.000Z	defillama-api	9.35881504773306	\N	12969836	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-22T23:00:00.000Z	defillama-api	10.28098963722357	\N	12979498	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-23T23:00:00.000Z	defillama-api	10.024534488906056	\N	13004278	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-24T23:00:00.000Z	defillama-api	9.117199382657759	\N	13010067	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-25T23:00:00.000Z	defillama-api	9.550207408892675	\N	13440070	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-26T23:00:00.000Z	defillama-api	9.617353409652196	\N	13443908	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-27T23:00:00.000Z	defillama-api	9.712516707693908	\N	13447804	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-28T23:00:00.000Z	defillama-api	9.646923838957377	\N	13467924	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-29T23:00:00.000Z	defillama-api	10.04701148836773	\N	13470807	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-30T23:00:00.000Z	defillama-api	9.478476937729852	\N	13470950	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-08-31T23:00:00.000Z	defillama-api	8.769086337068188	\N	13479566	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-01T23:00:00.000Z	defillama-api	4.86203428238241	\N	165486902	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-02T23:00:00.000Z	defillama-api	4.8465064633518296	\N	166747051	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-03T23:00:00.000Z	defillama-api	4.861624642060747	\N	168017363	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-04T23:00:00.000Z	defillama-api	5.042073654593082	\N	168202245	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-05T23:00:00.000Z	defillama-api	4.803749817128278	\N	168531571	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-06T23:00:00.000Z	defillama-api	4.734750281443212	\N	168259861	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-07T23:00:00.000Z	defillama-api	4.770910668128181	\N	167956934	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-08T23:00:00.000Z	defillama-api	4.774838313537089	\N	167849566	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-09T23:00:00.000Z	defillama-api	4.772683675469125	\N	167534485	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-10T23:00:00.000Z	defillama-api	6.726399117695792	\N	170308983	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-11T23:00:00.000Z	defillama-api	6.680539008385722	\N	168842469	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-12T23:00:00.000Z	defillama-api	6.614937736770798	\N	168399028	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-13T23:00:00.000Z	defillama-api	6.648412703569306	\N	167764156	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-14T23:00:00.000Z	defillama-api	6.676871852207	\N	166463039	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-15T23:00:00.000Z	defillama-api	6.61134340553815	\N	166210099	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-16T23:00:00.000Z	defillama-api	6.580487335838825	\N	166003616	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-17T23:00:00.000Z	defillama-api	6.5694193445153815	\N	165312646	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-18T23:00:00.000Z	defillama-api	6.543477558196287	\N	162924465	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-19T23:00:00.000Z	defillama-api	6.463239172660451	\N	165806226	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-20T23:00:00.000Z	defillama-api	6.387945881058954	\N	165300416	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-21T23:00:00.000Z	defillama-api	6.302756799669851	\N	164279099	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-22T23:00:00.000Z	defillama-api	6.247335615228167	\N	163015443	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-23T23:00:00.000Z	defillama-api	6.098088590889006	\N	162721571	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-24T23:00:00.000Z	defillama-api	5.934050399858393	\N	160675262	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-25T23:00:00.000Z	defillama-api	5.78978978360567	\N	157269812	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-26T23:00:00.000Z	defillama-api	5.744422643161329	\N	153534090	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-27T23:00:00.000Z	defillama-api	5.679291232496553	\N	152281289	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-28T23:00:00.000Z	defillama-api	5.569739405686391	\N	150921346	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-29T23:00:00.000Z	defillama-api	5.534303067022961	\N	150906875	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-30T23:00:00.000Z	defillama-api	5.568037122571923	\N	150875471	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-08-31T23:00:00.000Z	defillama-api	5.5770884230810225	\N	148066176	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-10T23:00:00.000Z	defillama-api	8.0295294029753	\N	5188132	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-11T23:00:00.000Z	defillama-api	8.39495307829452	\N	5187896	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-12T23:00:00.000Z	defillama-api	8.035066199596486	\N	5226457	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-13T23:00:00.000Z	defillama-api	7.772741640721392	\N	4945690	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-14T23:00:00.000Z	defillama-api	8.351819703023011	\N	5149866	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-15T23:00:00.000Z	defillama-api	8.093553734411785	\N	4891652	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-16T23:00:00.000Z	defillama-api	7.728228792913683	\N	4879261	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-17T23:00:00.000Z	defillama-api	8.190712015831991	\N	4209796	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-18T23:00:00.000Z	defillama-api	7.892762753769489	\N	5085822	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-19T23:00:00.000Z	defillama-api	7.6944373176957015	\N	5074179	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-20T23:00:00.000Z	defillama-api	7.981991518946074	\N	5078852	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-21T23:00:00.000Z	defillama-api	8.45387406158693	\N	4852077	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-22T23:00:00.000Z	defillama-api	7.980698876153269	\N	5138177	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-23T23:00:00.000Z	defillama-api	7.456465700883541	\N	5627080	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-24T23:00:00.000Z	defillama-api	7.8434028456086935	\N	5537445	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-25T23:00:00.000Z	defillama-api	8.331304775666126	\N	5627565	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-26T23:00:00.000Z	defillama-api	7.958906711280633	\N	5734830	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-27T23:00:00.000Z	defillama-api	7.716102038912709	\N	6041783	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-28T23:00:00.000Z	defillama-api	7.184240450541779	\N	6327509	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-29T23:00:00.000Z	defillama-api	7.192988547188861	\N	6318808	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-30T23:00:00.000Z	defillama-api	6.956337582764149	\N	6316544	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-08-31T23:00:00.000Z	defillama-api	7.384415220101914	\N	5693751	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-01T23:00:00.000Z	defillama-api	5.56276851781945	\N	145873867	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-02T23:00:00.000Z	defillama-api	5.552495998983886	\N	150010202	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-03T23:00:00.000Z	defillama-api	5.552495998983886	\N	149240291	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-04T23:00:00.000Z	defillama-api	5.556421543673196	\N	150353517	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-05T23:00:00.000Z	defillama-api	5.556421543673196	\N	150422366	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-06T23:00:00.000Z	defillama-api	5.567526647709542	\N	147528012	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-07T23:00:00.000Z	defillama-api	5.567526647709542	\N	149764288	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-08T23:00:00.000Z	defillama-api	5.578535818884234	\N	154798244	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-09T23:00:00.000Z	defillama-api	5.578535818884234	\N	156521573	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-10T23:00:00.000Z	defillama-api	5.623986988112506	\N	155088271	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-11T23:00:00.000Z	defillama-api	5.623986988112506	\N	155839592	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-12T23:00:00.000Z	defillama-api	5.623986988112506	\N	153882466	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-13T23:00:00.000Z	defillama-api	5.600805547345544	\N	155807190	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-14T23:00:00.000Z	defillama-api	5.600805547345544	\N	153592528	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-15T23:00:00.000Z	defillama-api	5.573210494702607	\N	154614309	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-16T23:00:00.000Z	defillama-api	5.573210494702607	\N	151940080	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-17T23:00:00.000Z	defillama-api	5.572454235647228	\N	154445019	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-18T23:00:00.000Z	defillama-api	5.572454235647228	\N	156991027	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-19T23:00:00.000Z	defillama-api	5.56797130002451	\N	173540624	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-20T23:00:00.000Z	defillama-api	5.282951967089389	\N	177599534	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-21T23:00:00.000Z	defillama-api	5.309479153936536	\N	190414843	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-22T23:00:00.000Z	defillama-api	5.309479153936536	\N	181969030	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-23T23:00:00.000Z	defillama-api	5.424412324117611	\N	185609627	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-24T23:00:00.000Z	defillama-api	5.424412324117611	\N	190081021	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-25T23:00:00.000Z	defillama-api	5.508866853887184	\N	189434177	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-26T23:00:00.000Z	defillama-api	5.579235358510459	\N	193600664	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-27T23:00:00.000Z	defillama-api	5.579434226632429	\N	209930148	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-28T23:00:00.000Z	defillama-api	5.588068184181338	\N	200392921	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-29T23:00:00.000Z	defillama-api	5.588068184181338	\N	203062931	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-30T23:00:00.000Z	defillama-api	5.559704268165433	\N	199394090	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-08-31T23:00:00.000Z	defillama-api	5.546687509294657	\N	198607948	\N	\N
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
