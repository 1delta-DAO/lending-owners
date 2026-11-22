-- Generated from VAULT_LLAMA/1/2025-09.ndjson (90 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-01T23:00:00.000Z	defillama-api	4.690000052320897	\N	57238960	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-02T23:00:00.000Z	defillama-api	4.548547397931202	\N	58200913	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-03T23:00:00.000Z	defillama-api	4.153208075052817	\N	61976788	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-04T23:00:00.000Z	defillama-api	4.549302256506849	\N	61247786	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-05T23:00:00.000Z	defillama-api	4.0592947051720785	\N	61722820	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-06T23:00:00.000Z	defillama-api	4.025901666437903	\N	61628616	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-07T23:00:00.000Z	defillama-api	4.398779395131669	\N	62345966	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-08T23:00:00.000Z	defillama-api	3.96095792005724	\N	62500111	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-09T23:00:00.000Z	defillama-api	4.330093566906612	\N	62949575	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-10T23:00:00.000Z	defillama-api	3.8212803737280865	\N	63472951	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-11T23:00:00.000Z	defillama-api	3.8212803737280865	\N	65092501	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-12T23:00:00.000Z	defillama-api	4.024471076391478	\N	69447925	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-13T23:00:00.000Z	defillama-api	4.0903237341183285	\N	68837808	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-14T23:00:00.000Z	defillama-api	4.000358316602615	\N	68518337	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-15T23:00:00.000Z	defillama-api	4.132033521742073	\N	66815019	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-16T23:00:00.000Z	defillama-api	4.252409656402278	\N	66923856	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-17T23:00:00.000Z	defillama-api	4.029024036000806	\N	68023987	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-18T23:00:00.000Z	defillama-api	4.029024036000806	\N	67935819	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-19T23:00:00.000Z	defillama-api	4.16075736104915	\N	65662882	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-20T23:00:00.000Z	defillama-api	4.210300031814995	\N	66060399	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-21T23:00:00.000Z	defillama-api	4.14186839066133	\N	65748531	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-22T23:00:00.000Z	defillama-api	4.209714631286943	\N	61621922	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-23T23:00:00.000Z	defillama-api	4.479992514561104	\N	61528953	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-24T23:00:00.000Z	defillama-api	4.142156189246293	\N	61212084	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-25T23:00:00.000Z	defillama-api	4.018418903228849	\N	57237988	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-26T23:00:00.000Z	defillama-api	4.083527205978044	\N	58323820	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-27T23:00:00.000Z	defillama-api	4.310067406976259	\N	57292049	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-28T23:00:00.000Z	defillama-api	3.936589572717253	\N	59019216	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-29T23:00:00.000Z	defillama-api	4.3303519554172	\N	60326906	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-09-30T23:00:00.000Z	defillama-api	4.182078964731772	\N	59399973	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-01T21:00:00.000Z	defillama-api	18.132597893583124	\N	14893881	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-02T23:00:00.000Z	defillama-api	19.09655929708265	\N	15673860	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-03T22:00:00.000Z	defillama-api	18.07911357261105	\N	16109335	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-04T22:00:00.000Z	defillama-api	18.76844020038959	\N	15496570	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-05T19:00:00.000Z	defillama-api	19.320173895920334	\N	16000047	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-06T23:00:00.000Z	defillama-api	20.038173945735593	\N	15498686	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-07T22:00:00.000Z	defillama-api	20.628268181610565	\N	15959773	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-08T22:00:00.000Z	defillama-api	21.22788217846505	\N	16223970	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-09T18:00:00.000Z	defillama-api	18.650977763812193	\N	16811841	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-10T20:00:00.000Z	defillama-api	19.271148002175664	\N	15919320	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-11T22:00:00.000Z	defillama-api	19.669238567487923	\N	16728659	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-12T23:00:00.000Z	defillama-api	20.126997972269578	\N	17341136	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-13T23:00:00.000Z	defillama-api	20.556490794376714	\N	17340050	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-14T23:00:00.000Z	defillama-api	20.68413892004628	\N	16304437	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-15T21:00:00.000Z	defillama-api	20.68413892004628	\N	15199496	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-16T23:00:00.000Z	defillama-api	20.691693107721676	\N	14964224	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-17T20:00:00.000Z	defillama-api	21.47952807938225	\N	15849046	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-18T22:00:00.000Z	defillama-api	17.8328091013924	\N	16732408	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-19T22:00:00.000Z	defillama-api	17.694479516805472	\N	16409052	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-20T23:00:00.000Z	defillama-api	18.186061907599083	\N	16910809	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-21T20:00:00.000Z	defillama-api	18.526954079689517	\N	17108938	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-22T21:00:00.000Z	defillama-api	19.04161217503031	\N	15180312	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-23T21:00:00.000Z	defillama-api	17.859420317023478	\N	14642648	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-24T21:00:00.000Z	defillama-api	18.35393181117695	\N	15559737	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-25T21:00:00.000Z	defillama-api	18.82072851167038	\N	13581217	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-26T22:00:00.000Z	defillama-api	18.016406392362683	\N	14405226	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-27T23:00:00.000Z	defillama-api	18.623621492963593	\N	14603678	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-28T23:00:00.000Z	defillama-api	18.864386366601593	\N	14739071	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-29T21:00:00.000Z	defillama-api	19.612706802618618	\N	14795049	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-09-30T17:00:00.000Z	defillama-api	20.01934799693572	\N	14616730	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-01T23:00:00.000Z	defillama-api	5.082618243079651	\N	501444480	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-02T23:00:00.000Z	defillama-api	5.261806823853021	\N	501594196	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-03T23:00:00.000Z	defillama-api	5.285712312641522	\N	501018092	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-04T23:00:00.000Z	defillama-api	5.004499483618474	\N	501752351	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-05T23:00:00.000Z	defillama-api	5.230464787686628	\N	499844002	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-06T23:00:00.000Z	defillama-api	5.218724566091737	\N	498833400	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-07T23:00:00.000Z	defillama-api	5.273114997450534	\N	497867441	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-08T23:00:00.000Z	defillama-api	5.701208040065353	\N	498153408	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-09T23:00:00.000Z	defillama-api	5.715054583177448	\N	497451096	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-10T23:00:00.000Z	defillama-api	5.804152403499074	\N	498529162	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-11T23:00:00.000Z	defillama-api	6.0119646892786704	\N	499079131	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-12T23:00:00.000Z	defillama-api	6.047025699373876	\N	498482351	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-13T23:00:00.000Z	defillama-api	6.206725204194186	\N	498937191	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-14T23:00:00.000Z	defillama-api	5.8613094825687995	\N	498965249	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-15T23:00:00.000Z	defillama-api	5.408535785633717	\N	497513504	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-16T23:00:00.000Z	defillama-api	5.635320370345198	\N	499040533	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-17T23:00:00.000Z	defillama-api	5.868221550286989	\N	499402901	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-18T23:00:00.000Z	defillama-api	6.030777333521087	\N	498921180	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-19T23:00:00.000Z	defillama-api	5.746094115721689	\N	499170507	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-20T23:00:00.000Z	defillama-api	5.683760163321949	\N	499097089	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-21T23:00:00.000Z	defillama-api	5.67349044544585	\N	497510293	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-22T23:00:00.000Z	defillama-api	4.920103073757787	\N	497288134	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-23T23:00:00.000Z	defillama-api	4.7722068121203165	\N	497237393	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-24T23:00:00.000Z	defillama-api	4.776087541458196	\N	498568839	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-25T23:00:00.000Z	defillama-api	4.444425931282581	\N	496900143	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-26T23:00:00.000Z	defillama-api	4.514772728470007	\N	492552332	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-27T23:00:00.000Z	defillama-api	4.6036282657979655	\N	491273729	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-28T23:00:00.000Z	defillama-api	4.652589037235089	\N	492262849	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-29T23:00:00.000Z	defillama-api	4.497403278591605	\N	491621231	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-09-30T23:00:00.000Z	defillama-api	4.35509423084568	\N	492507816	\N	\N
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
