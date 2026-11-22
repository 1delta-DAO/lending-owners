-- Generated from VAULT_YEARN/8453/2024-12.ndjson (141 vault rows)
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
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-15T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-16T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-17T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-18T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-19T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-20T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-21T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-22T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-23T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-24T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-25T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-26T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-27T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-28T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-29T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-30T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2024-12-31T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-01T00:00:00.000Z	yearn-kong	0.2187136200149098	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-02T00:00:00.000Z	yearn-kong	0.06769778977400165	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-03T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-04T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-05T00:00:00.000Z	yearn-kong	0	\N	24.4689836508	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-06T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-07T00:00:00.000Z	yearn-kong	0.1458060456371868	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-08T00:00:00.000Z	yearn-kong	0.3280581758247081	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-09T00:00:00.000Z	yearn-kong	0.5103019031338363	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-10T00:00:00.000Z	yearn-kong	0.6873288434405822	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-11T00:00:00.000Z	yearn-kong	0.8695711702699782	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-12T00:00:00.000Z	yearn-kong	1.0465855062591345	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-13T00:00:00.000Z	yearn-kong	1.228792821095226	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-14T00:00:00.000Z	yearn-kong	1.2652213996489081	\N	24.4858	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-15T00:00:00.000Z	yearn-kong	1.2599625982545604	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-16T00:00:00.000Z	yearn-kong	1.2599268860213897	\N	24.4820291868	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-17T00:00:00.000Z	yearn-kong	1.1141096365463454	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-18T00:00:00.000Z	yearn-kong	1.2025856438668825	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-19T00:00:00.000Z	yearn-kong	1.4107494500592566	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-20T00:00:00.000Z	yearn-kong	1.6136740615735334	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-21T00:00:00.000Z	yearn-kong	1.8217839492962185	\N	24.498672705999997	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-22T00:00:00.000Z	yearn-kong	2.029891736299305	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-23T00:00:00.000Z	yearn-kong	2.2379259981164523	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-24T00:00:00.000Z	yearn-kong	2.591778909888376	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-25T00:00:00.000Z	yearn-kong	2.7060510536358606	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-26T00:00:00.000Z	yearn-kong	2.7110983825906487	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-27T00:00:00.000Z	yearn-kong	2.7108897111105534	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-28T00:00:00.000Z	yearn-kong	2.4402175927917824	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-29T00:00:00.000Z	yearn-kong	2.13312389831799	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-30T00:00:00.000Z	yearn-kong	1.9873059486030797	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-12-31T00:00:00.000Z	yearn-kong	1.8467369969243919	\N	24.491118274799998	\N	\N
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-01T00:00:00.000Z	yearn-kong	1.90980410046393	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-02T00:00:00.000Z	yearn-kong	0.5677180709540153	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-03T00:00:00.000Z	yearn-kong	0	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-04T00:00:00.000Z	yearn-kong	0	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-05T00:00:00.000Z	yearn-kong	0	\N	0	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-06T00:00:00.000Z	yearn-kong	0	\N	3.6574613655	1.011037	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-07T00:00:00.000Z	yearn-kong	2.373407707167985	\N	0	1.011497	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-08T00:00:00.000Z	yearn-kong	5.240695292130226	\N	0	1.012053	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-09T00:00:00.000Z	yearn-kong	8.111534493693284	\N	0	1.01261	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-10T00:00:00.000Z	yearn-kong	10.980738635169018	\N	0	1.013167	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-11T00:00:00.000Z	yearn-kong	13.853750681036558	\N	0	1.013725	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-12T00:00:00.000Z	yearn-kong	16.724925297495474	\N	0	1.014283	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-13T00:00:00.000Z	yearn-kong	19.59955979913275	\N	0	1.014842	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-14T00:00:00.000Z	yearn-kong	20.10487109274095	\N	3.684	1.015402	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-15T00:00:00.000Z	yearn-kong	20.119392667083957	\N	0	1.015963	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-16T00:00:00.000Z	yearn-kong	20.123879103906006	\N	3.683432664	1.016523	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-17T00:00:00.000Z	yearn-kong	17.752158974815302	\N	0	1.01662	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-18T00:00:00.000Z	yearn-kong	16.142065239677095	\N	0	1.016866	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-19T00:00:00.000Z	yearn-kong	15.086901094818472	\N	0	1.01722	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-20T00:00:00.000Z	yearn-kong	14.027450081499637	\N	0	1.017575	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-21T00:00:00.000Z	yearn-kong	12.96899550951025	\N	0	1.017929	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-22T00:00:00.000Z	yearn-kong	11.90649425133472	\N	0	1.018283	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-23T00:00:00.000Z	yearn-kong	10.844671525589433	\N	0	1.018638	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-24T00:00:00.000Z	yearn-kong	12.170229093300122	\N	0	1.018994	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-25T00:00:00.000Z	yearn-kong	12.725004630809167	\N	0	1.019349	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-26T00:00:00.000Z	yearn-kong	12.731025993417688	\N	3.6928524041000004	1.019705	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-27T00:00:00.000Z	yearn-kong	12.726547959474033	\N	0	1.02006	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-28T00:00:00.000Z	yearn-kong	11.464171634401055	\N	0	1.020168	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-29T00:00:00.000Z	yearn-kong	10.130576713507367	\N	0	1.020263	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-30T00:00:00.000Z	yearn-kong	9.845768152771939	\N	0	1.020563	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-12-31T00:00:00.000Z	yearn-kong	9.566394853877114	\N	0	1.020863	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-01T00:00:00.000Z	yearn-kong	0.002884288008431213	\N	176.6119698	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-02T00:00:00.000Z	yearn-kong	0.0008535923967656345	\N	173.169752	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-03T00:00:00.000Z	yearn-kong	0	\N	172.315332	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-04T00:00:00.000Z	yearn-kong	0	\N	182.70912044	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-05T00:00:00.000Z	yearn-kong	0	\N	180.39632688	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-06T00:00:00.000Z	yearn-kong	0	\N	190.73767916	1.0010798608990883	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-07T00:00:00.000Z	yearn-kong	0.0023962208217653824	\N	190.40503132	1.0010803206015135	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-08T00:00:00.000Z	yearn-kong	0.005287511228857511	\N	190.725108	1.0010808755441627	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-09T00:00:00.000Z	yearn-kong	0.008176700916351365	\N	176.915872	1.0010814296658403	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-10T00:00:00.000Z	yearn-kong	0.011067291083577402	\N	172.76132496	1.001081984352973	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-11T00:00:00.000Z	yearn-kong	0.013957881250803439	\N	182.49093156	1.0010825388481606	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-12T00:00:00.000Z	yearn-kong	0.016848471418029476	\N	184.62501568	1.001083093446661	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-13T00:00:00.000Z	yearn-kong	0.019739061585255513	\N	186.00414	1.0010836481741496	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-14T00:00:00.000Z	yearn-kong	0.020233430930716167	\N	184.058252	1.0010842027225297	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-15T00:00:00.000Z	yearn-kong	0.020233430930716167	\N	188.24759939999998	1.001084757297199	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-16T00:00:00.000Z	yearn-kong	0.020233430930716167	\N	189.90416032	1.0010853117697835	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-17T00:00:00.000Z	yearn-kong	0.017837210108950785	\N	185.164595	1.0010854066253259	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-18T00:00:00.000Z	yearn-kong	0.01754240912532623	\N	172.63546104	1.0010859047797973	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-19T00:00:00.000Z	yearn-kong	0.018373593846376934	\N	163.15280800000002	1.0010866185833422	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-20T00:00:00.000Z	yearn-kong	0.01920477856742764	\N	165.162956	1.0010873327680636	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-21T00:00:00.000Z	yearn-kong	0.020035963288478342	\N	158.915456	1.001088046672817	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-22T00:00:00.000Z	yearn-kong	0.020867148009529046	\N	155.92522875999998	1.0010887607273464	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-23T00:00:00.000Z	yearn-kong	0.021696932250847567	\N	162.48529416	1.0010894744853782	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-24T00:00:00.000Z	yearn-kong	0.024925038033529745	\N	166.441016	1.0010901887898753	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-25T00:00:00.000Z	yearn-kong	0.026051023738205004	\N	166.253472	1.0010909028639896	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-26T00:00:00.000Z	yearn-kong	0.026051023738205004	\N	158.60796	1.0010916169060649	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-27T00:00:00.000Z	yearn-kong	0.026051723978071095	\N	158.503716	1.0010923310979178	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-28T00:00:00.000Z	yearn-kong	0.023455934794469613	\N	161.8281	1.0010925470135106	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-29T00:00:00.000Z	yearn-kong	0.020421795454694802	\N	159.47274252	1.001092679379499	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-30T00:00:00.000Z	yearn-kong	0.01887286487090023	\N	159.844132	1.0010930959742064	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-12-31T00:00:00.000Z	yearn-kong	0.017323934287105658	\N	158.805262	1.0010935124342026	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-01T00:00:00.000Z	yearn-kong	0.5489432396643679	\N	1.11310065	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-02T00:00:00.000Z	yearn-kong	0.1624934618860152	\N	1.09197162	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-03T00:00:00.000Z	yearn-kong	0	\N	1.0860210000000001	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-04T00:00:00.000Z	yearn-kong	0	\N	1.15152807	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-05T00:00:00.000Z	yearn-kong	0	\N	1.1369516400000002	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-06T00:00:00.000Z	yearn-kong	0	\N	1.2049530000000002	1.0038596940603606	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-07T00:00:00.000Z	yearn-kong	0.41182787100524365	\N	1.20003171	1.0039389435871005	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-08T00:00:00.000Z	yearn-kong	0.9089736675349513	\N	1.202049	1.0040346284458272	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-09T00:00:00.000Z	yearn-kong	1.4056692098307622	\N	1.115016	1.004130174346378	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-10T00:00:00.000Z	yearn-kong	1.902816406840202	\N	1.08883188	1.004225855801584	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-11T00:00:00.000Z	yearn-kong	2.3999138868191494	\N	1.15015293	1.004321528914085	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-12T00:00:00.000Z	yearn-kong	2.8970491797508657	\N	1.16360304	1.0044172269039942	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-13T00:00:00.000Z	yearn-kong	3.3942713024259774	\N	1.172295	1.0045129542118496	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-14T00:00:00.000Z	yearn-kong	3.4795990313085667	\N	1.1618190000000002	1.0046086909035412	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-15T00:00:00.000Z	yearn-kong	3.479930244765228	\N	1.18643445	1.0047044391958255	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-16T00:00:00.000Z	yearn-kong	3.4802621584617555	\N	1.2083789999999999	1.0048001813538807	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-17T00:00:00.000Z	yearn-kong	3.0682424217332027	\N	1.16700375	1.004816569902321	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-18T00:00:00.000Z	yearn-kong	2.773462445304631	\N	1.08588231	1.0048555338211467	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-19T00:00:00.000Z	yearn-kong	2.5662901787626424	\N	1.0251615	1.0049113507998615	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-20T00:00:00.000Z	yearn-kong	2.3589694613690426	\N	1.040943	1.0049671972456786	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-21T00:00:00.000Z	yearn-kong	2.151673952610622	\N	1.001568	1.0050230279233139	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-22T00:00:00.000Z	yearn-kong	1.9443182232237177	\N	0.9827220300000001	1.0050788764400913	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-23T00:00:00.000Z	yearn-kong	1.736975098154403	\N	1.02406698	1.0051347078905952	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-24T00:00:00.000Z	yearn-kong	1.9417980599456541	\N	1.0489979999999999	1.00519058821717	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-25T00:00:00.000Z	yearn-kong	2.0294799952580433	\N	1.047816	1.005246450185413	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-26T00:00:00.000Z	yearn-kong	2.0296396499475122	\N	0.995943	1.005302328710147	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-27T00:00:00.000Z	yearn-kong	2.029752388565953	\N	0.998973	1.005358218621652	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-28T00:00:00.000Z	yearn-kong	1.8274474893331671	\N	1.01980953	1.0053750919761024	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-29T00:00:00.000Z	yearn-kong	1.6269022928838694	\N	1.0050803099999999	1.0053923432309702	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-30T00:00:00.000Z	yearn-kong	1.6188075200318508	\N	1.00803	1.0054466418395531	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-12-31T00:00:00.000Z	yearn-kong	1.6107561620515298	\N	1.0008735	1.0055009287073613	assets_per_share
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
