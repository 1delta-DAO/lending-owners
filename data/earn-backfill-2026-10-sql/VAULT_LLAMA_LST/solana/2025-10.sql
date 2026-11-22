-- Generated from VAULT_LLAMA_LST/solana/2025-10.ndjson (186 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-01T23:00:00.000Z	defillama-api	6.8482422548754585	\N	1133415150	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-02T23:00:00.000Z	defillama-api	6.766322593421137	\N	1168996193	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-03T23:00:00.000Z	defillama-api	6.766322593421137	\N	1201867408	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-04T23:00:00.000Z	defillama-api	6.724847386152533	\N	1173932972	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-05T23:00:00.000Z	defillama-api	6.724847386152533	\N	1176955363	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-06T23:00:00.000Z	defillama-api	6.6499658355922975	\N	1207208689	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-07T23:00:00.000Z	defillama-api	6.6499658355922975	\N	1143361142	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-08T23:00:00.000Z	defillama-api	6.64574619015923	\N	1171306250	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-09T23:00:00.000Z	defillama-api	6.64574619015923	\N	1132589581	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-10T23:00:00.000Z	defillama-api	6.612363655023046	\N	971042273	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-11T23:00:00.000Z	defillama-api	6.612363655023046	\N	891108862	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-12T23:00:00.000Z	defillama-api	6.612410571094074	\N	985856390	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-13T23:00:00.000Z	defillama-api	6.612410571094074	\N	1037284120	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-14T23:00:00.000Z	defillama-api	6.666918642750375	\N	1001965280	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-15T23:00:00.000Z	defillama-api	6.666918642750375	\N	961145350	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-16T23:00:00.000Z	defillama-api	6.666918642750375	\N	910845409	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-17T23:00:00.000Z	defillama-api	6.666918642750375	\N	911290132	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-18T23:00:00.000Z	defillama-api	6.697196314320308	\N	927749976	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-19T23:00:00.000Z	defillama-api	6.697196314320308	\N	940933946	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-20T23:00:00.000Z	defillama-api	6.6720829117628	\N	942409466	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-21T23:00:00.000Z	defillama-api	6.6720829117628	\N	932797038	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-22T23:00:00.000Z	defillama-api	6.521501230238869	\N	880829987	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-23T23:00:00.000Z	defillama-api	6.521501230238869	\N	937103823	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-24T23:00:00.000Z	defillama-api	6.471778597827438	\N	953604448	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-25T23:00:00.000Z	defillama-api	6.471778597827438	\N	969438256	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-26T23:00:00.000Z	defillama-api	6.5347665742621075	\N	997527835	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-27T23:00:00.000Z	defillama-api	6.5347665742621075	\N	986693807	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-28T23:00:00.000Z	defillama-api	6.416075916959585	\N	955723216	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-29T23:00:00.000Z	defillama-api	6.416075916959585	\N	959916754	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-30T23:00:00.000Z	defillama-api	6.463239172660451	\N	887036802	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-10-31T23:00:00.000Z	defillama-api	6.463239172660451	\N	906338816	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-01T23:00:00.000Z	defillama-api	5.547008919393193	\N	986644636	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-02T23:00:00.000Z	defillama-api	7.225815091871368	\N	1019902672	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-03T23:00:00.000Z	defillama-api	5.43030344211104	\N	1048672800	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-04T23:00:00.000Z	defillama-api	7.188968470117629	\N	1024385071	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-05T23:00:00.000Z	defillama-api	5.3513464955301515	\N	1026379399	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-06T23:00:00.000Z	defillama-api	7.117312224380612	\N	1054220278	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-07T23:00:00.000Z	defillama-api	5.3666159260501445	\N	988449819	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-08T23:00:00.000Z	defillama-api	7.229601288827325	\N	1018011522	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-09T23:00:00.000Z	defillama-api	5.465246811908742	\N	983077001	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-10T23:00:00.000Z	defillama-api	7.501665483999886	\N	815258438	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-11T23:00:00.000Z	defillama-api	5.81191806361403	\N	759665984	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-12T23:00:00.000Z	defillama-api	7.666312883713999	\N	841566984	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-13T23:00:00.000Z	defillama-api	5.988797253309031	\N	878467056	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-14T23:00:00.000Z	defillama-api	7.864240583543847	\N	844729616	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-15T23:00:00.000Z	defillama-api	6.030165323878123	\N	805402344	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-16T23:00:00.000Z	defillama-api	7.813784799992618	\N	766132511	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-17T23:00:00.000Z	defillama-api	5.77862445894084	\N	768071564	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-18T23:00:00.000Z	defillama-api	7.475796522626865	\N	782072236	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-19T23:00:00.000Z	defillama-api	5.6187688006303915	\N	793840214	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-20T23:00:00.000Z	defillama-api	7.248706633333768	\N	797547477	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-21T23:00:00.000Z	defillama-api	5.313034971976549	\N	789423418	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-22T23:00:00.000Z	defillama-api	7.088120624842986	\N	748108302	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-23T23:00:00.000Z	defillama-api	5.306093494183983	\N	796143793	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-24T23:00:00.000Z	defillama-api	7.099969383617122	\N	810138329	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-25T23:00:00.000Z	defillama-api	5.327817035549742	\N	814912469	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-26T23:00:00.000Z	defillama-api	7.095833766967985	\N	837486488	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-27T23:00:00.000Z	defillama-api	5.3680381132181765	\N	831609217	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-28T23:00:00.000Z	defillama-api	7.162004333594041	\N	810583688	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-29T23:00:00.000Z	defillama-api	5.36116665941222	\N	814211642	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-30T23:00:00.000Z	defillama-api	7.120664272619592	\N	762184866	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-10-31T23:00:00.000Z	defillama-api	5.3250202775245725	\N	778262381	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-01T23:00:00.000Z	defillama-api	5.789147663648464	\N	479062023	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-02T23:00:00.000Z	defillama-api	5.817456260714948	\N	493096544	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-03T23:00:00.000Z	defillama-api	5.817456260714948	\N	510083731	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-04T23:00:00.000Z	defillama-api	5.864619516415814	\N	500835358	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-05T23:00:00.000Z	defillama-api	5.864619516415814	\N	503531210	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-06T23:00:00.000Z	defillama-api	5.732506661360048	\N	517061812	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-07T23:00:00.000Z	defillama-api	5.732506661360048	\N	491013223	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-08T23:00:00.000Z	defillama-api	5.638033099586437	\N	506111340	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-09T23:00:00.000Z	defillama-api	5.638033099586437	\N	488467369	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-10T23:00:00.000Z	defillama-api	5.751390730068806	\N	413759693	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-11T23:00:00.000Z	defillama-api	5.751390730068806	\N	374927849	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-12T23:00:00.000Z	defillama-api	5.6758334480377926	\N	384491533	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-13T23:00:00.000Z	defillama-api	5.6758334480377926	\N	391706765	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-14T23:00:00.000Z	defillama-api	6.269307041506522	\N	362436319	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-15T23:00:00.000Z	defillama-api	6.269307041506522	\N	342466286	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-16T23:00:00.000Z	defillama-api	5.609674085249594	\N	322371614	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-17T23:00:00.000Z	defillama-api	5.609674085249594	\N	314419167	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-18T23:00:00.000Z	defillama-api	5.666384411284753	\N	319283487	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-19T23:00:00.000Z	defillama-api	5.666384411284753	\N	321782108	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-20T23:00:00.000Z	defillama-api	5.628581261873933	\N	324373445	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-21T23:00:00.000Z	defillama-api	5.628581261873933	\N	322280338	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-22T23:00:00.000Z	defillama-api	5.779709830733282	\N	300440660	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-23T23:00:00.000Z	defillama-api	5.779709830733282	\N	320318004	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-24T23:00:00.000Z	defillama-api	11.270348740666236	\N	327255533	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-25T23:00:00.000Z	defillama-api	11.270348740666236	\N	330435495	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-26T23:00:00.000Z	defillama-api	11.306079180073425	\N	342713971	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-27T23:00:00.000Z	defillama-api	11.306079180073425	\N	344183977	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-28T23:00:00.000Z	defillama-api	11.431034883457869	\N	338700782	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-29T23:00:00.000Z	defillama-api	11.431034883457869	\N	352469419	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-30T23:00:00.000Z	defillama-api	5.552930847940729	\N	330503707	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-10-31T23:00:00.000Z	defillama-api	5.552930847940729	\N	337559768	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-01T23:00:00.000Z	defillama-api	6.349100074487524	\N	98770884	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-02T23:00:00.000Z	defillama-api	6.334552591269471	\N	105853711	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-03T23:00:00.000Z	defillama-api	6.334552591269471	\N	108546170	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-04T23:00:00.000Z	defillama-api	6.348218472496114	\N	106125595	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-05T23:00:00.000Z	defillama-api	6.348218472496114	\N	106521971	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-06T23:00:00.000Z	defillama-api	6.334552591269471	\N	109158932	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-07T23:00:00.000Z	defillama-api	6.334552591269471	\N	104481738	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-08T23:00:00.000Z	defillama-api	6.316069760003984	\N	106420536	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-09T23:00:00.000Z	defillama-api	6.316069760003984	\N	101981523	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-10T23:00:00.000Z	defillama-api	6.292230794002762	\N	96756261	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-11T23:00:00.000Z	defillama-api	6.292230794002762	\N	81102713	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-12T23:00:00.000Z	defillama-api	6.260007856084826	\N	90854888	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-13T23:00:00.000Z	defillama-api	6.260007856084826	\N	95513904	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-14T23:00:00.000Z	defillama-api	6.260007856084826	\N	92335268	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-15T23:00:00.000Z	defillama-api	6.260007856084826	\N	90093530	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-16T23:00:00.000Z	defillama-api	6.237471336234535	\N	84403879	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-17T23:00:00.000Z	defillama-api	6.237471336234535	\N	84511992	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-18T23:00:00.000Z	defillama-api	6.256748939748036	\N	86381567	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-19T23:00:00.000Z	defillama-api	6.256748939748036	\N	87510722	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-20T22:00:00.000Z	defillama-api	6.241623758640458	\N	87615993	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-21T23:00:00.000Z	defillama-api	6.241623758640458	\N	88443893	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-22T23:00:00.000Z	defillama-api	6.246528238662563	\N	83301544	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-23T23:00:00.000Z	defillama-api	6.246528238662563	\N	87847876	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-24T23:00:00.000Z	defillama-api	6.246528238662563	\N	89368884	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-25T23:00:00.000Z	defillama-api	6.246528238662563	\N	89539679	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-26T23:00:00.000Z	defillama-api	6.285187781429613	\N	91371808	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-27T23:00:00.000Z	defillama-api	6.285187781429613	\N	92035002	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-28T23:00:00.000Z	defillama-api	6.229729484275026	\N	89490030	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-29T23:00:00.000Z	defillama-api	6.229729484275026	\N	91437984	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-30T23:00:00.000Z	defillama-api	6.216714826123848	\N	84589610	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-10-31T23:00:00.000Z	defillama-api	6.216714826123848	\N	87284237	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-01T23:00:00.000Z	defillama-api	6.786086863641572	\N	365049839	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-02T23:00:00.000Z	defillama-api	6.739796106813856	\N	371102137	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-03T23:00:00.000Z	defillama-api	6.739796106813856	\N	402839033	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-04T23:00:00.000Z	defillama-api	6.787787746276308	\N	393805162	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-05T23:00:00.000Z	defillama-api	6.787787746276308	\N	393982721	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-06T23:00:00.000Z	defillama-api	6.770173212444774	\N	405081697	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-07T23:00:00.000Z	defillama-api	6.770173212444774	\N	385104027	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-08T23:00:00.000Z	defillama-api	6.738749248214049	\N	395965258	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-09T23:00:00.000Z	defillama-api	6.738749248214049	\N	382691130	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-10T23:00:00.000Z	defillama-api	6.72709095468349	\N	325836288	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-11T23:00:00.000Z	defillama-api	6.72709095468349	\N	302115428	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-12T23:00:00.000Z	defillama-api	6.649273298364733	\N	332218672	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-13T23:00:00.000Z	defillama-api	6.649273298364733	\N	352560391	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-14T23:00:00.000Z	defillama-api	6.649273298364733	\N	340383966	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-15T23:00:00.000Z	defillama-api	6.649273298364733	\N	332601306	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-16T23:00:00.000Z	defillama-api	6.5819291297231075	\N	315625016	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-17T23:00:00.000Z	defillama-api	6.5819291297231075	\N	313049189	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-18T23:00:00.000Z	defillama-api	6.590168852227407	\N	320603373	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-19T23:00:00.000Z	defillama-api	6.590168852227407	\N	323632284	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-20T23:00:00.000Z	defillama-api	6.575346874981847	\N	324873982	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-21T23:00:00.000Z	defillama-api	6.575346874981847	\N	323599780	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-22T23:00:00.000Z	defillama-api	6.6571608002163885	\N	305199032	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-23T23:00:00.000Z	defillama-api	6.6571608002163885	\N	325472098	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-24T23:00:00.000Z	defillama-api	6.64322882784063	\N	331961928	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-25T23:00:00.000Z	defillama-api	6.64322882784063	\N	332489617	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-26T23:00:00.000Z	defillama-api	6.651949615132935	\N	341743517	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-27T23:00:00.000Z	defillama-api	6.651949615132935	\N	339125016	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-28T23:00:00.000Z	defillama-api	6.651949615132935	\N	332317389	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-29T23:00:00.000Z	defillama-api	6.651949615132935	\N	333964507	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-30T23:00:00.000Z	defillama-api	6.602722752546697	\N	312508155	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-10-31T23:00:00.000Z	defillama-api	6.602722752546697	\N	320036893	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-01T23:00:00.000Z	defillama-api	5.303732285355522	\N	2768540656	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-02T23:00:00.000Z	defillama-api	5.346313171372685	\N	2845222854	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-03T23:00:00.000Z	defillama-api	5.346313171372685	\N	2920675005	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-04T23:00:00.000Z	defillama-api	5.2985638149039005	\N	2794086625	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-05T23:00:00.000Z	defillama-api	5.2985638149039005	\N	2798433507	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-06T23:00:00.000Z	defillama-api	5.252584664816595	\N	2847834508	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-07T23:00:00.000Z	defillama-api	5.252584664816595	\N	2695778788	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-08T23:00:00.000Z	defillama-api	5.169071257427049	\N	2775111865	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-09T23:00:00.000Z	defillama-api	5.169071257427049	\N	2681618871	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-10T23:00:00.000Z	defillama-api	5.219312767579254	\N	2079769246	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-11T23:00:00.000Z	defillama-api	5.219312767579254	\N	2043652474	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-12T23:00:00.000Z	defillama-api	5.1631171178456725	\N	2147150950	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-13T23:00:00.000Z	defillama-api	5.1631171178456725	\N	2142456466	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-14T23:00:00.000Z	defillama-api	5.506056091064693	\N	2001827818	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-15T23:00:00.000Z	defillama-api	5.506056091064693	\N	1877123027	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-16T23:00:00.000Z	defillama-api	5.1997963822714155	\N	1750342435	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-17T23:00:00.000Z	defillama-api	5.1997963822714155	\N	1749729849	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-18T23:00:00.000Z	defillama-api	5.319397351399857	\N	1723419823	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-19T23:00:00.000Z	defillama-api	5.319397351399857	\N	1719566511	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-20T23:00:00.000Z	defillama-api	5.303485800922658	\N	1726932907	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-21T23:00:00.000Z	defillama-api	5.303485800922658	\N	1679848652	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-22T23:00:00.000Z	defillama-api	5.279138460778654	\N	1579345099	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-23T23:00:00.000Z	defillama-api	5.279138460778654	\N	1667129700	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-24T23:00:00.000Z	defillama-api	5.324441879395181	\N	1695253441	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-25T23:00:00.000Z	defillama-api	5.324441879395181	\N	1706380862	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-26T23:00:00.000Z	defillama-api	5.522673483326912	\N	1757529801	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-27T23:00:00.000Z	defillama-api	5.522673483326912	\N	1740903278	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-28T23:00:00.000Z	defillama-api	5.504021194013831	\N	1716803964	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-29T23:00:00.000Z	defillama-api	5.504021194013831	\N	1726227821	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-30T23:00:00.000Z	defillama-api	5.502052119510381	\N	1619105183	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-10-31T23:00:00.000Z	defillama-api	5.502052119510381	\N	1653065869	\N	\N
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
