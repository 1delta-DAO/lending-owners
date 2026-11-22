-- Generated from VAULT_YEARN/42161/2024-02.ndjson (116 vault rows)
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
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-01T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-02T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-03T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-04T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-05T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-06T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-07T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-08T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-09T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-10T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-11T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-12T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-13T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-14T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-15T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-16T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-17T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-18T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-19T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-20T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-21T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-22T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-23T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-24T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-25T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-26T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-27T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-28T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0x5108db0852c0caa2df797dcf31f8a73bfb335452	2024-02-29T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-01T00:00:00.000Z	yearn-kong	3.588339280113928	\N	5010.156020879999	1.000754	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-02T00:00:00.000Z	yearn-kong	3.6248224773771653	\N	5023.17201374	1.000763	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-03T00:00:00.000Z	yearn-kong	3.6613189791978584	\N	5010.156020879999	1.000772	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-04T00:00:00.000Z	yearn-kong	3.6978014762212297	\N	4995.63818269	1.000781	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-05T00:00:00.000Z	yearn-kong	0.32846921662610384	\N	5003.147409339999	1.00079	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-06T00:00:00.000Z	yearn-kong	0.3284657154267734	\N	5001.64556401	1.000799	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-07T00:00:00.000Z	yearn-kong	0.328462914467309	\N	5007.65294533	1.000808	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-08T00:00:00.000Z	yearn-kong	0.32845941326797856	\N	5018.66647775	1.000817	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-09T00:00:00.000Z	yearn-kong	0.4066580000738895	\N	5009.719659660001	1.000841	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-10T00:00:00.000Z	yearn-kong	0.49527895704670755	\N	5006.7096138	1.000867	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-11T00:00:00.000Z	yearn-kong	0.5786859279766077	\N	5012.22803121	1.000892	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-12T00:00:00.000Z	yearn-kong	0.6620893977071773	\N	5003.197893629999	1.000917	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-13T00:00:00.000Z	yearn-kong	0.7611278231678398	\N	5008.32630942	1.000945	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-14T00:00:00.000Z	yearn-kong	0.8914375605684199	\N	5021.38321146	1.000979	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-15T00:00:00.000Z	yearn-kong	1.0165298107267517	\N	5021.38321146	1.001012	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-16T00:00:00.000Z	yearn-kong	1.0634178721602439	\N	5015.85913752	1.001045	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-17T00:00:00.000Z	yearn-kong	1.0998751605484358	\N	5014.85476044	1.001078	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-18T00:00:00.000Z	yearn-kong	1.146755519343401	\N	5010.335063580001	1.001112	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-19T00:00:00.000Z	yearn-kong	1.188420491615716	\N	5029.4182281	1.001145	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-20T00:00:00.000Z	yearn-kong	1.2144456064788756	\N	5037.95543328	1.001178	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-21T00:00:00.000Z	yearn-kong	1.2144056928065083	\N	5004.81098964	1.001212	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-22T00:00:00.000Z	yearn-kong	1.2143622779348107	\N	5021.8854	1.001245	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-23T00:00:00.000Z	yearn-kong	46.74231210728408	\N	18.910732680000002	1.010053	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-24T00:00:00.000Z	yearn-kong	93.24076218000243	\N	18.87667974	1.019128	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-25T00:00:00.000Z	yearn-kong	140.15225013821464	\N	18.852085950000003	1.028367	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-26T00:00:00.000Z	yearn-kong	194.80338289987742	\N	31.093054560000002	1.039229	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-27T00:00:00.000Z	yearn-kong	272.87300933060976	\N	31.0403124	1.05493	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-28T00:00:00.000Z	yearn-kong	352.1295591401241	\N	31.07754216	1.071113	assets_per_share
VAULT_YEARN	42161	0xcacc53bacce744ac7b5c1ec7eb7e3ab01330733b	2024-02-29T00:00:00.000Z	yearn-kong	411.81846048168325	\N	3118.2524502	1.083472	assets_per_share
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-01T00:00:00.000Z	yearn-kong	0.01032153562618987	\N	0.06405119999999999	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-02T00:00:00.000Z	yearn-kong	0.01032153562618987	\N	0.0642176	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-03T00:00:00.000Z	yearn-kong	0.01032153562618987	\N	0.06405119999999999	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-04T00:00:00.000Z	yearn-kong	0.01032153562618987	\N	0.0638656	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-05T00:00:00.000Z	yearn-kong	0	\N	0.0639616	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-06T00:00:00.000Z	yearn-kong	0	\N	0.0639424	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-07T00:00:00.000Z	yearn-kong	0	\N	0.0640192	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-08T00:00:00.000Z	yearn-kong	0	\N	0.06416	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-09T00:00:00.000Z	yearn-kong	0	\N	0.0639104	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-10T00:00:00.000Z	yearn-kong	0	\N	0.063872	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-11T00:00:00.000Z	yearn-kong	0	\N	0.0639424	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-12T00:00:00.000Z	yearn-kong	0	\N	0.06382719999999999	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-13T00:00:00.000Z	yearn-kong	0	\N	0.06382719999999999	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-14T00:00:00.000Z	yearn-kong	0	\N	0.0639936	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-15T00:00:00.000Z	yearn-kong	0	\N	0.0639936	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-16T00:00:00.000Z	yearn-kong	0	\N	0.0639232	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-17T00:00:00.000Z	yearn-kong	0	\N	0.0639104	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-18T00:00:00.000Z	yearn-kong	0	\N	0.0638528	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-19T00:00:00.000Z	yearn-kong	0	\N	0.064096	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-20T00:00:00.000Z	yearn-kong	0	\N	0.0642048	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-21T00:00:00.000Z	yearn-kong	0	\N	0.0637824	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-22T00:00:00.000Z	yearn-kong	0	\N	0.064	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-23T00:00:00.000Z	yearn-kong	0	\N	0.0639744	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-24T00:00:00.000Z	yearn-kong	0	\N	0.0638592	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-25T00:00:00.000Z	yearn-kong	0	\N	0.063776	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-26T00:00:00.000Z	yearn-kong	3584.3473085702017	\N	0.14321438	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-27T00:00:00.000Z	yearn-kong	3584.34423311671	\N	0.14297144999999997	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-28T00:00:00.000Z	yearn-kong	3584.3381067181213	\N	0.14314293	\N	\N
VAULT_YEARN	42161	0xd89ee1e95f7728f6964cf321e2648ccd29a881f1	2024-02-29T00:00:00.000Z	yearn-kong	3584.345779946574	\N	4630.91942328	\N	\N
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-01T00:00:00.000Z	yearn-kong	\N	\N	1007.4786657	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-02T00:00:00.000Z	yearn-kong	\N	\N	1007.2771095	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-03T00:00:00.000Z	yearn-kong	\N	\N	1007.4786657	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-04T00:00:00.000Z	yearn-kong	\N	\N	1007.4786657	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-05T00:00:00.000Z	yearn-kong	\N	\N	1006.4708847	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-06T00:00:00.000Z	yearn-kong	\N	\N	1006.9747752000001	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-07T00:00:00.000Z	yearn-kong	\N	\N	1007.0755533	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-08T00:00:00.000Z	yearn-kong	\N	\N	1007.781	1	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-09T00:00:00.000Z	yearn-kong	85.2491094516239	\N	1010.23281318	1.002098	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-10T00:00:00.000Z	yearn-kong	40.27934322721194	\N	1010.53585272	1.002098	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-11T00:00:00.000Z	yearn-kong	26.361640339445103	\N	1010.3338263599999	1.002098	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-12T00:00:00.000Z	yearn-kong	19.578453169089016	\N	1010.6368659	1.002098	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-13T00:00:00.000Z	yearn-kong	24.877482643503868	\N	1011.5358	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-14T00:00:00.000Z	yearn-kong	20.641633659934655	\N	1012.14272148	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-15T00:00:00.000Z	yearn-kong	17.675678076400914	\N	1011.7381071599999	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-16T00:00:00.000Z	yearn-kong	6.525275523117102	\N	1011.94041432	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-17T00:00:00.000Z	yearn-kong	6.52526151831978	\N	1011.7381071599999	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-18T00:00:00.000Z	yearn-kong	6.525272722157638	\N	1011.7381071599999	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-19T00:00:00.000Z	yearn-kong	6.525275523117102	\N	1011.5358	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-20T00:00:00.000Z	yearn-kong	0	\N	1011.6369535800001	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-21T00:00:00.000Z	yearn-kong	0	\N	1011.3334928400001	1.003352	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-22T00:00:00.000Z	yearn-kong	0.005199981245596064	\N	0.37624944	1.003353	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-23T00:00:00.000Z	yearn-kong	0.005199981245596064	\N	0.37632472	1.003353	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-24T00:00:00.000Z	yearn-kong	0.005199981245596064	\N	0.37632472	1.003353	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-25T00:00:00.000Z	yearn-kong	0.005199981245596064	\N	0.37636236	1.003353	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-26T00:00:00.000Z	yearn-kong	257.3590942628101	\N	3.0370072799999996	1.054082	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-27T00:00:00.000Z	yearn-kong	1467.997166076529	\N	3.03731092	1.329358	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-28T00:00:00.000Z	yearn-kong	3047.181866072179	\N	3.0379181999999996	1.799214	assets_per_share
VAULT_YEARN	42161	0x4ae5ce819e7d678b07e8d0f483d351e2c8e8b8d3	2024-02-29T00:00:00.000Z	yearn-kong	3294.5982530758756	\N	1213.90716293	1.886585	assets_per_share
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
