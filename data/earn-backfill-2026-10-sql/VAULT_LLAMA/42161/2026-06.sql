-- Generated from VAULT_LLAMA/42161/2026-06.ndjson (60 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-01T23:00:00.000Z	defillama-api	4.046676382785108	\N	13736	1.06806	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-02T23:00:00.000Z	defillama-api	4.016603881495939	\N	13737	1.06815	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-03T23:00:00.000Z	defillama-api	4.0907368756393225	\N	13740	1.06835	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-04T23:00:00.000Z	defillama-api	3.998051726483709	\N	13740	1.0684	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-05T23:00:00.000Z	defillama-api	4.235550681386258	\N	13745	1.06873	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-06T23:00:00.000Z	defillama-api	4.251546960887254	\N	13746	1.06886	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-07T23:00:00.000Z	defillama-api	4.214949624525843	\N	13747	1.06894	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-08T23:00:00.000Z	defillama-api	4.215591744483049	\N	13749	1.06906	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-09T23:00:00.000Z	defillama-api	4.152699700910034	\N	13750	1.06913	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-10T23:00:00.000Z	defillama-api	4.185109602872217	\N	13755	1.06927	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-11T23:00:00.000Z	defillama-api	4.2360394488127895	\N	13757	1.06945	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-12T23:00:00.000Z	defillama-api	4.284864373715891	\N	13757	1.0696	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-13T23:00:00.000Z	defillama-api	4.364160236391967	\N	13759	1.0698	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-14T23:00:00.000Z	defillama-api	4.550458352525766	\N	13763	1.07006	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-15T23:00:00.000Z	defillama-api	4.470296293135334	\N	13763	1.07012	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-16T23:00:00.000Z	defillama-api	4.417438686843411	\N	13764	1.07018	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-17T23:00:00.000Z	defillama-api	4.491122126992764	\N	13767	1.07038	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-18T23:00:00.000Z	defillama-api	4.470946815970933	\N	13768	1.07049	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-19T23:00:00.000Z	defillama-api	4.519456632934293	\N	13771	1.07068	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-20T23:00:00.000Z	defillama-api	4.478510807004454	\N	3755	1.07079	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-21T23:00:00.000Z	defillama-api	4.503120036858377	\N	3735	1.07092	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-22T23:00:00.000Z	defillama-api	4.517822273086836	\N	3760	1.07107	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-23T23:00:00.000Z	defillama-api	4.4507098838408865	\N	4260	1.07116	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-24T23:00:00.000Z	defillama-api	4.4501742003433264	\N	4262	1.07129	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-25T23:00:00.000Z	defillama-api	4.398310234421388	\N	4262	1.07139	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-26T23:00:00.000Z	defillama-api	4.51361663245109	\N	4263	1.07156	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-27T23:00:00.000Z	defillama-api	4.569824886502261	\N	4263	1.07171	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-28T23:00:00.000Z	defillama-api	4.652360058798877	\N	4264	1.07183	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-29T23:00:00.000Z	defillama-api	4.592673713332829	\N	4269	1.072	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-06-30T23:00:00.000Z	defillama-api	4.6882347476184805	\N	4268	1.07212	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-01T23:00:00.000Z	defillama-api	4.364744236440288	\N	568509	1.05067	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-02T23:00:00.000Z	defillama-api	4.047300296505796	\N	571969	1.05078	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-03T23:00:00.000Z	defillama-api	3.934388018578261	\N	574716	1.05091	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-04T23:00:00.000Z	defillama-api	3.833945612186085	\N	573539	1.05102	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-05T23:00:00.000Z	defillama-api	3.720214053615223	\N	571141	1.0511	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-06T23:00:00.000Z	defillama-api	3.624108932953618	\N	568526	1.05123	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-07T23:00:00.000Z	defillama-api	3.5868659754356713	\N	566744	1.05135	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-08T23:00:00.000Z	defillama-api	3.5711294849249953	\N	567382	1.05147	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-09T23:00:00.000Z	defillama-api	3.5988092665917293	\N	568111	1.05159	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-10T23:00:00.000Z	defillama-api	3.721514399046555	\N	556222	1.05167	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-11T23:00:00.000Z	defillama-api	3.72663035150822	\N	538837	1.05179	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-12T23:00:00.000Z	defillama-api	3.783234941323599	\N	538165	1.0519	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-13T23:00:00.000Z	defillama-api	4.712296389897119	\N	538636	1.05204	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-14T23:00:00.000Z	defillama-api	5.0297886463823716	\N	537936	1.05218	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-15T23:00:00.000Z	defillama-api	4.976949246326967	\N	539136	1.05227	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-16T23:00:00.000Z	defillama-api	5.095172843638807	\N	541918	1.05244	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-17T23:00:00.000Z	defillama-api	4.028034597070018	\N	542096	1.05259	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-18T23:00:00.000Z	defillama-api	4.481924476351651	\N	541551	1.05271	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-19T23:00:00.000Z	defillama-api	4.3455576641093785	\N	537646	1.05286	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-20T23:00:00.000Z	defillama-api	4.277688315568184	\N	538169	1.05298	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-21T23:00:00.000Z	defillama-api	4.417888240837442	\N	540052	1.05312	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-22T23:00:00.000Z	defillama-api	4.4158505428271155	\N	540138	1.05323	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-23T23:00:00.000Z	defillama-api	4.10296516442088	\N	538363	1.05335	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-24T23:00:00.000Z	defillama-api	4.134662222199381	\N	537376	1.05347	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-25T23:00:00.000Z	defillama-api	4.139248793322281	\N	554601	1.05354	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-26T23:00:00.000Z	defillama-api	4.079812433488428	\N	556021	1.05368	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-27T23:00:00.000Z	defillama-api	4.08996871250622	\N	553022	1.05384	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-28T23:00:00.000Z	defillama-api	4.253904668516384	\N	555070	1.05397	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-29T23:00:00.000Z	defillama-api	4.013587248152817	\N	552136	1.05409	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-06-30T23:00:00.000Z	defillama-api	3.9669267646758044	\N	551374	1.05412	assets_per_share
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
