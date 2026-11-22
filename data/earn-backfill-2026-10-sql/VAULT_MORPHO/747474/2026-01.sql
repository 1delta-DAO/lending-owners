-- Generated from VAULT_MORPHO/747474/2026-01.ndjson (62 vault rows)
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
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-01T00:00:00.000Z	morpho-api	5.504265577727097	\N	6.008828001285499	0.999919354138179	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-02T00:00:00.000Z	morpho-api	5.668480929443831	\N	6.001503767408605	0.999909858269018	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-03T00:00:00.000Z	morpho-api	5.65189784893505	\N	5.999486284453868	0.999899862617269	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-04T00:00:00.000Z	morpho-api	-0.35879835582619535	\N	6.0020522998079215	0.999890033559716	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-05T00:00:00.000Z	morpho-api	-0.3709646733796035	\N	6.0138598898329505	0.999879871313771	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-06T00:00:00.000Z	morpho-api	5.595220434173598	\N	5.9995325448561445	0.999868709502652	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-07T00:00:00.000Z	morpho-api	-0.39529870896615193	\N	6.004896284519188	0.999857880879924	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-08T00:00:00.000Z	morpho-api	5.577421037017416	\N	6.008142481638619	0.999846885663	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-09T00:00:00.000Z	morpho-api	5.567108604509485	\N	6.001927724588249	0.999835890446077	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-10T00:00:00.000Z	morpho-api	5.592410371590972	\N	6.007208997935902	0.999825561605936	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-11T00:00:00.000Z	morpho-api	5.587382649352435	\N	5.998221895645592	0.999814899577404	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-12T00:00:00.000Z	morpho-api	-0.37099268297424715	\N	6.00108687538714	0.99980473733146	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-13T00:00:00.000Z	morpho-api	-0.48596961814695305	\N	10.991904708441277	0.99979142578515	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-14T00:00:00.000Z	morpho-api	5.539634693363382	\N	10.995948077764217	0.999778523543613	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-15T00:00:00.000Z	morpho-api	5.517881741923247	\N	10.991693765301601	0.999765439580363	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-16T00:00:00.000Z	morpho-api	5.21125650791987	\N	10.99960874031718	0.999752537338825	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-17T00:00:00.000Z	morpho-api	5.158164321272807	\N	11.002437326483406	0.999739180793007	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-18T00:00:00.000Z	morpho-api	5.119074831227977	\N	11.009792617029328	0.999725642525478	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-19T00:00:00.000Z	morpho-api	5.1385646074209035	\N	10.98994947966204	0.999711740814525	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-20T00:00:00.000Z	morpho-api	5.1358651827371204	\N	11.015609020056887	0.999697657381861	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-21T00:00:00.000Z	morpho-api	4.863238694952088	\N	10.998593836188707	0.999681211566942	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-22T00:00:00.000Z	morpho-api	4.665364213352063	\N	10.980518502320415	0.999662312508915	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-23T00:00:00.000Z	morpho-api	4.598041051906421	\N	10.975711700267942	0.999644231198591	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-24T00:00:00.000Z	morpho-api	4.514692200885406	\N	11.006783440032759	0.999627149357681	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-25T00:00:00.000Z	morpho-api	4.504298540553009	\N	11.031898351154327	0.99960988579506	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-26T00:00:00.000Z	morpho-api	4.443364367645586	\N	11.007534413014316	0.999592167928159	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-27T00:00:00.000Z	morpho-api	4.400280709404569	\N	11.016023557484878	0.999574177478691	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-28T00:00:00.000Z	morpho-api	4.44764563418687	\N	11.00412956042756	0.99955691391607	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-29T00:00:00.000Z	morpho-api	-0.5905893054602984	\N	11.02748698518563	0.999540740683719	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-30T00:00:00.000Z	morpho-api	-0.574009025910982	\N	11.014519722813175	0.999525021755649	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-01-31T00:00:00.000Z	morpho-api	-0.5707000424237663	\N	10.977762466277046	0.999509393688434	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-01T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-02T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-03T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-04T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-05T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-06T00:00:00.000Z	morpho-api	5.9789861925452215	\N	0.0999420881237417	1	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-07T00:00:00.000Z	morpho-api	1.2553221086619715	\N	1300730.464692513	1.000034392974126	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-08T00:00:00.000Z	morpho-api	7.60075922840997	\N	1301474.5364198254	1.000082152746494	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-09T00:00:00.000Z	morpho-api	7.361429846497458	\N	1300215.0518366175	1.000123279445994	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-10T00:00:00.000Z	morpho-api	7.346755619863643	\N	1301335.1428222198	1.000163916090892	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-11T00:00:00.000Z	morpho-api	7.426182427394679	\N	1299421.953278732	1.000206664611987	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-12T00:00:00.000Z	morpho-api	7.735706654443675	\N	1300086.9367639893	1.000257931273474	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-13T00:00:00.000Z	morpho-api	7.923975945800521	\N	1299307.5169061853	1.000314076779724	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-14T00:00:00.000Z	morpho-api	7.902322428421371	\N	1299839.117126357	1.00036982076666	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-15T00:00:00.000Z	morpho-api	7.784617008610439	\N	1539124.8132000763	1.000422598421879	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-16T00:00:00.000Z	morpho-api	6.785868388803351	\N	1720190.9916078197	1.000455334790583	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-17T00:00:00.000Z	morpho-api	6.574087143462748	\N	1720656.6919681255	1.000483002207895	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-18T00:00:00.000Z	morpho-api	6.505497248099346	\N	1721829.0042658593	1.000509621512474	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-19T00:00:00.000Z	morpho-api	6.509268740018115	\N	1718746.7946893203	1.000535435106501	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-20T00:00:00.000Z	morpho-api	6.477723634290555	\N	1722779.6006951781	1.000560234181789	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-21T00:00:00.000Z	morpho-api	6.23922613733896	\N	1720139.7539616255	1.00058358637132	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-22T00:00:00.000Z	morpho-api	6.129133725352176	\N	1717338.4667064655	1.000606974606406	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-23T00:00:00.000Z	morpho-api	5.985219727833169	\N	2235224.199224681	1.000628932462494	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-24T00:00:00.000Z	morpho-api	5.785705984706624	\N	2841664.3438838953	1.000648498147902	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-25T00:00:00.000Z	morpho-api	5.744800772689018	\N	2848172.0320850955	1.000666999015807	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-26T00:00:00.000Z	morpho-api	5.61776045522322	\N	2841900.2727645286	1.000683125294202	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-27T00:00:00.000Z	morpho-api	5.556530781092306	\N	2844108.644317407	1.000698444636017	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-28T00:00:00.000Z	morpho-api	5.944308913896634	\N	2841082.3105794	1.000724284986352	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-29T00:00:00.000Z	morpho-api	2.9341079741840304	\N	2847309.7368879006	1.000804688194661	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-30T00:00:00.000Z	morpho-api	1.6458129707075386	\N	2844056.3307056376	1.000849764144437	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-01-31T00:00:00.000Z	morpho-api	1.8362845164432429	\N	2834674.489932566	1.000900067166382	assets_per_share
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
