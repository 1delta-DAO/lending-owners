-- Generated from VAULT_LLAMA/10/2026-08.ndjson (62 vault rows)
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
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-01T23:00:00.000Z	defillama-api	3.246718858562758	\N	8093978	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-02T23:00:00.000Z	defillama-api	3.246718858562758	\N	8092399	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-03T23:00:00.000Z	defillama-api	3.246718858562758	\N	8097853	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-04T23:00:00.000Z	defillama-api	3.246718858562758	\N	8087402	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-05T23:00:00.000Z	defillama-api	3.246718858562758	\N	8061277	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-06T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094668	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-07T23:00:00.000Z	defillama-api	3.246718858562758	\N	8039284	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-08T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099067	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-09T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099148	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-10T23:00:00.000Z	defillama-api	3.246718858562758	\N	8098191	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-11T23:00:00.000Z	defillama-api	3.246718858562758	\N	7991105	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-12T23:00:00.000Z	defillama-api	3.246718858562758	\N	1369	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-13T23:00:00.000Z	defillama-api	3.246718858562758	\N	8098259	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-14T23:00:00.000Z	defillama-api	3.246718858562758	\N	8098228	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-15T23:00:00.000Z	defillama-api	3.246718858562758	\N	8094423	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-16T23:00:00.000Z	defillama-api	3.246718858562758	\N	8095172	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-17T23:00:00.000Z	defillama-api	3.246718858562758	\N	8095797	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-18T23:00:00.000Z	defillama-api	3.246718858562758	\N	8097180	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-19T23:00:00.000Z	defillama-api	3.246718858562758	\N	8097363	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-20T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099055	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-21T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099877	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-22T23:00:00.000Z	defillama-api	3.246718858562758	\N	8099994	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-23T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100487	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-24T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100353	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-25T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100675	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-26T23:00:00.000Z	defillama-api	3.246718858562758	\N	8101565	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-27T23:00:00.000Z	defillama-api	3.246718858562758	\N	8102311	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-28T23:00:00.000Z	defillama-api	3.246718858562758	\N	8101194	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-29T23:00:00.000Z	defillama-api	3.246718858562758	\N	8101366	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-30T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100711	\N	\N
VAULT_LLAMA	10	0xa6c17e2c8a3ad6307ae159d1cbc9e33b4d53958e	2026-08-31T23:00:00.000Z	defillama-api	3.246718858562758	\N	8100114	\N	\N
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-01T23:00:00.000Z	defillama-api	1.1677157992551201	\N	1545276	1.00371	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-02T23:00:00.000Z	defillama-api	1.1738828117557887	\N	1569285	1.00374	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-03T23:00:00.000Z	defillama-api	1.182708635028007	\N	1553087	1.00377	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-04T23:00:00.000Z	defillama-api	1.090334392372938	\N	1564861	1.00379	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-05T23:00:00.000Z	defillama-api	1.1926597437650344	\N	1599850	1.00385	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-06T23:00:00.000Z	defillama-api	1.206848003931782	\N	1598531	1.00389	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-07T23:00:00.000Z	defillama-api	1.2222896934588334	\N	1603463	1.00394	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-08T23:00:00.000Z	defillama-api	1.2301428835570505	\N	1610633	1.00396	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-09T23:00:00.000Z	defillama-api	1.2679376300894774	\N	1607612	1.004	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-10T23:00:00.000Z	defillama-api	1.1750291044165806	\N	1574924	1.00404	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-11T23:00:00.000Z	defillama-api	1.2846530559329494	\N	1568459	1.00406	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-12T23:00:00.000Z	defillama-api	1.2433781172660474	\N	1571486	1.00408	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-13T23:00:00.000Z	defillama-api	1.2120052705455464	\N	1624063	1.00413	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-14T23:00:00.000Z	defillama-api	1.2274357562347404	\N	1565370	1.00417	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-15T23:00:00.000Z	defillama-api	1.2716306951432443	\N	1569536	1.0042	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-16T23:00:00.000Z	defillama-api	1.2769819281999162	\N	1569322	1.00424	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-17T23:00:00.000Z	defillama-api	1.3223679751206419	\N	1594311	1.00428	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-18T23:00:00.000Z	defillama-api	1.3136240799127563	\N	1602327	1.0043	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-19T23:00:00.000Z	defillama-api	1.2162039087826315	\N	1892304	1.00432	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-20T23:00:00.000Z	defillama-api	1.2505184631805832	\N	1935549	1.00437	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-21T23:00:00.000Z	defillama-api	1.0904625362684328	\N	2151638	1.00436	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-22T23:00:00.000Z	defillama-api	1.2095355245378414	\N	2059858	1.00443	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-23T23:00:00.000Z	defillama-api	1.2302808308106705	\N	2097020	1.00447	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-24T23:00:00.000Z	defillama-api	1.212805644712489	\N	2113383	1.00451	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-25T23:00:00.000Z	defillama-api	1.3207987375807306	\N	2086653	1.00457	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-26T23:00:00.000Z	defillama-api	1.3736815525078327	\N	2125108	1.00461	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-27T23:00:00.000Z	defillama-api	1.3196741523557876	\N	2142928	1.00463	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-28T22:00:00.000Z	defillama-api	1.2746417265674381	\N	2069536	1.00466	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-29T23:00:00.000Z	defillama-api	1.3003881459638933	\N	2090384	1.0047	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-30T23:00:00.000Z	defillama-api	1.337554777336436	\N	2078491	1.00475	assets_per_share
VAULT_LLAMA	10	0x91b8657aea26caa8a0e9d6dd4e24727ccf32f822	2026-08-31T23:00:00.000Z	defillama-api	1.2905959916764687	\N	2079952	1.00478	assets_per_share
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
