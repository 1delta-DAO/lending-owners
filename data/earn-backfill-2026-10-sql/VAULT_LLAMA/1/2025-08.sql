-- Generated from VAULT_LLAMA/1/2025-08.ndjson (93 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-01T23:00:00.000Z	defillama-api	4.658115330258283	\N	44149942	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-02T23:00:00.000Z	defillama-api	4.674941394000598	\N	43433591	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-03T23:00:00.000Z	defillama-api	4.9545023571795355	\N	44978651	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-04T23:00:00.000Z	defillama-api	4.9545023571795355	\N	47875669	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-05T23:00:00.000Z	defillama-api	4.9545023571795355	\N	46162426	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-06T23:00:00.000Z	defillama-api	5.0192416335193	\N	47602407	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-07T23:00:00.000Z	defillama-api	4.935172235676077	\N	50900801	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-08T23:00:00.000Z	defillama-api	4.945689138224907	\N	51284090	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-09T23:00:00.000Z	defillama-api	4.923682699953247	\N	54369123	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-10T23:00:00.000Z	defillama-api	4.933535074869155	\N	54011735	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-11T23:00:00.000Z	defillama-api	4.964332324419729	\N	54239262	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-12T23:00:00.000Z	defillama-api	4.622669188236728	\N	60886527	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-13T23:00:00.000Z	defillama-api	4.96857647824811	\N	63358127	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-14T23:00:00.000Z	defillama-api	4.893167647068708	\N	60812730	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-15T23:00:00.000Z	defillama-api	5.035303735567709	\N	59938014	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-16T23:00:00.000Z	defillama-api	4.758258033987772	\N	59482992	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-17T23:00:00.000Z	defillama-api	4.63034591788869	\N	60870391	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-18T23:00:00.000Z	defillama-api	4.620300977009606	\N	58232306	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-19T23:00:00.000Z	defillama-api	4.913486507263087	\N	55376998	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-20T23:00:00.000Z	defillama-api	4.690591054767879	\N	58497640	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-21T23:00:00.000Z	defillama-api	4.923121107580641	\N	56901153	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-22T23:00:00.000Z	defillama-api	4.640522503862599	\N	64263486	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-23T23:00:00.000Z	defillama-api	4.731431144477938	\N	63774176	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-24T23:00:00.000Z	defillama-api	4.927271429266966	\N	63764034	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-25T23:00:00.000Z	defillama-api	5.4875039360524624	\N	58706876	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-26T23:00:00.000Z	defillama-api	4.752488757731044	\N	61366567	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-27T23:00:00.000Z	defillama-api	4.617007048679511	\N	60619815	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-28T23:00:00.000Z	defillama-api	4.517563884576248	\N	59344409	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-29T23:00:00.000Z	defillama-api	4.991020566436077	\N	57361929	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-30T23:00:00.000Z	defillama-api	4.59642699901508	\N	57372481	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-08-31T23:00:00.000Z	defillama-api	4.699235515914779	\N	58431596	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-01T21:00:00.000Z	defillama-api	18.4338270791784	\N	15953326	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-02T22:00:00.000Z	defillama-api	18.97923340727914	\N	16210170	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-03T18:00:00.000Z	defillama-api	19.420212263909775	\N	16541159	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-04T21:00:00.000Z	defillama-api	19.95777240431096	\N	17859605	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-05T22:00:00.000Z	defillama-api	16.794503931549798	\N	16557492	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-06T23:00:00.000Z	defillama-api	16.058178604438922	\N	17451781	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-07T22:00:00.000Z	defillama-api	15.883497467683583	\N	16640526	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-08T21:00:00.000Z	defillama-api	16.53312049505473	\N	17672367	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-09T23:00:00.000Z	defillama-api	17.255249159120467	\N	19162066	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-10T23:00:00.000Z	defillama-api	17.887955791806576	\N	18207762	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-11T21:00:00.000Z	defillama-api	18.495733185019958	\N	18738118	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-12T23:00:00.000Z	defillama-api	16.89844263559337	\N	18203731	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-13T23:00:00.000Z	defillama-api	16.875292005380516	\N	18774525	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-14T23:00:00.000Z	defillama-api	16.91097482847681	\N	16772385	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-15T21:00:00.000Z	defillama-api	17.21746701690563	\N	16714202	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-16T23:00:00.000Z	defillama-api	17.709073215854687	\N	17899201	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-17T23:00:00.000Z	defillama-api	17.157729553929357	\N	17232396	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-18T22:00:00.000Z	defillama-api	17.675760704705112	\N	17077712	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-19T22:00:00.000Z	defillama-api	17.59100507179312	\N	16355753	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-20T23:00:00.000Z	defillama-api	17.61193664187033	\N	17699569	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-21T22:00:00.000Z	defillama-api	15.64826728994717	\N	17193144	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-22T23:00:00.000Z	defillama-api	18.220863128703968	\N	18284547	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-23T23:00:00.000Z	defillama-api	18.667813630912633	\N	17762464	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-24T23:00:00.000Z	defillama-api	19.126535865510164	\N	17884088	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-25T21:00:00.000Z	defillama-api	19.553512025538566	\N	15279655	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-26T21:00:00.000Z	defillama-api	18.194148277572708	\N	15706454	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-27T22:00:00.000Z	defillama-api	17.640098188564934	\N	16153582	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-28T15:00:00.000Z	defillama-api	18.061994108364843	\N	16434856	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-29T23:00:00.000Z	defillama-api	17.379590051902483	\N	15747137	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-30T22:00:00.000Z	defillama-api	17.432323715738107	\N	15781525	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-08-31T23:00:00.000Z	defillama-api	17.97472461433358	\N	15186340	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-01T23:00:00.000Z	defillama-api	6.12099553762846	\N	509309562	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-02T23:00:00.000Z	defillama-api	6.047223167016114	\N	509019156	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-03T23:00:00.000Z	defillama-api	6.1705263043165814	\N	509953847	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-04T23:00:00.000Z	defillama-api	6.361149802103228	\N	510786676	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-05T23:00:00.000Z	defillama-api	5.900391970214969	\N	509325904	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-06T23:00:00.000Z	defillama-api	6.137370646897011	\N	508393449	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-07T23:00:00.000Z	defillama-api	6.498432528090348	\N	507057475	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-08T23:00:00.000Z	defillama-api	6.577378971073244	\N	508378864	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-09T23:00:00.000Z	defillama-api	7.107402429795684	\N	508313767	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-10T23:00:00.000Z	defillama-api	6.99833306825326	\N	508033338	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-11T23:00:00.000Z	defillama-api	6.449805070829484	\N	507226399	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-12T23:00:00.000Z	defillama-api	6.738234571912471	\N	507155005	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-13T23:00:00.000Z	defillama-api	7.107886995783019	\N	506232740	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-14T23:00:00.000Z	defillama-api	6.181111830372288	\N	506848004	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-15T23:00:00.000Z	defillama-api	6.006267537728149	\N	505999506	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-16T23:00:00.000Z	defillama-api	6.1283039411108575	\N	507310178	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-17T23:00:00.000Z	defillama-api	6.277402514598407	\N	506044814	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-18T23:00:00.000Z	defillama-api	5.982929243231183	\N	507116956	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-19T23:00:00.000Z	defillama-api	5.663190617255509	\N	506649073	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-20T23:00:00.000Z	defillama-api	5.909196786291204	\N	505420072	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-21T23:00:00.000Z	defillama-api	5.6609988664746425	\N	505188378	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-22T23:00:00.000Z	defillama-api	6.265747022027313	\N	505161981	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-23T23:00:00.000Z	defillama-api	6.547233644838002	\N	505167374	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-24T23:00:00.000Z	defillama-api	6.218528447377025	\N	504566274	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-25T23:00:00.000Z	defillama-api	5.459244355776605	\N	505229904	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-26T23:00:00.000Z	defillama-api	5.763710750272821	\N	504838871	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-27T23:00:00.000Z	defillama-api	5.7506449746114185	\N	504464950	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-28T23:00:00.000Z	defillama-api	6.007416631348406	\N	503504708	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-29T23:00:00.000Z	defillama-api	5.673253764371111	\N	504260919	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-30T23:00:00.000Z	defillama-api	5.692735137685645	\N	504848299	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-08-31T23:00:00.000Z	defillama-api	5.589770467295807	\N	504951053	\N	\N
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
