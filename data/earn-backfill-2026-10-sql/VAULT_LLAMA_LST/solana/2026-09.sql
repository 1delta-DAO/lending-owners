-- Generated from VAULT_LLAMA_LST/solana/2026-09.ndjson (535 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-01T23:00:00.000Z	defillama-api	5.151815246406954	\N	516785778	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-02T23:00:00.000Z	defillama-api	5.041284484263997	\N	515229923	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-03T20:00:00.000Z	defillama-api	5.041284484263997	\N	544837245	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-04T23:00:00.000Z	defillama-api	4.956405609135572	\N	525656669	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-05T23:00:00.000Z	defillama-api	4.906260031845022	\N	534743791	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-06T23:00:00.000Z	defillama-api	4.906260031845022	\N	546908121	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-07T23:00:00.000Z	defillama-api	5.504664714450769	\N	535463827	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-08T23:00:00.000Z	defillama-api	5.392467381426513	\N	535280235	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-09T23:00:00.000Z	defillama-api	5.3926284365957144	\N	523907733	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-10T23:00:00.000Z	defillama-api	5.364047446221321	\N	514808281	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-11T23:00:00.000Z	defillama-api	5.370937806503662	\N	525732792	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-12T23:00:00.000Z	defillama-api	5.3711275715073725	\N	524967940	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-13T23:00:00.000Z	defillama-api	5.352247003997945	\N	516821012	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-14T23:00:00.000Z	defillama-api	5.352247003997945	\N	532216882	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-15T23:00:00.000Z	defillama-api	5.215488057430662	\N	502024123	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-16T23:00:00.000Z	defillama-api	5.198477130363699	\N	505030471	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-17T23:00:00.000Z	defillama-api	5.198477130363699	\N	526753654	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-18T23:00:00.000Z	defillama-api	5.203679212328893	\N	585166867	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-19T23:00:00.000Z	defillama-api	5.311024583321	\N	570751734	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-20T23:00:00.000Z	defillama-api	5.316771451902014	\N	570372110	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-21T23:00:00.000Z	defillama-api	5.316420631729102	\N	615225954	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-22T23:00:00.000Z	defillama-api	5.269206258518011	\N	612975065	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-23T23:00:00.000Z	defillama-api	5.373515389450745	\N	596517295	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-24T23:00:00.000Z	defillama-api	5.36993296229582	\N	603217318	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-25T23:00:00.000Z	defillama-api	5.3702935858268575	\N	632687359	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-26T23:00:00.000Z	defillama-api	5.361536386061516	\N	626925078	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-27T23:00:00.000Z	defillama-api	5.3585029469616074	\N	627161926	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-28T23:00:00.000Z	defillama-api	5.3636875229301495	\N	610995158	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-29T23:00:00.000Z	defillama-api	5.363413028902642	\N	614709637	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-09-30T23:00:00.000Z	defillama-api	5.382707438172929	\N	610284471	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-01T23:00:00.000Z	defillama-api	5.382991735558562	\N	231240185	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-02T23:00:00.000Z	defillama-api	5.143798900419938	\N	230271800	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-03T23:00:00.000Z	defillama-api	5.143532809270823	\N	240724021	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-04T23:00:00.000Z	defillama-api	4.847373360306051	\N	234651793	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-05T23:00:00.000Z	defillama-api	6.002717321607065	\N	238474936	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-06T23:00:00.000Z	defillama-api	4.719956313792295	\N	243856043	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-07T23:00:00.000Z	defillama-api	4.668452271161527	\N	238221566	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-08T23:00:00.000Z	defillama-api	5.81773005450259	\N	237805035	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-09T23:00:00.000Z	defillama-api	4.639224259150865	\N	232889894	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-10T23:00:00.000Z	defillama-api	5.827258918600364	\N	229247712	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-11T23:00:00.000Z	defillama-api	5.838399734869881	\N	233690061	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-12T23:00:00.000Z	defillama-api	4.680524406452946	\N	233347533	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-13T23:00:00.000Z	defillama-api	5.9398833979429355	\N	229617093	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-14T23:00:00.000Z	defillama-api	4.790005509036632	\N	236476550	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-15T23:00:00.000Z	defillama-api	4.780062803177998	\N	222942769	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-16T23:00:00.000Z	defillama-api	5.889635585631936	\N	224104591	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-17T23:00:00.000Z	defillama-api	4.702212935825401	\N	232721050	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-18T23:00:00.000Z	defillama-api	4.633142675913859	\N	259307461	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-19T23:00:00.000Z	defillama-api	5.576946974628072	\N	252269524	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-20T23:00:00.000Z	defillama-api	5.259577260119386	\N	252669657	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-21T23:00:00.000Z	defillama-api	5.259690698977693	\N	271727746	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-22T23:00:00.000Z	defillama-api	5.03684426327311	\N	270456990	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-23T23:00:00.000Z	defillama-api	4.858014205311179	\N	262272396	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-24T23:00:00.000Z	defillama-api	5.8001701393806115	\N	264880880	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-25T23:00:00.000Z	defillama-api	4.678825624537808	\N	278345377	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-26T23:00:00.000Z	defillama-api	4.6735766265015855	\N	275319259	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-27T23:00:00.000Z	defillama-api	4.650965881225488	\N	275476493	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-28T23:00:00.000Z	defillama-api	5.572889084604071	\N	268765492	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-29T23:00:00.000Z	defillama-api	4.653524557696187	\N	270421996	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-09-30T23:00:00.000Z	defillama-api	4.676402094361265	\N	268287959	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-01T23:00:00.000Z	defillama-api	4.200529584963419	\N	121136918	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-02T23:00:00.000Z	defillama-api	4.286790033347643	\N	121314435	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-03T23:00:00.000Z	defillama-api	4.286790033347643	\N	127063910	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-04T23:00:00.000Z	defillama-api	4.583341616637426	\N	125683592	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-05T23:00:00.000Z	defillama-api	4.3634039773365885	\N	127817824	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-06T23:00:00.000Z	defillama-api	4.3634039773365885	\N	131883974	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-07T23:00:00.000Z	defillama-api	4.5928928884109155	\N	129090162	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-08T23:00:00.000Z	defillama-api	4.640637343200638	\N	129045178	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-09T23:00:00.000Z	defillama-api	4.640637343200638	\N	126441314	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-10T23:00:00.000Z	defillama-api	4.70744092666564	\N	124345116	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-11T23:00:00.000Z	defillama-api	4.8123277554879	\N	127561249	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-12T23:00:00.000Z	defillama-api	4.82185731982554	\N	126887596	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-13T23:00:00.000Z	defillama-api	4.688358690074779	\N	124933585	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-14T23:00:00.000Z	defillama-api	4.688358690074779	\N	128568006	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-15T23:00:00.000Z	defillama-api	4.70744092666564	\N	121160372	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-16T23:00:00.000Z	defillama-api	4.659728682909758	\N	122546642	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-17T23:00:00.000Z	defillama-api	4.659728682909758	\N	127073688	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-18T23:00:00.000Z	defillama-api	4.745594196009506	\N	142171011	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-19T23:00:00.000Z	defillama-api	5.732506661360048	\N	138595209	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-20T23:00:00.000Z	defillama-api	4.688358690074779	\N	137960392	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-21T23:00:00.000Z	defillama-api	4.678815821179683	\N	149141305	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-22T23:00:00.000Z	defillama-api	4.5928928884109155	\N	148687474	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-23T23:00:00.000Z	defillama-api	4.82185731982554	\N	144360584	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-24T23:00:00.000Z	defillama-api	4.755130062505941	\N	146498807	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-25T23:00:00.000Z	defillama-api	4.76466522876251	\N	155780619	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-26T23:00:00.000Z	defillama-api	4.650183713295064	\N	154659694	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-27T23:00:00.000Z	defillama-api	4.621542502292186	\N	154872752	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-28T23:00:00.000Z	defillama-api	4.869491836956286	\N	150760887	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-29T23:00:00.000Z	defillama-api	4.859967174297708	\N	151510998	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-09-30T23:00:00.000Z	defillama-api	4.783732760316184	\N	150431552	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-01T23:00:00.000Z	defillama-api	4.864548843741545	\N	92187594	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-02T23:00:00.000Z	defillama-api	4.782474429276817	\N	91957792	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-03T21:00:00.000Z	defillama-api	4.782474429276817	\N	97118858	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-04T23:00:00.000Z	defillama-api	4.708223094596065	\N	93864771	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-05T23:00:00.000Z	defillama-api	4.6617327694065125	\N	95353214	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-06T23:00:00.000Z	defillama-api	4.6617327694065125	\N	97640179	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-07T23:00:00.000Z	defillama-api	5.353943685193485	\N	95265863	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-08T23:00:00.000Z	defillama-api	5.267508176842739	\N	95449215	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-09T23:00:00.000Z	defillama-api	5.267669932251806	\N	93283037	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-10T23:00:00.000Z	defillama-api	5.251417364959821	\N	91974084	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-11T23:00:00.000Z	defillama-api	5.156611889489682	\N	94109634	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-12T23:00:00.000Z	defillama-api	5.157095755237151	\N	93992360	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-13T23:00:00.000Z	defillama-api	5.136883331502418	\N	92457758	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-14T23:00:00.000Z	defillama-api	5.136883331502418	\N	95177173	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-15T23:00:00.000Z	defillama-api	5.035141980158642	\N	89794375	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-16T23:00:00.000Z	defillama-api	5.030976953435129	\N	90668112	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-17T23:00:00.000Z	defillama-api	5.030976953435129	\N	95800811	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-18T23:00:00.000Z	defillama-api	5.032726852860492	\N	107031505	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-19T23:00:00.000Z	defillama-api	5.111165621940472	\N	104625803	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-20T23:00:00.000Z	defillama-api	5.17459825069011	\N	104554465	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-21T23:00:00.000Z	defillama-api	5.174208917324563	\N	112691103	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-22T23:00:00.000Z	defillama-api	5.072144055162653	\N	112274287	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-23T23:00:00.000Z	defillama-api	5.06472011210235	\N	109135021	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-24T23:00:00.000Z	defillama-api	5.0593107591367925	\N	110371875	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-25T23:00:00.000Z	defillama-api	5.059672082907696	\N	115756586	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-26T23:00:00.000Z	defillama-api	5.053188561987554	\N	114776537	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-27T23:00:00.000Z	defillama-api	5.048634201898494	\N	114973922	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-28T23:00:00.000Z	defillama-api	5.04328156836209	\N	112226805	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-29T23:00:00.000Z	defillama-api	5.043024580331235	\N	112972776	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-09-30T23:00:00.000Z	defillama-api	5.042273222954918	\N	112162760	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-01T23:00:00.000Z	defillama-api	4.761308979084333	\N	280382732	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-02T23:00:00.000Z	defillama-api	4.688367793193038	\N	279840064	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-03T20:00:00.000Z	defillama-api	4.688367793193038	\N	296231715	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-04T23:00:00.000Z	defillama-api	4.615965791998633	\N	285793652	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-05T23:00:00.000Z	defillama-api	4.572718977868817	\N	290416494	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-06T23:00:00.000Z	defillama-api	4.572718977868817	\N	297232195	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-07T23:00:00.000Z	defillama-api	5.167143497075699	\N	290701832	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-08T23:00:00.000Z	defillama-api	5.080813024704867	\N	290639889	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-09T23:00:00.000Z	defillama-api	5.0809649767558085	\N	284885008	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-10T23:00:00.000Z	defillama-api	5.068085464898786	\N	280387686	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-11T23:00:00.000Z	defillama-api	5.067458049978768	\N	286388138	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-12T23:00:00.000Z	defillama-api	5.067628908506094	\N	285995147	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-13T23:00:00.000Z	defillama-api	5.054091871414812	\N	281280414	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-14T23:00:00.000Z	defillama-api	5.054091871414812	\N	289679598	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-15T23:00:00.000Z	defillama-api	4.963009571312682	\N	273268638	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-16T23:00:00.000Z	defillama-api	4.950114654178606	\N	274903426	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-17T23:00:00.000Z	defillama-api	4.950114654178606	\N	285295796	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-18T23:00:00.000Z	defillama-api	4.947060207882714	\N	317913452	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-19T23:00:00.000Z	defillama-api	5.036273567782246	\N	311604995	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-20T23:00:00.000Z	defillama-api	5.030834104502446	\N	311547252	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-21T23:00:00.000Z	defillama-api	5.030501490566053	\N	335181239	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-22T23:00:00.000Z	defillama-api	5.01873816105558	\N	333897853	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-23T23:00:00.000Z	defillama-api	5.016379052946718	\N	324650237	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-24T23:00:00.000Z	defillama-api	5.009473987627189	\N	328296932	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-25T23:00:00.000Z	defillama-api	5.0098164049217075	\N	344463105	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-26T23:00:00.000Z	defillama-api	5.001950610505901	\N	341433910	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-27T23:00:00.000Z	defillama-api	4.991505832663279	\N	343724407	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-28T23:00:00.000Z	defillama-api	4.987005391043908	\N	333919985	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-29T23:00:00.000Z	defillama-api	4.9867392998947935	\N	335992391	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-09-30T23:00:00.000Z	defillama-api	4.982362800731721	\N	333475394	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-01T23:00:00.000Z	defillama-api	4.65127188604697	\N	131574641	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-02T23:00:00.000Z	defillama-api	4.5489577384927316	\N	131299485	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-03T20:00:00.000Z	defillama-api	4.5489577384927316	\N	138991002	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-04T23:00:00.000Z	defillama-api	4.5227918754164875	\N	134395012	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-05T23:00:00.000Z	defillama-api	4.455386785906512	\N	136564395	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-06T23:00:00.000Z	defillama-api	4.455386785906512	\N	139508119	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-07T23:00:00.000Z	defillama-api	4.994292787330323	\N	136734326	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-08T23:00:00.000Z	defillama-api	4.878787521178651	\N	136695644	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-09T23:00:00.000Z	defillama-api	4.878940173469459	\N	133583403	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-10T22:00:00.000Z	defillama-api	4.839751249363644	\N	131868534	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-11T23:00:00.000Z	defillama-api	4.895252961389929	\N	135582410	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-12T23:00:00.000Z	defillama-api	4.895424520157121	\N	134216709	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-13T23:00:00.000Z	defillama-api	4.9225406087316514	\N	132327858	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-14T23:00:00.000Z	defillama-api	4.9225406087316514	\N	135951891	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-15T23:00:00.000Z	defillama-api	4.8901587163641125	\N	147070525	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-16T23:00:00.000Z	defillama-api	4.972363375443933	\N	155063339	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-17T23:00:00.000Z	defillama-api	4.972363375443933	\N	161298684	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-18T23:00:00.000Z	defillama-api	4.888073402042892	\N	179475643	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-19T23:00:00.000Z	defillama-api	4.975569773790767	\N	175913234	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-20T23:00:00.000Z	defillama-api	4.966378425308449	\N	175784523	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-21T23:00:00.000Z	defillama-api	4.966045111132189	\N	189644594	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-22T23:00:00.000Z	defillama-api	4.956938491673668	\N	188545478	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-23T23:00:00.000Z	defillama-api	4.954283182101449	\N	207018867	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-24T23:00:00.000Z	defillama-api	4.9454419535521765	\N	209820670	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-25T23:00:00.000Z	defillama-api	4.945784370846695	\N	220025739	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-26T23:00:00.000Z	defillama-api	4.872949621415046	\N	218472619	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-27T23:00:00.000Z	defillama-api	4.879120835354911	\N	218784094	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-28T23:00:00.000Z	defillama-api	4.877273602588161	\N	213327010	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-29T23:00:00.000Z	defillama-api	4.8770068111991804	\N	217987119	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-09-30T23:00:00.000Z	defillama-api	4.875006926141623	\N	216934823	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-01T23:00:00.000Z	defillama-api	5.1876542229933875	\N	165356431	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-02T23:00:00.000Z	defillama-api	5.016512098521275	\N	164805450	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-03T20:00:00.000Z	defillama-api	5.016512098521275	\N	174095958	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-04T23:00:00.000Z	defillama-api	4.848126118162099	\N	168045692	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-05T23:00:00.000Z	defillama-api	4.714786442860941	\N	170928047	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-06T23:00:00.000Z	defillama-api	4.714786442860941	\N	174897569	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-07T23:00:00.000Z	defillama-api	5.407086289110907	\N	170606995	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-08T23:00:00.000Z	defillama-api	4.765342360713021	\N	170441800	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-09T23:00:00.000Z	defillama-api	4.765342360713021	\N	166735707	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-10T23:00:00.000Z	defillama-api	4.241033559537755	\N	163242905	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-11T23:00:00.000Z	defillama-api	3.7830808885530587	\N	166317551	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-12T23:00:00.000Z	defillama-api	3.7830808885530587	\N	165808889	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-13T23:00:00.000Z	defillama-api	3.282646765612185	\N	162826677	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-14T23:00:00.000Z	defillama-api	3.282646765612185	\N	166558880	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-15T23:00:00.000Z	defillama-api	2.687900136066901	\N	157600747	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-16T23:00:00.000Z	defillama-api	2.4741393126248568	\N	158355678	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-17T23:00:00.000Z	defillama-api	2.4741393126248568	\N	164277388	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-18T23:00:00.000Z	defillama-api	1.6792515250330098	\N	182781377	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-19T23:00:00.000Z	defillama-api	1.6792515250330098	\N	178407803	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-20T23:00:00.000Z	defillama-api	1.6792515250330098	\N	178409359	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-21T23:00:00.000Z	defillama-api	1.6792515250330098	\N	191548387	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-22T23:00:00.000Z	defillama-api	1.6792515250330098	\N	190581025	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-23T23:00:00.000Z	defillama-api	4.437051005012904	\N	184695469	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-24T23:00:00.000Z	defillama-api	4.907773950435512	\N	186766393	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-25T23:00:00.000Z	defillama-api	4.908107264611772	\N	196050849	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-26T23:00:00.000Z	defillama-api	5.416104678346301	\N	193315341	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-27T23:00:00.000Z	defillama-api	5.954498104188133	\N	194275655	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-28T23:00:00.000Z	defillama-api	6.490467299613556	\N	189612258	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-29T23:00:00.000Z	defillama-api	6.490167596950869	\N	190663426	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-09-30T23:00:00.000Z	defillama-api	4.991904969386951	\N	189440391	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-01T23:00:00.000Z	defillama-api	4.608775729053605	\N	127033597	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-02T23:00:00.000Z	defillama-api	4.527513592833543	\N	126957023	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-03T20:00:00.000Z	defillama-api	4.527513592833543	\N	134687224	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-04T23:00:00.000Z	defillama-api	4.455788723589649	\N	129381178	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-05T23:00:00.000Z	defillama-api	4.418768442349119	\N	131518225	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-06T23:00:00.000Z	defillama-api	4.418768442349119	\N	134609071	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-07T23:00:00.000Z	defillama-api	4.9932844419231515	\N	131621210	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-08T23:00:00.000Z	defillama-api	4.909612080084003	\N	131280601	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-09T23:00:00.000Z	defillama-api	4.9097640321349445	\N	128241781	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-10T23:00:00.000Z	defillama-api	4.885787819119969	\N	126336404	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-11T23:00:00.000Z	defillama-api	4.85122187861009	\N	129179133	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-12T23:00:00.000Z	defillama-api	4.8513843342590235	\N	128911355	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-13T23:00:00.000Z	defillama-api	4.8399228081308365	\N	126762588	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-14T23:00:00.000Z	defillama-api	4.8399228081308365	\N	130633782	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-15T23:00:00.000Z	defillama-api	4.759669017317947	\N	123910018	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-16T23:00:00.000Z	defillama-api	4.743200075907339	\N	123773509	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-17T23:00:00.000Z	defillama-api	4.743200075907339	\N	128613676	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-18T23:00:00.000Z	defillama-api	4.736419653283974	\N	142974479	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-19T23:00:00.000Z	defillama-api	4.819246125364884	\N	140205345	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-20T23:00:00.000Z	defillama-api	4.824344571829897	\N	140090529	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-21T23:00:00.000Z	defillama-api	4.8240105574137715	\N	149629952	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-22T23:00:00.000Z	defillama-api	4.821599631554818	\N	150415594	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-23T23:00:00.000Z	defillama-api	4.821962355805454	\N	145630193	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-24T23:00:00.000Z	defillama-api	4.831652975312295	\N	147700432	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-25T23:00:00.000Z	defillama-api	4.831986289488555	\N	153266061	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-26T23:00:00.000Z	defillama-api	4.822476331867165	\N	152954587	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-27T23:00:00.000Z	defillama-api	4.819284638557519	\N	153304552	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-28T23:00:00.000Z	defillama-api	4.8045887044878555	\N	149524845	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-29T23:00:00.000Z	defillama-api	4.804340819575259	\N	148654628	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-09-30T23:00:00.000Z	defillama-api	4.814548216103276	\N	146483392	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-01T23:00:00.000Z	defillama-api	4.4929483525635305	\N	1030389815	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-02T23:00:00.000Z	defillama-api	4.506896430456209	\N	1031523375	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-03T23:00:00.000Z	defillama-api	4.506896430456209	\N	1079278115	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-04T23:00:00.000Z	defillama-api	4.53346773241492	\N	1055149053	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-05T23:00:00.000Z	defillama-api	4.499296727189517	\N	1072135094	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-06T23:00:00.000Z	defillama-api	4.499296727189517	\N	1098507270	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-07T23:00:00.000Z	defillama-api	4.4911893500199085	\N	1075064038	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-08T23:00:00.000Z	defillama-api	4.483186308590348	\N	1073880315	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-09T23:00:00.000Z	defillama-api	4.483186308590348	\N	1050326637	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-10T23:00:00.000Z	defillama-api	4.425705018462622	\N	1032420042	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-11T23:00:00.000Z	defillama-api	4.5277621779860056	\N	1055055702	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-12T23:00:00.000Z	defillama-api	4.5277621779860056	\N	1054746111	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-13T23:00:00.000Z	defillama-api	4.531021094322796	\N	1035440389	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-14T23:00:00.000Z	defillama-api	4.531021094322796	\N	1063930252	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-15T23:00:00.000Z	defillama-api	4.446405509384022	\N	1004321575	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-16T23:00:00.000Z	defillama-api	4.461192474636277	\N	1008829875	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-17T23:00:00.000Z	defillama-api	4.461192474636277	\N	1047511442	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-18T23:00:00.000Z	defillama-api	4.451809960670516	\N	1170820740	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-19T23:00:00.000Z	defillama-api	4.5154897740928845	\N	1146228045	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-20T23:00:00.000Z	defillama-api	4.433540002324321	\N	1147189799	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-21T23:00:00.000Z	defillama-api	4.433540002324321	\N	1231288887	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-22T23:00:00.000Z	defillama-api	4.41134379904895	\N	1211359580	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-23T23:00:00.000Z	defillama-api	4.510069917529336	\N	1175635349	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-24T23:00:00.000Z	defillama-api	4.571420032917217	\N	1192642875	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-25T23:00:00.000Z	defillama-api	4.571420032917217	\N	1251981609	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-26T23:00:00.000Z	defillama-api	4.560882123172405	\N	1241403799	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-27T23:00:00.000Z	defillama-api	4.462761011936323	\N	1241727999	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-28T23:00:00.000Z	defillama-api	4.39577466586627	\N	1212770179	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-29T23:00:00.000Z	defillama-api	4.39577466586627	\N	1219961245	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-09-30T23:00:00.000Z	defillama-api	4.421964337097961	\N	1210159473	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-01T23:00:00.000Z	defillama-api	4.642623223460873	\N	76097754	1.11125	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-02T23:00:00.000Z	defillama-api	4.592606490305684	\N	76018228	1.11147	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-03T23:00:00.000Z	defillama-api	4.592606490305684	\N	79637696	1.11147	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-04T23:00:00.000Z	defillama-api	4.563375677335557	\N	77750395	1.11169	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-05T23:00:00.000Z	defillama-api	4.423944615439268	\N	78981887	1.1119	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-06T23:00:00.000Z	defillama-api	4.423944615439268	\N	80884514	1.1119	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-07T23:00:00.000Z	defillama-api	4.437480952290684	\N	79136260	1.11211	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-08T23:00:00.000Z	defillama-api	4.392893879057169	\N	79074689	1.11233	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-09T23:00:00.000Z	defillama-api	4.392893879057169	\N	77120116	1.11233	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-10T23:00:00.000Z	defillama-api	4.439824655122493	\N	75897717	1.11254	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-11T23:00:00.000Z	defillama-api	4.591852331969903	\N	77896197	1.11276	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-12T23:00:00.000Z	defillama-api	4.591861435088163	\N	77783468	1.11276	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-13T23:00:00.000Z	defillama-api	4.539058447505795	\N	76241343	1.11298	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-14T23:00:00.000Z	defillama-api	4.539058447505795	\N	78714085	1.11298	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-15T23:00:00.000Z	defillama-api	4.413735818431519	\N	74393099	1.11319	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-16T23:00:00.000Z	defillama-api	4.526557765416328	\N	74485467	1.11341	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-17T23:00:00.000Z	defillama-api	4.526548662298069	\N	77423828	1.11341	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-18T23:00:00.000Z	defillama-api	4.539335742492767	\N	86513658	1.11363	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-19T23:00:00.000Z	defillama-api	4.449102833348206	\N	84653590	1.11381	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-20T23:00:00.000Z	defillama-api	4.517793563252326	\N	84916178	1.114	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-21T23:00:00.000Z	defillama-api	4.517793563252326	\N	91580700	1.114	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-22T23:00:00.000Z	defillama-api	4.5096399702515555	\N	90786133	1.11418	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-23T23:00:00.000Z	defillama-api	4.593819305753755	\N	88202456	1.11437	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-24T23:00:00.000Z	defillama-api	4.403324652102469	\N	89224050	1.11454	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-25T23:00:00.000Z	defillama-api	4.403324652102469	\N	93711574	1.11454	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-26T23:00:00.000Z	defillama-api	4.487699354527308	\N	92800736	1.11473	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-27T23:00:00.000Z	defillama-api	4.463315601910267	\N	93115206	1.11491	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-28T23:00:00.000Z	defillama-api	4.473203689059346	\N	90866389	1.11509	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-29T23:00:00.000Z	defillama-api	4.473193885701221	\N	91329719	1.11509	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-09-30T23:00:00.000Z	defillama-api	4.514266455046823	\N	90601257	1.11528	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-01T23:00:00.000Z	defillama-api	4.897348079069275	\N	57772160	1.04033	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-02T23:00:00.000Z	defillama-api	4.86516785578317	\N	56247239	1.04055	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-03T23:00:00.000Z	defillama-api	4.865177659141295	\N	58925421	1.04055	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-04T23:00:00.000Z	defillama-api	4.7962012313718105	\N	57312420	1.04076	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-05T23:00:00.000Z	defillama-api	4.796401499973513	\N	58145546	1.04098	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-06T23:00:00.000Z	defillama-api	4.847497302762349	\N	59546376	1.04099	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-07T23:00:00.000Z	defillama-api	4.751458704888023	\N	56685772	1.0412	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-08T23:00:00.000Z	defillama-api	4.644474657666819	\N	56638475	1.04141	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-09T23:00:00.000Z	defillama-api	4.64446555454856	\N	55235511	1.04141	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-10T23:00:00.000Z	defillama-api	4.683492023005442	\N	54261180	1.04163	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-11T23:00:00.000Z	defillama-api	4.772617152681846	\N	55577912	1.04185	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-12T23:00:00.000Z	defillama-api	4.772607349323721	\N	55492877	1.04185	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-13T23:00:00.000Z	defillama-api	4.667698112825747	\N	54031953	1.04207	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-14T23:00:00.000Z	defillama-api	4.667698112825747	\N	55773560	1.04207	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-15T23:00:00.000Z	defillama-api	4.680390660638523	\N	52594398	1.04228	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-16T23:00:00.000Z	defillama-api	4.556324962123881	\N	52635794	1.04249	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-17T23:00:00.000Z	defillama-api	4.556315158765756	\N	54701723	1.04249	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-18T23:00:00.000Z	defillama-api	4.617398482764656	\N	61027879	1.0427	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-19T23:00:00.000Z	defillama-api	4.909630986560387	\N	59691550	1.04289	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-20T23:00:00.000Z	defillama-api	4.780091513012508	\N	59877074	1.04307	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-21T23:00:00.000Z	defillama-api	4.780100616130767	\N	64411074	1.04307	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-22T23:00:00.000Z	defillama-api	4.852317754000524	\N	64000148	1.04325	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-23T23:00:00.000Z	defillama-api	4.885463608061968	\N	62170173	1.04344	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-24T23:00:00.000Z	defillama-api	4.890672692425824	\N	62927108	1.04363	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-25T23:00:00.000Z	defillama-api	4.890682495783949	\N	66047603	1.04363	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-26T23:00:00.000Z	defillama-api	4.562372933847314	\N	65401287	1.04381	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-27T23:00:00.000Z	defillama-api	4.536870197924259	\N	65620587	1.04399	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-28T23:00:00.000Z	defillama-api	4.594822749481864	\N	64035695	1.04417	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-29T23:00:00.000Z	defillama-api	4.594822749481864	\N	64360549	1.04417	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-09-30T23:00:00.000Z	defillama-api	4.591193406255911	\N	63842593	1.04435	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-01T23:00:00.000Z	defillama-api	4.52548779890094	\N	133107015	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-02T23:00:00.000Z	defillama-api	4.458705922871786	\N	132996518	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-03T20:00:00.000Z	defillama-api	4.458705922871786	\N	140596499	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-04T23:00:00.000Z	defillama-api	4.3871610152734775	\N	135543314	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-05T23:00:00.000Z	defillama-api	4.345730623356303	\N	137718406	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-06T23:00:00.000Z	defillama-api	4.345730623356303	\N	141050831	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-07T23:00:00.000Z	defillama-api	4.916019274858741	\N	137870539	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-08T23:00:00.000Z	defillama-api	4.835063843700027	\N	137684683	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-09T23:00:00.000Z	defillama-api	4.83520669263271	\N	134840454	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-10T23:00:00.000Z	defillama-api	4.814691065035959	\N	132671519	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-11T23:00:00.000Z	defillama-api	4.8105071318360615	\N	135574904	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-12T23:00:00.000Z	defillama-api	4.810678690603254	\N	135415953	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-13T23:00:00.000Z	defillama-api	4.7949239938560595	\N	133227191	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-14T23:00:00.000Z	defillama-api	4.7949239938560595	\N	137153038	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-15T23:00:00.000Z	defillama-api	4.702871161299527	\N	129416209	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-16T23:00:00.000Z	defillama-api	4.686144531618197	\N	130209146	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-17T23:00:00.000Z	defillama-api	4.686144531618197	\N	135079347	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-18T23:00:00.000Z	defillama-api	4.667707916183872	\N	150634596	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-19T23:00:00.000Z	defillama-api	4.754319884980873	\N	147630901	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-20T23:00:00.000Z	defillama-api	4.7639026675483365	\N	147568629	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-21T23:00:00.000Z	defillama-api	4.763578456490336	\N	158819296	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-22T23:00:00.000Z	defillama-api	4.760603137299313	\N	158290482	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-23T23:00:00.000Z	defillama-api	4.764646322286126	\N	153841369	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-24T23:00:00.000Z	defillama-api	4.775267560575003	\N	155464409	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-25T23:00:00.000Z	defillama-api	4.775600874751262	\N	163072356	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-26T23:00:00.000Z	defillama-api	4.774304730759127	\N	161753454	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-27T23:00:00.000Z	defillama-api	4.774018332653895	\N	162006875	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-28T23:00:00.000Z	defillama-api	4.769727962994352	\N	158168038	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-29T23:00:00.000Z	defillama-api	4.769470974963497	\N	159055524	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-09-30T23:00:00.000Z	defillama-api	4.774285124042876	\N	157447641	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-01T23:00:00.000Z	defillama-api	4.592004984260711	\N	10006887	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-02T23:00:00.000Z	defillama-api	4.5308201254812275	\N	9986349	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-03T20:00:00.000Z	defillama-api	4.5308201254812275	\N	10565791	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-04T23:00:00.000Z	defillama-api	4.463917808195106	\N	10196836	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-05T23:00:00.000Z	defillama-api	4.430067512828373	\N	10362461	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-06T23:00:00.000Z	defillama-api	4.430067512828373	\N	10600093	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-07T23:00:00.000Z	defillama-api	5.015332894586777	\N	10344544	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-08T23:00:00.000Z	defillama-api	4.9455182796975805	\N	10341235	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-09T23:00:00.000Z	defillama-api	4.945670231748522	\N	10127704	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-10T23:00:00.000Z	defillama-api	4.943671747170697	\N	9966602	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-11T23:00:00.000Z	defillama-api	4.931040820466137	\N	10182841	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-12T23:00:00.000Z	defillama-api	4.93121237923333	\N	10173264	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-13T23:00:00.000Z	defillama-api	4.918561145572653	\N	10006706	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-14T23:00:00.000Z	defillama-api	4.918561145572653	\N	10303208	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-15T23:00:00.000Z	defillama-api	4.819379871179308	\N	9719896	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-16T23:00:00.000Z	defillama-api	4.808448426629752	\N	9775645	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-17T23:00:00.000Z	defillama-api	4.808448426629752	\N	10143875	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-18T23:00:00.000Z	defillama-api	4.811269693050235	\N	11300176	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-19T23:00:00.000Z	defillama-api	4.895434323515246	\N	11075807	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-20T23:00:00.000Z	defillama-api	4.892777613463295	\N	11070011	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-21T23:00:00.000Z	defillama-api	4.892453402405295	\N	11912331	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-22T23:00:00.000Z	defillama-api	4.909240252715108	\N	11728222	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-23T23:00:00.000Z	defillama-api	4.93322066716928	\N	11098932	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-24T23:00:00.000Z	defillama-api	4.934801108547049	\N	11221981	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-25T23:00:00.000Z	defillama-api	4.935143525841568	\N	11774245	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-26T23:00:00.000Z	defillama-api	4.931507180216954	\N	11670461	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-27T23:00:00.000Z	defillama-api	4.920360061788642	\N	11686554	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-28T23:00:00.000Z	defillama-api	4.922102258575478	\N	11405686	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-29T23:00:00.000Z	defillama-api	4.922188388079007	\N	11486302	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-09-30T23:00:00.000Z	defillama-api	4.919846085726931	\N	11397280	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-01T23:00:00.000Z	defillama-api	5.280049472844439	\N	18781186	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-02T23:00:00.000Z	defillama-api	5.187540083895215	\N	18750940	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-03T20:00:00.000Z	defillama-api	5.187540083895215	\N	19812602	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-04T23:00:00.000Z	defillama-api	5.104866264105112	\N	19282474	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-05T23:00:00.000Z	defillama-api	5.052732005594862	\N	19503575	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-06T23:00:00.000Z	defillama-api	5.052732005594862	\N	19923722	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-07T23:00:00.000Z	defillama-api	5.706611090872116	\N	19491949	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-08T23:00:00.000Z	defillama-api	5.60058777274719	\N	19495376	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-09T23:00:00.000Z	defillama-api	5.60075793103465	\N	19084898	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-10T23:00:00.000Z	defillama-api	5.573627137422932	\N	18785879	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-11T23:00:00.000Z	defillama-api	5.5622391364806845	\N	19283718	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-12T23:00:00.000Z	defillama-api	5.565776748284179	\N	19254507	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-13T23:00:00.000Z	defillama-api	5.538030443830166	\N	18995065	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-14T23:00:00.000Z	defillama-api	5.538030443830166	\N	19553703	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-15T23:00:00.000Z	defillama-api	5.423379470315126	\N	18534565	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-16T23:00:00.000Z	defillama-api	5.407635977405789	\N	18612892	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-17T23:00:00.000Z	defillama-api	5.407635977405789	\N	19354803	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-18T23:00:00.000Z	defillama-api	5.405267065938801	\N	21532749	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-19T23:00:00.000Z	defillama-api	5.518103017720932	\N	20933678	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-20T23:00:00.000Z	defillama-api	5.510296043453877	\N	20957926	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-21T23:00:00.000Z	defillama-api	5.5111853480838136	\N	22575501	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-22T23:00:00.000Z	defillama-api	5.507816494088047	\N	22743879	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-23T23:00:00.000Z	defillama-api	5.697288097294972	\N	22130449	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-24T23:00:00.000Z	defillama-api	5.689919473184091	\N	22392185	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-25T23:00:00.000Z	defillama-api	5.690457957641115	\N	23489139	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-26T23:00:00.000Z	defillama-api	5.675143711769692	\N	23223065	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-27T23:00:00.000Z	defillama-api	5.674435069025208	\N	23279781	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-28T23:00:00.000Z	defillama-api	5.676107241825434	\N	22737774	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-29T23:00:00.000Z	defillama-api	5.676967136380995	\N	22886264	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-09-30T23:00:00.000Z	defillama-api	5.684685880424922	\N	22733566	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-01T23:00:00.000Z	defillama-api	4.152929379586112	\N	71663881	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-02T23:00:00.000Z	defillama-api	4.0929538350553685	\N	71462598	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-03T20:00:00.000Z	defillama-api	4.0929538350553685	\N	75643644	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-04T23:00:00.000Z	defillama-api	4.0320588755804465	\N	72974484	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-05T23:00:00.000Z	defillama-api	3.9942186134567237	\N	74153499	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-06T23:00:00.000Z	defillama-api	3.9942186134567237	\N	75903108	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-07T23:00:00.000Z	defillama-api	4.5267678373761555	\N	74226775	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-08T23:00:00.000Z	defillama-api	4.4942865109476315	\N	74184872	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-09T23:00:00.000Z	defillama-api	4.49443006012018	\N	72643818	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-10T23:00:00.000Z	defillama-api	4.542727704404115	\N	71484062	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-11T23:00:00.000Z	defillama-api	4.577094776792023	\N	73069417	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-12T23:00:00.000Z	defillama-api	4.577247429082831	\N	72983710	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-13T23:00:00.000Z	defillama-api	4.609616016892915	\N	71793936	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-14T23:00:00.000Z	defillama-api	4.609616016892915	\N	73906915	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-15T23:00:00.000Z	defillama-api	4.515241188940422	\N	69720180	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-16T23:00:00.000Z	defillama-api	4.506446876462178	\N	70148155	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-17T23:00:00.000Z	defillama-api	4.506446876462178	\N	72796457	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-18T23:00:00.000Z	defillama-api	4.49938215645318	\N	81115288	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-19T23:00:00.000Z	defillama-api	4.585548072455481	\N	79521249	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-20T23:00:00.000Z	defillama-api	4.5850705088668064	\N	79448760	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-21T23:00:00.000Z	defillama-api	4.584755400927065	\N	83620581	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-22T23:00:00.000Z	defillama-api	4.567350238815493	\N	83161248	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-23T23:00:00.000Z	defillama-api	4.575480023660816	\N	80165104	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-24T23:00:00.000Z	defillama-api	4.564169049103839	\N	81066652	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-25T23:00:00.000Z	defillama-api	4.564474353685455	\N	85020109	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-26T23:00:00.000Z	defillama-api	4.573703515120542	\N	84297916	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-27T23:00:00.000Z	defillama-api	4.580495141581764	\N	84427128	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-28T23:00:00.000Z	defillama-api	4.572652455081538	\N	82374038	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-29T23:00:00.000Z	defillama-api	4.572413673287201	\N	82949760	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-09-30T23:00:00.000Z	defillama-api	4.568706603436112	\N	82363345	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-01T23:00:00.000Z	defillama-api	4.630116239212612	\N	4155830	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-02T23:00:00.000Z	defillama-api	4.560901729888656	\N	4113250	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-03T20:00:00.000Z	defillama-api	4.560901729888656	\N	4372241	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-04T23:00:00.000Z	defillama-api	4.456381826756228	\N	4251002	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-05T23:00:00.000Z	defillama-api	4.41303697904516	\N	4311537	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-06T23:00:00.000Z	defillama-api	4.41303697904516	\N	4408792	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-07T23:00:00.000Z	defillama-api	4.984237342853248	\N	4337750	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-08T23:00:00.000Z	defillama-api	4.915362449864347	\N	4348489	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-09T23:00:00.000Z	defillama-api	4.915505298797029	\N	4246644	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-10T22:00:00.000Z	defillama-api	4.902261662209639	\N	4154112	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-11T23:00:00.000Z	defillama-api	4.895776740809765	\N	4158209	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-12T23:00:00.000Z	defillama-api	4.895938496218832	\N	4237952	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-13T23:00:00.000Z	defillama-api	4.881045094506931	\N	4147513	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-14T23:00:00.000Z	defillama-api	4.881045094506931	\N	4261726	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-15T23:00:00.000Z	defillama-api	4.802215591581671	\N	4036711	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-16T23:00:00.000Z	defillama-api	4.734321034405298	\N	4034640	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-17T23:00:00.000Z	defillama-api	4.734321034405298	\N	4178987	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-18T23:00:00.000Z	defillama-api	4.75273664264364	\N	4691434	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-19T23:00:00.000Z	defillama-api	4.843076688487713	\N	4637966	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-20T23:00:00.000Z	defillama-api	4.836912476946509	\N	4576621	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-21T23:00:00.000Z	defillama-api	4.836588265888508	\N	4939456	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-22T23:00:00.000Z	defillama-api	4.834301982725719	\N	4929818	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-23T23:00:00.000Z	defillama-api	4.81427162135617	\N	4795247	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-24T23:00:00.000Z	defillama-api	4.828327536188226	\N	4897846	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-25T23:00:00.000Z	defillama-api	4.828660850364486	\N	5054195	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-26T23:00:00.000Z	defillama-api	4.818283995788875	\N	5052385	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-27T23:00:00.000Z	defillama-api	4.815749127473623	\N	5124884	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-28T23:00:00.000Z	defillama-api	4.808477136464262	\N	4857768	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-29T23:00:00.000Z	defillama-api	4.808229251551666	\N	4930755	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-09-30T23:00:00.000Z	defillama-api	4.824849444773349	\N	4928454	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-01T23:00:00.000Z	defillama-api	5.254937470766663	\N	10883545	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-02T23:00:00.000Z	defillama-api	5.24392129719331	\N	10868093	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-03T23:00:00.000Z	defillama-api	5.221353266549045	\N	11466043	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-04T23:00:00.000Z	defillama-api	5.204979557760225	\N	11314341	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-05T23:00:00.000Z	defillama-api	5.1955907416356695	\N	11495631	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-06T23:00:00.000Z	defillama-api	4.909792741969454	\N	11763090	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-07T23:00:00.000Z	defillama-api	5.02093481351551	\N	11513589	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-08T23:00:00.000Z	defillama-api	5.000741996497027	\N	11507107	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-09T23:00:00.000Z	defillama-api	5.005688490911098	\N	11287006	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-10T23:00:00.000Z	defillama-api	4.945394337241282	\N	11089644	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-11T23:00:00.000Z	defillama-api	4.961097216238386	\N	5517098	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-12T23:00:00.000Z	defillama-api	4.940378519080468	\N	11322624	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-13T23:00:00.000Z	defillama-api	5.0866005071981135	\N	11108197	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-14T23:00:00.000Z	defillama-api	5.087950569659938	\N	11735431	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-15T23:00:00.000Z	defillama-api	5.09166604238942	\N	11091859	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-16T23:00:00.000Z	defillama-api	5.011129354670629	\N	11122422	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-17T23:00:00.000Z	defillama-api	5.022807955157305	\N	11562042	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-18T23:00:00.000Z	defillama-api	5.022380108599123	\N	12876161	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-19T23:00:00.000Z	defillama-api	5.045744311971134	\N	12623166	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-20T23:00:00.000Z	defillama-api	5.020563686386481	\N	12611736	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-21T23:00:00.000Z	defillama-api	5.036159428684073	\N	13488780	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-22T23:00:00.000Z	defillama-api	5.0068873015618465	\N	13461372	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-23T23:00:00.000Z	defillama-api	5.041256474669353	\N	12984360	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-24T23:00:00.000Z	defillama-api	5.029722123595093	\N	13104013	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-25T23:00:00.000Z	defillama-api	5.008180644594518	\N	13653375	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-26T23:00:00.000Z	defillama-api	5.008960711805344	\N	13535194	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-27T23:00:00.000Z	defillama-api	5.006354419023751	\N	13581674	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-28T23:00:00.000Z	defillama-api	5.009331138694506	\N	13263041	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-29T23:00:00.000Z	defillama-api	5.027411332036991	\N	13347437	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-09-30T23:00:00.000Z	defillama-api	5.011480875083407	\N	13246968	\N	\N
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-06T23:00:00.000Z	defillama-api	4.580036484469474	\N	115973063	1.15045	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-07T23:00:00.000Z	defillama-api	4.526711117947002	\N	113466860	1.15068	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-08T23:00:00.000Z	defillama-api	4.553926640582517	\N	113379590	1.1509	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-09T23:00:00.000Z	defillama-api	4.553926640582517	\N	110571287	1.1509	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-10T22:00:00.000Z	defillama-api	4.585749041297049	\N	109406206	1.15113	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-11T23:00:00.000Z	defillama-api	4.628121255834117	\N	111685101	1.15136	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-12T23:00:00.000Z	defillama-api	4.628111452475991	\N	111523474	1.15136	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-13T23:00:00.000Z	defillama-api	4.630231078550651	\N	109312856	1.15159	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-14T23:00:00.000Z	defillama-api	4.630231078550651	\N	112858039	1.15159	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-15T23:00:00.000Z	defillama-api	4.559468338882766	\N	106663439	1.15182	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-16T23:00:00.000Z	defillama-api	4.55417522573498	\N	106796024	1.15205	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-17T23:00:00.000Z	defillama-api	4.554165422376855	\N	110997496	1.15205	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-18T23:00:00.000Z	defillama-api	4.4876419348582886	\N	124028557	1.15227	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-19T23:00:00.000Z	defillama-api	4.699026144194818	\N	121363082	1.15247	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-20T23:00:00.000Z	defillama-api	4.561770727562475	\N	121739754	1.15266	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-21T23:00:00.000Z	defillama-api	4.561761624444216	\N	130954585	1.15266	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-22T23:00:00.000Z	defillama-api	4.364628696862383	\N	130116712	1.15285	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-23T23:00:00.000Z	defillama-api	4.7045216266639045	\N	126395370	1.15304	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-24T23:00:00.000Z	defillama-api	4.597172054232601	\N	127858778	1.15324	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-25T23:00:00.000Z	defillama-api	4.597172054232601	\N	134289436	1.15324	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-26T23:00:00.000Z	defillama-api	4.588748168643519	\N	132984709	1.15343	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-27T23:00:00.000Z	defillama-api	4.611430338385958	\N	133433851	1.15363	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-28T23:00:00.000Z	defillama-api	4.362867593599162	\N	130211651	1.15382	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-29T23:00:00.000Z	defillama-api	4.532244413368858	\N	130873624	1.15383	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-09-30T23:00:00.000Z	defillama-api	4.362417339365265	\N	129826400	1.15401	assets_per_share
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
