-- Generated from VAULT_LLAMA_LST/solana/2026-04.ndjson (510 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-01T23:00:00.000Z	defillama-api	6.0204298890198515	\N	352390002	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-02T23:00:00.000Z	defillama-api	6.0204298890198515	\N	343403871	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-03T23:00:00.000Z	defillama-api	6.075929500326538	\N	347374832	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-04T23:00:00.000Z	defillama-api	6.075929500326538	\N	350381871	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-05T23:00:00.000Z	defillama-api	6.091399199448233	\N	346941040	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-06T23:00:00.000Z	defillama-api	6.091399199448233	\N	347639647	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-07T23:00:00.000Z	defillama-api	6.101833473692864	\N	365989599	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-08T23:00:00.000Z	defillama-api	6.101833473692864	\N	406220708	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-09T23:00:00.000Z	defillama-api	6.110723719032762	\N	425394169	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-10T23:00:00.000Z	defillama-api	6.110723719032762	\N	428893109	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-11T23:00:00.000Z	defillama-api	6.110723719032762	\N	430221107	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-12T23:00:00.000Z	defillama-api	6.110723719032762	\N	413416737	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-13T23:00:00.000Z	defillama-api	6.075204752065133	\N	435554185	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-14T23:00:00.000Z	defillama-api	6.075204752065133	\N	420392275	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-15T23:00:00.000Z	defillama-api	6.014309092350345	\N	428407255	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-16T23:00:00.000Z	defillama-api	6.014309092350345	\N	448714233	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-17T23:00:00.000Z	defillama-api	6.0106650440872045	\N	450649514	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-18T23:00:00.000Z	defillama-api	6.0106650440872045	\N	434720135	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-19T23:00:00.000Z	defillama-api	6.0106650440872045	\N	423101167	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-20T23:00:00.000Z	defillama-api	6.0106650440872045	\N	431977763	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-21T23:00:00.000Z	defillama-api	6.024036124330223	\N	429019861	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-22T23:00:00.000Z	defillama-api	6.024036124330223	\N	439530651	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-23T23:00:00.000Z	defillama-api	6.035964710449093	\N	432125115	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-24T23:00:00.000Z	defillama-api	6.035964710449093	\N	432494466	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-25T23:00:00.000Z	defillama-api	6.035964710449093	\N	432851786	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-26T23:00:00.000Z	defillama-api	6.035964710449093	\N	436240505	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-27T23:00:00.000Z	defillama-api	6.045820586564332	\N	425269136	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-28T23:00:00.000Z	defillama-api	6.045820586564332	\N	421281645	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-29T23:00:00.000Z	defillama-api	5.961714776248073	\N	418435423	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-04-30T23:00:00.000Z	defillama-api	5.961714776248073	\N	418899232	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-01T23:00:00.000Z	defillama-api	6.8154787317809	\N	227043756	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-02T23:00:00.000Z	defillama-api	6.81569370541979	\N	221708058	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-03T23:00:00.000Z	defillama-api	7.043041282983609	\N	223943897	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-04T23:00:00.000Z	defillama-api	7.042929244605034	\N	226084625	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-05T23:00:00.000Z	defillama-api	7.224763331592499	\N	223104895	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-06T23:00:00.000Z	defillama-api	7.221256530343112	\N	223675356	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-07T23:00:00.000Z	defillama-api	7.121437337431757	\N	234041953	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-08T23:00:00.000Z	defillama-api	5.361925019187197	\N	268668739	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-09T23:00:00.000Z	defillama-api	6.91127294594196	\N	272548224	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-10T23:00:00.000Z	defillama-api	5.01159501418158	\N	274654628	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-11T23:00:00.000Z	defillama-api	6.6952321414959215	\N	275018098	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-12T23:00:00.000Z	defillama-api	4.865634915773853	\N	264620322	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-13T23:00:00.000Z	defillama-api	6.505600883599527	\N	277598478	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-14T23:00:00.000Z	defillama-api	4.874273775001825	\N	268702905	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-15T23:00:00.000Z	defillama-api	6.495293352770659	\N	274015172	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-16T23:00:00.000Z	defillama-api	4.951399594332884	\N	286921712	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-17T23:00:00.000Z	defillama-api	6.59389482855488	\N	287457117	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-18T23:00:00.000Z	defillama-api	4.910259101720271	\N	277634838	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-19T23:00:00.000Z	defillama-api	6.516854438487485	\N	269821880	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-20T23:00:00.000Z	defillama-api	4.877254696111777	\N	274953997	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-21T23:00:00.000Z	defillama-api	6.496193160998587	\N	273287288	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-22T23:00:00.000Z	defillama-api	4.87206381798444	\N	280116962	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-23T23:00:00.000Z	defillama-api	6.524836472721063	\N	275497989	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-24T23:00:00.000Z	defillama-api	4.885626063710902	\N	275843350	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-25T23:00:00.000Z	defillama-api	6.551757194372954	\N	275422295	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-26T23:00:00.000Z	defillama-api	4.946308150266532	\N	277291115	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-27T23:00:00.000Z	defillama-api	6.7267541393079	\N	270322615	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-28T23:00:00.000Z	defillama-api	5.10772604371823	\N	267618924	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-29T23:00:00.000Z	defillama-api	6.797542087610964	\N	265437053	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-04-30T23:00:00.000Z	defillama-api	5.135753144358546	\N	264634940	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-01T23:00:00.000Z	defillama-api	5.49615609983789	\N	97394387	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-02T23:00:00.000Z	defillama-api	5.49615609983789	\N	95005544	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-03T23:00:00.000Z	defillama-api	5.5150842836582115	\N	93472093	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-04T23:00:00.000Z	defillama-api	5.5150842836582115	\N	94465276	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-05T23:00:00.000Z	defillama-api	5.56239038829176	\N	93572889	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-06T23:00:00.000Z	defillama-api	5.56239038829176	\N	93677969	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-07T23:00:00.000Z	defillama-api	5.4582878281195235	\N	98479387	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-08T23:00:00.000Z	defillama-api	5.4582878281195235	\N	96417261	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-09T23:00:00.000Z	defillama-api	5.56239038829176	\N	98005302	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-10T23:00:00.000Z	defillama-api	5.56239038829176	\N	98997517	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-11T23:00:00.000Z	defillama-api	5.543470607349832	\N	99645041	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-12T23:00:00.000Z	defillama-api	5.543470607349832	\N	95859957	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-13T23:00:00.000Z	defillama-api	5.505620541867984	\N	100790731	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-14T23:00:00.000Z	defillama-api	5.505620541867984	\N	98050322	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-15T23:00:00.000Z	defillama-api	5.39198421591891	\N	98824338	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-16T23:00:00.000Z	defillama-api	5.39198421591891	\N	102306318	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-17T23:00:00.000Z	defillama-api	5.448818484410367	\N	102786819	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-18T23:00:00.000Z	defillama-api	5.448818484410367	\N	99100007	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-19T23:00:00.000Z	defillama-api	5.42987699603259	\N	96981621	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-20T23:00:00.000Z	defillama-api	5.42987699603259	\N	99283267	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-21T23:00:00.000Z	defillama-api	5.401459161546995	\N	97944099	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-22T23:00:00.000Z	defillama-api	5.401459161546995	\N	100653399	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-23T23:00:00.000Z	defillama-api	5.344597583700761	\N	99243580	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-24T23:00:00.000Z	defillama-api	5.344597583700761	\N	99524158	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-25T23:00:00.000Z	defillama-api	5.354076730768043	\N	99580629	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-26T23:00:00.000Z	defillama-api	5.354076730768043	\N	100276368	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-27T23:00:00.000Z	defillama-api	5.401459161546995	\N	97873164	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-28T23:00:00.000Z	defillama-api	5.401459161546995	\N	97039438	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-29T23:00:00.000Z	defillama-api	5.325636488606733	\N	99706270	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-04-30T23:00:00.000Z	defillama-api	5.325636488606733	\N	99916459	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-01T23:00:00.000Z	defillama-api	5.671156545972167	\N	59622020	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-02T23:00:00.000Z	defillama-api	5.671156545972167	\N	58189451	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-03T23:00:00.000Z	defillama-api	5.730712646823122	\N	59012774	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-04T23:00:00.000Z	defillama-api	5.730712646823122	\N	59607775	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-05T23:00:00.000Z	defillama-api	5.721816799564294	\N	59121731	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-06T23:00:00.000Z	defillama-api	5.721816799564294	\N	59237723	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-07T23:00:00.000Z	defillama-api	5.66755661282059	\N	62211216	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-08T23:00:00.000Z	defillama-api	5.66755661282059	\N	60715848	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-09T23:00:00.000Z	defillama-api	5.671297994425117	\N	61981081	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-10T23:00:00.000Z	defillama-api	5.671297994425117	\N	62464301	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-11T23:00:00.000Z	defillama-api	5.671297994425117	\N	62742939	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-12T23:00:00.000Z	defillama-api	5.671297994425117	\N	60297496	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-13T23:00:00.000Z	defillama-api	5.657898904587455	\N	63501454	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-14T23:00:00.000Z	defillama-api	5.657898904587455	\N	62253993	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-15T23:00:00.000Z	defillama-api	5.657898904587455	\N	62628543	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-16T23:00:00.000Z	defillama-api	5.657898904587455	\N	65293279	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-17T23:00:00.000Z	defillama-api	5.646114567881	\N	65564716	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-18T23:00:00.000Z	defillama-api	5.646114567881	\N	62876672	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-19T23:00:00.000Z	defillama-api	5.638250874184791	\N	61018573	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-20T23:00:00.000Z	defillama-api	5.638250874184791	\N	62336838	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-21T23:00:00.000Z	defillama-api	5.622295208596029	\N	62014068	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-22T23:00:00.000Z	defillama-api	5.622295208596029	\N	63546223	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-23T23:00:00.000Z	defillama-api	5.6236088585848165	\N	62662119	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-24T23:00:00.000Z	defillama-api	5.6236088585848165	\N	62703838	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-25T23:00:00.000Z	defillama-api	5.6236088585848165	\N	59369034	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-26T23:00:00.000Z	defillama-api	5.6236088585848165	\N	59817377	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-27T23:00:00.000Z	defillama-api	5.610817576950922	\N	54239741	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-28T23:00:00.000Z	defillama-api	5.610817576950922	\N	53721178	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-29T23:00:00.000Z	defillama-api	5.604077067999924	\N	53324507	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-04-30T23:00:00.000Z	defillama-api	5.604077067999924	\N	53181653	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-01T23:00:00.000Z	defillama-api	5.989748879287049	\N	227703984	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-02T23:00:00.000Z	defillama-api	5.989748879287049	\N	222004860	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-03T23:00:00.000Z	defillama-api	6.033403933258796	\N	221308054	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-04T23:00:00.000Z	defillama-api	6.033403933258796	\N	223350448	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-05T23:00:00.000Z	defillama-api	6.031144259210919	\N	220297867	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-06T23:00:00.000Z	defillama-api	6.031144259210919	\N	222344563	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-07T23:00:00.000Z	defillama-api	6.037376394019134	\N	230554422	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-08T23:00:00.000Z	defillama-api	6.037376394019134	\N	228272935	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-09T23:00:00.000Z	defillama-api	6.044248548064957	\N	232689036	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-10T23:00:00.000Z	defillama-api	6.044248548064957	\N	234298870	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-11T23:00:00.000Z	defillama-api	6.0835425081506855	\N	235562380	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-12T23:00:00.000Z	defillama-api	6.0835425081506855	\N	226202329	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-13T23:00:00.000Z	defillama-api	6.0480326443013155	\N	238027125	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-14T23:00:00.000Z	defillama-api	6.0480326443013155	\N	232072033	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-15T23:00:00.000Z	defillama-api	6.010994857064134	\N	237167522	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-16T23:00:00.000Z	defillama-api	6.010994857064134	\N	247745385	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-17T23:00:00.000Z	defillama-api	6.006974079753036	\N	248578372	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-18T23:00:00.000Z	defillama-api	6.006974079753036	\N	240149325	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-19T23:00:00.000Z	defillama-api	6.018462214996134	\N	233234400	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-20T23:00:00.000Z	defillama-api	6.018462214996134	\N	238297463	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-21T23:00:00.000Z	defillama-api	5.974055803648071	\N	237817271	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-22T23:00:00.000Z	defillama-api	5.974055803648071	\N	243164301	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-23T23:00:00.000Z	defillama-api	5.951831590778056	\N	239804492	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-24T23:00:00.000Z	defillama-api	5.951831590778056	\N	239900539	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-25T23:00:00.000Z	defillama-api	5.948109815889779	\N	239632108	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-26T23:00:00.000Z	defillama-api	5.948109815889779	\N	241548343	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-27T23:00:00.000Z	defillama-api	5.918339818222762	\N	235328726	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-28T23:00:00.000Z	defillama-api	5.918339818222762	\N	232941186	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-29T23:00:00.000Z	defillama-api	5.898129495207627	\N	231309416	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-04-30T23:00:00.000Z	defillama-api	5.898129495207627	\N	230468558	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-01T23:00:00.000Z	defillama-api	5.813871032600559	\N	53451155	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-02T23:00:00.000Z	defillama-api	5.813871032600559	\N	51824327	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-03T23:00:00.000Z	defillama-api	5.828645393535226	\N	52502584	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-04T23:00:00.000Z	defillama-api	5.828645393535226	\N	53088984	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-05T23:00:00.000Z	defillama-api	5.8307398109747055	\N	52687745	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-06T23:00:00.000Z	defillama-api	5.8307398109747055	\N	52730110	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-07T23:00:00.000Z	defillama-api	5.8383710250353715	\N	54996970	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-08T23:00:00.000Z	defillama-api	5.8383710250353715	\N	54072811	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-09T23:00:00.000Z	defillama-api	5.8383710250353715	\N	56050560	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-10T23:00:00.000Z	defillama-api	5.8383710250353715	\N	56469533	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-11T23:00:00.000Z	defillama-api	5.835965701095347	\N	56647009	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-12T23:00:00.000Z	defillama-api	5.835965701095347	\N	54359638	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-13T23:00:00.000Z	defillama-api	5.811361372920487	\N	57455448	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-14T23:00:00.000Z	defillama-api	5.811361372920487	\N	55460860	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-15T23:00:00.000Z	defillama-api	5.794432373917857	\N	56410181	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-16T23:00:00.000Z	defillama-api	5.794432373917857	\N	65005530	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-17T23:00:00.000Z	defillama-api	5.794432373917857	\N	65036723	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-18T23:00:00.000Z	defillama-api	5.794432373917857	\N	62744928	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-19T23:00:00.000Z	defillama-api	5.649015661646217	\N	60880211	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-20T23:00:00.000Z	defillama-api	5.649015661646217	\N	62433465	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-21T23:00:00.000Z	defillama-api	5.785401380364874	\N	62170194	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-22T23:00:00.000Z	defillama-api	5.785401380364874	\N	64714070	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-23T23:00:00.000Z	defillama-api	5.7783317586768135	\N	63860963	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-24T23:00:00.000Z	defillama-api	5.7783317586768135	\N	64023001	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-25T23:00:00.000Z	defillama-api	5.735556906216743	\N	63867326	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-26T23:00:00.000Z	defillama-api	5.735556906216743	\N	64230864	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-27T23:00:00.000Z	defillama-api	5.735556906216743	\N	62673440	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-28T23:00:00.000Z	defillama-api	5.735556906216743	\N	61940506	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-29T23:00:00.000Z	defillama-api	5.735556906216743	\N	61519186	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-04-30T23:00:00.000Z	defillama-api	5.735556906216743	\N	61580718	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-01T23:00:00.000Z	defillama-api	6.186939926777768	\N	113847295	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-02T23:00:00.000Z	defillama-api	6.186939926777768	\N	111036720	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-03T23:00:00.000Z	defillama-api	6.216094413602491	\N	112698729	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-04T23:00:00.000Z	defillama-api	6.216094413602491	\N	114157075	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-05T23:00:00.000Z	defillama-api	6.256964613626792	\N	113568361	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-06T23:00:00.000Z	defillama-api	6.256964613626792	\N	113881796	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-07T23:00:00.000Z	defillama-api	6.248876843173434	\N	120659570	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-08T23:00:00.000Z	defillama-api	6.248876843173434	\N	117864341	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-09T23:00:00.000Z	defillama-api	6.248876843173434	\N	119765272	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-10T23:00:00.000Z	defillama-api	6.248876843173434	\N	120874102	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-11T23:00:00.000Z	defillama-api	6.2494216297892535	\N	121688463	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-12T23:00:00.000Z	defillama-api	6.2494216297892535	\N	116879217	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-13T23:00:00.000Z	defillama-api	6.270650101569686	\N	123910941	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-14T23:00:00.000Z	defillama-api	6.270650101569686	\N	119811485	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-15T23:00:00.000Z	defillama-api	6.208764302684244	\N	123055876	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-16T23:00:00.000Z	defillama-api	6.208764302684244	\N	129056862	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-17T23:00:00.000Z	defillama-api	6.178122506383943	\N	129627538	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-18T23:00:00.000Z	defillama-api	6.178122506383943	\N	125544668	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-19T23:00:00.000Z	defillama-api	6.240026511505903	\N	121919131	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-20T23:00:00.000Z	defillama-api	6.240026511505903	\N	124593683	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-21T23:00:00.000Z	defillama-api	6.153159655397644	\N	123602693	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-22T23:00:00.000Z	defillama-api	6.153159655397644	\N	125778801	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-23T23:00:00.000Z	defillama-api	6.088162690787158	\N	123908613	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-24T23:00:00.000Z	defillama-api	6.088162690787158	\N	124109067	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-25T23:00:00.000Z	defillama-api	6.10627369468375	\N	124120642	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-26T23:00:00.000Z	defillama-api	6.10627369468375	\N	125251338	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-27T23:00:00.000Z	defillama-api	6.094955717728112	\N	122304514	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-28T23:00:00.000Z	defillama-api	6.094955717728112	\N	121392139	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-29T23:00:00.000Z	defillama-api	6.06241487091097	\N	120486990	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-04-30T23:00:00.000Z	defillama-api	6.06241487091097	\N	120000893	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-01T23:00:00.000Z	defillama-api	5.280627870973831	\N	101573935	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-02T23:00:00.000Z	defillama-api	5.280627870973831	\N	99170715	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-03T23:00:00.000Z	defillama-api	5.268561337601341	\N	100668312	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-04T23:00:00.000Z	defillama-api	5.268561337601341	\N	101654707	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-05T23:00:00.000Z	defillama-api	5.268561337601341	\N	100962613	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-06T23:00:00.000Z	defillama-api	5.268561337601341	\N	101264371	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-07T23:00:00.000Z	defillama-api	5.2590555814191475	\N	106251698	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-08T23:00:00.000Z	defillama-api	5.2590555814191475	\N	104203196	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-09T23:00:00.000Z	defillama-api	5.212516939678835	\N	106035896	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-10T23:00:00.000Z	defillama-api	5.212516939678835	\N	106712622	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-11T23:00:00.000Z	defillama-api	5.236547771403366	\N	107154993	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-12T23:00:00.000Z	defillama-api	5.236547771403366	\N	103066649	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-13T23:00:00.000Z	defillama-api	5.217167932869415	\N	108426455	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-14T23:00:00.000Z	defillama-api	5.217167932869415	\N	105120880	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-15T23:00:00.000Z	defillama-api	5.197698463632605	\N	107218196	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-16T23:00:00.000Z	defillama-api	5.197698463632605	\N	112164193	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-17T23:00:00.000Z	defillama-api	5.222236269020186	\N	112523217	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-18T23:00:00.000Z	defillama-api	5.222236269020186	\N	108699414	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-19T23:00:00.000Z	defillama-api	5.254908760932153	\N	105707542	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-20T23:00:00.000Z	defillama-api	5.254908760932153	\N	107886217	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-21T23:00:00.000Z	defillama-api	5.237904836263851	\N	107530288	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-22T23:00:00.000Z	defillama-api	5.237904836263851	\N	110103096	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-23T23:00:00.000Z	defillama-api	5.23870240947133	\N	108445535	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-24T23:00:00.000Z	defillama-api	5.23870240947133	\N	108634703	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-25T23:00:00.000Z	defillama-api	5.2465689041270025	\N	108579801	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-26T23:00:00.000Z	defillama-api	5.2465689041270025	\N	109364131	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-27T23:00:00.000Z	defillama-api	5.25026897157943	\N	106670463	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-28T23:00:00.000Z	defillama-api	5.25026897157943	\N	105498097	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-29T23:00:00.000Z	defillama-api	5.2373166347763345	\N	104718008	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-04-30T23:00:00.000Z	defillama-api	5.2373166347763345	\N	104410427	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-01T23:00:00.000Z	defillama-api	5.294153704227256	\N	771143932	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-02T23:00:00.000Z	defillama-api	5.294153704227256	\N	751772109	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-03T23:00:00.000Z	defillama-api	5.338265314591695	\N	761990136	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-04T23:00:00.000Z	defillama-api	5.338265314591695	\N	768457780	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-05T23:00:00.000Z	defillama-api	5.227503473292927	\N	762935279	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-06T23:00:00.000Z	defillama-api	5.227503473292927	\N	763476779	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-07T23:00:00.000Z	defillama-api	5.191955096250922	\N	803732178	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-08T23:00:00.000Z	defillama-api	5.191955096250922	\N	785935996	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-09T23:00:00.000Z	defillama-api	5.206517984746029	\N	797635883	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-10T23:00:00.000Z	defillama-api	5.206517984746029	\N	804914391	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-11T23:00:00.000Z	defillama-api	5.1538956590491125	\N	813278104	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-12T23:00:00.000Z	defillama-api	5.1538956590491125	\N	780987228	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-13T23:00:00.000Z	defillama-api	5.05103042272026	\N	846580356	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-14T23:00:00.000Z	defillama-api	5.05103042272026	\N	828330326	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-15T23:00:00.000Z	defillama-api	4.89763377693464	\N	878946524	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-16T23:00:00.000Z	defillama-api	4.89763377693464	\N	921068863	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-17T23:00:00.000Z	defillama-api	5.157257510646218	\N	927674471	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-18T23:00:00.000Z	defillama-api	5.157257510646218	\N	896789471	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-19T23:00:00.000Z	defillama-api	5.053930116005745	\N	870295160	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-20T23:00:00.000Z	defillama-api	5.053930116005745	\N	888628809	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-21T23:00:00.000Z	defillama-api	5.125540846151466	\N	886561245	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-22T23:00:00.000Z	defillama-api	5.125540846151466	\N	910889265	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-23T23:00:00.000Z	defillama-api	5.172404399189645	\N	905986095	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-24T23:00:00.000Z	defillama-api	5.172404399189645	\N	907192850	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-25T23:00:00.000Z	defillama-api	5.123887579827624	\N	908897256	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-26T23:00:00.000Z	defillama-api	5.123887579827624	\N	914425773	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-27T23:00:00.000Z	defillama-api	5.080955173397683	\N	892365822	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-28T23:00:00.000Z	defillama-api	5.080955173397683	\N	883481073	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-29T23:00:00.000Z	defillama-api	5.0659938484187705	\N	877607163	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-04-30T23:00:00.000Z	defillama-api	5.0659938484187705	\N	874257934	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-01T23:00:00.000Z	defillama-api	5.310711576100857	\N	61351568	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-02T23:00:00.000Z	defillama-api	5.3107213794589825	\N	59855039	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-03T23:00:00.000Z	defillama-api	5.352020126281332	\N	60711256	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-04T23:00:00.000Z	defillama-api	5.352029229399591	\N	61356413	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-05T23:00:00.000Z	defillama-api	5.0744730529572735	\N	60955411	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-06T23:00:00.000Z	defillama-api	5.074482156075533	\N	60922206	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-07T23:00:00.000Z	defillama-api	5.388971083775118	\N	64286183	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-08T23:00:00.000Z	defillama-api	5.388961280416993	\N	62666837	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-09T23:00:00.000Z	defillama-api	5.391330191883981	\N	63734626	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-10T23:00:00.000Z	defillama-api	5.391330191883981	\N	64335903	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-11T23:00:00.000Z	defillama-api	5.092179318211265	\N	64646111	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-12T23:00:00.000Z	defillama-api	5.09218912156939	\N	62124311	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-13T23:00:00.000Z	defillama-api	5.360976894408509	\N	65476413	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-14T23:00:00.000Z	defillama-api	5.360986697766634	\N	63382243	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-15T23:00:00.000Z	defillama-api	5.333012815356142	\N	64533841	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-16T23:00:00.000Z	defillama-api	5.333022618714267	\N	67554068	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-17T23:00:00.000Z	defillama-api	5.3252954717919465	\N	67796536	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-18T23:00:00.000Z	defillama-api	5.3252954717919465	\N	65503131	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-19T23:00:00.000Z	defillama-api	5.2899613681489654	\N	63698454	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-20T23:00:00.000Z	defillama-api	5.289971171507091	\N	65045815	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-21T23:00:00.000Z	defillama-api	5.26679673313879	\N	64813637	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-22T23:00:00.000Z	defillama-api	5.26679673313879	\N	66355669	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-23T23:00:00.000Z	defillama-api	5.061734989553202	\N	65392309	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-24T23:00:00.000Z	defillama-api	5.061725886434942	\N	65484787	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-25T23:00:00.000Z	defillama-api	5.293821790530728	\N	65436187	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-26T23:00:00.000Z	defillama-api	5.293821790530728	\N	65925430	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-27T23:00:00.000Z	defillama-api	5.251682755869069	\N	64234680	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-28T23:00:00.000Z	defillama-api	5.251682755869069	\N	63645385	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-29T23:00:00.000Z	defillama-api	5.2279880392802625	\N	63125087	1.0928	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-04-30T23:00:00.000Z	defillama-api	5.227997142398522	\N	62980916	1.0928	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-01T23:00:00.000Z	defillama-api	5.491773298516023	\N	62242628	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-02T23:00:00.000Z	defillama-api	5.491773298516023	\N	60183546	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-03T23:00:00.000Z	defillama-api	5.548617370365605	\N	61475541	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-04T23:00:00.000Z	defillama-api	5.548617370365605	\N	62039687	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-05T23:00:00.000Z	defillama-api	5.5089522831508475	\N	61339708	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-06T23:00:00.000Z	defillama-api	5.508961386269107	\N	61500285	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-07T23:00:00.000Z	defillama-api	5.433552555089705	\N	64898552	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-08T23:00:00.000Z	defillama-api	5.433542751731579	\N	63082680	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-09T23:00:00.000Z	defillama-api	5.463902351365846	\N	64143680	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-10T23:00:00.000Z	defillama-api	5.463902351365846	\N	64948636	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-11T23:00:00.000Z	defillama-api	5.333486877745486	\N	66253433	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-12T23:00:00.000Z	defillama-api	5.333486877745486	\N	63399353	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-13T23:00:00.000Z	defillama-api	5.4103073924949285	\N	67060799	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-14T23:00:00.000Z	defillama-api	5.4103073924949285	\N	64936790	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-15T23:00:00.000Z	defillama-api	5.395783717432323	\N	65117075	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-16T23:00:00.000Z	defillama-api	5.395783717432323	\N	68144393	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-17T23:00:00.000Z	defillama-api	5.5228912579252665	\N	68347536	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-18T23:00:00.000Z	defillama-api	5.5228912579252665	\N	65908885	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-19T23:00:00.000Z	defillama-api	5.408023910291604	\N	64000781	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-20T23:00:00.000Z	defillama-api	5.408033713649729	\N	67197670	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-21T23:00:00.000Z	defillama-api	5.206707749749739	\N	66874152	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-22T23:00:00.000Z	defillama-api	5.206707749749739	\N	68727136	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-23T23:00:00.000Z	defillama-api	5.25026897157943	\N	67550145	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-24T23:00:00.000Z	defillama-api	5.250259868461171	\N	67694793	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-25T23:00:00.000Z	defillama-api	5.3903736642269	\N	67595850	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-26T23:00:00.000Z	defillama-api	5.3903736642269	\N	68118753	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-27T23:00:00.000Z	defillama-api	5.315433993757779	\N	65567950	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-28T23:00:00.000Z	defillama-api	5.31542489063952	\N	65053506	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-29T23:00:00.000Z	defillama-api	5.328680431304633	\N	64381104	1.02279	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-04-30T23:00:00.000Z	defillama-api	5.328680431304633	\N	64368657	1.02279	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-01T23:00:00.000Z	defillama-api	5.360398496279117	\N	102006731	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-02T23:00:00.000Z	defillama-api	5.360398496279117	\N	99562547	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-03T23:00:00.000Z	defillama-api	5.37369535109633	\N	100757640	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-04T23:00:00.000Z	defillama-api	5.37369535109633	\N	102492384	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-05T23:00:00.000Z	defillama-api	5.37369535109633	\N	101880280	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-06T23:00:00.000Z	defillama-api	5.37369535109633	\N	102255935	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-07T23:00:00.000Z	defillama-api	5.336624652585442	\N	107623634	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-08T23:00:00.000Z	defillama-api	5.336624652585442	\N	105457179	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-09T23:00:00.000Z	defillama-api	5.3562096614001575	\N	107364840	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-10T23:00:00.000Z	defillama-api	5.3562096614001575	\N	108154618	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-11T23:00:00.000Z	defillama-api	5.3454126629048915	\N	108600994	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-12T23:00:00.000Z	defillama-api	5.3454126629048915	\N	104376395	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-13T23:00:00.000Z	defillama-api	5.304272870532145	\N	109801647	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-14T23:00:00.000Z	defillama-api	5.304272870532145	\N	106587208	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-15T23:00:00.000Z	defillama-api	5.301588851125416	\N	108635190	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-16T23:00:00.000Z	defillama-api	5.301588851125416	\N	113777818	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-17T23:00:00.000Z	defillama-api	5.321180162098926	\N	114205467	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-18T23:00:00.000Z	defillama-api	5.321180162098926	\N	110595637	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-19T23:00:00.000Z	defillama-api	5.324261917749595	\N	107285739	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-20T23:00:00.000Z	defillama-api	5.324261917749595	\N	109978702	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-21T23:00:00.000Z	defillama-api	5.324261917749595	\N	109500897	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-22T23:00:00.000Z	defillama-api	5.324261917749595	\N	112120748	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-23T23:00:00.000Z	defillama-api	5.361773067136255	\N	110903324	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-24T23:00:00.000Z	defillama-api	5.361773067136255	\N	111159961	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-25T23:00:00.000Z	defillama-api	5.332918282974219	\N	110859137	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-26T23:00:00.000Z	defillama-api	5.332918282974219	\N	111698751	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-27T23:00:00.000Z	defillama-api	5.325200239170158	\N	108741744	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-28T23:00:00.000Z	defillama-api	5.325200239170158	\N	107785282	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-29T23:00:00.000Z	defillama-api	5.317757389633471	\N	108987368	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-04-30T23:00:00.000Z	defillama-api	5.317757389633471	\N	108650815	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-01T23:00:00.000Z	defillama-api	5.564272633051814	\N	16032648	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-02T23:00:00.000Z	defillama-api	5.564272633051814	\N	15624291	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-03T23:00:00.000Z	defillama-api	5.59513220395047	\N	15830704	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-04T23:00:00.000Z	defillama-api	5.59513220395047	\N	15934420	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-05T23:00:00.000Z	defillama-api	5.592446083824143	\N	15694041	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-06T23:00:00.000Z	defillama-api	5.592446083824143	\N	16012858	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-07T23:00:00.000Z	defillama-api	5.578733986766338	\N	16201852	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-08T23:00:00.000Z	defillama-api	5.578733986766338	\N	15933799	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-09T23:00:00.000Z	defillama-api	5.578733986766338	\N	16165366	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-10T23:00:00.000Z	defillama-api	5.578733986766338	\N	16268094	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-11T23:00:00.000Z	defillama-api	5.578838322506385	\N	16347741	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-12T23:00:00.000Z	defillama-api	5.578838322506385	\N	15669655	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-13T23:00:00.000Z	defillama-api	5.555305361326646	\N	16476596	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-14T23:00:00.000Z	defillama-api	5.555305361326646	\N	16013630	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-15T23:00:00.000Z	defillama-api	5.5475200944954395	\N	16349014	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-16T23:00:00.000Z	defillama-api	5.5475200944954395	\N	17095245	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-17T23:00:00.000Z	defillama-api	5.542089734333899	\N	17194542	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-18T23:00:00.000Z	defillama-api	5.542089734333899	\N	16994213	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-19T23:00:00.000Z	defillama-api	5.535778472420816	\N	16068022	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-20T23:00:00.000Z	defillama-api	5.535778472420816	\N	16526938	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-21T23:00:00.000Z	defillama-api	5.52237097970476	\N	16392696	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-22T23:00:00.000Z	defillama-api	5.52237097970476	\N	16669931	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-23T23:00:00.000Z	defillama-api	5.496278641814456	\N	16412740	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-24T23:00:00.000Z	defillama-api	5.496278641814456	\N	16451589	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-25T23:00:00.000Z	defillama-api	5.476854688168942	\N	16364177	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-26T23:00:00.000Z	defillama-api	5.476854688168942	\N	16520504	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-27T23:00:00.000Z	defillama-api	5.455570197199222	\N	16124543	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-28T23:00:00.000Z	defillama-api	5.455570197199222	\N	15974486	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-29T23:00:00.000Z	defillama-api	5.41531830897668	\N	15821385	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-04-30T23:00:00.000Z	defillama-api	5.41531830897668	\N	15804481	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-01T23:00:00.000Z	defillama-api	5.978285252439264	\N	16956845	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-02T23:00:00.000Z	defillama-api	5.978285252439264	\N	16589506	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-03T23:00:00.000Z	defillama-api	6.006060266727786	\N	16742816	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-04T23:00:00.000Z	defillama-api	6.006060266727786	\N	16869569	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-05T23:00:00.000Z	defillama-api	5.978285252439264	\N	16667814	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-06T23:00:00.000Z	defillama-api	5.978285252439264	\N	16354131	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-07T23:00:00.000Z	defillama-api	5.984964140282045	\N	17063614	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-08T23:00:00.000Z	defillama-api	5.984964140282045	\N	16963576	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-09T23:00:00.000Z	defillama-api	5.994354356886333	\N	17815628	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-10T23:00:00.000Z	defillama-api	5.994354356886333	\N	17945335	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-11T23:00:00.000Z	defillama-api	6.002914789249303	\N	17847135	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-12T23:00:00.000Z	defillama-api	6.002914789249303	\N	17251926	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-13T23:00:00.000Z	defillama-api	6.034138484878326	\N	18135601	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-14T23:00:00.000Z	defillama-api	6.034138484878326	\N	17654264	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-15T23:00:00.000Z	defillama-api	6.050866515039388	\N	17985146	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-16T23:00:00.000Z	defillama-api	6.050866515039388	\N	18916311	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-17T23:00:00.000Z	defillama-api	6.044549651207376	\N	18980532	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-18T23:00:00.000Z	defillama-api	6.044549651207376	\N	18392397	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-19T23:00:00.000Z	defillama-api	5.978078681678767	\N	17808584	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-20T23:00:00.000Z	defillama-api	5.978078681678767	\N	18013012	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-21T23:00:00.000Z	defillama-api	5.960754047151795	\N	17851922	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-22T23:00:00.000Z	defillama-api	5.960754047151795	\N	18148247	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-23T23:00:00.000Z	defillama-api	5.931515531543141	\N	17501346	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-24T23:00:00.000Z	defillama-api	5.931515531543141	\N	17541551	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-25T23:00:00.000Z	defillama-api	5.931515531543141	\N	17518759	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-26T23:00:00.000Z	defillama-api	5.931515531543141	\N	17640444	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-27T23:00:00.000Z	defillama-api	5.910893467486744	\N	17185996	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-28T23:00:00.000Z	defillama-api	5.910893467486744	\N	16966513	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-29T23:00:00.000Z	defillama-api	5.879339258640925	\N	16787831	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-04-30T23:00:00.000Z	defillama-api	5.879339258640925	\N	16726902	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-01T23:00:00.000Z	defillama-api	5.102043597204897	\N	826356084	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-02T23:00:00.000Z	defillama-api	5.121921306283639	\N	805914163	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-03T23:00:00.000Z	defillama-api	5.121921306283639	\N	817635585	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-04T23:00:00.000Z	defillama-api	5.121921306283639	\N	826038678	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-05T23:00:00.000Z	defillama-api	5.121921306283639	\N	819100807	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-06T23:00:00.000Z	defillama-api	5.121921306283639	\N	820327352	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-07T23:00:00.000Z	defillama-api	5.120800222258026	\N	858103189	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-08T23:00:00.000Z	defillama-api	5.120800222258026	\N	844134508	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-09T23:00:00.000Z	defillama-api	5.067467153097027	\N	857985684	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-10T23:00:00.000Z	defillama-api	5.08604031530524	\N	866413606	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-11T23:00:00.000Z	defillama-api	5.053692034451274	\N	870639792	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-12T23:00:00.000Z	defillama-api	5.053692034451274	\N	836685806	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-13T23:00:00.000Z	defillama-api	5.055945406340356	\N	882300604	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-14T23:00:00.000Z	defillama-api	5.055945406340356	\N	853504872	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-15T23:00:00.000Z	defillama-api	5.02387301999363	\N	869129809	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-16T23:00:00.000Z	defillama-api	5.02387301999363	\N	910203601	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-17T23:00:00.000Z	defillama-api	5.02387301999363	\N	913771468	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-18T23:00:00.000Z	defillama-api	5.02387301999363	\N	882793149	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-19T23:00:00.000Z	defillama-api	5.02387301999363	\N	857448290	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-20T23:00:00.000Z	defillama-api	5.02387301999363	\N	876607383	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-21T23:00:00.000Z	defillama-api	4.992199770370576	\N	872541202	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-22T23:00:00.000Z	defillama-api	4.992199770370576	\N	893962791	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-23T23:00:00.000Z	defillama-api	4.961829667138318	\N	881786153	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-24T23:00:00.000Z	defillama-api	4.961829667138318	\N	882043730	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-25T23:00:00.000Z	defillama-api	4.993798417984863	\N	881852538	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-26T23:00:00.000Z	defillama-api	4.993798417984863	\N	888697364	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-27T23:00:00.000Z	defillama-api	5.046761060256699	\N	865712788	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-28T23:00:00.000Z	defillama-api	5.046761060256699	\N	813122434	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-29T23:00:00.000Z	defillama-api	5.031966392365916	\N	807417500	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-04-30T23:00:00.000Z	defillama-api	5.031966392365916	\N	735320485	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-01T23:00:00.000Z	defillama-api	5.8219847119289625	\N	5276721	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-02T23:00:00.000Z	defillama-api	5.8219847119289625	\N	5103176	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-03T23:00:00.000Z	defillama-api	5.893849629146075	\N	5051546	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-04T23:00:00.000Z	defillama-api	5.893849629146075	\N	5106805	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-05T23:00:00.000Z	defillama-api	5.893849629146075	\N	5035068	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-06T23:00:00.000Z	defillama-api	5.893849629146075	\N	5139461	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-07T23:00:00.000Z	defillama-api	5.817702044907946	\N	5290683	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-08T23:00:00.000Z	defillama-api	5.817702044907946	\N	5277798	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-09T23:00:00.000Z	defillama-api	5.777039115884008	\N	5387557	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-10T23:00:00.000Z	defillama-api	5.777039115884008	\N	5314216	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-11T23:00:00.000Z	defillama-api	5.715602170752732	\N	5400075	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-12T23:00:00.000Z	defillama-api	5.715602170752732	\N	5150293	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-13T23:00:00.000Z	defillama-api	5.587056337574836	\N	5410568	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-14T23:00:00.000Z	defillama-api	5.587056337574836	\N	5260256	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-15T23:00:00.000Z	defillama-api	5.593089604261081	\N	5270616	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-16T23:00:00.000Z	defillama-api	5.593089604261081	\N	5662515	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-17T23:00:00.000Z	defillama-api	5.593089604261081	\N	5657820	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-18T23:00:00.000Z	defillama-api	5.593089604261081	\N	5521174	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-19T23:00:00.000Z	defillama-api	5.6112909391003996	\N	5272329	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-20T23:00:00.000Z	defillama-api	5.6112909391003996	\N	5403513	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-21T23:00:00.000Z	defillama-api	5.4800260745224705	\N	5383576	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-22T23:00:00.000Z	defillama-api	5.4800260745224705	\N	5493650	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-23T23:00:00.000Z	defillama-api	5.635736312825657	\N	5383788	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-24T23:00:00.000Z	defillama-api	5.635736312825657	\N	5441399	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-25T23:00:00.000Z	defillama-api	5.510078268855523	\N	5416445	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-26T23:00:00.000Z	defillama-api	5.510078268855523	\N	5430154	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-27T23:00:00.000Z	defillama-api	5.603518976826649	\N	5375448	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-28T23:00:00.000Z	defillama-api	5.603518976826649	\N	5254958	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-29T23:00:00.000Z	defillama-api	5.427319720041623	\N	5244392	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-04-30T23:00:00.000Z	defillama-api	5.427319720041623	\N	5243522	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-01T23:00:00.000Z	defillama-api	5.91423921356693	\N	6804910	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-02T23:00:00.000Z	defillama-api	5.91636934323958	\N	6681182	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-03T23:00:00.000Z	defillama-api	5.949296722462805	\N	6776946	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-04T23:00:00.000Z	defillama-api	5.929753027800189	\N	6846226	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-05T23:00:00.000Z	defillama-api	5.896677897965219	\N	6791463	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-06T23:00:00.000Z	defillama-api	5.842710411485541	\N	6810369	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-07T23:00:00.000Z	defillama-api	5.85005802840044	\N	7246024	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-08T23:00:00.000Z	defillama-api	5.815258207775287	\N	7090898	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-09T23:00:00.000Z	defillama-api	5.832946967032626	\N	7208517	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-10T23:00:00.000Z	defillama-api	5.765749148523014	\N	7269527	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-11T23:00:00.000Z	defillama-api	5.787100162280012	\N	7309240	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-12T23:00:00.000Z	defillama-api	5.756384840793771	\N	7020685	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-13T23:00:00.000Z	defillama-api	5.810304710962555	\N	7491179	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-14T23:00:00.000Z	defillama-api	5.858121990698351	\N	7270491	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-15T23:00:00.000Z	defillama-api	5.8464833038840425	\N	7408537	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-16T23:00:00.000Z	defillama-api	5.832645163650341	\N	7850075	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-17T23:00:00.000Z	defillama-api	5.836908924194972	\N	7887655	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-18T23:00:00.000Z	defillama-api	5.8378430441763385	\N	7628102	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-19T23:00:00.000Z	defillama-api	5.8404276295220825	\N	7375845	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-20T23:00:00.000Z	defillama-api	5.840880684715444	\N	7585639	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-21T23:00:00.000Z	defillama-api	5.826871685954416	\N	7499645	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-22T23:00:00.000Z	defillama-api	5.814870975129338	\N	7707947	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-23T23:00:00.000Z	defillama-api	5.815880721016242	\N	7584639	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-24T23:00:00.000Z	defillama-api	5.809502236076014	\N	7579253	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-25T23:00:00.000Z	defillama-api	5.773546319431944	\N	7577077	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-26T23:00:00.000Z	defillama-api	5.731977980261149	\N	7630776	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-27T23:00:00.000Z	defillama-api	5.728710661045966	\N	7437886	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-28T23:00:00.000Z	defillama-api	5.719162890471807	\N	7361924	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-29T23:00:00.000Z	defillama-api	5.717557240458859	\N	7299426	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-04-30T23:00:00.000Z	defillama-api	5.711805470198783	\N	7320856	\N	\N
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
