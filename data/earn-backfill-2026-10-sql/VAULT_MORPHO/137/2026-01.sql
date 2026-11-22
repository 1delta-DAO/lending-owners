-- Generated from VAULT_MORPHO/137/2026-01.ndjson (31 vault rows)
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
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-01T00:00:00.000Z	morpho-api	3.2345465889704883	\N	0.00006373836030948116	1.0003518711871695	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-02T00:00:00.000Z	morpho-api	3.2268418497238827	\N	0.00006372167812531349	1.0004402385155646	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-03T00:00:00.000Z	morpho-api	3.2191553167137954	\N	0.0000637797491720976	1.0005284031164225	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-04T00:00:00.000Z	morpho-api	3.211489090659825	\N	0.00006382725444738234	1.0006163654999274	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-05T00:00:00.000Z	morpho-api	3.203843871801837	\N	0.00006379670869033847	1.0007041261762384	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-06T00:00:00.000Z	morpho-api	3.1962189598999657	\N	0.00006380920686301761	1.000791685656013	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-07T00:00:00.000Z	morpho-api	3.188614354954211	\N	0.00006376334102595795	1.0008790444498172	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-08T00:00:00.000Z	morpho-api	3.1810307572044394	\N	0.0000636052915958544	1.0009662030699564	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-09T00:00:00.000Z	morpho-api	3.1734674664107843	\N	0.00006343859365683918	1.0010531620278331	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-10T00:00:00.000Z	morpho-api	3.165925182813112	\N	0.00006322857615440958	1.001139921835635	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-11T00:00:00.000Z	morpho-api	3.158403906411422	\N	0.00006308508999494151	1.0012264830059279	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-12T00:00:00.000Z	morpho-api	3.150902236725983	\N	0.00006317505215646097	1.0013128460508163	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-13T00:00:00.000Z	morpho-api	3.143422274476393	\N	0.00006315530000925724	1.001399011486141	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-14T00:00:00.000Z	morpho-api	1.2647711454150112	\N	0.00006266069821036293	1.0014337118357255	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-15T00:00:00.000Z	morpho-api	0.0002541870713912431	\N	0.00006310067959843193	1.0014337188080615	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-16T00:00:00.000Z	morpho-api	0.013375981922081337	\N	0.00006265690342213887	1.0014340858036372	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-17T00:00:00.000Z	morpho-api	0.9617045304111116	\N	0.00006295370167433611	1.001460472012468	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-18T00:00:00.000Z	morpho-api	1.2857748401984281	\N	0.00006283226822247483	1.0014957386988883	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-19T00:00:00.000Z	morpho-api	1.2422003138112814	\N	0.00006316060836291762	1.0015298113815352	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-20T00:00:00.000Z	morpho-api	1.00175825075155	\N	0.00006318781373213912	1.001556888020882	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-21T00:00:00.000Z	morpho-api	8.186448955527226	\N	0.00006322097795280358	1.0017811087915631	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-22T00:00:00.000Z	morpho-api	9.393541343172274	\N	0.00006308076451125682	1.0020384564398754	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-23T00:00:00.000Z	morpho-api	10.82014142284038	\N	0.00006302429151486391	1.002334914307987	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-24T00:00:00.000Z	morpho-api	12.38495134607831	\N	0.00006397406569156877	1.0026743070761375	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-25T00:00:00.000Z	morpho-api	7.7709056117925	\N	0.00006404348293201062	1.0028876310136783	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-26T00:00:00.000Z	morpho-api	4.441461115689549	\N	0.00006450023643133184	1.0030096018489907	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-27T00:00:00.000Z	morpho-api	3.2205564966858446	\N	0.00006495539013267278	1.003098033190656	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-28T00:00:00.000Z	morpho-api	9.327672579928503	\N	176.825572759859	1.0033539488500094	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-29T00:00:00.000Z	morpho-api	2.6561659655754966	\N	20346.753761790304	1.0034269645450902	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-30T00:00:00.000Z	morpho-api	0.7061575931999187	\N	18095.39031834302	1.003446373664343	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-01-31T00:00:00.000Z	morpho-api	1.1064020963402754	\N	20828.51253156546	1.0034767828972675	assets_per_share
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
