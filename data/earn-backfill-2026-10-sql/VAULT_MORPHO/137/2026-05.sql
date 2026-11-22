-- Generated from VAULT_MORPHO/137/2026-05.ndjson (31 vault rows)
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
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-01T00:00:00.000Z	morpho-api	0.4844875604703702	\N	82480.97034584061	1.0060904473200927	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-02T00:00:00.000Z	morpho-api	0.42988915787134374	\N	80543.22146761304	1.0061022969021223	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-03T00:00:00.000Z	morpho-api	0.43125392537035623	\N	80413.86823014761	1.0061141842531272	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-04T00:00:00.000Z	morpho-api	0.4297491098981254	\N	80491.83786860699	1.0061260302687745	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-05T00:00:00.000Z	morpho-api	0.47760070138735955	\N	80573.97120175527	1.0061391954651138	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-06T00:00:00.000Z	morpho-api	1.359697762381984	\N	80662.89803227542	1.0061766768470601	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-07T00:00:00.000Z	morpho-api	0.7422164451043045	\N	81196.781420153	1.006197137343451	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-08T00:00:00.000Z	morpho-api	0.6631810716584141	\N	80869.35906375079	1.0062154194432171	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-09T00:00:00.000Z	morpho-api	0.9289543118740085	\N	80847.86035545137	1.0062410287576808	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-10T00:00:00.000Z	morpho-api	1.0183385303008663	\N	81192.81420070623	1.0062691029555713	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-11T00:00:00.000Z	morpho-api	0.980150248963696	\N	93857.34694342635	1.0062961250912257	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-12T00:00:00.000Z	morpho-api	1.0537524612885818	\N	93690.4088281426	1.0063251772069493	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-13T00:00:00.000Z	morpho-api	0.7419657592322437	\N	88284.4819028304	1.00634563382145	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-14T00:00:00.000Z	morpho-api	0.4678582641304274	\N	92503.27711130028	1.0063585332757752	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-15T00:00:00.000Z	morpho-api	0.4775467829176705	\N	91123.94136182933	1.006371700017816	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-16T00:00:00.000Z	morpho-api	0.5471499253673073	\N	90857.22997140762	1.0063867860470037	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-17T00:00:00.000Z	morpho-api	0.5720686612420423	\N	91054.86840259582	1.0064025593903123	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-18T00:00:00.000Z	morpho-api	0.5697284596095642	\N	93263.027249012	1.0064182684560055	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-19T00:00:00.000Z	morpho-api	0.6174820175175455	\N	93258.2124770505	1.0064352945026682	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-20T00:00:00.000Z	morpho-api	0.6330707574164762	\N	93346.8957713063	1.0064527506834082	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-21T00:00:00.000Z	morpho-api	0.6281186610834766	\N	91120.37662718515	1.006470070600681	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-22T00:00:00.000Z	morpho-api	0.6348206568418391	\N	90942.32862916352	1.0064875756244738	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-23T00:00:00.000Z	morpho-api	0.6343178846179853	\N	90800.2120630062	1.0065050671028828	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-24T00:00:00.000Z	morpho-api	0.6441954681690731	\N	90431.44493091322	1.006522831252961	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-25T00:00:00.000Z	morpho-api	0.6895864167688615	\N	83992.62781806181	1.0065418474479246	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-26T00:00:00.000Z	morpho-api	0.6786304638239926	\N	82954.25154950739	1.0065605618611262	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-27T00:00:00.000Z	morpho-api	0.679077216858559	\N	82819.00754683343	1.0065792889530947	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-28T00:00:00.000Z	morpho-api	0.6865977930203826	\N	82523.94914635672	1.006598223797417	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-29T00:00:00.000Z	morpho-api	0.6698543575822669	\N	82533.59648653741	1.006616697233856	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-30T00:00:00.000Z	morpho-api	0.7112581403845297	\N	82593.4210265415	1.006636312883209	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-05-31T00:00:00.000Z	morpho-api	0.7063368546056381	\N	82613.93995246459	1.0066557931865927	assets_per_share
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
