-- Generated from VAULT_LLAMA/98866/2026-09.ndjson (90 vault rows)
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
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-01T23:00:00.000Z	defillama-api	7.123923889196249	\N	28776968	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-02T23:00:00.000Z	defillama-api	7.123923889196249	\N	28782461	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-03T23:00:00.000Z	defillama-api	7.097268558453607	\N	25703825	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-04T23:00:00.000Z	defillama-api	7.075692767699593	\N	25708705	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-05T23:00:00.000Z	defillama-api	7.044010414958279	\N	25713634	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-06T23:00:00.000Z	defillama-api	7.027494557476643	\N	25718514	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-07T23:00:00.000Z	defillama-api	7.000887543284762	\N	25723394	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-08T23:00:00.000Z	defillama-api	6.969237401577288	\N	25728299	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-09T23:00:00.000Z	defillama-api	6.947699423776044	\N	25733204	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-10T23:00:00.000Z	defillama-api	6.946374569949398	\N	25738108	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-11T23:00:00.000Z	defillama-api	6.950097045077541	\N	25742988	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-12T23:00:00.000Z	defillama-api	6.948781294369155	\N	25747918	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-13T23:00:00.000Z	defillama-api	6.947447337424251	\N	25752798	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-14T23:00:00.000Z	defillama-api	6.946132286955731	\N	25757727	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-15T23:00:00.000Z	defillama-api	6.95489158744067	\N	25786687	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-16T23:00:00.000Z	defillama-api	6.948529908257228	\N	25791721	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-17T23:00:00.000Z	defillama-api	6.972398984572692	\N	25796556	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-18T23:00:00.000Z	defillama-api	6.955955251797263	\N	26302904	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-19T23:00:00.000Z	defillama-api	6.909312974556769	\N	26307934	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-20T23:00:00.000Z	defillama-api	6.907988120730124	\N	26312913	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-21T23:00:00.000Z	defillama-api	6.906681473139997	\N	26317893	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-22T23:00:00.000Z	defillama-api	6.895294872677482	\N	26322898	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-23T23:00:00.000Z	defillama-api	6.899019448525223	\N	26327877	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-24T23:00:00.000Z	defillama-api	6.867486246875387	\N	26332884	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-25T23:00:00.000Z	defillama-api	6.881293576554981	\N	26337889	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-26T23:00:00.000Z	defillama-api	6.930346079414562	\N	26342873	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-27T23:00:00.000Z	defillama-api	6.918962279911511	\N	26347898	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-28T23:00:00.000Z	defillama-api	6.927715278237656	\N	26353132	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-29T23:00:00.000Z	defillama-api	6.9766704477558505	\N	26357882	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-09-30T23:00:00.000Z	defillama-api	6.925083776820884	\N	26362887	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-01T23:00:00.000Z	defillama-api	10.88365597965435	\N	5463369	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-02T23:00:00.000Z	defillama-api	10.88365597965435	\N	5465001	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-03T23:00:00.000Z	defillama-api	10.885342157251898	\N	5466628	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-04T23:00:00.000Z	defillama-api	10.882095144992832	\N	5468265	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-05T23:00:00.000Z	defillama-api	10.88870470908887	\N	5469897	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-06T23:00:00.000Z	defillama-api	10.88544929395141	\N	5471523	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-07T23:00:00.000Z	defillama-api	10.882212085050469	\N	5473160	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-08T23:00:00.000Z	defillama-api	10.888812546028248	\N	5474787	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-09T23:00:00.000Z	defillama-api	10.885575337127307	\N	5476424	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-10T23:00:00.000Z	defillama-api	10.887243308488337	\N	5478056	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-11T23:00:00.000Z	defillama-api	10.888929486085885	\N	5479693	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-12T23:00:00.000Z	defillama-api	10.88567337070856	\N	5481325	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-13T23:00:00.000Z	defillama-api	10.882427058689359	\N	5482962	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-14T23:00:00.000Z	defillama-api	10.889019116788745	\N	5484594	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-15T23:00:00.000Z	defillama-api	10.880857120909582	\N	5486231	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-16T23:00:00.000Z	defillama-api	10.887440776130575	\N	5487868	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-17T23:00:00.000Z	defillama-api	10.884184660753249	\N	5489505	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-18T23:00:00.000Z	defillama-api	10.885853332354145	\N	5491142	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-19T23:00:00.000Z	defillama-api	10.882606320095078	\N	5492779	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-20T23:00:00.000Z	defillama-api	10.884274291456109	\N	5494421	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-21T23:00:00.000Z	defillama-api	10.885924756820486	\N	5496058	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-22T23:00:00.000Z	defillama-api	10.887592728181517	\N	5497700	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-23T23:00:00.000Z	defillama-api	10.889243193545894	\N	5499337	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-24T23:00:00.000Z	defillama-api	10.885996881526694	\N	5500979	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-25T23:00:00.000Z	defillama-api	10.887646646651206	\N	5502616	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-26T23:00:00.000Z	defillama-api	10.884409437750264	\N	5504258	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-27T23:00:00.000Z	defillama-api	10.886059202874776	\N	5505900	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-28T23:00:00.000Z	defillama-api	10.882812890855575	\N	5507542	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-29T23:00:00.000Z	defillama-api	10.884462655980087	\N	5509184	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-09-30T23:00:00.000Z	defillama-api	10.881216343960887	\N	5510832	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-01T23:00:00.000Z	defillama-api	10.474003053673187	\N	17933979	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-02T23:00:00.000Z	defillama-api	10.474003053673187	\N	18214565	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-03T23:00:00.000Z	defillama-api	10.528319259606178	\N	18510578	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-04T23:00:00.000Z	defillama-api	10.472814746620429	\N	19306872	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-05T23:00:00.000Z	defillama-api	10.47935218601026	\N	19322003	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-06T23:00:00.000Z	defillama-api	10.343517556066217	\N	19325593	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-07T23:00:00.000Z	defillama-api	11.335270079371185	\N	20779606	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-08T23:00:00.000Z	defillama-api	8.954760539481299	\N	23623319	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-09T23:00:00.000Z	defillama-api	10.100466399265429	\N	24173523	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-10T23:00:00.000Z	defillama-api	10.049878970619375	\N	23147222	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-11T23:00:00.000Z	defillama-api	8.57079521274784	\N	22621646	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-12T23:00:00.000Z	defillama-api	9.991845191237303	\N	22619908	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-13T23:00:00.000Z	defillama-api	10.07080423853779	\N	22624574	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-14T23:00:00.000Z	defillama-api	10.15454242292435	\N	24293300	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-15T23:00:00.000Z	defillama-api	11.437037339590006	\N	24541130	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-16T23:00:00.000Z	defillama-api	10.228344903850939	\N	24946201	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-17T23:00:00.000Z	defillama-api	10.220697584273353	\N	25152158	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-18T23:00:00.000Z	defillama-api	11.727437315656175	\N	25341504	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-19T23:00:00.000Z	defillama-api	10.224544001857794	\N	25346475	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-20T23:00:00.000Z	defillama-api	10.193898004118296	\N	25370344	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-21T23:00:00.000Z	defillama-api	10.182301331695953	\N	25892483	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-22T23:00:00.000Z	defillama-api	10.277624284427134	\N	26034170	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-23T23:00:00.000Z	defillama-api	10.270007775403656	\N	26096507	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-24T23:00:00.000Z	defillama-api	10.281350260754607	\N	25874346	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-25T23:00:00.000Z	defillama-api	10.321133688506734	\N	25700084	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-26T23:00:00.000Z	defillama-api	10.39893173810924	\N	25591603	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-27T23:00:00.000Z	defillama-api	10.610128983401523	\N	25576925	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-28T23:00:00.000Z	defillama-api	10.835454968471936	\N	24289764	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-29T23:00:00.000Z	defillama-api	10.390054097086932	\N	23103099	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-09-30T23:00:00.000Z	defillama-api	10.45347762271831	\N	23269371	\N	\N
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
