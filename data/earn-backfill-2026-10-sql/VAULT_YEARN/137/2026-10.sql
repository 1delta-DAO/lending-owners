-- Generated from VAULT_YEARN/137/2026-10.ndjson (156 vault rows)
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
VAULT_YEARN	137	0x90b2f54c6addad41b8f6c4fccd555197bc0f773b	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	49947.05100719873	\N	\N
VAULT_YEARN	137	0x90b2f54c6addad41b8f6c4fccd555197bc0f773b	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	49937.43779981312	\N	\N
VAULT_YEARN	137	0x90b2f54c6addad41b8f6c4fccd555197bc0f773b	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	49933.99464226247	\N	\N
VAULT_YEARN	137	0x90b2f54c6addad41b8f6c4fccd555197bc0f773b	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	49945.02225747663	\N	\N
VAULT_YEARN	137	0xb1403908f772e4374bb151f7c67e88761a0eb4f1	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	767.0915226234217	1.334027	assets_per_share
VAULT_YEARN	137	0xb1403908f772e4374bb151f7c67e88761a0eb4f1	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	767.1263829488988	1.334027	assets_per_share
VAULT_YEARN	137	0xb1403908f772e4374bb151f7c67e88761a0eb4f1	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	767.1491711550572	1.334027	assets_per_share
VAULT_YEARN	137	0xb1403908f772e4374bb151f7c67e88761a0eb4f1	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	767.1271671416	1.334027	assets_per_share
VAULT_YEARN	137	0x305f25377d0a39091e99b975558b1bdfc3975654	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	27518.9539524857	\N	\N
VAULT_YEARN	137	0x305f25377d0a39091e99b975558b1bdfc3975654	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	27188.2618369251	\N	\N
VAULT_YEARN	137	0x305f25377d0a39091e99b975558b1bdfc3975654	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	27405.396241707724	\N	\N
VAULT_YEARN	137	0x305f25377d0a39091e99b975558b1bdfc3975654	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	27785.887045151834	\N	\N
VAULT_YEARN	137	0x12c3ad898e8eb1c0ec0bb74f9748f36c46593f68	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	9043.417443117427	1.0273902275306441	assets_per_share
VAULT_YEARN	137	0x12c3ad898e8eb1c0ec0bb74f9748f36c46593f68	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	8958.775798626017	1.0273902275306441	assets_per_share
VAULT_YEARN	137	0x12c3ad898e8eb1c0ec0bb74f9748f36c46593f68	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	9259.196204104564	1.0273902275306441	assets_per_share
VAULT_YEARN	137	0x12c3ad898e8eb1c0ec0bb74f9748f36c46593f68	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	9269.384526827878	1.0273902275306441	assets_per_share
VAULT_YEARN	137	0x3a58df70f9204bedcd6aee2b51582eb77fe30e02	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.0250381743646937	assets_per_share
VAULT_YEARN	137	0x3a58df70f9204bedcd6aee2b51582eb77fe30e02	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.0250381743646937	assets_per_share
VAULT_YEARN	137	0x3a58df70f9204bedcd6aee2b51582eb77fe30e02	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.0250381743646937	assets_per_share
VAULT_YEARN	137	0x3a58df70f9204bedcd6aee2b51582eb77fe30e02	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.0250381743646937	assets_per_share
VAULT_YEARN	137	0x5136c2f7ab13e202ed42bc1ae82dd63475919653	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x5136c2f7ab13e202ed42bc1ae82dd63475919653	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x5136c2f7ab13e202ed42bc1ae82dd63475919653	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x5136c2f7ab13e202ed42bc1ae82dd63475919653	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x06ed7c67755344548fafe1822bee365c4208a57f	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	4367.1415440673845	1.022828462321403	assets_per_share
VAULT_YEARN	137	0x06ed7c67755344548fafe1822bee365c4208a57f	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	4366.3010092109935	1.022828462321403	assets_per_share
VAULT_YEARN	137	0x06ed7c67755344548fafe1822bee365c4208a57f	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	4365.999955273294	1.022828462321403	assets_per_share
VAULT_YEARN	137	0x06ed7c67755344548fafe1822bee365c4208a57f	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	4366.964159476799	1.022828462321403	assets_per_share
VAULT_YEARN	137	0x42908891cbc13301c910b4e71055431bf134aaa0	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x42908891cbc13301c910b4e71055431bf134aaa0	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x42908891cbc13301c910b4e71055431bf134aaa0	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x42908891cbc13301c910b4e71055431bf134aaa0	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	\N	\N
VAULT_YEARN	137	0x8bba7afd0f9b1b664c161ec31d812a8ec15f7e1a	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	0.8874117583249541	2.864126	assets_per_share
VAULT_YEARN	137	0x8bba7afd0f9b1b664c161ec31d812a8ec15f7e1a	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	0.887452086580208	2.864126	assets_per_share
VAULT_YEARN	137	0x8bba7afd0f9b1b664c161ec31d812a8ec15f7e1a	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	0.8874784491738487	2.864126	assets_per_share
VAULT_YEARN	137	0x8bba7afd0f9b1b664c161ec31d812a8ec15f7e1a	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	0.8874529937755078	2.864126	assets_per_share
VAULT_YEARN	137	0x3bd8c987286d8ad00c05fdb2ae3e8c9a0f054734	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1961.1091778513376	1.159662	assets_per_share
VAULT_YEARN	137	0x3bd8c987286d8ad00c05fdb2ae3e8c9a0f054734	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1961.5810677302431	1.159662	assets_per_share
VAULT_YEARN	137	0x3bd8c987286d8ad00c05fdb2ae3e8c9a0f054734	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1961.2522760640175	1.159662	assets_per_share
VAULT_YEARN	137	0x3bd8c987286d8ad00c05fdb2ae3e8c9a0f054734	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1961.3860768423542	1.159662	assets_per_share
VAULT_YEARN	137	0xa013fbd4b711f9ded6fb09c1c0d358e2fbc2eaa0	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	45540.90044373316	\N	\N
VAULT_YEARN	137	0xa013fbd4b711f9ded6fb09c1c0d358e2fbc2eaa0	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	45542.9700411217	\N	\N
VAULT_YEARN	137	0xa013fbd4b711f9ded6fb09c1c0d358e2fbc2eaa0	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	45540.60662785496	\N	\N
VAULT_YEARN	137	0xa013fbd4b711f9ded6fb09c1c0d358e2fbc2eaa0	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	45539.30039412785	\N	\N
VAULT_YEARN	137	0x7486325a843590b84c98563c6962c58655569eca	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	5619.3855685747585	\N	\N
VAULT_YEARN	137	0x7486325a843590b84c98563c6962c58655569eca	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	5551.858056263382	\N	\N
VAULT_YEARN	137	0x7486325a843590b84c98563c6962c58655569eca	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	5596.197021428383	\N	\N
VAULT_YEARN	137	0x7486325a843590b84c98563c6962c58655569eca	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	5673.893453260093	\N	\N
VAULT_YEARN	137	0xa9c3b8f7ab9cc105ac4d27c1bf821ec0c6a9e954	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa9c3b8f7ab9cc105ac4d27c1bf821ec0c6a9e954	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa9c3b8f7ab9cc105ac4d27c1bf821ec0c6a9e954	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa9c3b8f7ab9cc105ac4d27c1bf821ec0c6a9e954	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x2a42a69f48efffdf2d4fb079af60d98d3e34d49c	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	15766.672461100909	\N	\N
VAULT_YEARN	137	0x2a42a69f48efffdf2d4fb079af60d98d3e34d49c	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	15619.10467561948	\N	\N
VAULT_YEARN	137	0x2a42a69f48efffdf2d4fb079af60d98d3e34d49c	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	16142.870183913717	\N	\N
VAULT_YEARN	137	0x2a42a69f48efffdf2d4fb079af60d98d3e34d49c	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	16160.632932157603	\N	\N
VAULT_YEARN	137	0xbeda9a5300393e00229dc15cc54d5185e7646c56	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	76.9372063337724	1.021560661451433	assets_per_share
VAULT_YEARN	137	0xbeda9a5300393e00229dc15cc54d5185e7646c56	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	76.01266074342158	1.021560661451433	assets_per_share
VAULT_YEARN	137	0xbeda9a5300393e00229dc15cc54d5185e7646c56	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	76.61972286256193	1.021560661451433	assets_per_share
VAULT_YEARN	137	0xbeda9a5300393e00229dc15cc54d5185e7646c56	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	77.68349510852836	1.021560661451433	assets_per_share
VAULT_YEARN	137	0xb64ce1c06af365424060e2720df46997a4fd3a0a	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xb64ce1c06af365424060e2720df46997a4fd3a0a	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xb64ce1c06af365424060e2720df46997a4fd3a0a	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xb64ce1c06af365424060e2720df46997a4fd3a0a	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x6ed737ef2ef74e04005dc9810366de5ad38cf7d6	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	7.962813092202363	\N	\N
VAULT_YEARN	137	0x6ed737ef2ef74e04005dc9810366de5ad38cf7d6	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	7.888285337717838	\N	\N
VAULT_YEARN	137	0x6ed737ef2ef74e04005dc9810366de5ad38cf7d6	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	8.152808296317955	\N	\N
VAULT_YEARN	137	0x6ed737ef2ef74e04005dc9810366de5ad38cf7d6	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	8.161779209148095	\N	\N
VAULT_YEARN	137	0x91e646449a3105e9091e882c9a9a7a81950eebb8	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x91e646449a3105e9091e882c9a9a7a81950eebb8	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x91e646449a3105e9091e882c9a9a7a81950eebb8	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x91e646449a3105e9091e882c9a9a7a81950eebb8	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xbb287e6017d3deb0e2e65061e8684eab21060123	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	53151.66166378131	\N	\N
VAULT_YEARN	137	0xbb287e6017d3deb0e2e65061e8684eab21060123	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	53156.04064473658	\N	\N
VAULT_YEARN	137	0xbb287e6017d3deb0e2e65061e8684eab21060123	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	53147.13086096009	\N	\N
VAULT_YEARN	137	0xbb287e6017d3deb0e2e65061e8684eab21060123	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	53150.756670634015	\N	\N
VAULT_YEARN	137	0x28f53ba70e5c8ce8d03b1fad41e9df11bb646c36	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	4946.793582296347	\N	\N
VAULT_YEARN	137	0x28f53ba70e5c8ce8d03b1fad41e9df11bb646c36	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	4900.49418868782	\N	\N
VAULT_YEARN	137	0x28f53ba70e5c8ce8d03b1fad41e9df11bb646c36	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	5064.82562015825	\N	\N
VAULT_YEARN	137	0x28f53ba70e5c8ce8d03b1fad41e9df11bb646c36	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	5070.398682529755	\N	\N
VAULT_YEARN	137	0x2c5d0c3db75d2f8a4957c74be09194a9271cf28d	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1.0673521517474351	1.066796	assets_per_share
VAULT_YEARN	137	0x2c5d0c3db75d2f8a4957c74be09194a9271cf28d	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1.0676089822611703	1.066796	assets_per_share
VAULT_YEARN	137	0x2c5d0c3db75d2f8a4957c74be09194a9271cf28d	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1.0674300342982592	1.066796	assets_per_share
VAULT_YEARN	137	0x2c5d0c3db75d2f8a4957c74be09194a9271cf28d	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1.0675028566328215	1.066796	assets_per_share
VAULT_YEARN	137	0x4987d1856f93dff29e08aa605a805faf43dc3103	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	2415.9654655057975	1.079572	assets_per_share
VAULT_YEARN	137	0x4987d1856f93dff29e08aa605a805faf43dc3103	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	2416.129851273346	1.079572	assets_per_share
VAULT_YEARN	137	0x4987d1856f93dff29e08aa605a805faf43dc3103	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	2416.1470303614387	1.079572	assets_per_share
VAULT_YEARN	137	0x4987d1856f93dff29e08aa605a805faf43dc3103	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	2416.069355475468	1.079572	assets_per_share
VAULT_YEARN	137	0x8df66d28914084f44c4046783810cbad662fa633	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.2186024217607792	assets_per_share
VAULT_YEARN	137	0x8df66d28914084f44c4046783810cbad662fa633	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.2186024217607792	assets_per_share
VAULT_YEARN	137	0x8df66d28914084f44c4046783810cbad662fa633	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.2186024217607792	assets_per_share
VAULT_YEARN	137	0x8df66d28914084f44c4046783810cbad662fa633	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.2186024217607792	assets_per_share
VAULT_YEARN	137	0x54303f18161d9870b0fc66b88b0b129e8e5ff505	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	80.39202679716131	\N	\N
VAULT_YEARN	137	0x54303f18161d9870b0fc66b88b0b129e8e5ff505	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	80.28563106070573	\N	\N
VAULT_YEARN	137	0x54303f18161d9870b0fc66b88b0b129e8e5ff505	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	80.65474621639977	\N	\N
VAULT_YEARN	137	0x54303f18161d9870b0fc66b88b0b129e8e5ff505	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	81.32852590564086	\N	\N
VAULT_YEARN	137	0xdb92b89ca415c0dab40dc96e99fc411c08f20780	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	3820.0029498844074	1.146119	assets_per_share
VAULT_YEARN	137	0xdb92b89ca415c0dab40dc96e99fc411c08f20780	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	3820.17654917762	1.146119	assets_per_share
VAULT_YEARN	137	0xdb92b89ca415c0dab40dc96e99fc411c08f20780	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	3820.2900310923333	1.146119	assets_per_share
VAULT_YEARN	137	0xdb92b89ca415c0dab40dc96e99fc411c08f20780	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	3820.1804543419235	1.146119	assets_per_share
VAULT_YEARN	137	0xa823ef7df6392800569946c6c1dec0e34356ef18	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa823ef7df6392800569946c6c1dec0e34356ef18	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa823ef7df6392800569946c6c1dec0e34356ef18	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0xa823ef7df6392800569946c6c1dec0e34356ef18	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x34b9421fe3d52191b64bc32ec1ab764dcbcdbf5e	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	77250.053629004	\N	\N
VAULT_YEARN	137	0x34b9421fe3d52191b64bc32ec1ab764dcbcdbf5e	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	77255.4924585426	\N	\N
VAULT_YEARN	137	0x34b9421fe3d52191b64bc32ec1ab764dcbcdbf5e	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	77256.6656060262	\N	\N
VAULT_YEARN	137	0x34b9421fe3d52191b64bc32ec1ab764dcbcdbf5e	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	77253.49417049471	\N	\N
VAULT_YEARN	137	0xf54a15f6da443041bb075959ea66ee47655ddfca	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	2940.5003050999317	1.015342	assets_per_share
VAULT_YEARN	137	0xf54a15f6da443041bb075959ea66ee47655ddfca	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	2940.633935566021	1.015342	assets_per_share
VAULT_YEARN	137	0xf54a15f6da443041bb075959ea66ee47655ddfca	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	2940.7212898453804	1.015342	assets_per_share
VAULT_YEARN	137	0xf54a15f6da443041bb075959ea66ee47655ddfca	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	2940.6369416204607	1.015342	assets_per_share
VAULT_YEARN	137	0x32adfc6170344f848a8c0efe68dad93e5b6964aa	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x32adfc6170344f848a8c0efe68dad93e5b6964aa	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x32adfc6170344f848a8c0efe68dad93e5b6964aa	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x32adfc6170344f848a8c0efe68dad93e5b6964aa	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x0fefee13864c431717f5b2678607b6ce532a170c	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	12.054871337915118	2.602736	assets_per_share
VAULT_YEARN	137	0x0fefee13864c431717f5b2678607b6ce532a170c	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	12.057772028932282	2.602736	assets_per_share
VAULT_YEARN	137	0x0fefee13864c431717f5b2678607b6ce532a170c	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	12.05575095775578	2.602736	assets_per_share
VAULT_YEARN	137	0x0fefee13864c431717f5b2678607b6ce532a170c	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	12.056573426584125	2.602736	assets_per_share
VAULT_YEARN	137	0x52367c8e381edfb068e9fba1e7e9b2c847042897	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	96.46809362313526	1.107928	assets_per_share
VAULT_YEARN	137	0x52367c8e381edfb068e9fba1e7e9b2c847042897	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	96.47488550860955	1.107928	assets_per_share
VAULT_YEARN	137	0x52367c8e381edfb068e9fba1e7e9b2c847042897	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	96.47635050825633	1.107928	assets_per_share
VAULT_YEARN	137	0x52367c8e381edfb068e9fba1e7e9b2c847042897	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	96.47239009236795	1.107928	assets_per_share
VAULT_YEARN	137	0xd811a47cfd17355f47ac49be02c4744a926dd16b	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	524.3510717605462	1.082543	assets_per_share
VAULT_YEARN	137	0xd811a47cfd17355f47ac49be02c4744a926dd16b	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	524.4270879063652	1.082625	assets_per_share
VAULT_YEARN	137	0xd811a47cfd17355f47ac49be02c4744a926dd16b	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	524.4786509671973	1.082705	assets_per_share
VAULT_YEARN	137	0xd811a47cfd17355f47ac49be02c4744a926dd16b	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	524.4980186168938	1.082788	assets_per_share
VAULT_YEARN	137	0xf7464410c1ccf86b19711c9b6599336b00641c8f	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	0.003034392078440263	1.3135671301545802	assets_per_share
VAULT_YEARN	137	0xf7464410c1ccf86b19711c9b6599336b00641c8f	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	0.0030059917599581875	1.3135671301545802	assets_per_share
VAULT_YEARN	137	0xf7464410c1ccf86b19711c9b6599336b00641c8f	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	0.0031067936199098913	1.3135671301545802	assets_per_share
VAULT_YEARN	137	0xf7464410c1ccf86b19711c9b6599336b00641c8f	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	0.0031102121689217744	1.3135671301545802	assets_per_share
VAULT_YEARN	137	0xf4f9d5697341b4c9b0cc8151413e05a90f7dc24f	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	398.76290087313805	1.1479746730227132	assets_per_share
VAULT_YEARN	137	0xf4f9d5697341b4c9b0cc8151413e05a90f7dc24f	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	398.6861517881274	1.1479746730227132	assets_per_share
VAULT_YEARN	137	0xf4f9d5697341b4c9b0cc8151413e05a90f7dc24f	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	398.65866260777796	1.1479746730227132	assets_per_share
VAULT_YEARN	137	0xf4f9d5697341b4c9b0cc8151413e05a90f7dc24f	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	398.7467039184027	1.1479746730227132	assets_per_share
VAULT_YEARN	137	0x5bfd56f9bcbdb2be985c64c620eca7f02fa7b439	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	28.67960351933057	1.075572	assets_per_share
VAULT_YEARN	137	0x5bfd56f9bcbdb2be985c64c620eca7f02fa7b439	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	28.68162272148576	1.075572	assets_per_share
VAULT_YEARN	137	0x5bfd56f9bcbdb2be985c64c620eca7f02fa7b439	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	28.682058260402805	1.075572	assets_per_share
VAULT_YEARN	137	0x5bfd56f9bcbdb2be985c64c620eca7f02fa7b439	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	28.68088084356803	1.075572	assets_per_share
VAULT_YEARN	137	0x03e6010193c595ec168756af700479d1aff76895	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x03e6010193c595ec168756af700479d1aff76895	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x03e6010193c595ec168756af700479d1aff76895	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x03e6010193c595ec168756af700479d1aff76895	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	137	0x335bc8366545faa446e0c1f639617ac40061f2ef	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	159.09058048986307	1.017954	assets_per_share
VAULT_YEARN	137	0x335bc8366545faa446e0c1f639617ac40061f2ef	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	159.09781033043967	1.017954	assets_per_share
VAULT_YEARN	137	0x335bc8366545faa446e0c1f639617ac40061f2ef	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	159.10253647958766	1.017954	assets_per_share
VAULT_YEARN	137	0x335bc8366545faa446e0c1f639617ac40061f2ef	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	159.09797296771094	1.017954	assets_per_share
VAULT_YEARN	137	0xd4a0aa006e0f70580aaa7ee1fd04fa447c36b259	2026-10-01T00:00:00.000Z	yearn-kong	0.009165439607272674	\N	74.77756545422791	\N	\N
VAULT_YEARN	137	0xd4a0aa006e0f70580aaa7ee1fd04fa447c36b259	2026-10-02T00:00:00.000Z	yearn-kong	0.009409123080672543	\N	73.87897202079922	\N	\N
VAULT_YEARN	137	0xd4a0aa006e0f70580aaa7ee1fd04fa447c36b259	2026-10-03T00:00:00.000Z	yearn-kong	0.00964300319594713	\N	74.46899379975318	\N	\N
VAULT_YEARN	137	0xd4a0aa006e0f70580aaa7ee1fd04fa447c36b259	2026-10-04T00:00:00.000Z	yearn-kong	0.010007127926314752	\N	75.50290577214862	\N	\N
VAULT_YEARN	137	0xe30461f1270ba52d45df1e773aefe594c7e430dc	2026-10-01T00:00:00.000Z	yearn-kong	4.2613790288470454	\N	369.8282735940635	1.050988	assets_per_share
VAULT_YEARN	137	0xe30461f1270ba52d45df1e773aefe594c7e430dc	2026-10-02T00:00:00.000Z	yearn-kong	4.23108735247979	\N	370.0074554527874	1.051107	assets_per_share
VAULT_YEARN	137	0xe30461f1270ba52d45df1e773aefe594c7e430dc	2026-10-03T00:00:00.000Z	yearn-kong	4.210659955106166	\N	369.94543641630935	1.05123	assets_per_share
VAULT_YEARN	137	0xe30461f1270ba52d45df1e773aefe594c7e430dc	2026-10-04T00:00:00.000Z	yearn-kong	4.195316999400234	\N	370.0651574276524	1.051356	assets_per_share
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
