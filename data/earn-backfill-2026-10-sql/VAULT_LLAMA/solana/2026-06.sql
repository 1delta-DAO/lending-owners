-- Generated from VAULT_LLAMA/solana/2026-06.ndjson (120 vault rows)
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
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-01T23:00:00.000Z	defillama-api	11.210784937176754	\N	183476022	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-02T23:00:00.000Z	defillama-api	11.207343258234914	\N	183641860	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-03T23:00:00.000Z	defillama-api	11.203901579293074	\N	183848519	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-04T23:00:00.000Z	defillama-api	11.200468303229627	\N	183274395	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-05T23:00:00.000Z	defillama-api	11.197026624287787	\N	181632817	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-06T23:00:00.000Z	defillama-api	11.19359334822434	\N	181715239	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-07T23:00:00.000Z	defillama-api	11.190159371921027	\N	180310492	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-08T23:00:00.000Z	defillama-api	11.186735198975839	\N	181284967	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-09T23:00:00.000Z	defillama-api	11.183310325790785	\N	180399393	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-10T23:00:00.000Z	defillama-api	11.179876349487472	\N	184031106	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-11T23:00:00.000Z	defillama-api	11.176460579420677	\N	184582936	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-12T23:00:00.000Z	defillama-api	11.173035706235623	\N	186324070	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-13T23:00:00.000Z	defillama-api	11.169619235928963	\N	187173662	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-14T23:00:00.000Z	defillama-api	11.166202765622302	\N	187874317	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-15T23:00:00.000Z	defillama-api	11.162786295315641	\N	188304977	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-16T23:00:00.000Z	defillama-api	11.15936982500898	\N	188545663	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-17T23:00:00.000Z	defillama-api	11.155962457820578	\N	190461067	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-18T23:00:00.000Z	defillama-api	11.15255439039231	\N	190847848	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-19T23:00:00.000Z	defillama-api	11.149146322964043	\N	190930519	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-20T23:00:00.000Z	defillama-api	11.145738255535775	\N	192994938	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-21T23:00:00.000Z	defillama-api	11.142339291225767	\N	193313052	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-22T23:00:00.000Z	defillama-api	11.138939626675892	\N	196484895	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-23T23:00:00.000Z	defillama-api	11.135539962126018	\N	200971547	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-24T23:00:00.000Z	defillama-api	11.132140297576143	\N	202498574	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-25T23:00:00.000Z	defillama-api	11.128749736144528	\N	201884981	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-26T23:00:00.000Z	defillama-api	11.125358474473046	\N	202065492	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-27T23:00:00.000Z	defillama-api	11.12196791304143	\N	203127412	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-28T23:00:00.000Z	defillama-api	11.118576651369949	\N	203236580	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-29T23:00:00.000Z	defillama-api	11.115194492816727	\N	204357099	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-06-30T23:00:00.000Z	defillama-api	11.111811634023638	\N	204483243	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-01T23:00:00.000Z	defillama-api	7.262433435428761	\N	230210	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-02T23:00:00.000Z	defillama-api	9.554206478767924	\N	143802	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-03T23:00:00.000Z	defillama-api	9.806311737037277	\N	144182	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-04T23:00:00.000Z	defillama-api	9.571900839944192	\N	143182	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-05T23:00:00.000Z	defillama-api	7.968011930259422	\N	36500	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-06T23:00:00.000Z	defillama-api	10.805929354518184	\N	36521	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-07T23:00:00.000Z	defillama-api	10.985328007251383	\N	36521	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-08T23:00:00.000Z	defillama-api	6.395591099916942	\N	36864	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-09T23:00:00.000Z	defillama-api	10.670842580751128	\N	36122	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-10T23:00:00.000Z	defillama-api	9.211481078708061	\N	36540	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-11T23:00:00.000Z	defillama-api	10.952369117234184	\N	37513	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-12T23:00:00.000Z	defillama-api	12.079830927547164	\N	43294	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-13T23:00:00.000Z	defillama-api	10.546858810300819	\N	2043094	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-14T23:00:00.000Z	defillama-api	10.546858810300819	\N	3043074	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-15T23:00:00.000Z	defillama-api	6.321983985912993	\N	3045216	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-16T23:00:00.000Z	defillama-api	8.308539977619489	\N	4056206	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-17T23:00:00.000Z	defillama-api	6.951981390557194	\N	4057406	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-18T23:00:00.000Z	defillama-api	8.611182247264537	\N	6558797	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-19T23:00:00.000Z	defillama-api	7.9844010443252955	\N	6560699	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-20T23:00:00.000Z	defillama-api	9.295796260744282	\N	6560693	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-21T23:00:00.000Z	defillama-api	9.29152199660166	\N	6567027	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-22T23:00:00.000Z	defillama-api	6.128435586205683	\N	6572772	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-23T23:00:00.000Z	defillama-api	9.020260976555505	\N	6574808	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-24T23:00:00.000Z	defillama-api	8.98850369814852	\N	6570955	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-25T23:00:00.000Z	defillama-api	9.616754004326822	\N	6572926	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-26T23:00:00.000Z	defillama-api	9.665917845325112	\N	6574920	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-27T23:00:00.000Z	defillama-api	10.906039146973967	\N	6582943	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-28T23:00:00.000Z	defillama-api	10.906039146973967	\N	6582943	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-29T23:00:00.000Z	defillama-api	6.737094581410474	\N	6588843	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-06-30T23:00:00.000Z	defillama-api	9.72862292485388	\N	6590832	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-01T23:00:00.000Z	defillama-api	6.1811398399669315	\N	272762148	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-02T23:00:00.000Z	defillama-api	6.1399566327224875	\N	265585588	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-03T23:00:00.000Z	defillama-api	6.14667123279844	\N	260185967	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-04T23:00:00.000Z	defillama-api	6.187231226562062	\N	257667088	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-05T23:00:00.000Z	defillama-api	6.225660390413168	\N	250549101	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-06T23:00:00.000Z	defillama-api	6.3045592170851705	\N	249471311	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-07T23:00:00.000Z	defillama-api	6.30522584543769	\N	249457897	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-08T23:00:00.000Z	defillama-api	6.284446227411422	\N	243824642	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-09T23:00:00.000Z	defillama-api	6.178573460857706	\N	237169290	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-10T23:00:00.000Z	defillama-api	6.155350705938645	\N	237882532	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-11T23:00:00.000Z	defillama-api	6.17383563792373	\N	236032646	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-12T23:00:00.000Z	defillama-api	6.02878094966286	\N	236731380	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-13T23:00:00.000Z	defillama-api	5.829183177752384	\N	235206059	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-14T23:00:00.000Z	defillama-api	5.842860963056751	\N	234749420	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-15T23:00:00.000Z	defillama-api	5.937113249032677	\N	224941018	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-16T23:00:00.000Z	defillama-api	6.80073728211994	\N	223792003	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-17T23:00:00.000Z	defillama-api	6.444217156698073	\N	221027927	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-18T23:00:00.000Z	defillama-api	6.296250170834128	\N	215690839	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-19T23:00:00.000Z	defillama-api	6.2441229147225386	\N	217266254	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-20T23:00:00.000Z	defillama-api	6.270424624332804	\N	216738368	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-21T23:00:00.000Z	defillama-api	6.282793661327446	\N	216195754	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-22T23:00:00.000Z	defillama-api	6.267832336348533	\N	215638566	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-23T23:00:00.000Z	defillama-api	6.118879412753131	\N	214442286	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-24T23:00:00.000Z	defillama-api	6.0172564019467245	\N	213390030	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-25T23:00:00.000Z	defillama-api	6.003037331225869	\N	212482273	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-26T23:00:00.000Z	defillama-api	5.500064838770413	\N	211092192	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-27T23:00:00.000Z	defillama-api	5.539884678995577	\N	210736255	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-28T23:00:00.000Z	defillama-api	5.494073586476134	\N	211510646	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-29T23:00:00.000Z	defillama-api	5.50305556323849	\N	208511750	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-06-30T23:00:00.000Z	defillama-api	5.565984719524408	\N	202409169	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-01T23:00:00.000Z	defillama-api	5.878283296922859	\N	164858999	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-02T23:00:00.000Z	defillama-api	5.869164773386615	\N	148740348	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-03T23:00:00.000Z	defillama-api	5.869164773386615	\N	146147394	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-04T23:00:00.000Z	defillama-api	5.9198572380125825	\N	137287364	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-05T23:00:00.000Z	defillama-api	5.9198572380125825	\N	129489524	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-06T23:00:00.000Z	defillama-api	5.952208319826013	\N	124399914	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-07T23:00:00.000Z	defillama-api	5.952208319826013	\N	133719493	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-08T23:00:00.000Z	defillama-api	5.971060177500931	\N	135337688	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-09T23:00:00.000Z	defillama-api	5.971060177500931	\N	131085999	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-10T23:00:00.000Z	defillama-api	5.980395775395664	\N	127102165	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-11T23:00:00.000Z	defillama-api	5.980395775395664	\N	135544923	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-12T23:00:00.000Z	defillama-api	6.0036304343924485	\N	134358204	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-13T23:00:00.000Z	defillama-api	6.0036304343924485	\N	139642158	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-14T23:00:00.000Z	defillama-api	6.043401257826986	\N	142770867	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-15T23:00:00.000Z	defillama-api	6.043401257826986	\N	149735941	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-16T23:00:00.000Z	defillama-api	6.001681666845116	\N	150021753	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-17T23:00:00.000Z	defillama-api	6.001681666845116	\N	146175074	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-18T23:00:00.000Z	defillama-api	5.9497777872508095	\N	140974278	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-19T23:00:00.000Z	defillama-api	5.9497777872508095	\N	140987059	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-20T23:00:00.000Z	defillama-api	5.93536054864785	\N	149538698	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-21T23:00:00.000Z	defillama-api	5.93536054864785	\N	148331216	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-22T23:00:00.000Z	defillama-api	5.927952711104467	\N	146176418	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-23T23:00:00.000Z	defillama-api	5.927952711104467	\N	141133544	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-24T23:00:00.000Z	defillama-api	5.8594517462040585	\N	137862701	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-25T23:00:00.000Z	defillama-api	5.8594517462040585	\N	136474169	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-26T23:00:00.000Z	defillama-api	5.782984852586992	\N	146027419	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-27T23:00:00.000Z	defillama-api	5.782984852586992	\N	144194899	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-28T23:00:00.000Z	defillama-api	5.729957088007609	\N	142406304	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-29T23:00:00.000Z	defillama-api	5.729957088007609	\N	152823887	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-06-30T23:00:00.000Z	defillama-api	5.65457276522352	\N	148669688	\N	\N
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
