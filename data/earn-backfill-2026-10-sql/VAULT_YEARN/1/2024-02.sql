-- Generated from VAULT_YEARN/1/2024-02.ndjson (68 vault rows)
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
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-20T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-21T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-22T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-23T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-24T00:00:00.000Z	yearn-kong	0	\N	0	1.0000440866006088	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-25T00:00:00.000Z	yearn-kong	1.7334619947462215	\N	0	1.0000946852725072	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-26T00:00:00.000Z	yearn-kong	2.160534787876145	\N	0	1.0001771457422644	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-27T00:00:00.000Z	yearn-kong	2.1608842075693246	\N	0	1.0002711988904653	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-28T00:00:00.000Z	yearn-kong	2.567257910257581	\N	0	1.000350967994899	assets_per_share
VAULT_YEARN	1	0xb974598227660befe79a23dfc473d859602254ac	2024-02-29T00:00:00.000Z	yearn-kong	2.6542781188965137	\N	0	1.0004354449486321	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-01T00:00:00.000Z	yearn-kong	4.142570031007153	\N	0	1.0052855925558333	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-02T00:00:00.000Z	yearn-kong	3.404651658200919	\N	0	1.005351467219373	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-03T00:00:00.000Z	yearn-kong	4.98380529485587	\N	0	1.005817461998089	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-04T00:00:00.000Z	yearn-kong	5.383418181637012	\N	0	1.0062060343755814	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-05T00:00:00.000Z	yearn-kong	8.746469289633296	\N	0	1.0065510894054437	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-06T00:00:00.000Z	yearn-kong	10.21692679259445	\N	0	1.0068412666161235	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-07T00:00:00.000Z	yearn-kong	12.72832586849404	\N	0	1.0073229615134087	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-08T00:00:00.000Z	yearn-kong	10.564079809327609	\N	0	1.0078463776851239	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-09T00:00:00.000Z	yearn-kong	18.082690397847045	\N	0	1.0083813418351075	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-10T00:00:00.000Z	yearn-kong	18.354831619404877	\N	0	1.0089277539796349	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-11T00:00:00.000Z	yearn-kong	18.844859477695763	\N	0	1.0094773590682036	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-12T00:00:00.000Z	yearn-kong	19.729288337444473	\N	0	1.0100143117527416	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-13T00:00:00.000Z	yearn-kong	21.190186165753744	\N	0	1.0105293096717436	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-14T00:00:00.000Z	yearn-kong	21.6150693088224	\N	0	1.011037861570306	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-15T00:00:00.000Z	yearn-kong	21.787160258313065	\N	0	1.011541251957113	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-16T00:00:00.000Z	yearn-kong	23.233497999086694	\N	0	1.0123022801935864	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-17T00:00:00.000Z	yearn-kong	24.119785995679877	\N	0	1.0123023866022354	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-18T00:00:00.000Z	yearn-kong	23.93187172593514	\N	0	1.0133824743215456	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-19T00:00:00.000Z	yearn-kong	23.931835313462102	\N	0	1.0138221287000881	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-20T00:00:00.000Z	yearn-kong	23.60232484015512	\N	0	1.0143682001490177	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-21T00:00:00.000Z	yearn-kong	22.986227897092704	\N	0	1.0148454645273306	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-22T00:00:00.000Z	yearn-kong	21.973404455977175	\N	0	1.015222044721465	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-23T00:00:00.000Z	yearn-kong	18.951805711964198	\N	0	1.0156231975472252	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-24T00:00:00.000Z	yearn-kong	15.895430955481515	\N	0	1.0156233107875445	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-25T00:00:00.000Z	yearn-kong	16.073851373121784	\N	0	1.0164391285963992	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-26T00:00:00.000Z	yearn-kong	16.47627782368488	\N	0	1.0168533186174054	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-27T00:00:00.000Z	yearn-kong	16.61892508728613	\N	0	1.0168534354574257	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-28T00:00:00.000Z	yearn-kong	\N	\N	0	1.0169855200641438	assets_per_share
VAULT_YEARN	1	0x082a5743aadf3d0daf750eef24652b36a68b1e9c	2024-02-29T00:00:00.000Z	yearn-kong	16.61386375353402	\N	0	1.0171281484035208	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-01T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-02T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-03T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-04T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-05T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-06T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-07T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-08T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-09T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-10T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-11T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-12T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-13T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-14T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-15T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-16T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-17T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-18T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-19T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-20T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-21T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-22T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-23T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-24T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-25T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-26T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-27T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-28T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	1	0x04aebe2e4301cdf5e9c57b01ebdfe4ac4b48dd13	2024-02-29T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
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
