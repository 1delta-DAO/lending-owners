-- Generated from VAULT_LLAMA/1/2025-04.ndjson (90 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-01T23:00:00.000Z	defillama-api	7.498269320649342	\N	25052804	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-02T23:00:00.000Z	defillama-api	7.556228874605608	\N	22491983	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-03T23:00:00.000Z	defillama-api	7.587647236917405	\N	22548368	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-04T23:00:00.000Z	defillama-api	7.755160718403431	\N	21936738	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-05T23:00:00.000Z	defillama-api	7.594682546852027	\N	22051400	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-06T23:00:00.000Z	defillama-api	7.484222508935545	\N	19258533	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-07T23:00:00.000Z	defillama-api	7.737151249287422	\N	19312372	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-08T23:00:00.000Z	defillama-api	8.024370035641937	\N	17678388	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-09T23:00:00.000Z	defillama-api	7.862687451520856	\N	20282495	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-10T23:00:00.000Z	defillama-api	8.029104357376582	\N	18613178	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-11T23:00:00.000Z	defillama-api	8.036247504250582	\N	22171642	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-12T23:00:00.000Z	defillama-api	7.445503445779877	\N	21471585	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-13T23:00:00.000Z	defillama-api	7.808874017811718	\N	20668933	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-14T23:00:00.000Z	defillama-api	7.687612779960773	\N	21428488	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-15T23:00:00.000Z	defillama-api	7.805433039109744	\N	22517071	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-16T23:00:00.000Z	defillama-api	7.883336124692164	\N	22777933	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-17T23:00:00.000Z	defillama-api	7.564703177465049	\N	22137038	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-18T23:00:00.000Z	defillama-api	7.812980224386479	\N	22418304	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-19T23:00:00.000Z	defillama-api	8.113675827203792	\N	22772162	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-20T23:00:00.000Z	defillama-api	7.944277299998248	\N	22294762	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-21T23:00:00.000Z	defillama-api	7.905449699663336	\N	22247532	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-22T23:00:00.000Z	defillama-api	8.227937467353286	\N	24873046	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-23T23:00:00.000Z	defillama-api	8.084672592190145	\N	24813554	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-24T23:00:00.000Z	defillama-api	8.572557716490792	\N	24274181	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-25T23:00:00.000Z	defillama-api	8.478820106816443	\N	26173072	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-26T23:00:00.000Z	defillama-api	8.191108351596199	\N	26481312	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-27T23:00:00.000Z	defillama-api	7.768725765089357	\N	26056294	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-28T23:00:00.000Z	defillama-api	7.752125178583924	\N	26782937	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-29T23:00:00.000Z	defillama-api	7.736198222829671	\N	26874882	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2025-04-30T23:00:00.000Z	defillama-api	7.5644805011876315	\N	27152406	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-01T21:00:00.000Z	defillama-api	19.767410095994364	\N	14089961	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-02T23:00:00.000Z	defillama-api	20.113006479505202	\N	11907966	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-03T22:00:00.000Z	defillama-api	20.624086349130266	\N	11446957	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-04T23:00:00.000Z	defillama-api	21.23122232262631	\N	12918472	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-05T22:00:00.000Z	defillama-api	21.791921189162622	\N	13307184	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-06T19:00:00.000Z	defillama-api	22.236004209119642	\N	11479182	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-07T23:00:00.000Z	defillama-api	22.846003463428133	\N	13201711	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-08T22:00:00.000Z	defillama-api	17.375278675046957	\N	11549187	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-09T22:00:00.000Z	defillama-api	17.694027161851977	\N	13105978	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-10T23:00:00.000Z	defillama-api	16.932446283490776	\N	13423664	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-11T21:00:00.000Z	defillama-api	17.411321421434423	\N	15416364	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-12T22:00:00.000Z	defillama-api	17.904904397525456	\N	15226057	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-13T23:00:00.000Z	defillama-api	18.393026202900842	\N	13815892	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-14T20:00:00.000Z	defillama-api	16.536061502492316	\N	14151735	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-15T21:00:00.000Z	defillama-api	16.46024163051152	\N	13706062	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-16T22:00:00.000Z	defillama-api	16.853749125900208	\N	15548998	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-17T22:00:00.000Z	defillama-api	17.416118764757016	\N	14495581	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-18T21:00:00.000Z	defillama-api	18.038050806623573	\N	14534248	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-19T23:00:00.000Z	defillama-api	18.7317805426801	\N	14879182	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-20T23:00:00.000Z	defillama-api	19.372759108904347	\N	15131416	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-21T21:00:00.000Z	defillama-api	19.942299203989933	\N	15304978	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-22T23:00:00.000Z	defillama-api	20.61871620959721	\N	16768922	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-23T22:00:00.000Z	defillama-api	16.97613424873623	\N	16070836	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-24T21:00:00.000Z	defillama-api	17.48372832430789	\N	17226264	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-25T21:00:00.000Z	defillama-api	18.056684889700136	\N	16728228	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-26T23:00:00.000Z	defillama-api	18.242497039366867	\N	17117382	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-27T23:00:00.000Z	defillama-api	18.803180500626127	\N	16513029	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-28T22:00:00.000Z	defillama-api	19.357129054853317	\N	17158041	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-29T23:00:00.000Z	defillama-api	19.93011643079967	\N	17052415	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2025-04-30T22:00:00.000Z	defillama-api	17.80332060015155	\N	17834384	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-01T23:00:00.000Z	defillama-api	7.98304397946481	\N	782890896	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-02T23:00:00.000Z	defillama-api	7.093831080950963	\N	779748941	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-03T23:00:00.000Z	defillama-api	8.139941824580887	\N	729373042	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-04T23:00:00.000Z	defillama-api	10.00770702468401	\N	667952659	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-05T23:00:00.000Z	defillama-api	9.556078219929987	\N	660156703	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-06T23:00:00.000Z	defillama-api	10.13190016685428	\N	632830242	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-07T23:00:00.000Z	defillama-api	10.69897051593216	\N	613486156	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-08T23:00:00.000Z	defillama-api	11.264040979952483	\N	603047503	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-09T23:00:00.000Z	defillama-api	13.667334924605257	\N	599464393	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-10T23:00:00.000Z	defillama-api	12.923191419389468	\N	602705493	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-11T23:00:00.000Z	defillama-api	13.479589412668247	\N	583415993	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-12T23:00:00.000Z	defillama-api	15.564692961689275	\N	587288835	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-13T23:00:00.000Z	defillama-api	13.802513429794772	\N	586738836	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-14T23:00:00.000Z	defillama-api	13.40960113829226	\N	580797520	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-15T23:00:00.000Z	defillama-api	12.3462434867605	\N	583916136	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-16T23:00:00.000Z	defillama-api	11.934625687715084	\N	580619159	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-17T23:00:00.000Z	defillama-api	11.4870085571539	\N	576207687	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-18T23:00:00.000Z	defillama-api	10.574661834183985	\N	578561350	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-19T23:00:00.000Z	defillama-api	10.995568315053106	\N	575494383	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-20T23:00:00.000Z	defillama-api	13.01294396398589	\N	579261799	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-21T23:00:00.000Z	defillama-api	12.621114943556222	\N	578582129	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-22T23:00:00.000Z	defillama-api	12.668974237683983	\N	578396239	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-23T23:00:00.000Z	defillama-api	12.630114426315231	\N	578609011	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-24T23:00:00.000Z	defillama-api	13.158240935240428	\N	578603735	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-25T23:00:00.000Z	defillama-api	14.223028476578747	\N	568393521	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-26T23:00:00.000Z	defillama-api	14.090858902093828	\N	569064336	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-27T23:00:00.000Z	defillama-api	12.9301335974219	\N	568959586	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-28T23:00:00.000Z	defillama-api	12.99058810602105	\N	568288701	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-29T23:00:00.000Z	defillama-api	12.427692587024808	\N	565263838	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2025-04-30T23:00:00.000Z	defillama-api	12.071508576738665	\N	564831194	\N	\N
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
