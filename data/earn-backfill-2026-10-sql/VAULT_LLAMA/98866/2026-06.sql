-- Generated from VAULT_LLAMA/98866/2026-06.ndjson (60 vault rows)
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
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-01T23:00:00.000Z	defillama-api	7.367211727071776	\N	4142910	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-02T23:00:00.000Z	defillama-api	7.376027746985869	\N	4143750	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-03T23:00:00.000Z	defillama-api	7.374532034631898	\N	4144588	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-04T23:00:00.000Z	defillama-api	7.373046125636051	\N	4145426	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-05T23:00:00.000Z	defillama-api	7.366412753384566	\N	4146260	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-06T23:00:00.000Z	defillama-api	7.370063804046367	\N	4147098	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-07T23:00:00.000Z	defillama-api	7.368577895050521	\N	4147936	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-08T23:00:00.000Z	defillama-api	7.377374308248363	\N	4148778	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-09T23:00:00.000Z	defillama-api	7.37074233647661	\N	4820612	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-10T23:00:00.000Z	defillama-api	7.369255727240898	\N	4821585	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-11T23:00:00.000Z	defillama-api	7.367769118005185	\N	5322559	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-12T23:00:00.000Z	defillama-api	7.376548025206375	\N	5423638	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-13T23:00:00.000Z	defillama-api	7.375061415970663	\N	5424733	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-14T23:00:00.000Z	defillama-api	7.378702663274339	\N	5425833	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-15T23:00:00.000Z	defillama-api	7.366942834963197	\N	6426922	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-16T23:00:00.000Z	defillama-api	7.37573014504278	\N	6928224	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-17T23:00:00.000Z	defillama-api	7.374235132928675	\N	6929624	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-18T23:00:00.000Z	defillama-api	7.377876380232351	\N	7650028	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-19T23:00:00.000Z	defillama-api	7.376380667878379	\N	7651577	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-20T23:00:00.000Z	defillama-api	7.380021915182056	\N	7653127	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-21T23:00:00.000Z	defillama-api	7.3733990465285615	\N	7654669	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-22T23:00:00.000Z	defillama-api	7.38216745013176	\N	7656218	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-23T23:00:00.000Z	defillama-api	7.380671737777789	\N	7657768	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-24T23:00:00.000Z	defillama-api	7.379185828781942	\N	10059310	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-25T23:00:00.000Z	defillama-api	7.377690116427971	\N	10061345	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-26T23:00:00.000Z	defillama-api	7.376195104313865	\N	10063380	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-27T23:00:00.000Z	defillama-api	7.374708495078153	\N	10065415	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-28T23:00:00.000Z	defillama-api	7.37834063926357	\N	10065438	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-29T23:00:00.000Z	defillama-api	7.376844926909598	\N	10067472	\N	\N
VAULT_LLAMA	98866	0x066d10e240999aea6798b2e2ca0bdac2923cbdff	2026-06-30T23:00:00.000Z	defillama-api	7.380467967976756	\N	12069517	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-01T23:00:00.000Z	defillama-api	11.101601436536157	\N	9161448	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-02T23:00:00.000Z	defillama-api	9.554206478767924	\N	9146388	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-03T23:00:00.000Z	defillama-api	11.104787527926874	\N	9149840	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-04T23:00:00.000Z	defillama-api	9.582713943956378	\N	9124714	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-05T23:00:00.000Z	defillama-api	7.968011930259422	\N	9524707	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-06T23:00:00.000Z	defillama-api	10.985328007251383	\N	9523773	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-07T23:00:00.000Z	defillama-api	10.985328007251383	\N	9499941	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-08T23:00:00.000Z	defillama-api	8.685159788157648	\N	10246467	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-09T23:00:00.000Z	defillama-api	12.11506909832849	\N	10443038	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-10T23:00:00.000Z	defillama-api	11.530993424102576	\N	10449267	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-11T23:00:00.000Z	defillama-api	12.014788447345381	\N	10465525	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-12T23:00:00.000Z	defillama-api	13.564172786573181	\N	10488641	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-13T23:00:00.000Z	defillama-api	10.546858810300819	\N	10488023	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-14T23:00:00.000Z	defillama-api	10.546858810300819	\N	10485691	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-15T23:00:00.000Z	defillama-api	8.804402934714517	\N	10556856	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-16T23:00:00.000Z	defillama-api	8.308539977619489	\N	10649836	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-17T23:00:00.000Z	defillama-api	7.186614263687829	\N	10681635	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-18T23:00:00.000Z	defillama-api	9.333322815407996	\N	11572326	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-19T23:00:00.000Z	defillama-api	9.296406869907514	\N	12660303	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-20T23:00:00.000Z	defillama-api	9.29152199660166	\N	12708070	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-21T23:00:00.000Z	defillama-api	9.29152199660166	\N	12668442	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-22T23:00:00.000Z	defillama-api	10.289109618710768	\N	12645250	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-23T23:00:00.000Z	defillama-api	10.466627427163644	\N	12714345	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-24T23:00:00.000Z	defillama-api	10.458665699886183	\N	12691061	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-25T23:00:00.000Z	defillama-api	10.850761511704832	\N	12694855	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-26T23:00:00.000Z	defillama-api	10.901161276066773	\N	12679601	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-27T23:00:00.000Z	defillama-api	10.906039146973967	\N	12679162	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-28T23:00:00.000Z	defillama-api	10.906039146973967	\N	12686150	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-29T23:00:00.000Z	defillama-api	10.91089040876625	\N	12709430	\N	\N
VAULT_LLAMA	98866	0x119dd7daff816f29d7ee47596ae5e4bdc4299165	2026-06-30T23:00:00.000Z	defillama-api	10.902730513606684	\N	12686222	\N	\N
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
