-- Generated from VAULT_LLAMA_LST/solana/2025-08.ndjson (186 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-01T23:00:00.000Z	defillama-api	7.5768754470573185	\N	961933884	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-02T23:00:00.000Z	defillama-api	7.6364476534251935	\N	953315179	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-03T23:00:00.000Z	defillama-api	7.6364476534251935	\N	971604164	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-04T23:00:00.000Z	defillama-api	7.608602615150062	\N	1013077376	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-05T23:00:00.000Z	defillama-api	7.608602615150062	\N	981945379	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-06T23:00:00.000Z	defillama-api	7.523677524190475	\N	1010390910	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-07T23:00:00.000Z	defillama-api	7.546492039267605	\N	1049038572	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-08T23:00:00.000Z	defillama-api	7.54650184262573	\N	1067158765	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-09T23:00:00.000Z	defillama-api	7.592707870429649	\N	1089118428	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-10T23:00:00.000Z	defillama-api	7.592707870429649	\N	1102814628	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-11T23:00:00.000Z	defillama-api	7.624717235188427	\N	1063056743	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-12T23:00:00.000Z	defillama-api	7.624717235188427	\N	1163730837	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-13T23:00:00.000Z	defillama-api	7.668711205255363	\N	1222621550	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-14T23:00:00.000Z	defillama-api	7.668711205255363	\N	1154105891	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-15T23:00:00.000Z	defillama-api	7.761823500729292	\N	1125071565	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-16T23:00:00.000Z	defillama-api	7.761823500729292	\N	1128063753	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-17T23:00:00.000Z	defillama-api	7.8263436019909705	\N	1152256219	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-18T23:00:00.000Z	defillama-api	7.8263436019909705	\N	1098741577	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-19T23:00:00.000Z	defillama-api	7.733282424027266	\N	1055756906	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-20T23:00:00.000Z	defillama-api	7.733282424027266	\N	1104344713	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-21T23:00:00.000Z	defillama-api	7.59354255635003	\N	1066843150	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-22T23:00:00.000Z	defillama-api	7.59354255635003	\N	1170560977	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-23T23:00:00.000Z	defillama-api	7.549385430394295	\N	1194702045	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-24T23:00:00.000Z	defillama-api	7.549385430394295	\N	1202302421	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-25T23:00:00.000Z	defillama-api	7.381731200695185	\N	1102451454	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-26T23:00:00.000Z	defillama-api	7.381731200695185	\N	1154260430	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-27T23:00:00.000Z	defillama-api	7.284740976842841	\N	1212311225	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-28T23:00:00.000Z	defillama-api	7.284740976842841	\N	1267253402	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-29T23:00:00.000Z	defillama-api	7.214204414651704	\N	1181711796	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-30T23:00:00.000Z	defillama-api	7.214204414651704	\N	1172638395	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2025-08-31T23:00:00.000Z	defillama-api	7.019468408131502	\N	1189459770	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-01T23:00:00.000Z	defillama-api	5.863648283721545	\N	830793816	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-02T23:00:00.000Z	defillama-api	7.826176944902841	\N	822432361	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-03T23:00:00.000Z	defillama-api	5.8543589016579745	\N	838121229	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-04T23:00:00.000Z	defillama-api	7.827073952171304	\N	872087234	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-05T23:00:00.000Z	defillama-api	5.911986541917713	\N	845042125	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-06T23:00:00.000Z	defillama-api	7.810140751729477	\N	869245930	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-07T23:00:00.000Z	defillama-api	6.427920474294524	\N	813469000	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-08T23:00:00.000Z	defillama-api	8.711991579346545	\N	829250397	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-09T23:00:00.000Z	defillama-api	7.864683835379083	\N	841950102	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-10T23:00:00.000Z	defillama-api	7.8607372834937905	\N	852821072	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-11T23:00:00.000Z	defillama-api	9.377855269931956	\N	815053471	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-12T23:00:00.000Z	defillama-api	9.377664104448513	\N	892000323	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-13T23:00:00.000Z	defillama-api	9.419228242180111	\N	943252362	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-14T23:00:00.000Z	defillama-api	8.844805374508269	\N	893990322	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-15T23:00:00.000Z	defillama-api	8.62087986917004	\N	870563865	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-16T23:00:00.000Z	defillama-api	7.506146318903006	\N	881340186	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-17T23:00:00.000Z	defillama-api	9.533954141360823	\N	898950671	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-18T23:00:00.000Z	defillama-api	6.039325161566467	\N	856427087	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-19T23:00:00.000Z	defillama-api	8.003030925962662	\N	830232843	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-20T23:00:00.000Z	defillama-api	6.0602973455559095	\N	868578892	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-21T23:00:00.000Z	defillama-api	8.02409344089483	\N	841532247	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-22T23:00:00.000Z	defillama-api	5.959689682555336	\N	926780064	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-23T23:00:00.000Z	defillama-api	8.060706882773161	\N	945952537	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-24T23:00:00.000Z	defillama-api	6.0339025040434535	\N	953199873	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-25T23:00:00.000Z	defillama-api	7.98160358606026	\N	872568684	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-26T23:00:00.000Z	defillama-api	6.021823366353374	\N	916674272	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-27T23:00:00.000Z	defillama-api	7.777478063175636	\N	955917015	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-28T23:00:00.000Z	defillama-api	5.891162808779882	\N	988585197	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-29T23:00:00.000Z	defillama-api	7.868159826074361	\N	936206692	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-30T23:00:00.000Z	defillama-api	5.763294807792363	\N	928495424	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2025-08-31T23:00:00.000Z	defillama-api	7.22127473657963	\N	940065848	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-01T23:00:00.000Z	defillama-api	6.363186099633822	\N	343827284	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-02T23:00:00.000Z	defillama-api	6.353802185188329	\N	345994659	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-03T23:00:00.000Z	defillama-api	6.353802185188329	\N	347557283	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-04T23:00:00.000Z	defillama-api	6.306869308403407	\N	363988352	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-05T23:00:00.000Z	defillama-api	6.306869308403407	\N	349841708	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-06T23:00:00.000Z	defillama-api	6.250520306139151	\N	361530662	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-07T23:00:00.000Z	defillama-api	6.250520306139151	\N	373262219	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-08T23:00:00.000Z	defillama-api	6.250520306139151	\N	380409462	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-09T23:00:00.000Z	defillama-api	6.269307041506522	\N	386338413	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-10T23:00:00.000Z	defillama-api	6.269307041506522	\N	393458740	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-11T23:00:00.000Z	defillama-api	6.32564483993292	\N	375464742	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-12T23:00:00.000Z	defillama-api	6.32564483993292	\N	411701526	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-13T23:00:00.000Z	defillama-api	6.428848992356961	\N	414285236	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-14T23:00:00.000Z	defillama-api	6.428848992356961	\N	394556624	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-15T23:00:00.000Z	defillama-api	6.5225781991529175	\N	387022430	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-16T23:00:00.000Z	defillama-api	6.5225781991529175	\N	391568485	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-17T23:00:00.000Z	defillama-api	6.56004593366788	\N	399381400	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-18T23:00:00.000Z	defillama-api	6.56004593366788	\N	381486348	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-19T23:00:00.000Z	defillama-api	6.494469170448269	\N	373925485	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-20T23:00:00.000Z	defillama-api	6.494469170448269	\N	391985652	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-21T23:00:00.000Z	defillama-api	6.419471380070263	\N	382601640	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-22T23:00:00.000Z	defillama-api	6.419471380070263	\N	420466418	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-23T23:00:00.000Z	defillama-api	6.3162574242880964	\N	428975906	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-24T23:00:00.000Z	defillama-api	6.3162574242880964	\N	431010857	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-25T23:00:00.000Z	defillama-api	6.212937032046284	\N	408793810	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-26T23:00:00.000Z	defillama-api	6.212937032046284	\N	426721139	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-27T23:00:00.000Z	defillama-api	6.184740473358374	\N	446807396	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-28T23:00:00.000Z	defillama-api	6.184740473358374	\N	468110379	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-29T23:00:00.000Z	defillama-api	6.184740473358374	\N	443476849	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-30T23:00:00.000Z	defillama-api	6.184740473358374	\N	440102641	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2025-08-31T23:00:00.000Z	defillama-api	6.194140493320788	\N	445298159	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-01T23:00:00.000Z	defillama-api	6.833234714065384	\N	90937162	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-02T23:00:00.000Z	defillama-api	6.863246994726069	\N	88036869	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-03T23:00:00.000Z	defillama-api	6.863246994726069	\N	90281436	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-04T23:00:00.000Z	defillama-api	6.825734444859677	\N	93553508	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-05T23:00:00.000Z	defillama-api	6.825734444859677	\N	91099719	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-06T23:00:00.000Z	defillama-api	6.749471321043643	\N	93992724	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-07T23:00:00.000Z	defillama-api	6.68304586710633	\N	96743609	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-08T23:00:00.000Z	defillama-api	6.702227537758176	\N	99750290	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-09T23:00:00.000Z	defillama-api	6.714954397324391	\N	102445671	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-10T23:00:00.000Z	defillama-api	6.714964200682516	\N	102528810	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-11T23:00:00.000Z	defillama-api	6.714964200682516	\N	98705405	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-12T23:00:00.000Z	defillama-api	6.714964200682516	\N	107081242	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-13T23:00:00.000Z	defillama-api	6.805043757296403	\N	112287803	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-14T23:00:00.000Z	defillama-api	6.805043757296403	\N	107658433	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-15T23:00:00.000Z	defillama-api	6.911805128240189	\N	103046393	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-16T23:00:00.000Z	defillama-api	6.911805128240189	\N	105538487	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-17T23:00:00.000Z	defillama-api	6.946645562777576	\N	94829707	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-18T23:00:00.000Z	defillama-api	6.946645562777576	\N	90942861	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-19T23:00:00.000Z	defillama-api	6.946645562777576	\N	87675249	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-20T23:00:00.000Z	defillama-api	6.946645562777576	\N	92785247	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-21T23:00:00.000Z	defillama-api	6.835261208237853	\N	89255839	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-22T23:00:00.000Z	defillama-api	6.835261208237853	\N	98298115	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-23T23:00:00.000Z	defillama-api	6.768659293854284	\N	100479602	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-24T23:00:00.000Z	defillama-api	6.768659293854284	\N	101015846	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-25T23:00:00.000Z	defillama-api	6.691341608799917	\N	93155783	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-26T23:00:00.000Z	defillama-api	6.691341608799917	\N	97099709	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-27T23:00:00.000Z	defillama-api	6.651369116283945	\N	102949886	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-28T23:00:00.000Z	defillama-api	6.651369116283945	\N	104169630	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-29T23:00:00.000Z	defillama-api	6.626833411615962	\N	92932421	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-30T23:00:00.000Z	defillama-api	6.626833411615962	\N	92107890	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2025-08-31T23:00:00.000Z	defillama-api	6.6497977780244355	\N	94155572	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-01T23:00:00.000Z	defillama-api	7.779347003378234	\N	267546293	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-02T23:00:00.000Z	defillama-api	7.874195193480205	\N	265411492	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-03T23:00:00.000Z	defillama-api	7.874195193480205	\N	270481014	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-04T23:00:00.000Z	defillama-api	7.779347003378234	\N	281848376	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-05T23:00:00.000Z	defillama-api	7.779347003378234	\N	273048918	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-06T23:00:00.000Z	defillama-api	7.643599903417453	\N	281832723	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-07T23:00:00.000Z	defillama-api	7.681640434142878	\N	292524589	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-08T23:00:00.000Z	defillama-api	7.681640434142878	\N	297441549	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-09T23:00:00.000Z	defillama-api	7.701280061667148	\N	302780963	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-10T23:00:00.000Z	defillama-api	7.701280061667148	\N	307695487	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-11T23:00:00.000Z	defillama-api	7.66719238498581	\N	294079469	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-12T23:00:00.000Z	defillama-api	7.66719238498581	\N	322167569	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-13T23:00:00.000Z	defillama-api	7.753670607968388	\N	344722337	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-14T23:00:00.000Z	defillama-api	7.753670607968388	\N	326541198	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-15T23:00:00.000Z	defillama-api	7.753670607968388	\N	321788766	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-16T23:00:00.000Z	defillama-api	7.753670607968388	\N	324744057	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-17T23:00:00.000Z	defillama-api	7.652761141585529	\N	331933339	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-18T23:00:00.000Z	defillama-api	7.652761141585529	\N	317509202	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-19T23:00:00.000Z	defillama-api	7.452223647774758	\N	307602163	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-20T23:00:00.000Z	defillama-api	7.452223647774758	\N	322084069	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-21T23:00:00.000Z	defillama-api	7.23350792704025	\N	311674351	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-22T23:00:00.000Z	defillama-api	7.23350792704025	\N	341958348	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-23T23:00:00.000Z	defillama-api	7.086201967609895	\N	349414569	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-24T23:00:00.000Z	defillama-api	7.086201967609895	\N	349712649	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-25T23:00:00.000Z	defillama-api	7.086201967609895	\N	322726035	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-26T23:00:00.000Z	defillama-api	7.086201967609895	\N	337971856	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-27T23:00:00.000Z	defillama-api	7.10203719194169	\N	352894914	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-28T23:00:00.000Z	defillama-api	7.10203719194169	\N	363799314	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-29T23:00:00.000Z	defillama-api	7.197687856930202	\N	348897359	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-30T23:00:00.000Z	defillama-api	7.197687856930202	\N	345311719	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2025-08-31T23:00:00.000Z	defillama-api	7.343752291077976	\N	349987558	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-01T23:00:00.000Z	defillama-api	5.52048803470484	\N	1699580068	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-02T23:00:00.000Z	defillama-api	5.501399495955184	\N	1686798246	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-03T23:00:00.000Z	defillama-api	5.501399495955184	\N	1711162234	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-04T23:00:00.000Z	defillama-api	5.528161963397338	\N	1782285902	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-05T23:00:00.000Z	defillama-api	5.528161963397338	\N	1702612444	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-06T23:00:00.000Z	defillama-api	5.409795517152816	\N	1751747616	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-07T23:00:00.000Z	defillama-api	5.584739243857939	\N	1808336466	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-08T23:00:00.000Z	defillama-api	5.584739243857939	\N	1846503153	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-09T23:00:00.000Z	defillama-api	5.5496768332830015	\N	1866752242	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-10T23:00:00.000Z	defillama-api	5.5496768332830015	\N	1892149329	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-11T23:00:00.000Z	defillama-api	5.587027627740326	\N	1795493567	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-12T23:00:00.000Z	defillama-api	5.587027627740326	\N	1976376194	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-13T23:00:00.000Z	defillama-api	5.718162247703162	\N	2087909903	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-14T23:00:00.000Z	defillama-api	5.718162247703162	\N	1979506322	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-15T23:00:00.000Z	defillama-api	5.915983511073364	\N	1948991296	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-16T23:00:00.000Z	defillama-api	5.915983511073364	\N	1962120360	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-17T23:00:00.000Z	defillama-api	5.85067073828327	\N	1981062133	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-18T23:00:00.000Z	defillama-api	5.85067073828327	\N	1945860923	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-19T23:00:00.000Z	defillama-api	5.492028886067146	\N	1891093213	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-20T23:00:00.000Z	defillama-api	5.492028886067146	\N	1986542521	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-21T23:00:00.000Z	defillama-api	5.574449919265589	\N	1927654955	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-22T23:00:00.000Z	defillama-api	5.574449919265589	\N	2130656495	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-23T23:00:00.000Z	defillama-api	5.657974530492993	\N	2185874548	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-24T23:00:00.000Z	defillama-api	5.657974530492993	\N	2193003583	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-25T23:00:00.000Z	defillama-api	5.494111399428903	\N	2044353483	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-26T23:00:00.000Z	defillama-api	5.494111399428903	\N	2189425110	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-27T23:00:00.000Z	defillama-api	5.337298283336622	\N	2301770866	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-28T23:00:00.000Z	defillama-api	5.337298283336622	\N	2452564821	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-29T23:00:00.000Z	defillama-api	5.497235169471537	\N	2330336480	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-30T23:00:00.000Z	defillama-api	5.497235169471537	\N	2313374956	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2025-08-31T23:00:00.000Z	defillama-api	5.71740668888765	\N	2347074508	\N	\N
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
