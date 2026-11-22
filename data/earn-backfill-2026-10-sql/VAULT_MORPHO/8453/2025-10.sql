-- Generated from VAULT_MORPHO/8453/2025-10.ndjson (82 vault rows)
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
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-15T00:00:00.000Z	morpho-api	\N	\N	99.98052976237098	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-16T00:00:00.000Z	morpho-api	0.5803616019761648	\N	99.98664013802961	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-17T00:00:00.000Z	morpho-api	0.5090267663376835	\N	99.98037880662388	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-18T00:00:00.000Z	morpho-api	0.73317494795333	\N	99.98456659828967	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-19T00:00:00.000Z	morpho-api	0.7808241701212637	\N	99.98052982765573	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-20T00:00:00.000Z	morpho-api	0.8062057645474852	\N	99.98240535289524	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-21T00:00:00.000Z	morpho-api	0.8017480375599462	\N	99.98007236297119	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-22T00:00:00.000Z	morpho-api	0.760227314700046	\N	99.98045811178396	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-23T00:00:00.000Z	morpho-api	0.7412403107309729	\N	99.98030996817569	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-24T00:00:00.000Z	morpho-api	0.7702757567784602	\N	99.98688857336947	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-25T00:00:00.000Z	morpho-api	0.8119330264122482	\N	99.98823390480553	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-26T00:00:00.000Z	morpho-api	0.802236104746612	\N	99.98064378326512	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-27T00:00:00.000Z	morpho-api	0.837745968595982	\N	99.97998533284415	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-28T00:00:00.000Z	morpho-api	0.8183115113524764	\N	99.98048277355254	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-29T00:00:00.000Z	morpho-api	0.7630541830394577	\N	99.98074039962177	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-30T00:00:00.000Z	morpho-api	0.7741186731635707	\N	99.98760899008604	1	assets_per_share
VAULT_MORPHO	8453	0xe18deb2adeeee6eec6fe7b3bf68ad96c7b39df5d	2025-10-31T00:00:00.000Z	morpho-api	0.5135853278659397	\N	99.97526079835569	1	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-13T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-14T00:00:00.000Z	morpho-api	0.3942882628393818	\N	1000.0232523895779	1	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-15T00:00:00.000Z	morpho-api	0.9702474567774289	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-16T00:00:00.000Z	morpho-api	29.84643304984047	\N	1001.765510628021	1.000797991814795	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-17T00:00:00.000Z	morpho-api	43.18605221591554	\N	1002.878620628994	1.001972771976276	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-18T00:00:00.000Z	morpho-api	25.35656085100868	\N	1003.6043947936372	1.002655893205462	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-19T00:00:00.000Z	morpho-api	25203.161201894276	\N	9.998052982765572e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-20T00:00:00.000Z	morpho-api	0.38376365765202536	\N	9.998240535289524e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-21T00:00:00.000Z	morpho-api	0.6784154901851025	\N	9.998007236297117e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-22T00:00:00.000Z	morpho-api	0.48700422254910336	\N	9.998045811178396e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-23T00:00:00.000Z	morpho-api	0.2571217766700329	\N	9.998030996817568e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-24T00:00:00.000Z	morpho-api	0.276819524103189	\N	9.998688857336947e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-25T00:00:00.000Z	morpho-api	0.314171719040246	\N	9.998823390480553e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-26T00:00:00.000Z	morpho-api	0.2238596827908168	\N	9.998064378326513e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-27T00:00:00.000Z	morpho-api	0.232990810644651	\N	9.997998533284416e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-28T00:00:00.000Z	morpho-api	0.21777109715515053	\N	9.998048277355253e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-29T00:00:00.000Z	morpho-api	0.22138713582364744	\N	9.998074039962175e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-30T00:00:00.000Z	morpho-api	0.158745077882827	\N	9.998760899008605e-7	2	assets_per_share
VAULT_MORPHO	8453	0x4a80756eda9e5d2b5aa66e7666fa7c90bed4f33b	2025-10-31T00:00:00.000Z	morpho-api	0.8087259278255488	\N	9.99752607983557e-7	2	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-21T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-22T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-23T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-24T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-25T00:00:00.000Z	morpho-api	2.4587816518817363	\N	0.10999205670698133	1.000045454132235	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-26T00:00:00.000Z	morpho-api	7.064161217584797	\N	0.11000370332253745	1.000218179834728	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-27T00:00:00.000Z	morpho-api	6.760439178066235	\N	0.11002197505967502	1.000381814710775	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-28T00:00:00.000Z	morpho-api	6.741321229242203	\N	0.11004151875505512	1.000545449586821	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-29T00:00:00.000Z	morpho-api	6.687813800354547	\N	0.11006079864671163	1.000709084462868	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-30T00:00:00.000Z	morpho-api	6.696949129647578	\N	0.11008735737417465	1.000872719338915	assets_per_share
VAULT_MORPHO	8453	0x618495ccc4e751178c4914b1e939c0fe0fb07b9b	2025-10-31T00:00:00.000Z	morpho-api	6.4504815025401285	\N	0.11009275719114929	1.001036354214961	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-23T00:00:00.000Z	morpho-api	\N	\N	3.804632871088336	1.000016124818167	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-24T00:00:00.000Z	morpho-api	3.065605318397502	\N	3.857344476839158	1.000087422587632	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-25T00:00:00.000Z	morpho-api	3.2041232675084075	\N	3.933347105299174	1.000162193019665	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-26T00:00:00.000Z	morpho-api	3.109557974312338	\N	3.95570921337339	1.000234565858174	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-27T00:00:00.000Z	morpho-api	2.97290196300537	\N	4.161162594676843	1.000303352180619	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-28T00:00:00.000Z	morpho-api	2.9352927800374573	\N	4.120656396191088	1.000371093377847	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-29T00:00:00.000Z	morpho-api	2.822597576468411	\N	3.9850252687460475	1.0004361375897974	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-30T00:00:00.000Z	morpho-api	2.795211195305569	\N	3.90673038329482	1.0004998151394868	assets_per_share
VAULT_MORPHO	8453	0xfefec33668e22677c4762d0853d56245a800ff08	2025-10-31T00:00:00.000Z	morpho-api	2.654447576944108	\N	3.8057633531317636	1.0005594193851286	assets_per_share
VAULT_MORPHO	8453	0xbeeff7ae5e00aae3db302e4b0d8c883810a58100	2025-10-28T00:00:00.000Z	morpho-api	\N	\N	0.009998048277355254	1	assets_per_share
VAULT_MORPHO	8453	0xbeeff7ae5e00aae3db302e4b0d8c883810a58100	2025-10-29T00:00:00.000Z	morpho-api	7.998345621018643	\N	0.010000073654770169	1.000199980001999	assets_per_share
VAULT_MORPHO	8453	0xbeeff7ae5e00aae3db302e4b0d8c883810a58100	2025-10-30T00:00:00.000Z	morpho-api	4.38508760502998	\N	0.010001760527278308	1.000299970002999	assets_per_share
VAULT_MORPHO	8453	0xbeeff7ae5e00aae3db302e4b0d8c883810a58100	2025-10-31T00:00:00.000Z	morpho-api	9.58038284544216	\N	0.059993154499877285	1.0005499700005	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-23T00:00:00.000Z	morpho-api	\N	\N	0.999853089836741	1.00004999995	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-24T00:00:00.000Z	morpho-api	6.928262165573074	\N	1.0000888568885562	1.00021999978	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-25T00:00:00.000Z	morpho-api	7.002594728078293	\N	1.000273293042623	1.000390999609	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-26T00:00:00.000Z	morpho-api	6.956215741027449	\N	1.0003673292442754	1.000560999439	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-27T00:00:00.000Z	morpho-api	6.988561220921952	\N	1.0005307070212246	1.000730999269	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-28T00:00:00.000Z	morpho-api	6.969240902776619	\N	1.000705651885315	1.000900999099	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-29T00:00:00.000Z	morpho-api	6.95239943375725	\N	1.0008791975333016	1.00107199792693	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-30T00:00:00.000Z	morpho-api	6.961779146763547	\N	1.0011189358806074	1.001242997755759	assets_per_share
VAULT_MORPHO	8453	0x050ce30b927da55177a4914ec73480238bad56f0	2025-10-31T00:00:00.000Z	morpho-api	6.679564274492122	\N	1.0011652584186377	1.001412997585589	assets_per_share
VAULT_MORPHO	8453	0xbeef0e0834849acc03f0089f01f4f1eeb06873c9	2025-10-28T00:00:00.000Z	morpho-api	\N	\N	0.009998048277355254	1	assets_per_share
VAULT_MORPHO	8453	0xbeef0e0834849acc03f0089f01f4f1eeb06873c9	2025-10-29T00:00:00.000Z	morpho-api	7.998345621018643	\N	0.010000073654770169	1.000199980001999	assets_per_share
VAULT_MORPHO	8453	0xbeef0e0834849acc03f0089f01f4f1eeb06873c9	2025-10-30T00:00:00.000Z	morpho-api	4.38508760502998	\N	0.010001760527278308	1.000299970002999	assets_per_share
VAULT_MORPHO	8453	0xbeef0e0834849acc03f0089f01f4f1eeb06873c9	2025-10-31T00:00:00.000Z	morpho-api	6.617791214225122	\N	0.10998478390948706	1.000468382346402	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-23T00:00:00.000Z	morpho-api	\N	\N	0.9998570890491396	1.000053999946	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-24T00:00:00.000Z	morpho-api	7.244518498694674	\N	1.0001018551840706	1.000232999767	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-25T00:00:00.000Z	morpho-api	7.282317446666298	\N	1.0002942905717431	1.000411999588	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-26T00:00:00.000Z	morpho-api	7.272236793554043	\N	1.0003973234374104	1.000590999409	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-27T00:00:00.000Z	morpho-api	7.2680710665906645	\N	1.000568699415651	1.000768999231	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-28T00:00:00.000Z	morpho-api	7.284925840167489	\N	1.0007526427122186	1.000947999052	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-29T00:00:00.000Z	morpho-api	7.26809697546571	\N	1.0009351867479253	1.001127997870874	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-30T00:00:00.000Z	morpho-api	7.241105529587344	\N	1.0011829279503608	1.001306997691695	assets_per_share
VAULT_MORPHO	8453	0x1deefabee758aabdc29a542b24ca3b75afd56765	2025-10-31T00:00:00.000Z	morpho-api	6.995695264677693	\N	1.0012382403590205	1.001485997512516	assets_per_share
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
