-- Generated from VAULT_LLAMA/10/2026-10.ndjson (44 vault rows)
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
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-01T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099109	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-02T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100524	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-03T22:00:00.000Z	defillama-api	3.246718858562758	\N	8100309	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-04T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100369	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-05T23:00:00.000Z	defillama-api	3.246718858562758	\N	8101072	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-06T23:00:00.000Z	defillama-api	3.246718858562758	\N	8101035	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-07T23:00:00.000Z	defillama-api	3.246718858562758	\N	8098325	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-08T23:00:00.000Z	defillama-api	3.246718858562758	\N	8095395	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-09T23:00:00.000Z	defillama-api	3.246718858562758	\N	8095000	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-10T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094845	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-11T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094357	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-12T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093195	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-13T23:00:00.000Z	defillama-api	3.246718858562758	\N	8096089	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-14T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093497	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-15T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094338	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-16T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094020	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-17T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093876	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-18T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094952	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-19T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094570	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-20T23:00:00.000Z	defillama-api	3.246718858562758	\N	8095166	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-21T23:00:00.000Z	defillama-api	3.246718858562758	\N	8096869	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-22T23:00:00.000Z	defillama-api	3.246718858562758	\N	8092922	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-23T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094915	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-24T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093970	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-25T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093053	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-10-26T23:00:00.000Z	defillama-api	3.246718858562758	\N	8090190	\N	\N
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-01T23:00:00.000Z	defillama-api	0.7882649189383528	\N	2658836	1.00568	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-02T23:00:00.000Z	defillama-api	0.9677223918203026	\N	2617963	1.00577	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-03T23:00:00.000Z	defillama-api	0.9876071032977052	\N	2640416	1.0058	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-04T23:00:00.000Z	defillama-api	1.1032419138246041	\N	2677272	1.00586	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-05T23:00:00.000Z	defillama-api	1.0472178228582152	\N	2712700	1.0059	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-06T23:00:00.000Z	defillama-api	1.037291222516501	\N	2693631	1.00592	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-07T23:00:00.000Z	defillama-api	1.129774002350814	\N	2565275	1.00598	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-08T23:00:00.000Z	defillama-api	1.1080287535492062	\N	2496791	1.00601	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-09T23:00:00.000Z	defillama-api	1.0550549074395121	\N	2510111	1.00604	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-10T23:00:00.000Z	defillama-api	1.0830140848128167	\N	2534785	1.00607	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-11T23:00:00.000Z	defillama-api	1.0353319513711767	\N	2564135	1.0061	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-12T23:00:00.000Z	defillama-api	1.11810590546213	\N	2512074	1.00614	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-13T23:00:00.000Z	defillama-api	1.1605397411074136	\N	2542276	1.00617	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-14T23:00:00.000Z	defillama-api	1.1027174341649015	\N	2449048	1.0062	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-15T23:00:00.000Z	defillama-api	1.4036133055839173	\N	2486431	1.00623	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-16T23:00:00.000Z	defillama-api	1.282707789584947	\N	2450623	1.00626	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-17T23:00:00.000Z	defillama-api	1.273585064609506	\N	2421167	1.00629	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-10-18T23:00:00.000Z	defillama-api	1.1348759500151573	\N	2418863	1.0063	assets_per_share
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
