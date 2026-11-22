-- Generated from VAULT_LLAMA/1/2025-05.ndjson (93 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-01T23:00:00.000Z	defillama-api	7.892235473150322	\N	27845315	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-02T23:00:00.000Z	defillama-api	7.519698761271343	\N	28235097	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-03T23:00:00.000Z	defillama-api	7.311773736873306	\N	28444265	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-04T23:00:00.000Z	defillama-api	7.176404066200348	\N	28814116	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-05T23:00:00.000Z	defillama-api	6.999582296174367	\N	29782248	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-06T23:00:00.000Z	defillama-api	6.994528665060784	\N	29459376	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-07T23:00:00.000Z	defillama-api	6.843087088981292	\N	30036711	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-08T23:00:00.000Z	defillama-api	6.565383862167096	\N	35234345	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-09T23:00:00.000Z	defillama-api	6.627937689884789	\N	37753950	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-10T23:00:00.000Z	defillama-api	6.349175700393062	\N	41376693	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-11T23:00:00.000Z	defillama-api	6.23996068895849	\N	40364767	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-12T23:00:00.000Z	defillama-api	6.1629952245567665	\N	40566078	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-13T23:00:00.000Z	defillama-api	5.942446976092697	\N	43667243	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-14T23:00:00.000Z	defillama-api	6.375092978316843	\N	41976395	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-15T23:00:00.000Z	defillama-api	6.215868936365609	\N	41181534	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-16T23:00:00.000Z	defillama-api	5.93155334449591	\N	40881979	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-17T23:00:00.000Z	defillama-api	6.055412472250055	\N	39568940	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-18T23:00:00.000Z	defillama-api	5.475472414673277	\N	39064420	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-19T23:00:00.000Z	defillama-api	5.558540469507989	\N	40679544	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-20T23:00:00.000Z	defillama-api	5.708386899172524	\N	40407335	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-21T23:00:00.000Z	defillama-api	5.347318015580527	\N	40498770	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-22T23:00:00.000Z	defillama-api	5.248210266373121	\N	43209437	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-23T23:00:00.000Z	defillama-api	5.343517113587382	\N	41429947	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-24T23:00:00.000Z	defillama-api	5.162908446365577	\N	41297113	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-25T23:00:00.000Z	defillama-api	5.2268109360653625	\N	41534434	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-26T23:00:00.000Z	defillama-api	4.8829497469427	\N	41719745	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-27T23:00:00.000Z	defillama-api	5.024139811382611	\N	43299922	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-28T23:00:00.000Z	defillama-api	5.166231784770048	\N	42479980	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-29T23:00:00.000Z	defillama-api	5.330225860689097	\N	42506262	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-30T23:00:00.000Z	defillama-api	5.1235934790838655	\N	40622113	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-05-31T23:00:00.000Z	defillama-api	4.837522385869875	\N	40554699	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-01T22:00:00.000Z	defillama-api	17.196957691467674	\N	18003412	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-02T22:00:00.000Z	defillama-api	17.65697957125667	\N	18877257	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-03T20:00:00.000Z	defillama-api	17.2492411010694	\N	17353898	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-04T23:00:00.000Z	defillama-api	17.76732687055471	\N	17719825	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-05T21:00:00.000Z	defillama-api	16.976918517386252	\N	17854573	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-06T23:00:00.000Z	defillama-api	16.948864807631026	\N	16016713	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-07T23:00:00.000Z	defillama-api	16.7588645233252	\N	15292307	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-08T22:00:00.000Z	defillama-api	16.754086086478992	\N	17570438	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-09T22:00:00.000Z	defillama-api	16.787453216338122	\N	18021136	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-10T22:00:00.000Z	defillama-api	17.322514200657224	\N	18665155	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-11T23:00:00.000Z	defillama-api	17.856258734028074	\N	18887211	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-12T23:00:00.000Z	defillama-api	18.362420819073577	\N	18462577	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-13T21:00:00.000Z	defillama-api	17.08132568190024	\N	18393536	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-14T22:00:00.000Z	defillama-api	17.016370031441852	\N	18237236	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-15T22:00:00.000Z	defillama-api	17.42106665965082	\N	16597491	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-16T23:00:00.000Z	defillama-api	16.925168690562487	\N	17297987	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-17T22:00:00.000Z	defillama-api	16.95182752250446	\N	16436276	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-18T23:00:00.000Z	defillama-api	16.791950856998028	\N	16404177	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-19T22:00:00.000Z	defillama-api	16.585556556947267	\N	16208813	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-20T22:00:00.000Z	defillama-api	17.060982313310546	\N	17107047	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-21T22:00:00.000Z	defillama-api	17.385691942095605	\N	17481676	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-22T23:00:00.000Z	defillama-api	15.990321860215317	\N	19161373	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-23T22:00:00.000Z	defillama-api	15.965552975671926	\N	19022437	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-24T23:00:00.000Z	defillama-api	16.56151942306394	\N	18467368	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-25T21:00:00.000Z	defillama-api	17.098773558643643	\N	18051973	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-26T23:00:00.000Z	defillama-api	16.274501605550995	\N	15838568	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-27T20:00:00.000Z	defillama-api	16.87106815850825	\N	16652169	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-28T22:00:00.000Z	defillama-api	17.395524010055397	\N	15528449	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-29T20:00:00.000Z	defillama-api	16.137869402399474	\N	15344091	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-30T20:00:00.000Z	defillama-api	16.221050896092493	\N	13809818	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-05-31T23:00:00.000Z	defillama-api	16.93650697447424	\N	14376903	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-01T23:00:00.000Z	defillama-api	12.4078554918583	\N	565432579	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-02T23:00:00.000Z	defillama-api	11.835309267027583	\N	567559614	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-03T23:00:00.000Z	defillama-api	11.123301169746469	\N	565652090	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-04T23:00:00.000Z	defillama-api	11.547156360691702	\N	567605876	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-05T23:00:00.000Z	defillama-api	11.325805637341091	\N	566962157	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-06T23:00:00.000Z	defillama-api	10.916198226951224	\N	569101954	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-07T23:00:00.000Z	defillama-api	10.97376004466355	\N	570281787	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-08T23:00:00.000Z	defillama-api	12.734922128032622	\N	568948450	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-09T23:00:00.000Z	defillama-api	14.591082252835008	\N	570601795	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-10T23:00:00.000Z	defillama-api	15.65989687364322	\N	570946760	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-11T23:00:00.000Z	defillama-api	15.56210837634353	\N	571743035	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-12T23:00:00.000Z	defillama-api	14.558884523552251	\N	572083889	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-13T23:00:00.000Z	defillama-api	16.794588660573595	\N	572342785	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-14T23:00:00.000Z	defillama-api	14.380462705432251	\N	573028161	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-15T23:00:00.000Z	defillama-api	12.825116523984548	\N	570593422	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-16T23:00:00.000Z	defillama-api	11.586813745267932	\N	569701282	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-17T23:00:00.000Z	defillama-api	11.20793356044203	\N	567606218	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-18T23:00:00.000Z	defillama-api	11.821814244328266	\N	568971696	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-19T23:00:00.000Z	defillama-api	11.609262735134962	\N	566707682	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-20T23:00:00.000Z	defillama-api	11.565891278308982	\N	567075901	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-21T23:00:00.000Z	defillama-api	11.770961424772963	\N	567345102	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-22T23:00:00.000Z	defillama-api	13.566949237642234	\N	566503656	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-23T23:00:00.000Z	defillama-api	12.00868655715226	\N	566288935	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-24T23:00:00.000Z	defillama-api	11.831187655175768	\N	565899358	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-25T23:00:00.000Z	defillama-api	11.50931959976731	\N	568136366	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-26T23:00:00.000Z	defillama-api	11.230306924403521	\N	567340205	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-27T23:00:00.000Z	defillama-api	11.652375103210488	\N	564617661	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-28T23:00:00.000Z	defillama-api	11.173249979634647	\N	564605147	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-29T23:00:00.000Z	defillama-api	11.200254029830603	\N	563509541	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-30T23:00:00.000Z	defillama-api	9.380277399628767	\N	561086887	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-05-31T23:00:00.000Z	defillama-api	9.264709111889147	\N	561501814	\N	\N
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
