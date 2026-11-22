-- Generated from VAULT_LLAMA_LST/solana/2025-07.ndjson (186 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-01T23:00:00.000Z	defillama-api	7.725210759090828	\N	736259528	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-02T23:00:00.000Z	defillama-api	7.725210759090828	\N	741213961	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-03T23:00:00.000Z	defillama-api	7.802602669571002	\N	768437190	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-04T23:00:00.000Z	defillama-api	7.802602669571002	\N	745518412	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-05T23:00:00.000Z	defillama-api	7.868140919597977	\N	763166599	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-06T23:00:00.000Z	defillama-api	7.868140919597977	\N	794304804	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-07T23:00:00.000Z	defillama-api	7.861300976585994	\N	772923190	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-08T23:00:00.000Z	defillama-api	7.861300976585994	\N	788621306	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-09T23:00:00.000Z	defillama-api	7.826269376565165	\N	820503811	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-10T23:00:00.000Z	defillama-api	7.826269376565165	\N	858360988	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-11T23:00:00.000Z	defillama-api	7.904692040128225	\N	841239849	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-12T23:00:00.000Z	defillama-api	7.904692040128225	\N	832268413	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-13T23:00:00.000Z	defillama-api	7.827637645263508	\N	836538325	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-14T23:00:00.000Z	defillama-api	7.827637645263508	\N	845099457	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-15T23:00:00.000Z	defillama-api	7.649000153264751	\N	842182304	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-16T23:00:00.000Z	defillama-api	7.649000153264751	\N	915437264	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-17T23:00:00.000Z	defillama-api	7.732624898793006	\N	952168679	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-18T23:00:00.000Z	defillama-api	7.732624898793006	\N	959580794	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-19T23:00:00.000Z	defillama-api	7.792779704729469	\N	1077564583	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-20T23:00:00.000Z	defillama-api	7.792779704729469	\N	1099944883	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-21T23:00:00.000Z	defillama-api	7.783695492946663	\N	1199774147	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-22T23:00:00.000Z	defillama-api	7.783695492946663	\N	1214681805	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-23T23:00:00.000Z	defillama-api	7.6392079989773265	\N	1134679904	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-24T23:00:00.000Z	defillama-api	7.6392079989773265	\N	1103268181	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-25T23:00:00.000Z	defillama-api	7.7464245258340725	\N	1113659705	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-26T23:00:00.000Z	defillama-api	7.7464245258340725	\N	1110638903	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-27T23:00:00.000Z	defillama-api	7.85282387276709	\N	1134137163	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-28T23:00:00.000Z	defillama-api	7.85282387276709	\N	1098065298	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-29T23:00:00.000Z	defillama-api	7.70435411467929	\N	1089151761	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-30T23:00:00.000Z	defillama-api	7.70435411467929	\N	1053113393	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-07-31T23:00:00.000Z	defillama-api	7.5768754470573185	\N	1035582813	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-01T23:00:00.000Z	defillama-api	8.275966219528641	\N	726708039	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-02T23:00:00.000Z	defillama-api	6.404671110260551	\N	730993152	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-03T23:00:00.000Z	defillama-api	8.389251725304803	\N	758484236	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-04T23:00:00.000Z	defillama-api	7.201661718170271	\N	736270205	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-05T23:00:00.000Z	defillama-api	9.20939226318751	\N	733484209	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-06T23:00:00.000Z	defillama-api	6.293132702950288	\N	757936255	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-07T23:00:00.000Z	defillama-api	8.276665759154866	\N	738296084	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-08T23:00:00.000Z	defillama-api	5.981017588396753	\N	753143955	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-09T23:00:00.000Z	defillama-api	8.00299381324976	\N	784286777	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-10T23:00:00.000Z	defillama-api	6.017990953566255	\N	821107818	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-11T23:00:00.000Z	defillama-api	8.08334423716417	\N	803579109	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-12T23:00:00.000Z	defillama-api	6.079712196083165	\N	799192580	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-13T23:00:00.000Z	defillama-api	8.107811318325275	\N	803546806	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-14T23:00:00.000Z	defillama-api	6.126225629188298	\N	810796650	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-15T23:00:00.000Z	defillama-api	8.126657574081264	\N	809957002	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-16T23:00:00.000Z	defillama-api	6.1027269797619965	\N	869598413	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-17T23:00:00.000Z	defillama-api	8.045742056594918	\N	877761818	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-18T23:00:00.000Z	defillama-api	6.072466113948849	\N	866679873	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-19T23:00:00.000Z	defillama-api	8.168587937262828	\N	869421882	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-20T23:00:00.000Z	defillama-api	6.182004636201555	\N	890052711	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-21T23:00:00.000Z	defillama-api	8.288401779310561	\N	971456073	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-22T23:00:00.000Z	defillama-api	6.337810107126529	\N	996047305	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-23T23:00:00.000Z	defillama-api	8.314788217944624	\N	944462703	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-24T23:00:00.000Z	defillama-api	6.376481553971303	\N	921341505	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-25T23:00:00.000Z	defillama-api	8.256972913400773	\N	934743994	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-26T23:00:00.000Z	defillama-api	6.160325209947359	\N	930942791	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-27T23:00:00.000Z	defillama-api	8.086498817760912	\N	977563670	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-28T23:00:00.000Z	defillama-api	5.99000306635844	\N	945624429	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-29T23:00:00.000Z	defillama-api	7.8632420414948	\N	937537103	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-30T23:00:00.000Z	defillama-api	5.8801410332876	\N	907973651	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-07-31T23:00:00.000Z	defillama-api	7.832362863879894	\N	891973817	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-01T23:00:00.000Z	defillama-api	6.419471380070263	\N	325851677	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-02T23:00:00.000Z	defillama-api	6.419471380070263	\N	296338200	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-03T23:00:00.000Z	defillama-api	6.419471380070263	\N	306742610	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-04T23:00:00.000Z	defillama-api	6.419471380070263	\N	297396718	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-05T23:00:00.000Z	defillama-api	6.372569313839449	\N	296775609	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-06T23:00:00.000Z	defillama-api	6.372569313839449	\N	305877429	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-07T23:00:00.000Z	defillama-api	6.353802185188329	\N	297045295	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-08T23:00:00.000Z	defillama-api	6.353802185188329	\N	308411557	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-09T23:00:00.000Z	defillama-api	6.32564483993292	\N	327517985	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-10T23:00:00.000Z	defillama-api	6.32564483993292	\N	351015106	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-11T23:00:00.000Z	defillama-api	6.3162574242880964	\N	344632402	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-12T23:00:00.000Z	defillama-api	6.3162574242880964	\N	341447507	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-13T23:00:00.000Z	defillama-api	6.278698658590542	\N	343360267	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-14T23:00:00.000Z	defillama-api	6.278698658590542	\N	346782659	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-15T23:00:00.000Z	defillama-api	6.278698658590542	\N	346791042	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-16T23:00:00.000Z	defillama-api	6.278698658590542	\N	371910598	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-17T23:00:00.000Z	defillama-api	6.297479792038985	\N	381049359	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-18T23:00:00.000Z	defillama-api	6.297479792038985	\N	382116721	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-19T23:00:00.000Z	defillama-api	6.3162574242880964	\N	382580709	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-20T23:00:00.000Z	defillama-api	6.3162574242880964	\N	390190615	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-21T23:00:00.000Z	defillama-api	6.419471380070263	\N	426121631	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-22T23:00:00.000Z	defillama-api	6.419471380070263	\N	431514960	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-23T23:00:00.000Z	defillama-api	6.419471380070263	\N	395792902	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-24T23:00:00.000Z	defillama-api	6.419471380070263	\N	383992409	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-25T23:00:00.000Z	defillama-api	6.438225904403794	\N	387469158	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-26T23:00:00.000Z	defillama-api	6.438225904403794	\N	386365560	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-27T23:00:00.000Z	defillama-api	6.466351038625362	\N	394573449	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-28T23:00:00.000Z	defillama-api	6.466351038625362	\N	386208428	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-29T23:00:00.000Z	defillama-api	6.410092367303832	\N	384488861	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-30T23:00:00.000Z	defillama-api	6.410092367303832	\N	373349345	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-07-31T23:00:00.000Z	defillama-api	6.363186099633822	\N	365359047	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-01T23:00:00.000Z	defillama-api	7.037019920375087	\N	78691898	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-02T23:00:00.000Z	defillama-api	7.037019920375087	\N	79736664	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-03T23:00:00.000Z	defillama-api	7.037700553524928	\N	81743573	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-04T23:00:00.000Z	defillama-api	7.037700553524928	\N	78976099	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-05T23:00:00.000Z	defillama-api	7.037803488785244	\N	79440737	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-06T23:00:00.000Z	defillama-api	7.037803488785244	\N	81866520	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-07T23:00:00.000Z	defillama-api	7.037803488785244	\N	79970761	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-08T23:00:00.000Z	defillama-api	7.037803488785244	\N	81229989	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-09T23:00:00.000Z	defillama-api	6.949453524640603	\N	84115575	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-10T23:00:00.000Z	defillama-api	6.949453524640603	\N	86301267	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-11T23:00:00.000Z	defillama-api	6.949453524640603	\N	88238479	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-12T23:00:00.000Z	defillama-api	6.949453524640603	\N	85878022	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-13T23:00:00.000Z	defillama-api	6.9287509329996055	\N	87397091	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-14T23:00:00.000Z	defillama-api	6.9287509329996055	\N	87782208	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-15T23:00:00.000Z	defillama-api	6.8823299315567965	\N	86462339	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-16T23:00:00.000Z	defillama-api	6.8823299315567965	\N	94023672	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-17T23:00:00.000Z	defillama-api	6.9432402963087725	\N	94316607	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-18T23:00:00.000Z	defillama-api	6.9432402963087725	\N	96611620	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-19T23:00:00.000Z	defillama-api	7.041437733690259	\N	98057088	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-20T23:00:00.000Z	defillama-api	7.041437733690259	\N	100730453	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-21T23:00:00.000Z	defillama-api	6.986826026533777	\N	109247290	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-22T23:00:00.000Z	defillama-api	6.986826026533777	\N	111559974	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-23T23:00:00.000Z	defillama-api	6.931988141900547	\N	103928915	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-24T23:00:00.000Z	defillama-api	6.931988141900547	\N	105518526	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-25T23:00:00.000Z	defillama-api	7.07565565498669	\N	102976849	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-26T23:00:00.000Z	defillama-api	7.07565565498669	\N	103832686	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-27T23:00:00.000Z	defillama-api	7.021444485033612	\N	104734511	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-28T23:00:00.000Z	defillama-api	7.021444485033612	\N	102860635	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-29T23:00:00.000Z	defillama-api	6.9187949225835155	\N	100974193	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-30T23:00:00.000Z	defillama-api	6.9187949225835155	\N	98456479	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-07-31T23:00:00.000Z	defillama-api	6.833234714065384	\N	97947088	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-01T23:00:00.000Z	defillama-api	7.770983338417636	\N	238277236	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-02T23:00:00.000Z	defillama-api	7.770983338417636	\N	239410404	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-03T23:00:00.000Z	defillama-api	7.81827963969306	\N	247692878	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-04T23:00:00.000Z	defillama-api	7.81827963969306	\N	240227055	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-05T23:00:00.000Z	defillama-api	7.841156476118272	\N	239646433	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-06T23:00:00.000Z	defillama-api	7.841156476118272	\N	247515635	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-07T23:00:00.000Z	defillama-api	7.905560337562179	\N	240339063	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-08T23:00:00.000Z	defillama-api	7.905560337562179	\N	246988768	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-09T23:00:00.000Z	defillama-api	7.844355171826578	\N	257378627	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-10T23:00:00.000Z	defillama-api	7.844355171826578	\N	268702258	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-11T23:00:00.000Z	defillama-api	7.8584355950539475	\N	263145838	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-12T23:00:00.000Z	defillama-api	7.8584355950539475	\N	261574256	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-13T23:00:00.000Z	defillama-api	7.857778770059554	\N	262462319	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-14T23:00:00.000Z	defillama-api	7.857778770059554	\N	265142338	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-15T23:00:00.000Z	defillama-api	7.838660120995655	\N	264201564	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-16T23:00:00.000Z	defillama-api	7.838660120995655	\N	283609334	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-17T23:00:00.000Z	defillama-api	7.837578250402544	\N	289544751	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-18T23:00:00.000Z	defillama-api	7.837578250402544	\N	291230226	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-19T23:00:00.000Z	defillama-api	7.857547690903743	\N	290610875	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-20T23:00:00.000Z	defillama-api	7.857547690903743	\N	298237035	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-21T23:00:00.000Z	defillama-api	8.003538599865578	\N	326038800	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-22T23:00:00.000Z	defillama-api	8.003538599865578	\N	334301343	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-23T23:00:00.000Z	defillama-api	7.921525806509067	\N	315010095	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-24T23:00:00.000Z	defillama-api	7.921525806509067	\N	305589234	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-25T23:00:00.000Z	defillama-api	8.128999176193474	\N	308873887	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-26T23:00:00.000Z	defillama-api	8.128999176193474	\N	307894701	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-27T23:00:00.000Z	defillama-api	8.136411215176054	\N	315637827	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-28T23:00:00.000Z	defillama-api	8.136411215176054	\N	305087791	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-29T23:00:00.000Z	defillama-api	7.9198816433034835	\N	302524655	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-30T23:00:00.000Z	defillama-api	7.9198816433034835	\N	293146849	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-07-31T23:00:00.000Z	defillama-api	7.779347003378234	\N	287576447	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-01T23:00:00.000Z	defillama-api	5.828824654940945	\N	1345954266	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-02T23:00:00.000Z	defillama-api	5.828824654940945	\N	1353076637	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-03T23:00:00.000Z	defillama-api	5.770610913913288	\N	1404500701	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-04T23:00:00.000Z	defillama-api	5.770610913913288	\N	1377801258	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-05T23:00:00.000Z	defillama-api	5.798688431823962	\N	1373443615	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-06T23:00:00.000Z	defillama-api	5.798688431823962	\N	1420302119	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-07T23:00:00.000Z	defillama-api	5.688257103741989	\N	1380793794	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-08T23:00:00.000Z	defillama-api	5.688257103741989	\N	1416108705	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-09T23:00:00.000Z	defillama-api	5.703663781275736	\N	1478964940	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-10T23:00:00.000Z	defillama-api	5.703663781275736	\N	1542478784	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-11T23:00:00.000Z	defillama-api	5.864072629080397	\N	1518356186	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-12T23:00:00.000Z	defillama-api	5.864072629080397	\N	1521972432	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-13T23:00:00.000Z	defillama-api	5.741552359950219	\N	1531526278	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-14T23:00:00.000Z	defillama-api	5.741552359950219	\N	1574391941	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-15T23:00:00.000Z	defillama-api	5.6083317254262965	\N	1572804398	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-16T23:00:00.000Z	defillama-api	5.6083317254262965	\N	1702346414	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-17T23:00:00.000Z	defillama-api	5.792979376195717	\N	1717341009	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-18T23:00:00.000Z	defillama-api	5.792979376195717	\N	1716369746	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-19T23:00:00.000Z	defillama-api	5.908480440908193	\N	1721333500	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-20T23:00:00.000Z	defillama-api	5.908480440908193	\N	1773224081	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-21T23:00:00.000Z	defillama-api	6.0674313893116505	\N	1938248938	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-22T23:00:00.000Z	defillama-api	6.0674313893116505	\N	2016026027	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-23T23:00:00.000Z	defillama-api	5.62114121329671	\N	1892483192	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-24T23:00:00.000Z	defillama-api	5.62114121329671	\N	1843729015	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-25T23:00:00.000Z	defillama-api	5.752627353672324	\N	1877684618	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-26T23:00:00.000Z	defillama-api	5.752627353672324	\N	1850522085	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-27T23:00:00.000Z	defillama-api	5.649488323555829	\N	1904480920	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-28T23:00:00.000Z	defillama-api	5.649488323555829	\N	1898792569	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-29T23:00:00.000Z	defillama-api	5.435863346647807	\N	1881473150	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-30T23:00:00.000Z	defillama-api	5.435863346647807	\N	1833175597	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-07-31T23:00:00.000Z	defillama-api	5.52048803470484	\N	1806160175	\N	\N
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
