-- Generated from VAULT_LLAMA_LST/1/2026-05.ndjson (93 vault rows)
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
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-01T23:00:00.000Z	defillama-api	\N	\N	39637672	1.12104	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-02T23:00:00.000Z	defillama-api	\N	\N	40624178	1.12111	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-03T23:00:00.000Z	defillama-api	\N	\N	40902329	1.12119	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-04T23:00:00.000Z	defillama-api	\N	\N	40834087	1.12123	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-05T23:00:00.000Z	defillama-api	\N	\N	40865859	1.12123	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-06T23:00:00.000Z	defillama-api	\N	\N	40211368	1.12144	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-07T23:00:00.000Z	defillama-api	\N	\N	39299460	1.12152	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-08T23:00:00.000Z	defillama-api	\N	\N	39660293	1.12162	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-09T23:00:00.000Z	defillama-api	\N	\N	39941911	1.12167	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-10T23:00:00.000Z	defillama-api	\N	\N	40751999	1.12167	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-11T23:00:00.000Z	defillama-api	\N	\N	40126902	1.12167	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-12T23:00:00.000Z	defillama-api	\N	\N	39496747	1.12195	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-13T23:00:00.000Z	defillama-api	\N	\N	38383501	1.12203	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-14T23:00:00.000Z	defillama-api	\N	\N	39125598	1.12212	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-15T23:00:00.000Z	defillama-api	\N	\N	37740601	1.12218	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-16T23:00:00.000Z	defillama-api	\N	\N	37877684	1.12225	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-17T23:00:00.000Z	defillama-api	\N	\N	38059116	1.12232	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-18T23:00:00.000Z	defillama-api	\N	\N	36997915	1.1224	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-19T23:00:00.000Z	defillama-api	\N	\N	36061968	1.12246	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-20T23:00:00.000Z	defillama-api	\N	\N	36502118	1.12254	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-21T23:00:00.000Z	defillama-api	\N	\N	37174231	1.12264	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-22T23:00:00.000Z	defillama-api	\N	\N	36137038	1.12271	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-23T23:00:00.000Z	defillama-api	\N	\N	36005551	1.12276	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-24T23:00:00.000Z	defillama-api	\N	\N	35633911	1.12276	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-25T23:00:00.000Z	defillama-api	\N	\N	35897668	1.12291	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-26T23:00:00.000Z	defillama-api	\N	\N	35052478	1.12301	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-27T23:00:00.000Z	defillama-api	\N	\N	34529789	1.12308	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-28T23:00:00.000Z	defillama-api	\N	\N	34196406	1.12316	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-29T23:00:00.000Z	defillama-api	\N	\N	34221189	1.12323	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-30T23:00:00.000Z	defillama-api	\N	\N	34235483	1.1233	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-05-31T23:00:00.000Z	defillama-api	\N	\N	34009699	1.12339	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-01T23:00:00.000Z	defillama-api	1.7182429814965872	\N	805441406	1.10779	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-02T23:00:00.000Z	defillama-api	1.7180469143340815	\N	816900373	1.10779	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-03T23:00:00.000Z	defillama-api	1.7184299455408336	\N	823319747	1.10791	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-04T23:00:00.000Z	defillama-api	2.2847398341241387	\N	826989103	1.10803	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-05T23:00:00.000Z	defillama-api	1.71861690958508	\N	831676420	1.10803	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-06T23:00:00.000Z	defillama-api	2.2849842178374047	\N	824963536	1.10816	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-07T23:00:00.000Z	defillama-api	1.7188038736293265	\N	803664763	1.10816	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-08T23:00:00.000Z	defillama-api	1.71861690958508	\N	812159064	1.10816	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-09T23:00:00.000Z	defillama-api	2.285238404908796	\N	818823361	1.10828	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-10T23:00:00.000Z	defillama-api	2.2857467790515784	\N	834435081	1.1084	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-11T23:00:00.000Z	defillama-api	1.7191869048360786	\N	822941926	1.1084	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-12T23:00:00.000Z	defillama-api	2.2857467790515784	\N	802348395	1.10852	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-13T23:00:00.000Z	defillama-api	1.719373868880325	\N	794063146	1.10852	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-14T23:00:00.000Z	defillama-api	2.2859911627648444	\N	807738269	1.10865	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-15T23:00:00.000Z	defillama-api	1.7195601326847054	\N	782756095	1.10865	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-16T23:00:00.000Z	defillama-api	2.2862453498362356	\N	767655870	1.10877	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-17T23:00:00.000Z	defillama-api	1.7197569000870772	\N	766982503	1.10877	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-18T23:00:00.000Z	defillama-api	2.2864897335495016	\N	751514923	1.10889	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-19T23:00:00.000Z	defillama-api	1.7199438641313236	\N	741509528	1.10889	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-20T23:00:00.000Z	defillama-api	2.286743920620893	\N	748941527	1.10902	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-21T23:00:00.000Z	defillama-api	1.72013082817557	\N	750189815	1.10902	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-22T23:00:00.000Z	defillama-api	2.286997407452418	\N	729434950	1.10914	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-23T23:00:00.000Z	defillama-api	1.7203170919799504	\N	744727472	1.10914	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-24T23:00:00.000Z	defillama-api	2.287251594523809	\N	736129424	1.10926	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-25T23:00:00.000Z	defillama-api	1.7205138593823222	\N	740892311	1.10926	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-26T23:00:00.000Z	defillama-api	1.7203268953380757	\N	728053389	1.10926	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-27T23:00:00.000Z	defillama-api	1.7207008234265686	\N	712816143	1.10939	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-28T23:00:00.000Z	defillama-api	2.287740361950341	\N	706200810	1.10951	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-29T23:00:00.000Z	defillama-api	1.720887087230949	\N	708792763	1.10951	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-30T23:00:00.000Z	defillama-api	2.2879945490217324	\N	712103560	1.10963	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-05-31T23:00:00.000Z	defillama-api	1.7210838546333207	\N	708747337	1.10963	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-01T23:00:00.000Z	defillama-api	2.1405653473749453	\N	24142793	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-02T23:00:00.000Z	defillama-api	2.7625961230626217	\N	24493848	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-03T23:00:00.000Z	defillama-api	2.7598728902233916	\N	24553706	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-04T23:00:00.000Z	defillama-api	2.7530826642419015	\N	24772272	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-05T23:00:00.000Z	defillama-api	2.7530826642419015	\N	24910012	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-06T23:00:00.000Z	defillama-api	2.7644741663834793	\N	24501548	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-07T23:00:00.000Z	defillama-api	2.7748818315131984	\N	24118339	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-08T23:00:00.000Z	defillama-api	2.1993756927685126	\N	24278204	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-09T23:00:00.000Z	defillama-api	2.828333241211567	\N	24539693	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-10T23:00:00.000Z	defillama-api	2.831559946514517	\N	24950074	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-11T23:00:00.000Z	defillama-api	2.8332223159566183	\N	24594442	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-12T23:00:00.000Z	defillama-api	2.826836128377863	\N	23993915	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-13T23:00:00.000Z	defillama-api	2.8257374520279654	\N	24110347	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-14T23:00:00.000Z	defillama-api	2.8253096054697835	\N	24116132	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-15T23:00:00.000Z	defillama-api	2.826621854978839	\N	23325952	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-16T23:00:00.000Z	defillama-api	2.0037895950508755	\N	22873155	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-17T23:00:00.000Z	defillama-api	2.609182671520216	\N	23018422	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-18T23:00:00.000Z	defillama-api	2.6126411562188423	\N	22379423	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-19T23:00:00.000Z	defillama-api	2.6179118616909136	\N	21994873	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-20T23:00:00.000Z	defillama-api	2.6147551803745728	\N	22318559	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-21T23:00:00.000Z	defillama-api	2.613985616761738	\N	22316464	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-22T23:00:00.000Z	defillama-api	2.6058901436698534	\N	21558442	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-23T23:00:00.000Z	defillama-api	2.589754516435505	\N	22050673	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-24T23:00:00.000Z	defillama-api	2.022136579782341	\N	21788696	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-25T23:00:00.000Z	defillama-api	2.6015346517027638	\N	22080214	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-26T23:00:00.000Z	defillama-api	2.600472387825903	\N	21659333	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-27T23:00:00.000Z	defillama-api	2.5827094031427578	\N	21217554	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-28T23:00:00.000Z	defillama-api	2.575935982918054	\N	21021499	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-29T23:00:00.000Z	defillama-api	2.547347990144999	\N	21074159	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-30T23:00:00.000Z	defillama-api	2.5429903974583112	\N	21177325	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-05-31T23:00:00.000Z	defillama-api	2.5424049969302587	\N	21076117	\N	\N
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
