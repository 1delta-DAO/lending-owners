-- Generated from VAULT_LLAMA_LST/1/2025-12.ndjson (62 vault rows)
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
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-01T23:00:00.000Z	defillama-api	2.8167834848602524	\N	962397701	1.09565	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-02T23:00:00.000Z	defillama-api	2.2599884555773997	\N	1026956333	1.09577	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-03T23:00:00.000Z	defillama-api	2.2602237361724065	\N	1085824426	1.09577	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-04T23:00:00.000Z	defillama-api	2.8173961947430826	\N	1071356363	1.09589	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-05T23:00:00.000Z	defillama-api	2.8179991012677874	\N	1031490856	1.09601	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-06T23:00:00.000Z	defillama-api	2.2607125035989384	\N	1035346030	1.09613	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-07T23:00:00.000Z	defillama-api	2.8179991012677874	\N	1032199423	1.09613	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-08T23:00:00.000Z	defillama-api	2.8186111109107514	\N	1065288178	1.09625	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-09T23:00:00.000Z	defillama-api	2.818310007768332	\N	1134389819	1.09637	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-10T23:00:00.000Z	defillama-api	2.818912914293037	\N	1139185290	1.09637	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-11T23:00:00.000Z	defillama-api	2.8192238207935816	\N	1102237062	1.09649	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-12T23:00:00.000Z	defillama-api	2.2616998418101275	\N	1051588421	1.09661	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-13T23:00:00.000Z	defillama-api	2.8192238207935816	\N	1059823256	1.09661	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-14T23:00:00.000Z	defillama-api	2.8198267273182864	\N	1043910794	1.09673	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-15T23:00:00.000Z	defillama-api	2.2621886092366594	\N	1003988924	1.09685	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-16T23:00:00.000Z	defillama-api	2.8198267273182864	\N	1005251147	1.09685	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-17T23:00:00.000Z	defillama-api	2.2624329929499254	\N	965208425	1.09697	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-18T23:00:00.000Z	defillama-api	2.2626773766631914	\N	963352435	1.09697	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-19T23:00:00.000Z	defillama-api	2.8204387369612505	\N	1017046559	1.09709	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-20T23:00:00.000Z	defillama-api	2.2629217603764573	\N	929144517	1.09721	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-21T23:00:00.000Z	defillama-api	2.8213525499865	\N	934022090	1.09721	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-22T23:00:00.000Z	defillama-api	3.376199511961886	\N	908129915	1.09745	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-23T23:00:00.000Z	defillama-api	2.8216543533687855	\N	861854930	1.09757	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-24T23:00:00.000Z	defillama-api	3.376567137891584	\N	862136393	1.09757	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-25T23:00:00.000Z	defillama-api	3.377291886152989	\N	850731533	1.09769	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-26T23:00:00.000Z	defillama-api	2.8222670632516156	\N	853301673	1.09782	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-27T23:00:00.000Z	defillama-api	4.479141723123803	\N	855270228	1.09782	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-28T23:00:00.000Z	defillama-api	4.481054078198099	\N	860705230	1.09818	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-29T23:00:00.000Z	defillama-api	4.481063881556224	\N	850034411	1.09842	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-30T23:00:00.000Z	defillama-api	5.027335005891587	\N	858185292	1.09854	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2025-12-31T23:00:00.000Z	defillama-api	4.481542145384765	\N	857033703	1.09866	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-01T23:00:00.000Z	defillama-api	3.004092047120821	\N	31261895	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-02T23:00:00.000Z	defillama-api	2.981809014102055	\N	33619714	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-03T23:00:00.000Z	defillama-api	3.651734796150663	\N	35484613	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-04T23:00:00.000Z	defillama-api	3.440606174365257	\N	34936411	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-05T23:00:00.000Z	defillama-api	3.636770670212286	\N	33650019	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-06T23:00:00.000Z	defillama-api	3.68046213665707	\N	33744304	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-07T23:00:00.000Z	defillama-api	3.0060324117897608	\N	33733795	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-08T23:00:00.000Z	defillama-api	3.0099236447256317	\N	34589227	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-09T23:00:00.000Z	defillama-api	2.996668104060518	\N	37107114	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-10T23:00:00.000Z	defillama-api	2.74770272135072	\N	37297684	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-11T23:00:00.000Z	defillama-api	2.719426335318076	\N	36052650	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-12T23:00:00.000Z	defillama-api	3.4305479289287177	\N	34409066	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-13T23:00:00.000Z	defillama-api	3.4317558426977257	\N	34675029	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-14T23:00:00.000Z	defillama-api	3.4305864421213528	\N	34168957	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-15T23:00:00.000Z	defillama-api	3.343428986468666	\N	32698452	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-16T23:00:00.000Z	defillama-api	2.8485701733416136	\N	32693819	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-17T23:00:00.000Z	defillama-api	2.6542024929909758	\N	31540731	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-18T23:00:00.000Z	defillama-api	2.618388725039722	\N	31556722	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-19T23:00:00.000Z	defillama-api	2.771078828800455	\N	33319522	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-20T23:00:00.000Z	defillama-api	3.347955336963082	\N	33226090	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-21T23:00:00.000Z	defillama-api	3.454315470463598	\N	33400248	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-22T23:00:00.000Z	defillama-api	3.4548854657145966	\N	33518485	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-23T23:00:00.000Z	defillama-api	3.4541803241694424	\N	33051472	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-24T23:00:00.000Z	defillama-api	2.842709165662427	\N	33017553	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-25T23:00:00.000Z	defillama-api	2.841523659569134	\N	32602245	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-26T23:00:00.000Z	defillama-api	2.841523659569134	\N	32688795	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-27T23:00:00.000Z	defillama-api	2.766720535873901	\N	32794712	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-28T23:00:00.000Z	defillama-api	2.7602713267071977	\N	33009379	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-29T23:00:00.000Z	defillama-api	3.402387082473979	\N	32984716	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-30T23:00:00.000Z	defillama-api	3.402725298329301	\N	33438871	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2025-12-31T23:00:00.000Z	defillama-api	3.399544808857513	\N	33442405	\N	\N
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
