-- Generated from VAULT_LLAMA_LST/1/2026-10.ndjson (78 vault rows)
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
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-01T23:00:00.000Z	defillama-api	\N	\N	37120779	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-02T23:00:00.000Z	defillama-api	\N	\N	36573465	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-03T22:00:00.000Z	defillama-api	\N	\N	36962969	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-04T23:00:00.000Z	defillama-api	\N	\N	36759142	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-05T23:00:00.000Z	defillama-api	\N	\N	36592450	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-06T23:00:00.000Z	defillama-api	\N	\N	36222236	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-07T23:00:00.000Z	defillama-api	\N	\N	34501092	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-08T23:00:00.000Z	defillama-api	\N	\N	33076443	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-09T23:00:00.000Z	defillama-api	\N	\N	33190674	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-10T23:00:00.000Z	defillama-api	\N	\N	33348241	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-11T23:00:00.000Z	defillama-api	\N	\N	33712067	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-12T23:00:00.000Z	defillama-api	\N	\N	32924724	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-13T23:00:00.000Z	defillama-api	\N	\N	33353205	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-14T23:00:00.000Z	defillama-api	\N	\N	32047704	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-15T23:00:00.000Z	defillama-api	\N	\N	32267682	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-16T23:00:00.000Z	defillama-api	\N	\N	31431236	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-17T23:00:00.000Z	defillama-api	\N	\N	31273420	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-18T23:00:00.000Z	defillama-api	\N	\N	31029771	1.13179	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-19T23:00:00.000Z	defillama-api	\N	\N	31311408	1.13315	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-20T23:00:00.000Z	defillama-api	\N	\N	32082588	1.13323	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-21T23:00:00.000Z	defillama-api	\N	\N	32412304	1.13325	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-22T23:00:00.000Z	defillama-api	\N	\N	31134988	1.20297	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-23T23:00:00.000Z	defillama-api	\N	\N	30926113	1.20297	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-24T23:00:00.000Z	defillama-api	\N	\N	31584552	1.20297	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-25T23:00:00.000Z	defillama-api	\N	\N	30752092	1.20297	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-10-26T23:00:00.000Z	defillama-api	\N	\N	31196830	1.20297	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-01T23:00:00.000Z	defillama-api	2.306211289138105	\N	739806672	1.11857	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-02T23:00:00.000Z	defillama-api	2.8748669812728167	\N	730407315	1.11869	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-03T23:00:00.000Z	defillama-api	2.306465476209496	\N	735642188	1.11869	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-04T23:00:00.000Z	defillama-api	2.8751876911314866	\N	747335107	1.11882	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-05T23:00:00.000Z	defillama-api	2.3067294666390126	\N	743709518	1.11882	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-06T23:00:00.000Z	defillama-api	2.306983653710404	\N	738533523	1.11894	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-07T23:00:00.000Z	defillama-api	2.307237140541929	\N	703675463	1.11907	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-08T23:00:00.000Z	defillama-api	2.307237140541929	\N	676970252	1.11907	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-09T23:00:00.000Z	defillama-api	2.30749132761332	\N	681455940	1.11919	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-10T23:00:00.000Z	defillama-api	2.30749132761332	\N	686839272	1.11919	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-11T23:00:00.000Z	defillama-api	2.3077455146847115	\N	693681528	1.11932	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-12T23:00:00.000Z	defillama-api	2.3077455146847115	\N	678587726	1.11932	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-13T23:00:00.000Z	defillama-api	2.3079997017561027	\N	687729544	1.11944	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-14T23:00:00.000Z	defillama-api	2.308253888827494	\N	662316070	1.11957	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-15T23:00:00.000Z	defillama-api	2.308253888827494	\N	672489981	1.11957	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-16T23:00:00.000Z	defillama-api	2.308508075898885	\N	664000767	1.1197	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-17T23:00:00.000Z	defillama-api	2.308508075898885	\N	656302964	1.1197	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-18T23:00:00.000Z	defillama-api	2.3087713660885356	\N	656167528	1.11982	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-19T23:00:00.000Z	defillama-api	2.3087713660885356	\N	659245695	1.11982	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-20T23:00:00.000Z	defillama-api	2.309025553159927	\N	672534827	1.11995	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-21T23:00:00.000Z	defillama-api	2.309279740231318	\N	681072072	1.12007	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-22T23:00:00.000Z	defillama-api	2.309279740231318	\N	652998430	1.12007	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-23T23:00:00.000Z	defillama-api	2.3095339273027093	\N	647643293	1.1202	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-24T23:00:00.000Z	defillama-api	2.3095339273027093	\N	642188476	1.1202	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-25T23:00:00.000Z	defillama-api	2.3097881143741006	\N	642224408	1.12032	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-10-26T23:00:00.000Z	defillama-api	2.3097881143741006	\N	633592995	1.12032	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-01T23:00:00.000Z	defillama-api	2.445619243118813	\N	27662869	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-02T23:00:00.000Z	defillama-api	2.449513277014148	\N	27326250	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-03T23:00:00.000Z	defillama-api	2.449903310619561	\N	27593139	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-04T23:00:00.000Z	defillama-api	2.4431992141416004	\N	27994336	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-05T23:00:00.000Z	defillama-api	2.429662877290184	\N	27735916	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-06T23:00:00.000Z	defillama-api	2.433654944766772	\N	27472988	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-07T23:00:00.000Z	defillama-api	2.4494838669397723	\N	26341915	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-08T23:00:00.000Z	defillama-api	1.8737354452014188	\N	25350640	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-09T23:00:00.000Z	defillama-api	2.459934246701323	\N	25454834	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-10T23:00:00.000Z	defillama-api	2.4523814595056592	\N	25647528	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-11T23:00:00.000Z	defillama-api	2.45215738274851	\N	25982060	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-12T23:00:00.000Z	defillama-api	2.4548308985572476	\N	25323342	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-13T23:00:00.000Z	defillama-api	2.4496785336225457	\N	25686389	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-14T23:00:00.000Z	defillama-api	2.451415828730319	\N	24936849	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-15T23:00:00.000Z	defillama-api	2.5309105595283654	\N	25154645	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-16T23:00:00.000Z	defillama-api	2.4162714900910487	\N	24912381	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-17T23:00:00.000Z	defillama-api	2.4094581561939776	\N	24611386	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-18T23:00:00.000Z	defillama-api	2.4054261750450223	\N	24654067	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-19T23:00:00.000Z	defillama-api	2.4027806688309283	\N	24710469	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-20T23:00:00.000Z	defillama-api	2.403717589771759	\N	25369641	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-21T23:00:00.000Z	defillama-api	2.397869886650028	\N	25543129	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-22T23:00:00.000Z	defillama-api	2.3975575796697512	\N	24425451	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-23T23:00:00.000Z	defillama-api	2.870212486882906	\N	24323803	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-24T23:00:00.000Z	defillama-api	2.2729225861439772	\N	23912855	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-25T23:00:00.000Z	defillama-api	2.2681616552944206	\N	24038034	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-10-26T23:00:00.000Z	defillama-api	2.263684321590631	\N	23716251	\N	\N
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
