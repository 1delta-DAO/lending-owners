-- Generated from VAULT_LLAMA_LST/solana/2026-07.ndjson (527 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-01T23:00:00.000Z	defillama-api	5.4003975979100005	\N	414451473	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-02T23:00:00.000Z	defillama-api	5.402264437393001	\N	428642008	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-03T23:00:00.000Z	defillama-api	5.402264437393001	\N	436819072	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-04T23:00:00.000Z	defillama-api	5.432159777996048	\N	431811133	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-05T23:00:00.000Z	defillama-api	5.432159777996048	\N	431127976	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-06T23:00:00.000Z	defillama-api	5.462870898043093	\N	432920899	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-07T23:00:00.000Z	defillama-api	5.462870898043093	\N	425542576	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-08T23:00:00.000Z	defillama-api	5.483291993257922	\N	406113523	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-09T23:00:00.000Z	defillama-api	5.483291993257922	\N	409861103	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-10T23:00:00.000Z	defillama-api	5.515094087016337	\N	408904896	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-11T23:00:00.000Z	defillama-api	5.515094087016337	\N	407474393	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-12T23:00:00.000Z	defillama-api	5.531899843802535	\N	401012461	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-13T23:00:00.000Z	defillama-api	5.531899843802535	\N	389326651	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-14T23:00:00.000Z	defillama-api	5.5411051970821745	\N	406679400	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-15T23:00:00.000Z	defillama-api	5.5411051970821745	\N	405482744	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-16T23:00:00.000Z	defillama-api	5.547595720400977	\N	394413608	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-17T23:00:00.000Z	defillama-api	5.547595720400977	\N	392899643	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-18T23:00:00.000Z	defillama-api	5.578421679786061	\N	395731698	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-19T23:00:00.000Z	defillama-api	5.578421679786061	\N	399295270	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-20T23:00:00.000Z	defillama-api	5.620564915886916	\N	402243978	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-21T23:00:00.000Z	defillama-api	5.620564915886916	\N	403343612	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-22T23:00:00.000Z	defillama-api	5.620716167697992	\N	406416554	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-23T23:00:00.000Z	defillama-api	5.620716167697992	\N	394801405	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-24T23:00:00.000Z	defillama-api	5.620716167697992	\N	383081923	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-25T23:00:00.000Z	defillama-api	5.611895946344703	\N	386187258	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-26T23:00:00.000Z	defillama-api	5.611895946344703	\N	397642480	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-27T23:00:00.000Z	defillama-api	5.608832396930552	\N	386397308	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-28T23:00:00.000Z	defillama-api	5.608832396930552	\N	381120499	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-29T23:00:00.000Z	defillama-api	5.605504156847019	\N	381688420	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-30T23:00:00.000Z	defillama-api	5.605504156847019	\N	388283579	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-07-31T23:00:00.000Z	defillama-api	5.604209413334615	\N	378356926	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-01T23:00:00.000Z	defillama-api	4.626402166962862	\N	189179877	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-02T23:00:00.000Z	defillama-api	6.175819417464368	\N	195467889	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-03T23:00:00.000Z	defillama-api	4.579071553934	\N	199205125	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-04T23:00:00.000Z	defillama-api	6.132752564980137	\N	197441543	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-05T23:00:00.000Z	defillama-api	4.660606783701837	\N	196433268	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-06T23:00:00.000Z	defillama-api	6.217090854931939	\N	197963775	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-07T23:00:00.000Z	defillama-api	4.663250189196333	\N	194434904	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-08T23:00:00.000Z	defillama-api	6.2103713531769245	\N	186041624	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-09T23:00:00.000Z	defillama-api	4.660988414428857	\N	187673474	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-10T23:00:00.000Z	defillama-api	6.199647879867598	\N	187667252	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-11T23:00:00.000Z	defillama-api	4.645954264503871	\N	186926171	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-12T23:00:00.000Z	defillama-api	6.186601710922446	\N	183707160	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-13T23:00:00.000Z	defillama-api	4.630116239212612	\N	178477037	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-14T23:00:00.000Z	defillama-api	6.171438016622233	\N	185517959	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-15T23:00:00.000Z	defillama-api	4.618926406152468	\N	185007454	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-16T23:00:00.000Z	defillama-api	7.426008067668022	\N	180013078	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-17T23:00:00.000Z	defillama-api	5.887730933196167	\N	179086494	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-18T23:00:00.000Z	defillama-api	7.420632326216037	\N	179451225	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-19T23:00:00.000Z	defillama-api	5.880772649646815	\N	181056664	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-20T23:00:00.000Z	defillama-api	7.437260222076247	\N	183039568	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-21T23:00:00.000Z	defillama-api	5.896687001083478	\N	184197450	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-22T23:00:00.000Z	defillama-api	7.425850513698151	\N	184458417	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-23T23:00:00.000Z	defillama-api	4.617961475616994	\N	180198202	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-24T23:00:00.000Z	defillama-api	4.6218576102319275	\N	174931879	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-25T23:00:00.000Z	defillama-api	4.621503989099551	\N	176160614	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-26T23:00:00.000Z	defillama-api	4.6251991548729166	\N	181170674	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-27T23:00:00.000Z	defillama-api	4.627290071113066	\N	175448360	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-28T23:00:00.000Z	defillama-api	4.6295721528366585	\N	173423459	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-29T23:00:00.000Z	defillama-api	4.6764210008376494	\N	173572364	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-30T23:00:00.000Z	defillama-api	4.678739495034279	\N	176613561	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-07-31T23:00:00.000Z	defillama-api	6.233384036136158	\N	171964198	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-01T23:00:00.000Z	defillama-api	5.230777794906771	\N	94527987	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-02T23:00:00.000Z	defillama-api	5.42987699603259	\N	97664704	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-03T23:00:00.000Z	defillama-api	5.42987699603259	\N	99228703	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-04T23:00:00.000Z	defillama-api	5.2402681458119105	\N	98602578	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-05T23:00:00.000Z	defillama-api	5.2402681458119105	\N	98049637	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-06T23:00:00.000Z	defillama-api	4.993236825612257	\N	98777120	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-07T23:00:00.000Z	defillama-api	4.993236825612257	\N	97223021	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-08T23:00:00.000Z	defillama-api	4.964693648190632	\N	93871182	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-09T23:00:00.000Z	defillama-api	4.964693648190632	\N	94900226	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-10T23:00:00.000Z	defillama-api	5.325636488606733	\N	94770965	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-11T23:00:00.000Z	defillama-api	5.325636488606733	\N	94554251	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-12T23:00:00.000Z	defillama-api	5.145328224287482	\N	93435574	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-13T23:00:00.000Z	defillama-api	5.145328224287482	\N	90956359	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-14T23:00:00.000Z	defillama-api	5.192809388887554	\N	94771937	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-15T23:00:00.000Z	defillama-api	5.192809388887554	\N	94217294	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-16T23:00:00.000Z	defillama-api	5.230777794906771	\N	91425616	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-17T23:00:00.000Z	defillama-api	5.230777794906771	\N	91028462	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-18T23:00:00.000Z	defillama-api	5.107326906994558	\N	91368058	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-19T23:00:00.000Z	defillama-api	5.107326906994558	\N	92129250	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-20T23:00:00.000Z	defillama-api	4.983723366791537	\N	94145618	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-21T23:00:00.000Z	defillama-api	4.983723366791537	\N	94860256	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-22T23:00:00.000Z	defillama-api	5.183314836543218	\N	93950049	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-23T23:00:00.000Z	defillama-api	5.183314836543218	\N	91826218	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-24T23:00:00.000Z	defillama-api	5.183314836543218	\N	89080006	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-25T23:00:00.000Z	defillama-api	5.335117736393613	\N	89850753	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-26T23:00:00.000Z	defillama-api	5.335117736393613	\N	92488763	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-27T23:00:00.000Z	defillama-api	5.297188543806897	\N	89562266	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-28T23:00:00.000Z	defillama-api	5.297188543806897	\N	88913847	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-29T23:00:00.000Z	defillama-api	5.335117736393613	\N	89020027	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-30T23:00:00.000Z	defillama-api	5.335117736393613	\N	91156405	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-07-31T23:00:00.000Z	defillama-api	5.259245346422858	\N	88819597	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-01T23:00:00.000Z	defillama-api	5.611706881580858	\N	68577708	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-02T23:00:00.000Z	defillama-api	5.593060894426571	\N	70943025	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-03T23:00:00.000Z	defillama-api	5.593060894426571	\N	72189751	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-04T23:00:00.000Z	defillama-api	5.636038816447808	\N	72032579	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-05T23:00:00.000Z	defillama-api	5.636038816447808	\N	71882359	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-06T23:00:00.000Z	defillama-api	5.582091636924247	\N	71989696	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-07T23:00:00.000Z	defillama-api	5.582091636924247	\N	70736188	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-08T23:00:00.000Z	defillama-api	5.581911675278661	\N	67744445	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-09T23:00:00.000Z	defillama-api	5.581911675278661	\N	68360304	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-10T23:00:00.000Z	defillama-api	5.595888463005849	\N	68351147	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-11T23:00:00.000Z	defillama-api	5.595888463005849	\N	68207572	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-12T23:00:00.000Z	defillama-api	5.596720347966766	\N	67011026	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-13T23:00:00.000Z	defillama-api	5.596720347966766	\N	65758576	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-14T23:00:00.000Z	defillama-api	5.605362708394068	\N	68353566	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-15T23:00:00.000Z	defillama-api	5.605362708394068	\N	68026220	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-16T23:00:00.000Z	defillama-api	5.617038507921279	\N	66235171	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-17T23:00:00.000Z	defillama-api	5.617038507921279	\N	65763084	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-18T23:00:00.000Z	defillama-api	5.615582709239675	\N	66220754	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-19T23:00:00.000Z	defillama-api	5.615582709239675	\N	66827809	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-20T23:00:00.000Z	defillama-api	5.618002738216887	\N	67921631	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-21T23:00:00.000Z	defillama-api	5.618002738216887	\N	69909451	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-22T23:00:00.000Z	defillama-api	5.608974545623369	\N	69765282	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-23T23:00:00.000Z	defillama-api	5.608974545623369	\N	68194423	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-24T23:00:00.000Z	defillama-api	5.608974545623369	\N	66471922	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-25T23:00:00.000Z	defillama-api	5.557301044945007	\N	66868234	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-26T23:00:00.000Z	defillama-api	5.557301044945007	\N	68824596	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-27T23:00:00.000Z	defillama-api	5.552032440192534	\N	67148741	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-28T23:00:00.000Z	defillama-api	5.552032440192534	\N	65993806	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-29T23:00:00.000Z	defillama-api	5.551133332204472	\N	64518459	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-30T23:00:00.000Z	defillama-api	5.551133332204472	\N	67130637	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-07-31T23:00:00.000Z	defillama-api	5.5391095134638135	\N	65399029	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-01T23:00:00.000Z	defillama-api	5.651151393237797	\N	217589447	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-02T23:00:00.000Z	defillama-api	5.620403860717715	\N	225427502	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-03T23:00:00.000Z	defillama-api	5.620403860717715	\N	229589562	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-04T23:00:00.000Z	defillama-api	5.59054563282757	\N	228656436	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-05T23:00:00.000Z	defillama-api	5.59054563282757	\N	228515092	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-06T23:00:00.000Z	defillama-api	5.564499510768428	\N	230227159	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-07T23:00:00.000Z	defillama-api	5.564499510768428	\N	226335907	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-08T23:00:00.000Z	defillama-api	5.554065936763664	\N	216505172	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-09T23:00:00.000Z	defillama-api	5.554065936763664	\N	218597132	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-10T23:00:00.000Z	defillama-api	5.544984525940322	\N	218377638	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-11T23:00:00.000Z	defillama-api	5.544984525940322	\N	218071424	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-12T23:00:00.000Z	defillama-api	5.528407747590336	\N	214049773	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-13T23:00:00.000Z	defillama-api	5.528407747590336	\N	208448495	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-14T23:00:00.000Z	defillama-api	5.512235707882951	\N	218075904	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-15T23:00:00.000Z	defillama-api	5.512235707882951	\N	217250165	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-16T23:00:00.000Z	defillama-api	5.494442612885564	\N	211413609	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-17T23:00:00.000Z	defillama-api	5.494442612885564	\N	209778216	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-18T23:00:00.000Z	defillama-api	5.486055840009385	\N	211466227	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-19T23:00:00.000Z	defillama-api	5.486055840009385	\N	213489041	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-20T23:00:00.000Z	defillama-api	5.477148088672834	\N	217088331	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-21T23:00:00.000Z	defillama-api	5.477148088672834	\N	218355835	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-22T23:00:00.000Z	defillama-api	5.463845631936692	\N	217925179	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-23T23:00:00.000Z	defillama-api	5.463845631936692	\N	213147644	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-24T23:00:00.000Z	defillama-api	5.463845631936692	\N	207080263	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-25T23:00:00.000Z	defillama-api	5.455655626462885	\N	208523483	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-26T23:00:00.000Z	defillama-api	5.455655626462885	\N	214644313	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-27T23:00:00.000Z	defillama-api	5.441573802755784	\N	208921036	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-28T23:00:00.000Z	defillama-api	5.441573802755784	\N	205787316	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-29T23:00:00.000Z	defillama-api	5.434243691837537	\N	206032626	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-30T23:00:00.000Z	defillama-api	5.434243691837537	\N	209350496	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-07-31T23:00:00.000Z	defillama-api	5.428939374851893	\N	204225165	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-01T23:00:00.000Z	defillama-api	5.692111223964957	\N	59889130	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-02T23:00:00.000Z	defillama-api	5.698327253256252	\N	62041031	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-03T23:00:00.000Z	defillama-api	5.698327253256252	\N	63228912	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-04T23:00:00.000Z	defillama-api	5.709567503586754	\N	63135542	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-05T23:00:00.000Z	defillama-api	5.709567503586754	\N	62344548	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-06T23:00:00.000Z	defillama-api	5.71939887130668	\N	63512875	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-07T23:00:00.000Z	defillama-api	5.71939887130668	\N	62286315	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-08T23:00:00.000Z	defillama-api	5.730146152771454	\N	59588071	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-09T23:00:00.000Z	defillama-api	5.730146152771454	\N	60163178	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-10T23:00:00.000Z	defillama-api	5.715914477733008	\N	60117316	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-11T23:00:00.000Z	defillama-api	5.715914477733008	\N	60000461	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-12T23:00:00.000Z	defillama-api	5.703002754842146	\N	62588895	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-13T23:00:00.000Z	defillama-api	5.703002754842146	\N	60952016	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-14T23:00:00.000Z	defillama-api	5.689910370065832	\N	63783210	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-15T23:00:00.000Z	defillama-api	5.689910370065832	\N	65002349	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-16T23:00:00.000Z	defillama-api	5.616433500676976	\N	63426744	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-17T23:00:00.000Z	defillama-api	5.616433500676976	\N	62811414	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-18T23:00:00.000Z	defillama-api	5.593165230166619	\N	63254167	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-19T23:00:00.000Z	defillama-api	5.593165230166619	\N	63887670	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-20T23:00:00.000Z	defillama-api	5.588077287299598	\N	64964898	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-21T23:00:00.000Z	defillama-api	5.588077287299598	\N	65363626	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-22T23:00:00.000Z	defillama-api	5.58066314759742	\N	65313432	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-23T23:00:00.000Z	defillama-api	5.58066314759742	\N	63866583	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-24T23:00:00.000Z	defillama-api	5.58066314759742	\N	62047511	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-25T23:00:00.000Z	defillama-api	5.574393199836436	\N	62481543	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-26T23:00:00.000Z	defillama-api	5.574393199836436	\N	64315923	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-27T23:00:00.000Z	defillama-api	5.566836211201576	\N	62588847	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-28T23:00:00.000Z	defillama-api	5.566836211201576	\N	61665724	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-29T23:00:00.000Z	defillama-api	5.558588085818883	\N	61714064	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-30T23:00:00.000Z	defillama-api	5.558588085818883	\N	63224430	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-07-31T23:00:00.000Z	defillama-api	5.572425525812719	\N	61704642	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-01T23:00:00.000Z	defillama-api	5.875331785887283	\N	121072170	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-02T23:00:00.000Z	defillama-api	5.898384382518884	\N	125952652	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-03T23:00:00.000Z	defillama-api	5.898384382518884	\N	128551678	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-04T23:00:00.000Z	defillama-api	5.918697640794335	\N	128034789	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-05T23:00:00.000Z	defillama-api	5.918697640794335	\N	127829217	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-06T23:00:00.000Z	defillama-api	5.98824196309522	\N	129243954	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-07T23:00:00.000Z	defillama-api	5.98824196309522	\N	126989983	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-08T23:00:00.000Z	defillama-api	6.013433792517731	\N	121481446	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-09T23:00:00.000Z	defillama-api	6.013433792517731	\N	123120580	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-10T23:00:00.000Z	defillama-api	6.039626964948752	\N	123047452	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-11T23:00:00.000Z	defillama-api	6.039626964948752	\N	122962134	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-12T23:00:00.000Z	defillama-api	6.026079424259478	\N	120811010	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-13T23:00:00.000Z	defillama-api	6.026079424259478	\N	117586084	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-14T23:00:00.000Z	defillama-api	6.035738532972346	\N	123052057	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-15T23:00:00.000Z	defillama-api	6.035738532972346	\N	122644950	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-16T23:00:00.000Z	defillama-api	6.036190187685975	\N	118966045	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-17T23:00:00.000Z	defillama-api	6.036190187685975	\N	119509667	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-18T23:00:00.000Z	defillama-api	6.0419237517095326	\N	120774253	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-19T23:00:00.000Z	defillama-api	6.0419237517095326	\N	122050335	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-20T23:00:00.000Z	defillama-api	6.041848125803995	\N	124092664	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-21T23:00:00.000Z	defillama-api	6.041848125803995	\N	125154862	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-22T23:00:00.000Z	defillama-api	6.056306678559054	\N	125279750	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-23T23:00:00.000Z	defillama-api	6.056306678559054	\N	121893895	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-24T23:00:00.000Z	defillama-api	6.056306678559054	\N	118268062	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-25T23:00:00.000Z	defillama-api	6.059525681223477	\N	119360661	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-26T23:00:00.000Z	defillama-api	6.059525681223477	\N	122696193	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-27T23:00:00.000Z	defillama-api	6.021051001781075	\N	119636736	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-28T23:00:00.000Z	defillama-api	6.021051001781075	\N	120227174	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-29T23:00:00.000Z	defillama-api	6.017652037471066	\N	120991929	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-30T23:00:00.000Z	defillama-api	6.017652037471066	\N	123118799	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-07-31T23:00:00.000Z	defillama-api	6.0078969958965445	\N	120277236	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-01T23:00:00.000Z	defillama-api	5.254339465921021	\N	107524729	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-02T23:00:00.000Z	defillama-api	5.258229998617026	\N	111862313	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-03T23:00:00.000Z	defillama-api	5.258229998617026	\N	114189492	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-04T23:00:00.000Z	defillama-api	5.23960361817899	\N	113503703	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-05T23:00:00.000Z	defillama-api	5.23960361817899	\N	113387912	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-06T23:00:00.000Z	defillama-api	5.245724414848496	\N	113326359	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-07T23:00:00.000Z	defillama-api	5.245724414848496	\N	111612408	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-08T23:00:00.000Z	defillama-api	5.2512941227433885	\N	106848622	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-09T23:00:00.000Z	defillama-api	5.2512941227433885	\N	107888422	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-10T23:00:00.000Z	defillama-api	5.251208693479725	\N	108184994	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-11T23:00:00.000Z	defillama-api	5.251208693479725	\N	107750163	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-12T23:00:00.000Z	defillama-api	5.259681595859433	\N	106292401	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-13T23:00:00.000Z	defillama-api	5.259681595859433	\N	104686018	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-14T23:00:00.000Z	defillama-api	5.255516569135921	\N	108710425	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-15T23:00:00.000Z	defillama-api	5.255516569135921	\N	108105685	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-16T23:00:00.000Z	defillama-api	5.2123362777933835	\N	105052489	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-17T23:00:00.000Z	defillama-api	5.2123362777933835	\N	104695582	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-18T23:00:00.000Z	defillama-api	5.2175285564004525	\N	105373175	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-19T23:00:00.000Z	defillama-api	5.2175285564004525	\N	106444984	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-20T23:00:00.000Z	defillama-api	5.20737227738266	\N	108158604	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-21T23:00:00.000Z	defillama-api	5.20737227738266	\N	108950387	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-22T23:00:00.000Z	defillama-api	5.198989705945678	\N	108629362	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-23T23:00:00.000Z	defillama-api	5.198989705945678	\N	106231589	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-24T23:00:00.000Z	defillama-api	5.198989705945678	\N	102133428	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-25T23:00:00.000Z	defillama-api	5.209906445458046	\N	102678379	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-26T23:00:00.000Z	defillama-api	5.209906445458046	\N	105605477	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-27T23:00:00.000Z	defillama-api	5.191670098625423	\N	102540906	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-28T23:00:00.000Z	defillama-api	5.191670098625423	\N	101356374	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-29T23:00:00.000Z	defillama-api	5.183514404905054	\N	101746216	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-30T23:00:00.000Z	defillama-api	5.183514404905054	\N	103207725	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-07-31T23:00:00.000Z	defillama-api	5.176990970312545	\N	100535149	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-01T23:00:00.000Z	defillama-api	4.9172187857493554	\N	788892363	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-02T23:00:00.000Z	defillama-api	4.944785128557783	\N	813011387	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-03T23:00:00.000Z	defillama-api	4.944785128557783	\N	829247046	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-04T23:00:00.000Z	defillama-api	4.9068125210993685	\N	827026926	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-05T23:00:00.000Z	defillama-api	4.9068125210993685	\N	823326214	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-06T23:00:00.000Z	defillama-api	4.909821451803964	\N	826915714	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-07T23:00:00.000Z	defillama-api	4.909821451803964	\N	812392149	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-08T23:00:00.000Z	defillama-api	4.851260391802725	\N	778786655	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-09T23:00:00.000Z	defillama-api	4.851260391802725	\N	785848050	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-10T23:00:00.000Z	defillama-api	4.834349599036614	\N	786398340	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-11T23:00:00.000Z	defillama-api	4.834349599036614	\N	783433091	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-12T23:00:00.000Z	defillama-api	4.80326385066121	\N	773396174	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-13T23:00:00.000Z	defillama-api	4.80326385066121	\N	750522386	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-14T23:00:00.000Z	defillama-api	4.752098023885765	\N	784010400	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-15T23:00:00.000Z	defillama-api	4.752098023885765	\N	781809726	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-16T23:00:00.000Z	defillama-api	4.788784990950035	\N	761288722	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-17T23:00:00.000Z	defillama-api	4.788784990950035	\N	760665608	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-18T23:00:00.000Z	defillama-api	4.738717840524487	\N	768248943	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-19T23:00:00.000Z	defillama-api	4.738717840524487	\N	774263387	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-20T23:00:00.000Z	defillama-api	4.653925094899591	\N	787358325	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-21T23:00:00.000Z	defillama-api	4.653925094899591	\N	793008021	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-22T23:00:00.000Z	defillama-api	4.726089714779391	\N	791262369	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-23T23:00:00.000Z	defillama-api	4.726089714779391	\N	772913646	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-24T23:00:00.000Z	defillama-api	4.726089714779391	\N	751474141	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-25T23:00:00.000Z	defillama-api	4.667554563653198	\N	759712478	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-26T23:00:00.000Z	defillama-api	4.667554563653198	\N	782712318	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-27T23:00:00.000Z	defillama-api	4.630144949047121	\N	758795750	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-28T23:00:00.000Z	defillama-api	4.630144949047121	\N	748945575	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-29T23:00:00.000Z	defillama-api	4.635214685677624	\N	746638474	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-30T23:00:00.000Z	defillama-api	4.635214685677624	\N	758540431	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-07-31T23:00:00.000Z	defillama-api	4.673987667302981	\N	740837624	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-01T23:00:00.000Z	defillama-api	5.040752301965767	\N	58835796	1.10222	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-02T23:00:00.000Z	defillama-api	5.040914057374835	\N	61111601	1.10253	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-03T23:00:00.000Z	defillama-api	5.040904254016709	\N	62296492	1.10253	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-04T23:00:00.000Z	defillama-api	5.05227544920217	\N	61969487	1.10284	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-05T23:00:00.000Z	defillama-api	5.052285252560296	\N	61885592	1.10284	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-06T23:00:00.000Z	defillama-api	4.991153612010635	\N	62314117	1.10314	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-07T23:00:00.000Z	defillama-api	4.9911438086525095	\N	61230742	1.10314	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-08T23:00:00.000Z	defillama-api	4.955225704961208	\N	58707074	1.10345	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-09T23:00:00.000Z	defillama-api	4.955225704961208	\N	59189047	1.10345	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-10T23:00:00.000Z	defillama-api	4.916218843220577	\N	59203577	1.10375	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-11T23:00:00.000Z	defillama-api	4.916218843220577	\N	58988953	1.10375	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-12T23:00:00.000Z	defillama-api	4.910897020238281	\N	58173274	1.10405	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-13T23:00:00.000Z	defillama-api	4.910897020238281	\N	56450845	1.10405	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-14T23:00:00.000Z	defillama-api	4.836645685557528	\N	59127779	1.10435	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-15T23:00:00.000Z	defillama-api	4.836645685557528	\N	58757489	1.10435	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-16T23:00:00.000Z	defillama-api	4.662763522489399	\N	57108215	1.10464	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-17T23:00:00.000Z	defillama-api	4.662773325847525	\N	56868729	1.10464	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-18T23:00:00.000Z	defillama-api	4.864072680632603	\N	57377637	1.10495	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-19T23:00:00.000Z	defillama-api	4.864081783750862	\N	57720592	1.10495	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-20T23:00:00.000Z	defillama-api	4.76292023101621	\N	58782321	1.10525	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-21T23:00:00.000Z	defillama-api	4.76292023101621	\N	59181365	1.10525	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-22T23:00:00.000Z	defillama-api	4.5807052135415915	\N	59247172	1.10555	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-23T23:00:00.000Z	defillama-api	4.5807052135415915	\N	57823246	1.10555	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-24T23:00:00.000Z	defillama-api	4.5807052135415915	\N	56106250	1.10555	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-25T23:00:00.000Z	defillama-api	4.831891056866766	\N	56495696	1.10585	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-26T23:00:00.000Z	defillama-api	4.831891056866766	\N	58244554	1.10585	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-27T23:00:00.000Z	defillama-api	4.733386914423932	\N	56289839	1.10615	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-28T23:00:00.000Z	defillama-api	4.733386914423932	\N	55784841	1.10615	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-29T23:00:00.000Z	defillama-api	4.744468910544697	\N	55912151	1.10646	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-30T23:00:00.000Z	defillama-api	4.744468910544697	\N	56786321	1.10646	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-07-31T23:00:00.000Z	defillama-api	4.769566207585285	\N	55317992	1.10676	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-01T23:00:00.000Z	defillama-api	4.886997133368709	\N	50253456	1.03159	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-02T23:00:00.000Z	defillama-api	4.912191763750684	\N	51984142	1.03187	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-03T23:00:00.000Z	defillama-api	4.912201567108809	\N	52788118	1.03187	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-04T23:00:00.000Z	defillama-api	4.978985543857561	\N	52168942	1.03216	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-05T23:00:00.000Z	defillama-api	4.978985543857561	\N	51992035	1.03216	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-06T23:00:00.000Z	defillama-api	4.9678531304664375	\N	52106226	1.03244	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-07T23:00:00.000Z	defillama-api	4.967862933824563	\N	51125488	1.03244	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-08T23:00:00.000Z	defillama-api	4.947611996897194	\N	48965096	1.03272	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-09T23:00:00.000Z	defillama-api	4.947602193539069	\N	49367113	1.03272	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-10T23:00:00.000Z	defillama-api	4.782274160675115	\N	49316157	1.033	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-11T23:00:00.000Z	defillama-api	4.78228396403324	\N	49139368	1.033	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-12T23:00:00.000Z	defillama-api	4.745307797904275	\N	48357637	1.03328	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-13T23:00:00.000Z	defillama-api	4.745298694786015	\N	46996408	1.03328	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-14T23:00:00.000Z	defillama-api	4.624884046933175	\N	49190863	1.03355	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-15T23:00:00.000Z	defillama-api	4.624893850291301	\N	48882816	1.03355	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-16T23:00:00.000Z	defillama-api	4.928052196717658	\N	47511559	1.03384	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-17T23:00:00.000Z	defillama-api	4.928042393359533	\N	47311995	1.03384	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-18T23:00:00.000Z	defillama-api	4.785133940288233	\N	49184257	1.03413	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-19T23:00:00.000Z	defillama-api	4.785133940288233	\N	49480331	1.03413	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-20T23:00:00.000Z	defillama-api	4.820027593055443	\N	50427140	1.03442	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-21T23:00:00.000Z	defillama-api	4.820037396413568	\N	50769545	1.03442	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-22T23:00:00.000Z	defillama-api	4.767773593528091	\N	50910451	1.03471	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-23T23:00:00.000Z	defillama-api	4.767783396886216	\N	49677867	1.03471	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-24T23:00:00.000Z	defillama-api	4.854517907659783	\N	48203144	1.03472	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-25T23:00:00.000Z	defillama-api	4.833310443075334	\N	48483802	1.035	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-26T23:00:00.000Z	defillama-api	4.833310443075334	\N	49985203	1.035	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-27T23:00:00.000Z	defillama-api	4.895977009411467	\N	46577277	1.03529	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-28T23:00:00.000Z	defillama-api	4.895977009411467	\N	46067103	1.03529	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-29T23:00:00.000Z	defillama-api	4.826440389749109	\N	46083815	1.03558	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-30T23:00:00.000Z	defillama-api	4.826440389749109	\N	46811262	1.03558	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-07-31T23:00:00.000Z	defillama-api	5.118016068550446	\N	45381673	1.03589	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-01T23:00:00.000Z	defillama-api	5.147940118988004	\N	104495435	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-02T23:00:00.000Z	defillama-api	5.15327804748722	\N	108360068	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-03T23:00:00.000Z	defillama-api	5.15327804748722	\N	110401008	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-04T23:00:00.000Z	defillama-api	5.173382634282575	\N	109819419	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-05T23:00:00.000Z	defillama-api	5.173382634282575	\N	109725608	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-06T23:00:00.000Z	defillama-api	5.179507632391278	\N	110493290	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-07T23:00:00.000Z	defillama-api	5.179507632391278	\N	108311269	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-08T23:00:00.000Z	defillama-api	5.181359066597224	\N	103417390	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-09T23:00:00.000Z	defillama-api	5.181359066597224	\N	104363389	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-10T23:00:00.000Z	defillama-api	5.175110826272089	\N	104327651	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-11T23:00:00.000Z	defillama-api	5.175110826272089	\N	104071242	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-12T23:00:00.000Z	defillama-api	5.181453598979147	\N	102295588	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-13T23:00:00.000Z	defillama-api	5.181453598979147	\N	99374649	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-14T23:00:00.000Z	defillama-api	5.18223226571024	\N	103926557	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-15T23:00:00.000Z	defillama-api	5.18223226571024	\N	103639976	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-16T23:00:00.000Z	defillama-api	5.163487544734835	\N	100799447	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-17T23:00:00.000Z	defillama-api	5.163487544734835	\N	100143484	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-18T23:00:00.000Z	defillama-api	5.15154005213958	\N	100870747	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-19T23:00:00.000Z	defillama-api	5.15154005213958	\N	101730812	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-20T23:00:00.000Z	defillama-api	5.160676781912343	\N	103605670	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-21T23:00:00.000Z	defillama-api	5.160676781912343	\N	104257537	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-22T23:00:00.000Z	defillama-api	5.147683831197014	\N	104098305	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-23T23:00:00.000Z	defillama-api	5.147683831197014	\N	101851236	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-24T23:00:00.000Z	defillama-api	5.147683831197014	\N	98844099	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-25T23:00:00.000Z	defillama-api	5.143371754101622	\N	99639520	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-26T23:00:00.000Z	defillama-api	5.143371754101622	\N	102545987	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-27T23:00:00.000Z	defillama-api	5.131174275874173	\N	99849895	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-28T23:00:00.000Z	defillama-api	5.131174275874173	\N	98366891	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-29T23:00:00.000Z	defillama-api	5.11530824098827	\N	98521555	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-30T23:00:00.000Z	defillama-api	5.11530824098827	\N	100143418	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-07-31T23:00:00.000Z	defillama-api	5.107317803876299	\N	97662035	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-01T23:00:00.000Z	defillama-api	5.405201243391389	\N	10776658	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-02T23:00:00.000Z	defillama-api	5.40142064835436	\N	11146317	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-03T23:00:00.000Z	defillama-api	5.40142064835436	\N	11442381	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-04T23:00:00.000Z	defillama-api	5.395565942833969	\N	11291132	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-05T23:00:00.000Z	defillama-api	5.395565942833969	\N	11322601	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-06T23:00:00.000Z	defillama-api	5.378443677628297	\N	11416173	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-07T23:00:00.000Z	defillama-api	5.378443677628297	\N	11211116	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-08T23:00:00.000Z	defillama-api	5.368445652820242	\N	10716204	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-09T23:00:00.000Z	defillama-api	5.368445652820242	\N	10819513	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-10T23:00:00.000Z	defillama-api	5.361858496399918	\N	10811365	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-11T23:00:00.000Z	defillama-api	5.361858496399918	\N	10786385	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-12T23:00:00.000Z	defillama-api	5.351650399632035	\N	10611278	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-13T23:00:00.000Z	defillama-api	5.351650399632035	\N	10289082	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-14T23:00:00.000Z	defillama-api	5.34466410648804	\N	10771617	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-15T23:00:00.000Z	defillama-api	5.34466410648804	\N	10750395	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-16T23:00:00.000Z	defillama-api	5.333107347738064	\N	10450990	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-17T23:00:00.000Z	defillama-api	5.333107347738064	\N	10387162	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-18T23:00:00.000Z	defillama-api	5.329533323461533	\N	10468075	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-19T23:00:00.000Z	defillama-api	5.329533323461533	\N	10567075	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-20T23:00:00.000Z	defillama-api	5.326471174527114	\N	10792479	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-21T23:00:00.000Z	defillama-api	5.326471174527114	\N	10809712	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-22T23:00:00.000Z	defillama-api	5.321777466704702	\N	10781779	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-23T23:00:00.000Z	defillama-api	5.321777466704702	\N	10546791	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-24T23:00:00.000Z	defillama-api	5.321777466704702	\N	10236056	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-25T23:00:00.000Z	defillama-api	5.3219007089211345	\N	10310521	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-26T23:00:00.000Z	defillama-api	5.3219007089211345	\N	10605109	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-27T23:00:00.000Z	defillama-api	5.329608949367071	\N	10306311	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-28T23:00:00.000Z	defillama-api	5.329608949367071	\N	10182250	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-29T23:00:00.000Z	defillama-api	5.327826838907868	\N	10189793	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-30T23:00:00.000Z	defillama-api	5.327826838907868	\N	10292415	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-07-31T23:00:00.000Z	defillama-api	5.3283765272027495	\N	10070015	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-01T23:00:00.000Z	defillama-api	5.852576090958905	\N	14451226	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-02T23:00:00.000Z	defillama-api	5.828702112964379	\N	15036294	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-03T23:00:00.000Z	defillama-api	5.828702112964379	\N	15295999	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-04T23:00:00.000Z	defillama-api	5.812936912619193	\N	15183740	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-05T23:00:00.000Z	defillama-api	5.812936912619193	\N	15156765	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-06T23:00:00.000Z	defillama-api	5.8375601472704375	\N	15284620	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-07T23:00:00.000Z	defillama-api	5.8375601472704375	\N	15020589	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-08T23:00:00.000Z	defillama-api	5.870023267462443	\N	14325303	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-09T23:00:00.000Z	defillama-api	5.870023267462443	\N	14470005	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-10T23:00:00.000Z	defillama-api	5.889587969321042	\N	14364000	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-11T23:00:00.000Z	defillama-api	5.889587969321042	\N	14326538	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-12T23:00:00.000Z	defillama-api	5.91639805307409	\N	14079852	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-13T23:00:00.000Z	defillama-api	5.91639805307409	\N	13707261	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-14T23:00:00.000Z	defillama-api	5.941071004755827	\N	14287780	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-15T23:00:00.000Z	defillama-api	5.941071004755827	\N	14293694	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-16T23:00:00.000Z	defillama-api	5.963156570132355	\N	13942552	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-17T23:00:00.000Z	defillama-api	5.963156570132355	\N	13832993	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-18T23:00:00.000Z	defillama-api	5.927877785438795	\N	14006818	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-19T23:00:00.000Z	defillama-api	5.927877785438795	\N	14139006	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-20T23:00:00.000Z	defillama-api	5.9507105067524435	\N	14366215	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-21T23:00:00.000Z	defillama-api	5.9507105067524435	\N	14477413	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-22T23:00:00.000Z	defillama-api	5.969195438737529	\N	14456112	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-23T23:00:00.000Z	defillama-api	5.969195438737529	\N	14135913	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-24T23:00:00.000Z	defillama-api	5.969195438737529	\N	13731708	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-25T23:00:00.000Z	defillama-api	5.995390011648283	\N	13833919	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-26T23:00:00.000Z	defillama-api	5.995390011648283	\N	14301935	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-27T23:00:00.000Z	defillama-api	5.992150702027743	\N	13898920	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-28T23:00:00.000Z	defillama-api	5.992150702027743	\N	13712100	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-29T23:00:00.000Z	defillama-api	5.990690701906942	\N	13720875	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-30T23:00:00.000Z	defillama-api	5.990690701906942	\N	13957992	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-07-31T23:00:00.000Z	defillama-api	5.999167105485981	\N	13490204	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-01T23:00:00.000Z	defillama-api	4.958489522977061	\N	407504162	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-02T23:00:00.000Z	defillama-api	4.974837322890835	\N	422223174	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-03T23:00:00.000Z	defillama-api	4.974837322890835	\N	430341994	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-04T23:00:00.000Z	defillama-api	4.977539548534082	\N	428239292	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-05T23:00:00.000Z	defillama-api	4.977539548534082	\N	427946052	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-06T23:00:00.000Z	defillama-api	4.936714163861211	\N	431235394	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-07T23:00:00.000Z	defillama-api	4.936714163861211	\N	423850106	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-08T23:00:00.000Z	defillama-api	4.891968136178093	\N	405523090	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-09T23:00:00.000Z	defillama-api	4.891968136178093	\N	409422142	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-10T23:00:00.000Z	defillama-api	4.883026073088104	\N	409102153	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-11T23:00:00.000Z	defillama-api	4.883026073088104	\N	408343183	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-12T23:00:00.000Z	defillama-api	4.882768384817382	\N	400900730	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-13T23:00:00.000Z	defillama-api	4.882768384817382	\N	390468800	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-14T23:00:00.000Z	defillama-api	4.8732066094459014	\N	117273304	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-15T23:00:00.000Z	defillama-api	4.8732066094459014	\N	116789090	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-16T23:00:00.000Z	defillama-api	4.837235987764643	\N	113962018	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-17T23:00:00.000Z	defillama-api	4.837235987764643	\N	112709804	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-18T23:00:00.000Z	defillama-api	4.8189030078304995	\N	113746071	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-19T23:00:00.000Z	defillama-api	4.8189030078304995	\N	114793619	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-20T23:00:00.000Z	defillama-api	4.8104693188832925	\N	116690842	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-21T23:00:00.000Z	defillama-api	4.8104693188832925	\N	117392166	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-22T23:00:00.000Z	defillama-api	4.779728788761872	\N	117263266	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-23T23:00:00.000Z	defillama-api	4.779728788761872	\N	114712390	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-24T23:00:00.000Z	defillama-api	4.779728788761872	\N	111403368	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-25T23:00:00.000Z	defillama-api	4.753070657059766	\N	112204084	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-26T23:00:00.000Z	defillama-api	4.753070657059766	\N	115499194	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-27T23:00:00.000Z	defillama-api	4.759897995754159	\N	112374410	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-28T23:00:00.000Z	defillama-api	4.759897995754159	\N	110712498	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-29T23:00:00.000Z	defillama-api	4.760441381890246	\N	110873128	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-30T23:00:00.000Z	defillama-api	4.760441381890246	\N	112587817	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-07-31T23:00:00.000Z	defillama-api	4.737563845225168	\N	109919350	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-01T23:00:00.000Z	defillama-api	5.2551937585576525	\N	3628966	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-02T23:00:00.000Z	defillama-api	5.250487446417651	\N	3792824	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-03T23:00:00.000Z	defillama-api	5.250487446417651	\N	3875045	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-04T23:00:00.000Z	defillama-api	5.2431433307020825	\N	3858865	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-05T23:00:00.000Z	defillama-api	5.2431433307020825	\N	3792277	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-06T23:00:00.000Z	defillama-api	5.2370414405089605	\N	3809172	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-07T23:00:00.000Z	defillama-api	5.2370414405089605	\N	3732501	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-08T23:00:00.000Z	defillama-api	5.225216489890272	\N	3453959	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-09T23:00:00.000Z	defillama-api	5.225216489890272	\N	3462272	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-10T23:00:00.000Z	defillama-api	5.217167932869415	\N	3398634	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-11T23:00:00.000Z	defillama-api	5.217167932869415	\N	3395602	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-12T23:00:00.000Z	defillama-api	5.246360232646907	\N	3325251	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-13T23:00:00.000Z	defillama-api	5.246360232646907	\N	3235469	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-14T23:00:00.000Z	defillama-api	5.242384270687239	\N	3339694	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-15T23:00:00.000Z	defillama-api	5.242384270687239	\N	3355829	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-16T23:00:00.000Z	defillama-api	5.234488365957191	\N	3273217	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-17T23:00:00.000Z	defillama-api	5.234488365957191	\N	3249954	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-18T23:00:00.000Z	defillama-api	5.246863004870761	\N	3260007	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-19T23:00:00.000Z	defillama-api	5.246863004870761	\N	3247960	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-20T23:00:00.000Z	defillama-api	5.2460185155922545	\N	3301279	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-21T23:00:00.000Z	defillama-api	5.2460185155922545	\N	3351726	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-22T23:00:00.000Z	defillama-api	5.242497709545546	\N	3261292	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-23T23:00:00.000Z	defillama-api	5.242497709545546	\N	3249895	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-24T23:00:00.000Z	defillama-api	5.242497709545546	\N	3162678	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-25T23:00:00.000Z	defillama-api	5.246502381339724	\N	3173116	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-26T23:00:00.000Z	defillama-api	5.246502381339724	\N	3262115	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-27T23:00:00.000Z	defillama-api	5.237535109614555	\N	3171894	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-28T23:00:00.000Z	defillama-api	5.237535109614555	\N	3173994	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-29T23:00:00.000Z	defillama-api	5.236224960825098	\N	3113622	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-30T23:00:00.000Z	defillama-api	5.236224960825098	\N	3181046	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-07-31T23:00:00.000Z	defillama-api	5.242782707171045	\N	3103979	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-01T23:00:00.000Z	defillama-api	5.45666887354912	\N	7800672	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-02T23:00:00.000Z	defillama-api	5.511507458422216	\N	8098714	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-03T23:00:00.000Z	defillama-api	5.572842168533043	\N	8325650	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-04T23:00:00.000Z	defillama-api	5.551143135562597	\N	8274881	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-05T23:00:00.000Z	defillama-api	5.581174322699667	\N	8259696	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-06T23:00:00.000Z	defillama-api	5.56854829767417	\N	8333907	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-07T23:00:00.000Z	defillama-api	5.585164989696523	\N	8184824	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-08T23:00:00.000Z	defillama-api	5.564376968791862	\N	7945031	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-09T23:00:00.000Z	defillama-api	5.577154945868301	\N	8016889	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-10T23:00:00.000Z	defillama-api	5.553157725657343	\N	8024336	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-11T23:00:00.000Z	defillama-api	5.558190349574943	\N	7999173	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-12T23:00:00.000Z	defillama-api	5.513031180370831	\N	7885629	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-13T23:00:00.000Z	defillama-api	5.495569298830105	\N	7654428	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-14T23:00:00.000Z	defillama-api	5.412713416674819	\N	7990390	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-15T23:00:00.000Z	defillama-api	5.358958102874567	\N	7941525	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-16T23:00:00.000Z	defillama-api	5.329940863063598	\N	7710187	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-17T23:00:00.000Z	defillama-api	5.292702106984848	\N	7689678	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-18T23:00:00.000Z	defillama-api	5.295633311064307	\N	7739288	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-19T23:00:00.000Z	defillama-api	5.289913751838071	\N	7731442	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-20T23:00:00.000Z	defillama-api	5.256787504492877	\N	7883464	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-21T23:00:00.000Z	defillama-api	5.244367349988011	\N	7930550	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-22T23:00:00.000Z	defillama-api	5.264719121456096	\N	7997628	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-23T23:00:00.000Z	defillama-api	5.297055498232339	\N	7810349	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-24T23:00:00.000Z	defillama-api	5.270069654272902	\N	7582075	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-25T23:00:00.000Z	defillama-api	5.2580304302551895	\N	7601416	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-26T23:00:00.000Z	defillama-api	5.216892738602041	\N	7817676	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-27T23:00:00.000Z	defillama-api	5.199483375051273	\N	7607751	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-28T23:00:00.000Z	defillama-api	5.19984399858231	\N	7516861	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-29T23:00:00.000Z	defillama-api	5.164124062773112	\N	7525143	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-30T23:00:00.000Z	defillama-api	5.163439928423941	\N	7653866	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-07-31T23:00:00.000Z	defillama-api	5.164465779827765	\N	7373909	\N	\N
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
