-- Generated from VAULT_LLAMA/42161/2026-10.ndjson (88 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-01T23:00:00.000Z	defillama-api	4.502412794593624	\N	5037198	1.08515	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-02T23:00:00.000Z	defillama-api	4.5460055272172895	\N	5037964	1.08531	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-03T23:00:00.000Z	defillama-api	4.5809727051704385	\N	5038688	1.08547	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-04T23:00:00.000Z	defillama-api	4.566385308280019	\N	5039320	1.0856	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-05T23:00:00.000Z	defillama-api	4.573416416775444	\N	5039909	1.08573	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-06T23:00:00.000Z	defillama-api	4.55776745624803	\N	5040176	1.08587	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-07T23:00:00.000Z	defillama-api	4.523929765198886	\N	5040824	1.08596	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-08T23:00:00.000Z	defillama-api	4.4911893500199085	\N	5041251	1.08605	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-09T23:00:00.000Z	defillama-api	4.464807112825042	\N	5042213	1.08617	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-10T23:00:00.000Z	defillama-api	4.48902840979315	\N	5042900	1.08632	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-11T23:00:00.000Z	defillama-api	4.474456418179784	\N	5043527	1.08645	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-12T23:00:00.000Z	defillama-api	4.451312790365591	\N	5044084	1.08657	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-13T23:00:00.000Z	defillama-api	4.457271131386165	\N	5044674	1.0867	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-14T23:00:00.000Z	defillama-api	4.447018219266852	\N	5043926	1.08683	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-15T23:00:00.000Z	defillama-api	4.480930135741801	\N	5044723	1.08699	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-16T23:00:00.000Z	defillama-api	4.430794361809376	\N	5045298	1.08712	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-17T23:00:00.000Z	defillama-api	4.4118892859046355	\N	5045953	1.08726	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-18T23:00:00.000Z	defillama-api	4.38329429073292	\N	5046588	1.08739	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-19T23:00:00.000Z	defillama-api	4.388041917025021	\N	5047350	1.08756	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-20T23:00:00.000Z	defillama-api	4.33368439693993	\N	5047847	1.08767	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-21T23:00:00.000Z	defillama-api	4.366515143061633	\N	5048936	1.08782	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-22T23:00:00.000Z	defillama-api	4.3531118517847744	\N	5049230	1.08794	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-23T23:00:00.000Z	defillama-api	4.366543852896143	\N	5049710	1.08809	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-24T23:00:00.000Z	defillama-api	4.327240089452289	\N	5050505	1.08821	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-25T23:00:00.000Z	defillama-api	4.313812289780117	\N	5051085	1.08833	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-10-26T23:00:00.000Z	defillama-api	4.357315391700922	\N	5051920	1.08851	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-01T23:00:00.000Z	defillama-api	3.5006846541563164	\N	36266	1.01578	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-02T23:00:00.000Z	defillama-api	3.5054644914822575	\N	36274	1.01588	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-03T23:00:00.000Z	defillama-api	3.487126609869051	\N	36267	1.01598	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-04T23:00:00.000Z	defillama-api	3.466235653704075	\N	36266	1.01608	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-05T23:00:00.000Z	defillama-api	3.4633184544219375	\N	36270	1.01618	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-06T23:00:00.000Z	defillama-api	3.4321906916545686	\N	36273	1.01627	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-07T23:00:00.000Z	defillama-api	3.4010622286473335	\N	36268	1.01636	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-08T23:00:00.000Z	defillama-api	3.375029411145647	\N	36270	1.01647	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-09T23:00:00.000Z	defillama-api	3.420855908942144	\N	36277	1.01659	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-10T23:00:00.000Z	defillama-api	3.4872428496868224	\N	36282	1.0167	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-11T23:00:00.000Z	defillama-api	3.5664588850181644	\N	36275	1.01681	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-12T23:00:00.000Z	defillama-api	3.637956876545445	\N	36282	1.01692	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-13T23:00:00.000Z	defillama-api	3.701742426187593	\N	36291	1.01703	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-14T23:00:00.000Z	defillama-api	3.755258958193508	\N	36284	1.01713	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-15T23:00:00.000Z	defillama-api	3.783051478478683	\N	36288	1.01726	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-16T23:00:00.000Z	defillama-api	3.803163767912565	\N	36248	1.01737	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-17T23:00:00.000Z	defillama-api	3.846350361413897	\N	36256	1.01748	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-10-18T23:00:00.000Z	defillama-api	3.897212284087459	\N	36263	1.0176	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-01T23:00:00.000Z	defillama-api	1.8128481883650238	\N	302987	1.00989	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-02T23:00:00.000Z	defillama-api	1.8329583770793079	\N	299355	1.00994	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-03T23:00:00.000Z	defillama-api	1.8421378214839024	\N	301477	1.00999	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-04T23:00:00.000Z	defillama-api	1.8847957338863353	\N	306014	1.01004	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-05T23:00:00.000Z	defillama-api	1.8931853077219785	\N	304662	1.01009	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-06T23:00:00.000Z	defillama-api	1.7973308729324344	\N	302558	1.01013	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-07T23:00:00.000Z	defillama-api	1.7119128131071193	\N	288126	1.01017	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-08T23:00:00.000Z	defillama-api	1.652628405324208	\N	277283	1.01021	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-09T23:00:00.000Z	defillama-api	1.6124598456457306	\N	279140	1.01025	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-10T23:00:00.000Z	defillama-api	1.5865768794753876	\N	280845	1.01028	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-11T23:00:00.000Z	defillama-api	1.5585217692404285	\N	284196	1.01032	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-12T23:00:00.000Z	defillama-api	1.5199399530985147	\N	278079	1.01035	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-13T23:00:00.000Z	defillama-api	1.4887134565100268	\N	280841	1.01039	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-14T23:00:00.000Z	defillama-api	1.4653212435433716	\N	271321	1.01042	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-15T23:00:00.000Z	defillama-api	1.4552202834750005	\N	275443	1.01046	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-16T23:00:00.000Z	defillama-api	1.4364433514657549	\N	271890	1.0105	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-17T23:00:00.000Z	defillama-api	1.4286167704824493	\N	268504	1.01055	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-10-18T23:00:00.000Z	defillama-api	1.4203448369443095	\N	268637	1.01059	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-01T23:00:00.000Z	defillama-api	3.8712894042447488	\N	216614	1.06547	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-02T23:00:00.000Z	defillama-api	4.5742665079728795	\N	217803	1.06561	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-03T22:00:00.000Z	defillama-api	4.164181533994338	\N	216116	1.06572	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-04T23:00:00.000Z	defillama-api	4.280849898563588	\N	215987	1.06585	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-05T23:00:00.000Z	defillama-api	4.333818842994219	\N	214774	1.06598	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-06T23:00:00.000Z	defillama-api	3.937455069191742	\N	215184	1.0661	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-07T23:00:00.000Z	defillama-api	4.102293634389298	\N	215625	1.06622	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-08T23:00:00.000Z	defillama-api	4.673376357899883	\N	214855	1.06635	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-09T23:00:00.000Z	defillama-api	4.24414822646213	\N	226566	1.06648	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-10T23:00:00.000Z	defillama-api	4.378336592480991	\N	226594	1.06661	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-11T23:00:00.000Z	defillama-api	4.364839469062076	\N	226058	1.06673	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-12T23:00:00.000Z	defillama-api	4.568917375635806	\N	225497	1.06687	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-10-13T23:00:00.000Z	defillama-api	4.310450438183011	\N	229633	1.06699	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-01T23:00:00.000Z	defillama-api	6.8809385549428725	\N	354446	1.01856	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-02T23:00:00.000Z	defillama-api	7.760435625314699	\N	355669	1.01879	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-03T22:00:00.000Z	defillama-api	7.532637093277117	\N	359414	1.01898	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-04T23:00:00.000Z	defillama-api	7.091595215058533	\N	360849	1.01919	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-05T23:00:00.000Z	defillama-api	6.780256666516493	\N	367947	1.01938	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-06T23:00:00.000Z	defillama-api	6.265550254624941	\N	375815	1.01955	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-07T23:00:00.000Z	defillama-api	6.658237068890571	\N	378307	1.01974	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-08T23:00:00.000Z	defillama-api	7.097557057278436	\N	360704	1.01994	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-09T23:00:00.000Z	defillama-api	6.51255356522995	\N	387546	1.02012	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-10T23:00:00.000Z	defillama-api	7.0592658406809505	\N	392503	1.02032	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-11T23:00:00.000Z	defillama-api	6.73707567493409	\N	393246	1.02051	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-12T23:00:00.000Z	defillama-api	6.508899713608685	\N	395731	1.02069	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-13T23:00:00.000Z	defillama-api	6.793804907445633	\N	394553	1.02088	assets_per_share
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
