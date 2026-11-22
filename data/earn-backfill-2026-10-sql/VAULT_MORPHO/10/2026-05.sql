-- Generated from VAULT_MORPHO/10/2026-05.ndjson (62 vault rows)
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
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-01T00:00:00.000Z	morpho-api	1039.0968883445594	\N	53420.77379858491	1.004242716715746	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-02T00:00:00.000Z	morpho-api	4.936955746615013	\N	72479.87234483047	1.004321901700425	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-03T00:00:00.000Z	morpho-api	5.419320179811393	\N	72503.36298777159	1.004409096321236	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-04T00:00:00.000Z	morpho-api	4.79896577836314	\N	72508.77634955598	1.004481899613208	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-05T00:00:00.000Z	morpho-api	4.493883172784763	\N	72525.32662136419	1.004544252445252	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-06T00:00:00.000Z	morpho-api	2.306051634448636	\N	72530.73312898651	1.004607721043064	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-07T00:00:00.000Z	morpho-api	3.260413449623911	\N	70975.57287377641	1.004670228104045	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-08T00:00:00.000Z	morpho-api	5.308796420067097	\N	81474.93070220125	1.004773370265221	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-09T00:00:00.000Z	morpho-api	5.25158402204795	\N	81505.41385447494	1.004868591119674	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-10T00:00:00.000Z	morpho-api	5.229300288789318	\N	81516.2958955592	1.004964386531491	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-11T00:00:00.000Z	morpho-api	5.403913502277646	\N	81526.7794192478	1.00506405136764	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-12T00:00:00.000Z	morpho-api	5.371174487578401	\N	81530.78098471735	1.005164451677957	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-13T00:00:00.000Z	morpho-api	4.525849122671843	\N	81537.58977772814	1.00524404459275	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-14T00:00:00.000Z	morpho-api	4.049536862638092	\N	81512.60738786703	1.005314308545816	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-15T00:00:00.000Z	morpho-api	4.729399748626406	\N	81562.49574916992	1.005392982722886	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-16T00:00:00.000Z	morpho-api	4.05760852757453	\N	87469.3569171198	1.005454620092989	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-17T00:00:00.000Z	morpho-api	4.154910358167285	\N	86975.21571336349	1.005517846194419	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-18T00:00:00.000Z	morpho-api	4.157648296043703	\N	95616.77456148494	1.005582802733698	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-19T00:00:00.000Z	morpho-api	4.057124661827061	\N	95607.90725942313	1.005646437695477	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-20T00:00:00.000Z	morpho-api	4.79795533223637	\N	95616.22045679638	1.00572776857593	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-21T00:00:00.000Z	morpho-api	3.835703914489841	\N	95602.42634852436	1.005833463818782	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-22T00:00:00.000Z	morpho-api	3.6636612815499348	\N	95624.56827097519	1.005934428699607	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-23T00:00:00.000Z	morpho-api	1.9366856086833195	\N	95051.41155428029	1.005987804883677	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-24T00:00:00.000Z	morpho-api	2.479164934143796	\N	44960.318694547386	1.006056136227484	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-25T00:00:00.000Z	morpho-api	5.924943080160006	\N	44966.704572047995	1.006219459759012	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-26T00:00:00.000Z	morpho-api	3.635127207246569	\N	49976.60606367036	1.006319676692531	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-27T00:00:00.000Z	morpho-api	5.456992384367254	\N	49980.01248927689	1.006470139418777	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-28T00:00:00.000Z	morpho-api	3.0587142578752946	\N	44986.439344198756	1.006554485543127	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-29T00:00:00.000Z	morpho-api	4.821316734648917	\N	45387.3616590311	1.006641988369005	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-30T00:00:00.000Z	morpho-api	4.207943024425731	\N	45393.57136846253	1.006708955795498	assets_per_share
VAULT_MORPHO	10	0x4ffc4e5f1f1f5c43dc9bc27b53728da13b02be35	2026-05-31T00:00:00.000Z	morpho-api	4.452877826466306	\N	45390.99882791853	1.006775134283006	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-01T00:00:00.000Z	morpho-api	1.3246759657192797	\N	140761.93922092282	1.0002353216894877	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-02T00:00:00.000Z	morpho-api	1.3244848002358367	\N	143080.08967979203	1.0002716181502058	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-03T00:00:00.000Z	morpho-api	1.3243083397895816	\N	144357.85640349067	1.0003079110929998	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-04T00:00:00.000Z	morpho-api	1.32412767790413	\N	144789.3361145241	1.0003442004004643	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-05T00:00:00.000Z	morpho-api	1.3239470160186784	\N	146745.103206472	1.000380486072769	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-06T00:00:00.000Z	morpho-api	1.3237663541332267	\N	147362.1736735012	1.000416768110433	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-07T00:00:00.000Z	morpho-api	1.3235863924876412	\N	146894.08676011622	1.0004530465131012	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-08T00:00:00.000Z	morpho-api	1.3234057306021896	\N	142791.83019257773	1.0004893212812238	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-09T00:00:00.000Z	morpho-api	1.323225068716738	\N	143752.54317397208	1.0005255924150058	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-10T00:00:00.000Z	morpho-api	1.3230444068312863	\N	144634.68326723267	1.0005618599146526	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-11T00:00:00.000Z	morpho-api	1.3228609439863703	\N	147922.6099378615	1.000598123696642	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-12T00:00:00.000Z	morpho-api	1.322682382820517	\N	145817.01643402406	1.0006343839024072	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-13T00:00:00.000Z	morpho-api	1.3225094235735924	\N	141835.77865309903	1.0006706406777393	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-14T00:00:00.000Z	morpho-api	1.3223364643266677	\N	140785.88950081856	1.0007068940226616	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-15T00:00:00.000Z	morpho-api	1.3221635050797431	\N	142356.40767514682	1.000743143937817	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-16T00:00:00.000Z	morpho-api	1.3219905458328185	\N	138761.40711742168	1.0007793904228897	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-17T00:00:00.000Z	morpho-api	1.3218175865858939	\N	135877.80461755345	1.0008156334783531	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-18T00:00:00.000Z	morpho-api	1.3216446273389693	\N	132969.87355798078	1.0008518731039222	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-19T00:00:00.000Z	morpho-api	1.3214534618555263	\N	132639.8440658721	1.0008881087997474	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-20T00:00:00.000Z	morpho-api	1.3212826033282	\N	131244.75270924147	1.0009243411268334	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-21T00:00:00.000Z	morpho-api	1.321114545760338	\N	132655.26927731466	1.0009605701580742	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-22T00:00:00.000Z	morpho-api	1.320946488192476	\N	132701.80235376765	1.000996795893784	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-23T00:00:00.000Z	morpho-api	1.5160403172842507	\N	128275.90818427032	1.0010383735055564	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-24T00:00:00.000Z	morpho-api	1.902555917610016	\N	132168.5970043961	1.0010905538163162	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-25T00:00:00.000Z	morpho-api	1.9387107023760564	\N	131211.0906290089	1.0011437285087987	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-26T00:00:00.000Z	morpho-api	1.976962005301175	\N	131084.2277994159	1.0011979552607442	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-27T00:00:00.000Z	morpho-api	2.0151117734457102	\N	128711.77376446669	1.001253231467875	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-28T00:00:00.000Z	morpho-api	2.054046510480134	\N	125763.95112191248	1.001309578834031	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-29T00:00:00.000Z	morpho-api	2.093766916644313	\N	124724.62794873337	1.0013670190728727	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-30T00:00:00.000Z	morpho-api	2.134271591458514	\N	125323.2888338376	1.0014255739099083	assets_per_share
VAULT_MORPHO	10	0x3d63934715b6d4c4dfbbc1a00fe2a2145079dd76	2026-05-31T00:00:00.000Z	morpho-api	2.175561235162604	\N	126167.8561940961	1.0014852650788257	assets_per_share
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
