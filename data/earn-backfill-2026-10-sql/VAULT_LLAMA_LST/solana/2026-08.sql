-- Generated from VAULT_LLAMA_LST/solana/2026-08.ndjson (527 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-01T23:00:00.000Z	defillama-api	5.604209413334615	\N	373738836	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-02T23:00:00.000Z	defillama-api	5.619600685591308	\N	382904485	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-03T23:00:00.000Z	defillama-api	5.619600685591308	\N	382037749	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-04T23:00:00.000Z	defillama-api	5.622351928025182	\N	385141368	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-05T23:00:00.000Z	defillama-api	5.622351928025182	\N	385680171	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-06T23:00:00.000Z	defillama-api	5.644526423864704	\N	378481725	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-07T23:00:00.000Z	defillama-api	5.644526423864704	\N	380462425	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-08T23:00:00.000Z	defillama-api	5.645046001845344	\N	393290060	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-09T23:00:00.000Z	defillama-api	5.645074711679854	\N	397632910	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-10T23:00:00.000Z	defillama-api	5.636587104262958	\N	393603582	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-11T23:00:00.000Z	defillama-api	5.636587104262958	\N	394420739	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-12T23:00:00.000Z	defillama-api	5.636587104262958	\N	390625640	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-13T23:00:00.000Z	defillama-api	5.665222713346907	\N	395539862	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-14T23:00:00.000Z	defillama-api	5.665222713346907	\N	390040938	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-15T23:00:00.000Z	defillama-api	5.687680806332196	\N	392406322	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-16T23:00:00.000Z	defillama-api	5.687680806332196	\N	385766210	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-17T23:00:00.000Z	defillama-api	5.6861787918194295	\N	392382053	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-18T23:00:00.000Z	defillama-api	5.6861787918194295	\N	398834194	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-19T23:00:00.000Z	defillama-api	5.679565026284195	\N	443169205	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-20T23:00:00.000Z	defillama-api	5.388942373940608	\N	453438818	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-21T23:00:00.000Z	defillama-api	5.381826536421386	\N	487982460	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-22T23:00:00.000Z	defillama-api	5.381826536421386	\N	484585494	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-23T23:00:00.000Z	defillama-api	5.385929241796816	\N	493854679	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-24T23:00:00.000Z	defillama-api	5.385929241796816	\N	505029659	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-25T23:00:00.000Z	defillama-api	5.353905872240716	\N	503647368	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-26T23:00:00.000Z	defillama-api	5.283947708178971	\N	517229158	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-27T23:00:00.000Z	defillama-api	5.284099660229913	\N	565638227	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-28T23:00:00.000Z	defillama-api	5.235171800066496	\N	539573988	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-29T23:00:00.000Z	defillama-api	5.235171800066496	\N	546563818	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-30T23:00:00.000Z	defillama-api	5.231641890901528	\N	535689663	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-08-31T23:00:00.000Z	defillama-api	5.151273960990466	\N	533960017	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-01T23:00:00.000Z	defillama-api	4.699397971563712	\N	170009362	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-02T23:00:00.000Z	defillama-api	6.24369086672516	\N	174071535	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-03T23:00:00.000Z	defillama-api	4.68788182672597	\N	173381870	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-04T23:00:00.000Z	defillama-api	6.2093469022528325	\N	174878809	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-05T23:00:00.000Z	defillama-api	4.637009400454417	\N	174813385	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-06T23:00:00.000Z	defillama-api	6.158444365667037	\N	171490398	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-07T23:00:00.000Z	defillama-api	4.6006004286169855	\N	173741971	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-08T23:00:00.000Z	defillama-api	6.135263625139942	\N	179497219	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-09T23:00:00.000Z	defillama-api	4.588040926378767	\N	181478464	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-10T23:00:00.000Z	defillama-api	6.097636936175377	\N	179614727	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-11T23:00:00.000Z	defillama-api	4.573091505477578	\N	179952598	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-12T23:00:00.000Z	defillama-api	4.574142565516581	\N	177795927	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-13T23:00:00.000Z	defillama-api	4.5876396889354965	\N	179915505	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-14T23:00:00.000Z	defillama-api	4.587620782459112	\N	177335923	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-15T23:00:00.000Z	defillama-api	4.588833597907183	\N	178454982	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-16T23:00:00.000Z	defillama-api	4.591087670036131	\N	175067339	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-17T23:00:00.000Z	defillama-api	4.614199086816484	\N	178719186	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-18T23:00:00.000Z	defillama-api	4.614208890174609	\N	181652737	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-19T23:00:00.000Z	defillama-api	6.211696907243436	\N	201274609	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-20T23:00:00.000Z	defillama-api	4.676831341399179	\N	205798632	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-21T23:00:00.000Z	defillama-api	6.256457639963742	\N	220108656	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-22T23:00:00.000Z	defillama-api	4.717495670902849	\N	220378889	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-23T23:00:00.000Z	defillama-api	6.180171408232127	\N	224458855	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-24T23:00:00.000Z	defillama-api	4.643911664814482	\N	229569532	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-25T23:00:00.000Z	defillama-api	6.155341602820386	\N	228046016	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-26T23:00:00.000Z	defillama-api	5.9742917844829435	\N	233452456	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-27T23:00:00.000Z	defillama-api	5.974499055483307	\N	254659422	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-28T23:00:00.000Z	defillama-api	5.869796389745829	\N	241969586	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-29T23:00:00.000Z	defillama-api	5.872918059068866	\N	245025440	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-30T23:00:00.000Z	defillama-api	5.693027837949671	\N	240389447	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-08-31T23:00:00.000Z	defillama-api	6.89440836900701	\N	238911419	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-01T23:00:00.000Z	defillama-api	5.259245346422858	\N	87564492	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-02T23:00:00.000Z	defillama-api	5.354076730768043	\N	90003123	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-03T23:00:00.000Z	defillama-api	5.354076730768043	\N	90262245	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-04T23:00:00.000Z	defillama-api	5.154826277831148	\N	90880980	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-05T23:00:00.000Z	defillama-api	5.154826277831148	\N	90981920	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-06T23:00:00.000Z	defillama-api	5.211795692616761	\N	89351974	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-07T23:00:00.000Z	defillama-api	5.211795692616761	\N	90321305	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-08T23:00:00.000Z	defillama-api	5.401459161546995	\N	93447207	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-09T23:00:00.000Z	defillama-api	5.401459161546995	\N	94137299	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-10T23:00:00.000Z	defillama-api	5.287703794820686	\N	93412368	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-11T23:00:00.000Z	defillama-api	5.287703794820686	\N	94319292	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-12T23:00:00.000Z	defillama-api	5.287703794820686	\N	92985435	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-13T23:00:00.000Z	defillama-api	5.363555177595458	\N	93974264	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-14T23:00:00.000Z	defillama-api	5.363555177595458	\N	92303908	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-15T23:00:00.000Z	defillama-api	5.6002187463377595	\N	93534710	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-16T23:00:00.000Z	defillama-api	5.6002187463377595	\N	92121014	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-17T23:00:00.000Z	defillama-api	5.192809388887554	\N	93870321	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-18T23:00:00.000Z	defillama-api	5.192809388887554	\N	95423851	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-19T23:00:00.000Z	defillama-api	5.0883209965491005	\N	104863093	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-20T23:00:00.000Z	defillama-api	4.82185731982554	\N	105953610	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-21T23:00:00.000Z	defillama-api	4.93614276813048	\N	114299819	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-22T23:00:00.000Z	defillama-api	4.93614276813048	\N	114455944	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-23T23:00:00.000Z	defillama-api	5.040790114918536	\N	116777024	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-24T23:00:00.000Z	defillama-api	5.040790114918536	\N	119551387	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-25T23:00:00.000Z	defillama-api	4.0853996473799725	\N	120875594	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-26T23:00:00.000Z	defillama-api	4.0853996473799725	\N	124400079	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-27T23:00:00.000Z	defillama-api	4.094998535464356	\N	133420073	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-28T23:00:00.000Z	defillama-api	4.0565959807281615	\N	126800895	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-29T23:00:00.000Z	defillama-api	4.0565959807281615	\N	128594546	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-30T23:00:00.000Z	defillama-api	4.745594196009506	\N	127210847	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-08-31T23:00:00.000Z	defillama-api	4.200529584963419	\N	126653987	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-01T23:00:00.000Z	defillama-api	5.5391095134638135	\N	63865885	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-02T23:00:00.000Z	defillama-api	5.542845993389278	\N	66426173	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-03T23:00:00.000Z	defillama-api	5.542845993389278	\N	66027315	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-04T23:00:00.000Z	defillama-api	5.620300225217534	\N	66497691	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-05T23:00:00.000Z	defillama-api	5.620300225217534	\N	66785034	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-06T23:00:00.000Z	defillama-api	5.558341601386019	\N	65511082	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-07T23:00:00.000Z	defillama-api	5.558341601386019	\N	66341719	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-08T23:00:00.000Z	defillama-api	5.544719835270939	\N	68495051	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-09T23:00:00.000Z	defillama-api	5.544719835270939	\N	69600948	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-10T23:00:00.000Z	defillama-api	5.581372490581771	\N	68930533	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-11T23:00:00.000Z	defillama-api	5.581372490581771	\N	69006533	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-12T23:00:00.000Z	defillama-api	5.581372490581771	\N	68363090	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-13T23:00:00.000Z	defillama-api	5.575017113557124	\N	69027140	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-14T23:00:00.000Z	defillama-api	5.575017113557124	\N	68052929	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-15T23:00:00.000Z	defillama-api	5.566419568481251	\N	69719749	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-16T23:00:00.000Z	defillama-api	5.566419568481251	\N	68523456	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-17T23:00:00.000Z	defillama-api	5.55012148559797	\N	69827415	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-18T23:00:00.000Z	defillama-api	5.55012148559797	\N	70919277	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-19T23:00:00.000Z	defillama-api	5.532495747928579	\N	78804572	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-20T23:00:00.000Z	defillama-api	5.249529518280838	\N	80588418	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-21T23:00:00.000Z	defillama-api	5.229506159309949	\N	86471623	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-22T23:00:00.000Z	defillama-api	5.229506159309949	\N	86541847	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-23T23:00:00.000Z	defillama-api	5.212801937304334	\N	88293508	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-24T23:00:00.000Z	defillama-api	5.212801937304334	\N	90319444	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-25T23:00:00.000Z	defillama-api	5.069216352282524	\N	89750310	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-26T23:00:00.000Z	defillama-api	5.073760208773592	\N	92177333	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-27T23:00:00.000Z	defillama-api	5.073931067300919	\N	100774381	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-28T23:00:00.000Z	defillama-api	5.016673853930342	\N	96077303	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-29T23:00:00.000Z	defillama-api	5.016673853930342	\N	97304196	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-30T23:00:00.000Z	defillama-api	4.944252246019687	\N	95724258	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-08-31T23:00:00.000Z	defillama-api	4.864053073916352	\N	95310219	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-01T23:00:00.000Z	defillama-api	5.428939374851893	\N	201878481	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-02T23:00:00.000Z	defillama-api	5.430568833020288	\N	206641023	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-03T23:00:00.000Z	defillama-api	5.430568833020288	\N	205759958	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-04T23:00:00.000Z	defillama-api	5.423815719751701	\N	207353333	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-05T23:00:00.000Z	defillama-api	5.423815719751701	\N	207605083	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-06T23:00:00.000Z	defillama-api	5.424165839684747	\N	203824142	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-07T23:00:00.000Z	defillama-api	5.424165839684747	\N	206347014	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-08T23:00:00.000Z	defillama-api	5.412192438214447	\N	213287147	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-09T23:00:00.000Z	defillama-api	5.412192438214447	\N	215670688	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-10T23:00:00.000Z	defillama-api	5.39981009666235	\N	213568713	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-11T23:00:00.000Z	defillama-api	5.39981009666235	\N	213839638	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-12T23:00:00.000Z	defillama-api	5.39981009666235	\N	211864220	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-13T23:00:00.000Z	defillama-api	5.390856829734503	\N	214114008	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-14T23:00:00.000Z	defillama-api	5.390856829734503	\N	211009630	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-15T23:00:00.000Z	defillama-api	5.37539203229187	\N	212238892	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-16T23:00:00.000Z	defillama-api	5.37539203229187	\N	208712522	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-17T23:00:00.000Z	defillama-api	5.36237947486029	\N	212686711	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-18T23:00:00.000Z	defillama-api	5.36237947486029	\N	216069331	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-19T23:00:00.000Z	defillama-api	5.347318015580527	\N	239943052	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-20T23:00:00.000Z	defillama-api	5.073760208773592	\N	245389282	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-21T23:00:00.000Z	defillama-api	5.057989406509478	\N	263201893	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-22T23:00:00.000Z	defillama-api	5.057989406509478	\N	263129460	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-23T23:00:00.000Z	defillama-api	5.049680360258435	\N	268367210	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-24T23:00:00.000Z	defillama-api	5.049680360258435	\N	274672827	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-25T23:00:00.000Z	defillama-api	4.988641851610964	\N	273118443	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-26T23:00:00.000Z	defillama-api	4.917409250992932	\N	280763475	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-27T23:00:00.000Z	defillama-api	4.917552099925615	\N	306682759	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-28T23:00:00.000Z	defillama-api	4.861767490993429	\N	292133652	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-29T23:00:00.000Z	defillama-api	4.861767490993429	\N	295963300	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-30T23:00:00.000Z	defillama-api	4.8333776661024785	\N	291268204	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-08-31T23:00:00.000Z	defillama-api	4.760803405901015	\N	289696761	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-01T23:00:00.000Z	defillama-api	5.572425525812719	\N	60984213	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-02T23:00:00.000Z	defillama-api	5.573608230946547	\N	62392942	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-03T23:00:00.000Z	defillama-api	5.573608230946547	\N	62175588	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-04T23:00:00.000Z	defillama-api	5.577079319962763	\N	62660794	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-05T23:00:00.000Z	defillama-api	5.577079319962763	\N	62773027	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-06T23:00:00.000Z	defillama-api	5.647484937298941	\N	61581703	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-07T23:00:00.000Z	defillama-api	5.647484937298941	\N	62545826	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-08T23:00:00.000Z	defillama-api	5.664920209724755	\N	64508022	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-09T23:00:00.000Z	defillama-api	5.664920209724755	\N	65209697	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-10T23:00:00.000Z	defillama-api	5.666545466453954	\N	64585959	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-11T23:00:00.000Z	defillama-api	5.666545466453954	\N	64666575	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-12T23:00:00.000Z	defillama-api	5.666545466453954	\N	64061755	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-13T23:00:00.000Z	defillama-api	5.662010012841279	\N	74116563	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-14T23:00:00.000Z	defillama-api	5.662010012841279	\N	74518907	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-15T23:00:00.000Z	defillama-api	5.653920841908189	\N	74965344	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-16T23:00:00.000Z	defillama-api	5.653920841908189	\N	73684416	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-17T23:00:00.000Z	defillama-api	5.570987933367633	\N	75118349	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-18T23:00:00.000Z	defillama-api	5.570987933367633	\N	76303703	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-19T23:00:00.000Z	defillama-api	5.560971702323059	\N	84946724	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-20T23:00:00.000Z	defillama-api	5.276501357442953	\N	86680863	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-21T23:00:00.000Z	defillama-api	5.261882449758559	\N	92977920	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-22T23:00:00.000Z	defillama-api	5.261882449758559	\N	93068755	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-23T23:00:00.000Z	defillama-api	5.2613418645819365	\N	94949082	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-24T23:00:00.000Z	defillama-api	5.2613418645819365	\N	108251234	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-25T23:00:00.000Z	defillama-api	5.203698118805278	\N	118327300	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-26T23:00:00.000Z	defillama-api	5.061944361273163	\N	121542705	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-27T23:00:00.000Z	defillama-api	5.062067603489595	\N	143840958	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-28T23:00:00.000Z	defillama-api	4.937151813777518	\N	137372934	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-29T23:00:00.000Z	defillama-api	4.937151813777518	\N	139160516	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-30T23:00:00.000Z	defillama-api	4.830919123932631	\N	136637911	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-08-31T23:00:00.000Z	defillama-api	4.650860845245575	\N	136038993	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-01T23:00:00.000Z	defillama-api	6.0078969958965445	\N	118147260	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-02T23:00:00.000Z	defillama-api	6.032443904402385	\N	120975052	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-03T23:00:00.000Z	defillama-api	6.032443904402385	\N	120642118	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-04T23:00:00.000Z	defillama-api	6.046008951088311	\N	121645560	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-05T23:00:00.000Z	defillama-api	6.046008951088311	\N	121439977	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-06T23:00:00.000Z	defillama-api	6.06374252569708	\N	119100603	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-07T23:00:00.000Z	defillama-api	6.06374252569708	\N	120795979	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-08T23:00:00.000Z	defillama-api	6.061982122673726	\N	124524379	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-09T23:00:00.000Z	defillama-api	6.061982122673726	\N	125843272	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-10T23:00:00.000Z	defillama-api	6.075054200493923	\N	125123068	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-11T23:00:00.000Z	defillama-api	6.075054200493923	\N	124958437	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-12T23:00:00.000Z	defillama-api	6.075054200493923	\N	123791842	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-13T23:00:00.000Z	defillama-api	6.076277519539985	\N	125004660	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-14T23:00:00.000Z	defillama-api	6.076277519539985	\N	123741107	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-15T23:00:00.000Z	defillama-api	6.097646739533502	\N	124576707	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-16T23:00:00.000Z	defillama-api	6.097646739533502	\N	122528269	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-17T23:00:00.000Z	defillama-api	6.111297215483091	\N	124882932	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-18T23:00:00.000Z	defillama-api	6.111297215483091	\N	126857280	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-19T23:00:00.000Z	defillama-api	6.131548852650326	\N	141385189	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-20T23:00:00.000Z	defillama-api	5.8176642319551775	\N	144169445	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-21T23:00:00.000Z	defillama-api	5.819050706890039	\N	156452817	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-22T23:00:00.000Z	defillama-api	5.819050706890039	\N	156407488	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-23T23:00:00.000Z	defillama-api	5.81705992495074	\N	160360964	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-24T23:00:00.000Z	defillama-api	5.81705992495074	\N	164848657	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-25T23:00:00.000Z	defillama-api	5.720390410957066	\N	163526659	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-26T23:00:00.000Z	defillama-api	5.559751184236461	\N	168096622	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-27T23:00:00.000Z	defillama-api	5.559883529571152	\N	183348658	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-28T23:00:00.000Z	defillama-api	5.43989742851636	\N	172513218	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-29T23:00:00.000Z	defillama-api	5.43989742851636	\N	174523866	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-30T23:00:00.000Z	defillama-api	5.340957036636951	\N	171823119	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-08-31T23:00:00.000Z	defillama-api	5.187150750529668	\N	170752773	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-01T23:00:00.000Z	defillama-api	5.176990970312545	\N	99223427	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-02T23:00:00.000Z	defillama-api	5.173952629533574	\N	101806017	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-03T23:00:00.000Z	defillama-api	5.173952629533574	\N	101362271	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-04T23:00:00.000Z	defillama-api	5.182279882021135	\N	102176036	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-05T23:00:00.000Z	defillama-api	5.182279882021135	\N	102203743	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-06T23:00:00.000Z	defillama-api	5.191366194523539	\N	100438993	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-07T23:00:00.000Z	defillama-api	5.191366194523539	\N	101610604	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-08T23:00:00.000Z	defillama-api	5.1770483899815645	\N	105004680	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-09T23:00:00.000Z	defillama-api	5.1770483899815645	\N	106219756	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-10T23:00:00.000Z	defillama-api	5.154531476847524	\N	105197620	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-11T23:00:00.000Z	defillama-api	5.154531476847524	\N	105193766	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-12T23:00:00.000Z	defillama-api	5.154531476847524	\N	104014669	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-13T23:00:00.000Z	defillama-api	5.143865423207217	\N	104476953	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-14T23:00:00.000Z	defillama-api	5.143865423207217	\N	103017039	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-15T23:00:00.000Z	defillama-api	5.150295725897536	\N	103594872	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-16T23:00:00.000Z	defillama-api	5.150295725897536	\N	101922520	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-17T23:00:00.000Z	defillama-api	5.14983986974471	\N	103828342	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-18T23:00:00.000Z	defillama-api	5.14983986974471	\N	105664224	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-19T23:00:00.000Z	defillama-api	5.131013220704972	\N	116771094	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-20T23:00:00.000Z	defillama-api	4.868549314096526	\N	119660645	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-21T23:00:00.000Z	defillama-api	4.851841590891581	\N	128301630	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-22T23:00:00.000Z	defillama-api	4.851841590891581	\N	128401442	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-23T23:00:00.000Z	defillama-api	4.839351412400106	\N	130976650	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-24T23:00:00.000Z	defillama-api	4.839351412400106	\N	133971312	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-25T23:00:00.000Z	defillama-api	4.78504851102457	\N	133075701	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-26T23:00:00.000Z	defillama-api	4.74280934206206	\N	136502609	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-27T23:00:00.000Z	defillama-api	4.7429521909947425	\N	149519723	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-28T23:00:00.000Z	defillama-api	4.691478958918083	\N	132910864	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-29T23:00:00.000Z	defillama-api	4.691478958918083	\N	134651308	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-30T23:00:00.000Z	defillama-api	4.673376357899883	\N	132389958	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-08-31T23:00:00.000Z	defillama-api	4.608288362106805	\N	131490415	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-01T23:00:00.000Z	defillama-api	4.673987667302981	\N	732343331	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-02T23:00:00.000Z	defillama-api	4.6100739737653385	\N	748251565	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-03T23:00:00.000Z	defillama-api	4.6100739737653385	\N	746610987	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-04T23:00:00.000Z	defillama-api	4.601164121709189	\N	752185950	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-05T23:00:00.000Z	defillama-api	4.601164121709189	\N	752296174	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-06T23:00:00.000Z	defillama-api	4.582109194473105	\N	739321052	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-07T23:00:00.000Z	defillama-api	4.582109194473105	\N	748497908	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-08T23:00:00.000Z	defillama-api	4.5747636782778045	\N	775671549	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-09T23:00:00.000Z	defillama-api	4.5747636782778045	\N	782075298	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-10T23:00:00.000Z	defillama-api	4.545871781402866	\N	779008624	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-11T23:00:00.000Z	defillama-api	4.545871781402866	\N	780346870	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-12T23:00:00.000Z	defillama-api	4.545871781402866	\N	773562802	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-13T23:00:00.000Z	defillama-api	4.563729298467933	\N	781924411	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-14T23:00:00.000Z	defillama-api	4.563729298467933	\N	769087781	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-15T23:00:00.000Z	defillama-api	4.65957603061895	\N	768241548	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-16T23:00:00.000Z	defillama-api	4.65957603061895	\N	754749030	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-17T23:00:00.000Z	defillama-api	4.646975914468499	\N	767909059	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-18T23:00:00.000Z	defillama-api	4.646975914468499	\N	780932762	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-19T23:00:00.000Z	defillama-api	4.584478105940093	\N	861200383	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-20T23:00:00.000Z	defillama-api	4.584478105940093	\N	882021001	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-21T23:00:00.000Z	defillama-api	4.625170445038407	\N	945576313	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-22T23:00:00.000Z	defillama-api	4.625170445038407	\N	947336196	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-23T23:00:00.000Z	defillama-api	4.612662060310413	\N	967590209	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-24T23:00:00.000Z	defillama-api	4.612662060310413	\N	992225359	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-25T23:00:00.000Z	defillama-api	4.589005856914241	\N	996860836	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-26T23:00:00.000Z	defillama-api	4.5500662182007545	\N	1019337488	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-27T23:00:00.000Z	defillama-api	4.5500662182007545	\N	1120633536	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-28T23:00:00.000Z	defillama-api	4.572174891492864	\N	1069259527	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-29T23:00:00.000Z	defillama-api	4.572174891492864	\N	1084076297	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-30T23:00:00.000Z	defillama-api	4.587955497115104	\N	1066058415	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-08-31T23:00:00.000Z	defillama-api	4.4929483525635305	\N	1064796028	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-01T23:00:00.000Z	defillama-api	4.76955640422716	\N	54669142	1.10676	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-02T23:00:00.000Z	defillama-api	4.7456131024858905	\N	56050654	1.10707	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-03T23:00:00.000Z	defillama-api	4.745603999367631	\N	55851785	1.10707	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-04T23:00:00.000Z	defillama-api	4.667240155953323	\N	56379356	1.10736	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-05T23:00:00.000Z	defillama-api	4.6672303525951975	\N	56269931	1.10736	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-06T23:00:00.000Z	defillama-api	4.707573972240198	\N	55270707	1.10767	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-07T23:00:00.000Z	defillama-api	4.707573972240198	\N	56000634	1.10767	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-08T23:00:00.000Z	defillama-api	4.6890071121907795	\N	57760813	1.10797	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-09T23:00:00.000Z	defillama-api	4.6890071121907795	\N	58464237	1.10797	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-10T23:00:00.000Z	defillama-api	4.599445032837934	\N	57949494	1.10826	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-11T23:00:00.000Z	defillama-api	4.599445032837934	\N	58137112	1.10826	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-12T23:00:00.000Z	defillama-api	4.599445032837934	\N	57433235	1.10826	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-13T23:00:00.000Z	defillama-api	4.7163507787217895	\N	58012599	1.10856	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-14T23:00:00.000Z	defillama-api	4.716360582079915	\N	57195748	1.10856	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-15T23:00:00.000Z	defillama-api	4.699855928436136	\N	57551812	1.10886	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-16T23:00:00.000Z	defillama-api	4.699855928436136	\N	56694319	1.10886	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-17T23:00:00.000Z	defillama-api	4.735713811498954	\N	57662237	1.10916	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-18T23:00:00.000Z	defillama-api	4.735723614857079	\N	58616119	1.10916	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-19T23:00:00.000Z	defillama-api	4.731097830301678	\N	65151802	1.10946	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-20T23:00:00.000Z	defillama-api	4.731088026943553	\N	66606998	1.10946	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-21T23:00:00.000Z	defillama-api	4.723304860831945	\N	71934133	1.10975	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-22T23:00:00.000Z	defillama-api	4.723304860831945	\N	71386288	1.10975	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-23T23:00:00.000Z	defillama-api	4.759935808706928	\N	72902047	1.11002	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-24T23:00:00.000Z	defillama-api	4.759935808706928	\N	74353102	1.11002	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-25T23:00:00.000Z	defillama-api	4.554776731779953	\N	74218380	1.11027	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-26T23:00:00.000Z	defillama-api	4.737173111379889	\N	76137610	1.11054	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-27T23:00:00.000Z	defillama-api	4.737163308021763	\N	83367739	1.11054	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-28T23:00:00.000Z	defillama-api	4.732223115766487	\N	79460661	1.1108	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-29T23:00:00.000Z	defillama-api	4.732223115766487	\N	80593202	1.1108	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-30T23:00:00.000Z	defillama-api	4.662582160364082	\N	79274702	1.11102	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-08-31T23:00:00.000Z	defillama-api	4.642623223460873	\N	78837870	1.11125	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-01T23:00:00.000Z	defillama-api	5.118025871908571	\N	44849614	1.03589	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-02T23:00:00.000Z	defillama-api	4.98073614352279	\N	45928316	1.03619	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-03T23:00:00.000Z	defillama-api	4.980745946880916	\N	45765361	1.03619	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-04T23:00:00.000Z	defillama-api	4.994425832904881	\N	46117861	1.03649	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-05T23:00:00.000Z	defillama-api	4.994425832904881	\N	46025295	1.03649	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-06T23:00:00.000Z	defillama-api	4.860176546017669	\N	45207888	1.03678	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-07T23:00:00.000Z	defillama-api	4.860176546017669	\N	45805531	1.03678	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-08T23:00:00.000Z	defillama-api	4.7798912444108055	\N	47201227	1.03707	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-09T23:00:00.000Z	defillama-api	4.779900347529065	\N	47775827	1.03707	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-10T23:00:00.000Z	defillama-api	4.782579465256731	\N	47353414	1.03737	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-11T23:00:00.000Z	defillama-api	4.782579465256731	\N	47506754	1.03737	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-12T23:00:00.000Z	defillama-api	4.888130121472045	\N	46931917	1.03737	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-13T23:00:00.000Z	defillama-api	4.822285866623588	\N	47400891	1.03766	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-14T23:00:00.000Z	defillama-api	4.8832928644770845	\N	46733163	1.03767	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-15T23:00:00.000Z	defillama-api	4.929784590146369	\N	46999881	1.03796	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-16T23:00:00.000Z	defillama-api	5.029797749500631	\N	46299904	1.03796	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-17T23:00:00.000Z	defillama-api	4.811183563546706	\N	47089402	1.03825	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-18T23:00:00.000Z	defillama-api	4.892453402405295	\N	47868621	1.03825	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-19T23:00:00.000Z	defillama-api	4.833701176920613	\N	53194297	1.03854	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-20T23:00:00.000Z	defillama-api	4.833701176920613	\N	54256944	1.03854	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-21T23:00:00.000Z	defillama-api	5.028514209826085	\N	58519456	1.03884	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-22T23:00:00.000Z	defillama-api	5.028514209826085	\N	58073698	1.03884	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-23T23:00:00.000Z	defillama-api	5.052447007969363	\N	59129451	1.0391	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-24T23:00:00.000Z	defillama-api	5.052447007969363	\N	60306374	1.0391	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-25T23:00:00.000Z	defillama-api	5.100741851293833	\N	59926610	1.03936	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-26T23:00:00.000Z	defillama-api	4.982866973435307	\N	61421927	1.03962	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-27T23:00:00.000Z	defillama-api	4.982876776793432	\N	67254331	1.03962	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-28T23:00:00.000Z	defillama-api	5.002026236411439	\N	64063122	1.03988	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-29T23:00:00.000Z	defillama-api	5.002036039769564	\N	64975661	1.03988	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-30T23:00:00.000Z	defillama-api	4.9658266362939685	\N	63535501	1.04011	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-08-31T23:00:00.000Z	defillama-api	4.897348079069275	\N	63185749	1.04033	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-01T23:00:00.000Z	defillama-api	5.107317803876299	\N	96520189	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-02T23:00:00.000Z	defillama-api	5.10494189001065	\N	98848040	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-03T23:00:00.000Z	defillama-api	5.10494189001065	\N	98570930	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-04T23:00:00.000Z	defillama-api	5.109237161349256	\N	99127702	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-05T23:00:00.000Z	defillama-api	5.109237161349256	\N	99272920	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-06T23:00:00.000Z	defillama-api	5.114823675000935	\N	97388264	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-07T23:00:00.000Z	defillama-api	5.114823675000935	\N	99698930	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-08T23:00:00.000Z	defillama-api	5.123375004245645	\N	103064844	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-09T23:00:00.000Z	defillama-api	5.123375004245645	\N	104192436	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-10T23:00:00.000Z	defillama-api	5.098404450620819	\N	103048315	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-11T23:00:00.000Z	defillama-api	5.098404450620819	\N	103068445	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-12T23:00:00.000Z	defillama-api	5.098404450620819	\N	102143161	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-13T23:00:00.000Z	defillama-api	5.085982895636221	\N	102568914	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-14T23:00:00.000Z	defillama-api	5.085982895636221	\N	101055351	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-15T23:00:00.000Z	defillama-api	5.074529772386427	\N	101425360	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-16T23:00:00.000Z	defillama-api	5.074529772386427	\N	99632894	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-17T23:00:00.000Z	defillama-api	5.063702663576919	\N	101590241	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-18T23:00:00.000Z	defillama-api	5.063702663576919	\N	103236153	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-19T23:00:00.000Z	defillama-api	5.056791296098595	\N	114638308	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-20T23:00:00.000Z	defillama-api	4.798107284287312	\N	117209323	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-21T23:00:00.000Z	defillama-api	4.783513585238097	\N	125513371	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-22T23:00:00.000Z	defillama-api	4.783513585238097	\N	125626899	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-23T23:00:00.000Z	defillama-api	4.769604020538054	\N	128094621	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-24T23:00:00.000Z	defillama-api	4.769604020538054	\N	131056383	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-25T23:00:00.000Z	defillama-api	4.706162288670157	\N	130310414	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-26T23:00:00.000Z	defillama-api	4.6494295549592835	\N	133777044	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-27T23:00:00.000Z	defillama-api	4.649562600533841	\N	146277726	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-28T23:00:00.000Z	defillama-api	4.596999795225543	\N	139290205	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-29T23:00:00.000Z	defillama-api	4.596999795225543	\N	140958885	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-30T23:00:00.000Z	defillama-api	4.580093904138494	\N	138238523	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-08-31T23:00:00.000Z	defillama-api	4.5250095350724	\N	137417725	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-01T23:00:00.000Z	defillama-api	5.3283765272027495	\N	9955994	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-02T23:00:00.000Z	defillama-api	5.327855548742377	\N	10254284	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-03T23:00:00.000Z	defillama-api	5.327855548742377	\N	10188796	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-04T23:00:00.000Z	defillama-api	5.327135001920169	\N	10299266	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-05T23:00:00.000Z	defillama-api	5.327135001920169	\N	10273901	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-06T23:00:00.000Z	defillama-api	5.326205783617866	\N	10073410	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-07T23:00:00.000Z	defillama-api	5.326205783617866	\N	10200603	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-08T23:00:00.000Z	defillama-api	5.314135048806179	\N	10548769	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-09T23:00:00.000Z	defillama-api	5.314135048806179	\N	10657844	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-10T23:00:00.000Z	defillama-api	5.2950542126950495	\N	10542726	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-11T23:00:00.000Z	defillama-api	5.2950542126950495	\N	11187929	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-12T23:00:00.000Z	defillama-api	5.2950542126950495	\N	10457726	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-13T23:00:00.000Z	defillama-api	5.2667400137096365	\N	10551109	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-14T23:00:00.000Z	defillama-api	5.2667400137096365	\N	10396384	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-15T23:00:00.000Z	defillama-api	5.236272577135992	\N	10463589	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-16T23:00:00.000Z	defillama-api	5.236272577135992	\N	10284424	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-17T23:00:00.000Z	defillama-api	5.204818502591024	\N	10473592	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-18T23:00:00.000Z	defillama-api	5.204818502591024	\N	10103132	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-19T23:00:00.000Z	defillama-api	5.1821566398047025	\N	11013253	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-20T23:00:00.000Z	defillama-api	4.917123553127567	\N	11051236	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-21T23:00:00.000Z	defillama-api	4.885654073305545	\N	10366742	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-22T23:00:00.000Z	defillama-api	4.885654073305545	\N	9900664	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-23T23:00:00.000Z	defillama-api	4.863663040310939	\N	9695990	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-24T23:00:00.000Z	defillama-api	4.863663040310939	\N	9909408	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-25T23:00:00.000Z	defillama-api	4.7941138163309915	\N	9768518	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-26T23:00:00.000Z	defillama-api	4.7299529381206185	\N	10011641	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-27T23:00:00.000Z	defillama-api	4.730095787053301	\N	10947640	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-28T23:00:00.000Z	defillama-api	4.670799475192666	\N	10429705	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-29T23:00:00.000Z	defillama-api	4.670799475192666	\N	10564862	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-30T23:00:00.000Z	defillama-api	4.649848998639072	\N	10398871	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-08-31T23:00:00.000Z	defillama-api	4.591517617313912	\N	10342335	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-01T23:00:00.000Z	defillama-api	5.999167105485981	\N	13330015	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-02T23:00:00.000Z	defillama-api	5.9972456472934255	\N	13648657	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-03T23:00:00.000Z	defillama-api	5.9972456472934255	\N	13606886	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-04T23:00:00.000Z	defillama-api	6.003178779678819	\N	13699909	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-05T23:00:00.000Z	defillama-api	6.003178779678819	\N	13734271	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-06T23:00:00.000Z	defillama-api	5.99873365700887	\N	13543661	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-07T23:00:00.000Z	defillama-api	5.99873365700887	\N	13733477	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-08T23:00:00.000Z	defillama-api	5.990115804976881	\N	14201807	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-09T23:00:00.000Z	defillama-api	5.990115804976881	\N	14412809	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-10T23:00:00.000Z	defillama-api	5.978219429891851	\N	14268904	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-11T23:00:00.000Z	defillama-api	5.978219429891851	\N	14292217	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-12T23:00:00.000Z	defillama-api	5.978219429891851	\N	14144413	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-13T23:00:00.000Z	defillama-api	5.995899086030931	\N	14280020	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-14T23:00:00.000Z	defillama-api	5.995899086030931	\N	14068266	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-15T23:00:00.000Z	defillama-api	5.986941617663888	\N	14141237	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-16T23:00:00.000Z	defillama-api	5.986941617663888	\N	13914891	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-17T23:00:00.000Z	defillama-api	5.969788541904109	\N	14198337	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-18T23:00:00.000Z	defillama-api	5.969788541904109	\N	14400098	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-19T23:00:00.000Z	defillama-api	5.945688386432835	\N	16061073	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-20T23:00:00.000Z	defillama-api	5.641520994359439	\N	16516332	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-21T23:00:00.000Z	defillama-api	5.613692061601228	\N	17669880	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-22T23:00:00.000Z	defillama-api	5.613692061601228	\N	17685074	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-23T23:00:00.000Z	defillama-api	5.615611419074185	\N	18082848	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-24T23:00:00.000Z	defillama-api	5.615611419074185	\N	18505673	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-25T23:00:00.000Z	defillama-api	5.544104324428645	\N	18398265	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-26T23:00:00.000Z	defillama-api	5.472490093083593	\N	18880267	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-27T23:00:00.000Z	defillama-api	5.472651148252794	\N	20646783	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-28T23:00:00.000Z	defillama-api	5.407617070929405	\N	19659079	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-29T23:00:00.000Z	defillama-api	5.407617070929405	\N	19913439	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-30T23:00:00.000Z	defillama-api	5.384043495837432	\N	19499370	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-08-31T23:00:00.000Z	defillama-api	5.279499084309691	\N	19402863	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-01T23:00:00.000Z	defillama-api	4.737563845225168	\N	108630621	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-02T23:00:00.000Z	defillama-api	4.719222462412631	\N	111130769	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-03T23:00:00.000Z	defillama-api	4.719222462412631	\N	110717799	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-04T23:00:00.000Z	defillama-api	4.711657070899378	\N	111583982	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-05T23:00:00.000Z	defillama-api	4.711657070899378	\N	111703288	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-06T23:00:00.000Z	defillama-api	4.728751326510405	\N	109598597	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-07T23:00:00.000Z	defillama-api	4.728751326510405	\N	111046776	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-08T23:00:00.000Z	defillama-api	4.720653052459056	\N	114792097	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-09T23:00:00.000Z	defillama-api	4.720653052459056	\N	116049947	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-10T23:00:00.000Z	defillama-api	4.70782255739266	\N	114918408	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-11T23:00:00.000Z	defillama-api	4.70782255739266	\N	115072725	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-12T23:00:00.000Z	defillama-api	4.70782255739266	\N	113973141	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-13T23:00:00.000Z	defillama-api	4.7134601885545635	\N	115214046	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-14T23:00:00.000Z	defillama-api	4.7134601885545635	\N	113460232	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-15T23:00:00.000Z	defillama-api	4.721120112449739	\N	114226576	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-16T23:00:00.000Z	defillama-api	4.721120112449739	\N	112284519	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-17T23:00:00.000Z	defillama-api	4.72797826169824	\N	114443847	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-18T23:00:00.000Z	defillama-api	4.72797826169824	\N	55136455	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-19T23:00:00.000Z	defillama-api	4.746814714096104	\N	61229725	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-20T23:00:00.000Z	defillama-api	4.503904305508399	\N	62624850	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-21T23:00:00.000Z	defillama-api	4.496141446352908	\N	67175426	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-22T23:00:00.000Z	defillama-api	4.496141446352908	\N	67120792	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-23T23:00:00.000Z	defillama-api	4.4667292712574636	\N	68585964	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-24T23:00:00.000Z	defillama-api	4.4667292712574636	\N	70162626	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-25T23:00:00.000Z	defillama-api	4.3803945974474345	\N	69790421	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-26T23:00:00.000Z	defillama-api	4.298161228533104	\N	71674247	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-27T23:00:00.000Z	defillama-api	4.298276067871143	\N	78365109	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-28T23:00:00.000Z	defillama-api	4.2172219028913105	\N	74684672	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-29T23:00:00.000Z	defillama-api	4.2172219028913105	\N	75634560	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-30T23:00:00.000Z	defillama-api	4.21457569643735	\N	74425906	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-08-31T23:00:00.000Z	defillama-api	4.15246932199409	\N	74033171	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-01T23:00:00.000Z	defillama-api	5.242782707171045	\N	3082536	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-02T23:00:00.000Z	defillama-api	5.208558483715819	\N	3143565	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-03T23:00:00.000Z	defillama-api	5.208558483715819	\N	3107037	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-04T23:00:00.000Z	defillama-api	5.198040180687258	\N	3106591	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-05T23:00:00.000Z	defillama-api	5.198040180687258	\N	3169267	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-06T23:00:00.000Z	defillama-api	5.196492650583195	\N	3145947	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-07T23:00:00.000Z	defillama-api	5.196492650583195	\N	3113734	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-08T23:00:00.000Z	defillama-api	5.171550106553013	\N	3255420	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-09T23:00:00.000Z	defillama-api	5.171550106553013	\N	3264004	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-10T23:00:00.000Z	defillama-api	5.182071210541039	\N	3255354	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-11T23:00:00.000Z	defillama-api	5.182071210541039	\N	3222320	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-12T23:00:00.000Z	defillama-api	5.182071210541039	\N	3239039	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-13T23:00:00.000Z	defillama-api	5.175699727999472	\N	3255026	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-14T23:00:00.000Z	defillama-api	5.175699727999472	\N	3242099	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-15T11:00:00.000Z	defillama-api	5.158473127053753	\N	3241578	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-16T23:00:00.000Z	defillama-api	5.158473127053753	\N	3176430	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-17T23:00:00.000Z	defillama-api	5.178472677869195	\N	3184295	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-18T23:00:00.000Z	defillama-api	5.178472677869195	\N	3264029	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-19T23:00:00.000Z	defillama-api	5.166507679277288	\N	3681834	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-20T23:00:00.000Z	defillama-api	4.902156626229726	\N	3692377	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-21T23:00:00.000Z	defillama-api	4.87830225495145	\N	3984579	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-22T23:00:00.000Z	defillama-api	4.87830225495145	\N	3998293	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-23T23:00:00.000Z	defillama-api	4.870025419734247	\N	3987251	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-24T23:00:00.000Z	defillama-api	4.870025419734247	\N	4091111	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-25T23:00:00.000Z	defillama-api	4.812880244742246	\N	4051259	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-26T23:00:00.000Z	defillama-api	4.753852124750324	\N	4163912	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-27T23:00:00.000Z	defillama-api	4.753995673922873	\N	4487083	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-28T23:00:00.000Z	defillama-api	4.700066000395964	\N	4346325	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-29T23:00:00.000Z	defillama-api	4.700066000395964	\N	4442302	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-30T23:00:00.000Z	defillama-api	4.65759995371684	\N	4352243	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-08-31T23:00:00.000Z	defillama-api	4.629581956194784	\N	4270640	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-01T23:00:00.000Z	defillama-api	5.13973330775741	\N	7280260	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-02T23:00:00.000Z	defillama-api	5.157988561066418	\N	7453987	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-03T23:00:00.000Z	defillama-api	5.129948856108513	\N	7439265	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-04T23:00:00.000Z	defillama-api	5.092683490914851	\N	7715904	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-05T23:00:00.000Z	defillama-api	5.013687330901462	\N	7719880	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-06T23:00:00.000Z	defillama-api	5.032612713762319	\N	7502157	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-07T23:00:00.000Z	defillama-api	5.032232483515031	\N	7588316	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-08T23:00:00.000Z	defillama-api	5.015152232701325	\N	7826095	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-09T23:00:00.000Z	defillama-api	4.987709832349196	\N	7905402	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-10T23:00:00.000Z	defillama-api	5.002073852722333	\N	7834428	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-11T23:00:00.000Z	defillama-api	4.980012795741118	\N	7849318	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-12T23:00:00.000Z	defillama-api	5.046305204103874	\N	7757633	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-13T23:00:00.000Z	defillama-api	5.094906752489692	\N	7842349	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-14T23:00:00.000Z	defillama-api	5.126519081244396	\N	7731117	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-15T23:00:00.000Z	defillama-api	5.135525566402066	\N	7777885	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-16T23:00:00.000Z	defillama-api	5.166507679277288	\N	7651725	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-17T23:00:00.000Z	defillama-api	5.174161301013669	\N	7791286	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-18T23:00:00.000Z	defillama-api	5.196550070252215	\N	7912283	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-19T23:00:00.000Z	defillama-api	5.206574704175182	\N	9175364	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-20T23:00:00.000Z	defillama-api	5.291033435383952	\N	9399637	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-21T23:00:00.000Z	defillama-api	5.292531948697388	\N	10177680	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-22T23:00:00.000Z	defillama-api	5.318961802203148	\N	10208384	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-23T23:00:00.000Z	defillama-api	5.320507231587612	\N	10369270	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-24T23:00:00.000Z	defillama-api	5.339469026921506	\N	10639337	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-25T23:00:00.000Z	defillama-api	5.300479671177527	\N	10564164	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-26T23:00:00.000Z	defillama-api	5.286489578892883	\N	10819233	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-27T23:00:00.000Z	defillama-api	5.287476216864206	\N	11966058	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-28T23:00:00.000Z	defillama-api	5.313139307716597	\N	11398192	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-29T23:00:00.000Z	defillama-api	5.312238799248803	\N	11527801	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-30T23:00:00.000Z	defillama-api	5.294011555534439	\N	11295677	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-08-31T23:00:00.000Z	defillama-api	5.265193884085306	\N	11240433	\N	\N
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
