-- Generated from VAULT_MORPHO/747474/2025-12.ndjson (38 vault rows)
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
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-03T00:00:00.000Z	morpho-api	\N	\N	2.0071867901601053	1.000005666664777	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-04T00:00:00.000Z	morpho-api	5.57162445140591	\N	1.9965276823992242	1.000021666659444	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-05T00:00:00.000Z	morpho-api	5.50877092102553	\N	2.0053267565788806	1.000036166654611	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-06T00:00:00.000Z	morpho-api	5.48922792660278	\N	1.9929651200633922	1.000050666649777	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-07T00:00:00.000Z	morpho-api	5.111716710715086	\N	1.9975875217363592	1.000058666647111	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-08T00:00:00.000Z	morpho-api	5.075800707743383	\N	1.9675569045265957	1.000065666644777	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-09T00:00:00.000Z	morpho-api	5.0383287717892244	\N	1.9964599809689838	1.000073666642111	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-10T00:00:00.000Z	morpho-api	5.034583188745501	\N	1.9985726355669617	1.000081666639444	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-11T00:00:00.000Z	morpho-api	4.9273582590103615	\N	1.9992089822957317	1.000086666637777	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-12T00:00:00.000Z	morpho-api	4.8721667532447555	\N	2.0004634158680124	1.000091166636277	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-13T00:00:00.000Z	morpho-api	4.607113359611503	\N	2.0048958836322073	1.000087166637611	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-14T00:00:00.000Z	morpho-api	4.466077347942132	\N	2.00147185354586	1.000079166640277	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-15T00:00:00.000Z	morpho-api	4.462061472310097	\N	2.0005033097935785	1.000071166642944	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-16T00:00:00.000Z	morpho-api	0.7124919630285831	\N	2.0015748067640198	1.000063666645444	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-17T00:00:00.000Z	morpho-api	4.183251866507476	\N	2.0002097198925015	1.000054666648444	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-18T00:00:00.000Z	morpho-api	4.189683569677527	\N	6.009001513915343	1.000045500262124	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-19T00:00:00.000Z	morpho-api	4.128617051435413	\N	6.00627627074347	1.000035001357457	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-20T00:00:00.000Z	morpho-api	4.273199077786671	\N	5.994651292026206	1.000025502348473	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-21T00:00:00.000Z	morpho-api	4.223907793132753	\N	5.998038799004024	1.000016336638049	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-22T00:00:00.000Z	morpho-api	4.259663441175121	\N	6.0081929644689644	1.00000883742043	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-23T00:00:00.000Z	morpho-api	4.228088925373186	\N	6.007282020818441	1.000000838254969	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-24T00:00:00.000Z	morpho-api	4.206361882808096	\N	6.004640960142106	0.999992172492387	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-25T00:00:00.000Z	morpho-api	4.215622555037157	\N	6.013327116251276	0.999983673379086	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-26T00:00:00.000Z	morpho-api	4.208090775037476	\N	5.984082592321526	0.999975007616503	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-27T00:00:00.000Z	morpho-api	4.22070489598525	\N	5.990432378935957	0.999966508503202	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-28T00:00:00.000Z	morpho-api	4.217100061154611	\N	6.002154019068177	0.99995817603918	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-29T00:00:00.000Z	morpho-api	-0.3284811207038274	\N	6.002974654441352	0.999949176978037	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-30T00:00:00.000Z	morpho-api	4.179316518460041	\N	6.003017978434065	0.999939512035873	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2025-12-31T00:00:00.000Z	morpho-api	4.196986371240996	\N	6.000176153546743	0.99992968297832	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-23T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-24T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-25T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-26T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-27T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-28T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-29T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-30T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2025-12-31T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
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
