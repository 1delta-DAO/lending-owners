-- Generated from VAULT_LLAMA/1/2026-01.ndjson (130 vault rows)
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
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-01T23:00:00.000Z	defillama-api	3.9608717905537105	\N	26989532	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-02T23:00:00.000Z	defillama-api	4.053724997277186	\N	28313724	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-03T23:00:00.000Z	defillama-api	3.987751898293368	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-04T23:00:00.000Z	defillama-api	3.976335187516611	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-05T23:00:00.000Z	defillama-api	3.976335187516611	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-06T23:00:00.000Z	defillama-api	3.976335187516611	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-07T23:00:00.000Z	defillama-api	3.9694350238761444	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-08T23:00:00.000Z	defillama-api	3.9867330492882047	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-09T23:00:00.000Z	defillama-api	3.988770047058665	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-10T23:00:00.000Z	defillama-api	3.992815332765076	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-11T23:00:00.000Z	defillama-api	3.976527753479786	\N	28132901	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-12T23:00:00.000Z	defillama-api	4.068464346218548	\N	28045587	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-13T23:00:00.000Z	defillama-api	3.9875880421647025	\N	28476607	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-14T23:00:00.000Z	defillama-api	3.9750957629536288	\N	30209849	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-15T23:00:00.000Z	defillama-api	3.937935433739881	\N	30328518	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-16T23:00:00.000Z	defillama-api	3.9248787611967373	\N	29968721	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-17T23:00:00.000Z	defillama-api	4.053110186674758	\N	29906884	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-18T23:00:00.000Z	defillama-api	4.023683306542125	\N	30065121	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-19T23:00:00.000Z	defillama-api	4.007525271632062	\N	29099882	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-20T23:00:00.000Z	defillama-api	4.094221269212994	\N	27176274	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-21T23:00:00.000Z	defillama-api	4.046983788086322	\N	27075163	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-22T23:00:00.000Z	defillama-api	4.000252580382835	\N	26607072	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-23T23:00:00.000Z	defillama-api	3.855164280608392	\N	26763658	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-24T23:00:00.000Z	defillama-api	4.104366344392929	\N	26788847	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-25T23:00:00.000Z	defillama-api	4.166474119315922	\N	25991823	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-26T23:00:00.000Z	defillama-api	4.15552937020891	\N	26596160	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-27T23:00:00.000Z	defillama-api	3.7890889466041244	\N	26692687	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-28T23:00:00.000Z	defillama-api	4.087722343015798	\N	27339937	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-29T23:00:00.000Z	defillama-api	4.072583157110898	\N	25504294	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-30T23:00:00.000Z	defillama-api	4.051804239324497	\N	24690447	\N	\N
VAULT_LLAMA	1	0x0a2b94f6871c1d7a32fe58e1ab5e6dea2f114e56	2026-01-31T23:00:00.000Z	defillama-api	4.17594136230548	\N	21798525	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-01T19:00:00.000Z	defillama-api	18.797885986998608	\N	8743037	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-02T15:00:00.000Z	defillama-api	18.653799030232676	\N	9309278	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-03T21:00:00.000Z	defillama-api	18.643275825525052	\N	9246878	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-04T18:00:00.000Z	defillama-api	18.514714587070102	\N	9117921	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-05T23:00:00.000Z	defillama-api	18.081375347378525	\N	9593705	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-06T23:00:00.000Z	defillama-api	18.01926267077647	\N	8865969	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-07T23:00:00.000Z	defillama-api	17.939452832038683	\N	8759929	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-08T19:00:00.000Z	defillama-api	17.769361767605574	\N	8749865	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-09T21:00:00.000Z	defillama-api	17.722852535939637	\N	8216776	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-10T21:00:00.000Z	defillama-api	17.66815960095869	\N	8713117	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-11T19:00:00.000Z	defillama-api	17.196713307754408	\N	8500773	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-12T20:00:00.000Z	defillama-api	17.459402691599735	\N	8349996	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-13T21:00:00.000Z	defillama-api	17.489605437503997	\N	9111336	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-14T23:00:00.000Z	defillama-api	17.29442267794923	\N	9219133	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-15T19:00:00.000Z	defillama-api	17.2155140479191	\N	9195392	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-16T22:00:00.000Z	defillama-api	17.388683366803548	\N	9094935	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-17T15:00:00.000Z	defillama-api	17.307123628640397	\N	9370449	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-18T21:00:00.000Z	defillama-api	17.202060339371883	\N	9075864	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-19T23:00:00.000Z	defillama-api	17.163465218672513	\N	8563996	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-20T20:00:00.000Z	defillama-api	17.242516697635324	\N	8142993	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-21T23:00:00.000Z	defillama-api	17.22134774624351	\N	8048867	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-22T23:00:00.000Z	defillama-api	17.58810257754817	\N	7864492	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-23T22:00:00.000Z	defillama-api	17.854961889796073	\N	7989394	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-24T23:00:00.000Z	defillama-api	17.451062834794584	\N	7734188	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-25T22:00:00.000Z	defillama-api	18.189646435473605	\N	7895171	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-26T22:00:00.000Z	defillama-api	18.48378079074564	\N	7806500	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-27T21:00:00.000Z	defillama-api	18.806428913364925	\N	7237711	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-28T21:00:00.000Z	defillama-api	19.048712607272478	\N	7367878	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-29T21:00:00.000Z	defillama-api	19.297156311282038	\N	7003242	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-30T22:00:00.000Z	defillama-api	19.48060515140071	\N	6729516	\N	\N
VAULT_LLAMA	1	0x27b5739e22ad9033bcbf192059122d163b60349d	2026-01-31T23:00:00.000Z	defillama-api	20.125493156797347	\N	6173912	\N	\N
VAULT_LLAMA	1	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-01-29T23:00:00.000Z	defillama-api	2.18387868429204	\N	34995601	\N	\N
VAULT_LLAMA	1	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-01-30T23:00:00.000Z	defillama-api	2.3959365243797492	\N	35095549	\N	\N
VAULT_LLAMA	1	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-01-31T23:00:00.000Z	defillama-api	2.231798899288151	\N	32829327	\N	\N
VAULT_LLAMA	1	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-01-29T23:00:00.000Z	defillama-api	4.626545716135411	\N	530801987	\N	\N
VAULT_LLAMA	1	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-01-30T23:00:00.000Z	defillama-api	4.471788504289975	\N	510488464	\N	\N
VAULT_LLAMA	1	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-01-31T23:00:00.000Z	defillama-api	4.2300678032347605	\N	463150421	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-01T23:00:00.000Z	defillama-api	10.189093658397042	\N	33525	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-02T23:00:00.000Z	defillama-api	8.583781861304374	\N	33558	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-03T23:00:00.000Z	defillama-api	11.85268501906478	\N	33558	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-04T23:00:00.000Z	defillama-api	11.85268501906478	\N	33558	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-05T23:00:00.000Z	defillama-api	11.048625489706865	\N	33561	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-06T23:00:00.000Z	defillama-api	9.763266591988895	\N	33602	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-07T23:00:00.000Z	defillama-api	12.369529963507375	\N	35614	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-08T23:00:00.000Z	defillama-api	13.576797411118946	\N	35614	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-09T23:00:00.000Z	defillama-api	9.854376201445803	\N	35638	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-10T23:00:00.000Z	defillama-api	13.85176900221552	\N	47742	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-11T23:00:00.000Z	defillama-api	12.482008092717933	\N	47742	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-12T23:00:00.000Z	defillama-api	12.389719279326528	\N	47765	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-13T23:00:00.000Z	defillama-api	8.95562043403686	\N	47782	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-14T23:00:00.000Z	defillama-api	9.107421933407522	\N	79798	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-15T23:00:00.000Z	defillama-api	11.293950325352853	\N	104448	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-16T23:00:00.000Z	defillama-api	10.549747299748446	\N	104480	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-17T23:00:00.000Z	defillama-api	8.478057545602269	\N	104480	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-18T23:00:00.000Z	defillama-api	11.030948634527249	\N	104481	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-19T23:00:00.000Z	defillama-api	8.665409522734535	\N	104502	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-20T23:00:00.000Z	defillama-api	8.95492509584983	\N	104564	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-21T23:00:00.000Z	defillama-api	10.19180288643895	\N	104641	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-22T23:00:00.000Z	defillama-api	10.397669905870544	\N	104677	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-23T23:00:00.000Z	defillama-api	9.817516275134608	\N	104677	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-24T23:00:00.000Z	defillama-api	10.446784730078207	\N	105261	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-25T23:00:00.000Z	defillama-api	11.471504546278766	\N	105261	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-26T23:00:00.000Z	defillama-api	11.538113463060995	\N	105356	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-27T23:00:00.000Z	defillama-api	11.803376228414209	\N	502290	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-28T23:00:00.000Z	defillama-api	9.001600984603897	\N	502234	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-29T23:00:00.000Z	defillama-api	8.715666438163794	\N	522378	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-30T23:00:00.000Z	defillama-api	10.718745289750586	\N	525297	\N	\N
VAULT_LLAMA	1	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-01-31T23:00:00.000Z	defillama-api	16.938760346363324	\N	532297	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-01T23:00:00.000Z	defillama-api	3.5980376022592964	\N	496592965	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-02T23:00:00.000Z	defillama-api	3.7491815763956993	\N	491437381	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-03T23:00:00.000Z	defillama-api	3.755586670450839	\N	491069253	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-04T23:00:00.000Z	defillama-api	3.796434462799425	\N	497910756	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-05T23:00:00.000Z	defillama-api	3.814609888763698	\N	499447322	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-06T23:00:00.000Z	defillama-api	3.1901394773825587	\N	500454919	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-07T23:00:00.000Z	defillama-api	3.403536876334101	\N	491637590	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-08T23:00:00.000Z	defillama-api	3.5171178833337535	\N	493862129	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-09T23:00:00.000Z	defillama-api	3.169574132755315	\N	499373392	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-10T23:00:00.000Z	defillama-api	3.1785154956054384	\N	498776386	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-11T23:00:00.000Z	defillama-api	3.4555717007833664	\N	493632221	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-12T23:00:00.000Z	defillama-api	3.2081055316268703	\N	493893171	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-13T23:00:00.000Z	defillama-api	2.946996589159312	\N	500611091	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-14T23:00:00.000Z	defillama-api	3.268265239242396	\N	502223872	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-15T23:00:00.000Z	defillama-api	4.165697553304426	\N	500549980	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-16T23:00:00.000Z	defillama-api	4.39222374950532	\N	501234112	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-17T23:00:00.000Z	defillama-api	4.065353180493503	\N	501020433	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-18T23:00:00.000Z	defillama-api	4.146022213546985	\N	500788910	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-19T23:00:00.000Z	defillama-api	4.262606549332304	\N	501082759	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-20T23:00:00.000Z	defillama-api	4.411200249876401	\N	501478390	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-21T23:00:00.000Z	defillama-api	4.5517481943591065	\N	501471856	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-22T23:00:00.000Z	defillama-api	4.528430907058123	\N	502107225	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-23T23:00:00.000Z	defillama-api	4.3651937904343185	\N	501140051	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-24T23:00:00.000Z	defillama-api	4.189118476105591	\N	500991203	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-25T23:00:00.000Z	defillama-api	4.003451976331007	\N	500469298	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-26T23:00:00.000Z	defillama-api	4.277822061382608	\N	500527386	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-27T23:00:00.000Z	defillama-api	4.109741385605048	\N	499639891	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-28T23:00:00.000Z	defillama-api	3.7192309168432303	\N	500566222	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-29T23:00:00.000Z	defillama-api	3.351388613026529	\N	500458504	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-30T23:00:00.000Z	defillama-api	3.125668392911507	\N	502637500	\N	\N
VAULT_LLAMA	1	0x35d8949372d46b7a3d5a56006ae77b215fc69bc0	2026-01-31T23:00:00.000Z	defillama-api	2.8479189502661484	\N	500686675	\N	\N
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
