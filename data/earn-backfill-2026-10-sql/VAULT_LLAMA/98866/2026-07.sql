-- Generated from VAULT_LLAMA/98866/2026-07.ndjson (81 vault rows)
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
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-01T23:00:00.000Z	defillama-api	7.384099411922307	\N	12071956	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-02T23:00:00.000Z	defillama-api	7.382603699568335	\N	12906730	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-03T23:00:00.000Z	defillama-api	7.381117790572489	\N	12909337	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-04T23:00:00.000Z	defillama-api	7.3847310282815215	\N	12911958	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-05T23:00:00.000Z	defillama-api	7.388353369108813	\N	12914578	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-06T23:00:00.000Z	defillama-api	7.386857656754842	\N	13917185	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-07T23:00:00.000Z	defillama-api	7.385362644640736	\N	13920007	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-08T23:00:00.000Z	defillama-api	7.3838669322867645	\N	13922816	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-09T23:00:00.000Z	defillama-api	7.387480169995797	\N	13925638	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-10T23:00:00.000Z	defillama-api	7.385994260999951	\N	17212615	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-11T23:00:00.000Z	defillama-api	7.384498548645979	\N	17216102	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-12T23:00:00.000Z	defillama-api	7.383003536531874	\N	17219590	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-13T23:00:00.000Z	defillama-api	7.386606970882781	\N	17223076	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-14T23:00:00.000Z	defillama-api	7.3239123949520035	\N	17226362	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-15T23:00:00.000Z	defillama-api	7.256146681910991	\N	17929613	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-16T23:00:00.000Z	defillama-api	7.188400575586229	\N	20983014	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-17T23:00:00.000Z	defillama-api	7.130880072026002	\N	20987015	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-18T23:00:00.000Z	defillama-api	7.058091538425515	\N	20990974	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-19T23:00:00.000Z	defillama-api	6.9904259596853535	\N	20994968	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-20T23:00:00.000Z	defillama-api	6.927873532447393	\N	20998968	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-21T23:00:00.000Z	defillama-api	6.9214635367131905	\N	24852948	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-22T23:00:00.000Z	defillama-api	6.925251834388746	\N	25077658	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-23T23:00:00.000Z	defillama-api	6.9188411384146775	\N	27353738	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-24T23:00:00.000Z	defillama-api	6.912439545558868	\N	27358920	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-25T23:00:00.000Z	defillama-api	6.921314385621713	\N	27364128	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-26T23:00:00.000Z	defillama-api	6.919998634913327	\N	27369310	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-27T23:00:00.000Z	defillama-api	6.913597042057518	\N	27374491	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-28T23:00:00.000Z	defillama-api	6.917376236614814	\N	27379700	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-29T23:00:00.000Z	defillama-api	6.926231469961408	\N	28598264	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-30T23:00:00.000Z	defillama-api	6.930010664518704	\N	28613675	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-07-31T23:00:00.000Z	defillama-api	6.928704016928577	\N	28619088	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-13T23:00:00.000Z	defillama-api	10.88691139479181	\N	5382511	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-14T23:00:00.000Z	defillama-api	10.883664382532743	\N	5384113	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-15T23:00:00.000Z	defillama-api	10.885431787954758	\N	5385719	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-16T23:00:00.000Z	defillama-api	10.882175672577432	\N	5387325	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-17T23:00:00.000Z	defillama-api	10.888937888964278	\N	5388936	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-18T23:00:00.000Z	defillama-api	10.885691576945078	\N	5390542	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-19T23:00:00.000Z	defillama-api	10.882445264925877	\N	5392148	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-20T23:00:00.000Z	defillama-api	10.884193763871508	\N	5393759	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-21T23:00:00.000Z	defillama-api	10.885952066175264	\N	5395365	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-22T23:00:00.000Z	defillama-api	10.887700565120895	\N	5396976	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-23T23:00:00.000Z	defillama-api	10.889440661188132	\N	5398587	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-24T23:00:00.000Z	defillama-api	10.886193648929066	\N	5400198	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-25T23:00:00.000Z	defillama-api	10.882947336909865	\N	5401804	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-26T23:00:00.000Z	defillama-api	10.884695835855496	\N	5403416	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-27T23:00:00.000Z	defillama-api	10.886426828804474	\N	5405032	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-28T23:00:00.000Z	defillama-api	10.883189619903533	\N	5406638	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-29T23:00:00.000Z	defillama-api	10.884920612852511	\N	5408254	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-30T23:00:00.000Z	defillama-api	10.886660008679883	\N	5409870	\N	\N
VAULT_LLAMA	98866	0x7488b23f4c26b44eef2e0766896be47443e86d79	2026-07-31T23:00:00.000Z	defillama-api	10.878435691452637	\N	5411476	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-01T23:00:00.000Z	defillama-api	10.972433790357172	\N	12696703	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-02T23:00:00.000Z	defillama-api	10.915696154967236	\N	12388585	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-03T23:00:00.000Z	defillama-api	10.9172828985038	\N	12392967	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-04T23:00:00.000Z	defillama-api	10.9172828985038	\N	12426995	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-05T23:00:00.000Z	defillama-api	10.9172828985038	\N	12415383	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-06T23:00:00.000Z	defillama-api	10.839573779364287	\N	11913817	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-07T23:00:00.000Z	defillama-api	10.700444520850283	\N	11878917	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-08T23:00:00.000Z	defillama-api	10.551637247147028	\N	11803180	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-09T23:00:00.000Z	defillama-api	11.586279462250104	\N	12045580	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-10T23:00:00.000Z	defillama-api	13.303230501193752	\N	12846049	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-11T23:00:00.000Z	defillama-api	13.30807195962791	\N	12843536	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-12T23:00:00.000Z	defillama-api	13.30807195962791	\N	12833189	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-13T23:00:00.000Z	defillama-api	11.107686520972493	\N	13084599	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-14T23:00:00.000Z	defillama-api	12.184278705973384	\N	13086821	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-15T23:00:00.000Z	defillama-api	12.122802547409606	\N	13524758	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-16T23:00:00.000Z	defillama-api	10.747776534358877	\N	13577710	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-17T23:00:00.000Z	defillama-api	10.213926264768247	\N	13590358	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-18T23:00:00.000Z	defillama-api	7.596999640568924	\N	13636588	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-19T23:00:00.000Z	defillama-api	7.5389343503928785	\N	13635372	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-20T23:00:00.000Z	defillama-api	10.533089293573994	\N	13686949	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-21T23:00:00.000Z	defillama-api	10.895179827130619	\N	13909218	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-22T23:00:00.000Z	defillama-api	11.027500653426614	\N	13949471	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-23T23:00:00.000Z	defillama-api	11.063139361411345	\N	13953035	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-24T23:00:00.000Z	defillama-api	11.106675374605857	\N	13952561	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-25T23:00:00.000Z	defillama-api	11.179250335047186	\N	13940717	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-26T23:00:00.000Z	defillama-api	11.23730512162524	\N	13946384	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-27T23:00:00.000Z	defillama-api	11.601899012703143	\N	13951698	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-28T23:00:00.000Z	defillama-api	8.702678389127527	\N	13949447	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-29T23:00:00.000Z	defillama-api	10.180071067722452	\N	13969882	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-30T23:00:00.000Z	defillama-api	10.220616356448886	\N	13969011	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-07-31T23:00:00.000Z	defillama-api	11.71415866707548	\N	13995842	\N	\N
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
