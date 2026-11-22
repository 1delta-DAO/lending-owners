-- Generated from VAULT_LLAMA/42161/2026-07.ndjson (98 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-01T23:00:00.000Z	defillama-api	4.674531053439068	\N	4267	1.07226	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-02T23:00:00.000Z	defillama-api	4.649152259972311	\N	4306	1.07233	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-03T23:00:00.000Z	defillama-api	4.569996445269453	\N	4306	1.07245	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-04T23:00:00.000Z	defillama-api	4.730658779905639	\N	4307	1.07266	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-05T23:00:00.000Z	defillama-api	4.343010891716403	\N	4307	1.07263	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-06T23:00:00.000Z	defillama-api	4.5417718769869	\N	4308	1.07294	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-07T23:00:00.000Z	defillama-api	4.451092915047639	\N	4308	1.07294	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-08T23:00:00.000Z	defillama-api	4.671343561568619	\N	4309	1.07326	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-09T23:00:00.000Z	defillama-api	4.711247430577714	\N	4310	1.07336	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-10T23:00:00.000Z	defillama-api	4.714958001628133	\N	4311	1.07351	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-11T23:00:00.000Z	defillama-api	4.702240945420044	\N	4211	1.07369	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-12T23:00:00.000Z	defillama-api	4.73307180648419	\N	4212	1.07386	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-13T23:00:00.000Z	defillama-api	4.580217846594792	\N	4210	1.07393	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-14T23:00:00.000Z	defillama-api	4.570445299023618	\N	4210	1.07418	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-15T23:00:00.000Z	defillama-api	4.585424129999183	\N	4210	1.07424	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-16T23:00:00.000Z	defillama-api	4.693682613776673	\N	4235	1.07441	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-17T23:00:00.000Z	defillama-api	4.648360288683762	\N	4233	1.07457	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-18T23:00:00.000Z	defillama-api	4.678252828327345	\N	4235	1.07471	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-19T23:00:00.000Z	defillama-api	4.592845272100021	\N	4236	1.07481	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-20T23:00:00.000Z	defillama-api	4.654240202839333	\N	24321	1.07498	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-21T23:00:00.000Z	defillama-api	4.626545716135411	\N	24569	1.07509	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-22T23:00:00.000Z	defillama-api	4.613979911738397	\N	29634	1.07523	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-23T23:00:00.000Z	defillama-api	4.705761751466753	\N	31024	1.0754	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-24T23:00:00.000Z	defillama-api	4.6629259781383325	\N	31021	1.07549	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-25T23:00:00.000Z	defillama-api	4.741588823975462	\N	26373	1.07567	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-26T23:00:00.000Z	defillama-api	4.712706730458649	\N	26777	1.07581	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-27T23:00:00.000Z	defillama-api	4.595013214725441	\N	26778	1.07586	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-28T23:00:00.000Z	defillama-api	4.655223339611325	\N	26782	1.07603	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-29T23:00:00.000Z	defillama-api	4.656674236613867	\N	26849	1.0762	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-30T23:00:00.000Z	defillama-api	4.6832343347347205	\N	26853	1.07635	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-07-31T23:00:00.000Z	defillama-api	4.666390764995754	\N	27165	1.07647	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-07-29T23:00:00.000Z	defillama-api	3.386949594386124	\N	31674	1.00981	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-07-30T23:00:00.000Z	defillama-api	3.3995546122156384	\N	31672	1.00991	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-07-31T23:00:00.000Z	defillama-api	3.4276391325249733	\N	31671	1.01001	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-07-29T23:00:00.000Z	defillama-api	2.8609420112957196	\N	205668	1.00697	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-07-30T23:00:00.000Z	defillama-api	2.5989724740327347	\N	208119	1.00701	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-07-31T23:00:00.000Z	defillama-api	2.4957165038586027	\N	201018	1.00705	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-01T23:00:00.000Z	defillama-api	3.958862802377894	\N	556196	1.05422	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-02T23:00:00.000Z	defillama-api	3.9525669457418644	\N	534720	1.05442	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-03T23:00:00.000Z	defillama-api	3.9283981667637136	\N	535990	1.05456	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-04T23:00:00.000Z	defillama-api	3.9277343393706587	\N	536172	1.05459	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-05T23:00:00.000Z	defillama-api	3.9190135520783542	\N	537531	1.05468	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-06T23:00:00.000Z	defillama-api	3.924301763547078	\N	537605	1.05477	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-07T23:00:00.000Z	defillama-api	3.8484867932453426	\N	532028	1.05486	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-08T23:00:00.000Z	defillama-api	3.8763206276826168	\N	532505	1.05497	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-09T23:00:00.000Z	defillama-api	3.9726449234223082	\N	469458	1.0551	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-10T23:00:00.000Z	defillama-api	4.101582890925215	\N	468493	1.05521	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-11T23:00:00.000Z	defillama-api	3.990711111967471	\N	469219	1.05533	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-12T23:00:00.000Z	defillama-api	3.9803237537938685	\N	468963	1.05544	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-13T23:00:00.000Z	defillama-api	4.035718329120641	\N	471961	1.05558	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-14T23:00:00.000Z	defillama-api	4.216876684637327	\N	314213	1.05569	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-15T23:00:00.000Z	defillama-api	4.105345279725725	\N	319077	1.05582	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-16T23:00:00.000Z	defillama-api	4.021406826737461	\N	319530	1.05594	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-17T23:00:00.000Z	defillama-api	3.9694063140416347	\N	318804	1.05606	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-18T23:00:00.000Z	defillama-api	3.9662538341644904	\N	316506	1.05618	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-19T23:00:00.000Z	defillama-api	3.958641526580209	\N	276504	1.0563	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-20T23:00:00.000Z	defillama-api	3.968743186888446	\N	276736	1.05642	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-21T23:00:00.000Z	defillama-api	4.040376324709882	\N	278434	1.05658	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-22T23:00:00.000Z	defillama-api	4.223146632398311	\N	283067	1.05678	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-23T23:00:00.000Z	defillama-api	4.204661700413226	\N	283321	1.05694	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-24T23:00:00.000Z	defillama-api	4.067926562001389	\N	270627	1.05705	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-25T23:00:00.000Z	defillama-api	4.325995062970378	\N	266250	1.0572	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-26T23:00:00.000Z	defillama-api	4.249524668153981	\N	264255	1.05733	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-27T23:00:00.000Z	defillama-api	4.417878437479317	\N	258514	1.05744	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-28T23:00:00.000Z	defillama-api	4.136302884205634	\N	257179	1.05757	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-29T23:00:00.000Z	defillama-api	4.636837841687225	\N	250920	1.05771	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-30T23:00:00.000Z	defillama-api	4.478147382513953	\N	250054	1.05785	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-07-31T23:00:00.000Z	defillama-api	4.0867532110411275	\N	251377	1.05797	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-02T23:00:00.000Z	defillama-api	6.378113813099162	\N	26882	1.0029	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-03T23:00:00.000Z	defillama-api	6.624559732770763	\N	26892	1.00311	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-04T23:00:00.000Z	defillama-api	7.362242124742124	\N	26896	1.00331	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-05T23:00:00.000Z	defillama-api	6.458429925260134	\N	26901	1.00349	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-06T23:00:00.000Z	defillama-api	6.0093653988957385	\N	27011	1.00365	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-07T23:00:00.000Z	defillama-api	6.1096698580342945	\N	27331	1.00382	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-08T23:00:00.000Z	defillama-api	7.491635948397857	\N	27335	1.00399	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-09T23:00:00.000Z	defillama-api	7.323113421264793	\N	28456	1.00418	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-10T23:00:00.000Z	defillama-api	6.678107075330786	\N	28462	1.00435	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-11T23:00:00.000Z	defillama-api	6.7700891836608434	\N	28467	1.00452	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-12T23:00:00.000Z	defillama-api	6.5236180553540635	\N	28470	1.00468	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-13T23:00:00.000Z	defillama-api	6.947074109575624	\N	36018	1.00484	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-14T23:00:00.000Z	defillama-api	6.657478709115594	\N	36024	1.005	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-15T23:00:00.000Z	defillama-api	7.257979209640553	\N	36029	1.00517	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-16T23:00:00.000Z	defillama-api	6.752107023899612	\N	35998	1.00533	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-17T23:00:00.000Z	defillama-api	6.970869660705148	\N	36005	1.00549	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-18T23:00:00.000Z	defillama-api	5.93352241899936	\N	36117	1.00564	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-19T23:00:00.000Z	defillama-api	5.825098678613472	\N	36119	1.00578	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-20T23:00:00.000Z	defillama-api	6.264910935627199	\N	36130	1.00593	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-21T23:00:00.000Z	defillama-api	6.3364208312322035	\N	36207	1.00608	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-22T23:00:00.000Z	defillama-api	5.766730884815274	\N	36728	1.00623	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-23T23:00:00.000Z	defillama-api	6.4868778700599705	\N	38187	1.00638	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-24T23:00:00.000Z	defillama-api	6.234126290394215	\N	58604	1.00649	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-25T23:00:00.000Z	defillama-api	6.0070868183714765	\N	68789	1.00663	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-26T23:00:00.000Z	defillama-api	6.024064133924867	\N	70386	1.00676	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-27T23:00:00.000Z	defillama-api	6.534644732525408	\N	85317	1.00688	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-28T23:00:00.000Z	defillama-api	6.576929417079214	\N	89643	1.00709	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-29T23:00:00.000Z	defillama-api	7.602448907206849	\N	100942	1.0074	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-30T23:00:00.000Z	defillama-api	7.853868630647298	\N	124836	1.00765	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-31T23:00:00.000Z	defillama-api	7.266971690000901	\N	138976	1.00786	assets_per_share
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
