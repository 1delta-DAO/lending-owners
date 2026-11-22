-- Generated from VAULT_YEARN/42161/2026-10.ndjson (192 vault rows)
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
VAULT_YEARN	42161	0xc0ba9bfed28ab46da48d2b69316a3838698ef3f5	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	751.6167493785564	\N	\N
VAULT_YEARN	42161	0xc0ba9bfed28ab46da48d2b69316a3838698ef3f5	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	751.7976063858324	\N	\N
VAULT_YEARN	42161	0xc0ba9bfed28ab46da48d2b69316a3838698ef3f5	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	751.6715933488315	\N	\N
VAULT_YEARN	42161	0xc0ba9bfed28ab46da48d2b69316a3838698ef3f5	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	751.722873974721	\N	\N
VAULT_YEARN	42161	0x461ad11a76b302f13ada1296da0178722a50838e	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x461ad11a76b302f13ada1296da0178722a50838e	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x461ad11a76b302f13ada1296da0178722a50838e	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x461ad11a76b302f13ada1296da0178722a50838e	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x074943fefe3391d033a15557dfa1b6f246ce5fd0	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.1	assets_per_share
VAULT_YEARN	42161	0x074943fefe3391d033a15557dfa1b6f246ce5fd0	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.1	assets_per_share
VAULT_YEARN	42161	0x074943fefe3391d033a15557dfa1b6f246ce5fd0	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.1	assets_per_share
VAULT_YEARN	42161	0x074943fefe3391d033a15557dfa1b6f246ce5fd0	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1.506808933528996	1.202156	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1.5071715078788628	1.202156	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1.5069188823618676	1.202156	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1.5070216875551672	1.202156	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2026-10-01T00:00:00.000Z	yearn-kong	2.877462770456418	\N	23115.05280557987	1.238836	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2026-10-02T00:00:00.000Z	yearn-kong	2.8814499362539436	\N	23116.68023269583	1.238933	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2026-10-03T00:00:00.000Z	yearn-kong	2.8854329006122725	\N	23120.868520596698	1.239032	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2026-10-04T00:00:00.000Z	yearn-kong	2.880994080101118	\N	23119.919394157318	1.239129	assets_per_share
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	33.388844332337534	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	33.39119509100092	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	33.39170214616617	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	33.3903313954379	\N	\N
VAULT_YEARN	42161	0x6faf8b7ffee3306efcfc2ba9fec912b4d49834c1	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	4248.718517452617	\N	\N
VAULT_YEARN	42161	0x6faf8b7ffee3306efcfc2ba9fec912b4d49834c1	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	4249.017650653028	\N	\N
VAULT_YEARN	42161	0x6faf8b7ffee3306efcfc2ba9fec912b4d49834c1	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	4249.082173241726	\N	\N
VAULT_YEARN	42161	0x6faf8b7ffee3306efcfc2ba9fec912b4d49834c1	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	4248.907745701077	\N	\N
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	4.6319904421857645	2.328673	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	4.633105010121881	2.328673	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	4.632328429260077	2.328673	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	4.6326444565029306	2.328673	assets_per_share
VAULT_YEARN	42161	0x368d79018e525db25dba517a0b5d3cc34c87cafa	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.0843754581495593	assets_per_share
VAULT_YEARN	42161	0x368d79018e525db25dba517a0b5d3cc34c87cafa	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.0843754581495593	assets_per_share
VAULT_YEARN	42161	0x368d79018e525db25dba517a0b5d3cc34c87cafa	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.0843754581495593	assets_per_share
VAULT_YEARN	42161	0x368d79018e525db25dba517a0b5d3cc34c87cafa	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.0843754581495593	assets_per_share
VAULT_YEARN	42161	0x075472d809aa98a4686d6f04e2c2663802653f2a	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x075472d809aa98a4686d6f04e2c2663802653f2a	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x075472d809aa98a4686d6f04e2c2663802653f2a	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x075472d809aa98a4686d6f04e2c2663802653f2a	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x65073e8c0a9c26d4280a43a3ecd3cdedd36fdb89	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x65073e8c0a9c26d4280a43a3ecd3cdedd36fdb89	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x65073e8c0a9c26d4280a43a3ecd3cdedd36fdb89	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x65073e8c0a9c26d4280a43a3ecd3cdedd36fdb89	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0a5e1394ba0c23d71167233a3b4b55cb8d214279	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0a5e1394ba0c23d71167233a3b4b55cb8d214279	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0a5e1394ba0c23d71167233a3b4b55cb8d214279	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0a5e1394ba0c23d71167233a3b4b55cb8d214279	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x586fb80ddadfc01294751a7cd58625ccff4bdb2f	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x586fb80ddadfc01294751a7cd58625ccff4bdb2f	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x586fb80ddadfc01294751a7cd58625ccff4bdb2f	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x586fb80ddadfc01294751a7cd58625ccff4bdb2f	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8b5aa1688297bc2e4664a18df6ad22a70c4178b8	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8b5aa1688297bc2e4664a18df6ad22a70c4178b8	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8b5aa1688297bc2e4664a18df6ad22a70c4178b8	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8b5aa1688297bc2e4664a18df6ad22a70c4178b8	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8a64111709ce75434b9156e3878cdd5b1fbc2d13	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8a64111709ce75434b9156e3878cdd5b1fbc2d13	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8a64111709ce75434b9156e3878cdd5b1fbc2d13	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x8a64111709ce75434b9156e3878cdd5b1fbc2d13	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x15943b95af6bbe222c49f7501f39f1d2da55ccdf	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x15943b95af6bbe222c49f7501f39f1d2da55ccdf	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x15943b95af6bbe222c49f7501f39f1d2da55ccdf	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x15943b95af6bbe222c49f7501f39f1d2da55ccdf	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x4da30274267dedc73a6a7eb233fba81691f34ef7	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x4da30274267dedc73a6a7eb233fba81691f34ef7	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x4da30274267dedc73a6a7eb233fba81691f34ef7	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x4da30274267dedc73a6a7eb233fba81691f34ef7	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x92f1e6d904f21c05074952bbad51d91fd9f8730f	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.0967417732388482	assets_per_share
VAULT_YEARN	42161	0x92f1e6d904f21c05074952bbad51d91fd9f8730f	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.0967417732388482	assets_per_share
VAULT_YEARN	42161	0x92f1e6d904f21c05074952bbad51d91fd9f8730f	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.0967417732388482	assets_per_share
VAULT_YEARN	42161	0x92f1e6d904f21c05074952bbad51d91fd9f8730f	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.0967417732388482	assets_per_share
VAULT_YEARN	42161	0x0d5e99a012415e22557f6df554e97159516e6d3c	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0d5e99a012415e22557f6df554e97159516e6d3c	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0d5e99a012415e22557f6df554e97159516e6d3c	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x0d5e99a012415e22557f6df554e97159516e6d3c	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0xdfaa4001308f5ec4d06920cd0d2c649c6f930e2c	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xdfaa4001308f5ec4d06920cd0d2c649c6f930e2c	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xdfaa4001308f5ec4d06920cd0d2c649c6f930e2c	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xdfaa4001308f5ec4d06920cd0d2c649c6f930e2c	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xcb1a0a9c9cbbca82a395301267d525125cfba557	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	2.073250964511348	assets_per_share
VAULT_YEARN	42161	0xcb1a0a9c9cbbca82a395301267d525125cfba557	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	2.073250964511348	assets_per_share
VAULT_YEARN	42161	0xcb1a0a9c9cbbca82a395301267d525125cfba557	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	2.073250964511348	assets_per_share
VAULT_YEARN	42161	0xcb1a0a9c9cbbca82a395301267d525125cfba557	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	2.073250964511348	assets_per_share
VAULT_YEARN	42161	0x7deb119b92b76f78c212bc54fbbb34cea75f4d4a	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	315.1784784384359	\N	\N
VAULT_YEARN	42161	0x7deb119b92b76f78c212bc54fbbb34cea75f4d4a	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	305.6285946230929	\N	\N
VAULT_YEARN	42161	0x7deb119b92b76f78c212bc54fbbb34cea75f4d4a	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	316.0974024640654	\N	\N
VAULT_YEARN	42161	0x7deb119b92b76f78c212bc54fbbb34cea75f4d4a	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	321.59118022838237	\N	\N
VAULT_YEARN	42161	0xb119e90beb09fcf9abc92c20a8d84fe8bdfcc6e3	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	0.5577071828036076	1.0011707248504578	assets_per_share
VAULT_YEARN	42161	0xb119e90beb09fcf9abc92c20a8d84fe8bdfcc6e3	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	0.5516542315621746	1.0011707248504578	assets_per_share
VAULT_YEARN	42161	0xb119e90beb09fcf9abc92c20a8d84fe8bdfcc6e3	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	0.5554708568704627	1.0011707248504578	assets_per_share
VAULT_YEARN	42161	0xb119e90beb09fcf9abc92c20a8d84fe8bdfcc6e3	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	0.564307442841275	1.0011707248504578	assets_per_share
VAULT_YEARN	42161	0x0f2ae7531a83982f15ff1d26b165e2bf3d7566da	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	14020.474907789818	1.0043395799640915	assets_per_share
VAULT_YEARN	42161	0x0f2ae7531a83982f15ff1d26b165e2bf3d7566da	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	13857.806123725035	1.0043395799640915	assets_per_share
VAULT_YEARN	42161	0x0f2ae7531a83982f15ff1d26b165e2bf3d7566da	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	13972.114841151384	1.0043395799640915	assets_per_share
VAULT_YEARN	42161	0x0f2ae7531a83982f15ff1d26b165e2bf3d7566da	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	14164.45228802282	1.0043395799640915	assets_per_share
VAULT_YEARN	42161	0x02822b7b6de0bf087dcea626f6f19a838aedb7be	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	0.26998456733228177	1.0000040558333207	assets_per_share
VAULT_YEARN	42161	0x02822b7b6de0bf087dcea626f6f19a838aedb7be	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	0.2684676901798339	1.0000040558333207	assets_per_share
VAULT_YEARN	42161	0x02822b7b6de0bf087dcea626f6f19a838aedb7be	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	0.2735381615641179	1.0000040558333207	assets_per_share
VAULT_YEARN	42161	0x02822b7b6de0bf087dcea626f6f19a838aedb7be	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	0.27821561672020617	1.0000040558333207	assets_per_share
VAULT_YEARN	42161	0x08e3d13d50310afbea2da20a3dbd92aacfc503ac	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x08e3d13d50310afbea2da20a3dbd92aacfc503ac	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x08e3d13d50310afbea2da20a3dbd92aacfc503ac	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x08e3d13d50310afbea2da20a3dbd92aacfc503ac	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x044e75fcbf7bd3f8f4577ff317554e9c0037f145	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	2621.5189893137685	\N	\N
VAULT_YEARN	42161	0x044e75fcbf7bd3f8f4577ff317554e9c0037f145	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	2590.6856075090354	\N	\N
VAULT_YEARN	42161	0x044e75fcbf7bd3f8f4577ff317554e9c0037f145	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	2610.718822211617	\N	\N
VAULT_YEARN	42161	0x044e75fcbf7bd3f8f4577ff317554e9c0037f145	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	2648.5383837047884	\N	\N
VAULT_YEARN	42161	0x022061d81e42fcb59711193346bab758d24d6c43	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x022061d81e42fcb59711193346bab758d24d6c43	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x022061d81e42fcb59711193346bab758d24d6c43	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x022061d81e42fcb59711193346bab758d24d6c43	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x1dd930add968ff5913c3627daa1e6e6fcc9dc544	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	42150.12039401809	\N	\N
VAULT_YEARN	42161	0x1dd930add968ff5913c3627daa1e6e6fcc9dc544	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	41672.175136267004	\N	\N
VAULT_YEARN	42161	0x1dd930add968ff5913c3627daa1e6e6fcc9dc544	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	41983.04669303638	\N	\N
VAULT_YEARN	42161	0x1dd930add968ff5913c3627daa1e6e6fcc9dc544	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	42652.45942802842	\N	\N
VAULT_YEARN	42161	0x85968bf0f1f110c707fef10a59f80118f349c058	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	3.261959426553788	4.91312	assets_per_share
VAULT_YEARN	42161	0x85968bf0f1f110c707fef10a59f80118f349c058	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	3.2621297385585937	4.91312	assets_per_share
VAULT_YEARN	42161	0x85968bf0f1f110c707fef10a59f80118f349c058	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	3.2622033853464822	4.91312	assets_per_share
VAULT_YEARN	42161	0x85968bf0f1f110c707fef10a59f80118f349c058	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	3.2620762075057734	4.91312	assets_per_share
VAULT_YEARN	42161	0x9fa306b1f4a6a83fec98d8ebbabedff78c407f6b	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	22331.946991945657	\N	\N
VAULT_YEARN	42161	0x9fa306b1f4a6a83fec98d8ebbabedff78c407f6b	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	22333.112977835135	\N	\N
VAULT_YEARN	42161	0x9fa306b1f4a6a83fec98d8ebbabedff78c407f6b	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	22333.617176676442	\N	\N
VAULT_YEARN	42161	0x9fa306b1f4a6a83fec98d8ebbabedff78c407f6b	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	22332.74649484817	\N	\N
VAULT_YEARN	42161	0x34a2b066af16409648ef15d239e656edb8790ca0	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	64268.34279398179	1.0174476165048314	assets_per_share
VAULT_YEARN	42161	0x34a2b066af16409648ef15d239e656edb8790ca0	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	64272.07826937119	1.0174476165048314	assets_per_share
VAULT_YEARN	42161	0x34a2b066af16409648ef15d239e656edb8790ca0	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	64274.59936117742	1.0174476165048314	assets_per_share
VAULT_YEARN	42161	0x34a2b066af16409648ef15d239e656edb8790ca0	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	64275.05089845419	1.0174476165048314	assets_per_share
VAULT_YEARN	42161	0xc40da6a01ac36f39736731ee50fb3b1b8204e2d3	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xc40da6a01ac36f39736731ee50fb3b1b8204e2d3	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xc40da6a01ac36f39736731ee50fb3b1b8204e2d3	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0xc40da6a01ac36f39736731ee50fb3b1b8204e2d3	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0x2b0b6376083c6e1f376c7439f328436a673f333c	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	30.878389120919273	1.023294	assets_per_share
VAULT_YEARN	42161	0x2b0b6376083c6e1f376c7439f328436a673f333c	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	30.88056312969941	1.023294	assets_per_share
VAULT_YEARN	42161	0x2b0b6376083c6e1f376c7439f328436a673f333c	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	30.881032060176384	1.023294	assets_per_share
VAULT_YEARN	42161	0x2b0b6376083c6e1f376c7439f328436a673f333c	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	30.879764374060805	1.023294	assets_per_share
VAULT_YEARN	42161	0xaeba9f4a9293213e0e3ed18a2f688bddd7f5fb0c	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0xaeba9f4a9293213e0e3ed18a2f688bddd7f5fb0c	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0xaeba9f4a9293213e0e3ed18a2f688bddd7f5fb0c	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0xaeba9f4a9293213e0e3ed18a2f688bddd7f5fb0c	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x3ce71021cca8a2902764a43c60ff5f8a312245f9	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0x3ce71021cca8a2902764a43c60ff5f8a312245f9	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0x3ce71021cca8a2902764a43c60ff5f8a312245f9	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0x3ce71021cca8a2902764a43c60ff5f8a312245f9	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	42161	0x1bd173f9a1186a1abe680071e0f57d4d83c18430	2026-10-01T00:00:00.000Z	yearn-kong	1.6307998279785352	\N	76.10138743079183	1.612801	assets_per_share
VAULT_YEARN	42161	0x1bd173f9a1186a1abe680071e0f57d4d83c18430	2026-10-02T00:00:00.000Z	yearn-kong	1.6339628114536708	\N	76.10536080328578	1.612873	assets_per_share
VAULT_YEARN	42161	0x1bd173f9a1186a1abe680071e0f57d4d83c18430	2026-10-03T00:00:00.000Z	yearn-kong	1.6371243944490743	\N	76.11427898747448	1.612946	assets_per_share
VAULT_YEARN	42161	0x1bd173f9a1186a1abe680071e0f57d4d83c18430	2026-10-04T00:00:00.000Z	yearn-kong	1.6370515695030008	\N	76.11131165266873	1.613018	assets_per_share
VAULT_YEARN	42161	0xda3b69a45797dca697ff5bb2c10682f14373c063	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	538.8230611486631	\N	\N
VAULT_YEARN	42161	0xda3b69a45797dca697ff5bb2c10682f14373c063	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	538.8511939436428	\N	\N
VAULT_YEARN	42161	0xda3b69a45797dca697ff5bb2c10682f14373c063	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	538.8633592046117	\N	\N
VAULT_YEARN	42161	0xda3b69a45797dca697ff5bb2c10682f14373c063	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	538.8423514775127	\N	\N
VAULT_YEARN	42161	0x45aceaa535830c921316085e355e4a32385e53f2	2026-10-01T00:00:00.000Z	yearn-kong	2.324502954920149	\N	17.49129961517737	1.264032	assets_per_share
VAULT_YEARN	42161	0x45aceaa535830c921316085e355e4a32385e53f2	2026-10-02T00:00:00.000Z	yearn-kong	2.3119742632360385	\N	17.49910813426977	1.264108	assets_per_share
VAULT_YEARN	42161	0x45aceaa535830c921316085e355e4a32385e53f2	2026-10-03T00:00:00.000Z	yearn-kong	2.2953148565818537	\N	17.496175010059112	1.264186	assets_per_share
VAULT_YEARN	42161	0x45aceaa535830c921316085e355e4a32385e53f2	2026-10-04T00:00:00.000Z	yearn-kong	2.282786164897743	\N	17.49736863612284	1.264264	assets_per_share
VAULT_YEARN	42161	0x985c0271ad0bf0a45951b64eb6fc58010b050908	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x985c0271ad0bf0a45951b64eb6fc58010b050908	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x985c0271ad0bf0a45951b64eb6fc58010b050908	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x985c0271ad0bf0a45951b64eb6fc58010b050908	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x2d25ce68aad6ffef1585ff05bc621db1f9f2e499	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x2d25ce68aad6ffef1585ff05bc621db1f9f2e499	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x2d25ce68aad6ffef1585ff05bc621db1f9f2e499	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x2d25ce68aad6ffef1585ff05bc621db1f9f2e499	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	42161	0x127a7f610cc704be6122dfa76eb61e84c9cb0efd	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	0.1398896829669778	\N	\N
VAULT_YEARN	42161	0x127a7f610cc704be6122dfa76eb61e84c9cb0efd	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	0.1398969868261747	\N	\N
VAULT_YEARN	42161	0x127a7f610cc704be6122dfa76eb61e84c9cb0efd	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	0.13990014518115776	\N	\N
VAULT_YEARN	42161	0x127a7f610cc704be6122dfa76eb61e84c9cb0efd	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	0.1398946911379001	\N	\N
VAULT_YEARN	42161	0xa4b8873b4629c20f2167c0a2bc33b6af8699ddc1	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	44.5530141614121	1.255658	assets_per_share
VAULT_YEARN	42161	0xa4b8873b4629c20f2167c0a2bc33b6af8699ddc1	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	44.55534034398205	1.255658	assets_per_share
VAULT_YEARN	42161	0xa4b8873b4629c20f2167c0a2bc33b6af8699ddc1	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	44.55634623827891	1.255658	assets_per_share
VAULT_YEARN	42161	0xa4b8873b4629c20f2167c0a2bc33b6af8699ddc1	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	44.554609197624146	1.255658	assets_per_share
VAULT_YEARN	42161	0xe82d060687c014b280b65df24acd94a77251c784	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	588.508696773045	1.226653	assets_per_share
VAULT_YEARN	42161	0xe82d060687c014b280b65df24acd94a77251c784	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	588.5394237327911	1.226653	assets_per_share
VAULT_YEARN	42161	0xe82d060687c014b280b65df24acd94a77251c784	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	588.5527107696589	1.226653	assets_per_share
VAULT_YEARN	42161	0xe82d060687c014b280b65df24acd94a77251c784	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	588.529765890368	1.226653	assets_per_share
VAULT_YEARN	42161	0xb739ae19620f7ecb4fb84727f205453aa5bc1ad2	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1822.9477554020043	1.166487	assets_per_share
VAULT_YEARN	42161	0xb739ae19620f7ecb4fb84727f205453aa5bc1ad2	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1823.0429343562093	1.166487	assets_per_share
VAULT_YEARN	42161	0xb739ae19620f7ecb4fb84727f205453aa5bc1ad2	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1823.084091902677	1.166487	assets_per_share
VAULT_YEARN	42161	0xb739ae19620f7ecb4fb84727f205453aa5bc1ad2	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1823.0130184989519	1.166487	assets_per_share
VAULT_YEARN	42161	0x252b965400862d94bda35fecf7ee0f204a53cc36	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	2967.5375318310903	\N	\N
VAULT_YEARN	42161	0x252b965400862d94bda35fecf7ee0f204a53cc36	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	2908.2023018063023	\N	\N
VAULT_YEARN	42161	0x252b965400862d94bda35fecf7ee0f204a53cc36	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	2943.091875810718	\N	\N
VAULT_YEARN	42161	0x252b965400862d94bda35fecf7ee0f204a53cc36	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	2946.0736312510016	\N	\N
VAULT_YEARN	42161	0x2c28c7d3b482e9bceceff1a57f9ccea490e9daa1	2026-10-01T00:00:00.000Z	yearn-kong	4.032503527895415	\N	26.952071966868175	1.154625	assets_per_share
VAULT_YEARN	42161	0x2c28c7d3b482e9bceceff1a57f9ccea490e9daa1	2026-10-02T00:00:00.000Z	yearn-kong	4.208280540041187	\N	26.95836942204302	1.15479	assets_per_share
VAULT_YEARN	42161	0x2c28c7d3b482e9bceceff1a57f9ccea490e9daa1	2026-10-03T00:00:00.000Z	yearn-kong	4.40207752490096	\N	26.96277874519102	1.154961	assets_per_share
VAULT_YEARN	42161	0x2c28c7d3b482e9bceceff1a57f9ccea490e9daa1	2026-10-04T00:00:00.000Z	yearn-kong	4.568738814469953	\N	26.96557169931732	1.155122	assets_per_share
VAULT_YEARN	42161	0x2ef26b0e34ea0dba2068bc8df7c4c2a7a9620a80	2026-10-01T00:00:00.000Z	yearn-kong	4.3970477019428245	\N	13.662447431597847	1.170528	assets_per_share
VAULT_YEARN	42161	0x2ef26b0e34ea0dba2068bc8df7c4c2a7a9620a80	2026-10-02T00:00:00.000Z	yearn-kong	4.235954019549126	\N	13.667434799040022	1.170662	assets_per_share
VAULT_YEARN	42161	0x2ef26b0e34ea0dba2068bc8df7c4c2a7a9620a80	2026-10-03T00:00:00.000Z	yearn-kong	4.168548930039151	\N	13.666843493366573	1.170801	assets_per_share
VAULT_YEARN	42161	0x2ef26b0e34ea0dba2068bc8df7c4c2a7a9620a80	2026-10-04T00:00:00.000Z	yearn-kong	4.150225753463133	\N	13.669475560442011	1.170937	assets_per_share
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
