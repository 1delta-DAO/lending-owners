-- Generated from VAULT_LLAMA/98866/2026-08.ndjson (93 vault rows)
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
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-01T23:00:00.000Z	defillama-api	6.927388266220191	\N	28624529	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-02T23:00:00.000Z	defillama-api	6.931158357659228	\N	28609957	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-03T23:00:00.000Z	defillama-api	6.934927748858399	\N	28615394	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-04T23:00:00.000Z	defillama-api	6.933611998150013	\N	28620832	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-05T23:00:00.000Z	defillama-api	6.927202002415811	\N	28626269	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-06T23:00:00.000Z	defillama-api	6.930971393614982	\N	28631756	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-07T23:00:00.000Z	defillama-api	6.929665446264721	\N	28637166	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-08T23:00:00.000Z	defillama-api	6.933425034105767	\N	28642631	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-09T23:00:00.000Z	defillama-api	6.927033944847949	\N	28698039	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-10T23:00:00.000Z	defillama-api	6.925718194139563	\N	28703492	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-11T23:00:00.000Z	defillama-api	6.9294693791022155	\N	28708960	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-12T23:00:00.000Z	defillama-api	6.923086692722791	\N	28714379	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-13T23:00:00.000Z	defillama-api	6.921771642254271	\N	28719826	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-14T23:00:00.000Z	defillama-api	6.9255319303351826	\N	28725273	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-15T23:00:00.000Z	defillama-api	6.919149243955758	\N	28730719	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-16T23:00:00.000Z	defillama-api	6.917842596365631	\N	28736138	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-17T23:00:00.000Z	defillama-api	6.916526845657245	\N	28742598	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-18T23:00:00.000Z	defillama-api	6.976008721082394	\N	28748408	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-19T23:00:00.000Z	defillama-api	7.0101454145543585	\N	28754023	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-20T23:00:00.000Z	defillama-api	7.039210270676222	\N	28759637	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-21T23:00:00.000Z	defillama-api	7.063188584410796	\N	28765374	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-22T23:00:00.000Z	defillama-api	7.0922289321373455	\N	28720864	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-23T23:00:00.000Z	defillama-api	7.12631730905855	\N	28726469	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-24T23:00:00.000Z	defillama-api	7.155329647190456	\N	28732074	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-25T23:00:00.000Z	defillama-api	7.118476023038056	\N	28737679	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-26T23:00:00.000Z	defillama-api	7.122145279936376	\N	28743311	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-27T23:00:00.000Z	defillama-api	7.11569116909061	\N	28748888	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-28T23:00:00.000Z	defillama-api	7.124426661420102	\N	28754521	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-29T23:00:00.000Z	defillama-api	7.123039486245375	\N	28760126	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-30T23:00:00.000Z	defillama-api	7.1216516108307815	\N	28765730	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-08-31T23:00:00.000Z	defillama-api	7.125311764610842	\N	28771363	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-01T23:00:00.000Z	defillama-api	10.88515379272792	\N	5413093	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-02T23:00:00.000Z	defillama-api	10.886884785676898	\N	5414709	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-03T23:00:00.000Z	defillama-api	10.878659768209786	\N	5416320	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-04T23:00:00.000Z	defillama-api	10.890346071334989	\N	5417942	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-05T23:00:00.000Z	defillama-api	10.887090656197529	\N	5419558	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-06T23:00:00.000Z	defillama-api	10.878875442088543	\N	5421169	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-07T23:00:00.000Z	defillama-api	10.890543538977226	\N	5422791	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-08T23:00:00.000Z	defillama-api	10.887297226958026	\N	5424407	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-09T23:00:00.000Z	defillama-api	10.88405021469896	\N	5426023	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-10T23:00:00.000Z	defillama-api	10.890741006619464	\N	5427645	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-11T23:00:00.000Z	defillama-api	10.887485591482005	\N	5429266	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-12T23:00:00.000Z	defillama-api	10.884238579222938	\N	5430883	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-13T23:00:00.000Z	defillama-api	10.890920268025184	\N	5432504	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-14T23:00:00.000Z	defillama-api	10.882714157034457	\N	5434120	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-15T23:00:00.000Z	defillama-api	10.884426943746917	\N	5435742	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-16T23:00:00.000Z	defillama-api	10.886139730459377	\N	5437363	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-17T23:00:00.000Z	defillama-api	10.882893418440176	\N	5438985	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-18T23:00:00.000Z	defillama-api	10.87964640618111	\N	5440606	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-19T23:00:00.000Z	defillama-api	10.886301485868444	\N	5442233	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-20T23:00:00.000Z	defillama-api	10.883055173849243	\N	5443854	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-21T23:00:00.000Z	defillama-api	10.88971865641497	\N	5445481	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-22T23:00:00.000Z	defillama-api	10.886471644155904	\N	5447103	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-23T23:00:00.000Z	defillama-api	10.888166924871712	\N	5448729	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-24T23:00:00.000Z	defillama-api	10.88986220558752	\N	5450356	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-25T23:00:00.000Z	defillama-api	10.886624296446712	\N	5451977	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-26T23:00:00.000Z	defillama-api	10.883377984427511	\N	5453604	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-27T23:00:00.000Z	defillama-api	10.885072564903453	\N	5455231	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-28T23:00:00.000Z	defillama-api	10.881826252884252	\N	5456857	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-29T23:00:00.000Z	defillama-api	10.88845402321681	\N	5458489	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-30T23:00:00.000Z	defillama-api	10.885207010957743	\N	5460116	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-08-31T23:00:00.000Z	defillama-api	10.881960698938542	\N	5461742	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-01T23:00:00.000Z	defillama-api	12.841265455776352	\N	14064795	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-02T23:00:00.000Z	defillama-api	13.944050112968398	\N	14084870	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-03T23:00:00.000Z	defillama-api	10.084203328375452	\N	14543341	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-04T23:00:00.000Z	defillama-api	11.648387937412963	\N	14542187	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-05T23:00:00.000Z	defillama-api	10.078462061713367	\N	14546996	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-06T23:00:00.000Z	defillama-api	10.017867505140998	\N	14546437	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-07T23:00:00.000Z	defillama-api	10.000559676370813	\N	14538445	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-08T23:00:00.000Z	defillama-api	10.075324987113277	\N	14531513	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-09T23:00:00.000Z	defillama-api	10.159701090017847	\N	14556247	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-10T23:00:00.000Z	defillama-api	10.304942742322964	\N	14698942	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-11T23:00:00.000Z	defillama-api	10.26349274368954	\N	14806042	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-12T23:00:00.000Z	defillama-api	10.356691168666998	\N	14547747	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-13T23:00:00.000Z	defillama-api	10.43545204808538	\N	14555908	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-14T23:00:00.000Z	defillama-api	10.446884164139192	\N	14047165	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-15T23:00:00.000Z	defillama-api	10.329350303095453	\N	14093640	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-16T23:00:00.000Z	defillama-api	10.221483253403107	\N	14115752	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-17T23:00:00.000Z	defillama-api	10.462007244527172	\N	14099595	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-18T23:00:00.000Z	defillama-api	10.468600002866424	\N	14109112	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-19T23:00:00.000Z	defillama-api	10.412827998251828	\N	14099683	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-20T23:00:00.000Z	defillama-api	10.385871564366767	\N	14102836	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-21T23:00:00.000Z	defillama-api	10.454720548480623	\N	14107561	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-22T23:00:00.000Z	defillama-api	10.61534507016404	\N	14119000	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-23T23:00:00.000Z	defillama-api	10.598787898530304	\N	14125320	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-24T23:00:00.000Z	defillama-api	10.642005302585744	\N	14152821	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-25T23:00:00.000Z	defillama-api	10.677214763532561	\N	14172359	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-26T23:00:00.000Z	defillama-api	10.678985670153907	\N	14276907	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-27T23:00:00.000Z	defillama-api	10.699860520801963	\N	14267665	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-28T23:00:00.000Z	defillama-api	10.629742001810882	\N	15276038	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-29T23:00:00.000Z	defillama-api	10.541216277459853	\N	15259256	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-30T23:00:00.000Z	defillama-api	9.478476937729852	\N	15259245	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-08-31T23:00:00.000Z	defillama-api	10.491409616264491	\N	16494966	\N	\N
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
