-- Generated from VAULT_LLAMA/42161/2026-09.ndjson (150 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-01T23:00:00.000Z	defillama-api	4.77575352704207	\N	5028254	1.08106	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-02T23:00:00.000Z	defillama-api	4.783866506130607	\N	5028831	1.08118	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-03T23:00:00.000Z	defillama-api	4.677327111224372	\N	5049479	1.0813	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-04T23:00:00.000Z	defillama-api	4.710226480852953	\N	5030108	1.08145	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-05T23:00:00.000Z	defillama-api	4.6696923959643755	\N	5030528	1.08157	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-06T23:00:00.000Z	defillama-api	4.665817968785291	\N	5023341	1.08172	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-07T23:00:00.000Z	defillama-api	4.631749198580337	\N	5023921	1.08184	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-08T23:00:00.000Z	defillama-api	4.6236621283668455	\N	5024488	1.08197	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-09T23:00:00.000Z	defillama-api	4.628474176726627	\N	5025000	1.08211	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-10T23:00:00.000Z	defillama-api	4.577103879910283	\N	5025565	1.08223	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-11T23:00:00.000Z	defillama-api	4.6057002755617305	\N	5026252	1.08238	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-12T23:00:00.000Z	defillama-api	4.605108572874883	\N	5026907	1.08252	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-13T23:00:00.000Z	defillama-api	4.594870365792758	\N	5027469	1.08264	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-14T23:00:00.000Z	defillama-api	4.575881261104087	\N	5028142	1.08279	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-15T23:00:00.000Z	defillama-api	4.57431482452364	\N	5028599	1.08291	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-16T23:00:00.000Z	defillama-api	4.609252592402413	\N	5029421	1.08308	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-17T23:00:00.000Z	defillama-api	4.630212172074266	\N	5030155	1.08324	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-18T23:00:00.000Z	defillama-api	4.638173899351727	\N	5030912	1.0834	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-19T23:00:00.000Z	defillama-api	4.609415048051346	\N	5031770	1.08356	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-20T23:00:00.000Z	defillama-api	4.645486504273322	\N	5032499	1.08372	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-21T23:00:00.000Z	defillama-api	4.651453248172288	\N	5030050	1.08384	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-22T23:00:00.000Z	defillama-api	4.539631943956124	\N	5031793	1.08397	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-23T23:00:00.000Z	defillama-api	4.590935017745323	\N	5032429	1.08411	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-24T23:00:00.000Z	defillama-api	4.630231078550651	\N	5033158	1.08427	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-25T23:00:00.000Z	defillama-api	4.624263634411818	\N	5033794	1.0844	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-26T23:00:00.000Z	defillama-api	4.62368103484323	\N	5034439	1.08454	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-27T23:00:00.000Z	defillama-api	4.6306988387812	\N	5035593	1.08467	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-28T23:00:00.000Z	defillama-api	4.418787348825504	\N	5035398	1.08472	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-29T23:00:00.000Z	defillama-api	4.530533727375996	\N	5035931	1.08488	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-09-30T23:00:00.000Z	defillama-api	4.50731727461573	\N	5036533	1.085	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-01T23:00:00.000Z	defillama-api	3.0414939590883705	\N	45411	1.01293	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-02T23:00:00.000Z	defillama-api	3.084990758850381	\N	45405	1.01303	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-03T23:00:00.000Z	defillama-api	3.1207639128894016	\N	45418	1.01313	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-04T23:00:00.000Z	defillama-api	3.159120251794434	\N	45423	1.01323	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-05T23:00:00.000Z	defillama-api	3.187175362029393	\N	45418	1.01332	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-06T22:00:00.000Z	defillama-api	3.207514529179889	\N	45420	1.0134	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-07T23:00:00.000Z	defillama-api	3.214961580155773	\N	45423	1.01349	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-08T23:00:00.000Z	defillama-api	3.2121151051001107	\N	45419	1.01357	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-09T23:00:00.000Z	defillama-api	3.2092679298045823	\N	45408	1.01366	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-10T23:00:00.000Z	defillama-api	3.2167142805406	\N	45412	1.01375	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-11T23:00:00.000Z	defillama-api	3.2164432877124227	\N	45417	1.01384	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-12T23:00:00.000Z	defillama-api	3.23416285752387	\N	45423	1.01393	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-13T23:00:00.000Z	defillama-api	3.254453708123606	\N	45423	1.01402	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-14T23:00:00.000Z	defillama-api	3.2670076084428956	\N	45433	1.01412	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-15T23:00:00.000Z	defillama-api	3.2718854793500896	\N	45429	1.01421	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-16T23:00:00.000Z	defillama-api	3.3049788154215776	\N	45436	1.01432	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-17T23:00:00.000Z	defillama-api	3.30465950604264	\N	45438	1.01442	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-18T23:00:00.000Z	defillama-api	3.319770682352896	\N	45450	1.01452	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-19T23:00:00.000Z	defillama-api	3.3657288252442186	\N	45440	1.01463	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-20T23:00:00.000Z	defillama-api	3.4193966090612093	\N	41453	1.01473	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-21T23:00:00.000Z	defillama-api	3.4602079889367587	\N	41464	1.01484	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-22T23:00:00.000Z	defillama-api	3.4984445868246894	\N	41464	1.01494	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-23T23:00:00.000Z	defillama-api	3.541820245089866	\N	41467	1.01504	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-24T23:00:00.000Z	defillama-api	3.615997354344813	\N	38301	1.01515	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-25T23:00:00.000Z	defillama-api	3.6516388632890084	\N	36486	1.01526	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-26T23:00:00.000Z	defillama-api	3.6204823906871297	\N	36261	1.01534	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-27T23:00:00.000Z	defillama-api	3.5867693423341507	\N	36254	1.01542	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-28T23:00:00.000Z	defillama-api	3.545343151856173	\N	36257	1.0155	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-29T23:00:00.000Z	defillama-api	3.5399092904953022	\N	36260	1.01558	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-09-30T23:00:00.000Z	defillama-api	3.4702151168630735	\N	36257	1.01567	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-01T23:00:00.000Z	defillama-api	1.91922442738246	\N	272637	1.00841	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-02T23:00:00.000Z	defillama-api	1.9446291297242624	\N	269102	1.00845	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-03T23:00:00.000Z	defillama-api	1.9290536943827874	\N	282195	1.00849	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-04T23:00:00.000Z	defillama-api	1.849353793303976	\N	277301	1.00855	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-05T23:00:00.000Z	defillama-api	1.864332624279541	\N	280248	1.00861	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-06T22:00:00.000Z	defillama-api	1.8884852977407718	\N	283886	1.00866	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-07T23:00:00.000Z	defillama-api	1.9156735110215095	\N	280388	1.00872	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-08T23:00:00.000Z	defillama-api	1.9349777236499222	\N	280667	1.00878	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-09T23:00:00.000Z	defillama-api	1.956103260170039	\N	277600	1.00883	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-10T23:00:00.000Z	defillama-api	2.0049456910697927	\N	276549	1.00888	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-11T23:00:00.000Z	defillama-api	1.9490322380022462	\N	283881	1.00893	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-12T23:00:00.000Z	defillama-api	1.9294262219915481	\N	284932	1.00899	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-13T23:00:00.000Z	defillama-api	1.8987200036235663	\N	280045	1.00904	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-14T23:00:00.000Z	defillama-api	1.8574226572809494	\N	286424	1.00907	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-15T23:00:00.000Z	defillama-api	1.8293549427284006	\N	270894	1.00912	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-16T23:00:00.000Z	defillama-api	1.8188485437775626	\N	270207	1.00915	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-17T23:00:00.000Z	defillama-api	1.8011905950743312	\N	276027	1.00919	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-18T23:00:00.000Z	defillama-api	1.7517963751600973	\N	296252	1.00923	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-19T23:00:00.000Z	defillama-api	1.7231089483260575	\N	297291	1.00928	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-20T23:00:00.000Z	defillama-api	1.6681975385068881	\N	298512	1.00931	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-21T23:00:00.000Z	defillama-api	1.6432444908787147	\N	314637	1.00936	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-22T23:00:00.000Z	defillama-api	1.700302836127321	\N	312140	1.00944	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-23T23:00:00.000Z	defillama-api	1.7484842405934842	\N	304691	1.00951	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-24T23:00:00.000Z	defillama-api	1.7731662953934801	\N	303880	1.00957	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-25T23:00:00.000Z	defillama-api	1.7768796674033638	\N	301296	1.00962	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-26T23:00:00.000Z	defillama-api	1.7427751849652395	\N	300655	1.00967	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-27T23:00:00.000Z	defillama-api	1.7534860539569763	\N	298811	1.00971	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-28T23:00:00.000Z	defillama-api	1.7743055856556111	\N	300500	1.00976	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-29T23:00:00.000Z	defillama-api	1.790965692549662	\N	299859	1.00981	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-09-30T23:00:00.000Z	defillama-api	1.8037247631497166	\N	300717	1.00985	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-01T23:00:00.000Z	defillama-api	3.989183188579659	\N	239478	1.06183	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-02T23:00:00.000Z	defillama-api	3.9735482328495664	\N	239677	1.06194	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-03T23:00:00.000Z	defillama-api	3.9628996852059117	\N	239421	1.06208	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-04T23:00:00.000Z	defillama-api	4.352681204267128	\N	236960	1.06221	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-05T23:00:00.000Z	defillama-api	4.128790010682337	\N	235192	1.06234	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-06T23:00:00.000Z	defillama-api	3.944741765238291	\N	233254	1.06245	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-07T23:00:00.000Z	defillama-api	3.9799869384182784	\N	232854	1.06257	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-08T23:00:00.000Z	defillama-api	3.9855608477523674	\N	232836	1.06268	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-09T23:00:00.000Z	defillama-api	3.8922980007072283	\N	234323	1.06278	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-10T23:00:00.000Z	defillama-api	4.859681476432343	\N	234063	1.06292	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-11T23:00:00.000Z	defillama-api	4.120527880502323	\N	236104	1.06304	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-12T23:00:00.000Z	defillama-api	4.326061585757657	\N	235343	1.06316	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-13T23:00:00.000Z	defillama-api	4.116209501248136	\N	235829	1.06328	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-14T23:00:00.000Z	defillama-api	4.29071767875655	\N	233746	1.06341	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-15T23:00:00.000Z	defillama-api	4.110547361690919	\N	230232	1.06352	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-16T23:00:00.000Z	defillama-api	4.103925193277291	\N	229715	1.06364	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-17T23:00:00.000Z	defillama-api	4.103445528969019	\N	229475	1.06376	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-18T23:00:00.000Z	defillama-api	4.171375798378563	\N	227337	1.06388	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-19T23:00:00.000Z	defillama-api	4.185378494980796	\N	227121	1.064	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-20T23:00:00.000Z	defillama-api	4.170416469762017	\N	227052	1.06413	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-21T23:00:00.000Z	defillama-api	3.828181237608419	\N	227116	1.06424	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-22T23:00:00.000Z	defillama-api	4.629753514961976	\N	227600	1.06437	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-23T23:00:00.000Z	defillama-api	4.271460382199166	\N	227528	1.0645	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-24T23:00:00.000Z	defillama-api	4.251528054410869	\N	227404	1.06462	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-25T23:00:00.000Z	defillama-api	4.099702046644893	\N	226027	1.06474	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-26T23:00:00.000Z	defillama-api	4.113426748020288	\N	222504	1.06486	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-27T23:00:00.000Z	defillama-api	4.167059519843974	\N	222447	1.06498	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-28T23:00:00.000Z	defillama-api	4.283820316075548	\N	222485	1.06511	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-29T23:00:00.000Z	defillama-api	4.3026924807065825	\N	222316	1.06524	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-09-30T22:00:00.000Z	defillama-api	4.280849898563588	\N	224449	1.06536	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-01T23:00:00.000Z	defillama-api	6.461739258867283	\N	299771	1.01324	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-02T23:00:00.000Z	defillama-api	5.759556927387166	\N	303920	1.01339	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-03T23:00:00.000Z	defillama-api	5.641993656269051	\N	304999	1.01356	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-04T23:00:00.000Z	defillama-api	5.868080101834039	\N	304746	1.01371	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-05T23:00:00.000Z	defillama-api	6.09712926227246	\N	311850	1.01387	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-06T23:00:00.000Z	defillama-api	5.728153270112557	\N	317828	1.01404	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-07T23:00:00.000Z	defillama-api	5.6322106050998855	\N	318385	1.01419	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-08T23:00:00.000Z	defillama-api	5.43711327480878	\N	305393	1.01433	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-09T23:00:00.000Z	defillama-api	5.437529917529105	\N	306276	1.01449	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-10T23:00:00.000Z	defillama-api	6.704069868845863	\N	306776	1.01468	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-11T23:00:00.000Z	defillama-api	7.5533172772423995	\N	310540	1.01489	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-12T23:00:00.000Z	defillama-api	6.970048979582089	\N	314112	1.01509	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-13T23:00:00.000Z	defillama-api	6.34197723456964	\N	316430	1.01526	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-14T23:00:00.000Z	defillama-api	6.039306255090082	\N	315988	1.01543	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-15T23:00:00.000Z	defillama-api	6.685271929640635	\N	316079	1.01561	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-16T23:00:00.000Z	defillama-api	6.625111521785243	\N	310594	1.0158	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-17T23:00:00.000Z	defillama-api	6.516488913277385	\N	312501	1.01598	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-18T23:00:00.000Z	defillama-api	6.681623679938298	\N	311437	1.01616	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-19T23:00:00.000Z	defillama-api	6.608545247033248	\N	309337	1.01635	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-20T23:00:00.000Z	defillama-api	6.584485705474208	\N	308369	1.01653	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-21T23:00:00.000Z	defillama-api	5.796225688214918	\N	304072	1.0167	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-22T23:00:00.000Z	defillama-api	6.317947103084975	\N	314126	1.01687	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-23T23:00:00.000Z	defillama-api	6.9029674008902475	\N	315538	1.01706	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-24T23:00:00.000Z	defillama-api	6.973219665695751	\N	317466	1.01725	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-25T23:00:00.000Z	defillama-api	6.399962697400952	\N	326978	1.01743	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-26T23:00:00.000Z	defillama-api	6.707904382352581	\N	333533	1.01762	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-27T23:00:00.000Z	defillama-api	6.647757979294511	\N	336913	1.0178	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-28T23:00:00.000Z	defillama-api	5.7374167433010825	\N	335062	1.01796	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-29T23:00:00.000Z	defillama-api	7.1704660321358915	\N	340537	1.01816	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-30T22:00:00.000Z	defillama-api	7.420075635522494	\N	348460	1.01836	assets_per_share
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
