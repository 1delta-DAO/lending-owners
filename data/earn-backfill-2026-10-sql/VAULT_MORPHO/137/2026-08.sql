-- Generated from VAULT_MORPHO/137/2026-08.ndjson (73 vault rows)
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
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-01T00:00:00.000Z	morpho-api	0.7942197587595956	\N	87372.52754837443	1.0078555201255128	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-02T00:00:00.000Z	morpho-api	0.7917114995592556	\N	88028.49303422563	1.0078773814866038	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-03T00:00:00.000Z	morpho-api	0.7695706152333059	\N	87989.31699042283	1.007898631933705	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-04T00:00:00.000Z	morpho-api	0.6858317306068784	\N	87936.38785328392	1.0079175704386198	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-05T00:00:00.000Z	morpho-api	0.6682809186031591	\N	88010.46442710716	1.0079360246310765	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-06T00:00:00.000Z	morpho-api	0.649515890671637	\N	87773.92860550681	1.0079539609620798	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-07T00:00:00.000Z	morpho-api	0.6460160918209112	\N	87495.9710553801	1.007971800968904	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-08T00:00:00.000Z	morpho-api	0.6449041109135578	\N	87814.17964314211	1.007989610577779	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-09T00:00:00.000Z	morpho-api	0.6566163229138056	\N	88007.95145082848	1.0080077439503472	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-10T00:00:00.000Z	morpho-api	0.7130521549214563	\N	88161.93164247174	1.0080274362529669	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-11T00:00:00.000Z	morpho-api	0.7300161659173909	\N	87293.78453756474	1.0080475974498722	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-12T00:00:00.000Z	morpho-api	0.7343009336580053	\N	87296.44365629117	1.008067877384507	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-13T00:00:00.000Z	morpho-api	0.7408432747268989	\N	86509.8951746542	1.0080883384317052	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-14T00:00:00.000Z	morpho-api	0.7446196683247308	\N	86632.44343507115	1.0081089041842675	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-15T00:00:00.000Z	morpho-api	0.7478883880196463	\N	86579.28258599299	1.0081295606356897	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-16T00:00:00.000Z	morpho-api	0.7529077073797907	\N	86492.62953764151	1.0081503561468046	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-17T00:00:00.000Z	morpho-api	0.7584711131158883	\N	86518.68790574718	1.0081713057676156	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-18T00:00:00.000Z	morpho-api	0.7620542405106789	\N	86602.47486955502	1.0081923547870493	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-19T00:00:00.000Z	morpho-api	0.7656996892535517	\N	86598.67093136045	1.0082135049356908	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-20T00:00:00.000Z	morpho-api	0.7692155936211975	\N	87049.87618490463	1.0082347526528854	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-21T00:00:00.000Z	morpho-api	0.7789496279997365	\N	86763.23605399238	1.0082562697053798	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-22T00:00:00.000Z	morpho-api	0.6690854942092983	\N	86627.06555334096	1.0082747523219895	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-23T00:00:00.000Z	morpho-api	0.6654701557806675	\N	86420.93143154707	1.0082931354208753	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-24T00:00:00.000Z	morpho-api	0.6609739156004935	\N	86479.33607019608	1.008311394642958	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-25T00:00:00.000Z	morpho-api	0.6608891865766964	\N	86459.5520661291	1.008329651852216	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-26T00:00:00.000Z	morpho-api	0.6759674516132463	\N	86511.13262513418	1.0083483259487465	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-27T00:00:00.000Z	morpho-api	0.6820924497219494	\N	86460.97116459414	1.0083671695975323	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-28T00:00:00.000Z	morpho-api	0.6816085839744801	\N	86737.72347319403	1.0083860002308704	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-29T00:00:00.000Z	morpho-api	0.9120960370978537	\N	73853.7885593561	1.0084111990389772	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-30T00:00:00.000Z	morpho-api	1.3075628036318676	\N	73801.88200588472	1.0084473246406491	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-08-31T00:00:00.000Z	morpho-api	1.2552548856348267	\N	73723.03280637135	1.0084820062951994	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-11T00:00:00.000Z	morpho-api	\N	\N	0.19490174323512166	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-12T00:00:00.000Z	morpho-api	0	\N	0.1928813806209284	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-13T00:00:00.000Z	morpho-api	0	\N	0.19248167854829334	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-14T00:00:00.000Z	morpho-api	0	\N	0.19192161542117492	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-15T00:00:00.000Z	morpho-api	0	\N	0.19093709396890307	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-16T00:00:00.000Z	morpho-api	0	\N	0.19020673543512284	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-17T00:00:00.000Z	morpho-api	0	\N	0.19020973955305626	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-18T00:00:00.000Z	morpho-api	0	\N	0.19160430569352435	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-19T00:00:00.000Z	morpho-api	0	\N	0.19290098889821403	1	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-20T00:00:00.000Z	morpho-api	0.0006624269133226335	\N	193469.02344690618	1.0000000181399336	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-21T00:00:00.000Z	morpho-api	0.010177286213775005	\N	192400.99818977443	1.0000002969683455	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-22T00:00:00.000Z	morpho-api	0.01155885946957369	\N	194040.39090605368	1.0000006136440962	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-23T00:00:00.000Z	morpho-api	0.011559559709439782	\N	194167.38696136643	1.0000009303535549	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-24T00:00:00.000Z	morpho-api	0.011560960189171965	\N	193732.70771283598	1.000001247096725	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-25T00:00:00.000Z	morpho-api	0.011562360668904148	\N	193109.9387377339	1.0000015638736104	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-26T00:00:00.000Z	morpho-api	0.011563761148636331	\N	193566.38575630647	1.0000018806842144	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-27T00:00:00.000Z	morpho-api	0.011564461388502423	\N	193413.28971497604	1.0000021975285391	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-28T00:00:00.000Z	morpho-api	0.011565861868234606	\N	192981.2923966763	1.0000025144065914	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-29T00:00:00.000Z	morpho-api	0.011567262347966789	\N	191820.63930578507	1.0000028313183729	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-30T00:00:00.000Z	morpho-api	0.011568662827698972	\N	191571.89749989836	1.0000031482638876	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-08-31T00:00:00.000Z	morpho-api	0.011569363067565064	\N	191262.14011615832	1.0000034652431362	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-11T00:00:00.000Z	morpho-api	\N	\N	0.9998897680902552	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-12T00:00:00.000Z	morpho-api	0	\N	0.9990987064051591	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-13T00:00:00.000Z	morpho-api	0	\N	0.9993202832963256	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-14T00:00:00.000Z	morpho-api	0	\N	0.999863877889276	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-15T00:00:00.000Z	morpho-api	0	\N	1.0007680937265635	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-16T00:00:00.000Z	morpho-api	0	\N	0.9997573317695846	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-17T00:00:00.000Z	morpho-api	0	\N	0.9998884913939786	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-18T00:00:00.000Z	morpho-api	0	\N	0.9995869000980104	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-19T00:00:00.000Z	morpho-api	0	\N	1.0000203502620866	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-20T00:00:00.000Z	morpho-api	0	\N	1.0002880762640998	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-21T00:00:00.000Z	morpho-api	0	\N	1.0000496807747117	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-22T00:00:00.000Z	morpho-api	0	\N	0.9997538523618229	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-23T00:00:00.000Z	morpho-api	0	\N	0.9999796838753738	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-24T00:00:00.000Z	morpho-api	0	\N	1.0000294014470201	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-25T00:00:00.000Z	morpho-api	0	\N	0.999802838516583	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-26T00:00:00.000Z	morpho-api	0	\N	0.9995915424166164	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-27T00:00:00.000Z	morpho-api	0	\N	0.9999069783348152	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-28T00:00:00.000Z	morpho-api	0	\N	0.9999405206653547	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-29T00:00:00.000Z	morpho-api	0	\N	1.0000108550532625	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-30T00:00:00.000Z	morpho-api	0	\N	0.9999759050563947	1	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-08-31T00:00:00.000Z	morpho-api	0	\N	0.9995302509411799	1	assets_per_share
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
