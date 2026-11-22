-- Generated from VAULT_LLAMA_LST/1/2026-07.ndjson (93 vault rows)
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
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-01T23:00:00.000Z	defillama-api	\N	\N	23689065	1.12574	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-02T23:00:00.000Z	defillama-api	\N	\N	24462088	1.1258	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-03T23:00:00.000Z	defillama-api	\N	\N	24250225	1.12588	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-04T23:00:00.000Z	defillama-api	\N	\N	27729166	1.12595	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-05T23:00:00.000Z	defillama-api	\N	\N	27786959	1.12602	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-06T23:00:00.000Z	defillama-api	\N	\N	27921044	1.12609	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-07T23:00:00.000Z	defillama-api	\N	\N	27588920	1.12615	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-08T23:00:00.000Z	defillama-api	\N	\N	27028146	1.12622	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-09T23:00:00.000Z	defillama-api	\N	\N	27184336	1.12629	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-10T23:00:00.000Z	defillama-api	\N	\N	27885762	1.12636	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-11T23:00:00.000Z	defillama-api	\N	\N	28078667	1.12641	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-12T23:00:00.000Z	defillama-api	\N	\N	27965189	1.12647	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-13T23:00:00.000Z	defillama-api	\N	\N	27294564	1.12656	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-14T23:00:00.000Z	defillama-api	\N	\N	29087456	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-15T23:00:00.000Z	defillama-api	\N	\N	29700349	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-16T23:00:00.000Z	defillama-api	\N	\N	28860736	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-17T23:00:00.000Z	defillama-api	\N	\N	28399543	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-18T23:00:00.000Z	defillama-api	\N	\N	28742840	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-19T23:00:00.000Z	defillama-api	\N	\N	28842257	1.12659	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-20T23:00:00.000Z	defillama-api	\N	\N	29189124	1.12705	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-21T23:00:00.000Z	defillama-api	\N	\N	29551053	1.12713	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-22T23:00:00.000Z	defillama-api	\N	\N	29802247	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-23T23:00:00.000Z	defillama-api	\N	\N	28995962	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-24T23:00:00.000Z	defillama-api	\N	\N	28579940	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-25T23:00:00.000Z	defillama-api	\N	\N	28816898	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-26T23:00:00.000Z	defillama-api	\N	\N	29498028	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-27T23:00:00.000Z	defillama-api	\N	\N	28753497	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-28T23:00:00.000Z	defillama-api	\N	\N	28929705	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-29T23:00:00.000Z	defillama-api	\N	\N	28790614	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-30T23:00:00.000Z	defillama-api	\N	\N	29074931	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-07-31T23:00:00.000Z	defillama-api	\N	\N	28144520	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-01T23:00:00.000Z	defillama-api	2.2930278731791987	\N	564697958	1.11198	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-02T23:00:00.000Z	defillama-api	2.2927736861078074	\N	591096617	1.11198	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-03T23:00:00.000Z	defillama-api	2.29328206025059	\N	604693805	1.1121	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-04T23:00:00.000Z	defillama-api	2.293536247321981	\N	577228989	1.11222	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-05T23:00:00.000Z	defillama-api	2.29328206025059	\N	570757068	1.11222	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-06T22:00:00.000Z	defillama-api	2.2937904343933724	\N	578307344	1.11235	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-07T23:00:00.000Z	defillama-api	2.8591052821269614	\N	565891319	1.11247	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-08T23:00:00.000Z	defillama-api	2.2940348181066383	\N	554682082	1.11247	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-09T23:00:00.000Z	defillama-api	2.859416188627506	\N	557093886	1.11259	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-10T23:00:00.000Z	defillama-api	2.2942890051780296	\N	572362874	1.11259	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-11T23:00:00.000Z	defillama-api	2.294543192249421	\N	578107128	1.11272	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-12T23:00:00.000Z	defillama-api	2.8600478049867206	\N	575564445	1.11284	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-13T23:00:00.000Z	defillama-api	2.294796679080946	\N	560099872	1.11284	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-14T23:00:00.000Z	defillama-api	2.295050866152337	\N	600546233	1.11297	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-15T23:00:00.000Z	defillama-api	2.294796679080946	\N	613246274	1.11297	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-16T23:00:00.000Z	defillama-api	2.2953050532237285	\N	596004741	1.11309	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-17T23:00:00.000Z	defillama-api	2.86099032784648	\N	586829873	1.11321	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-18T23:00:00.000Z	defillama-api	2.2955494369369944	\N	594665781	1.11321	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-19T23:00:00.000Z	defillama-api	2.295813427366511	\N	596596337	1.11334	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-20T23:00:00.000Z	defillama-api	2.2955494369369944	\N	604628240	1.11334	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-21T23:00:00.000Z	defillama-api	2.2958036240083857	\N	612611594	1.11346	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-22T23:00:00.000Z	defillama-api	2.2958036240083857	\N	618259159	1.11346	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-23T23:00:00.000Z	defillama-api	2.296057811079777	\N	600857706	1.11359	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-24T23:00:00.000Z	defillama-api	2.296311998151168	\N	593456915	1.11371	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-25T23:00:00.000Z	defillama-api	2.296311998151168	\N	598556817	1.11371	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-26T23:00:00.000Z	defillama-api	2.2965661852225594	\N	622250453	1.11383	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-27T23:00:00.000Z	defillama-api	2.2965661852225594	\N	604612697	1.11383	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-28T23:00:00.000Z	defillama-api	2.2968196720540845	\N	610566368	1.11396	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-29T23:00:00.000Z	defillama-api	2.863186980306409	\N	608316601	1.11408	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-30T23:00:00.000Z	defillama-api	2.297073859125476	\N	614704149	1.11408	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-07-31T23:00:00.000Z	defillama-api	2.297328046196867	\N	594158759	1.11421	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-01T23:00:00.000Z	defillama-api	2.3756463740198797	\N	16867364	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-02T23:00:00.000Z	defillama-api	2.784529736388208	\N	17689966	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-03T23:00:00.000Z	defillama-api	2.786027549461778	\N	18174792	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-04T23:00:00.000Z	defillama-api	2.7817868968327275	\N	18448813	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-05T23:00:00.000Z	defillama-api	2.781086656966636	\N	18480705	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-06T23:00:00.000Z	defillama-api	2.783449966514695	\N	18700655	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-07T23:00:00.000Z	defillama-api	2.776827097861201	\N	18457751	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-08T23:00:00.000Z	defillama-api	2.778937620817601	\N	17890561	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-09T23:00:00.000Z	defillama-api	2.682633632034026	\N	18099913	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-10T23:00:00.000Z	defillama-api	2.6958044436753426	\N	18595195	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-11T23:00:00.000Z	defillama-api	2.69592138373298	\N	18689744	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-12T23:00:00.000Z	defillama-api	2.6920861699863963	\N	18692534	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-13T23:00:00.000Z	defillama-api	2.6911611531232893	\N	18204058	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-14T23:00:00.000Z	defillama-api	2.6977315037868266	\N	19463338	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-15T23:00:00.000Z	defillama-api	2.697955580543976	\N	19842479	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-16T23:00:00.000Z	defillama-api	2.489786172432673	\N	19403053	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-17T23:00:00.000Z	defillama-api	2.4439799815922925	\N	18992092	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-18T23:00:00.000Z	defillama-api	2.4419401828623677	\N	19215692	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-19T23:00:00.000Z	defillama-api	2.4416474825983414	\N	19115204	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-20T23:00:00.000Z	defillama-api	2.4409843554451527	\N	19397198	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-21T23:00:00.000Z	defillama-api	2.430795165153654	\N	19780184	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-22T23:00:00.000Z	defillama-api	2.4310101387925442	\N	19967694	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-23T23:00:00.000Z	defillama-api	2.4345526522751015	\N	19266075	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-24T23:00:00.000Z	defillama-api	2.4009159300675265	\N	19139949	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-25T23:00:00.000Z	defillama-api	2.392998317901629	\N	19222645	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-26T23:00:00.000Z	defillama-api	2.391807209889407	\N	19618429	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-27T23:00:00.000Z	defillama-api	2.391230912479614	\N	19932327	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-28T23:00:00.000Z	defillama-api	2.3917777998150314	\N	19719271	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-29T23:00:00.000Z	defillama-api	2.390420734954546	\N	19332987	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-30T23:00:00.000Z	defillama-api	2.3895027204901	\N	19544268	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-07-31T23:00:00.000Z	defillama-api	2.3895027204901	\N	19095296	\N	\N
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
