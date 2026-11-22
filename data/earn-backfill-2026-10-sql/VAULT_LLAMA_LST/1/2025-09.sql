-- Generated from VAULT_LLAMA_LST/1/2025-09.ndjson (60 vault rows)
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
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-01T23:00:00.000Z	defillama-api	2.7977355600228293	\N	1555812347	1.08814	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-02T23:00:00.000Z	defillama-api	2.798338466547534	\N	1570813720	1.08826	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-03T23:00:00.000Z	defillama-api	2.2448926845441974	\N	1623612741	1.08838	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-04T23:00:00.000Z	defillama-api	2.798338466547534	\N	1578246595	1.08838	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-05T23:00:00.000Z	defillama-api	2.798941373072239	\N	1566496687	1.08849	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-06T23:00:00.000Z	defillama-api	2.2453814519707294	\N	1552926268	1.08861	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-07T23:00:00.000Z	defillama-api	2.798941373072239	\N	1565389191	1.08861	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-08T23:00:00.000Z	defillama-api	2.7995344762388186	\N	1566052780	1.08873	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-09T23:00:00.000Z	defillama-api	2.2458702193972613	\N	1567266668	1.08885	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-10T23:00:00.000Z	defillama-api	2.799544279596944	\N	1579947565	1.08885	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-11T23:00:00.000Z	defillama-api	2.8001471861216487	\N	1620355693	1.08897	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-12T23:00:00.000Z	defillama-api	2.246349883705534	\N	1708192814	1.08909	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-13T23:00:00.000Z	defillama-api	2.8001373827635234	\N	1691716321	1.08909	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-14T23:00:00.000Z	defillama-api	2.8007402892882283	\N	1682172656	1.08921	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-15T23:00:00.000Z	defillama-api	2.246838651132066	\N	1639667520	1.08932	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-16T23:00:00.000Z	defillama-api	2.8007500926463536	\N	1643006787	1.08932	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-17T23:00:00.000Z	defillama-api	2.801343195812933	\N	1669133113	1.08944	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-18T23:00:00.000Z	defillama-api	2.2473176152004726	\N	1666085497	1.08956	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-19T23:00:00.000Z	defillama-api	2.8013529991710584	\N	1623734580	1.08956	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-20T23:00:00.000Z	defillama-api	2.2475619989137385	\N	1632559328	1.08968	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-21T23:00:00.000Z	defillama-api	2.2478063826270045	\N	1623785045	1.08968	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-22T23:00:00.000Z	defillama-api	2.801946102337638	\N	1522145987	1.0898	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-23T23:00:00.000Z	defillama-api	2.2480507663402705	\N	1519499649	1.08992	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-24T23:00:00.000Z	defillama-api	2.2482951500535364	\N	1508571681	1.08992	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-25T23:00:00.000Z	defillama-api	2.802549008862343	\N	1411581671	1.09004	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-26T23:00:00.000Z	defillama-api	2.2485395337668024	\N	1464253546	1.09016	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-27T23:00:00.000Z	defillama-api	2.8028508122446283	\N	1461040363	1.09016	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-28T23:00:00.000Z	defillama-api	2.803453718769333	\N	1500659735	1.09027	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-29T23:00:00.000Z	defillama-api	2.249019198075075	\N	1537776905	1.09039	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-09-30T23:00:00.000Z	defillama-api	2.803453718769333	\N	1502455309	1.09039	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-01T23:00:00.000Z	defillama-api	2.894405074016504	\N	53168170	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-02T23:00:00.000Z	defillama-api	2.8953279901600126	\N	53550533	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-03T23:00:00.000Z	defillama-api	2.9932229239193475	\N	55378620	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-04T23:00:00.000Z	defillama-api	2.8957551364783285	\N	53636641	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-05T23:00:00.000Z	defillama-api	3.6536828634581298	\N	53451142	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-06T23:00:00.000Z	defillama-api	3.6536828634581298	\N	52971749	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-07T23:00:00.000Z	defillama-api	3.060728147730174	\N	53350964	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-08T23:00:00.000Z	defillama-api	3.145351435307475	\N	53360081	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-09T23:00:00.000Z	defillama-api	3.1689348137575735	\N	52888066	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-10T23:00:00.000Z	defillama-api	3.0871727062731225	\N	53782290	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-11T23:00:00.000Z	defillama-api	3.041542275639131	\N	55161875	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-12T23:00:00.000Z	defillama-api	3.1276451700534835	\N	57971898	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-13T23:00:00.000Z	defillama-api	3.118068689644815	\N	57425888	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-14T23:00:00.000Z	defillama-api	3.5716119501927324	\N	57131960	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-15T23:00:00.000Z	defillama-api	3.56754005537141	\N	55637323	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-16T23:00:00.000Z	defillama-api	2.958763419869115	\N	55759849	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-17T23:00:00.000Z	defillama-api	2.977489234368136	\N	56616302	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-18T23:00:00.000Z	defillama-api	3.02603056212547	\N	56580147	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-19T23:00:00.000Z	defillama-api	2.998725408787095	\N	55086430	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-20T23:00:00.000Z	defillama-api	2.9697242744930463	\N	55409512	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-21T23:00:00.000Z	defillama-api	2.9697242744930463	\N	55086541	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-22T23:00:00.000Z	defillama-api	2.842952148895961	\N	51664327	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-23T23:00:00.000Z	defillama-api	3.446606529777796	\N	51583798	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-24T23:00:00.000Z	defillama-api	3.443862289742583	\N	51282786	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-25T23:00:00.000Z	defillama-api	2.803132308670797	\N	47930915	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-26T23:00:00.000Z	defillama-api	2.8161707749774223	\N	49655847	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-27T23:00:00.000Z	defillama-api	2.8676762180879223	\N	49675412	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-28T23:00:00.000Z	defillama-api	2.7533746642660617	\N	51003943	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-29T23:00:00.000Z	defillama-api	2.640431575784419	\N	52193010	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-09-30T23:00:00.000Z	defillama-api	2.639340602073048	\N	50988984	\N	\N
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
