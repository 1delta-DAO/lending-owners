-- Generated from VAULT_LLAMA/8453/2026-02.ndjson (69 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-11T23:00:00.000Z	defillama-api	31.782298677640597	\N	1777401	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-13T23:00:00.000Z	defillama-api	107.16216443498183	\N	407505	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-18T23:00:00.000Z	defillama-api	52.64058235070479	\N	459124	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-19T23:00:00.000Z	defillama-api	52.64058235070479	\N	444298	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-20T23:00:00.000Z	defillama-api	37.33171922313261	\N	430102	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-21T23:00:00.000Z	defillama-api	37.33171922313261	\N	505094	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-22T23:00:00.000Z	defillama-api	37.33171922313261	\N	581725	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-23T23:00:00.000Z	defillama-api	62.27617420790921	\N	547573	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-24T23:00:00.000Z	defillama-api	62.27617420790921	\N	642397	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-25T23:00:00.000Z	defillama-api	24.944501900847627	\N	693142	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-26T23:00:00.000Z	defillama-api	24.944501900847627	\N	549149	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-27T23:00:00.000Z	defillama-api	24.944501900847627	\N	524611	\N	\N
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-02-28T23:00:00.000Z	defillama-api	24.944501900847627	\N	496756	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-09T23:00:00.000Z	defillama-api	23.77223664318251	\N	4383	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-10T23:00:00.000Z	defillama-api	43.31555037531132	\N	2243	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-15T23:00:00.000Z	defillama-api	20.0533047287621	\N	3931	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-17T23:00:00.000Z	defillama-api	11.008414215396556	\N	4823	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-19T23:00:00.000Z	defillama-api	1.243535671235918	\N	4755	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-20T23:00:00.000Z	defillama-api	1.8399684783787507	\N	4841	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-21T23:00:00.000Z	defillama-api	3.899857090061687	\N	4849	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-23T23:00:00.000Z	defillama-api	1.2514364776450293	\N	4609	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-25T23:00:00.000Z	defillama-api	0.06357967912151707	\N	38794	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-02-27T23:00:00.000Z	defillama-api	0.5287994394365114	\N	37293	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-05T23:00:00.000Z	defillama-api	2.007416137317364	\N	381	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-06T23:00:00.000Z	defillama-api	2.5913328570936756	\N	20649	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-08T23:00:00.000Z	defillama-api	3.3943350242537917	\N	104688	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-09T23:00:00.000Z	defillama-api	3.175057010906812	\N	104961	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-10T23:00:00.000Z	defillama-api	2.5909435237281286	\N	169912	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-11T23:00:00.000Z	defillama-api	2.8826494471445585	\N	140698	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-12T23:00:00.000Z	defillama-api	2.918979992116988	\N	161377	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-13T23:00:00.000Z	defillama-api	3.101114482007006	\N	168889	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-14T23:00:00.000Z	defillama-api	2.5901634565173026	\N	170858	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-15T23:00:00.000Z	defillama-api	2.4440871182918045	\N	176908	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-16T23:00:00.000Z	defillama-api	2.5533231369223586	\N	158523	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-17T23:00:00.000Z	defillama-api	2.4801872843482897	\N	176262	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-18T23:00:00.000Z	defillama-api	3.537583093660146	\N	210382	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-19T23:00:00.000Z	defillama-api	3.1732167805387235	\N	213131	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-20T23:00:00.000Z	defillama-api	3.193849348193112	\N	212512	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-21T23:00:00.000Z	defillama-api	1.8444843252751753	\N	200854	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-22T23:00:00.000Z	defillama-api	2.203836220715516	\N	201073	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-23T23:00:00.000Z	defillama-api	2.5161768125059325	\N	203966	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-24T23:00:00.000Z	defillama-api	2.8127683094680833	\N	204257	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-25T23:00:00.000Z	defillama-api	2.567846811984964	\N	207537	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-26T23:00:00.000Z	defillama-api	2.0727688237798247	\N	206646	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-27T23:00:00.000Z	defillama-api	2.275610806989903	\N	207927	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-02-28T23:00:00.000Z	defillama-api	3.983782938732361	\N	223706	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-06T23:00:00.000Z	defillama-api	0.19490966600699267	\N	102829	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-07T23:00:00.000Z	defillama-api	1.037697361638834	\N	108016	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-08T23:00:00.000Z	defillama-api	2.3019020130021772	\N	571189	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-09T23:00:00.000Z	defillama-api	2.4984278326201093	\N	575597	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-10T23:00:00.000Z	defillama-api	2.267399094080247	\N	552843	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-11T23:00:00.000Z	defillama-api	1.8792316279103716	\N	539774	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-12T23:00:00.000Z	defillama-api	2.505645204919915	\N	536529	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-13T23:00:00.000Z	defillama-api	2.21146603429645	\N	250294	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-14T23:00:00.000Z	defillama-api	2.1541310943007375	\N	255999	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-15T23:00:00.000Z	defillama-api	2.4766755814198405	\N	255490	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-16T23:00:00.000Z	defillama-api	2.3097194908672236	\N	243232	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-17T23:00:00.000Z	defillama-api	1.9309366393827077	\N	248110	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-18T23:00:00.000Z	defillama-api	2.040930317548373	\N	243580	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-19T23:00:00.000Z	defillama-api	2.188085725407518	\N	244921	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-20T23:00:00.000Z	defillama-api	2.1487483504500915	\N	248369	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-21T23:00:00.000Z	defillama-api	2.123786899943525	\N	250445	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-22T23:00:00.000Z	defillama-api	2.05699802151571	\N	248422	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-23T23:00:00.000Z	defillama-api	2.01751079522694	\N	236785	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-24T23:00:00.000Z	defillama-api	2.03456163596627	\N	234930	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-25T23:00:00.000Z	defillama-api	2.063953504105598	\N	262714	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-26T23:00:00.000Z	defillama-api	2.0663042093360673	\N	256776	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-27T23:00:00.000Z	defillama-api	2.0784498698134257	\N	242419	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-02-28T23:00:00.000Z	defillama-api	2.0708102528743666	\N	248633	\N	\N
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
