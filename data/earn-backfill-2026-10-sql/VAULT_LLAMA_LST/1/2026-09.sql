-- Generated from VAULT_LLAMA_LST/1/2026-09.ndjson (90 vault rows)
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
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-01T23:00:00.000Z	defillama-api	\N	\N	35110120	1.13	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-02T23:00:00.000Z	defillama-api	\N	\N	34637920	1.13003	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-03T23:00:00.000Z	defillama-api	\N	\N	36298886	1.13012	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-04T23:00:00.000Z	defillama-api	\N	\N	34891595	1.1302	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-05T23:00:00.000Z	defillama-api	\N	\N	35273593	1.13027	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-06T23:00:00.000Z	defillama-api	\N	\N	35651007	1.13031	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-07T23:00:00.000Z	defillama-api	\N	\N	35160256	1.13038	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-08T23:00:00.000Z	defillama-api	\N	\N	35199121	1.13046	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-09T23:00:00.000Z	defillama-api	\N	\N	34893743	1.13052	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-10T23:00:00.000Z	defillama-api	\N	\N	34625562	1.13058	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-11T23:00:00.000Z	defillama-api	\N	\N	35276234	1.13064	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-12T23:00:00.000Z	defillama-api	\N	\N	35396302	1.13067	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-13T23:00:00.000Z	defillama-api	\N	\N	34762068	1.13078	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-14T23:00:00.000Z	defillama-api	\N	\N	35550030	1.13083	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-15T23:00:00.000Z	defillama-api	\N	\N	33616852	1.13083	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-16T23:00:00.000Z	defillama-api	\N	\N	33502426	1.13083	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-17T23:00:00.000Z	defillama-api	\N	\N	34214302	1.13083	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-18T23:00:00.000Z	defillama-api	\N	\N	36580075	1.13108	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-19T23:00:00.000Z	defillama-api	\N	\N	36722010	1.13114	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-20T23:00:00.000Z	defillama-api	\N	\N	36902613	1.13119	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-21T23:00:00.000Z	defillama-api	\N	\N	38585879	1.13125	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-22T23:00:00.000Z	defillama-api	\N	\N	38256097	1.13128	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-23T23:00:00.000Z	defillama-api	\N	\N	37335611	1.13138	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-24T23:00:00.000Z	defillama-api	\N	\N	37176784	1.13142	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-25T23:00:00.000Z	defillama-api	\N	\N	37266003	1.13142	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-26T23:00:00.000Z	defillama-api	\N	\N	37118901	1.13142	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-27T23:00:00.000Z	defillama-api	\N	\N	36669187	1.13142	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-28T23:00:00.000Z	defillama-api	\N	\N	36847079	1.13142	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-29T23:00:00.000Z	defillama-api	\N	\N	36925292	1.13176	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-09-30T23:00:00.000Z	defillama-api	\N	\N	36906708	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-01T23:00:00.000Z	defillama-api	2.301892209644052	\N	772060149	1.11645	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-02T23:00:00.000Z	defillama-api	2.302146396715443	\N	761360811	1.11657	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-03T23:00:00.000Z	defillama-api	2.302146396715443	\N	799675054	1.11657	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-04T23:00:00.000Z	defillama-api	2.3023998835469683	\N	784766299	1.11669	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-05T23:00:00.000Z	defillama-api	2.3023998835469683	\N	794269687	1.11669	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-06T23:00:00.000Z	defillama-api	2.3026540706183596	\N	802858814	1.11682	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-07T22:00:00.000Z	defillama-api	2.3026540706183596	\N	797685406	1.11682	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-08T23:00:00.000Z	defillama-api	2.302908257689751	\N	796953521	1.11694	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-09T23:00:00.000Z	defillama-api	2.303162444761142	\N	784659642	1.11707	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-10T22:00:00.000Z	defillama-api	2.303162444761142	\N	787455256	1.11707	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-11T23:00:00.000Z	defillama-api	2.3034166318325333	\N	804351812	1.11719	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-12T23:00:00.000Z	defillama-api	2.3034166318325333	\N	808036960	1.11719	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-13T22:00:00.000Z	defillama-api	2.3036708189039246	\N	803507164	1.11732	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-14T22:00:00.000Z	defillama-api	2.3036708189039246	\N	816079193	1.11732	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-15T23:00:00.000Z	defillama-api	2.3039243057354497	\N	768404733	1.11744	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-16T23:00:00.000Z	defillama-api	2.304178492806841	\N	765892491	1.11757	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-17T23:00:00.000Z	defillama-api	2.304178492806841	\N	782768226	1.11757	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-18T23:00:00.000Z	defillama-api	2.304432679878232	\N	839354751	1.11769	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-19T23:00:00.000Z	defillama-api	2.304432679878232	\N	842493378	1.11769	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-20T23:00:00.000Z	defillama-api	2.3046868669496234	\N	845452755	1.11782	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-21T23:00:00.000Z	defillama-api	2.3046868669496234	\N	890183422	1.11782	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-22T23:00:00.000Z	defillama-api	2.3049410540210147	\N	882104670	1.11794	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-23T23:00:00.000Z	defillama-api	1.733665064307388	\N	862056074	1.11794	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-24T23:00:00.000Z	defillama-api	2.305195241092406	\N	859924412	1.11807	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-25T23:00:00.000Z	defillama-api	1.7338611314698937	\N	861778994	1.11807	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-26T23:00:00.000Z	defillama-api	2.305449428163797	\N	737621458	1.11819	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-27T23:00:00.000Z	defillama-api	1.7340480955141402	\N	733974932	1.11819	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-28T23:00:00.000Z	defillama-api	2.3057029149953223	\N	735157840	1.11832	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-29T23:00:00.000Z	defillama-api	2.3059571020667136	\N	734024219	1.11844	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-09-30T23:00:00.000Z	defillama-api	2.874556074772272	\N	735581351	1.11857	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-01T23:00:00.000Z	defillama-api	2.6125732329518314	\N	24676642	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-02T23:00:00.000Z	defillama-api	2.6127482929183543	\N	24330613	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-03T23:00:00.000Z	defillama-api	2.615193530530746	\N	25810870	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-04T23:00:00.000Z	defillama-api	2.622236543103895	\N	25246235	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-05T23:00:00.000Z	defillama-api	2.6373246114985704	\N	25514468	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-06T23:00:00.000Z	defillama-api	2.63784068827988	\N	25722138	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-07T23:00:00.000Z	defillama-api	2.5829040698255312	\N	25455642	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-08T23:00:00.000Z	defillama-api	2.692640759960341	\N	25485208	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-09T23:00:00.000Z	defillama-api	2.6889609994640296	\N	25283788	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-10T23:00:00.000Z	defillama-api	2.688649392723619	\N	25199711	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-11T23:00:00.000Z	defillama-api	2.686800059237271	\N	25679115	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-12T23:00:00.000Z	defillama-api	2.6808613249329483	\N	25787568	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-13T23:00:00.000Z	defillama-api	2.69032436648331	\N	25737270	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-14T23:00:00.000Z	defillama-api	2.6897690762694992	\N	26031991	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-15T23:00:00.000Z	defillama-api	2.108249277554819	\N	24602669	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-16T23:00:00.000Z	defillama-api	2.6737741972482354	\N	24545232	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-17T23:00:00.000Z	defillama-api	2.6805112049999025	\N	25088833	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-18T23:00:00.000Z	defillama-api	2.68316861529172	\N	26867427	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-19T23:00:00.000Z	defillama-api	2.6790119914466004	\N	26916582	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-20T23:00:00.000Z	defillama-api	2.6768797610543515	\N	27071989	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-21T23:00:00.000Z	defillama-api	2.349667474987882	\N	28475429	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-22T23:00:00.000Z	defillama-api	2.350546976259693	\N	28328220	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-23T23:00:00.000Z	defillama-api	1.8176014165760535	\N	27507127	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-24T23:00:00.000Z	defillama-api	2.4119671156341838	\N	27484120	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-25T23:00:00.000Z	defillama-api	2.4167203438452134	\N	27704449	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-26T23:00:00.000Z	defillama-api	2.422313859895553	\N	27586703	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-27T23:00:00.000Z	defillama-api	2.4143878448512623	\N	27159815	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-28T23:00:00.000Z	defillama-api	2.4229090637817308	\N	27247834	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-29T23:00:00.000Z	defillama-api	2.428452862801578	\N	27480940	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-09-30T23:00:00.000Z	defillama-api	1.9300935505839334	\N	27594076	\N	\N
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
