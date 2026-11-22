-- Generated from VAULT_LLAMA/8453/2026-10.ndjson (148 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-01T22:00:00.000Z	defillama-api	17.596539767694708	\N	839025	1.18492	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-02T23:00:00.000Z	defillama-api	17.596539767694708	\N	834769	1.18492	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-03T22:00:00.000Z	defillama-api	17.596539767694708	\N	894851	1.18492	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-04T23:00:00.000Z	defillama-api	17.596539767694708	\N	869822	1.18492	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-05T23:00:00.000Z	defillama-api	33.38944930462162	\N	899979	1.19253	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-06T23:00:00.000Z	defillama-api	50.90094774153897	\N	896540	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-07T23:00:00.000Z	defillama-api	50.90094774153897	\N	938586	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-08T23:00:00.000Z	defillama-api	50.90094774153897	\N	888477	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-09T23:00:00.000Z	defillama-api	50.90094774153897	\N	842266	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-10T23:00:00.000Z	defillama-api	50.90094774153897	\N	906688	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-11T22:00:00.000Z	defillama-api	50.90094774153897	\N	888488	1.19654	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-12T23:00:00.000Z	defillama-api	35.84769247204633	\N	867062	1.20076	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-10-13T23:00:00.000Z	defillama-api	18.336193334889117	\N	900724	1.20076	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-01T22:00:00.000Z	defillama-api	35.941775299974665	\N	101999	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-02T23:00:00.000Z	defillama-api	29.374918133129313	\N	139069	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-03T22:00:00.000Z	defillama-api	30.918083642106353	\N	139487	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-04T23:00:00.000Z	defillama-api	30.267765276548175	\N	139303	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-05T23:00:00.000Z	defillama-api	29.643780831634103	\N	150065	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-06T23:00:00.000Z	defillama-api	28.504013706154296	\N	149589	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-07T23:00:00.000Z	defillama-api	21.40044789058493	\N	148311	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-08T23:00:00.000Z	defillama-api	21.122885411983816	\N	144831	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-09T23:00:00.000Z	defillama-api	21.01590556620181	\N	146282	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-10T23:00:00.000Z	defillama-api	22.07250310206632	\N	147365	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-11T22:00:00.000Z	defillama-api	21.59062253461741	\N	147763	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-12T23:00:00.000Z	defillama-api	21.22626462437438	\N	147168	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-10-13T23:00:00.000Z	defillama-api	21.74729420225674	\N	141421	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-01T22:00:00.000Z	defillama-api	16.671083854191693	\N	414435	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-02T23:00:00.000Z	defillama-api	16.523541913926465	\N	420643	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-03T22:00:00.000Z	defillama-api	17.086003984445597	\N	423428	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-04T23:00:00.000Z	defillama-api	16.839832558801504	\N	424421	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-05T23:00:00.000Z	defillama-api	16.975905970539884	\N	432114	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-06T23:00:00.000Z	defillama-api	16.597712721022617	\N	435134	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-07T23:00:00.000Z	defillama-api	16.9100540130529	\N	432591	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-08T23:00:00.000Z	defillama-api	16.763642259931544	\N	420745	1.00001	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-09T23:00:00.000Z	defillama-api	16.56264680924835	\N	431896	1.00001	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-10T23:00:00.000Z	defillama-api	17.148396056754223	\N	434844	1.00001	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-11T22:00:00.000Z	defillama-api	17.02932586944428	\N	436892	1.00002	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-12T23:00:00.000Z	defillama-api	16.86311903554838	\N	428594	1.00002	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-10-13T23:00:00.000Z	defillama-api	16.666581311852724	\N	446143	1.00003	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-01T22:00:00.000Z	defillama-api	1.6356104758585843	\N	75738	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-02T23:00:00.000Z	defillama-api	1.6332891807024907	\N	77003	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-03T22:00:00.000Z	defillama-api	1.7622411530027193	\N	77182	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-04T23:00:00.000Z	defillama-api	1.683007611674725	\N	79493	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-05T23:00:00.000Z	defillama-api	1.7491137562331005	\N	79049	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-06T23:00:00.000Z	defillama-api	1.6660148908442807	\N	78699	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-07T23:00:00.000Z	defillama-api	1.776506439554737	\N	76581	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-08T23:00:00.000Z	defillama-api	1.73328133286077	\N	75244	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-09T23:00:00.000Z	defillama-api	1.7125815421792367	\N	75981	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-10T23:00:00.000Z	defillama-api	1.875021085595563	\N	76441	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-11T22:00:00.000Z	defillama-api	1.8035574058217207	\N	76796	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-12T23:00:00.000Z	defillama-api	1.7487104180702318	\N	75683	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-10-13T23:00:00.000Z	defillama-api	1.755028682381976	\N	76832	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-01T22:00:00.000Z	defillama-api	6.468797676717486	\N	633029	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-02T23:00:00.000Z	defillama-api	7.092545440556819	\N	628329	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-03T22:00:00.000Z	defillama-api	6.477458943621173	\N	628096	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-04T23:00:00.000Z	defillama-api	6.402223071688695	\N	628533	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-05T23:00:00.000Z	defillama-api	6.513725066525922	\N	617234	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-06T23:00:00.000Z	defillama-api	6.35553807981637	\N	612140	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-07T23:00:00.000Z	defillama-api	6.340503229651517	\N	853729	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-08T23:00:00.000Z	defillama-api	6.189196099626315	\N	857001	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-09T23:00:00.000Z	defillama-api	6.275439742253752	\N	769306	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-10T23:00:00.000Z	defillama-api	6.54140764915212	\N	743241	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-11T22:00:00.000Z	defillama-api	6.490505112566325	\N	796768	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-12T23:00:00.000Z	defillama-api	6.484515960991644	\N	699634	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-10-13T23:00:00.000Z	defillama-api	6.534279207315308	\N	797016	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-01T22:00:00.000Z	defillama-api	2.8826207373100488	\N	400274	1.00842	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-02T23:00:00.000Z	defillama-api	2.9329455760063183	\N	406376	1.00845	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-03T22:00:00.000Z	defillama-api	3.0299400012978595	\N	407681	1.00849	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-04T23:00:00.000Z	defillama-api	2.993678780072173	\N	414543	1.00853	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-05T23:00:00.000Z	defillama-api	3.0216743699185145	\N	398975	1.00856	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-06T23:00:00.000Z	defillama-api	2.9538995537592427	\N	393098	1.00859	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-07T23:00:00.000Z	defillama-api	3.1058067893496855	\N	377225	1.00863	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-08T23:00:00.000Z	defillama-api	3.092728409370693	\N	361857	1.00866	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-09T23:00:00.000Z	defillama-api	3.1046822041247424	\N	365628	1.0087	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-10T23:00:00.000Z	defillama-api	3.0252834061883505	\N	678384	1.00873	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-11T22:00:00.000Z	defillama-api	2.958414000175935	\N	683366	1.00877	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-12T23:00:00.000Z	defillama-api	2.934557528178061	\N	629321	1.0088	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-10-13T23:00:00.000Z	defillama-api	2.9572782111131346	\N	636789	1.00884	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-01T22:00:00.000Z	defillama-api	35.13723890726794	\N	105013	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-02T23:00:00.000Z	defillama-api	30.69772936008519	\N	129742	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-03T22:00:00.000Z	defillama-api	32.33411850267487	\N	129723	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-04T23:00:00.000Z	defillama-api	31.656810091718057	\N	130148	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-05T23:00:00.000Z	defillama-api	31.989197150394943	\N	132401	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-06T23:00:00.000Z	defillama-api	30.818614569128044	\N	133242	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-07T23:00:00.000Z	defillama-api	31.474570565848126	\N	133768	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-08T23:00:00.000Z	defillama-api	30.20403504585545	\N	136931	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-09T23:00:00.000Z	defillama-api	27.674270778987875	\N	157010	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-10T23:00:00.000Z	defillama-api	28.227556206061877	\N	165272	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-11T22:00:00.000Z	defillama-api	27.895933809318763	\N	165894	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-12T23:00:00.000Z	defillama-api	26.70504217121561	\N	171232	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-10-13T23:00:00.000Z	defillama-api	26.733252034460975	\N	172865	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-05T23:00:00.000Z	defillama-api	13.976193923781466	\N	26431	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-06T23:00:00.000Z	defillama-api	13.976193923781466	\N	26683	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-07T23:00:00.000Z	defillama-api	13.976193923781466	\N	27225	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-08T23:00:00.000Z	defillama-api	13.976193923781466	\N	16578	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-09T23:00:00.000Z	defillama-api	13.976193923781466	\N	17071	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-10T23:00:00.000Z	defillama-api	13.976193923781466	\N	17066	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-11T22:00:00.000Z	defillama-api	13.976193923781466	\N	17156	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-12T23:00:00.000Z	defillama-api	13.976193923781466	\N	16934	1	assets_per_share
VAULT_LLAMA	8453	0x4855b2756910b7525d5b466292c394669ee74e7e	2026-10-13T23:00:00.000Z	defillama-api	13.976193923781466	\N	16844	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-05T23:00:00.000Z	defillama-api	13.976193923781466	\N	10943	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-06T23:00:00.000Z	defillama-api	13.976193923781466	\N	13895	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-07T23:00:00.000Z	defillama-api	13.976193923781466	\N	13904	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-08T23:00:00.000Z	defillama-api	13.976193923781466	\N	13748	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-09T23:00:00.000Z	defillama-api	13.976193923781466	\N	14053	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-10T23:00:00.000Z	defillama-api	13.976193923781466	\N	14284	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-11T22:00:00.000Z	defillama-api	13.976193923781466	\N	14304	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-12T23:00:00.000Z	defillama-api	13.976193923781466	\N	14439	1	assets_per_share
VAULT_LLAMA	8453	0x7778192c7e2c22a27c63d63485699888148d5919	2026-10-13T23:00:00.000Z	defillama-api	13.976193923781466	\N	14502	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-01T22:00:00.000Z	defillama-api	50.026813108061674	\N	47136	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-02T23:00:00.000Z	defillama-api	38.804105886924845	\N	77002	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-03T22:00:00.000Z	defillama-api	37.25297795043048	\N	92257	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-04T23:00:00.000Z	defillama-api	33.576427353665395	\N	93128	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-05T23:00:00.000Z	defillama-api	23.730567469470998	\N	148559	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-06T23:00:00.000Z	defillama-api	22.261421515779034	\N	149543	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-07T23:00:00.000Z	defillama-api	21.756168342079718	\N	205726	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-08T23:00:00.000Z	defillama-api	20.274686962906685	\N	198252	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-09T23:00:00.000Z	defillama-api	20.580303151263024	\N	187704	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-10T23:00:00.000Z	defillama-api	21.400802912197037	\N	190334	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-11T22:00:00.000Z	defillama-api	21.088836248495113	\N	190428	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-12T23:00:00.000Z	defillama-api	20.523999664590065	\N	191238	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-10-13T23:00:00.000Z	defillama-api	20.550816050501908	\N	191736	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-01T22:00:00.000Z	defillama-api	50.026813108061674	\N	25567	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-02T23:00:00.000Z	defillama-api	38.804105886924845	\N	30768	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-03T22:00:00.000Z	defillama-api	37.25297795043048	\N	30760	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-04T23:00:00.000Z	defillama-api	33.576427353665395	\N	30878	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-05T23:00:00.000Z	defillama-api	23.730567469470998	\N	83993	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-06T23:00:00.000Z	defillama-api	22.261421515779034	\N	85339	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-07T23:00:00.000Z	defillama-api	21.756168342079718	\N	87041	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-08T23:00:00.000Z	defillama-api	20.274686962906685	\N	87995	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-09T23:00:00.000Z	defillama-api	20.580303151263024	\N	87982	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-10T23:00:00.000Z	defillama-api	21.400802912197037	\N	87576	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-11T22:00:00.000Z	defillama-api	21.088836248495113	\N	87677	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-12T23:00:00.000Z	defillama-api	20.523999664590065	\N	88991	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-10-13T23:00:00.000Z	defillama-api	20.550816050501908	\N	89301	1	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-01T23:00:00.000Z	defillama-api	6.8809385549428725	\N	463447	1.01856	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-02T23:00:00.000Z	defillama-api	7.760435625314699	\N	470475	1.01879	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-03T22:00:00.000Z	defillama-api	7.532637093277117	\N	470583	1.01898	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-04T23:00:00.000Z	defillama-api	7.091595215058533	\N	470659	1.01919	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-05T23:00:00.000Z	defillama-api	6.780256666516493	\N	470960	1.01938	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-06T23:00:00.000Z	defillama-api	6.265550254624941	\N	472185	1.01955	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-07T23:00:00.000Z	defillama-api	6.658237068890571	\N	465293	1.01974	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-08T22:00:00.000Z	defillama-api	7.168976621940715	\N	456048	1.01993	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-09T23:00:00.000Z	defillama-api	6.51255356522995	\N	456889	1.02011	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-10T23:00:00.000Z	defillama-api	7.0592658406809505	\N	452585	1.02032	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-11T23:00:00.000Z	defillama-api	6.73707567493409	\N	452665	1.02051	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-12T23:00:00.000Z	defillama-api	6.508899713608685	\N	453151	1.02069	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-10-13T23:00:00.000Z	defillama-api	6.793804907445633	\N	452269	1.02088	assets_per_share
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
