-- Generated from VAULT_LLAMA_LST/solana/2025-09.ndjson (180 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-01T23:00:00.000Z	defillama-api	7.019468408131502	\N	1141543274	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-02T23:00:00.000Z	defillama-api	6.940460344040389	\N	1213154349	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-03T23:00:00.000Z	defillama-api	6.940460344040389	\N	1225204074	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-04T23:00:00.000Z	defillama-api	6.968724125755443	\N	1189931675	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-05T23:00:00.000Z	defillama-api	6.968724125755443	\N	1192930258	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-06T23:00:00.000Z	defillama-api	6.9726790805191285	\N	1168593101	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-07T23:00:00.000Z	defillama-api	6.9726790805191285	\N	1205521731	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-08T23:00:00.000Z	defillama-api	7.028612840542792	\N	1247322179	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-09T23:00:00.000Z	defillama-api	7.028612840542792	\N	1260437250	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-10T23:00:00.000Z	defillama-api	7.029358596000179	\N	1281941400	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-11T23:00:00.000Z	defillama-api	7.029358596000179	\N	1306871837	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-12T23:00:00.000Z	defillama-api	7.12726683431697	\N	1379895809	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-13T23:00:00.000Z	defillama-api	7.12726683431697	\N	1378741975	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-14T23:00:00.000Z	defillama-api	7.1190719271641	\N	1373232835	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-15T23:00:00.000Z	defillama-api	7.1190719271641	\N	1320414373	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-16T23:00:00.000Z	defillama-api	7.134846930867411	\N	1333263711	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-17T23:00:00.000Z	defillama-api	7.134846930867411	\N	1372182700	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-18T23:00:00.000Z	defillama-api	7.257764936241529	\N	1378341667	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-19T23:00:00.000Z	defillama-api	7.257764936241529	\N	1332008293	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-20T23:00:00.000Z	defillama-api	7.257764936241529	\N	1336980562	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-21T23:00:00.000Z	defillama-api	7.257764936241529	\N	1324465858	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-22T23:00:00.000Z	defillama-api	7.281774760770077	\N	1223669946	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-23T23:00:00.000Z	defillama-api	7.281774760770077	\N	1197104128	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-24T23:00:00.000Z	defillama-api	7.207309852930166	\N	1172249037	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-25T23:00:00.000Z	defillama-api	7.207309852930166	\N	1083439525	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-26T23:00:00.000Z	defillama-api	7.045539038585957	\N	1131510784	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-27T23:00:00.000Z	defillama-api	7.045539038585957	\N	1129425098	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-28T23:00:00.000Z	defillama-api	6.8482422548754585	\N	1155657440	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-29T23:00:00.000Z	defillama-api	6.8482422548754585	\N	1163115650	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-09-30T23:00:00.000Z	defillama-api	6.8482422548754585	\N	1077330787	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-01T23:00:00.000Z	defillama-api	5.299777330591837	\N	897649557	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-02T23:00:00.000Z	defillama-api	6.971764567254013	\N	953273498	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-03T23:00:00.000Z	defillama-api	5.2131625608353716	\N	961743376	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-04T23:00:00.000Z	defillama-api	7.279961839756766	\N	935783856	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-05T23:00:00.000Z	defillama-api	5.303248419608053	\N	938163606	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-06T23:00:00.000Z	defillama-api	7.1111837250725785	\N	920304168	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-07T23:00:00.000Z	defillama-api	5.654562961865395	\N	950546635	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-08T23:00:00.000Z	defillama-api	7.437120874342895	\N	984326199	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-09T23:00:00.000Z	defillama-api	5.768005321371561	\N	994955028	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-10T23:00:00.000Z	defillama-api	7.614524543697598	\N	1027737638	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-11T23:00:00.000Z	defillama-api	5.4714012200918205	\N	1048015588	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-12T23:00:00.000Z	defillama-api	7.408310905532289	\N	1104070070	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-13T23:00:00.000Z	defillama-api	5.599613739093456	\N	1103190436	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-14T23:00:00.000Z	defillama-api	7.517806713153163	\N	1109662982	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-15T23:00:00.000Z	defillama-api	5.703937575063378	\N	1067168691	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-16T23:00:00.000Z	defillama-api	7.584254574766192	\N	1086134031	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-17T23:00:00.000Z	defillama-api	5.762464323311178	\N	1114467079	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-18T23:00:00.000Z	defillama-api	7.68816877041445	\N	1123518780	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-19T23:00:00.000Z	defillama-api	5.754590826256845	\N	1085448981	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-20T23:00:00.000Z	defillama-api	7.620195786373074	\N	1088079389	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-21T23:00:00.000Z	defillama-api	5.730146152771454	\N	1072777922	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-22T23:00:00.000Z	defillama-api	7.7282189895555575	\N	963875056	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-23T23:00:00.000Z	defillama-api	5.8478599754607785	\N	943657615	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-24T23:00:00.000Z	defillama-api	7.680556462830168	\N	928218167	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-25T23:00:00.000Z	defillama-api	5.8424464210560245	\N	875238507	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-26T23:00:00.000Z	defillama-api	7.641024421189968	\N	913754642	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-27T23:00:00.000Z	defillama-api	5.783909869450099	\N	913005170	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-28T23:00:00.000Z	defillama-api	7.592995669014613	\N	941884636	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-29T23:00:00.000Z	defillama-api	5.602668185389348	\N	958859116	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-09-30T23:00:00.000Z	defillama-api	7.406351634386965	\N	936548639	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-01T23:00:00.000Z	defillama-api	6.194140493320788	\N	425636676	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-02T23:00:00.000Z	defillama-api	6.147131990630328	\N	451682964	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-03T23:00:00.000Z	defillama-api	6.147131990630328	\N	439441022	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-04T23:00:00.000Z	defillama-api	6.08128423458254	\N	426476248	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-05T23:00:00.000Z	defillama-api	6.08128423458254	\N	428127753	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-06T23:00:00.000Z	defillama-api	6.062462487221865	\N	420758102	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-07T23:00:00.000Z	defillama-api	6.062462487221865	\N	435218233	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-08T23:00:00.000Z	defillama-api	6.090693357663213	\N	451589987	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-09T23:00:00.000Z	defillama-api	6.090693357663213	\N	457278447	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-10T23:00:00.000Z	defillama-api	6.090693357663213	\N	476146106	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-11T23:00:00.000Z	defillama-api	6.090693357663213	\N	488779970	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-12T23:00:00.000Z	defillama-api	6.118916525466034	\N	513026447	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-13T23:00:00.000Z	defillama-api	6.118916525466034	\N	514824637	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-14T23:00:00.000Z	defillama-api	6.165938332713949	\N	514960081	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-15T23:00:00.000Z	defillama-api	6.3162574242880964	\N	495454368	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-16T23:00:00.000Z	defillama-api	6.25991402394277	\N	503874691	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-17T23:00:00.000Z	defillama-api	6.25991402394277	\N	521085722	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-18T23:00:00.000Z	defillama-api	6.44760211621076	\N	526335633	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-19T23:00:00.000Z	defillama-api	6.44760211621076	\N	511063306	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-20T23:00:00.000Z	defillama-api	5.723063226525937	\N	514441758	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-21T23:00:00.000Z	defillama-api	5.723063226525937	\N	510086350	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-22T23:00:00.000Z	defillama-api	6.194140493320788	\N	473831801	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-23T23:00:00.000Z	defillama-api	6.194140493320788	\N	462030515	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-24T23:00:00.000Z	defillama-api	5.817456260714948	\N	464118659	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-25T23:00:00.000Z	defillama-api	5.817456260714948	\N	425460070	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-26T23:00:00.000Z	defillama-api	5.8457571551429055	\N	445544643	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-27T23:00:00.000Z	defillama-api	5.8457571551429055	\N	445524181	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-28T23:00:00.000Z	defillama-api	5.656935374531713	\N	459376336	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-29T23:00:00.000Z	defillama-api	5.656935374531713	\N	467587561	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-09-30T23:00:00.000Z	defillama-api	5.789147663648464	\N	455338304	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-01T23:00:00.000Z	defillama-api	6.6497977780244355	\N	91333719	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-02T23:00:00.000Z	defillama-api	6.631961968395217	\N	95835987	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-03T23:00:00.000Z	defillama-api	6.631961968395217	\N	96667186	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-04T23:00:00.000Z	defillama-api	6.588445561916956	\N	92296919	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-05T23:00:00.000Z	defillama-api	6.588445561916956	\N	93658253	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-06T23:00:00.000Z	defillama-api	6.594765226708432	\N	91428520	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-07T23:00:00.000Z	defillama-api	6.594765226708432	\N	92832915	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-08T23:00:00.000Z	defillama-api	6.560157972046454	\N	96427883	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-09T23:00:00.000Z	defillama-api	6.560157972046454	\N	98305321	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-10T23:00:00.000Z	defillama-api	6.51256266834821	\N	101747306	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-11T23:00:00.000Z	defillama-api	6.51256266834821	\N	103418734	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-12T23:00:00.000Z	defillama-api	6.485312833959256	\N	111475673	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-13T23:00:00.000Z	defillama-api	6.485312833959256	\N	112028445	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-14T23:00:00.000Z	defillama-api	6.491835568311899	\N	112884785	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-15T23:00:00.000Z	defillama-api	6.491835568311899	\N	109289765	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-16T23:00:00.000Z	defillama-api	6.483597946527198	\N	110967547	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-17T23:00:00.000Z	defillama-api	6.483597946527198	\N	110818577	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-18T23:00:00.000Z	defillama-api	6.5507929640773455	\N	115715139	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-19T23:00:00.000Z	defillama-api	6.5507929640773455	\N	110406372	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-20T23:00:00.000Z	defillama-api	6.542578450208225	\N	111439345	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-21T23:00:00.000Z	defillama-api	6.542578450208225	\N	110743142	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-22T23:00:00.000Z	defillama-api	6.60895698807451	\N	102559566	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-23T23:00:00.000Z	defillama-api	6.60895698807451	\N	100263459	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-24T23:00:00.000Z	defillama-api	6.492772489252729	\N	100238889	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-25T23:00:00.000Z	defillama-api	6.492772489252729	\N	91563270	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-26T23:00:00.000Z	defillama-api	6.446561559769748	\N	93417852	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-27T23:00:00.000Z	defillama-api	6.446561559769748	\N	94479578	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-28T23:00:00.000Z	defillama-api	6.343131229868959	\N	96677607	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-29T23:00:00.000Z	defillama-api	6.343131229868959	\N	98058160	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-09-30T23:00:00.000Z	defillama-api	6.349100074487524	\N	97550929	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-01T23:00:00.000Z	defillama-api	7.343752291077976	\N	306690499	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-02T23:00:00.000Z	defillama-api	7.343752291077976	\N	327943175	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-03T23:00:00.000Z	defillama-api	7.343752291077976	\N	330295673	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-04T23:00:00.000Z	defillama-api	7.341420492323891	\N	320495716	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-05T23:00:00.000Z	defillama-api	7.341420492323891	\N	351039997	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-06T23:00:00.000Z	defillama-api	7.4209670408720285	\N	344242362	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-07T23:00:00.000Z	defillama-api	7.4209670408720285	\N	353240906	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-08T23:00:00.000Z	defillama-api	7.304198542001927	\N	364528052	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-09T23:00:00.000Z	defillama-api	7.304198542001927	\N	372539199	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-10T23:00:00.000Z	defillama-api	7.110531801757247	\N	384682169	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-11T23:00:00.000Z	defillama-api	7.110531801757247	\N	392161307	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-12T23:00:00.000Z	defillama-api	7.077770379382287	\N	414712420	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-13T23:00:00.000Z	defillama-api	7.077770379382287	\N	418769638	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-14T23:00:00.000Z	defillama-api	7.137063190043591	\N	422000842	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-15T23:00:00.000Z	defillama-api	7.137063190043591	\N	409488034	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-16T23:00:00.000Z	defillama-api	7.033758203078833	\N	411262109	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-17T23:00:00.000Z	defillama-api	7.033758203078833	\N	419004273	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-18T23:00:00.000Z	defillama-api	7.252798835111207	\N	423961497	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-19T23:00:00.000Z	defillama-api	7.252798835111207	\N	409522357	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-20T23:00:00.000Z	defillama-api	7.252798835111207	\N	412123608	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-21T23:00:00.000Z	defillama-api	7.252798835111207	\N	407662476	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-22T23:00:00.000Z	defillama-api	7.377578778289262	\N	378113870	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-23T23:00:00.000Z	defillama-api	7.377578778289262	\N	369365116	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-24T23:00:00.000Z	defillama-api	7.109823859252629	\N	368512544	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-25T23:00:00.000Z	defillama-api	7.109823859252629	\N	335849834	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-26T23:00:00.000Z	defillama-api	7.018042019524273	\N	350304138	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-27T23:00:00.000Z	defillama-api	7.018042019524273	\N	350189653	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-28T23:00:00.000Z	defillama-api	6.786086863641572	\N	360581702	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-29T23:00:00.000Z	defillama-api	6.786086863641572	\N	362575462	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-09-30T23:00:00.000Z	defillama-api	6.786086863641572	\N	359755079	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-01T23:00:00.000Z	defillama-api	5.71740668888765	\N	2257042000	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-02T23:00:00.000Z	defillama-api	5.490627706095097	\N	2339411409	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-03T23:00:00.000Z	defillama-api	5.490627706095097	\N	2356096870	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-04T23:00:00.000Z	defillama-api	5.364351350323204	\N	2318984839	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-05T23:00:00.000Z	defillama-api	5.364351350323204	\N	2321831656	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-06T23:00:00.000Z	defillama-api	5.405845464068193	\N	2299991368	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-07T23:00:00.000Z	defillama-api	5.405845464068193	\N	2391924134	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-08T23:00:00.000Z	defillama-api	5.264880876865163	\N	2519959118	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-09T23:00:00.000Z	defillama-api	5.264880876865163	\N	2570133524	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-10T23:00:00.000Z	defillama-api	5.188575038417298	\N	2673670629	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-11T23:00:00.000Z	defillama-api	5.188575038417298	\N	2742193408	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-12T23:00:00.000Z	defillama-api	5.352645440481751	\N	2912871532	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-13T23:00:00.000Z	defillama-api	5.352645440481751	\N	2916578591	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-14T23:00:00.000Z	defillama-api	5.539942098664596	\N	2939020330	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-15T23:00:00.000Z	defillama-api	5.539942098664596	\N	2845614547	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-16T23:00:00.000Z	defillama-api	5.338350043615492	\N	2931901963	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-17T23:00:00.000Z	defillama-api	5.338350043615492	\N	3050759477	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-18T23:00:00.000Z	defillama-api	5.533858414707993	\N	3088696859	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-19T23:00:00.000Z	defillama-api	5.533858414707993	\N	3022512854	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-20T23:00:00.000Z	defillama-api	5.254539034282857	\N	3045467208	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-21T23:00:00.000Z	defillama-api	5.254539034282857	\N	3023814878	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-22T23:00:00.000Z	defillama-api	5.289800312979764	\N	2800210604	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-23T23:00:00.000Z	defillama-api	5.289800312979764	\N	2746488023	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-24T23:00:00.000Z	defillama-api	5.296182999359189	\N	2724893483	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-25T23:00:00.000Z	defillama-api	5.296182999359189	\N	2504171426	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-26T23:00:00.000Z	defillama-api	5.27776318968165	\N	2608154567	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-27T23:00:00.000Z	defillama-api	5.27776318968165	\N	2617088903	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-28T23:00:00.000Z	defillama-api	5.293129253303164	\N	2661160166	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-29T23:00:00.000Z	defillama-api	5.293129253303164	\N	2717359813	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-09-30T23:00:00.000Z	defillama-api	5.303732285355522	\N	2620163944	\N	\N
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
