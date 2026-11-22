-- Generated from VAULT_LLAMA_LST/solana/2026-06.ndjson (510 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-01T23:00:00.000Z	defillama-api	5.750352274347392	\N	430024979	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-02T23:00:00.000Z	defillama-api	5.7180866217976245	\N	400081677	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-03T23:00:00.000Z	defillama-api	5.7180866217976245	\N	382390374	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-04T23:00:00.000Z	defillama-api	5.66070546597075	\N	359552746	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-05T23:00:00.000Z	defillama-api	5.66070546597075	\N	347712330	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-06T23:00:00.000Z	defillama-api	5.612907092711339	\N	330622255	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-07T23:00:00.000Z	defillama-api	5.612907092711339	\N	352647906	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-08T23:00:00.000Z	defillama-api	5.579708020420071	\N	354467705	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-09T23:00:00.000Z	defillama-api	5.579708020420071	\N	345696723	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-10T23:00:00.000Z	defillama-api	5.556345917767658	\N	338593422	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-11T23:00:00.000Z	defillama-api	5.556345917767658	\N	361772442	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-12T23:00:00.000Z	defillama-api	5.522882154807007	\N	358873404	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-13T23:00:00.000Z	defillama-api	5.522882154807007	\N	371707280	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-14T23:00:00.000Z	defillama-api	5.485421422690706	\N	381949655	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-15T23:00:00.000Z	defillama-api	5.485421422690706	\N	399314534	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-16T23:00:00.000Z	defillama-api	5.4629367205905055	\N	397705053	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-17T23:00:00.000Z	defillama-api	5.4629367205905055	\N	387395211	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-18T23:00:00.000Z	defillama-api	5.447852853635027	\N	373968750	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-19T23:00:00.000Z	defillama-api	5.447852853635027	\N	372665820	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-20T23:00:00.000Z	defillama-api	5.4369620229977045	\N	394623387	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-21T23:00:00.000Z	defillama-api	5.4369620229977045	\N	392344334	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-22T23:00:00.000Z	defillama-api	5.430133283823579	\N	386259893	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-23T23:00:00.000Z	defillama-api	5.430133283823579	\N	372565779	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-24T23:00:00.000Z	defillama-api	5.429972228654378	\N	362843226	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-25T23:00:00.000Z	defillama-api	5.429972228654378	\N	359879157	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-26T23:00:00.000Z	defillama-api	5.42805847310035	\N	384745783	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-27T23:00:00.000Z	defillama-api	5.42805847310035	\N	380006285	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-28T23:00:00.000Z	defillama-api	5.416824524928643	\N	374200121	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-29T23:00:00.000Z	defillama-api	5.416824524928643	\N	402269822	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-06-30T23:00:00.000Z	defillama-api	5.4003975979100005	\N	389981533	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-01T23:00:00.000Z	defillama-api	5.015961009746661	\N	245359442	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-02T23:00:00.000Z	defillama-api	6.695531844158609	\N	213070153	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-03T23:00:00.000Z	defillama-api	5.018404846879321	\N	204482438	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-04T23:00:00.000Z	defillama-api	6.711102377821021	\N	187019950	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-05T23:00:00.000Z	defillama-api	4.996309478144667	\N	168550486	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-06T23:00:00.000Z	defillama-api	6.657638363805063	\N	160038732	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-07T23:00:00.000Z	defillama-api	5.034695227124075	\N	171290305	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-08T23:00:00.000Z	defillama-api	6.721069592074969	\N	172739664	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-09T23:00:00.000Z	defillama-api	5.0446218274657895	\N	167394937	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-10T23:00:00.000Z	defillama-api	6.752546074295651	\N	158639007	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-11T23:00:00.000Z	defillama-api	5.062324591520451	\N	169375410	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-12T23:00:00.000Z	defillama-api	6.745834975419029	\N	166712327	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-13T23:00:00.000Z	defillama-api	5.0819817250413735	\N	172668455	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-14T23:00:00.000Z	defillama-api	6.802054433308058	\N	176374249	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-15T23:00:00.000Z	defillama-api	5.112458264733277	\N	184119900	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-16T23:00:00.000Z	defillama-api	6.8245391354082585	\N	184268705	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-17T23:00:00.000Z	defillama-api	5.113265641298881	\N	179533984	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-18T23:00:00.000Z	defillama-api	6.802213387757661	\N	173283003	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-19T23:00:00.000Z	defillama-api	5.11611631779374	\N	173042161	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-20T23:00:00.000Z	defillama-api	6.809229090976032	\N	183543668	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-21T23:00:00.000Z	defillama-api	5.09169475222393	\N	182598526	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-22T23:00:00.000Z	defillama-api	6.831338464508008	\N	180178643	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-23T23:00:00.000Z	defillama-api	5.119261095032357	\N	173384132	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-24T23:00:00.000Z	defillama-api	6.749040673525997	\N	169134374	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-25T23:00:00.000Z	defillama-api	5.060118835942262	\N	167393759	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-26T23:00:00.000Z	defillama-api	6.657179706692773	\N	178989374	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-27T23:00:00.000Z	defillama-api	4.967472199979284	\N	176987219	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-28T23:00:00.000Z	defillama-api	6.438891832516447	\N	174462163	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-29T23:00:00.000Z	defillama-api	4.700008580726944	\N	183649629	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-06-30T23:00:00.000Z	defillama-api	6.253104191245029	\N	178282556	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-01T23:00:00.000Z	defillama-api	5.27821834559461	\N	110332363	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-02T23:00:00.000Z	defillama-api	5.268732196128667	\N	98032911	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-03T23:00:00.000Z	defillama-api	5.268732196128667	\N	95653180	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-04T23:00:00.000Z	defillama-api	5.401459161546995	\N	86915801	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-05T23:00:00.000Z	defillama-api	5.401459161546995	\N	82037988	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-06T23:00:00.000Z	defillama-api	5.2497570962373175	\N	78683953	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-07T23:00:00.000Z	defillama-api	5.2497570962373175	\N	83805401	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-08T23:00:00.000Z	defillama-api	5.27821834559461	\N	82391795	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-09T23:00:00.000Z	defillama-api	5.27821834559461	\N	79037510	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-10T23:00:00.000Z	defillama-api	5.164323631134948	\N	75988711	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-11T23:00:00.000Z	defillama-api	5.164323631134948	\N	80909079	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-12T23:00:00.000Z	defillama-api	5.259245346422858	\N	80392189	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-13T23:00:00.000Z	defillama-api	5.259245346422858	\N	83295925	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-14T23:00:00.000Z	defillama-api	5.268732196128667	\N	85225171	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-15T23:00:00.000Z	defillama-api	5.268732196128667	\N	89474540	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-16T23:00:00.000Z	defillama-api	5.230777794906771	\N	89305709	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-17T23:00:00.000Z	defillama-api	5.230777794906771	\N	87185634	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-18T23:00:00.000Z	defillama-api	5.335117736393613	\N	84277991	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-19T23:00:00.000Z	defillama-api	5.335117736393613	\N	84250188	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-20T23:00:00.000Z	defillama-api	5.2402681458119105	\N	89541636	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-21T23:00:00.000Z	defillama-api	5.2402681458119105	\N	88896397	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-22T23:00:00.000Z	defillama-api	5.373032223943142	\N	87486730	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-23T23:00:00.000Z	defillama-api	5.373032223943142	\N	84574022	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-24T23:00:00.000Z	defillama-api	5.164323631134948	\N	82663692	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-25T23:00:00.000Z	defillama-api	5.164323631134948	\N	82047643	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-26T23:00:00.000Z	defillama-api	5.2497570962373175	\N	87715043	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-27T23:00:00.000Z	defillama-api	5.2497570962373175	\N	86746072	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-28T23:00:00.000Z	defillama-api	5.259245346422858	\N	85659901	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-29T23:00:00.000Z	defillama-api	5.259245346422858	\N	92031721	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-06-30T23:00:00.000Z	defillama-api	5.230777794906771	\N	89352903	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-01T23:00:00.000Z	defillama-api	5.4855544682652635	\N	69239931	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-02T23:00:00.000Z	defillama-api	5.476541680948799	\N	64851359	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-03T23:00:00.000Z	defillama-api	5.476541680948799	\N	61797302	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-04T23:00:00.000Z	defillama-api	5.402415689204076	\N	58851846	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-05T23:00:00.000Z	defillama-api	5.402415689204076	\N	53976052	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-06T23:00:00.000Z	defillama-api	5.4138316997409675	\N	54893425	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-07T23:00:00.000Z	defillama-api	5.4138316997409675	\N	56560413	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-08T23:00:00.000Z	defillama-api	5.55644045014958	\N	56986365	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-09T23:00:00.000Z	defillama-api	5.55644045014958	\N	55642387	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-10T23:00:00.000Z	defillama-api	5.531587536822258	\N	53544789	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-11T23:00:00.000Z	defillama-api	5.531587536822258	\N	57472929	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-12T23:00:00.000Z	defillama-api	5.550225121098151	\N	57009341	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-13T23:00:00.000Z	defillama-api	5.550225121098151	\N	59083683	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-14T23:00:00.000Z	defillama-api	5.547415758755392	\N	59826420	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-15T23:00:00.000Z	defillama-api	5.547415758755392	\N	62674300	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-16T23:00:00.000Z	defillama-api	5.6074522241544855	\N	63060960	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-17T23:00:00.000Z	defillama-api	5.6074522241544855	\N	61506481	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-18T23:00:00.000Z	defillama-api	5.585807809893595	\N	59653787	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-19T23:00:00.000Z	defillama-api	5.585807809893595	\N	59247010	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-20T23:00:00.000Z	defillama-api	5.583708490775052	\N	64180320	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-21T23:00:00.000Z	defillama-api	5.583708490775052	\N	63784762	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-22T23:00:00.000Z	defillama-api	5.581571358703741	\N	63094247	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-23T23:00:00.000Z	defillama-api	5.581571358703741	\N	60669299	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-24T23:00:00.000Z	defillama-api	5.56946561189875	\N	58680454	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-25T23:00:00.000Z	defillama-api	5.56946561189875	\N	58693247	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-26T23:00:00.000Z	defillama-api	5.613814603577794	\N	62837678	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-27T23:00:00.000Z	defillama-api	5.613814603577794	\N	62138517	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-28T23:00:00.000Z	defillama-api	5.614637385420451	\N	61338797	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-29T23:00:00.000Z	defillama-api	5.614637385420451	\N	65663764	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-06-30T23:00:00.000Z	defillama-api	5.611706881580858	\N	64052382	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-01T23:00:00.000Z	defillama-api	5.884261244659683	\N	225345432	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-02T23:00:00.000Z	defillama-api	5.872257732875141	\N	208239922	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-03T23:00:00.000Z	defillama-api	5.872257732875141	\N	200923635	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-04T23:00:00.000Z	defillama-api	5.842531150079822	\N	192726879	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-05T23:00:00.000Z	defillama-api	5.842531150079822	\N	174439542	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-06T23:00:00.000Z	defillama-api	5.8104461594155055	\N	182384109	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-07T23:00:00.000Z	defillama-api	5.8104461594155055	\N	183869225	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-08T23:00:00.000Z	defillama-api	5.8043596744994375	\N	186615675	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-09T23:00:00.000Z	defillama-api	5.8043596744994375	\N	181188139	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-10T23:00:00.000Z	defillama-api	5.801755482437443	\N	174507721	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-11T23:00:00.000Z	defillama-api	5.801755482437443	\N	186753113	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-12T23:00:00.000Z	defillama-api	5.801944547201288	\N	185665512	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-13T23:00:00.000Z	defillama-api	5.801944547201288	\N	192640443	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-14T23:00:00.000Z	defillama-api	5.797924470130056	\N	196937808	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-15T23:00:00.000Z	defillama-api	5.797924470130056	\N	203672002	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-16T23:00:00.000Z	defillama-api	5.803821890282279	\N	205502702	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-17T23:00:00.000Z	defillama-api	5.803821890282279	\N	200239290	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-18T23:00:00.000Z	defillama-api	5.779549475803947	\N	193819571	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-19T23:00:00.000Z	defillama-api	5.779549475803947	\N	193224807	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-20T23:00:00.000Z	defillama-api	5.753571277011815	\N	205093481	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-21T23:00:00.000Z	defillama-api	5.753571277011815	\N	203749561	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-22T23:00:00.000Z	defillama-api	5.730344320653558	\N	200783127	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-23T23:00:00.000Z	defillama-api	5.730344320653558	\N	193654756	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-24T23:00:00.000Z	defillama-api	5.705609747863605	\N	188878990	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-25T23:00:00.000Z	defillama-api	5.705609747863605	\N	187461655	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-26T23:00:00.000Z	defillama-api	5.707461182069551	\N	200554964	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-27T23:00:00.000Z	defillama-api	5.707461182069551	\N	198318409	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-28T23:00:00.000Z	defillama-api	5.680491443627034	\N	196422312	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-29T23:00:00.000Z	defillama-api	5.680491443627034	\N	210685020	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-06-30T23:00:00.000Z	defillama-api	5.651151393237797	\N	204691287	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-01T23:00:00.000Z	defillama-api	5.6481459637325315	\N	66813536	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-02T23:00:00.000Z	defillama-api	5.6371353920781075	\N	60885500	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-03T23:00:00.000Z	defillama-api	5.6371353920781075	\N	59612837	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-04T23:00:00.000Z	defillama-api	5.681634235088495	\N	56294366	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-05T23:00:00.000Z	defillama-api	5.681634235088495	\N	53694402	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-06T23:00:00.000Z	defillama-api	5.673735529398982	\N	51013819	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-07T23:00:00.000Z	defillama-api	5.673735529398982	\N	54542305	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-08T23:00:00.000Z	defillama-api	5.668822646498484	\N	55393487	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-09T23:00:00.000Z	defillama-api	5.668822646498484	\N	53934674	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-10T23:00:00.000Z	defillama-api	5.665420881229011	\N	52207710	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-11T23:00:00.000Z	defillama-api	5.665420881229011	\N	55417341	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-12T23:00:00.000Z	defillama-api	5.664154847551117	\N	55134893	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-13T23:00:00.000Z	defillama-api	5.664154847551117	\N	57155945	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-14T23:00:00.000Z	defillama-api	5.658891144477707	\N	58457079	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-15T23:00:00.000Z	defillama-api	5.658891144477707	\N	60407902	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-16T23:00:00.000Z	defillama-api	5.657870894992811	\N	60658562	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-17T23:00:00.000Z	defillama-api	5.657870894992811	\N	59059723	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-18T23:00:00.000Z	defillama-api	5.65544176289734	\N	57265196	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-19T23:00:00.000Z	defillama-api	5.65544176289734	\N	57044127	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-20T23:00:00.000Z	defillama-api	5.659741935915008	\N	60585119	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-21T23:00:00.000Z	defillama-api	5.659741935915008	\N	60092574	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-22T23:00:00.000Z	defillama-api	5.667688958155281	\N	59316914	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-23T23:00:00.000Z	defillama-api	5.667688958155281	\N	57218633	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-24T23:00:00.000Z	defillama-api	5.673972210473721	\N	55812105	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-25T23:00:00.000Z	defillama-api	5.673972210473721	\N	55388014	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-26T23:00:00.000Z	defillama-api	5.68165314156488	\N	59249772	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-27T23:00:00.000Z	defillama-api	5.68165314156488	\N	58542906	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-28T23:00:00.000Z	defillama-api	5.6894664179907295	\N	57991249	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-29T23:00:00.000Z	defillama-api	5.6894664179907295	\N	57965828	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-06-30T23:00:00.000Z	defillama-api	5.692111223964957	\N	56329507	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-01T23:00:00.000Z	defillama-api	5.858932868463285	\N	121477828	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-02T23:00:00.000Z	defillama-api	5.83570171066583	\N	111458616	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-03T23:00:00.000Z	defillama-api	5.83570171066583	\N	107836645	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-04T23:00:00.000Z	defillama-api	5.800198849215121	\N	101718031	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-05T23:00:00.000Z	defillama-api	5.800198849215121	\N	93839946	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-06T23:00:00.000Z	defillama-api	5.865430394180748	\N	93967939	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-07T23:00:00.000Z	defillama-api	5.865430394180748	\N	98372659	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-08T23:00:00.000Z	defillama-api	5.892199864021563	\N	100487458	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-09T23:00:00.000Z	defillama-api	5.892199864021563	\N	97345488	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-10T23:00:00.000Z	defillama-api	5.89150172487507	\N	93952705	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-11T23:00:00.000Z	defillama-api	5.89150172487507	\N	100254054	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-12T23:00:00.000Z	defillama-api	5.883186376465233	\N	99939485	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-13T23:00:00.000Z	defillama-api	5.883186376465233	\N	104003796	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-14T23:00:00.000Z	defillama-api	5.898403288995269	\N	107241150	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-15T23:00:00.000Z	defillama-api	5.898403288995269	\N	112755842	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-16T23:00:00.000Z	defillama-api	5.903710406940377	\N	113024908	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-17T23:00:00.000Z	defillama-api	5.903710406940377	\N	110092112	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-18T23:00:00.000Z	defillama-api	5.866288888256577	\N	107202966	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-19T23:00:00.000Z	defillama-api	5.866288888256577	\N	106921118	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-20T23:00:00.000Z	defillama-api	5.877689493516414	\N	113347906	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-21T23:00:00.000Z	defillama-api	5.877689493516414	\N	112685412	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-22T23:00:00.000Z	defillama-api	5.889701408179349	\N	111062598	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-23T23:00:00.000Z	defillama-api	5.889701408179349	\N	107181198	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-24T23:00:00.000Z	defillama-api	5.882592573058787	\N	104709722	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-25T23:00:00.000Z	defillama-api	5.882592573058787	\N	103849202	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-26T23:00:00.000Z	defillama-api	5.874898337410173	\N	111200425	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-27T23:00:00.000Z	defillama-api	5.874898337410173	\N	109970864	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-28T23:00:00.000Z	defillama-api	5.869023324933664	\N	108879846	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-29T23:00:00.000Z	defillama-api	5.869023324933664	\N	117035700	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-06-30T23:00:00.000Z	defillama-api	5.875331785887283	\N	113736974	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-01T23:00:00.000Z	defillama-api	5.240333968359323	\N	105036283	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-02T23:00:00.000Z	defillama-api	5.2296013919317375	\N	95387445	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-03T23:00:00.000Z	defillama-api	5.2296013919317375	\N	92688167	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-04T23:00:00.000Z	defillama-api	5.224162628891804	\N	87895075	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-05T23:00:00.000Z	defillama-api	5.224162628891804	\N	83195556	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-06T23:00:00.000Z	defillama-api	5.217196642703925	\N	79768696	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-07T23:00:00.000Z	defillama-api	5.217196642703925	\N	85118391	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-08T23:00:00.000Z	defillama-api	5.221970177871071	\N	86542480	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-09T23:00:00.000Z	defillama-api	5.221970177871071	\N	83923754	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-10T23:00:00.000Z	defillama-api	5.220034014641328	\N	81131712	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-11T23:00:00.000Z	defillama-api	5.220034014641328	\N	86459940	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-12T23:00:00.000Z	defillama-api	5.21951233594109	\N	85781554	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-13T23:00:00.000Z	defillama-api	5.21951233594109	\N	88820595	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-14T23:00:00.000Z	defillama-api	5.216199501134611	\N	90999293	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-15T23:00:00.000Z	defillama-api	5.216199501134611	\N	95312063	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-16T23:00:00.000Z	defillama-api	5.218050235100691	\N	95283139	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-17T23:00:00.000Z	defillama-api	5.218050235100691	\N	92802367	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-18T23:00:00.000Z	defillama-api	5.226592461227142	\N	89807563	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-19T23:00:00.000Z	defillama-api	5.226592461227142	\N	89677763	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-20T23:00:00.000Z	defillama-api	5.241852788628876	\N	95505203	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-21T23:00:00.000Z	defillama-api	5.241852788628876	\N	94762972	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-22T23:00:00.000Z	defillama-api	5.239242994647952	\N	93425951	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-23T23:00:00.000Z	defillama-api	5.239242994647952	\N	90140130	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-24T23:00:00.000Z	defillama-api	5.2280636651858	\N	88294923	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-25T23:00:00.000Z	defillama-api	5.2280636651858	\N	87293317	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-26T23:00:00.000Z	defillama-api	5.251863417754521	\N	93424460	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-27T23:00:00.000Z	defillama-api	5.251863417754521	\N	92327697	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-28T23:00:00.000Z	defillama-api	5.249016942698859	\N	91074937	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-29T23:00:00.000Z	defillama-api	5.249016942698859	\N	98001978	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-06-30T23:00:00.000Z	defillama-api	5.254339465921021	\N	95415359	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-01T23:00:00.000Z	defillama-api	5.074558482220937	\N	916557695	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-02T23:00:00.000Z	defillama-api	5.013145345245107	\N	836295982	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-03T23:00:00.000Z	defillama-api	5.013145345245107	\N	816046550	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-04T23:00:00.000Z	defillama-api	5.015561172783123	\N	769281264	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-05T23:00:00.000Z	defillama-api	5.015561172783123	\N	723778707	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-06T23:00:00.000Z	defillama-api	5.022037691304604	\N	694545599	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-07T23:00:00.000Z	defillama-api	5.022037691304604	\N	734199129	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-08T23:00:00.000Z	defillama-api	5.043100906476639	\N	752079093	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-09T23:00:00.000Z	defillama-api	5.043100906476639	\N	724351976	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-10T23:00:00.000Z	defillama-api	5.05522275879855	\N	699068821	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-11T23:00:00.000Z	defillama-api	5.05522275879855	\N	746187997	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-12T23:00:00.000Z	defillama-api	5.026269941055261	\N	741264391	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-13T23:00:00.000Z	defillama-api	5.026269941055261	\N	757998113	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-14T23:00:00.000Z	defillama-api	5.048272878127591	\N	774091545	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-15T23:00:00.000Z	defillama-api	5.048272878127591	\N	811098981	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-16T23:00:00.000Z	defillama-api	5.028809010809709	\N	806725715	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-17T23:00:00.000Z	defillama-api	5.028809010809709	\N	769452820	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-18T23:00:00.000Z	defillama-api	5.043414613936648	\N	745345157	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-19T23:00:00.000Z	defillama-api	5.043414613936648	\N	722927519	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-20T23:00:00.000Z	defillama-api	5.032079831224223	\N	769802298	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-21T23:00:00.000Z	defillama-api	5.032079831224223	\N	757774257	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-22T23:00:00.000Z	defillama-api	4.996490140030119	\N	746373812	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-23T23:00:00.000Z	defillama-api	4.996490140030119	\N	720083136	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-24T23:00:00.000Z	defillama-api	4.9641138495815085	\N	702854194	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-25T23:00:00.000Z	defillama-api	4.9641138495815085	\N	695964389	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-26T23:00:00.000Z	defillama-api	4.964551499497816	\N	738128674	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-27T23:00:00.000Z	defillama-api	4.964551499497816	\N	728946337	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-28T23:00:00.000Z	defillama-api	4.944861454703187	\N	722002289	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-29T23:00:00.000Z	defillama-api	4.944861454703187	\N	767238197	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-06-30T23:00:00.000Z	defillama-api	4.9172187857493554	\N	746093995	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-01T23:00:00.000Z	defillama-api	5.06233369463871	\N	62127993	1.09772	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-02T23:00:00.000Z	defillama-api	5.03093914048236	\N	56446650	1.09802	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-03T23:00:00.000Z	defillama-api	5.03093914048236	\N	55154256	1.09802	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-04T23:00:00.000Z	defillama-api	4.775772433518455	\N	52310034	1.0983	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-05T23:00:00.000Z	defillama-api	4.775763330400196	\N	49290372	1.0983	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-06T23:00:00.000Z	defillama-api	5.004090543536677	\N	47238823	1.0986	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-07T23:00:00.000Z	defillama-api	5.004090543536677	\N	50326040	1.0986	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-08T23:00:00.000Z	defillama-api	5.048900293047609	\N	51272037	1.09891	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-09T23:00:00.000Z	defillama-api	5.048900293047609	\N	49620751	1.09891	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-10T23:00:00.000Z	defillama-api	4.860309591592227	\N	48074460	1.0992	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-11T23:00:00.000Z	defillama-api	4.860309591592227	\N	51191183	1.0992	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-12T23:00:00.000Z	defillama-api	5.1044006045941615	\N	50966075	1.0995	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-13T23:00:00.000Z	defillama-api	5.1044006045941615	\N	52722070	1.0995	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-14T23:00:00.000Z	defillama-api	5.101169697852015	\N	53896330	1.09981	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-15T23:00:00.000Z	defillama-api	5.101178800970274	\N	56442647	1.09981	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-16T23:00:00.000Z	defillama-api	5.074548678862811	\N	56458091	1.10011	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-17T23:00:00.000Z	defillama-api	5.074548678862811	\N	54959530	1.10011	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-18T23:00:00.000Z	defillama-api	4.917732761811067	\N	53225405	1.1004	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-19T23:00:00.000Z	defillama-api	4.917722958452941	\N	53062724	1.1004	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-20T23:00:00.000Z	defillama-api	5.174503018068322	\N	56398691	1.10071	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-21T23:00:00.000Z	defillama-api	5.174512821426447	\N	55949519	1.10071	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-22T23:00:00.000Z	defillama-api	4.871568748399113	\N	55138856	1.10101	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-23T23:00:00.000Z	defillama-api	4.871558945040988	\N	53243871	1.10101	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-24T23:00:00.000Z	defillama-api	5.101958167941234	\N	51958207	1.10131	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-25T23:00:00.000Z	defillama-api	5.101958167941234	\N	51383779	1.10131	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-26T23:00:00.000Z	defillama-api	5.0963037310225445	\N	55011093	1.10162	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-27T23:00:00.000Z	defillama-api	5.0963037310225445	\N	54417083	1.10162	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-28T23:00:00.000Z	defillama-api	4.8564617735280535	\N	53724232	1.10192	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-29T23:00:00.000Z	defillama-api	4.856451970169928	\N	56893894	1.10192	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-06-30T23:00:00.000Z	defillama-api	5.040761405084027	\N	55455516	1.10222	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-01T23:00:00.000Z	defillama-api	5.178254203030974	\N	54802414	1.02737	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-02T23:00:00.000Z	defillama-api	4.991838446599672	\N	49776389	1.02765	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-03T23:00:00.000Z	defillama-api	4.991838446599672	\N	47836415	1.02765	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-04T23:00:00.000Z	defillama-api	4.998212029860838	\N	44163169	1.02793	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-05T23:00:00.000Z	defillama-api	4.998221833218963	\N	42081018	1.02793	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-06T23:00:00.000Z	defillama-api	4.898728952085207	\N	40276002	1.0282	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-07T23:00:00.000Z	defillama-api	4.898719148727082	\N	42255920	1.0282	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-08T23:00:00.000Z	defillama-api	4.993798417984863	\N	43748966	1.02848	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-09T23:00:00.000Z	defillama-api	4.993798417984863	\N	41991770	1.02848	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-10T23:00:00.000Z	defillama-api	4.95910783477882	\N	40608330	1.02876	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-11T23:00:00.000Z	defillama-api	4.95910783477882	\N	43004586	1.02876	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-12T23:00:00.000Z	defillama-api	5.326594416743546	\N	42712908	1.02906	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-13T23:00:00.000Z	defillama-api	5.326603519861806	\N	44184478	1.02906	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-14T23:00:00.000Z	defillama-api	5.191185532638087	\N	44945947	1.02935	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-15T23:00:00.000Z	defillama-api	5.191185532638087	\N	47071687	1.02935	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-16T23:00:00.000Z	defillama-api	5.182223162591981	\N	46966578	1.02964	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-17T23:00:00.000Z	defillama-api	5.182223162591981	\N	46609350	1.02964	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-18T23:00:00.000Z	defillama-api	4.987861784400138	\N	44974246	1.02992	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-19T23:00:00.000Z	defillama-api	4.987852681281879	\N	44836785	1.02992	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-20T23:00:00.000Z	defillama-api	4.9904022546343185	\N	47468039	1.0302	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-21T23:00:00.000Z	defillama-api	4.9904022546343185	\N	46946165	1.0302	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-22T23:00:00.000Z	defillama-api	5.00965464951264	\N	46332877	1.03048	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-23T23:00:00.000Z	defillama-api	5.00965464951264	\N	44887197	1.03048	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-24T23:00:00.000Z	defillama-api	4.966577993670285	\N	43940472	1.03076	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-25T23:00:00.000Z	defillama-api	4.96658779702841	\N	43466785	1.03076	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-26T23:00:00.000Z	defillama-api	4.925396186905573	\N	46377260	1.03104	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-27T23:00:00.000Z	defillama-api	4.925396186905573	\N	45893264	1.03104	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-28T23:00:00.000Z	defillama-api	4.917390344516548	\N	45313574	1.03131	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-29T23:00:00.000Z	defillama-api	4.917380541158423	\N	48531268	1.03131	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-06-30T23:00:00.000Z	defillama-api	4.886997133368709	\N	47224849	1.03159	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-01T23:00:00.000Z	defillama-api	5.190710770008877	\N	107401351	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-02T23:00:00.000Z	defillama-api	5.182175546281087	\N	98579767	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-03T23:00:00.000Z	defillama-api	5.182175546281087	\N	95735480	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-04T23:00:00.000Z	defillama-api	5.165310969346137	\N	91402827	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-05T23:00:00.000Z	defillama-api	5.165310969346137	\N	84433363	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-06T23:00:00.000Z	defillama-api	5.157305126957112	\N	82302095	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-07T23:00:00.000Z	defillama-api	5.157305126957112	\N	87961594	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-08T23:00:00.000Z	defillama-api	5.149915495650248	\N	89275152	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-09T23:00:00.000Z	defillama-api	5.149915495650248	\N	86645789	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-10T23:00:00.000Z	defillama-api	5.155538421774963	\N	83648927	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-11T23:00:00.000Z	defillama-api	5.155538421774963	\N	89306831	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-12T23:00:00.000Z	defillama-api	5.15154005213958	\N	88811052	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-13T23:00:00.000Z	defillama-api	5.15154005213958	\N	92034861	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-14T23:00:00.000Z	defillama-api	5.132599264001669	\N	93970360	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-15T23:00:00.000Z	defillama-api	5.132599264001669	\N	97696832	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-16T23:00:00.000Z	defillama-api	5.142041298356048	\N	98441569	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-17T23:00:00.000Z	defillama-api	5.142041298356048	\N	96180304	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-18T23:00:00.000Z	defillama-api	5.138432262086212	\N	93097945	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-19T23:00:00.000Z	defillama-api	5.138432262086212	\N	92838012	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-20T23:00:00.000Z	defillama-api	5.147987735298898	\N	98652529	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-21T23:00:00.000Z	defillama-api	5.147987735298898	\N	97910883	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-22T23:00:00.000Z	defillama-api	5.141633058514117	\N	96423373	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-23T23:00:00.000Z	defillama-api	5.141633058514117	\N	92997358	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-24T23:00:00.000Z	defillama-api	5.143998468781774	\N	90841580	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-25T23:00:00.000Z	defillama-api	5.143998468781774	\N	90030788	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-26T23:00:00.000Z	defillama-api	5.13778594068981	\N	96342748	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-27T23:00:00.000Z	defillama-api	5.13778594068981	\N	95223943	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-28T23:00:00.000Z	defillama-api	5.143903236159986	\N	94126031	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-29T23:00:00.000Z	defillama-api	5.143903236159986	\N	101008573	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-06-30T23:00:00.000Z	defillama-api	5.147940118988004	\N	98348934	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-01T23:00:00.000Z	defillama-api	5.42385353270447	\N	11198190	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-02T23:00:00.000Z	defillama-api	5.416388975731934	\N	10341740	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-03T23:00:00.000Z	defillama-api	5.416388975731934	\N	9962041	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-04T23:00:00.000Z	defillama-api	5.398607084572404	\N	9428268	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-05T23:00:00.000Z	defillama-api	5.398607084572404	\N	8838840	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-06T23:00:00.000Z	defillama-api	5.397024542475037	\N	8746552	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-07T23:00:00.000Z	defillama-api	5.397024542475037	\N	9183977	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-08T23:00:00.000Z	defillama-api	5.398862672123528	\N	9274245	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-09T23:00:00.000Z	defillama-api	5.398862672123528	\N	8994223	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-10T23:00:00.000Z	defillama-api	5.397214307478748	\N	8690854	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-11T23:00:00.000Z	defillama-api	5.397214307478748	\N	9272849	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-12T23:00:00.000Z	defillama-api	5.39858817809602	\N	9215037	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-13T23:00:00.000Z	defillama-api	5.39858817809602	\N	9586295	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-14T23:00:00.000Z	defillama-api	5.3980195833247535	\N	9772499	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-15T23:00:00.000Z	defillama-api	5.3980195833247535	\N	10189423	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-16T23:00:00.000Z	defillama-api	5.417866481849387	\N	10238242	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-17T23:00:00.000Z	defillama-api	5.417866481849387	\N	9934001	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-18T23:00:00.000Z	defillama-api	5.419884573143463	\N	9609937	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-19T23:00:00.000Z	defillama-api	5.419884573143463	\N	9586796	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-20T23:00:00.000Z	defillama-api	5.421513331071992	\N	10196722	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-21T23:00:00.000Z	defillama-api	5.421513331071992	\N	10113641	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-22T23:00:00.000Z	defillama-api	5.421987393461336	\N	9948188	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-23T23:00:00.000Z	defillama-api	5.421987393461336	\N	9595924	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-24T23:00:00.000Z	defillama-api	5.420244496434634	\N	9357473	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-25T23:00:00.000Z	defillama-api	5.420244496434634	\N	9290114	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-26T23:00:00.000Z	defillama-api	5.419259258943043	\N	9920963	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-27T23:00:00.000Z	defillama-api	5.419259258943043	\N	9811243	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-28T23:00:00.000Z	defillama-api	5.4138316997409675	\N	9702829	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-29T23:00:00.000Z	defillama-api	5.4138316997409675	\N	10417276	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-06-30T23:00:00.000Z	defillama-api	5.405201243391389	\N	10136615	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-01T23:00:00.000Z	defillama-api	5.815513095086544	\N	15031079	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-02T23:00:00.000Z	defillama-api	5.815078946369567	\N	13809697	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-03T23:00:00.000Z	defillama-api	5.815078946369567	\N	13327437	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-04T23:00:00.000Z	defillama-api	5.814144826388201	\N	12763324	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-05T23:00:00.000Z	defillama-api	5.814144826388201	\N	11659735	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-06T23:00:00.000Z	defillama-api	5.827758889864754	\N	11782972	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-07T23:00:00.000Z	defillama-api	5.827758889864754	\N	12121363	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-08T23:00:00.000Z	defillama-api	5.851548138835483	\N	12260035	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-09T23:00:00.000Z	defillama-api	5.851548138835483	\N	11842911	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-10T23:00:00.000Z	defillama-api	5.858348168175098	\N	11370291	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-11T23:00:00.000Z	defillama-api	5.858348168175098	\N	12079441	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-12T23:00:00.000Z	defillama-api	5.885326309496008	\N	12001436	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-13T23:00:00.000Z	defillama-api	5.885326309496008	\N	12452299	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-14T23:00:00.000Z	defillama-api	5.900269428238403	\N	12762959	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-15T23:00:00.000Z	defillama-api	5.900269428238403	\N	13280896	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-16T23:00:00.000Z	defillama-api	5.906613601425192	\N	13345737	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-17T23:00:00.000Z	defillama-api	5.906613601425192	\N	13013076	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-18T23:00:00.000Z	defillama-api	5.908037189072957	\N	12564840	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-19T23:00:00.000Z	defillama-api	5.908037189072957	\N	12558569	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-20T23:00:00.000Z	defillama-api	5.869900725485877	\N	13323954	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-21T23:00:00.000Z	defillama-api	5.869900725485877	\N	13246296	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-22T23:00:00.000Z	defillama-api	5.854839966445979	\N	13101820	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-23T23:00:00.000Z	defillama-api	5.854839966445979	\N	12717075	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-24T23:00:00.000Z	defillama-api	5.842946392320414	\N	12491302	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-25T23:00:00.000Z	defillama-api	5.842946392320414	\N	12371264	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-26T23:00:00.000Z	defillama-api	5.824192568226749	\N	13224996	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-27T23:00:00.000Z	defillama-api	5.824192568226749	\N	13082538	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-28T23:00:00.000Z	defillama-api	5.858187813245763	\N	12914719	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-29T23:00:00.000Z	defillama-api	5.858187813245763	\N	13910173	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-06-30T23:00:00.000Z	defillama-api	5.852576090958905	\N	13535972	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-01T23:00:00.000Z	defillama-api	4.9513904912146245	\N	420444927	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-02T23:00:00.000Z	defillama-api	4.930441415140763	\N	388525078	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-03T23:00:00.000Z	defillama-api	4.930441415140763	\N	375202819	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-04T23:00:00.000Z	defillama-api	4.918779620410874	\N	360421362	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-05T23:00:00.000Z	defillama-api	4.918779620410874	\N	326215994	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-06T23:00:00.000Z	defillama-api	4.910754171305598	\N	341108585	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-07T23:00:00.000Z	defillama-api	4.910754171305598	\N	345298592	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-08T23:00:00.000Z	defillama-api	4.9116679843308475	\N	348976938	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-09T23:00:00.000Z	defillama-api	4.9116679843308475	\N	338732062	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-10T23:00:00.000Z	defillama-api	4.9100210201658	\N	326344014	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-11T23:00:00.000Z	defillama-api	4.9100210201658	\N	349137958	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-12T23:00:00.000Z	defillama-api	4.918951179178066	\N	347177300	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-13T23:00:00.000Z	defillama-api	4.918951179178066	\N	360158691	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-14T23:00:00.000Z	defillama-api	4.918304157541797	\N	368366841	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-15T23:00:00.000Z	defillama-api	4.918304157541797	\N	380972617	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-16T23:00:00.000Z	defillama-api	4.918846843438018	\N	384566809	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-17T23:00:00.000Z	defillama-api	4.918846843438018	\N	374703619	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-18T23:00:00.000Z	defillama-api	4.946146394857465	\N	363067859	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-19T23:00:00.000Z	defillama-api	4.946146394857465	\N	361614543	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-20T23:00:00.000Z	defillama-api	4.937922777870085	\N	384062563	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-21T23:00:00.000Z	defillama-api	4.937922777870085	\N	380928845	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-22T23:00:00.000Z	defillama-api	4.956129714628332	\N	375394307	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-23T23:00:00.000Z	defillama-api	4.956129714628332	\N	362661725	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-24T23:00:00.000Z	defillama-api	4.951409397691009	\N	353737594	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-25T23:00:00.000Z	defillama-api	4.951409397691009	\N	351057457	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-26T23:00:00.000Z	defillama-api	4.948763191237049	\N	375576489	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-27T23:00:00.000Z	defillama-api	4.948763191237049	\N	371083420	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-28T23:00:00.000Z	defillama-api	4.9536459638233055	\N	367526249	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-29T23:00:00.000Z	defillama-api	4.9536459638233055	\N	394537075	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-06-30T23:00:00.000Z	defillama-api	4.958489522977061	\N	383376346	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-01T23:00:00.000Z	defillama-api	5.435162406541849	\N	4141433	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-02T23:00:00.000Z	defillama-api	5.3995257992767165	\N	3812593	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-03T23:00:00.000Z	defillama-api	5.3995257992767165	\N	3666660	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-04T23:00:00.000Z	defillama-api	5.388952177298734	\N	3470197	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-05T23:00:00.000Z	defillama-api	5.388952177298734	\N	3292857	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-06T23:00:00.000Z	defillama-api	5.380793682618901	\N	3148184	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-07T23:00:00.000Z	defillama-api	5.380793682618901	\N	3377724	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-08T23:00:00.000Z	defillama-api	5.344531060913482	\N	3395481	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-09T23:00:00.000Z	defillama-api	5.344531060913482	\N	3306337	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-10T23:00:00.000Z	defillama-api	5.348721296272174	\N	3198350	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-11T23:00:00.000Z	defillama-api	5.348721296272174	\N	3425750	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-12T23:00:00.000Z	defillama-api	5.344332192791512	\N	3405992	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-13T23:00:00.000Z	defillama-api	5.344332192791512	\N	3473152	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-14T23:00:00.000Z	defillama-api	5.305704861058302	\N	3555964	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-15T23:00:00.000Z	defillama-api	5.305704861058302	\N	3769129	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-16T23:00:00.000Z	defillama-api	5.30293541238791	\N	3570973	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-17T23:00:00.000Z	defillama-api	5.30293541238791	\N	3485166	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-18T23:00:00.000Z	defillama-api	5.303097167796977	\N	3262530	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-19T23:00:00.000Z	defillama-api	5.303097167796977	\N	3222329	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-20T23:00:00.000Z	defillama-api	5.308379077106906	\N	3442105	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-21T23:00:00.000Z	defillama-api	5.308379077106906	\N	3426660	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-22T23:00:00.000Z	defillama-api	5.290264572010983	\N	3404576	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-23T23:00:00.000Z	defillama-api	5.290264572010983	\N	3260552	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-24T23:00:00.000Z	defillama-api	5.2862150848653755	\N	3182214	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-25T23:00:00.000Z	defillama-api	5.2862150848653755	\N	3139277	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-26T23:00:00.000Z	defillama-api	5.275979678742715	\N	3402662	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-27T23:00:00.000Z	defillama-api	5.275979678742715	\N	3338602	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-28T23:00:00.000Z	defillama-api	5.268855438345099	\N	3319621	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-29T23:00:00.000Z	defillama-api	5.268855438345099	\N	3524320	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-06-30T23:00:00.000Z	defillama-api	5.2551937585576525	\N	3436123	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-01T23:00:00.000Z	defillama-api	5.8029914058010945	\N	7520922	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-02T23:00:00.000Z	defillama-api	5.800443933168253	\N	6834303	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-03T23:00:00.000Z	defillama-api	5.792195807785561	\N	6660882	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-04T23:00:00.000Z	defillama-api	5.715574161158088	\N	6338548	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-05T23:00:00.000Z	defillama-api	5.632220408458011	\N	5978994	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-06T23:00:00.000Z	defillama-api	5.548333072979972	\N	5739102	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-07T23:00:00.000Z	defillama-api	5.514507286008552	\N	6113440	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-08T23:00:00.000Z	defillama-api	5.496401884030888	\N	6683352	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-09T23:00:00.000Z	defillama-api	5.462690936397507	\N	6475475	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-10T23:00:00.000Z	defillama-api	5.440598368622318	\N	6229315	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-11T23:00:00.000Z	defillama-api	5.3969489165694995	\N	6655423	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-12T23:00:00.000Z	defillama-api	5.487428310146925	\N	6627191	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-13T23:00:00.000Z	defillama-api	5.4843612595334434	\N	6849105	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-14T23:00:00.000Z	defillama-api	5.516579996012183	\N	7004337	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-15T23:00:00.000Z	defillama-api	5.541626175542547	\N	7358216	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-16T23:00:00.000Z	defillama-api	5.54185305325916	\N	7360545	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-17T23:00:00.000Z	defillama-api	5.557887845952791	\N	7220047	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-18T23:00:00.000Z	defillama-api	5.5331294650073914	\N	6990873	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-19T23:00:00.000Z	defillama-api	5.574033976785131	\N	6977839	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-20T23:00:00.000Z	defillama-api	5.577296394321252	\N	7378654	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-21T23:00:00.000Z	defillama-api	5.616878152991944	\N	7332963	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-22T23:00:00.000Z	defillama-api	5.6177667573820145	\N	7223725	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-23T23:00:00.000Z	defillama-api	5.671619404523653	\N	6985087	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-24T23:00:00.000Z	defillama-api	5.597996885242651	\N	6814215	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-25T23:00:00.000Z	defillama-api	5.5743742933600515	\N	6857386	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-26T23:00:00.000Z	defillama-api	5.509927017044447	\N	7342546	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-27T23:00:00.000Z	defillama-api	5.5312563233655965	\N	7255842	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-28T23:00:00.000Z	defillama-api	5.49866435903823	\N	7170755	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-29T23:00:00.000Z	defillama-api	5.504863582572739	\N	7721915	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-06-30T23:00:00.000Z	defillama-api	5.473114707044147	\N	7353014	\N	\N
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
