-- Generated from VAULT_LLAMA_LST/solana/2026-03.ndjson (527 vault rows)
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
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-01T23:00:00.000Z	defillama-api	6.455205320676782	\N	397098072	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-02T23:00:00.000Z	defillama-api	6.455205320676782	\N	421585658	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-03T23:00:00.000Z	defillama-api	6.454427354185555	\N	413855496	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-04T23:00:00.000Z	defillama-api	6.454427354185555	\N	438096255	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-05T23:00:00.000Z	defillama-api	6.4169295093563505	\N	369362448	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-06T23:00:00.000Z	defillama-api	6.4169295093563505	\N	354138138	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-07T23:00:00.000Z	defillama-api	6.4058342086781295	\N	346288993	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-08T23:00:00.000Z	defillama-api	6.4058342086781295	\N	344372650	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-09T23:00:00.000Z	defillama-api	6.355190760842788	\N	362334228	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-10T23:00:00.000Z	defillama-api	6.355190760842788	\N	361402045	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-11T23:00:00.000Z	defillama-api	6.294700540010467	\N	369365647	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-12T23:00:00.000Z	defillama-api	6.294700540010467	\N	368554961	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-13T23:00:00.000Z	defillama-api	6.218960495374404	\N	379585661	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-14T23:00:00.000Z	defillama-api	6.218960495374404	\N	376696539	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-15T23:00:00.000Z	defillama-api	6.159732807020646	\N	398592990	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-16T23:00:00.000Z	defillama-api	6.159732807020646	\N	415892937	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-17T23:00:00.000Z	defillama-api	6.086948474859355	\N	411478304	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-18T23:00:00.000Z	defillama-api	6.086948474859355	\N	388759432	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-19T23:00:00.000Z	defillama-api	6.086948474859355	\N	386181135	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-20T23:00:00.000Z	defillama-api	6.086948474859355	\N	392130311	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-21T23:00:00.000Z	defillama-api	6.049454131229481	\N	391238417	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-22T23:00:00.000Z	defillama-api	6.049454131229481	\N	377398670	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-23T23:00:00.000Z	defillama-api	6.008885734587466	\N	397987433	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-24T23:00:00.000Z	defillama-api	6.008885734587466	\N	393069711	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-25T23:00:00.000Z	defillama-api	6.008885734587466	\N	398625591	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-26T23:00:00.000Z	defillama-api	6.008885734587466	\N	376712212	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-27T23:00:00.000Z	defillama-api	6.019347318186874	\N	358915071	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-28T23:00:00.000Z	defillama-api	6.019347318186874	\N	361044069	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-29T23:00:00.000Z	defillama-api	6.008574828086921	\N	348918543	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-30T23:00:00.000Z	defillama-api	6.008574828086921	\N	361421115	\N	\N
VAULT_LLAMA_LST	solana	jupsolahxqizztsfewmtrrgpnyfm8f6szdoswbjx93v	2026-03-31T23:00:00.000Z	defillama-api	5.989042337262163	\N	360709884	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-01T23:00:00.000Z	defillama-api	6.413300166130398	\N	237911962	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-02T23:00:00.000Z	defillama-api	4.880788106476075	\N	252592429	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-03T23:00:00.000Z	defillama-api	6.589700391756992	\N	246230230	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-04T23:00:00.000Z	defillama-api	5.02087739384649	\N	260552951	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-05T23:00:00.000Z	defillama-api	6.732756595440037	\N	254381808	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-06T23:00:00.000Z	defillama-api	5.090459529100144	\N	242363911	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-07T23:00:00.000Z	defillama-api	6.822315873833418	\N	236242838	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-08T23:00:00.000Z	defillama-api	5.152556100185279	\N	233233004	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-09T23:00:00.000Z	defillama-api	6.854180989179781	\N	243855356	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-10T23:00:00.000Z	defillama-api	5.1444830347691095	\N	242875463	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-11T23:00:00.000Z	defillama-api	6.855236250657981	\N	246198272	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-12T23:00:00.000Z	defillama-api	5.1433052313143435	\N	244195816	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-13T23:00:00.000Z	defillama-api	6.8379886425162795	\N	248402343	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-14T23:00:00.000Z	defillama-api	5.106044067559878	\N	246844975	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-15T23:00:00.000Z	defillama-api	6.795290116201613	\N	260842758	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-16T23:00:00.000Z	defillama-api	5.0941469922349825	\N	272324980	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-17T23:00:00.000Z	defillama-api	6.757864396078617	\N	268774117	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-18T23:00:00.000Z	defillama-api	5.044070738691175	\N	253418543	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-19T23:00:00.000Z	defillama-api	6.759547072476835	\N	249079032	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-20T23:00:00.000Z	defillama-api	5.06761000202971	\N	253180473	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-21T23:00:00.000Z	defillama-api	6.827173437784495	\N	252563164	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-22T23:00:00.000Z	defillama-api	5.140465058417476	\N	243289928	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-23T23:00:00.000Z	defillama-api	6.888844963270913	\N	256415168	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-24T23:00:00.000Z	defillama-api	5.225083444315715	\N	253200654	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-25T23:00:00.000Z	defillama-api	6.88911595609909	\N	257284596	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-26T23:00:00.000Z	defillama-api	5.172746816484164	\N	243077540	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-27T23:00:00.000Z	defillama-api	6.845011348133312	\N	232212892	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-28T23:00:00.000Z	defillama-api	5.085365284074328	\N	232236162	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-29T23:00:00.000Z	defillama-api	6.736654830774569	\N	225647819	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-30T23:00:00.000Z	defillama-api	4.987805064970985	\N	232371971	\N	\N
VAULT_LLAMA_LST	solana	msolzycxhdygdzu16g5qsh3i5k3z3kzk7ytfqcjm7so	2026-03-31T23:00:00.000Z	defillama-api	6.719358906082107	\N	232291504	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-01T23:00:00.000Z	defillama-api	5.789147663648464	\N	111855370	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-02T23:00:00.000Z	defillama-api	5.789147663648464	\N	118717915	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-03T23:00:00.000Z	defillama-api	5.609674085249594	\N	115709004	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-04T23:00:00.000Z	defillama-api	5.609674085249594	\N	123087164	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-05T23:00:00.000Z	defillama-api	5.694728020344542	\N	120259759	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-06T23:00:00.000Z	defillama-api	5.694728020344542	\N	114206400	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-07T23:00:00.000Z	defillama-api	5.704174256138117	\N	111727973	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-08T23:00:00.000Z	defillama-api	5.704174256138117	\N	110805097	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-09T23:00:00.000Z	defillama-api	5.80802122875923	\N	115355439	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-10T23:00:00.000Z	defillama-api	5.80802122875923	\N	113691781	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-11T23:00:00.000Z	defillama-api	5.524547325208573	\N	115494484	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-12T23:00:00.000Z	defillama-api	5.524547325208573	\N	114168310	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-13T23:00:00.000Z	defillama-api	5.79858479632378	\N	117637813	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-14T23:00:00.000Z	defillama-api	5.79858479632378	\N	115131792	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-15T23:00:00.000Z	defillama-api	5.56239038829176	\N	121754917	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-16T23:00:00.000Z	defillama-api	5.56239038829176	\N	127250566	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-17T23:00:00.000Z	defillama-api	5.534009666519069	\N	124993761	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-18T23:00:00.000Z	defillama-api	5.534009666519069	\N	111982083	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-19T23:00:00.000Z	defillama-api	5.552930847940729	\N	110200029	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-20T23:00:00.000Z	defillama-api	5.552930847940729	\N	112057212	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-21T23:00:00.000Z	defillama-api	5.410932706695348	\N	112074614	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-22T23:00:00.000Z	defillama-api	5.410932706695348	\N	107782660	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-23T23:00:00.000Z	defillama-api	5.42987699603259	\N	113563579	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-24T23:00:00.000Z	defillama-api	5.42987699603259	\N	111928417	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-25T23:00:00.000Z	defillama-api	5.363555177595458	\N	112348326	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-26T23:00:00.000Z	defillama-api	5.363555177595458	\N	106221830	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-27T23:00:00.000Z	defillama-api	5.49615609983789	\N	101475719	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-28T23:00:00.000Z	defillama-api	5.49615609983789	\N	101478070	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-29T23:00:00.000Z	defillama-api	5.477223714578372	\N	98548368	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-30T23:00:00.000Z	defillama-api	5.590763407425925	\N	101010861	\N	\N
VAULT_LLAMA_LST	solana	bybit2vbjghpf52gbdnaqfuj6zpthsghbobjwzplpb4b	2026-03-31T23:00:00.000Z	defillama-api	5.590763407425925	\N	99684513	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-01T23:00:00.000Z	defillama-api	5.846115677954344	\N	71970404	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-02T23:00:00.000Z	defillama-api	5.846115677954344	\N	73978424	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-03T23:00:00.000Z	defillama-api	5.924927674882952	\N	73355284	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-04T23:00:00.000Z	defillama-api	5.924927674882952	\N	78098271	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-05T23:00:00.000Z	defillama-api	5.8985629436847375	\N	72501631	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-06T23:00:00.000Z	defillama-api	5.8985629436847375	\N	68997208	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-07T23:00:00.000Z	defillama-api	5.7970652758143615	\N	67576147	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-08T23:00:00.000Z	defillama-api	5.7970652758143615	\N	66502452	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-09T23:00:00.000Z	defillama-api	5.8016987630082895	\N	69830036	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-10T23:00:00.000Z	defillama-api	5.8016987630082895	\N	69495147	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-11T23:00:00.000Z	defillama-api	5.8016987630082895	\N	70613756	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-12T23:00:00.000Z	defillama-api	5.8016987630082895	\N	70258813	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-13T23:00:00.000Z	defillama-api	5.764078376202519	\N	68151281	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-14T23:00:00.000Z	defillama-api	5.764078376202519	\N	67579484	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-15T23:00:00.000Z	defillama-api	5.757017157392852	\N	71186773	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-16T23:00:00.000Z	defillama-api	5.757017157392852	\N	72754942	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-17T23:00:00.000Z	defillama-api	5.745839228410432	\N	71039431	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-18T23:00:00.000Z	defillama-api	5.745839228410432	\N	67096813	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-19T23:00:00.000Z	defillama-api	5.731496215233278	\N	66085564	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-20T23:00:00.000Z	defillama-api	5.731496215233278	\N	67092682	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-21T23:00:00.000Z	defillama-api	5.72332791719532	\N	67004120	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-22T23:00:00.000Z	defillama-api	5.72332791719532	\N	64535238	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-23T23:00:00.000Z	defillama-api	5.7145160987204235	\N	68090270	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-24T23:00:00.000Z	defillama-api	5.7145160987204235	\N	67170818	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-25T23:00:00.000Z	defillama-api	5.691978878630266	\N	68250917	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-26T23:00:00.000Z	defillama-api	5.691978878630266	\N	64458036	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-27T23:00:00.000Z	defillama-api	5.693310734855572	\N	61496606	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-28T23:00:00.000Z	defillama-api	5.693310734855572	\N	61594570	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-29T23:00:00.000Z	defillama-api	5.71584795494573	\N	60590284	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-30T23:00:00.000Z	defillama-api	5.71584795494573	\N	61605854	\N	\N
VAULT_LLAMA_LST	solana	he1iusmfkpadwvxlngv8y1isbj4ruy6ymhea3fotn9a	2026-03-31T23:00:00.000Z	defillama-api	5.693310734855572	\N	61206461	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-01T23:00:00.000Z	defillama-api	6.4579054456004314	\N	231218260	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-02T23:00:00.000Z	defillama-api	6.4579054456004314	\N	252878541	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-03T23:00:00.000Z	defillama-api	6.2016778752393975	\N	250738068	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-04T23:00:00.000Z	defillama-api	6.2016778752393975	\N	258922443	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-05T23:00:00.000Z	defillama-api	6.044051080422719	\N	223903015	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-06T23:00:00.000Z	defillama-api	6.044051080422719	\N	213292374	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-07T23:00:00.000Z	defillama-api	6.181215465872469	\N	208720988	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-08T23:00:00.000Z	defillama-api	6.181215465872469	\N	205722842	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-09T23:00:00.000Z	defillama-api	6.181215465872469	\N	215502138	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-10T23:00:00.000Z	defillama-api	6.181215465872469	\N	215618821	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-11T23:00:00.000Z	defillama-api	6.234502319202306	\N	218712694	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-12T23:00:00.000Z	defillama-api	6.234502319202306	\N	216572104	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-13T23:00:00.000Z	defillama-api	6.296822967044591	\N	228696691	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-14T23:00:00.000Z	defillama-api	6.296822967044591	\N	230596313	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-15T23:00:00.000Z	defillama-api	6.326987199756218	\N	244050166	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-16T23:00:00.000Z	defillama-api	6.326987199756218	\N	255545087	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-17T23:00:00.000Z	defillama-api	6.270687914522455	\N	251470343	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-18T23:00:00.000Z	defillama-api	6.270687914522455	\N	237516249	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-19T23:00:00.000Z	defillama-api	6.205709856388353	\N	234065177	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-20T23:00:00.000Z	defillama-api	6.205709856388353	\N	237785780	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-21T23:00:00.000Z	defillama-api	6.163079953580564	\N	237132939	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-22T23:00:00.000Z	defillama-api	6.163079953580564	\N	228610932	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-23T23:00:00.000Z	defillama-api	6.100892351312837	\N	240051179	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-24T23:00:00.000Z	defillama-api	6.100892351312837	\N	236842118	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-25T23:00:00.000Z	defillama-api	6.058368184724827	\N	240444806	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-26T23:00:00.000Z	defillama-api	6.058368184724827	\N	228644489	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-27T23:00:00.000Z	defillama-api	6.100892351312837	\N	218070919	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-28T23:00:00.000Z	defillama-api	6.100892351312837	\N	218110042	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-29T23:00:00.000Z	defillama-api	6.067845231072511	\N	219177102	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-30T23:00:00.000Z	defillama-api	6.067845231072511	\N	227167598	\N	\N
VAULT_LLAMA_LST	solana	dso1bdedjcqxtrwhquui63obvv7mdm6waoblbq7gnpq	2026-03-31T23:00:00.000Z	defillama-api	6.034844326663347	\N	237370500	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-01T23:00:00.000Z	defillama-api	6.01300034404062	\N	44777082	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-02T23:00:00.000Z	defillama-api	6.01300034404062	\N	46630040	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-03T23:00:00.000Z	defillama-api	6.01300034404062	\N	45852779	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-04T23:00:00.000Z	defillama-api	6.01300034404062	\N	49131197	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-05T23:00:00.000Z	defillama-api	5.99443908591013	\N	45801076	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-06T23:00:00.000Z	defillama-api	5.99443908591013	\N	43614582	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-07T23:00:00.000Z	defillama-api	5.9709194292878465	\N	42649593	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-08T23:00:00.000Z	defillama-api	5.9709194292878465	\N	42058010	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-09T23:00:00.000Z	defillama-api	5.960631505175229	\N	44098137	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-10T23:00:00.000Z	defillama-api	5.960631505175229	\N	43852202	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-11T23:00:00.000Z	defillama-api	5.930440663348691	\N	44568580	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-12T23:00:00.000Z	defillama-api	5.930440663348691	\N	43928585	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-13T23:00:00.000Z	defillama-api	5.9171045950989765	\N	57780750	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-14T23:00:00.000Z	defillama-api	5.9171045950989765	\N	57397691	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-15T23:00:00.000Z	defillama-api	5.896187730058955	\N	60703353	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-16T23:00:00.000Z	defillama-api	5.896187730058955	\N	63428741	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-17T23:00:00.000Z	defillama-api	5.886316448666662	\N	62513886	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-18T23:00:00.000Z	defillama-api	5.886316448666662	\N	59121182	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-19T23:00:00.000Z	defillama-api	5.855716666758326	\N	58256650	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-20T23:00:00.000Z	defillama-api	5.855716666758326	\N	58898477	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-21T23:00:00.000Z	defillama-api	5.848237404748602	\N	59106050	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-22T23:00:00.000Z	defillama-api	5.848237404748602	\N	56983250	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-23T23:00:00.000Z	defillama-api	5.83890880925253	\N	60019698	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-24T23:00:00.000Z	defillama-api	5.83890880925253	\N	59305043	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-25T23:00:00.000Z	defillama-api	5.822287215551114	\N	60096139	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-26T23:00:00.000Z	defillama-api	5.822287215551114	\N	56713421	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-27T23:00:00.000Z	defillama-api	5.837144905029845	\N	53856172	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-28T23:00:00.000Z	defillama-api	5.837144905029845	\N	54218751	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-29T23:00:00.000Z	defillama-api	5.846973471790307	\N	52106796	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-30T23:00:00.000Z	defillama-api	5.846973471790307	\N	54156276	\N	\N
VAULT_LLAMA_LST	solana	sctmb7gpi5l2q5g9tuszxvhz4yidmegcrov9kfarqpx	2026-03-31T23:00:00.000Z	defillama-api	5.83221171517323	\N	54210000	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-01T23:00:00.000Z	defillama-api	6.620488538189306	\N	113365258	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-02T23:00:00.000Z	defillama-api	6.620488538189306	\N	117427699	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-03T23:00:00.000Z	defillama-api	6.509011751987259	\N	116400980	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-04T23:00:00.000Z	defillama-api	6.509011751987259	\N	123224285	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-05T23:00:00.000Z	defillama-api	6.489764258788	\N	119332066	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-06T23:00:00.000Z	defillama-api	6.489764258788	\N	113825955	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-07T23:00:00.000Z	defillama-api	6.505067300821565	\N	111145585	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-08T23:00:00.000Z	defillama-api	6.505067300821565	\N	109994761	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-09T23:00:00.000Z	defillama-api	6.505067300821565	\N	115496282	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-10T23:00:00.000Z	defillama-api	6.505067300821565	\N	114308111	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-11T23:00:00.000Z	defillama-api	6.415466708276085	\N	115810933	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-12T23:00:00.000Z	defillama-api	6.415466708276085	\N	115093350	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-13T23:00:00.000Z	defillama-api	6.513359541315822	\N	118469027	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-14T23:00:00.000Z	defillama-api	6.513359541315822	\N	117845206	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-15T23:00:00.000Z	defillama-api	6.468919518454186	\N	126108889	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-16T23:00:00.000Z	defillama-api	6.468919518454186	\N	132437168	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-17T23:00:00.000Z	defillama-api	6.402176155617667	\N	131148321	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-18T23:00:00.000Z	defillama-api	6.402176155617667	\N	125029156	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-19T23:00:00.000Z	defillama-api	6.281187311074632	\N	122902363	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-20T23:00:00.000Z	defillama-api	6.281187311074632	\N	124505918	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-21T23:00:00.000Z	defillama-api	6.167169354398538	\N	124773908	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-22T23:00:00.000Z	defillama-api	6.167169354398538	\N	120402314	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-23T23:00:00.000Z	defillama-api	6.155980921818127	\N	127224090	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-24T23:00:00.000Z	defillama-api	6.155980921818127	\N	125828496	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-25T23:00:00.000Z	defillama-api	6.146445755561558	\N	128084132	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-26T23:00:00.000Z	defillama-api	6.146445755561558	\N	121361997	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-27T23:00:00.000Z	defillama-api	6.166831138543216	\N	116025667	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-28T23:00:00.000Z	defillama-api	6.166831138543216	\N	115979269	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-29T23:00:00.000Z	defillama-api	6.151110053309594	\N	111718344	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-30T23:00:00.000Z	defillama-api	6.151110053309594	\N	115683375	\N	\N
VAULT_LLAMA_LST	solana	pso1f9nqxwgxibftkf7nwyxb5enam4qfp6ujsixrqfl	2026-03-31T23:00:00.000Z	defillama-api	6.186939926777768	\N	116229607	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-01T23:00:00.000Z	defillama-api	5.542240986144975	\N	103279234	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-02T23:00:00.000Z	defillama-api	5.542240986144975	\N	109660962	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-03T23:00:00.000Z	defillama-api	5.542240986144975	\N	107569330	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-04T23:00:00.000Z	defillama-api	5.542240986144975	\N	113869826	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-05T23:00:00.000Z	defillama-api	5.51323915161106	\N	111274479	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-06T23:00:00.000Z	defillama-api	5.51323915161106	\N	105915103	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-07T23:00:00.000Z	defillama-api	5.489236329481173	\N	103474068	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-08T23:00:00.000Z	defillama-api	5.489236329481173	\N	102191444	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-09T23:00:00.000Z	defillama-api	5.485828962292771	\N	106960447	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-10T23:00:00.000Z	defillama-api	5.485828962292771	\N	106709482	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-11T23:00:00.000Z	defillama-api	5.4520479906727815	\N	108776440	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-12T23:00:00.000Z	defillama-api	5.4520479906727815	\N	107744936	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-13T23:00:00.000Z	defillama-api	5.451062753181191	\N	109965527	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-14T23:00:00.000Z	defillama-api	5.451062753181191	\N	109428798	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-15T23:00:00.000Z	defillama-api	5.448553093501118	\N	116033696	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-16T23:00:00.000Z	defillama-api	5.448553093501118	\N	120966403	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-17T23:00:00.000Z	defillama-api	5.451820412716302	\N	119651867	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-18T23:00:00.000Z	defillama-api	5.451820412716302	\N	112220181	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-19T23:00:00.000Z	defillama-api	5.427158664872422	\N	110591154	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-20T23:00:00.000Z	defillama-api	5.427158664872422	\N	112322023	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-21T23:00:00.000Z	defillama-api	5.427158664872422	\N	111993984	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-22T23:00:00.000Z	defillama-api	5.427158664872422	\N	107986167	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-23T23:00:00.000Z	defillama-api	5.420187777005481	\N	114030337	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-24T23:00:00.000Z	defillama-api	5.420187777005481	\N	112549296	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-25T23:00:00.000Z	defillama-api	5.390363860868774	\N	112639770	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-26T23:00:00.000Z	defillama-api	5.390363860868774	\N	106856881	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-27T23:00:00.000Z	defillama-api	5.35673063986053	\N	102483558	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-28T23:00:00.000Z	defillama-api	5.35673063986053	\N	102540919	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-29T23:00:00.000Z	defillama-api	5.327163011514813	\N	100291389	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-30T23:00:00.000Z	defillama-api	5.327163011514813	\N	103156411	\N	\N
VAULT_LLAMA_LST	solana	7q2afv64in6n6sezsaab81tjzwdod6zpqmhkzi9dcavn	2026-03-31T23:00:00.000Z	defillama-api	5.3056670481055335	\N	102969471	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-01T23:00:00.000Z	defillama-api	5.376008243374031	\N	741078114	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-02T23:00:00.000Z	defillama-api	5.376008243374031	\N	787288533	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-03T23:00:00.000Z	defillama-api	5.410373915282207	\N	774163255	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-04T23:00:00.000Z	defillama-api	5.410373915282207	\N	814607783	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-05T23:00:00.000Z	defillama-api	5.341042465900614	\N	796948607	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-06T23:00:00.000Z	defillama-api	5.341042465900614	\N	757249825	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-07T23:00:00.000Z	defillama-api	5.451119472610344	\N	741423876	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-08T23:00:00.000Z	defillama-api	5.451119472610344	\N	728830452	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-09T23:00:00.000Z	defillama-api	5.2450696905737	\N	769621538	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-10T23:00:00.000Z	defillama-api	5.2450696905737	\N	768225538	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-11T23:00:00.000Z	defillama-api	5.271568867826204	\N	805483010	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-12T23:00:00.000Z	defillama-api	5.271568867826204	\N	805112544	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-13T23:00:00.000Z	defillama-api	5.691119684314572	\N	827777319	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-14T23:00:00.000Z	defillama-api	5.691119684314572	\N	820382855	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-15T23:00:00.000Z	defillama-api	5.265971850576534	\N	869195439	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-16T23:00:00.000Z	defillama-api	5.265971850576534	\N	987362218	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-17T23:00:00.000Z	defillama-api	4.813976120132679	\N	999006732	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-18T23:00:00.000Z	defillama-api	4.813976120132679	\N	964954428	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-19T23:00:00.000Z	defillama-api	4.95941243912057	\N	952205986	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-20T23:00:00.000Z	defillama-api	4.95941243912057	\N	968248185	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-21T23:00:00.000Z	defillama-api	5.2661896251748885	\N	966513959	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-22T23:00:00.000Z	defillama-api	5.2661896251748885	\N	932661121	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-23T23:00:00.000Z	defillama-api	5.199179470949389	\N	984739862	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-24T23:00:00.000Z	defillama-api	5.199179470949389	\N	970076297	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-25T23:00:00.000Z	defillama-api	5.215506963907046	\N	986502735	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-26T23:00:00.000Z	defillama-api	5.215506963907046	\N	879016842	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-27T23:00:00.000Z	defillama-api	5.340028518574513	\N	826790625	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-28T23:00:00.000Z	defillama-api	5.340028518574513	\N	818160942	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-29T23:00:00.000Z	defillama-api	5.249035849175243	\N	779427876	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-30T23:00:00.000Z	defillama-api	5.249035849175243	\N	797782007	\N	\N
VAULT_LLAMA_LST	solana	bnso1vujnh4zcfpza6986ea66p6tcp59hvtnj8b1x85	2026-03-31T23:00:00.000Z	defillama-api	5.19911294816211	\N	789504234	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-01T23:00:00.000Z	defillama-api	5.269510162619895	\N	61562024	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-02T23:00:00.000Z	defillama-api	5.26951996597802	\N	65396230	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-03T23:00:00.000Z	defillama-api	5.501853951628277	\N	64160554	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-04T23:00:00.000Z	defillama-api	5.501853951628277	\N	67890909	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-05T23:00:00.000Z	defillama-api	5.521481675074824	\N	66449790	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-06T23:00:00.000Z	defillama-api	5.521481675074824	\N	63240437	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-07T23:00:00.000Z	defillama-api	5.324849418997246	\N	61719037	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-08T23:00:00.000Z	defillama-api	5.324849418997246	\N	60974130	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-09T23:00:00.000Z	defillama-api	5.502194268203198	\N	63793549	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-10T23:00:00.000Z	defillama-api	5.502194268203198	\N	63671553	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-11T23:00:00.000Z	defillama-api	5.521093742189009	\N	64772971	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-12T23:00:00.000Z	defillama-api	5.521102845307269	\N	64068096	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-13T23:00:00.000Z	defillama-api	5.231461229016077	\N	65567776	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-14T23:00:00.000Z	defillama-api	5.231461229016077	\N	65070582	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-15T23:00:00.000Z	defillama-api	5.484597940608182	\N	68921485	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-16T23:00:00.000Z	defillama-api	5.484597940608182	\N	71728100	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-17T23:00:00.000Z	defillama-api	5.4451254193566	\N	71995436	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-18T23:00:00.000Z	defillama-api	5.4451254193566	\N	67982252	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-19T23:00:00.000Z	defillama-api	5.324527308658844	\N	67007311	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-20T23:00:00.000Z	defillama-api	5.324527308658844	\N	68108268	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-21T23:00:00.000Z	defillama-api	5.463003243377784	\N	67963039	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-22T23:00:00.000Z	defillama-api	5.463003243377784	\N	65538878	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-23T23:00:00.000Z	defillama-api	5.371554017585822	\N	69180901	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-24T23:00:00.000Z	defillama-api	5.3715631207040815	\N	68275046	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-25T23:00:00.000Z	defillama-api	5.095571980362479	\N	69369041	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-26T23:00:00.000Z	defillama-api	5.09556287724422	\N	65573254	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-27T23:00:00.000Z	defillama-api	5.361450956797853	\N	62588972	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-28T23:00:00.000Z	defillama-api	5.361450956797853	\N	62605767	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-29T23:00:00.000Z	defillama-api	5.328443049990028	\N	61110805	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-30T23:00:00.000Z	defillama-api	5.328443049990028	\N	62645608	\N	\N
VAULT_LLAMA_LST	solana	jag58erbc1c88laasrpsptmvokjpbnzw9p9frezhqyv	2026-03-31T23:00:00.000Z	defillama-api	5.05103042272026	\N	62585192	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-01T23:00:00.000Z	defillama-api	5.616433500676976	\N	57253014	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-02T23:00:00.000Z	defillama-api	5.616443304035101	\N	60844635	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-03T23:00:00.000Z	defillama-api	5.566911837107114	\N	59604949	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-04T23:00:00.000Z	defillama-api	5.566911837107114	\N	63050784	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-05T23:00:00.000Z	defillama-api	5.55870152467719	\N	61573880	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-06T23:00:00.000Z	defillama-api	5.558710627795449	\N	58638144	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-07T23:00:00.000Z	defillama-api	5.695275607919825	\N	57173151	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-08T23:00:00.000Z	defillama-api	5.695275607919825	\N	56821467	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-09T23:00:00.000Z	defillama-api	5.537008793865539	\N	59784166	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-10T23:00:00.000Z	defillama-api	5.537008793865539	\N	59538805	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-11T23:00:00.000Z	defillama-api	5.5209803033307026	\N	60908210	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-12T23:00:00.000Z	defillama-api	5.5209803033307026	\N	60319354	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-13T23:00:00.000Z	defillama-api	5.546053091975978	\N	62099067	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-14T23:00:00.000Z	defillama-api	5.546053091975978	\N	61656532	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-15T23:00:00.000Z	defillama-api	5.499213347093246	\N	65576215	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-16T23:00:00.000Z	defillama-api	5.499213347093246	\N	68008022	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-17T23:00:00.000Z	defillama-api	5.50901810569826	\N	73234047	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-18T23:00:00.000Z	defillama-api	5.50901810569826	\N	68942984	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-19T23:00:00.000Z	defillama-api	5.0192514368774255	\N	67857358	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-20T23:00:00.000Z	defillama-api	5.019260539995685	\N	69179468	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-21T23:00:00.000Z	defillama-api	5.511516561540475	\N	69016061	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-22T23:00:00.000Z	defillama-api	5.5115263648986	\N	66556811	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-23T23:00:00.000Z	defillama-api	5.470596644485681	\N	70172168	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-24T23:00:00.000Z	defillama-api	5.470596644485681	\N	69288024	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-25T23:00:00.000Z	defillama-api	5.478378410117557	\N	70369625	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-26T23:00:00.000Z	defillama-api	5.478369306999298	\N	66555658	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-27T23:00:00.000Z	defillama-api	5.520506941181225	\N	63519132	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-28T23:00:00.000Z	defillama-api	5.520506941181225	\N	63542078	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-29T23:00:00.000Z	defillama-api	5.49305123627164	\N	61947241	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-30T23:00:00.000Z	defillama-api	5.493041432913515	\N	63466314	\N	\N
VAULT_LLAMA_LST	solana	stke7uu3fxhsgqkvvjknkmj65lrpvrqr4blg2sjg7rh	2026-03-31T23:00:00.000Z	defillama-api	5.466184433089438	\N	63480372	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-01T23:00:00.000Z	defillama-api	5.5541037497164325	\N	103523071	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-02T23:00:00.000Z	defillama-api	5.5541037497164325	\N	109848001	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-03T23:00:00.000Z	defillama-api	5.550225121098151	\N	110528622	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-04T23:00:00.000Z	defillama-api	5.550225121098151	\N	115877236	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-05T23:00:00.000Z	defillama-api	5.538531815574288	\N	111551889	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-06T23:00:00.000Z	defillama-api	5.538531815574288	\N	106127266	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-07T23:00:00.000Z	defillama-api	5.550225121098151	\N	103806534	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-08T23:00:00.000Z	defillama-api	5.550225121098151	\N	102420757	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-09T23:00:00.000Z	defillama-api	5.541077187487531	\N	107138360	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-10T23:00:00.000Z	defillama-api	5.541077187487531	\N	106878610	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-11T23:00:00.000Z	defillama-api	5.535144755342003	\N	108714510	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-12T23:00:00.000Z	defillama-api	5.535144755342003	\N	108077754	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-13T23:00:00.000Z	defillama-api	5.512188791811923	\N	110208147	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-14T23:00:00.000Z	defillama-api	5.512188791811923	\N	109265172	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-15T23:00:00.000Z	defillama-api	5.487683897698048	\N	115923586	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-16T23:00:00.000Z	defillama-api	5.487683897698048	\N	120898698	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-17T23:00:00.000Z	defillama-api	5.464783253117389	\N	119561555	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-18T23:00:00.000Z	defillama-api	5.464783253117389	\N	113006287	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-19T23:00:00.000Z	defillama-api	5.438183241324168	\N	111569271	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-20T23:00:00.000Z	defillama-api	5.438183241324168	\N	113392453	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-21T23:00:00.000Z	defillama-api	5.424762444050657	\N	113003943	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-22T23:00:00.000Z	defillama-api	5.424762444050657	\N	108961217	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-23T23:00:00.000Z	defillama-api	5.4253779548929515	\N	115021597	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-24T23:00:00.000Z	defillama-api	5.4253779548929515	\N	113559371	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-25T23:00:00.000Z	defillama-api	5.385569318505645	\N	115489297	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-26T23:00:00.000Z	defillama-api	5.385569318505645	\N	109184698	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-27T23:00:00.000Z	defillama-api	5.392874921028579	\N	104177519	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-28T23:00:00.000Z	defillama-api	5.392874921028579	\N	104222148	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-29T23:00:00.000Z	defillama-api	5.393395899488951	\N	101000609	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-30T23:00:00.000Z	defillama-api	5.393395899488951	\N	104224857	\N	\N
VAULT_LLAMA_LST	solana	vsolxydx6akxymd9xecpvgyngq6nn66oqvb3ukgkei7	2026-03-31T23:00:00.000Z	defillama-api	5.393395899488951	\N	104244853	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-01T23:00:00.000Z	defillama-api	5.769138309474897	\N	16754420	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-02T23:00:00.000Z	defillama-api	5.769138309474897	\N	17720139	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-03T23:00:00.000Z	defillama-api	5.769138309474897	\N	17295344	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-04T23:00:00.000Z	defillama-api	5.769138309474897	\N	18541940	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-05T23:00:00.000Z	defillama-api	5.756403747270156	\N	17639630	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-06T23:00:00.000Z	defillama-api	5.756403747270156	\N	17301178	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-07T23:00:00.000Z	defillama-api	5.761954548688664	\N	16286103	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-08T23:00:00.000Z	defillama-api	5.761954548688664	\N	16051791	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-09T23:00:00.000Z	defillama-api	5.7592544237650145	\N	16931703	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-10T23:00:00.000Z	defillama-api	5.7592544237650145	\N	16859278	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-11T23:00:00.000Z	defillama-api	5.733064052293457	\N	17080049	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-12T23:00:00.000Z	defillama-api	5.733064052293457	\N	16995630	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-13T23:00:00.000Z	defillama-api	5.718794564302243	\N	17598970	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-14T23:00:00.000Z	defillama-api	5.718794564302243	\N	17238323	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-15T23:00:00.000Z	defillama-api	5.6877844418323775	\N	17930699	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-16T23:00:00.000Z	defillama-api	5.6877844418323775	\N	19026945	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-17T23:00:00.000Z	defillama-api	5.642248543580308	\N	18759483	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-18T23:00:00.000Z	defillama-api	5.642248543580308	\N	17725977	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-19T23:00:00.000Z	defillama-api	5.616821433562791	\N	17451995	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-20T23:00:00.000Z	defillama-api	5.616821433562791	\N	17727355	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-21T23:00:00.000Z	defillama-api	5.627853012413198	\N	17863665	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-22T23:00:00.000Z	defillama-api	5.627853012413198	\N	17167941	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-23T23:00:00.000Z	defillama-api	5.612652205400082	\N	18141281	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-24T23:00:00.000Z	defillama-api	5.612652205400082	\N	17896135	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-25T23:00:00.000Z	defillama-api	5.582006207660584	\N	18177192	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-26T23:00:00.000Z	defillama-api	5.582006207660584	\N	17176962	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-27T23:00:00.000Z	defillama-api	5.596909412730611	\N	16368467	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-28T23:00:00.000Z	defillama-api	5.596909412730611	\N	16309047	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-29T23:00:00.000Z	defillama-api	5.61395675227061	\N	15901680	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-30T23:00:00.000Z	defillama-api	5.61395675227061	\N	16337673	\N	\N
VAULT_LLAMA_LST	solana	bonk1yhkxeglzzwtcvrtip3gal9nceqd7ppzblxhtts	2026-03-31T23:00:00.000Z	defillama-api	5.583103483530749	\N	16331506	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-01T23:00:00.000Z	defillama-api	6.270894485282952	\N	18335614	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-02T23:00:00.000Z	defillama-api	6.270894485282952	\N	19402940	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-03T23:00:00.000Z	defillama-api	6.229259623324879	\N	18973386	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-04T23:00:00.000Z	defillama-api	6.229259623324879	\N	20077892	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-05T23:00:00.000Z	defillama-api	6.209751640895433	\N	18657474	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-06T23:00:00.000Z	defillama-api	6.209751640895433	\N	17713708	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-07T23:00:00.000Z	defillama-api	6.251403308610293	\N	17386911	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-08T23:00:00.000Z	defillama-api	6.251403308610293	\N	17131908	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-09T23:00:00.000Z	defillama-api	6.244235653340979	\N	17964049	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-10T23:00:00.000Z	defillama-api	6.244235653340979	\N	17855222	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-11T23:00:00.000Z	defillama-api	6.208698480136832	\N	18135912	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-12T23:00:00.000Z	defillama-api	6.208698480136832	\N	17861798	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-13T23:00:00.000Z	defillama-api	6.1922036298511784	\N	18247251	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-14T23:00:00.000Z	defillama-api	6.1922036298511784	\N	18065732	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-15T23:00:00.000Z	defillama-api	6.164696807431369	\N	19123721	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-16T23:00:00.000Z	defillama-api	6.164696807431369	\N	20026274	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-17T23:00:00.000Z	defillama-api	6.096696514035216	\N	19615664	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-18T23:00:00.000Z	defillama-api	6.096696514035216	\N	18705671	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-19T23:00:00.000Z	defillama-api	6.058574755485324	\N	18317153	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-20T23:00:00.000Z	defillama-api	6.058574755485324	\N	18586792	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-21T23:00:00.000Z	defillama-api	6.073078123591813	\N	18502395	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-22T23:00:00.000Z	defillama-api	6.073078123591813	\N	17828874	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-23T23:00:00.000Z	defillama-api	6.054593891846594	\N	18854408	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-24T23:00:00.000Z	defillama-api	6.054593891846594	\N	18600706	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-25T23:00:00.000Z	defillama-api	6.014017792566051	\N	18909299	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-26T23:00:00.000Z	defillama-api	6.014017792566051	\N	17906631	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-27T23:00:00.000Z	defillama-api	6.050564711657103	\N	17134630	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-28T23:00:00.000Z	defillama-api	6.050564711657103	\N	17049761	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-29T23:00:00.000Z	defillama-api	6.039306255090082	\N	16402533	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-30T23:00:00.000Z	defillama-api	6.039306255090082	\N	17007303	\N	\N
VAULT_LLAMA_LST	solana	hy1oxygrbw6pvcj4s6s2fkavrdwgwtxdfe69axt7kpt	2026-03-31T23:00:00.000Z	defillama-api	5.997698002246921	\N	16987340	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-01T23:00:00.000Z	defillama-api	5.371269720200189	\N	1164858121	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-02T23:00:00.000Z	defillama-api	5.371269720200189	\N	1213043045	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-03T23:00:00.000Z	defillama-api	5.371345346105727	\N	1193141172	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-04T23:00:00.000Z	defillama-api	5.371345346105727	\N	1278158818	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-05T23:00:00.000Z	defillama-api	5.3580673977648985	\N	1191823264	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-06T23:00:00.000Z	defillama-api	5.3580673977648985	\N	1134641307	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-07T23:00:00.000Z	defillama-api	5.370985422814556	\N	1109353178	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-08T23:00:00.000Z	defillama-api	5.370985422814556	\N	1094082739	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-09T23:00:00.000Z	defillama-api	5.370985422814556	\N	1145617864	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-10T23:00:00.000Z	defillama-api	5.370985422814556	\N	1140735966	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-11T23:00:00.000Z	defillama-api	5.353186025658374	\N	1159557616	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-12T23:00:00.000Z	defillama-api	5.353186025658374	\N	1154491410	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-13T23:00:00.000Z	defillama-api	5.335098829917229	\N	1176849153	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-14T23:00:00.000Z	defillama-api	5.335098829917229	\N	1167061999	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-15T23:00:00.000Z	defillama-api	5.327883558337021	\N	1236600651	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-16T23:00:00.000Z	defillama-api	5.327883558337021	\N	1293630261	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-17T23:00:00.000Z	defillama-api	5.325949495826876	\N	1274829891	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-18T23:00:00.000Z	defillama-api	5.325949495826876	\N	1203523041	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-19T23:00:00.000Z	defillama-api	5.252783532938565	\N	1186855436	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-20T23:00:00.000Z	defillama-api	5.252783532938565	\N	1205571449	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-21T23:00:00.000Z	defillama-api	5.186020563385796	\N	914681156	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-22T23:00:00.000Z	defillama-api	5.186020563385796	\N	882486478	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-23T23:00:00.000Z	defillama-api	5.112762168835161	\N	931402521	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-24T23:00:00.000Z	defillama-api	5.112762168835161	\N	918918597	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-25T23:00:00.000Z	defillama-api	5.04170322770392	\N	934574505	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-26T23:00:00.000Z	defillama-api	5.04170322770392	\N	883091895	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-27T23:00:00.000Z	defillama-api	5.04170322770392	\N	843056601	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-28T23:00:00.000Z	defillama-api	5.04170322770392	\N	842975224	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-29T23:00:00.000Z	defillama-api	5.020544779910097	\N	812084287	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-30T23:00:00.000Z	defillama-api	5.020544779910097	\N	843055024	\N	\N
VAULT_LLAMA_LST	solana	gekfj7sl2fvptdxjzmec46ctyxinjb6gkanb6egt6mnn	2026-03-31T23:00:00.000Z	defillama-api	5.054785809122109	\N	843345032	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-01T23:00:00.000Z	defillama-api	6.2690906673879	\N	8591982	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-02T23:00:00.000Z	defillama-api	6.2690906673879	\N	9278759	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-03T23:00:00.000Z	defillama-api	6.123055643314501	\N	9061238	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-04T23:00:00.000Z	defillama-api	6.123055643314501	\N	9619995	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-05T23:00:00.000Z	defillama-api	6.131276459342416	\N	6324426	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-06T23:00:00.000Z	defillama-api	6.131276459342416	\N	6028410	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-07T23:00:00.000Z	defillama-api	6.3315961785548325	\N	5866834	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-08T23:00:00.000Z	defillama-api	6.3315961785548325	\N	5771087	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-09T23:00:00.000Z	defillama-api	6.226967038003295	\N	5813049	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-10T23:00:00.000Z	defillama-api	6.226967038003295	\N	5870249	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-11T23:00:00.000Z	defillama-api	6.067666669906657	\N	5997569	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-12T23:00:00.000Z	defillama-api	6.067666669906657	\N	5879394	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-13T23:00:00.000Z	defillama-api	5.951944329396497	\N	6018582	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-14T23:00:00.000Z	defillama-api	5.951944329396497	\N	5913921	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-15T23:00:00.000Z	defillama-api	5.911081832010723	\N	6179529	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-16T23:00:00.000Z	defillama-api	5.911081832010723	\N	6533093	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-17T23:00:00.000Z	defillama-api	5.911081832010723	\N	6454708	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-18T23:00:00.000Z	defillama-api	5.911081832010723	\N	6132712	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-19T23:00:00.000Z	defillama-api	6.026022704830325	\N	6109059	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-20T23:00:00.000Z	defillama-api	6.026022704830325	\N	6126238	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-21T23:00:00.000Z	defillama-api	6.035653803948549	\N	6087838	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-22T23:00:00.000Z	defillama-api	6.035653803948549	\N	5852493	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-23T23:00:00.000Z	defillama-api	6.035653803948549	\N	6168158	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-24T23:00:00.000Z	defillama-api	6.035653803948549	\N	6047222	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-25T23:00:00.000Z	defillama-api	5.92268480659186	\N	6222974	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-26T23:00:00.000Z	defillama-api	5.92268480659186	\N	5834050	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-27T23:00:00.000Z	defillama-api	5.710605959308168	\N	5709302	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-28T23:00:00.000Z	defillama-api	5.710605959308168	\N	5631695	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-29T23:00:00.000Z	defillama-api	5.699800557934509	\N	5392166	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-30T23:00:00.000Z	defillama-api	5.699800557934509	\N	5615905	\N	\N
VAULT_LLAMA_LST	solana	strng7mqqc1mbjjv6vmzybeqnwvgvkkgkedecvtktwa	2026-03-31T23:00:00.000Z	defillama-api	5.672393869815551	\N	5530250	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-01T23:00:00.000Z	defillama-api	5.975318336126634	\N	6476596	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-02T23:00:00.000Z	defillama-api	5.93503983878918	\N	6965127	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-03T23:00:00.000Z	defillama-api	5.911618915988015	\N	6842169	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-04T23:00:00.000Z	defillama-api	5.85952667186973	\N	7235002	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-05T23:00:00.000Z	defillama-api	6.014083615113464	\N	7076138	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-06T23:00:00.000Z	defillama-api	6.010590118421533	\N	6741412	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-07T23:00:00.000Z	defillama-api	6.035550168448367	\N	6566754	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-08T23:00:00.000Z	defillama-api	6.022124469495793	\N	6480345	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-09T23:00:00.000Z	defillama-api	6.037988403662098	\N	6862342	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-10T23:00:00.000Z	defillama-api	6.045642025398479	\N	6850611	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-11T23:00:00.000Z	defillama-api	6.052250189014785	\N	6977520	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-12T23:00:00.000Z	defillama-api	6.0631494225305005	\N	6927817	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-13T23:00:00.000Z	defillama-api	6.058302362177415	\N	7114940	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-14T23:00:00.000Z	defillama-api	6.046856241326282	\N	7075769	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-15T23:00:00.000Z	defillama-api	6.025664882258752	\N	7494772	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-16T23:00:00.000Z	defillama-api	6.032584652615469	\N	7827214	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-17T23:00:00.000Z	defillama-api	6.016484737614292	\N	7729380	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-18T23:00:00.000Z	defillama-api	5.985491420901212	\N	7362030	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-19T23:00:00.000Z	defillama-api	5.954790104212293	\N	7259766	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-20T23:00:00.000Z	defillama-api	5.912307251776383	\N	7381562	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-21T23:00:00.000Z	defillama-api	5.9121658033234326	\N	7359756	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-22T23:00:00.000Z	defillama-api	5.900712680073639	\N	7098725	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-23T23:00:00.000Z	defillama-api	5.859659017204422	\N	7560284	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-24T23:00:00.000Z	defillama-api	5.872606452328455	\N	7477143	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-25T23:00:00.000Z	defillama-api	5.856094096046149	\N	7607747	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-26T23:00:00.000Z	defillama-api	5.876689550987635	\N	7192232	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-27T23:00:00.000Z	defillama-api	5.885203767519442	\N	6864882	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-28T23:00:00.000Z	defillama-api	5.92467348781156	\N	6871839	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-29T23:00:00.000Z	defillama-api	5.91731186609934	\N	6729627	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-30T23:00:00.000Z	defillama-api	5.922788442092042	\N	6888790	\N	\N
VAULT_LLAMA_LST	solana	kyso1netpsze2nwe5vj2c64mpscih1sppmhb4xieq7b	2026-03-31T23:00:00.000Z	defillama-api	5.921393564278787	\N	6943940	\N	\N
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
