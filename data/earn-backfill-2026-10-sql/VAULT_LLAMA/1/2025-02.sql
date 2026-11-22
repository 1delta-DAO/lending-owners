-- Generated from VAULT_LLAMA/1/2025-02.ndjson (84 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-01T23:00:00.000Z	defillama-api	7.961335143136239	\N	44518066	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-02T23:00:00.000Z	defillama-api	8.06801318553596	\N	40560838	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-03T23:00:00.000Z	defillama-api	8.029002822595999	\N	40116692	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-04T23:00:00.000Z	defillama-api	7.948341492181044	\N	36413156	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-05T23:00:00.000Z	defillama-api	7.574169019974875	\N	37511398	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-06T23:00:00.000Z	defillama-api	8.059554287953574	\N	31276845	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-07T23:00:00.000Z	defillama-api	8.10772798978121	\N	29944294	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-08T23:00:00.000Z	defillama-api	8.198488179544938	\N	30301837	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-09T23:00:00.000Z	defillama-api	8.51271451729474	\N	30318702	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-10T23:00:00.000Z	defillama-api	8.32312527379031	\N	30674470	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-11T23:00:00.000Z	defillama-api	8.09783290023347	\N	30094528	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-12T23:00:00.000Z	defillama-api	8.090114156189543	\N	30778109	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-13T23:00:00.000Z	defillama-api	8.097372142401582	\N	29826152	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-14T23:00:00.000Z	defillama-api	8.840136875321036	\N	30308661	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-15T23:00:00.000Z	defillama-api	9.452250854025124	\N	29975417	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-16T23:00:00.000Z	defillama-api	9.691379967335934	\N	30166500	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-17T23:00:00.000Z	defillama-api	9.901612282092742	\N	31296454	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-18T23:00:00.000Z	defillama-api	9.84657412885781	\N	31025451	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-19T23:00:00.000Z	defillama-api	9.854666100750364	\N	31659700	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-20T23:00:00.000Z	defillama-api	9.993112625394929	\N	32327882	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-21T23:00:00.000Z	defillama-api	10.274384274566728	\N	31263208	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-22T23:00:00.000Z	defillama-api	9.83109462637799	\N	32341319	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-23T23:00:00.000Z	defillama-api	9.860964058105992	\N	33064206	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-24T23:00:00.000Z	defillama-api	9.635217929115925	\N	30101042	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-25T23:00:00.000Z	defillama-api	9.803836389110643	\N	30073416	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-26T23:00:00.000Z	defillama-api	9.92882570400866	\N	28244290	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-27T23:00:00.000Z	defillama-api	9.854049889668204	\N	27607767	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-02-28T23:00:00.000Z	defillama-api	10.306124747216927	\N	26249961	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-01T20:00:00.000Z	defillama-api	20.473662221576205	\N	16317890	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-02T20:00:00.000Z	defillama-api	21.143349922070342	\N	11319763	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-03T22:00:00.000Z	defillama-api	21.987629828856825	\N	12544929	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-04T23:00:00.000Z	defillama-api	20.189777277224152	\N	12187020	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-05T23:00:00.000Z	defillama-api	20.765250504695132	\N	13009309	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-06T21:00:00.000Z	defillama-api	20.508051001399963	\N	11721349	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-07T23:00:00.000Z	defillama-api	20.996947272067246	\N	12891414	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-08T22:00:00.000Z	defillama-api	21.85484474352961	\N	14134723	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-09T15:00:00.000Z	defillama-api	21.897093715850247	\N	14189753	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-10T23:00:00.000Z	defillama-api	22.92858485155591	\N	14969305	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-11T23:00:00.000Z	defillama-api	23.63565975898041	\N	14393675	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-12T23:00:00.000Z	defillama-api	21.89286846849825	\N	14825307	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-13T17:00:00.000Z	defillama-api	22.32301111320112	\N	14860058	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-14T23:00:00.000Z	defillama-api	23.098306189339723	\N	15360816	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-15T23:00:00.000Z	defillama-api	23.70387222505599	\N	14749547	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-16T19:00:00.000Z	defillama-api	24.22900450831378	\N	15054686	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-17T19:00:00.000Z	defillama-api	22.283334121908638	\N	15109333	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-18T23:00:00.000Z	defillama-api	23.034753819572984	\N	13533341	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-19T23:00:00.000Z	defillama-api	22.59291086694759	\N	15008605	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-20T20:00:00.000Z	defillama-api	23.062731903422673	\N	15296837	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-21T23:00:00.000Z	defillama-api	22.761275139870918	\N	14008994	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-22T22:00:00.000Z	defillama-api	23.331975532414617	\N	14544201	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-23T21:00:00.000Z	defillama-api	23.882593745838676	\N	14518434	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-24T22:00:00.000Z	defillama-api	24.479020250822714	\N	13092359	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-25T21:00:00.000Z	defillama-api	25.058056998972233	\N	12773700	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-26T21:00:00.000Z	defillama-api	25.546087773165027	\N	13479946	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-27T23:00:00.000Z	defillama-api	26.04313973755268	\N	13119324	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-02-28T23:00:00.000Z	defillama-api	26.56511673997386	\N	12968268	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-01T23:00:00.000Z	defillama-api	16.514504618214687	\N	1044983531	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-02T23:00:00.000Z	defillama-api	14.968575262486183	\N	1045370496	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-03T23:00:00.000Z	defillama-api	16.422072255650733	\N	1032068275	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-04T23:00:00.000Z	defillama-api	14.042945689496378	\N	1028897386	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-05T23:00:00.000Z	defillama-api	12.565516598428417	\N	1035125550	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-06T23:00:00.000Z	defillama-api	12.424451876924536	\N	1036380774	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-07T23:00:00.000Z	defillama-api	12.621811682222983	\N	1031931478	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-08T23:00:00.000Z	defillama-api	13.83024432897173	\N	1033514598	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-09T23:00:00.000Z	defillama-api	13.24622327345537	\N	1033426782	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-10T23:00:00.000Z	defillama-api	12.9574485541184	\N	1033507822	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-11T23:00:00.000Z	defillama-api	13.025137941014009	\N	1035429628	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-12T23:00:00.000Z	defillama-api	13.357667848623578	\N	1034469163	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-13T23:00:00.000Z	defillama-api	12.977335366315401	\N	1026589891	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-14T23:00:00.000Z	defillama-api	13.57922444249482	\N	1022088521	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-15T23:00:00.000Z	defillama-api	13.254114976746223	\N	1019638315	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-16T23:00:00.000Z	defillama-api	13.061001425995755	\N	1018234633	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-17T23:00:00.000Z	defillama-api	12.466675640609992	\N	1017730377	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-18T23:00:00.000Z	defillama-api	11.566434664445069	\N	1005898078	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-19T23:00:00.000Z	defillama-api	11.123488834030582	\N	1000054567	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-20T23:00:00.000Z	defillama-api	11.357445975690439	\N	996212447	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-21T23:00:00.000Z	defillama-api	11.336805705397524	\N	991425554	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-22T23:00:00.000Z	defillama-api	12.455869538996467	\N	989936374	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-23T23:00:00.000Z	defillama-api	12.0094498186063	\N	990691914	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-24T23:00:00.000Z	defillama-api	10.263808551869147	\N	988763714	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-25T23:00:00.000Z	defillama-api	12.473869904994217	\N	974775513	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-26T23:00:00.000Z	defillama-api	12.909947082562212	\N	965943114	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-27T23:00:00.000Z	defillama-api	12.330067245613918	\N	962588493	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-02-28T23:00:00.000Z	defillama-api	13.268846623049058	\N	959010849	\N	\N
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
