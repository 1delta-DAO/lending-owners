-- Generated from VAULT_LLAMA/solana/2026-09.ndjson (150 vault rows)
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
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-01T23:00:00.000Z	defillama-api	10.922294515225417	\N	280227433	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-02T23:00:00.000Z	defillama-api	10.922294515225417	\N	279878888	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-03T23:00:00.000Z	defillama-api	10.922294515225417	\N	287761482	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-04T23:00:00.000Z	defillama-api	10.922294515225417	\N	286136146	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-05T23:00:00.000Z	defillama-api	10.922294515225417	\N	287351203	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-06T23:00:00.000Z	defillama-api	10.922294515225417	\N	287456944	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-07T23:00:00.000Z	defillama-api	10.922294515225417	\N	287956405	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-08T23:00:00.000Z	defillama-api	10.922294515225417	\N	289333252	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-09T23:00:00.000Z	defillama-api	10.922294515225417	\N	292399495	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-10T23:00:00.000Z	defillama-api	10.922294515225417	\N	294086204	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-11T23:00:00.000Z	defillama-api	10.922294515225417	\N	294792312	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-12T23:00:00.000Z	defillama-api	10.922294515225417	\N	295671868	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-13T23:00:00.000Z	defillama-api	10.922294515225417	\N	297250001	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-14T23:00:00.000Z	defillama-api	10.922294515225417	\N	297457861	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-15T23:00:00.000Z	defillama-api	10.922294515225417	\N	298364218	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-16T23:00:00.000Z	defillama-api	10.922294515225417	\N	300276872	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-17T23:00:00.000Z	defillama-api	10.922294515225417	\N	300455036	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-18T23:00:00.000Z	defillama-api	10.922294515225417	\N	301396746	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-19T23:00:00.000Z	defillama-api	10.454018207894933	\N	301491574	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-20T23:00:00.000Z	defillama-api	10.454018207894933	\N	300441542	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-21T23:00:00.000Z	defillama-api	10.454018207894933	\N	302584071	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-22T23:00:00.000Z	defillama-api	10.454018207894933	\N	300959437	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-23T23:00:00.000Z	defillama-api	10.454018207894933	\N	298925010	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-24T23:00:00.000Z	defillama-api	10.454018207894933	\N	296991711	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-25T23:00:00.000Z	defillama-api	10.454018207894933	\N	293169795	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-26T23:00:00.000Z	defillama-api	10.454018207894933	\N	293377110	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-27T23:00:00.000Z	defillama-api	10.454018207894933	\N	293294417	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-28T23:00:00.000Z	defillama-api	10.454018207894933	\N	291408646	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-29T23:00:00.000Z	defillama-api	10.454018207894933	\N	287767164	\N	\N
VAULT_LLAMA	solana	5y8nv33vv7wbnlfq3zbcksdyprk7g2koiqoe7m2tcxp5	2026-09-30T23:00:00.000Z	defillama-api	10.454018207894933	\N	286636419	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-01T23:00:00.000Z	defillama-api	9.24306749858772	\N	13484014	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-02T23:00:00.000Z	defillama-api	9.327729999597523	\N	13487965	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-03T23:00:00.000Z	defillama-api	10.528319259606178	\N	13491827	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-04T23:00:00.000Z	defillama-api	10.472814746620429	\N	13860234	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-05T23:00:00.000Z	defillama-api	10.47935218601026	\N	14621399	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-06T23:00:00.000Z	defillama-api	10.343517556066217	\N	14626634	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-07T23:00:00.000Z	defillama-api	11.335270079371185	\N	14620040	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-08T23:00:00.000Z	defillama-api	8.954760539481299	\N	15243934	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-09T23:00:00.000Z	defillama-api	10.100466399265429	\N	16343060	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-10T23:00:00.000Z	defillama-api	10.049878970619375	\N	17792956	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-11T23:00:00.000Z	defillama-api	8.57079521274784	\N	18021048	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-12T23:00:00.000Z	defillama-api	9.991845191237303	\N	18032541	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-13T23:00:00.000Z	defillama-api	10.07080423853779	\N	18154847	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-14T23:00:00.000Z	defillama-api	10.15454242292435	\N	18214629	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-15T23:00:00.000Z	defillama-api	11.437037339590006	\N	18951930	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-16T23:00:00.000Z	defillama-api	10.228344903850939	\N	18961040	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-17T23:00:00.000Z	defillama-api	10.220697584273353	\N	18543370	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-18T23:00:00.000Z	defillama-api	11.727437315656175	\N	18759839	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-19T23:00:00.000Z	defillama-api	10.224544001857794	\N	18775266	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-20T23:00:00.000Z	defillama-api	10.193898004118296	\N	18785372	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-21T23:00:00.000Z	defillama-api	10.182301331695953	\N	18794553	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-22T23:00:00.000Z	defillama-api	10.277624284427134	\N	18869921	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-23T23:00:00.000Z	defillama-api	10.270007775403656	\N	18879471	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-24T23:00:00.000Z	defillama-api	10.281350260754607	\N	18937864	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-25T23:00:00.000Z	defillama-api	10.321133688506734	\N	18861515	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-26T23:00:00.000Z	defillama-api	10.39893173810924	\N	18869777	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-27T23:00:00.000Z	defillama-api	10.610128983401523	\N	18877906	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-28T23:00:00.000Z	defillama-api	10.835454968471936	\N	18886445	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-29T23:00:00.000Z	defillama-api	10.390054097086932	\N	19098146	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-09-30T23:00:00.000Z	defillama-api	10.45347762271831	\N	19115883	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-01T23:00:00.000Z	defillama-api	5.566362849052098	\N	147403864	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-02T23:00:00.000Z	defillama-api	5.565502254256671	\N	147096885	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-03T23:00:00.000Z	defillama-api	5.559713371283692	\N	144266128	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-04T23:00:00.000Z	defillama-api	5.578592538313387	\N	144337712	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-05T23:00:00.000Z	defillama-api	5.553082099751805	\N	144352832	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-06T23:00:00.000Z	defillama-api	5.59166181517412	\N	147898346	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-07T23:00:00.000Z	defillama-api	5.595765220789417	\N	146029940	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-08T23:00:00.000Z	defillama-api	5.604766804268024	\N	141733404	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-09T23:00:00.000Z	defillama-api	5.594053834556689	\N	141470605	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-10T23:00:00.000Z	defillama-api	5.603046314917037	\N	140671447	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-11T23:00:00.000Z	defillama-api	5.616943975539357	\N	137692483	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-12T23:00:00.000Z	defillama-api	5.655489379208234	\N	136584836	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-13T23:00:00.000Z	defillama-api	5.644753301581318	\N	136583733	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-14T23:00:00.000Z	defillama-api	5.7128257196836785	\N	129950861	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-15T23:00:00.000Z	defillama-api	5.7414767340446815	\N	126393578	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-16T23:00:00.000Z	defillama-api	5.799651261639838	\N	130669023	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-17T23:00:00.000Z	defillama-api	5.857782374363296	\N	132344275	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-18T23:00:00.000Z	defillama-api	5.891294453874707	\N	139200469	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-19T23:00:00.000Z	defillama-api	5.8952823199120985	\N	137825068	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-20T23:00:00.000Z	defillama-api	5.938611062106247	\N	136613489	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-21T23:00:00.000Z	defillama-api	5.9573242722876785	\N	132581540	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-22T23:00:00.000Z	defillama-api	5.976033981269779	\N	130298669	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-23T23:00:00.000Z	defillama-api	6.058612568438093	\N	131269008	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-24T23:00:00.000Z	defillama-api	6.082168637533414	\N	128231624	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-25T23:00:00.000Z	defillama-api	6.100826528765424	\N	130968911	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-26T23:00:00.000Z	defillama-api	6.139157659035277	\N	131898037	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-27T23:00:00.000Z	defillama-api	6.192175620256535	\N	130597384	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-28T23:00:00.000Z	defillama-api	6.215709281676141	\N	128628490	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-29T23:00:00.000Z	defillama-api	6.244150924317182	\N	137294687	\N	\N
VAULT_LLAMA	solana	3b8x44flf9ooxaum3hhsgjpmvs6rzz3ppogngahc3uu7	2026-09-30T23:00:00.000Z	defillama-api	6.1988489061803875	\N	135090077	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-01T23:00:00.000Z	defillama-api	6.991217930973903	\N	5724951	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-02T23:00:00.000Z	defillama-api	7.928149375402427	\N	5699118	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-03T23:00:00.000Z	defillama-api	7.413204181716537	\N	5339445	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-04T23:00:00.000Z	defillama-api	7.901171234081517	\N	5307721	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-05T23:00:00.000Z	defillama-api	7.856900669267475	\N	5314164	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-06T23:00:00.000Z	defillama-api	7.30952456642342	\N	5843604	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-07T23:00:00.000Z	defillama-api	7.308502216218926	\N	7854784	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-08T23:00:00.000Z	defillama-api	7.266013761864087	\N	7309098	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-09T23:00:00.000Z	defillama-api	7.4668600614558045	\N	7264135	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-10T23:00:00.000Z	defillama-api	7.049760784738623	\N	11457757	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-11T23:00:00.000Z	defillama-api	7.111900770695456	\N	11444488	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-12T23:00:00.000Z	defillama-api	7.235600943999998	\N	11470164	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-13T23:00:00.000Z	defillama-api	7.740076151208086	\N	11456829	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-14T23:00:00.000Z	defillama-api	7.069235855894362	\N	11458450	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-15T23:00:00.000Z	defillama-api	7.315194408619163	\N	12618964	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-16T23:00:00.000Z	defillama-api	7.5989274009202745	\N	12525647	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-17T23:00:00.000Z	defillama-api	7.044914424625404	\N	12528192	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-18T23:00:00.000Z	defillama-api	7.919003542511405	\N	12510389	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-19T23:00:00.000Z	defillama-api	8.201952266162493	\N	12498419	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-20T23:00:00.000Z	defillama-api	7.487831545205381	\N	12501256	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-21T23:00:00.000Z	defillama-api	7.901818255717785	\N	12604916	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-22T23:00:00.000Z	defillama-api	7.455815878287808	\N	15214112	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-23T23:00:00.000Z	defillama-api	7.859026597500929	\N	15482164	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-24T23:00:00.000Z	defillama-api	8.93241168391512	\N	27186265	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-25T23:00:00.000Z	defillama-api	8.972734996604004	\N	33506505	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-26T23:00:00.000Z	defillama-api	9.499558359138405	\N	34692400	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-27T23:00:00.000Z	defillama-api	9.04629939597612	\N	36552422	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-28T23:00:00.000Z	defillama-api	8.680502492808273	\N	37757338	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-29T23:00:00.000Z	defillama-api	9.051232585832736	\N	39169564	\N	\N
VAULT_LLAMA	solana	gne6ods6jhrfav3gqvvccp37fdnt7pipuewmkbj2bqnm	2026-09-30T23:00:00.000Z	defillama-api	9.53865415134203	\N	40027366	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-01T23:00:00.000Z	defillama-api	5.547273610062575	\N	192097967	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-02T23:00:00.000Z	defillama-api	5.502204071561323	\N	191606452	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-03T20:00:00.000Z	defillama-api	5.502204071561323	\N	202750247	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-04T23:00:00.000Z	defillama-api	5.413802989906458	\N	195207414	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-05T23:00:00.000Z	defillama-api	5.397593137246304	\N	198223353	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-06T23:00:00.000Z	defillama-api	5.397593137246304	\N	201725875	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-07T23:00:00.000Z	defillama-api	6.066113537883666	\N	197333850	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-08T23:00:00.000Z	defillama-api	5.880008687952909	\N	197639279	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-09T23:00:00.000Z	defillama-api	5.880178846240369	\N	193572464	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-10T23:00:00.000Z	defillama-api	5.74021210084652	\N	190519418	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-11T23:00:00.000Z	defillama-api	5.581391397058155	\N	194655415	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-12T23:00:00.000Z	defillama-api	5.581580461822	\N	194078591	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-13T23:00:00.000Z	defillama-api	5.507049731434677	\N	190946010	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-14T23:00:00.000Z	defillama-api	5.507049731434677	\N	196700079	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-15T23:00:00.000Z	defillama-api	5.375467658197408	\N	185534149	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-16T23:00:00.000Z	defillama-api	5.300479671177527	\N	186970964	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-17T23:00:00.000Z	defillama-api	5.300479671177527	\N	194067638	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-18T23:00:00.000Z	defillama-api	5.277981664519871	\N	216791150	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-19T23:00:00.000Z	defillama-api	5.436431241179207	\N	212439024	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-20T23:00:00.000Z	defillama-api	5.431430828295447	\N	212574468	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-21T23:00:00.000Z	defillama-api	5.4310519985278916	\N	229189028	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-22T23:00:00.000Z	defillama-api	5.459925689166312	\N	228353254	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-23T23:00:00.000Z	defillama-api	5.477223714578372	\N	221656336	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-24T23:00:00.000Z	defillama-api	5.446773083761514	\N	224126080	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-25T23:00:00.000Z	defillama-api	5.447142110170944	\N	236646051	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-26T23:00:00.000Z	defillama-api	5.428939374851893	\N	235878714	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-27T23:00:00.000Z	defillama-api	5.416085771869916	\N	236315000	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-28T23:00:00.000Z	defillama-api	5.399639938374889	\N	230358590	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-29T23:00:00.000Z	defillama-api	5.399364744107515	\N	231878235	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-09-30T23:00:00.000Z	defillama-api	5.392088551658958	\N	229943416	\N	\N
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
