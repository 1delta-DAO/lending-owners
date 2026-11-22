-- Generated from VAULT_LLAMA/8453/2026-09.ndjson (213 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-01T21:00:00.000Z	defillama-api	\N	\N	676445	1.16439	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-02T23:00:00.000Z	defillama-api	18.479582852748422	\N	692098	1.16853	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-03T23:00:00.000Z	defillama-api	18.479582852748422	\N	699007	1.16853	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-04T23:00:00.000Z	defillama-api	18.479582852748422	\N	699393	1.16853	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-05T23:00:00.000Z	defillama-api	18.479582852748422	\N	696132	1.16853	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-06T23:00:00.000Z	defillama-api	18.479582852748422	\N	695731	1.16853	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-07T23:00:00.000Z	defillama-api	36.81681464335895	\N	675594	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-08T23:00:00.000Z	defillama-api	18.33723389133013	\N	684201	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-09T23:00:00.000Z	defillama-api	18.33723389133013	\N	728104	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-10T23:00:00.000Z	defillama-api	18.33723389133013	\N	833640	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-11T23:00:00.000Z	defillama-api	18.33723389133013	\N	754804	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-12T23:00:00.000Z	defillama-api	18.33723389133013	\N	728168	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-13T23:00:00.000Z	defillama-api	18.33723389133013	\N	745380	1.17264	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-14T23:00:00.000Z	defillama-api	18.358991744449327	\N	708262	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-15T23:00:00.000Z	defillama-api	18.358991744449327	\N	668138	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-16T23:00:00.000Z	defillama-api	18.358991744449327	\N	642279	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-17T23:00:00.000Z	defillama-api	18.358991744449327	\N	650121	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-18T23:00:00.000Z	defillama-api	18.358991744449327	\N	673119	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-19T23:00:00.000Z	defillama-api	18.358991744449327	\N	712515	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-20T23:00:00.000Z	defillama-api	18.358991744449327	\N	691511	1.17678	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-21T23:00:00.000Z	defillama-api	18.3399893352032	\N	711198	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-22T23:00:00.000Z	defillama-api	18.3399893352032	\N	725822	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-23T23:00:00.000Z	defillama-api	18.3399893352032	\N	787805	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-24T23:00:00.000Z	defillama-api	18.3399893352032	\N	802415	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-25T23:00:00.000Z	defillama-api	18.3399893352032	\N	821036	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-26T23:00:00.000Z	defillama-api	18.3399893352032	\N	863519	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-27T23:00:00.000Z	defillama-api	18.3399893352032	\N	834042	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-28T21:00:00.000Z	defillama-api	\N	\N	804119	1.18093	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-29T23:00:00.000Z	defillama-api	17.596539767694708	\N	867163	1.18492	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-09-30T23:00:00.000Z	defillama-api	17.596539767694708	\N	941484	1.18492	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-12T23:00:00.000Z	defillama-api	46.21845145962311	\N	61995	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-13T23:00:00.000Z	defillama-api	44.966188698936094	\N	65524	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-14T23:00:00.000Z	defillama-api	43.61229872600347	\N	65434	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-15T23:00:00.000Z	defillama-api	41.27230436452578	\N	67671	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-16T23:00:00.000Z	defillama-api	39.11144956703083	\N	70677	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-17T23:00:00.000Z	defillama-api	35.60711316197285	\N	82963	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-18T23:00:00.000Z	defillama-api	34.36672226797555	\N	91482	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-19T23:00:00.000Z	defillama-api	35.82460976510049	\N	91610	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-20T23:00:00.000Z	defillama-api	34.76645839697312	\N	93368	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-21T23:00:00.000Z	defillama-api	27.883949204010605	\N	93860	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-22T23:00:00.000Z	defillama-api	31.51351440600081	\N	113802	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-23T23:00:00.000Z	defillama-api	33.94777855945108	\N	110133	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-24T23:00:00.000Z	defillama-api	34.106830342395256	\N	111768	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-25T23:00:00.000Z	defillama-api	34.26101475803023	\N	112294	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-26T23:00:00.000Z	defillama-api	35.29919598541653	\N	112282	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-27T23:00:00.000Z	defillama-api	36.96543565325783	\N	102195	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-28T23:00:00.000Z	defillama-api	35.76715788504714	\N	99991	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-29T23:00:00.000Z	defillama-api	36.381964986276216	\N	103390	1	assets_per_share
VAULT_LLAMA	8453	0x02b12a394f0a98b80e53d85f6831041932f1b621	2026-09-30T23:00:00.000Z	defillama-api	38.774096407223624	\N	103516	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-01T23:00:00.000Z	defillama-api	27.055204118653364	\N	121983	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-02T23:00:00.000Z	defillama-api	28.458605951797722	\N	114960	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-03T23:00:00.000Z	defillama-api	28.31853767162329	\N	117108	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-04T23:00:00.000Z	defillama-api	26.86406804528474	\N	128468	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-05T23:00:00.000Z	defillama-api	26.774591395195557	\N	129383	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-06T23:00:00.000Z	defillama-api	27.543022720166732	\N	130082	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-07T23:00:00.000Z	defillama-api	20.275919385071006	\N	122845	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-08T23:00:00.000Z	defillama-api	20.892949047635057	\N	118088	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-09T23:00:00.000Z	defillama-api	22.812639834768333	\N	111651	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-10T23:00:00.000Z	defillama-api	27.62638347526547	\N	110197	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-11T23:00:00.000Z	defillama-api	25.123502817336885	\N	112888	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-12T23:00:00.000Z	defillama-api	24.25957628062747	\N	113247	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-13T23:00:00.000Z	defillama-api	24.021916970795587	\N	115522	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-14T23:00:00.000Z	defillama-api	18.101720816687816	\N	306179	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-15T23:00:00.000Z	defillama-api	17.617143625514586	\N	309963	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-16T23:00:00.000Z	defillama-api	17.238493819604628	\N	313147	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-17T23:00:00.000Z	defillama-api	17.12345701392337	\N	321234	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-18T23:00:00.000Z	defillama-api	15.854691700312173	\N	404955	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-19T23:00:00.000Z	defillama-api	16.42987852967792	\N	396755	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-20T23:00:00.000Z	defillama-api	16.181438326867692	\N	398131	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-21T23:00:00.000Z	defillama-api	7.491422375238699	\N	398790	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-22T23:00:00.000Z	defillama-api	16.316209992695008	\N	412028	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-23T23:00:00.000Z	defillama-api	16.735088578911927	\N	406455	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-24T23:00:00.000Z	defillama-api	16.93066487327144	\N	375933	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-25T23:00:00.000Z	defillama-api	17.04758392371275	\N	402968	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-26T23:00:00.000Z	defillama-api	17.391851952197612	\N	402087	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-27T23:00:00.000Z	defillama-api	17.172604049164875	\N	402806	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-28T23:00:00.000Z	defillama-api	16.571840258450266	\N	411067	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-29T23:00:00.000Z	defillama-api	17.04519750624911	\N	408959	1	assets_per_share
VAULT_LLAMA	8453	0xc441a2cc3a528b6312740448a70cc4d40f4d7bfc	2026-09-30T23:00:00.000Z	defillama-api	17.780269403999682	\N	408868	1	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-01T23:00:00.000Z	defillama-api	1.1731321546193385	\N	71247	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-02T23:00:00.000Z	defillama-api	1.200564051373476	\N	71025	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-03T23:00:00.000Z	defillama-api	1.1427753559445364	\N	74890	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-04T23:00:00.000Z	defillama-api	1.177678111830005	\N	73506	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-05T23:00:00.000Z	defillama-api	1.1738730083976634	\N	73599	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-06T23:00:00.000Z	defillama-api	1.401256298194653	\N	73567	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-07T23:00:00.000Z	defillama-api	1.4378235242418214	\N	72513	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-08T23:00:00.000Z	defillama-api	1.452953607028462	\N	71283	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-09T23:00:00.000Z	defillama-api	1.5191031664585353	\N	70271	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-10T23:00:00.000Z	defillama-api	1.8678758380019644	\N	69315	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-11T23:00:00.000Z	defillama-api	1.7464206337081123	\N	69576	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-12T23:00:00.000Z	defillama-api	1.6624443677670797	\N	69669	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-13T23:00:00.000Z	defillama-api	1.6983659726577116	\N	69176	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-14T23:00:00.000Z	defillama-api	1.5228949653334212	\N	70748	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-15T23:00:00.000Z	defillama-api	1.5157637225371445	\N	68144	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-16T23:00:00.000Z	defillama-api	1.4447825080310395	\N	68134	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-17T23:00:00.000Z	defillama-api	1.4636560731418058	\N	68759	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-18T23:00:00.000Z	defillama-api	1.4354973274066651	\N	73071	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-19T23:00:00.000Z	defillama-api	1.5399023912010534	\N	73138	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-20T23:00:00.000Z	defillama-api	1.49473271839895	\N	73127	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-21T23:00:00.000Z	defillama-api	1.436138046884139	\N	78330	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-22T23:00:00.000Z	defillama-api	1.4859251013632502	\N	78098	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-23T23:00:00.000Z	defillama-api	1.643766169578953	\N	76673	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-24T23:00:00.000Z	defillama-api	1.6844627101164633	\N	75513	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-25T23:00:00.000Z	defillama-api	1.7166604393992202	\N	75381	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-26T23:00:00.000Z	defillama-api	0.00017996164558553573	\N	75550	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-27T23:00:00.000Z	defillama-api	0.00017996164558553573	\N	75462	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-28T23:00:00.000Z	defillama-api	1.6143883062369468	\N	74819	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-29T23:00:00.000Z	defillama-api	1.7177619167085822	\N	74899	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-09-30T23:00:00.000Z	defillama-api	1.888907542380025	\N	74935	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-01T23:00:00.000Z	defillama-api	5.259444214544828	\N	783372	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-02T23:00:00.000Z	defillama-api	5.290530663160098	\N	774780	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-03T23:00:00.000Z	defillama-api	5.274652023956605	\N	766197	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-04T23:00:00.000Z	defillama-api	5.349185555303393	\N	766645	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-05T23:00:00.000Z	defillama-api	5.316581686898303	\N	746814	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-06T23:00:00.000Z	defillama-api	5.401553693928918	\N	745794	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-07T23:00:00.000Z	defillama-api	5.358105210717667	\N	741459	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-08T23:00:00.000Z	defillama-api	5.337079808498402	\N	742687	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-09T23:00:00.000Z	defillama-api	5.411822711565151	\N	699013	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-10T23:00:00.000Z	defillama-api	5.835267561948854	\N	693694	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-11T23:00:00.000Z	defillama-api	5.614836253542421	\N	660179	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-12T23:00:00.000Z	defillama-api	5.475585853531584	\N	701418	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-13T23:00:00.000Z	defillama-api	5.467954639470918	\N	929591	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-14T23:00:00.000Z	defillama-api	16.20956346108926	\N	732505	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-15T23:00:00.000Z	defillama-api	16.170856302011316	\N	704179	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-16T23:00:00.000Z	defillama-api	16.24141317115857	\N	704172	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-17T23:00:00.000Z	defillama-api	16.33254378781146	\N	681607	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-18T23:00:00.000Z	defillama-api	16.526034067609885	\N	692697	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-19T23:00:00.000Z	defillama-api	16.657751987381175	\N	727446	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-20T23:00:00.000Z	defillama-api	16.574288997261988	\N	1039883	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-21T23:00:00.000Z	defillama-api	5.878538184234117	\N	1094174	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-22T23:00:00.000Z	defillama-api	5.959651869602567	\N	980650	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-23T23:00:00.000Z	defillama-api	6.261210167934905	\N	879774	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-24T23:00:00.000Z	defillama-api	6.25766905493208	\N	700473	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-25T23:00:00.000Z	defillama-api	5.793470244341847	\N	647879	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-26T23:00:00.000Z	defillama-api	3.829220393569699	\N	694399	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-27T23:00:00.000Z	defillama-api	3.7831866247728385	\N	692157	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-28T23:00:00.000Z	defillama-api	6.138960191393039	\N	691807	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-29T23:00:00.000Z	defillama-api	6.456320802783466	\N	634697	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-09-30T23:00:00.000Z	defillama-api	6.7122241620865	\N	631360	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-01T23:00:00.000Z	defillama-api	2.4261497738820026	\N	316314	1.00731	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-02T23:00:00.000Z	defillama-api	2.4601583234584723	\N	312083	1.00735	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-03T23:00:00.000Z	defillama-api	2.3940136657074618	\N	327563	1.00738	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-04T23:00:00.000Z	defillama-api	2.433010724089968	\N	321641	1.00742	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-05T23:00:00.000Z	defillama-api	2.4130601900651527	\N	322171	1.00745	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-06T23:00:00.000Z	defillama-api	2.4645488274188665	\N	326515	1.00749	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-07T23:00:00.000Z	defillama-api	2.443755904835143	\N	323245	1.00752	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-08T23:00:00.000Z	defillama-api	2.4384662928866874	\N	324101	1.00756	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-09T23:00:00.000Z	defillama-api	2.5362043729160177	\N	317394	1.0076	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-10T23:00:00.000Z	defillama-api	2.887876737744932	\N	316890	1.00764	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-11T23:00:00.000Z	defillama-api	2.806272884470218	\N	325065	1.00769	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-12T23:00:00.000Z	defillama-api	2.7488406111331187	\N	326682	1.00772	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-13T23:00:00.000Z	defillama-api	2.8190389574689334	\N	320316	1.00777	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-14T23:00:00.000Z	defillama-api	2.7390918717173918	\N	327461	1.0078	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-15T23:00:00.000Z	defillama-api	2.8215864301017746	\N	310661	1.00785	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-16T23:00:00.000Z	defillama-api	2.7856578228124818	\N	308600	1.0079	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-17T23:00:00.000Z	defillama-api	2.826038555170385	\N	315251	1.00794	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-18T23:00:00.000Z	defillama-api	2.7223750453941875	\N	338087	1.00798	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-19T23:00:00.000Z	defillama-api	2.8013628025291837	\N	338697	1.00801	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-20T23:00:00.000Z	defillama-api	2.7138398216663973	\N	339725	1.00805	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-21T23:00:00.000Z	defillama-api	2.6635990117540587	\N	357205	1.00808	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-22T23:00:00.000Z	defillama-api	2.624360370617751	\N	353876	1.00811	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-23T23:00:00.000Z	defillama-api	2.728145722130648	\N	345046	1.00815	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-24T23:00:00.000Z	defillama-api	2.681922888569943	\N	350062	1.00818	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-25T23:00:00.000Z	defillama-api	2.7568765638363857	\N	365006	1.00822	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-26T23:00:00.000Z	defillama-api	1.241876802993147	\N	364507	1.00825	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-27T23:00:00.000Z	defillama-api	1.2478813598448824	\N	362845	1.00829	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-28T23:00:00.000Z	defillama-api	2.697254640438018	\N	364187	1.00832	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-29T23:00:00.000Z	defillama-api	2.770290358711236	\N	395291	1.00835	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-09-30T23:00:00.000Z	defillama-api	2.915668557790241	\N	392462	1.00838	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-21T23:00:00.000Z	defillama-api	\N	\N	5086	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-22T23:00:00.000Z	defillama-api	50.76367271819038	\N	54776	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-23T23:00:00.000Z	defillama-api	50.5155742324348	\N	59993	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-24T23:00:00.000Z	defillama-api	44.18733500379801	\N	90363	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-25T23:00:00.000Z	defillama-api	36.68303731814149	\N	101119	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-26T23:00:00.000Z	defillama-api	37.81071340185349	\N	100904	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-27T23:00:00.000Z	defillama-api	36.81226798590842	\N	102373	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-28T23:00:00.000Z	defillama-api	36.064499338905875	\N	98548	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-29T23:00:00.000Z	defillama-api	38.12128518774216	\N	96198	1	assets_per_share
VAULT_LLAMA	8453	0xaf0edf09ec7f9357292f6bc6445a09aa84a31fa7	2026-09-30T23:00:00.000Z	defillama-api	39.820743534590974	\N	99065	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-09-29T23:00:00.000Z	defillama-api	9.531018035602301	\N	3779	1	assets_per_share
VAULT_LLAMA	8453	0x363600ac7173e8d91bcfee68d711bb93e992c110	2026-09-30T23:00:00.000Z	defillama-api	78.6418022286739	\N	27289	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-09-29T23:00:00.000Z	defillama-api	9.531018035602301	\N	1286	1	assets_per_share
VAULT_LLAMA	8453	0x301a1ceb684d62833101b373ab6c395349b24033	2026-09-30T23:00:00.000Z	defillama-api	78.6418022286739	\N	14372	1	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-01T23:00:00.000Z	defillama-api	6.461739258867283	\N	632555	1.01324	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-02T23:00:00.000Z	defillama-api	5.759556927387166	\N	632513	1.01339	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-03T23:00:00.000Z	defillama-api	5.641993656269051	\N	627923	1.01356	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-04T23:00:00.000Z	defillama-api	5.868080101834039	\N	625107	1.01371	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-05T23:00:00.000Z	defillama-api	6.09712926227246	\N	624435	1.01387	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-06T23:00:00.000Z	defillama-api	5.728153270112557	\N	624948	1.01404	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-07T23:00:00.000Z	defillama-api	5.6322106050998855	\N	642352	1.01419	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-08T23:00:00.000Z	defillama-api	5.43711327480878	\N	642755	1.01433	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-09T23:00:00.000Z	defillama-api	5.437529917529105	\N	599350	1.01449	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-10T23:00:00.000Z	defillama-api	6.704069868845863	\N	599451	1.01468	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-11T23:00:00.000Z	defillama-api	7.5533172772423995	\N	599575	1.01489	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-12T23:00:00.000Z	defillama-api	6.970048979582089	\N	599672	1.01509	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-13T22:00:00.000Z	defillama-api	6.687610030553515	\N	599719	1.01525	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-14T23:00:00.000Z	defillama-api	6.039306255090082	\N	599933	1.01543	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-15T23:00:00.000Z	defillama-api	6.685271929640635	\N	595631	1.01561	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-16T23:00:00.000Z	defillama-api	6.625111521785243	\N	593448	1.0158	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-17T23:00:00.000Z	defillama-api	6.516488913277385	\N	567080	1.01598	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-18T23:00:00.000Z	defillama-api	6.681623679938298	\N	577261	1.01616	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-19T23:00:00.000Z	defillama-api	6.608545247033248	\N	577289	1.01635	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-20T23:00:00.000Z	defillama-api	6.584485705474208	\N	576905	1.01653	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-21T23:00:00.000Z	defillama-api	5.796225688214918	\N	587992	1.0167	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-22T23:00:00.000Z	defillama-api	6.317947103084975	\N	587691	1.01687	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-23T23:00:00.000Z	defillama-api	6.9029674008902475	\N	586988	1.01706	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-24T23:00:00.000Z	defillama-api	6.973219665695751	\N	588534	1.01725	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-25T23:00:00.000Z	defillama-api	6.399962697400952	\N	588695	1.01743	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-26T23:00:00.000Z	defillama-api	6.707904382352581	\N	588780	1.01762	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-27T23:00:00.000Z	defillama-api	6.647757979294511	\N	584476	1.0178	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-28T23:00:00.000Z	defillama-api	5.7374167433010825	\N	469159	1.01796	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-29T23:00:00.000Z	defillama-api	7.1704660321358915	\N	461295	1.01816	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-09-30T23:00:00.000Z	defillama-api	7.358591074080323	\N	463038	1.01837	assets_per_share
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
