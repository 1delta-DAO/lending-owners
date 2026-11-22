-- Generated from VAULT_LLAMA_LST/solana/2026-05.ndjson (526 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-01T23:00:00.000Z	defillama-api	5.797924470130056	\N	423002697	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-02T23:00:00.000Z	defillama-api	5.797924470130056	\N	427508170	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-03T23:00:00.000Z	defillama-api	5.797924470130056	\N	428614180	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-04T23:00:00.000Z	defillama-api	6.017482579423472	\N	426254015	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-05T23:00:00.000Z	defillama-api	6.023339385663462	\N	439021835	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-06T23:00:00.000Z	defillama-api	6.023339385663462	\N	451819510	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-07T23:00:00.000Z	defillama-api	6.002905686131044	\N	446431233	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-08T23:00:00.000Z	defillama-api	6.002905686131044	\N	468233399	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-09T23:00:00.000Z	defillama-api	5.990106701858622	\N	473652418	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-10T23:00:00.000Z	defillama-api	5.990106701858622	\N	488546084	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-11T23:00:00.000Z	defillama-api	5.992885253647273	\N	497034451	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-12T23:00:00.000Z	defillama-api	5.992885253647273	\N	481212064	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-13T23:00:00.000Z	defillama-api	5.9670660093047445	\N	467049692	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-14T23:00:00.000Z	defillama-api	5.9670660093047445	\N	475401250	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-15T23:00:00.000Z	defillama-api	6.0147334377091966	\N	457198400	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-16T23:00:00.000Z	defillama-api	6.0147334377091966	\N	444188102	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-17T23:00:00.000Z	defillama-api	5.960113327674321	\N	443364521	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-18T23:00:00.000Z	defillama-api	5.960113327674321	\N	442290187	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-19T23:00:00.000Z	defillama-api	5.94807200293701	\N	435577487	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-20T23:00:00.000Z	defillama-api	5.94807200293701	\N	445635879	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-21T23:00:00.000Z	defillama-api	5.894669610029268	\N	451038229	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-22T23:00:00.000Z	defillama-api	5.894669610029268	\N	439622204	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-23T23:00:00.000Z	defillama-api	5.8732765818803045	\N	443328285	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-24T23:00:00.000Z	defillama-api	5.8732765818803045	\N	440591424	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-25T23:00:00.000Z	defillama-api	5.858093280863841	\N	440357504	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-26T23:00:00.000Z	defillama-api	5.858093280863841	\N	437561831	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-27T23:00:00.000Z	defillama-api	5.836163868977451	\N	430588420	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-28T23:00:00.000Z	defillama-api	5.836163868977451	\N	429476021	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-29T23:00:00.000Z	defillama-api	5.792989179553842	\N	431888872	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-30T23:00:00.000Z	defillama-api	5.792989179553842	\N	436313844	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-05-31T23:00:00.000Z	defillama-api	5.750352274347392	\N	434837173	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-01T23:00:00.000Z	defillama-api	6.845197611937692	\N	267297032	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-02T23:00:00.000Z	defillama-api	5.176649253257892	\N	269587190	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-03T23:00:00.000Z	defillama-api	6.814217599782069	\N	270076734	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-04T23:00:00.000Z	defillama-api	5.033763207862307	\N	268810193	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-05T23:00:00.000Z	defillama-api	6.660164129002055	\N	276198176	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-06T23:00:00.000Z	defillama-api	4.972772315525731	\N	284325142	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-07T23:00:00.000Z	defillama-api	6.659471591774491	\N	280694267	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-08T23:00:00.000Z	defillama-api	4.949201541393222	\N	294293115	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-09T23:00:00.000Z	defillama-api	6.6405055950014	\N	297048033	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-10T23:00:00.000Z	defillama-api	5.0045092869765995	\N	303457779	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-11T23:00:00.000Z	defillama-api	6.650536531083162	\N	308224619	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-12T23:00:00.000Z	defillama-api	5.0249478881880805	\N	299156305	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-13T23:00:00.000Z	defillama-api	6.641385796513077	\N	288106561	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-14T23:00:00.000Z	defillama-api	4.954664112588603	\N	292983117	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-15T23:00:00.000Z	defillama-api	6.589428698688948	\N	281980156	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-16T23:00:00.000Z	defillama-api	4.901394765255418	\N	274152237	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-17T23:00:00.000Z	defillama-api	6.554904072331169	\N	272523610	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-18T23:00:00.000Z	defillama-api	4.903185278593014	\N	269800533	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-19T23:00:00.000Z	defillama-api	6.580234549247166	\N	265489638	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-20T23:00:00.000Z	defillama-api	4.966273389328535	\N	271721862	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-21T23:00:00.000Z	defillama-api	6.635742563432245	\N	274613175	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-22T23:00:00.000Z	defillama-api	4.997869612566319	\N	267503001	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-23T23:00:00.000Z	defillama-api	6.683709694499385	\N	269729039	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-24T23:00:00.000Z	defillama-api	5.030292118846091	\N	267347733	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-25T23:00:00.000Z	defillama-api	6.712803960695624	\N	267052936	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-26T23:00:00.000Z	defillama-api	5.038384790978512	\N	262727400	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-27T23:00:00.000Z	defillama-api	6.713028737692639	\N	259024956	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-28T23:00:00.000Z	defillama-api	5.04355746286933	\N	258053624	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-29T23:00:00.000Z	defillama-api	6.75822922104885	\N	247044725	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-30T23:00:00.000Z	defillama-api	5.0756893696046745	\N	249310887	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-05-31T23:00:00.000Z	defillama-api	6.6985428755828025	\N	248515790	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-01T23:00:00.000Z	defillama-api	5.363555177595458	\N	100984239	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-02T23:00:00.000Z	defillama-api	5.363555177595458	\N	102471563	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-03T23:00:00.000Z	defillama-api	5.344597583700761	\N	103699110	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-04T23:00:00.000Z	defillama-api	5.344597583700761	\N	104103775	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-05T23:00:00.000Z	defillama-api	5.297188543806897	\N	107741704	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-06T23:00:00.000Z	defillama-api	5.297188543806897	\N	111834880	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-07T23:00:00.000Z	defillama-api	5.373032223943142	\N	111834374	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-08T23:00:00.000Z	defillama-api	5.373032223943142	\N	118401893	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-09T23:00:00.000Z	defillama-api	5.401459161546995	\N	119837476	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-10T23:00:00.000Z	defillama-api	5.401459161546995	\N	123628630	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-11T23:00:00.000Z	defillama-api	5.354076730768043	\N	126395079	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-12T23:00:00.000Z	defillama-api	5.354076730768043	\N	123412269	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-13T23:00:00.000Z	defillama-api	5.344597583700761	\N	119734160	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-14T23:00:00.000Z	defillama-api	5.344597583700761	\N	122555650	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-15T23:00:00.000Z	defillama-api	5.448818484410367	\N	118361535	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-16T23:00:00.000Z	defillama-api	5.448818484410367	\N	114707936	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-17T23:00:00.000Z	defillama-api	5.211795692616761	\N	114156297	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-18T23:00:00.000Z	defillama-api	5.211795692616761	\N	112921848	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-19T23:00:00.000Z	defillama-api	5.27821834559461	\N	111322164	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-20T23:00:00.000Z	defillama-api	5.27821834559461	\N	113877038	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-21T23:00:00.000Z	defillama-api	5.325636488606733	\N	115724149	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-22T23:00:00.000Z	defillama-api	5.325636488606733	\N	114547655	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-23T23:00:00.000Z	defillama-api	5.2497570962373175	\N	119551712	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-24T23:00:00.000Z	defillama-api	5.2497570962373175	\N	118970330	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-25T23:00:00.000Z	defillama-api	5.107326906994558	\N	119257761	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-26T23:00:00.000Z	defillama-api	5.107326906994558	\N	117713286	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-27T23:00:00.000Z	defillama-api	5.183314836543218	\N	116428785	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-28T23:00:00.000Z	defillama-api	5.183314836543218	\N	115788091	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-29T23:00:00.000Z	defillama-api	5.183314836543218	\N	115882871	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-30T23:00:00.000Z	defillama-api	5.183314836543218	\N	114155044	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-05-31T23:00:00.000Z	defillama-api	5.27821834559461	\N	114133472	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-01T23:00:00.000Z	defillama-api	5.577381823584915	\N	54005852	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-02T23:00:00.000Z	defillama-api	5.577381823584915	\N	54733156	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-03T23:00:00.000Z	defillama-api	5.577381823584915	\N	55002624	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-04T23:00:00.000Z	defillama-api	5.758433742641955	\N	54673985	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-05T23:00:00.000Z	defillama-api	5.688635233269679	\N	56201518	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-06T23:00:00.000Z	defillama-api	5.688635233269679	\N	57877578	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-07T23:00:00.000Z	defillama-api	5.683911415133025	\N	57118911	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-08T23:00:00.000Z	defillama-api	5.683911415133025	\N	59941539	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-09T23:00:00.000Z	defillama-api	5.685318897263869	\N	60580966	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-10T23:00:00.000Z	defillama-api	5.685318897263869	\N	62385955	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-11T23:00:00.000Z	defillama-api	5.686036643126613	\N	63219501	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-12T23:00:00.000Z	defillama-api	5.686036643126613	\N	61321358	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-13T23:00:00.000Z	defillama-api	5.679782800882549	\N	58239812	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-14T23:00:00.000Z	defillama-api	5.679782800882549	\N	60814100	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-15T23:00:00.000Z	defillama-api	5.691345861791319	\N	79041381	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-16T23:00:00.000Z	defillama-api	5.691345861791319	\N	76743881	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-17T23:00:00.000Z	defillama-api	5.672649457366674	\N	76350840	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-18T23:00:00.000Z	defillama-api	5.672649457366674	\N	75588052	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-19T23:00:00.000Z	defillama-api	5.529155603767322	\N	72783063	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-20T23:00:00.000Z	defillama-api	5.529155603767322	\N	74497707	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-21T23:00:00.000Z	defillama-api	5.485592281218032	\N	74959797	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-22T23:00:00.000Z	defillama-api	5.485592281218032	\N	72963871	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-23T23:00:00.000Z	defillama-api	5.483017499230414	\N	73502300	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-24T23:00:00.000Z	defillama-api	5.483017499230414	\N	73042696	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-25T23:00:00.000Z	defillama-api	5.4908454806934515	\N	72888968	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-26T23:00:00.000Z	defillama-api	5.4908454806934515	\N	71763858	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-27T23:00:00.000Z	defillama-api	5.481625422376624	\N	70811254	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-28T23:00:00.000Z	defillama-api	5.481625422376624	\N	70483278	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-29T23:00:00.000Z	defillama-api	5.494262651239978	\N	70025331	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-30T23:00:00.000Z	defillama-api	5.494262651239978	\N	71122231	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-05-31T23:00:00.000Z	defillama-api	5.4855544682652635	\N	70370182	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-01T23:00:00.000Z	defillama-api	5.862516696097941	\N	233050809	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-02T23:00:00.000Z	defillama-api	5.862516696097941	\N	235232093	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-03T23:00:00.000Z	defillama-api	5.862516696097941	\N	235994706	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-04T23:00:00.000Z	defillama-api	5.945320760503137	\N	234676887	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-05T23:00:00.000Z	defillama-api	6.281863742785276	\N	241398004	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-06T23:00:00.000Z	defillama-api	6.281863742785276	\N	248273790	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-07T23:00:00.000Z	defillama-api	6.276238015701097	\N	245204477	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-08T23:00:00.000Z	defillama-api	6.276238015701097	\N	257228367	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-09T23:00:00.000Z	defillama-api	6.2689688256512	\N	260035631	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-10T23:00:00.000Z	defillama-api	6.2689688256512	\N	268167442	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-11T23:00:00.000Z	defillama-api	6.280464663532825	\N	272219700	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-12T23:00:00.000Z	defillama-api	6.280464663532825	\N	263579022	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-13T23:00:00.000Z	defillama-api	6.27823860099852	\N	254270677	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-14T23:00:00.000Z	defillama-api	6.27823860099852	\N	258861713	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-15T23:00:00.000Z	defillama-api	6.300925672420021	\N	248790867	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-16T23:00:00.000Z	defillama-api	6.300925672420021	\N	241403274	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-17T23:00:00.000Z	defillama-api	6.2958272259550085	\N	240408411	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-18T23:00:00.000Z	defillama-api	6.2958272259550085	\N	238034934	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-19T23:00:00.000Z	defillama-api	6.298315878439098	\N	234680145	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-20T23:00:00.000Z	defillama-api	6.298315878439098	\N	239654729	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-21T23:00:00.000Z	defillama-api	6.283366457537909	\N	243099036	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-22T23:00:00.000Z	defillama-api	6.283366457537909	\N	236879180	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-23T23:00:00.000Z	defillama-api	6.266414350619698	\N	238821511	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-24T23:00:00.000Z	defillama-api	6.266414350619698	\N	237447886	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-25T23:00:00.000Z	defillama-api	5.929894476253139	\N	236937171	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-26T23:00:00.000Z	defillama-api	5.929894476253139	\N	233340907	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-27T23:00:00.000Z	defillama-api	5.912768709848137	\N	229506264	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-28T23:00:00.000Z	defillama-api	5.912768709848137	\N	229573235	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-29T23:00:00.000Z	defillama-api	5.9013533995511125	\N	228084838	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-30T23:00:00.000Z	defillama-api	5.9013533995511125	\N	231915742	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-05-31T23:00:00.000Z	defillama-api	5.884261244659683	\N	229254831	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-01T23:00:00.000Z	defillama-api	5.702794783601917	\N	62116827	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-02T23:00:00.000Z	defillama-api	5.702794783601917	\N	62581101	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-03T23:00:00.000Z	defillama-api	5.702794783601917	\N	62694141	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-04T23:00:00.000Z	defillama-api	5.741939592596168	\N	62366128	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-05T23:00:00.000Z	defillama-api	5.745480005359127	\N	64024436	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-06T23:00:00.000Z	defillama-api	5.745480005359127	\N	66007285	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-07T23:00:00.000Z	defillama-api	5.739021693074164	\N	65321663	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-08T23:00:00.000Z	defillama-api	5.739021693074164	\N	68327468	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-09T23:00:00.000Z	defillama-api	5.783777524115408	\N	69118260	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-10T23:00:00.000Z	defillama-api	5.783777524115408	\N	71211772	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-11T23:00:00.000Z	defillama-api	5.78601479048757	\N	80789877	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-12T23:00:00.000Z	defillama-api	5.78601479048757	\N	77800891	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-13T23:00:00.000Z	defillama-api	5.785608651365237	\N	75183362	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-14T23:00:00.000Z	defillama-api	5.785608651365237	\N	76458455	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-15T23:00:00.000Z	defillama-api	5.734546460089973	\N	73537246	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-16T23:00:00.000Z	defillama-api	5.734546460089973	\N	71289187	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-17T23:00:00.000Z	defillama-api	5.728550306116631	\N	71083402	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-18T23:00:00.000Z	defillama-api	5.728550306116631	\N	70408448	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-19T23:00:00.000Z	defillama-api	5.725717135618424	\N	69347768	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-20T23:00:00.000Z	defillama-api	5.725717135618424	\N	70937816	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-21T23:00:00.000Z	defillama-api	5.703635771681093	\N	71940870	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-22T23:00:00.000Z	defillama-api	5.703635771681093	\N	70055859	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-23T23:00:00.000Z	defillama-api	5.692961315162393	\N	70759117	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-24T23:00:00.000Z	defillama-api	5.692961315162393	\N	70033886	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-25T23:00:00.000Z	defillama-api	5.680887779391242	\N	69982752	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-26T23:00:00.000Z	defillama-api	5.680887779391242	\N	68791643	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-27T23:00:00.000Z	defillama-api	5.671695030429191	\N	67810085	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-28T23:00:00.000Z	defillama-api	5.671695030429191	\N	67792833	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-29T23:00:00.000Z	defillama-api	5.659307086958165	\N	67374806	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-30T23:00:00.000Z	defillama-api	5.659307086958165	\N	67735678	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-05-31T23:00:00.000Z	defillama-api	5.6481459637325315	\N	67973907	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-01T23:00:00.000Z	defillama-api	6.014262176279317	\N	122087337	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-02T23:00:00.000Z	defillama-api	6.014262176279317	\N	123432005	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-03T23:00:00.000Z	defillama-api	6.014262176279317	\N	123784570	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-04T23:00:00.000Z	defillama-api	6.13919477174818	\N	123358542	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-05T23:00:00.000Z	defillama-api	6.136044392590634	\N	126681487	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-06T23:00:00.000Z	defillama-api	6.136044392590634	\N	130765598	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-07T23:00:00.000Z	defillama-api	6.127119135257431	\N	128838654	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-08T23:00:00.000Z	defillama-api	6.127119135257431	\N	135624365	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-09T23:00:00.000Z	defillama-api	6.108766548607036	\N	138234683	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-10T23:00:00.000Z	defillama-api	6.108766548607036	\N	142574920	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-11T23:00:00.000Z	defillama-api	6.110253157842749	\N	145705628	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-12T23:00:00.000Z	defillama-api	6.110253157842749	\N	140971848	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-13T23:00:00.000Z	defillama-api	6.1074213878242745	\N	135883276	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-14T23:00:00.000Z	defillama-api	6.1074213878242745	\N	138284130	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-15T23:00:00.000Z	defillama-api	6.110789541580175	\N	133535650	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-16T23:00:00.000Z	defillama-api	6.110789541580175	\N	129648733	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-17T23:00:00.000Z	defillama-api	6.034825420186962	\N	129101575	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-18T23:00:00.000Z	defillama-api	6.034825420186962	\N	127966451	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-19T23:00:00.000Z	defillama-api	6.012125044208005	\N	126023780	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-20T23:00:00.000Z	defillama-api	6.012125044208005	\N	129301500	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-21T23:00:00.000Z	defillama-api	5.974423429577769	\N	131115074	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-22T23:00:00.000Z	defillama-api	5.974423429577769	\N	128109519	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-23T23:00:00.000Z	defillama-api	5.94733745131748	\N	129169356	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-24T23:00:00.000Z	defillama-api	5.94733745131748	\N	128206307	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-25T23:00:00.000Z	defillama-api	5.919677976606863	\N	127907076	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-26T23:00:00.000Z	defillama-api	5.919677976606863	\N	125904074	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-27T23:00:00.000Z	defillama-api	5.893566732240174	\N	124334607	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-28T23:00:00.000Z	defillama-api	5.893566732240174	\N	123782707	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-29T23:00:00.000Z	defillama-api	5.886005542166117	\N	122991789	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-30T23:00:00.000Z	defillama-api	5.886005542166117	\N	124488468	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-05-31T23:00:00.000Z	defillama-api	5.858932868463285	\N	123704643	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-01T23:00:00.000Z	defillama-api	5.218135664364354	\N	105626793	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-02T23:00:00.000Z	defillama-api	5.218135664364354	\N	106524120	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-03T23:00:00.000Z	defillama-api	5.218135664364354	\N	106732261	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-04T23:00:00.000Z	defillama-api	5.228880144869663	\N	106598865	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-05T23:00:00.000Z	defillama-api	5.227665228701994	\N	110084603	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-06T23:00:00.000Z	defillama-api	5.227665228701994	\N	113144628	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-07T23:00:00.000Z	defillama-api	5.22969592431366	\N	111982286	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-08T23:00:00.000Z	defillama-api	5.22969592431366	\N	117302853	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-09T23:00:00.000Z	defillama-api	5.231129315319549	\N	118732431	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-10T23:00:00.000Z	defillama-api	5.231129315319549	\N	122793018	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-11T23:00:00.000Z	defillama-api	5.2295250657863335	\N	125098689	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-12T23:00:00.000Z	defillama-api	5.2295250657863335	\N	121017489	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-13T23:00:00.000Z	defillama-api	5.239888615804489	\N	116924642	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-14T23:00:00.000Z	defillama-api	5.239888615804489	\N	118747492	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-15T23:00:00.000Z	defillama-api	5.2433807120166875	\N	114524951	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-16T23:00:00.000Z	defillama-api	5.2433807120166875	\N	111015192	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-17T23:00:00.000Z	defillama-api	5.243996923098848	\N	110600115	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-18T23:00:00.000Z	defillama-api	5.243996923098848	\N	109607563	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-19T23:00:00.000Z	defillama-api	5.243114620867573	\N	107994920	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-20T23:00:00.000Z	defillama-api	5.243114620867573	\N	110375111	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-21T23:00:00.000Z	defillama-api	5.265857711478361	\N	112361244	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-22T23:00:00.000Z	defillama-api	5.265857711478361	\N	109342858	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-23T23:00:00.000Z	defillama-api	5.264263965543137	\N	110433030	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-24T23:00:00.000Z	defillama-api	5.264263965543137	\N	109500823	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-25T23:00:00.000Z	defillama-api	5.271577970944463	\N	109304211	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-26T23:00:00.000Z	defillama-api	5.271577970944463	\N	107663077	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-27T23:00:00.000Z	defillama-api	5.264700214979712	\N	106246188	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-28T23:00:00.000Z	defillama-api	5.264700214979712	\N	105708932	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-29T23:00:00.000Z	defillama-api	5.251104357739678	\N	105606450	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-30T23:00:00.000Z	defillama-api	5.251104357739678	\N	106462913	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-05-31T23:00:00.000Z	defillama-api	5.240333968359323	\N	106373902	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-01T23:00:00.000Z	defillama-api	5.22694398163992	\N	884421915	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-02T23:00:00.000Z	defillama-api	5.22694398163992	\N	893227249	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-03T23:00:00.000Z	defillama-api	5.156079707191452	\N	896196037	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-04T23:00:00.000Z	defillama-api	5.156079707191452	\N	892856669	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-05T23:00:00.000Z	defillama-api	5.0957526422479305	\N	918366090	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-06T23:00:00.000Z	defillama-api	5.0957526422479305	\N	950116775	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-07T23:00:00.000Z	defillama-api	4.83418714338768	\N	975947078	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-08T23:00:00.000Z	defillama-api	4.83418714338768	\N	1022793414	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-09T23:00:00.000Z	defillama-api	5.041931505900266	\N	1037680739	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-10T23:00:00.000Z	defillama-api	5.041931505900266	\N	1071142709	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-11T23:00:00.000Z	defillama-api	4.956196237415611	\N	1088562606	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-12T23:00:00.000Z	defillama-api	4.956196237415611	\N	1067500468	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-13T23:00:00.000Z	defillama-api	4.9575000840462735	\N	1025372506	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-14T23:00:00.000Z	defillama-api	4.9575000840462735	\N	1023351330	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-15T23:00:00.000Z	defillama-api	5.081639307746855	\N	986131892	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-16T23:00:00.000Z	defillama-api	5.081639307746855	\N	954923076	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-17T23:00:00.000Z	defillama-api	5.033839534007711	\N	951904941	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-18T23:00:00.000Z	defillama-api	5.033839534007711	\N	943362358	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-19T23:00:00.000Z	defillama-api	5.01328819417779	\N	923208163	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-20T23:00:00.000Z	defillama-api	5.01328819417779	\N	949067699	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-21T23:00:00.000Z	defillama-api	4.997355636504608	\N	961438366	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-22T23:00:00.000Z	defillama-api	4.997355636504608	\N	936818456	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-23T23:00:00.000Z	defillama-api	5.046314307222133	\N	947860635	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-24T23:00:00.000Z	defillama-api	5.046314307222133	\N	939787405	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-25T23:00:00.000Z	defillama-api	4.946460102317474	\N	949042056	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-26T23:00:00.000Z	defillama-api	4.946460102317474	\N	936007035	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-27T23:00:00.000Z	defillama-api	4.975940900919795	\N	929750134	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-28T23:00:00.000Z	defillama-api	4.975940900919795	\N	924271242	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-29T23:00:00.000Z	defillama-api	4.974085265274653	\N	924577958	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-30T23:00:00.000Z	defillama-api	4.974085265274653	\N	929618450	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-05-31T23:00:00.000Z	defillama-api	5.074558482220937	\N	930260484	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-01T23:00:00.000Z	defillama-api	5.328215472033548	\N	63709067	1.09312	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-02T23:00:00.000Z	defillama-api	5.328225275391674	\N	64253574	1.09312	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-03T23:00:00.000Z	defillama-api	5.295927411808066	\N	64437475	1.09343	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-04T23:00:00.000Z	defillama-api	5.29591760844994	\N	64052748	1.09343	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-05T23:00:00.000Z	defillama-api	5.048538969276706	\N	65929096	1.09373	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-06T23:00:00.000Z	defillama-api	5.048538969276706	\N	67806947	1.09373	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-07T23:00:00.000Z	defillama-api	5.242659464954613	\N	67031354	1.09404	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-08T23:00:00.000Z	defillama-api	5.242659464954613	\N	70264023	1.09404	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-09T23:00:00.000Z	defillama-api	5.21418771199933	\N	71079032	1.09436	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-10T23:00:00.000Z	defillama-api	5.21418771199933	\N	73289158	1.09436	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-11T23:00:00.000Z	defillama-api	4.944652082983225	\N	74327873	1.09465	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-12T23:00:00.000Z	defillama-api	4.9446618863413505	\N	72104906	1.09465	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-13T23:00:00.000Z	defillama-api	5.206545994340672	\N	69469130	1.09497	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-14T23:00:00.000Z	defillama-api	5.206545994340672	\N	70575218	1.09497	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-15T23:00:00.000Z	defillama-api	5.23429860095348	\N	68025821	1.09528	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-16T23:00:00.000Z	defillama-api	5.234289497835221	\N	65990363	1.09528	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-17T23:00:00.000Z	defillama-api	5.204457879059987	\N	65671695	1.09559	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-18T23:00:00.000Z	defillama-api	5.204457879059987	\N	64995140	1.09559	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-19T23:00:00.000Z	defillama-api	5.173221579113374	\N	64110217	1.0959	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-20T23:00:00.000Z	defillama-api	5.173221579113374	\N	65573842	1.0959	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-21T23:00:00.000Z	defillama-api	5.11379782359711	\N	66463254	1.09621	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-22T23:00:00.000Z	defillama-api	5.113788020238985	\N	64762493	1.09621	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-23T23:00:00.000Z	defillama-api	4.968452535791812	\N	65399881	1.09651	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-24T23:00:00.000Z	defillama-api	4.968443432673553	\N	64797764	1.09651	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-25T23:00:00.000Z	defillama-api	5.1532304311763255	\N	64726624	1.09682	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-26T23:00:00.000Z	defillama-api	5.1532304311763255	\N	63720383	1.09682	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-27T23:00:00.000Z	defillama-api	5.1792128314076535	\N	62964084	1.09712	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-28T23:00:00.000Z	defillama-api	5.1792128314076535	\N	62552496	1.09712	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-29T23:00:00.000Z	defillama-api	4.922330536771824	\N	62516811	1.09742	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-30T23:00:00.000Z	defillama-api	4.922330536771824	\N	63004292	1.09742	assets_per_share
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-05-31T23:00:00.000Z	defillama-api	5.06233369463871	\N	62950076	1.09772	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-01T23:00:00.000Z	defillama-api	5.314779969722849	\N	65101894	1.02308	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-02T23:00:00.000Z	defillama-api	5.314779969722849	\N	65558519	1.02308	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-03T23:00:00.000Z	defillama-api	5.1463253658567965	\N	65748723	1.02337	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-04T23:00:00.000Z	defillama-api	5.146316262738537	\N	65356735	1.02337	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-05T23:00:00.000Z	defillama-api	4.958537139287955	\N	67030970	1.02364	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-06T23:00:00.000Z	defillama-api	4.95852733592983	\N	68586662	1.02364	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-07T23:00:00.000Z	defillama-api	4.787641499248707	\N	67595015	1.02391	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-08T23:00:00.000Z	defillama-api	4.787650602366966	\N	70854357	1.02391	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-09T23:00:00.000Z	defillama-api	5.304206347744866	\N	71619545	1.02421	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-10T23:00:00.000Z	defillama-api	5.304206347744866	\N	73719523	1.02421	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-11T23:00:00.000Z	defillama-api	5.286196178388991	\N	74730099	1.02451	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-12T23:00:00.000Z	defillama-api	5.286196178388991	\N	72746513	1.02451	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-13T23:00:00.000Z	defillama-api	5.181159498235388	\N	69872764	1.0248	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-14T23:00:00.000Z	defillama-api	5.181159498235388	\N	70833932	1.0248	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-15T23:00:00.000Z	defillama-api	5.10296581310854	\N	68438178	1.02509	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-16T23:00:00.000Z	defillama-api	5.10296581310854	\N	66406565	1.02509	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-17T23:00:00.000Z	defillama-api	5.308180208984936	\N	66148572	1.02539	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-18T23:00:00.000Z	defillama-api	5.308180208984936	\N	65730531	1.02539	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-19T23:00:00.000Z	defillama-api	5.107060815845443	\N	64412483	1.02567	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-20T23:00:00.000Z	defillama-api	5.107051712727184	\N	65731843	1.02567	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-21T23:00:00.000Z	defillama-api	4.971335423320511	\N	66014499	1.02595	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-22T23:00:00.000Z	defillama-api	4.971335423320511	\N	64604651	1.02595	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-23T23:00:00.000Z	defillama-api	5.027002391955193	\N	65173181	1.02623	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-24T23:00:00.000Z	defillama-api	5.027002391955193	\N	64520576	1.02623	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-25T23:00:00.000Z	defillama-api	4.8687110695055935	\N	64175195	1.02651	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-26T23:00:00.000Z	defillama-api	4.868701266147468	\N	63058800	1.02651	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-27T23:00:00.000Z	defillama-api	4.896005719245977	\N	62188599	1.02678	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-28T23:00:00.000Z	defillama-api	4.896005719245977	\N	53276896	1.02678	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-29T23:00:00.000Z	defillama-api	5.407351680020156	\N	53905391	1.02708	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-30T23:00:00.000Z	defillama-api	5.407360783138415	\N	55067235	1.02708	assets_per_share
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-05-31T23:00:00.000Z	defillama-api	5.178263306149233	\N	55206309	1.02737	assets_per_share
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-01T23:00:00.000Z	defillama-api	5.317757389633471	\N	109351994	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-02T23:00:00.000Z	defillama-api	5.317757389633471	\N	110448822	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-03T23:00:00.000Z	defillama-api	5.317757389633471	\N	110528535	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-04T23:00:00.000Z	defillama-api	5.316287586154544	\N	110011281	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-05T23:00:00.000Z	defillama-api	5.319407154757982	\N	113344426	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-06T23:00:00.000Z	defillama-api	5.319407154757982	\N	116450578	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-07T23:00:00.000Z	defillama-api	5.317387662984174	\N	115014532	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-08T23:00:00.000Z	defillama-api	5.317387662984174	\N	120452371	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-09T23:00:00.000Z	defillama-api	5.316657312803841	\N	122027844	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-10T23:00:00.000Z	defillama-api	5.316657312803841	\N	125625137	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-11T23:00:00.000Z	defillama-api	5.325504143272042	\N	127764574	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-12T23:00:00.000Z	defillama-api	5.325504143272042	\N	123503702	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-13T23:00:00.000Z	defillama-api	5.317169188145954	\N	119549109	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-14T23:00:00.000Z	defillama-api	5.317169188145954	\N	121946210	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-15T23:00:00.000Z	defillama-api	5.314372430120784	\N	117320243	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-16T23:00:00.000Z	defillama-api	5.314372430120784	\N	113720240	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-17T23:00:00.000Z	defillama-api	5.307828688572158	\N	113366714	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-18T23:00:00.000Z	defillama-api	5.307828688572158	\N	112211063	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-19T23:00:00.000Z	defillama-api	5.290255468892724	\N	110406920	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-20T23:00:00.000Z	defillama-api	5.290255468892724	\N	112906213	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-21T23:00:00.000Z	defillama-api	5.266664387804099	\N	114487549	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-22T23:00:00.000Z	defillama-api	5.266664387804099	\N	111553189	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-23T23:00:00.000Z	defillama-api	5.262280886242365	\N	112713745	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-24T23:00:00.000Z	defillama-api	5.262280886242365	\N	111585808	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-25T23:00:00.000Z	defillama-api	5.247232731520057	\N	111501073	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-26T23:00:00.000Z	defillama-api	5.247232731520057	\N	109772698	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-27T23:00:00.000Z	defillama-api	5.220489870794154	\N	108237385	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-28T23:00:00.000Z	defillama-api	5.220489870794154	\N	108065274	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-29T23:00:00.000Z	defillama-api	5.204420066107218	\N	107494708	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-30T23:00:00.000Z	defillama-api	5.204420066107218	\N	108982103	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-05-31T23:00:00.000Z	defillama-api	5.190710770008877	\N	109533798	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-01T23:00:00.000Z	defillama-api	5.41531830897668	\N	15959856	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-02T23:00:00.000Z	defillama-api	5.41531830897668	\N	16068694	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-03T23:00:00.000Z	defillama-api	5.41531830897668	\N	16150376	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-04T23:00:00.000Z	defillama-api	5.332302071892059	\N	16064490	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-05T23:00:00.000Z	defillama-api	5.33223554910478	\N	16524473	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-06T23:00:00.000Z	defillama-api	5.33223554910478	\N	17042219	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-07T23:00:00.000Z	defillama-api	5.323067308538043	\N	16964988	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-08T23:00:00.000Z	defillama-api	5.323067308538043	\N	17593632	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-09T23:00:00.000Z	defillama-api	5.333923127182061	\N	17819762	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-10T23:00:00.000Z	defillama-api	5.333923127182061	\N	18354910	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-11T23:00:00.000Z	defillama-api	5.4772426210547565	\N	18638846	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-12T23:00:00.000Z	defillama-api	5.4772426210547565	\N	18045285	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-13T23:00:00.000Z	defillama-api	5.47883286579065	\N	17404434	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-14T23:00:00.000Z	defillama-api	5.47883286579065	\N	17693754	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-15T23:00:00.000Z	defillama-api	5.488488473304187	\N	16978244	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-16T23:00:00.000Z	defillama-api	5.488488473304187	\N	16694436	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-17T23:00:00.000Z	defillama-api	5.483822074836553	\N	16407527	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-18T23:00:00.000Z	defillama-api	5.483822074836553	\N	16260779	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-19T23:00:00.000Z	defillama-api	5.484436885438981	\N	15543422	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-20T23:00:00.000Z	defillama-api	5.484436885438981	\N	15622007	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-21T23:00:00.000Z	defillama-api	5.47826497125925	\N	12126039	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-22T23:00:00.000Z	defillama-api	5.47826497125925	\N	11809349	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-23T23:00:00.000Z	defillama-api	5.47393818912667	\N	11884487	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-24T23:00:00.000Z	defillama-api	5.47393818912667	\N	11772312	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-25T23:00:00.000Z	defillama-api	5.465095560097666	\N	11754667	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-26T23:00:00.000Z	defillama-api	5.465095560097666	\N	11593491	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-27T23:00:00.000Z	defillama-api	5.458060250163044	\N	11440012	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-28T23:00:00.000Z	defillama-api	5.458060250163044	\N	11366439	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-29T23:00:00.000Z	defillama-api	5.432879624578391	\N	11325737	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-30T23:00:00.000Z	defillama-api	5.432879624578391	\N	11498244	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-05-31T23:00:00.000Z	defillama-api	5.42385353270447	\N	11417416	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-01T23:00:00.000Z	defillama-api	5.847954507842701	\N	16782445	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-02T23:00:00.000Z	defillama-api	5.847954507842701	\N	16947596	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-03T23:00:00.000Z	defillama-api	5.847954507842701	\N	17009737	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-04T23:00:00.000Z	defillama-api	5.920705228490419	\N	16929618	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-05T23:00:00.000Z	defillama-api	5.89927018594949	\N	16833783	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-06T23:00:00.000Z	defillama-api	5.89927018594949	\N	17472400	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-07T23:00:00.000Z	defillama-api	5.889295969296882	\N	17125499	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-08T23:00:00.000Z	defillama-api	5.889295969296882	\N	17967381	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-09T23:00:00.000Z	defillama-api	5.91592679164421	\N	18385393	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-10T23:00:00.000Z	defillama-api	5.91592679164421	\N	18971226	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-11T23:00:00.000Z	defillama-api	5.909705860673853	\N	19253213	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-12T23:00:00.000Z	defillama-api	5.909705860673853	\N	18658443	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-13T23:00:00.000Z	defillama-api	5.902060641815865	\N	17949331	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-14T23:00:00.000Z	defillama-api	5.902060641815865	\N	18262088	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-15T23:00:00.000Z	defillama-api	5.868561166622044	\N	17567418	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-16T23:00:00.000Z	defillama-api	5.868561166622044	\N	17037731	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-17T23:00:00.000Z	defillama-api	5.863053780075234	\N	16969393	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-18T23:00:00.000Z	defillama-api	5.863053780075234	\N	16811709	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-19T23:00:00.000Z	defillama-api	5.860856427375438	\N	16551891	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-20T23:00:00.000Z	defillama-api	5.860856427375438	\N	16928964	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-21T23:00:00.000Z	defillama-api	5.8464454909312735	\N	17146194	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-22T23:00:00.000Z	defillama-api	5.8464454909312735	\N	16710146	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-23T23:00:00.000Z	defillama-api	5.836315120788527	\N	16931065	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-24T23:00:00.000Z	defillama-api	5.836315120788527	\N	16870811	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-25T23:00:00.000Z	defillama-api	5.83300368646178	\N	16837092	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-26T23:00:00.000Z	defillama-api	5.83300368646178	\N	16580641	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-27T23:00:00.000Z	defillama-api	5.823249345127124	\N	15741936	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-28T23:00:00.000Z	defillama-api	5.823249345127124	\N	15628642	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-29T23:00:00.000Z	defillama-api	5.777482367719244	\N	15445670	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-30T23:00:00.000Z	defillama-api	5.777482367719244	\N	15680384	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-05-31T23:00:00.000Z	defillama-api	5.815513095086544	\N	15306572	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-01T23:00:00.000Z	defillama-api	5.031966392365916	\N	743357417	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-02T23:00:00.000Z	defillama-api	5.031966392365916	\N	750450001	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-03T23:00:00.000Z	defillama-api	5.031966392365916	\N	752803487	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-04T23:00:00.000Z	defillama-api	5.039715946963952	\N	704614192	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-05T23:00:00.000Z	defillama-api	5.025927523760743	\N	724807574	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-06T23:00:00.000Z	defillama-api	5.025927523760743	\N	745231538	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-07T23:00:00.000Z	defillama-api	5.025147456549917	\N	736653610	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-08T23:00:00.000Z	defillama-api	5.025147456549917	\N	772056628	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-09T23:00:00.000Z	defillama-api	5.003548557880322	\N	781166824	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-10T23:00:00.000Z	defillama-api	5.003548557880322	\N	804878589	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-11T23:00:00.000Z	defillama-api	5.01979342253378	\N	766041616	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-12T23:00:00.000Z	defillama-api	5.01979342253378	\N	742377982	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-13T23:00:00.000Z	defillama-api	5.024463322200745	\N	648607323	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-14T23:00:00.000Z	defillama-api	5.024463322200745	\N	660150788	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-15T23:00:00.000Z	defillama-api	5.009455081150804	\N	634639313	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-16T23:00:00.000Z	defillama-api	5.009455081150804	\N	615719189	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-17T23:00:00.000Z	defillama-api	4.9894695351326845	\N	613164109	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-18T23:00:00.000Z	defillama-api	4.9894695351326845	\N	606935782	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-19T23:00:00.000Z	defillama-api	4.969366348817061	\N	598618776	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-20T23:00:00.000Z	defillama-api	4.969366348817061	\N	612226760	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-21T23:00:00.000Z	defillama-api	4.94725977624455	\N	620320991	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-22T22:00:00.000Z	defillama-api	4.94725977624455	\N	605801622	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-23T23:00:00.000Z	defillama-api	4.922045539146325	\N	609416051	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-24T23:00:00.000Z	defillama-api	4.922045539146325	\N	605794004	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-25T23:00:00.000Z	defillama-api	4.9381321495900465	\N	604667430	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-26T23:00:00.000Z	defillama-api	4.9381321495900465	\N	595626092	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-27T23:00:00.000Z	defillama-api	4.948820610906068	\N	586169994	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-28T23:00:00.000Z	defillama-api	4.948820610906068	\N	555492310	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-29T23:00:00.000Z	defillama-api	4.942253761441862	\N	551999091	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-30T23:00:00.000Z	defillama-api	4.942253761441862	\N	432715611	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-05-31T23:00:00.000Z	defillama-api	4.9513904912146245	\N	427768749	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-01T23:00:00.000Z	defillama-api	5.404130576636135	\N	5254653	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-02T12:00:00.000Z	defillama-api	5.404130576636135	\N	5254954	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-04T23:00:00.000Z	defillama-api	5.554965044751725	\N	5268302	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-05T23:00:00.000Z	defillama-api	5.551843375428689	\N	5297058	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-06T23:00:00.000Z	defillama-api	5.551843375428689	\N	5510429	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-07T23:00:00.000Z	defillama-api	5.5805216991444695	\N	5446457	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-08T23:00:00.000Z	defillama-api	5.5805216991444695	\N	5707959	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-09T23:00:00.000Z	defillama-api	5.510797415197999	\N	5732232	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-10T23:00:00.000Z	defillama-api	5.510797415197999	\N	5887000	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-11T23:00:00.000Z	defillama-api	5.641180677784519	\N	6011306	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-12T23:00:00.000Z	defillama-api	5.641180677784519	\N	5831734	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-13T23:00:00.000Z	defillama-api	5.63242837969824	\N	4731005	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-14T23:00:00.000Z	defillama-api	5.63242837969824	\N	4771078	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-15T23:00:00.000Z	defillama-api	5.6361333488297305	\N	4618866	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-16T23:00:00.000Z	defillama-api	5.6361333488297305	\N	4498382	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-17T23:00:00.000Z	defillama-api	5.61068523161623	\N	4505422	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-18T23:00:00.000Z	defillama-api	5.61068523161623	\N	4408856	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-19T23:00:00.000Z	defillama-api	5.6201300669300736	\N	4386338	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-20T23:00:00.000Z	defillama-api	5.6201300669300736	\N	4414961	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-21T23:00:00.000Z	defillama-api	5.60835973502094	\N	4497084	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-22T23:00:00.000Z	defillama-api	5.60835973502094	\N	4381090	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-23T23:00:00.000Z	defillama-api	5.604190506858231	\N	4404689	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-24T23:00:00.000Z	defillama-api	5.604190506858231	\N	4385827	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-25T23:00:00.000Z	defillama-api	5.604067264641799	\N	4382190	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-26T23:00:00.000Z	defillama-api	5.604067264641799	\N	4318672	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-27T23:00:00.000Z	defillama-api	5.576832835529899	\N	4229283	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-28T23:00:00.000Z	defillama-api	5.576832835529899	\N	4160299	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-29T23:00:00.000Z	defillama-api	5.5727378327929955	\N	4208901	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-30T23:00:00.000Z	defillama-api	5.5727378327929955	\N	4230102	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-05-31T23:00:00.000Z	defillama-api	5.435162406541849	\N	4236071	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-01T23:00:00.000Z	defillama-api	5.720239859385856	\N	7401675	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-02T23:00:00.000Z	defillama-api	5.738559534762544	\N	7471327	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-03T23:00:00.000Z	defillama-api	5.773508506479175	\N	7462626	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-04T23:00:00.000Z	defillama-api	5.81465390077085	\N	7423163	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-05T23:00:00.000Z	defillama-api	5.821654898952033	\N	7702776	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-06T23:00:00.000Z	defillama-api	5.823711503438744	\N	7924608	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-07T23:00:00.000Z	defillama-api	5.826909498907185	\N	7822783	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-08T23:00:00.000Z	defillama-api	5.833682919131888	\N	8211877	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-09T23:00:00.000Z	defillama-api	5.791365323304376	\N	8295744	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-10T23:00:00.000Z	defillama-api	5.792356862954762	\N	8560081	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-11T23:00:00.000Z	defillama-api	5.776066482710007	\N	8685161	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-12T23:00:00.000Z	defillama-api	5.79124278132781	\N	8424836	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-13T23:00:00.000Z	defillama-api	5.780153782808384	\N	8150959	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-14T23:00:00.000Z	defillama-api	5.787968459713966	\N	8289725	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-15T23:00:00.000Z	defillama-api	5.744885501712815	\N	7988409	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-16T23:00:00.000Z	defillama-api	5.73075956289415	\N	7740977	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-17T23:00:00.000Z	defillama-api	5.722052780399167	\N	7742484	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-18T23:00:00.000Z	defillama-api	5.750182116059932	\N	7665124	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-19T23:00:00.000Z	defillama-api	5.692167943394111	\N	7552671	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-20T23:00:00.000Z	defillama-api	5.647466030822557	\N	7727381	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-21T23:00:00.000Z	defillama-api	5.646690865290793	\N	7972329	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-22T23:00:00.000Z	defillama-api	5.682702100884285	\N	7767477	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-23T23:00:00.000Z	defillama-api	5.71260864532519	\N	7848608	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-24T23:00:00.000Z	defillama-api	5.751390730068806	\N	7771164	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-25T23:00:00.000Z	defillama-api	5.745405079693455	\N	7772073	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-26T23:00:00.000Z	defillama-api	5.778265936129401	\N	7643856	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-27T23:00:00.000Z	defillama-api	5.78549521250693	\N	7499588	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-28T23:00:00.000Z	defillama-api	5.822654841480812	\N	7436652	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-29T23:00:00.000Z	defillama-api	5.823504232438381	\N	7429534	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-30T23:00:00.000Z	defillama-api	5.823268251603508	\N	7488140	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-05-31T23:00:00.000Z	defillama-api	5.81822092264872	\N	7613117	\N	\N
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
