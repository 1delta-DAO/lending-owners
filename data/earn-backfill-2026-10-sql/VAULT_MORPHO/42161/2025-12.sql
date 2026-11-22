-- Generated from VAULT_MORPHO/42161/2025-12.ndjson (47 vault rows)
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
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-16T00:00:00.000Z	morpho-api	\N	\N	0.010000585788729926	1	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-17T00:00:00.000Z	morpho-api	4.901719676553284	\N	0.010001999821918831	1.000099990000999	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-18T00:00:00.000Z	morpho-api	73.44807622580163	\N	1626777.6562565968	1.002098251838226	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-19T00:00:00.000Z	morpho-api	4.806375716626121	\N	978945.4412221104	1.002201638197488	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-20T00:00:00.000Z	morpho-api	4.589866451709668	\N	900372.1107169751	1.002298883433129	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-21T00:00:00.000Z	morpho-api	4.671842832593143	\N	900579.2037610813	1.002393877218647	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-22T00:00:00.000Z	morpho-api	4.617908957627037	\N	900653.1152102598	1.002489966042127	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-23T00:00:00.000Z	morpho-api	4.6433052570904465	\N	900542.4164203326	1.002585180638587	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-24T00:00:00.000Z	morpho-api	4.371768342537052	\N	900532.1566834543	1.002679182613438	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-25T00:00:00.000Z	morpho-api	10.379890815670478	\N	5373978.677922713	1.002766542079313	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-26T00:00:00.000Z	morpho-api	7.304265064789206	\N	9317368.098405909	1.002840677802899	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-27T00:00:00.000Z	morpho-api	6.877980041508636	\N	12246199.40161898	1.002920324253627	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-28T00:00:00.000Z	morpho-api	6.917637426084866	\N	14196249.962330915	1.003008840574394	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-29T00:00:00.000Z	morpho-api	6.905462355533132	\N	14512889.545086432	1.003098434106806	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-30T00:00:00.000Z	morpho-api	6.483701582027379	\N	15731369.863449559	1.003184591998297	assets_per_share
VAULT_MORPHO	42161	0xbeeff1d5de8f79ff37a151681100b039661da518	2025-12-31T00:00:00.000Z	morpho-api	4.30196913292491	\N	35404563.85260382	1.003245078365798	assets_per_share
VAULT_MORPHO	42161	0x5837e4189819637853a357af36650902347f5e73	2025-12-31T00:00:00.000Z	morpho-api	\N	\N	0.09998681144405716	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-25T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-26T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-27T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-28T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-29T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-30T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x55a2b207b0074e13adcb858950a81b7a04775e0f	2025-12-31T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-25T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-26T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-27T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-28T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-29T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-30T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0x610d151ae40662ae148cdbaae1ea5904b6afae78	2025-12-31T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-16T00:00:00.000Z	morpho-api	\N	\N	0.009997770838206396	1	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-17T00:00:00.000Z	morpho-api	0	\N	0.009999408193068788	1	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-18T00:00:00.000Z	morpho-api	0.717094639668403	\N	6550.990841825816	1.000019646620922	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-19T00:00:00.000Z	morpho-api	0.614496194728531	\N	6548.548034696549	1.000036482604775	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-20T00:00:00.000Z	morpho-api	0.5098061333086434	\N	6548.340201799595	1.000050450495861	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-21T00:00:00.000Z	morpho-api	0.4723734107869859	\N	6549.978402946143	1.000063392960268	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-22T00:00:00.000Z	morpho-api	0.4465912791573601	\N	6550.944461167429	1.000075629186423	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-23T00:00:00.000Z	morpho-api	0.4005505079618388	\N	6452.512329351714	1.000086604067988	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-24T00:00:00.000Z	morpho-api	0.357931808991907	\N	6448.393135543064	1.000096411314142	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-25T00:00:00.000Z	morpho-api	9.64199274982036	\N	3551573.3883420005	1.000109523811705	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-26T00:00:00.000Z	morpho-api	8.74826190369049	\N	4698282.131240675	1.000163249951342	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-27T00:00:00.000Z	morpho-api	7.520177025099883	\N	5865301.088571897	1.000213537531102	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-28T00:00:00.000Z	morpho-api	6.682726557727392	\N	6756083.153434594	1.000257549013538	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-29T00:00:00.000Z	morpho-api	6.267286849492848	\N	6656940.898349467	1.000288790831557	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-30T00:00:00.000Z	morpho-api	3.326100850742364	\N	14427661.657018937	1.000309773698409	assets_per_share
VAULT_MORPHO	42161	0xbeeff77ce5c059445714e6a3490e273fe7f2492f	2025-12-31T00:00:00.000Z	morpho-api	1.1765423227672045	\N	37031923.6655815	1.000316417136981	assets_per_share
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
