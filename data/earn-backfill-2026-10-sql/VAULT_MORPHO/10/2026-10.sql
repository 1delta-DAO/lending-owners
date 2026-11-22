-- Generated from VAULT_MORPHO/10/2026-10.ndjson (38 vault rows)
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
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-01T00:00:00.000Z	morpho-api	0	\N	136.55385807458515	1.011770652868852	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-02T00:00:00.000Z	morpho-api	0.0002674916288469831	\N	136.57080680563305	1.011770660276578	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-03T00:00:00.000Z	morpho-api	0	\N	136.57970261983584	1.011770660276578	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-04T00:00:00.000Z	morpho-api	0	\N	136.57934483842448	1.011770660276578	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-05T00:00:00.000Z	morpho-api	0	\N	136.57677118756087	1.011770660276578	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-06T00:00:00.000Z	morpho-api	0	\N	136.58252350440304	1.011770660276578	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-07T00:00:00.000Z	morpho-api	0.00009733334138672944	\N	136.37025796623152	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-08T00:00:00.000Z	morpho-api	0	\N	136.34087260087674	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-09T00:00:00.000Z	morpho-api	0	\N	136.33075255021882	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-10T00:00:00.000Z	morpho-api	0	\N	136.3439561402326	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-11T00:00:00.000Z	morpho-api	0	\N	136.34501794611256	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-12T00:00:00.000Z	morpho-api	0	\N	136.3375264397232	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-13T00:00:00.000Z	morpho-api	0	\N	136.3432402843154	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-14T00:00:00.000Z	morpho-api	0	\N	136.36020922473207	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-15T00:00:00.000Z	morpho-api	0	\N	136.34488936234845	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-16T00:00:00.000Z	morpho-api	0	\N	136.32804185497957	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-17T00:00:00.000Z	morpho-api	0	\N	136.37332777140418	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-18T00:00:00.000Z	morpho-api	0	\N	136.35599134173688	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-10-19T00:00:00.000Z	morpho-api	0	\N	136.3596011918841	1.01177066296718	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-01T00:00:00.000Z	morpho-api	5.2256100246950155	\N	2642828.657483841	1.0048914669953322	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-02T00:00:00.000Z	morpho-api	4.760797803982086	\N	2811370.009648694	1.0049202837181863	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-03T00:00:00.000Z	morpho-api	4.923983803095666	\N	2672002.444900332	1.0049488109645164	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-04T00:00:00.000Z	morpho-api	5.235112979917744	\N	2686205.3982658857	1.00497849679106	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-05T00:00:00.000Z	morpho-api	4.879016499614863	\N	2858409.0979835363	1.005007275688823	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-06T00:00:00.000Z	morpho-api	4.944406999030093	\N	2880813.199807506	1.0050350748833732	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-07T00:00:00.000Z	morpho-api	5.024996904978707	\N	2643734.5087661655	1.0050625875309482	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-08T00:00:00.000Z	morpho-api	4.598643958431126	\N	2780967.20505114	1.005089436216438	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-09T00:00:00.000Z	morpho-api	4.513477284717737	\N	2701391.2290208004	1.005114635140735	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-10T00:00:00.000Z	morpho-api	5.292421310798545	\N	2524441.5529670785	1.0051422686818803	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-11T00:00:00.000Z	morpho-api	5.42796884239749	\N	2582504.8979964	1.0051705125611063	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-12T00:00:00.000Z	morpho-api	5.545831115938427	\N	2602735.6734209494	1.0051990222471623	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-13T00:00:00.000Z	morpho-api	5.173825185877945	\N	2562182.926753253	1.005227608083334	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-14T00:00:00.000Z	morpho-api	5.761909733337234	\N	2750881.3826174675	1.0052558291531732	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-15T00:00:00.000Z	morpho-api	5.730787572488794	\N	2502523.974599857	1.0052873867086536	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-16T00:00:00.000Z	morpho-api	5.210359500651407	\N	2743568.984294333	1.0053186492328532	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-17T00:00:00.000Z	morpho-api	4.7971794664647405	\N	2878001.056830755	1.0053418260675384	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-18T00:00:00.000Z	morpho-api	4.5131187619062985	\N	2877173.926858948	1.0053649784388878	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-10-19T00:00:00.000Z	morpho-api	4.340193126495251	\N	2919284.3301784066	1.005387567165123	assets_per_share
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
