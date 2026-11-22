-- Generated from VAULT_LLAMA_LST/solana/2026-10.ndjson (478 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-01T23:00:00.000Z	defillama-api	5.38991850831394	\N	608149314	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-02T23:00:00.000Z	defillama-api	5.278541156172878	\N	611603567	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-03T23:00:00.000Z	defillama-api	5.278256158547379	\N	618800744	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-04T23:00:00.000Z	defillama-api	5.325797543775934	\N	628772174	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-05T23:00:00.000Z	defillama-api	5.3877582683270475	\N	626962597	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-06T23:00:00.000Z	defillama-api	5.28131060484327	\N	627265470	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-07T23:00:00.000Z	defillama-api	5.2811306431976845	\N	598596966	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-08T23:00:00.000Z	defillama-api	5.285635986496118	\N	571515220	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-09T23:00:00.000Z	defillama-api	5.27154996134982	\N	565015931	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-10T23:00:00.000Z	defillama-api	5.438060699347602	\N	569811439	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-11T23:00:00.000Z	defillama-api	5.359915330771514	\N	574040640	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-12T23:00:00.000Z	defillama-api	5.327968987600684	\N	552603714	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-13T23:00:00.000Z	defillama-api	5.3279024648134055	\N	555383378	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-14T23:00:00.000Z	defillama-api	5.313016065500165	\N	545360052	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-15T23:00:00.000Z	defillama-api	5.30360904313909	\N	552898686	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-16T23:00:00.000Z	defillama-api	5.2468055852017415	\N	545600020	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-17T23:00:00.000Z	defillama-api	5.2216193576981595	\N	539332385	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-18T23:00:00.000Z	defillama-api	5.183837215483322	\N	541462405	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-19T23:00:00.000Z	defillama-api	5.143998468781774	\N	550058216	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-20T23:00:00.000Z	defillama-api	5.104619079432382	\N	560722658	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-21T23:00:00.000Z	defillama-api	4.9590602184679256	\N	563719384	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-22T23:00:00.000Z	defillama-api	4.944994500277744	\N	540874011	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-23T23:00:00.000Z	defillama-api	4.935600082234259	\N	535569319	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-24T23:00:00.000Z	defillama-api	4.947469147964512	\N	531466776	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-25T23:00:00.000Z	defillama-api	4.932478412911223	\N	531680525	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-10-26T23:00:00.000Z	defillama-api	4.915505298797029	\N	524767225	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-01T23:00:00.000Z	defillama-api	4.665750745758146	\N	266489755	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-02T23:00:00.000Z	defillama-api	5.590044261083449	\N	266299914	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-03T23:00:00.000Z	defillama-api	4.651443444814163	\N	269356426	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-04T23:00:00.000Z	defillama-api	4.649830092162688	\N	274205792	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-05T23:00:00.000Z	defillama-api	4.644789765606561	\N	272558698	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-06T23:00:00.000Z	defillama-api	5.563269889563571	\N	271856537	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-07T23:00:00.000Z	defillama-api	4.608613273404671	\N	260289040	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-08T23:00:00.000Z	defillama-api	4.630488766821372	\N	247932706	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-09T23:00:00.000Z	defillama-api	4.639854475030347	\N	244838967	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-10T23:00:00.000Z	defillama-api	5.400369588315357	\N	247112922	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-11T23:00:00.000Z	defillama-api	5.246350429288782	\N	249072405	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-12T23:00:00.000Z	defillama-api	5.095600690196989	\N	240026886	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-13T23:00:00.000Z	defillama-api	4.17667941512434	\N	240994078	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-14T23:00:00.000Z	defillama-api	4.94670798723007	\N	235573482	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-15T23:00:00.000Z	defillama-api	4.76854595810039	\N	238279189	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-16T23:00:00.000Z	defillama-api	4.504439288766093	\N	235134988	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-17T23:00:00.000Z	defillama-api	4.503063317429223	\N	232535949	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-18T23:00:00.000Z	defillama-api	4.495787825220532	\N	233830268	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-19T23:00:00.000Z	defillama-api	4.490567537018819	\N	236886039	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-20T23:00:00.000Z	defillama-api	5.254472511495578	\N	240834231	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-21T23:00:00.000Z	defillama-api	5.2434465345641	\N	242239842	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-22T23:00:00.000Z	defillama-api	5.213219280264525	\N	232500203	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-23T23:00:00.000Z	defillama-api	5.393822345567401	\N	230340829	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-24T23:00:00.000Z	defillama-api	5.355138294405037	\N	228717729	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-25T23:00:00.000Z	defillama-api	5.354920519806683	\N	228800527	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-10-26T23:00:00.000Z	defillama-api	5.341165708117046	\N	225890023	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-01T23:00:00.000Z	defillama-api	4.659728682909758	\N	150172548	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-02T23:00:00.000Z	defillama-api	4.659728682909758	\N	159762760	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-03T23:00:00.000Z	defillama-api	4.659728682909758	\N	163525951	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-04T23:00:00.000Z	defillama-api	4.621542502292186	\N	166051387	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-05T23:00:00.000Z	defillama-api	4.583341616637426	\N	165227511	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-06T23:00:00.000Z	defillama-api	5.040790114918536	\N	167592452	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-07T23:00:00.000Z	defillama-api	5.040790114918536	\N	160593194	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-08T23:00:00.000Z	defillama-api	4.659728682909758	\N	154956931	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-09T23:00:00.000Z	defillama-api	4.583341616637426	\N	153349307	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-10T23:00:00.000Z	defillama-api	6.250520306139151	\N	154824793	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-11T23:00:00.000Z	defillama-api	4.516455404868225	\N	156180474	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-12T23:00:00.000Z	defillama-api	4.506896430456209	\N	150473234	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-13T23:00:00.000Z	defillama-api	4.554681499158164	\N	150580509	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-14T23:00:00.000Z	defillama-api	4.631090272866345	\N	147388612	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-15T23:00:00.000Z	defillama-api	4.5928928884109155	\N	149320568	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-16T23:00:00.000Z	defillama-api	4.5928928884109155	\N	146062822	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-17T23:00:00.000Z	defillama-api	4.573788944384205	\N	144160345	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-18T23:00:00.000Z	defillama-api	4.392118713525406	\N	145378997	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-19T23:00:00.000Z	defillama-api	4.573788944384205	\N	147639807	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-20T23:00:00.000Z	defillama-api	4.564235571891118	\N	152857702	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-21T23:00:00.000Z	defillama-api	4.516455404868225	\N	153903581	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-22T23:00:00.000Z	defillama-api	4.602444160184405	\N	148212081	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-23T23:00:00.000Z	defillama-api	4.640637343200638	\N	147040047	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-24T23:00:00.000Z	defillama-api	4.277209351499778	\N	146455515	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-25T23:00:00.000Z	defillama-api	4.726518961817305	\N	146841368	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-10-26T23:00:00.000Z	defillama-api	4.305949296323774	\N	146790455	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-01T23:00:00.000Z	defillama-api	5.071335978357183	\N	112076294	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-02T23:00:00.000Z	defillama-api	4.987062810712928	\N	112546203	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-03T23:00:00.000Z	defillama-api	4.986786916205688	\N	113843920	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-04T23:00:00.000Z	defillama-api	4.918703994505336	\N	115572877	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-05T23:00:00.000Z	defillama-api	4.916276262889596	\N	115035788	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-06T23:00:00.000Z	defillama-api	4.912887101937713	\N	114697773	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-07T23:00:00.000Z	defillama-api	4.9127155431705205	\N	109881743	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-08T23:00:00.000Z	defillama-api	4.911754113834377	\N	104727395	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-09T23:00:00.000Z	defillama-api	4.906374871183061	\N	103332262	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-10T23:00:00.000Z	defillama-api	5.2819177128071715	\N	104352363	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-11T23:00:00.000Z	defillama-api	5.193749110787849	\N	104934384	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-12T23:00:00.000Z	defillama-api	5.1810551624953405	\N	101052262	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-13T23:00:00.000Z	defillama-api	5.180988639708062	\N	101209850	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-14T23:00:00.000Z	defillama-api	5.137092703222379	\N	98961139	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-15T23:00:00.000Z	defillama-api	5.121930409401898	\N	100086303	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-16T23:00:00.000Z	defillama-api	5.109597784880293	\N	98648817	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-17T23:00:00.000Z	defillama-api	5.102091213515791	\N	97602234	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-18T23:00:00.000Z	defillama-api	5.0943843735495875	\N	97993686	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-19T23:00:00.000Z	defillama-api	5.080946070279424	\N	99409586	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-20T23:00:00.000Z	defillama-api	5.071792534749875	\N	102681409	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-21T23:00:00.000Z	defillama-api	4.75836236972782	\N	103480243	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-22T23:00:00.000Z	defillama-api	4.750629620886571	\N	99408746	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-23T23:00:00.000Z	defillama-api	4.743725255806908	\N	98465919	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-24T23:00:00.000Z	defillama-api	4.739500008454911	\N	97802264	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-25T23:00:00.000Z	defillama-api	4.733300784920402	\N	97903466	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-10-26T23:00:00.000Z	defillama-api	4.716713502972425	\N	96441159	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-01T23:00:00.000Z	defillama-api	4.969918137831542	\N	332468197	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-02T23:00:00.000Z	defillama-api	4.866844230022593	\N	334070255	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-03T23:00:00.000Z	defillama-api	4.866568335515353	\N	338079293	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-04T23:00:00.000Z	defillama-api	4.865244181928574	\N	343207889	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-05T23:00:00.000Z	defillama-api	4.859061764150852	\N	341488612	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-06T23:00:00.000Z	defillama-api	4.847878233249503	\N	341321311	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-07T23:00:00.000Z	defillama-api	4.8477066744823105	\N	326650519	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-08T23:00:00.000Z	defillama-api	4.845058367308752	\N	307097629	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-09T23:00:00.000Z	defillama-api	4.831976486130429	\N	304392876	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-10T23:00:00.000Z	defillama-api	4.9915723554505576	\N	306794221	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-11T23:00:00.000Z	defillama-api	4.920722085799412	\N	308801127	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-12T23:00:00.000Z	defillama-api	4.909983207213031	\N	297132233	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-13T23:00:00.000Z	defillama-api	4.9099166844257525	\N	297691859	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-14T23:00:00.000Z	defillama-api	4.900490055348428	\N	291057565	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-15T23:00:00.000Z	defillama-api	4.88968255325517	\N	294368183	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-16T23:00:00.000Z	defillama-api	4.877606916764421	\N	290537144	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-17T23:00:00.000Z	defillama-api	4.870320920957738	\N	287476154	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-18T23:00:00.000Z	defillama-api	4.865520076435814	\N	288663214	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-19T23:00:00.000Z	defillama-api	4.852317754000524	\N	292642038	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-20T23:00:00.000Z	defillama-api	4.845743902137656	\N	296957707	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-21T23:00:00.000Z	defillama-api	4.727997868414491	\N	299784852	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-22T23:00:00.000Z	defillama-api	4.727644947521981	\N	288385123	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-23T23:00:00.000Z	defillama-api	4.7350842958593375	\N	289437638	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-24T23:00:00.000Z	defillama-api	4.747367903590316	\N	283180289	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-25T23:00:00.000Z	defillama-api	4.75203080085862	\N	282996813	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-10-26T23:00:00.000Z	defillama-api	4.7448785508663605	\N	279389227	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-01T23:00:00.000Z	defillama-api	4.940026298427824	\N	216204589	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-02T23:00:00.000Z	defillama-api	4.839399028711	\N	216956950	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-03T23:00:00.000Z	defillama-api	4.839122433963894	\N	219456295	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-04T23:00:00.000Z	defillama-api	4.839541877643683	\N	222796456	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-05T23:00:00.000Z	defillama-api	4.835035133865517	\N	221675132	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-06T23:00:00.000Z	defillama-api	4.827431929399495	\N	221713148	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-07T23:00:00.000Z	defillama-api	4.827269473750562	\N	212251245	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-08T23:00:00.000Z	defillama-api	4.820503756164385	\N	202211364	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-09T23:00:00.000Z	defillama-api	4.870397247103142	\N	200515160	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-10T23:00:00.000Z	defillama-api	5.020221269091962	\N	202104454	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-11T23:00:00.000Z	defillama-api	4.955491796110323	\N	203444484	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-12T23:00:00.000Z	defillama-api	4.943671747170697	\N	200806504	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-13T23:00:00.000Z	defillama-api	4.943605224383418	\N	206977321	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-14T23:00:00.000Z	defillama-api	4.931811784558704	\N	202813162	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-15T23:00:00.000Z	defillama-api	4.911192521461771	\N	215481508	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-16T23:00:00.000Z	defillama-api	4.8987380552034665	\N	212804391	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-17T23:00:00.000Z	defillama-api	4.870615721941363	\N	210449393	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-18T23:00:00.000Z	defillama-api	4.859976277415967	\N	211420531	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-19T23:00:00.000Z	defillama-api	4.85284153342036	\N	214384969	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-20T23:00:00.000Z	defillama-api	4.84551562394131	\N	218067027	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-21T23:00:00.000Z	defillama-api	4.727234606960451	\N	229167971	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-22T23:00:00.000Z	defillama-api	4.71852572374587	\N	220364791	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-23T23:00:00.000Z	defillama-api	4.700142326541368	\N	220562525	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-24T23:00:00.000Z	defillama-api	4.696258796244024	\N	215927537	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-25T23:00:00.000Z	defillama-api	4.718277838833274	\N	216176406	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-10-26T23:00:00.000Z	defillama-api	4.711295046888608	\N	213356252	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-01T23:00:00.000Z	defillama-api	5.21830652289168	\N	188771319	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-02T23:00:00.000Z	defillama-api	5.208083721086609	\N	189771539	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-03T22:00:00.000Z	defillama-api	5.207779816984726	\N	191847634	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-04T23:00:00.000Z	defillama-api	5.279802988411575	\N	193907939	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-05T23:00:00.000Z	defillama-api	5.334596057693375	\N	192831472	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-06T23:00:00.000Z	defillama-api	5.400994902515777	\N	193668698	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-07T23:00:00.000Z	defillama-api	5.400805137512066	\N	185485013	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-08T23:00:00.000Z	defillama-api	5.462794571897689	\N	176622254	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-09T23:00:00.000Z	defillama-api	5.4853177871905245	\N	174890648	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-10T23:00:00.000Z	defillama-api	5.6612439504277745	\N	176538028	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-11T23:00:00.000Z	defillama-api	5.565445534827518	\N	177779318	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-12T23:00:00.000Z	defillama-api	5.532751335479702	\N	170807792	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-13T23:00:00.000Z	defillama-api	5.532684812692423	\N	171389046	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-14T23:00:00.000Z	defillama-api	5.4941492123816715	\N	167521538	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-15T23:00:00.000Z	defillama-api	5.455182264313407	\N	169430534	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-16T23:00:00.000Z	defillama-api	5.420111450860077	\N	168381006	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-17T23:00:00.000Z	defillama-api	5.4111406779355775	\N	166827205	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-18T23:00:00.000Z	defillama-api	5.383769001809924	\N	167558753	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-19T23:00:00.000Z	defillama-api	5.344322389433387	\N	169919867	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-20T23:00:00.000Z	defillama-api	5.3090239980235765	\N	172928124	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-21T23:00:00.000Z	defillama-api	5.162652158574588	\N	173955890	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-22T23:00:00.000Z	defillama-api	5.1930369668440335	\N	165656908	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-23T23:00:00.000Z	defillama-api	5.208093524444735	\N	164370906	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-24T23:00:00.000Z	defillama-api	5.236073709014022	\N	163144060	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-25T23:00:00.000Z	defillama-api	5.236813862552481	\N	163267302	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-10-26T23:00:00.000Z	defillama-api	5.2332643466712625	\N	162039413	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-01T23:00:00.000Z	defillama-api	4.8098881197944365	\N	145650871	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-02T23:00:00.000Z	defillama-api	4.724477762607648	\N	147306042	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-03T23:00:00.000Z	defillama-api	4.724220774576793	\N	147989842	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-04T23:00:00.000Z	defillama-api	4.719174145861871	\N	150233848	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-05T23:00:00.000Z	defillama-api	4.721549359487653	\N	149039961	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-06T23:00:00.000Z	defillama-api	4.7173906349229355	\N	149315145	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-07T23:00:00.000Z	defillama-api	4.717228179274002	\N	143420371	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-08T23:00:00.000Z	defillama-api	4.705704331797733	\N	135302780	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-09T23:00:00.000Z	defillama-api	4.71923156553089	\N	135661243	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-10T23:00:00.000Z	defillama-api	4.878130696184257	\N	136268297	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-11T23:00:00.000Z	defillama-api	4.836950289899278	\N	137264909	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-12T23:00:00.000Z	defillama-api	4.821771190322011	\N	131052213	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-13T23:00:00.000Z	defillama-api	4.821704667534732	\N	131883904	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-14T23:00:00.000Z	defillama-api	4.814205098568891	\N	129299687	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-15T23:00:00.000Z	defillama-api	4.803397596475634	\N	131373124	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-16T23:00:00.000Z	defillama-api	4.797716550442033	\N	130828217	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-17T23:00:00.000Z	defillama-api	4.784381182432185	\N	127611583	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-18T23:00:00.000Z	defillama-api	4.808077299500724	\N	128361233	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-19T23:00:00.000Z	defillama-api	4.798278843054504	\N	130461020	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-20T23:00:00.000Z	defillama-api	4.767916442460773	\N	133690446	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-21T23:00:00.000Z	defillama-api	4.641086196954802	\N	133917553	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-22T23:00:00.000Z	defillama-api	4.621122358372531	\N	130108115	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-23T23:00:00.000Z	defillama-api	4.604086222670389	\N	126004438	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-24T23:00:00.000Z	defillama-api	4.591326451830469	\N	127195194	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-25T23:00:00.000Z	defillama-api	4.596445905491464	\N	126350934	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-10-26T23:00:00.000Z	defillama-api	4.58601583268603	\N	122562357	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-01T23:00:00.000Z	defillama-api	4.397219260710017	\N	1205179617	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-02T23:00:00.000Z	defillama-api	4.444789355773082	\N	1214527792	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-03T23:00:00.000Z	defillama-api	4.444789355773082	\N	1227937426	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-04T23:00:00.000Z	defillama-api	4.607763182207236	\N	1246521715	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-05T23:00:00.000Z	defillama-api	4.452976560287425	\N	1241690951	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-06T23:00:00.000Z	defillama-api	4.446338986596743	\N	1241325319	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-07T23:00:00.000Z	defillama-api	4.446338986596743	\N	1190240347	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-08T23:00:00.000Z	defillama-api	4.587983506709747	\N	1133229793	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-09T23:00:00.000Z	defillama-api	4.544304644582553	\N	1118805870	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-10T23:00:00.000Z	defillama-api	4.657199416513436	\N	1130985015	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-11T23:00:00.000Z	defillama-api	4.390597092296389	\N	1140637752	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-12T23:00:00.000Z	defillama-api	4.3943867904516765	\N	1095839804	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-13T23:00:00.000Z	defillama-api	4.3943867904516765	\N	1097633690	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-14T23:00:00.000Z	defillama-api	4.407726359900721	\N	1073923739	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-15T23:00:00.000Z	defillama-api	4.486676304082948	\N	1088921393	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-16T23:00:00.000Z	defillama-api	4.481780927179102	\N	1087349652	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-10-17T23:00:00.000Z	defillama-api	4.530276039105274	\N	1079428605	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-01T23:00:00.000Z	defillama-api	4.500443720090175	\N	90721258	1.11546	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-02T23:00:00.000Z	defillama-api	4.448892761388379	\N	90939951	1.11564	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-03T23:00:00.000Z	defillama-api	4.448892761388379	\N	91862784	1.11564	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-04T23:00:00.000Z	defillama-api	4.504592641296767	\N	93392088	1.11583	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-05T23:00:00.000Z	defillama-api	4.461345126927085	\N	92945182	1.11601	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-06T23:00:00.000Z	defillama-api	4.506542809323832	\N	92834588	1.11619	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-07T23:00:00.000Z	defillama-api	4.506542809323832	\N	89000193	1.11619	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-08T23:00:00.000Z	defillama-api	4.542507829086162	\N	84626760	1.11638	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-09T23:00:00.000Z	defillama-api	4.493923786696996	\N	83839530	1.11657	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-10T23:00:00.000Z	defillama-api	4.457854431194619	\N	84770780	1.11671	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-11T23:00:00.000Z	defillama-api	4.343135534412568	\N	85277028	1.11686	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-12T23:00:00.000Z	defillama-api	4.4040136881307035	\N	81855269	1.11701	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-13T23:00:00.000Z	defillama-api	4.4040136881307035	\N	82139202	1.11701	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-14T23:00:00.000Z	defillama-api	4.383476353098104	\N	80259823	1.11715	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-15T23:00:00.000Z	defillama-api	4.452364550644461	\N	81238630	1.1173	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-16T23:00:00.000Z	defillama-api	4.4434308904328645	\N	80176034	1.11745	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-17T23:00:00.000Z	defillama-api	4.493818050477216	\N	79232271	1.1176	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-18T23:00:00.000Z	defillama-api	4.424824816950945	\N	79771688	1.11774	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-19T23:00:00.000Z	defillama-api	4.413783434742413	\N	80820620	1.11789	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-20T23:00:00.000Z	defillama-api	4.396587644350802	\N	82142256	1.11804	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-21T23:00:00.000Z	defillama-api	4.436132290308592	\N	82612143	1.11818	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-22T23:00:00.000Z	defillama-api	4.2282940956539505	\N	79399320	1.11832	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-23T23:00:00.000Z	defillama-api	4.421897114070816	\N	78398755	1.11846	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-24T23:00:00.000Z	defillama-api	4.375675680989843	\N	78079731	1.11861	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-25T23:00:00.000Z	defillama-api	4.497489408095134	\N	78118398	1.11875	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-10-26T23:00:00.000Z	defillama-api	4.216157538294851	\N	77072588	1.11889	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-01T23:00:00.000Z	defillama-api	4.666572127121071	\N	63926851	1.04453	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-02T23:00:00.000Z	defillama-api	4.7688988789929	\N	64027574	1.04471	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-03T22:00:00.000Z	defillama-api	4.768889075634775	\N	64641261	1.04471	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-04T23:00:00.000Z	defillama-api	4.8681683836093725	\N	65753774	1.0449	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-05T23:00:00.000Z	defillama-api	4.845372775008627	\N	65428503	1.04508	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-06T23:00:00.000Z	defillama-api	4.845724995661271	\N	65351508	1.04527	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-07T23:00:00.000Z	defillama-api	4.845724995661271	\N	62652260	1.04527	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-08T23:00:00.000Z	defillama-api	4.892225124208949	\N	59562819	1.04546	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-09T23:00:00.000Z	defillama-api	4.830576006398246	\N	59005947	1.04564	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-10T23:00:00.000Z	defillama-api	4.797478468887562	\N	59661389	1.04579	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-11T23:00:00.000Z	defillama-api	4.613855969282099	\N	60012508	1.04594	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-12T23:00:00.000Z	defillama-api	4.674216645739193	\N	57605208	1.04608	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-13T23:00:00.000Z	defillama-api	4.674216645739193	\N	57805024	1.04608	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-14T23:00:00.000Z	defillama-api	4.7492753569855495	\N	56422186	1.04623	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-15T23:00:00.000Z	defillama-api	4.799003591315909	\N	57110901	1.04638	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-16T23:00:00.000Z	defillama-api	4.720195095586632	\N	56355911	1.04653	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-17T23:00:00.000Z	defillama-api	4.806695026005059	\N	55693081	1.04668	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-18T23:00:00.000Z	defillama-api	4.542402793106248	\N	56072503	1.04682	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-19T23:00:00.000Z	defillama-api	4.512001179080016	\N	56810028	1.04697	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-20T23:00:00.000Z	defillama-api	4.686144531618197	\N	57739550	1.04711	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-21T23:00:00.000Z	defillama-api	4.65328577590185	\N	58070150	1.04726	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-22T23:00:00.000Z	defillama-api	4.797096838160542	\N	55811442	1.0474	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-23T23:00:00.000Z	defillama-api	4.569261193410057	\N	55110476	1.04754	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-24T23:00:00.000Z	defillama-api	4.780205652110681	\N	54886901	1.04769	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-25T23:00:00.000Z	defillama-api	4.51404657972887	\N	54914186	1.04783	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-10-26T23:00:00.000Z	defillama-api	4.357812562005847	\N	54180393	1.04797	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-01T23:00:00.000Z	defillama-api	4.781387657004643	\N	156947549	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-02T23:00:00.000Z	defillama-api	4.695810642729725	\N	157738919	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-03T23:00:00.000Z	defillama-api	4.695552954459004	\N	159571121	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-04T23:00:00.000Z	defillama-api	4.688911879568991	\N	162007060	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-05T23:00:00.000Z	defillama-api	4.695028474799301	\N	161209195	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-06T23:00:00.000Z	defillama-api	4.696087237476831	\N	161267730	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-07T23:00:00.000Z	defillama-api	4.695915678709639	\N	154374252	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-08T23:00:00.000Z	defillama-api	4.690095284942686	\N	146643536	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-09T23:00:00.000Z	defillama-api	4.695133510779215	\N	145059126	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-10T23:00:00.000Z	defillama-api	4.844267796499935	\N	146515478	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-11T23:00:00.000Z	defillama-api	4.784371379074059	\N	147494306	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-12T23:00:00.000Z	defillama-api	4.773427330206914	\N	141419775	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-13T23:00:00.000Z	defillama-api	4.773360807419635	\N	141198007	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-14T23:00:00.000Z	defillama-api	4.757161458357473	\N	137466101	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-15T23:00:00.000Z	defillama-api	4.7488552130658945	\N	138231247	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-16T23:00:00.000Z	defillama-api	4.749456018871001	\N	136509691	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-17T23:00:00.000Z	defillama-api	4.731259585710745	\N	134984072	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-18T23:00:00.000Z	defillama-api	4.727244410318576	\N	135559442	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-19T23:00:00.000Z	defillama-api	4.711332859841377	\N	137575459	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-20T23:00:00.000Z	defillama-api	4.692089568081315	\N	139909986	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-21T23:00:00.000Z	defillama-api	4.569757663475116	\N	140687088	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-22T23:00:00.000Z	defillama-api	4.556257739096736	\N	135098470	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-23T23:00:00.000Z	defillama-api	4.552732031370965	\N	133758613	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-24T23:00:00.000Z	defillama-api	4.553276817986784	\N	132836832	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-25T23:00:00.000Z	defillama-api	4.554930084310627	\N	132880164	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-10-26T23:00:00.000Z	defillama-api	4.525048048265035	\N	131203204	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-01T23:00:00.000Z	defillama-api	4.903527695887533	\N	11359509	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-02T23:00:00.000Z	defillama-api	4.8096969543109935	\N	11410881	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-03T23:00:00.000Z	defillama-api	4.809430162922013	\N	11538302	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-04T23:00:00.000Z	defillama-api	4.81728335302023	\N	11720264	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-05T23:00:00.000Z	defillama-api	4.797316713478494	\N	11657308	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-06T23:00:00.000Z	defillama-api	4.777116894061351	\N	11723934	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-07T23:00:00.000Z	defillama-api	4.776945335294158	\N	11151699	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-08T23:00:00.000Z	defillama-api	4.7701193970794975	\N	10632241	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-09T23:00:00.000Z	defillama-api	4.77509600180781	\N	10485621	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-10T23:00:00.000Z	defillama-api	4.988946455952714	\N	10589733	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-11T23:00:00.000Z	defillama-api	4.926823975992534	\N	10661007	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-12T23:00:00.000Z	defillama-api	4.921245865219248	\N	10249877	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-13T23:00:00.000Z	defillama-api	4.921178642192103	\N	10271343	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-14T23:00:00.000Z	defillama-api	4.92173113144645	\N	10041118	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-15T23:00:00.000Z	defillama-api	4.973904603389201	\N	7777996	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-16T23:00:00.000Z	defillama-api	4.971564401756723	\N	7674499	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-17T23:00:00.000Z	defillama-api	4.959955125016791	\N	7593033	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-18T23:00:00.000Z	defillama-api	4.945299104619494	\N	7619117	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-19T23:00:00.000Z	defillama-api	4.9270522541888795	\N	7748571	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-20T23:00:00.000Z	defillama-api	4.908421672311647	\N	7861212	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-21T23:00:00.000Z	defillama-api	4.7608517224517755	\N	7913679	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-22T23:00:00.000Z	defillama-api	4.799203859917611	\N	7635657	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-23T23:00:00.000Z	defillama-api	4.7723216514583555	\N	7643374	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-24T23:00:00.000Z	defillama-api	4.793713279127587	\N	7465318	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-25T23:00:00.000Z	defillama-api	4.720185292228507	\N	7442030	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-10-26T23:00:00.000Z	defillama-api	4.707020782745985	\N	7360303	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-01T23:00:00.000Z	defillama-api	5.674567414359899	\N	22447618	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-02T23:00:00.000Z	defillama-api	5.567356489422082	\N	22463984	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-03T23:00:00.000Z	defillama-api	5.569910264213718	\N	22725398	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-04T23:00:00.000Z	defillama-api	5.571707079710109	\N	23071861	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-05T23:00:00.000Z	defillama-api	5.560517246649965	\N	23442500	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-06T23:00:00.000Z	defillama-api	5.390600541943513	\N	23443096	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-07T23:00:00.000Z	defillama-api	5.390553625872485	\N	22468025	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-08T23:00:00.000Z	defillama-api	5.382707438172929	\N	21427698	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-09T23:00:00.000Z	defillama-api	5.430577936138548	\N	21093752	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-10T23:00:00.000Z	defillama-api	5.621387697729574	\N	21305162	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-11T23:00:00.000Z	defillama-api	5.534359786452114	\N	21439760	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-12T23:00:00.000Z	defillama-api	5.5079201295882285	\N	20616675	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-13T23:00:00.000Z	defillama-api	5.510153894761061	\N	20663993	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-14T23:00:00.000Z	defillama-api	5.512245511241076	\N	20244571	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-15T23:00:00.000Z	defillama-api	5.4860747464857695	\N	20477821	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-16T23:00:00.000Z	defillama-api	5.484200204364242	\N	20083706	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-17T23:00:00.000Z	defillama-api	5.487646084745279	\N	19863327	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-18T23:00:00.000Z	defillama-api	5.438562071091724	\N	19966213	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-19T23:00:00.000Z	defillama-api	5.426363192384542	\N	20230140	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-20T23:00:00.000Z	defillama-api	5.376529221834403	\N	20473716	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-21T23:00:00.000Z	defillama-api	5.2292407684007	\N	20647279	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-22T23:00:00.000Z	defillama-api	5.230929746957713	\N	19777375	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-23T23:00:00.000Z	defillama-api	5.226621171061652	\N	19568216	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-24T23:00:00.000Z	defillama-api	5.258561912313553	\N	19434851	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-25T23:00:00.000Z	defillama-api	5.243275676036774	\N	19454863	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-10-26T23:00:00.000Z	defillama-api	5.242260328230941	\N	19161495	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-01T23:00:00.000Z	defillama-api	4.560338036796452	\N	82084233	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-02T23:00:00.000Z	defillama-api	4.457424483916839	\N	82484151	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-03T23:00:00.000Z	defillama-api	4.45717519852451	\N	83463689	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-04T23:00:00.000Z	defillama-api	4.451857576981411	\N	84725635	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-05T23:00:00.000Z	defillama-api	4.459270316203856	\N	84299769	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-06T23:00:00.000Z	defillama-api	4.441020664813777	\N	84311662	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-07T23:00:00.000Z	defillama-api	4.440867312283103	\N	80720701	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-08T23:00:00.000Z	defillama-api	4.444674516435043	\N	76935824	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-09T23:00:00.000Z	defillama-api	4.432640894336259	\N	76090633	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-10T23:00:00.000Z	defillama-api	4.556028760660524	\N	76851061	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-11T23:00:00.000Z	defillama-api	4.493149321405099	\N	77373771	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-12T23:00:00.000Z	defillama-api	4.478587133149858	\N	74439932	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-13T23:00:00.000Z	defillama-api	4.478529713480839	\N	74553565	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-14T23:00:00.000Z	defillama-api	4.464826719541293	\N	72904129	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-15T23:00:00.000Z	defillama-api	4.456563188881546	\N	73755320	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-16T23:00:00.000Z	defillama-api	4.443057662584238	\N	72784822	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-17T23:00:00.000Z	defillama-api	4.437854180139311	\N	71998829	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-18T23:00:00.000Z	defillama-api	4.4278092392602275	\N	72305203	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-19T23:00:00.000Z	defillama-api	4.408367779618061	\N	73316158	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-20T23:00:00.000Z	defillama-api	4.410415280986513	\N	74157912	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-21T23:00:00.000Z	defillama-api	4.309991080830855	\N	75133258	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-22T23:00:00.000Z	defillama-api	4.321484117753016	\N	72410288	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-23T23:00:00.000Z	defillama-api	4.342350565522679	\N	72513109	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-24T23:00:00.000Z	defillama-api	4.3453279854333005	\N	70914223	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-25T23:00:00.000Z	defillama-api	4.309799215107546	\N	70889124	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-10-26T23:00:00.000Z	defillama-api	4.294272096316831	\N	70850877	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-01T23:00:00.000Z	defillama-api	4.800366258095323	\N	4893215	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-02T23:00:00.000Z	defillama-api	4.704779314934626	\N	4908005	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-03T22:00:00.000Z	defillama-api	4.7045216266639045	\N	4930893	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-04T23:00:00.000Z	defillama-api	4.715196783422471	\N	5032237	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-05T23:00:00.000Z	defillama-api	4.743944430884994	\N	5102782	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-06T23:00:00.000Z	defillama-api	4.760832115735525	\N	5076481	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-07T23:00:00.000Z	defillama-api	4.760670360326458	\N	4867480	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-08T23:00:00.000Z	defillama-api	4.744564143166485	\N	4551594	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-09T23:00:00.000Z	defillama-api	4.762348135045613	\N	4541053	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-10T23:00:00.000Z	defillama-api	4.954206855956045	\N	4561282	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-11T23:00:00.000Z	defillama-api	4.884911819047488	\N	4566911	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-12T23:00:00.000Z	defillama-api	4.867216057391488	\N	4383684	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-13T23:00:00.000Z	defillama-api	4.867148834364343	\N	4427294	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-14T23:00:00.000Z	defillama-api	4.872054014626315	\N	4330010	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-15T23:00:00.000Z	defillama-api	4.8626623975422945	\N	4351024	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-16T23:00:00.000Z	defillama-api	4.846210962128339	\N	4329481	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-17T23:00:00.000Z	defillama-api	4.800080560229958	\N	4246733	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-18T23:00:00.000Z	defillama-api	4.800347351618939	\N	4316701	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-19T23:00:00.000Z	defillama-api	4.791749806543066	\N	4339815	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-20T23:00:00.000Z	defillama-api	4.757571098679136	\N	4434245	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-21T23:00:00.000Z	defillama-api	4.6219339363773315	\N	4491897	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-22T23:00:00.000Z	defillama-api	4.6184012262528995	\N	4266474	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-23T23:00:00.000Z	defillama-api	4.631758301698596	\N	4318052	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-24T23:00:00.000Z	defillama-api	4.609099940111605	\N	4119691	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-25T23:00:00.000Z	defillama-api	4.610590050546648	\N	4120889	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-10-26T23:00:00.000Z	defillama-api	4.561732914609706	\N	4196696	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-01T23:00:00.000Z	defillama-api	5.008465642220017	\N	13201227	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-02T23:00:00.000Z	defillama-api	5.025823188020695	\N	13281574	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-03T23:00:00.000Z	defillama-api	5.026963878762558	\N	13434897	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-04T23:00:00.000Z	defillama-api	5.056487391996711	\N	13634820	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-05T23:00:00.000Z	defillama-api	5.052561147067536	\N	13550697	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-06T23:00:00.000Z	defillama-api	5.061915651438653	\N	13544606	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-07T23:00:00.000Z	defillama-api	5.063778989722323	\N	12941839	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-08T23:00:00.000Z	defillama-api	5.06549947907331	\N	12357003	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-09T23:00:00.000Z	defillama-api	5.093282196000359	\N	12239117	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-10T23:00:00.000Z	defillama-api	5.101834925724802	\N	12364962	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-11T23:00:00.000Z	defillama-api	5.0973204793081095	\N	12449138	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-12T23:00:00.000Z	defillama-api	5.090754330083769	\N	11961790	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-13T23:00:00.000Z	defillama-api	5.083777840297898	\N	11984162	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-14T23:00:00.000Z	defillama-api	5.024235044004399	\N	11720883	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-15T23:00:00.000Z	defillama-api	4.995263319784726	\N	11845902	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-16T23:00:00.000Z	defillama-api	4.986986484567524	\N	11686461	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-17T23:00:00.000Z	defillama-api	4.97874746230309	\N	11545631	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-18T23:00:00.000Z	defillama-api	4.972087480936693	\N	11624217	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-19T23:00:00.000Z	defillama-api	4.9414351810384005	\N	12160796	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-20T23:00:00.000Z	defillama-api	4.9378562550828065	\N	12356602	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-21T23:00:00.000Z	defillama-api	4.93617147796499	\N	12469015	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-22T23:00:00.000Z	defillama-api	4.995510504457457	\N	11944806	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-23T23:00:00.000Z	defillama-api	5.012279848770618	\N	11819773	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-24T23:00:00.000Z	defillama-api	5.010044683118053	\N	11752194	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-25T23:00:00.000Z	defillama-api	4.98668258046564	\N	11752854	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-10-26T23:00:00.000Z	defillama-api	4.963723115736229	\N	11581656	\N	\N
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-01T23:00:00.000Z	defillama-api	4.470287190017075	\N	129996760	1.1542	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-02T23:00:00.000Z	defillama-api	4.334163361008336	\N	130300656	1.15439	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-03T22:00:00.000Z	defillama-api	4.334153557650211	\N	131549553	1.15439	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-04T23:00:00.000Z	defillama-api	4.548632827194865	\N	133811949	1.15458	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-05T23:00:00.000Z	defillama-api	4.517191356967487	\N	133171912	1.15477	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-06T23:00:00.000Z	defillama-api	4.541007915292994	\N	133013630	1.15497	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-07T23:00:00.000Z	defillama-api	4.541007915292994	\N	127519698	1.15497	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-08T23:00:00.000Z	defillama-api	4.687222901011978	\N	121254108	1.15516	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-09T23:00:00.000Z	defillama-api	4.543798371159369	\N	120120131	1.15536	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-10T23:00:00.000Z	defillama-api	4.5113989727951775	\N	121454443	1.15551	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-11T23:00:00.000Z	defillama-api	4.443459600267374	\N	122161884	1.15567	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-12T23:00:00.000Z	defillama-api	4.431014237127329	\N	117260668	1.15582	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-13T23:00:00.000Z	defillama-api	4.431014237127329	\N	117667412	1.15582	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-14T23:00:00.000Z	defillama-api	4.460675697615102	\N	114975412	1.15597	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-15T23:00:00.000Z	defillama-api	4.508550397019917	\N	116377139	1.15613	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-16T23:00:00.000Z	defillama-api	4.498732333857447	\N	114837873	1.15628	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-17T23:00:00.000Z	defillama-api	4.540023378041269	\N	113486265	1.15644	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-18T23:00:00.000Z	defillama-api	4.465075304693755	\N	114259028	1.15659	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-19T23:00:00.000Z	defillama-api	4.444368511613561	\N	115761547	1.15674	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-20T23:00:00.000Z	defillama-api	4.44654905855657	\N	117654728	1.1569	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-21T23:00:00.000Z	defillama-api	4.479036687143889	\N	118327742	1.15705	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-22T23:00:00.000Z	defillama-api	4.585777050891693	\N	113727354	1.15721	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-23T23:00:00.000Z	defillama-api	4.381370731820766	\N	112298346	1.15735	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-24T23:00:00.000Z	defillama-api	3.679864832051294	\N	111839007	1.15748	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-25T23:00:00.000Z	defillama-api	4.405851117539328	\N	111894079	1.15762	assets_per_share
VAULT_LLAMA_LST	solana	aeroxvct6tjgvnytvzy86tfdwe4syskch7fbndcrcxf	2026-10-26T23:00:00.000Z	defillama-api	4.431042946961838	\N	110398585	1.15777	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-08T23:00:00.000Z	defillama-api	5.479505096062098	\N	6864116	1.12239	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-09T23:00:00.000Z	defillama-api	5.310645753553445	\N	6801976	1.12261	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-10T23:00:00.000Z	defillama-api	5.39116003359652	\N	6879433	1.12279	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-11T23:00:00.000Z	defillama-api	4.801548262989286	\N	6919516	1.12296	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-12T23:00:00.000Z	defillama-api	4.836864860635615	\N	6637429	1.12314	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-13T23:00:00.000Z	defillama-api	5.412069195998015	\N	6660434	1.12316	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-14T23:00:00.000Z	defillama-api	5.537652314302477	\N	6509480	1.12334	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-15T23:00:00.000Z	defillama-api	5.459244355776605	\N	6590388	1.12352	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-16T23:00:00.000Z	defillama-api	5.414248342461292	\N	6503376	1.1237	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-17T23:00:00.000Z	defillama-api	5.567365592540341	\N	6430130	1.12389	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-18T23:00:00.000Z	defillama-api	4.775668097778407	\N	6473617	1.12405	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-19T23:00:00.000Z	defillama-api	5.38827924678742	\N	6570139	1.12423	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-20T23:00:00.000Z	defillama-api	5.428380583438752	\N	6699181	1.12441	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-21T23:00:00.000Z	defillama-api	4.804426949078788	\N	6737504	1.12457	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-22T23:00:00.000Z	defillama-api	5.049927544931165	\N	6475405	1.12476	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-23T23:00:00.000Z	defillama-api	5.2121374096714135	\N	6396668	1.12494	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-24T23:00:00.000Z	defillama-api	4.529453957502483	\N	6370627	1.12511	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-25T23:00:00.000Z	defillama-api	4.842162175222597	\N	6373963	1.12529	assets_per_share
VAULT_LLAMA_LST	solana	bpsolzmlqn47ep5aa7jmfngrl8kc3twaeawxwzd8ip3p	2026-10-26T23:00:00.000Z	defillama-api	4.920121980234171	\N	6299427	1.12547	assets_per_share
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
