-- Generated from VAULT_LLAMA/solana/2026-03.ndjson (62 vault rows)
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
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-01T23:00:00.000Z	defillama-api	10.929771676515543	\N	14361	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-02T23:00:00.000Z	defillama-api	7.252585261952049	\N	14575	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-03T23:00:00.000Z	defillama-api	9.726426972633817	\N	14579	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-04T23:00:00.000Z	defillama-api	10.188343701500457	\N	14584	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-05T23:00:00.000Z	defillama-api	10.588191868876606	\N	14589	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-06T23:00:00.000Z	defillama-api	10.430595884614036	\N	14593	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-07T23:00:00.000Z	defillama-api	11.241996728728054	\N	14593	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-08T23:00:00.000Z	defillama-api	11.23943175009856	\N	14593	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-09T23:00:00.000Z	defillama-api	9.859876585593952	\N	14605	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-10T23:00:00.000Z	defillama-api	9.874880625204696	\N	14612	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-11T23:00:00.000Z	defillama-api	9.703124390370022	\N	14616	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-12T23:00:00.000Z	defillama-api	9.016615527812633	\N	14897	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-13T23:00:00.000Z	defillama-api	9.170815348724659	\N	14905	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-14T23:00:00.000Z	defillama-api	10.017885711377517	\N	24890	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-15T23:00:00.000Z	defillama-api	10.008431072705548	\N	14955	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-16T23:00:00.000Z	defillama-api	7.438337190990296	\N	14969	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-17T23:00:00.000Z	defillama-api	9.512789391408205	\N	14973	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-18T23:00:00.000Z	defillama-api	9.516053209424058	\N	14978	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-19T23:00:00.000Z	defillama-api	11.113565734888198	\N	14982	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-20T23:00:00.000Z	defillama-api	10.187991480847813	\N	18227	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-21T23:00:00.000Z	defillama-api	11.252228633651384	\N	18227	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-22T23:00:00.000Z	defillama-api	11.252228633651384	\N	18227	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-23T23:00:00.000Z	defillama-api	6.954341198905922	\N	18238	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-24T23:00:00.000Z	defillama-api	8.34772610076584	\N	128304	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-25T23:00:00.000Z	defillama-api	8.074230615306988	\N	128343	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-26T23:00:00.000Z	defillama-api	7.664672921947613	\N	128379	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-27T23:00:00.000Z	defillama-api	7.563080721695314	\N	128418	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-28T23:00:00.000Z	defillama-api	9.100720637889026	\N	125912	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-29T23:00:00.000Z	defillama-api	9.10239141020952	\N	130912	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-30T23:00:00.000Z	defillama-api	6.563351766075698	\N	131027	\N	\N
VAULT_LLAMA	solana	garhnndj3gyhmqeapkvxarv4tqfwhpcs3snf6fxstexq	2026-03-31T23:00:00.000Z	defillama-api	9.644989076207366	\N	131133	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-01T23:00:00.000Z	defillama-api	6.4278175390342085	\N	194038811	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-02T23:00:00.000Z	defillama-api	6.4278175390342085	\N	205301663	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-03T23:00:00.000Z	defillama-api	6.28437130174575	\N	201542899	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-04T23:00:00.000Z	defillama-api	6.28437130174575	\N	212110138	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-05T23:00:00.000Z	defillama-api	6.0771528193726	\N	206938862	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-06T23:00:00.000Z	defillama-api	6.0771528193726	\N	197071502	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-07T23:00:00.000Z	defillama-api	6.242488554875081	\N	192993274	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-08T23:00:00.000Z	defillama-api	6.242488554875081	\N	190484099	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-09T23:00:00.000Z	defillama-api	5.878707642281711	\N	198830653	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-10T23:00:00.000Z	defillama-api	5.878707642281711	\N	197816324	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-11T23:00:00.000Z	defillama-api	5.878707642281711	\N	201119208	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-12T23:00:00.000Z	defillama-api	5.878707642281711	\N	198873315	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-13T23:00:00.000Z	defillama-api	6.062085758173907	\N	199598699	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-14T23:00:00.000Z	defillama-api	6.062085758173907	\N	197805012	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-15T23:00:00.000Z	defillama-api	5.646879930054638	\N	209456072	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-16T23:00:00.000Z	defillama-api	5.646879930054638	\N	216220412	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-17T23:00:00.000Z	defillama-api	5.646879930054638	\N	212821856	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-18T23:00:00.000Z	defillama-api	5.646879930054638	\N	200953308	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-19T23:00:00.000Z	defillama-api	5.646879930054638	\N	197888459	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-20T23:00:00.000Z	defillama-api	5.646879930054638	\N	200674490	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-21T23:00:00.000Z	defillama-api	5.646879930054638	\N	200271537	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-22T23:00:00.000Z	defillama-api	5.646879930054638	\N	192306084	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-23T23:00:00.000Z	defillama-api	5.646879930054638	\N	199661172	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-24T23:00:00.000Z	defillama-api	5.646879930054638	\N	194707531	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-25T23:00:00.000Z	defillama-api	5.646879930054638	\N	197451695	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-26T23:00:00.000Z	defillama-api	5.646879930054638	\N	186377803	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-27T23:00:00.000Z	defillama-api	5.646879930054638	\N	176494350	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-28T23:00:00.000Z	defillama-api	5.646879930054638	\N	176422971	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-29T23:00:00.000Z	defillama-api	5.646879930054638	\N	171244913	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-30T23:00:00.000Z	defillama-api	5.646879930054638	\N	174460244	\N	\N
VAULT_LLAMA	solana	5ovnbeeeqvyi1cx3ir8dx5n1p7pdxydbgf2x4txvusjm	2026-03-31T23:00:00.000Z	defillama-api	5.646879930054638	\N	174369964	\N	\N
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
