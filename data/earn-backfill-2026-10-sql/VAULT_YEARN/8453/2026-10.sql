-- Generated from VAULT_YEARN/8453/2026-10.ndjson (116 vault rows)
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
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x1d7a8593c249ab84b2733d09a9e4a6b9e42140fe	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	21.98525626938223	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	21.98680415259518	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	21.987138028713797	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	21.986235442636172	\N	\N
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2026-10-01T00:00:00.000Z	yearn-kong	3.2785216525610394	\N	0.03319676306173036	1.230612	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2026-10-02T00:00:00.000Z	yearn-kong	3.3291545967983893	\N	0.03319910029681363	1.230715	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2026-10-03T00:00:00.000Z	yearn-kong	3.3287869708686912	\N	0.033199604434962664	1.230851	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2026-10-04T00:00:00.000Z	yearn-kong	3.328540486435827	\N	0.03319824156996829	1.230942	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2026-10-01T00:00:00.000Z	yearn-kong	0.01316450948252168	\N	127.46709523554227	1.0012927965661742	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2026-10-02T00:00:00.000Z	yearn-kong	0.01316450948252168	\N	125.88650293539749	1.001293153659982	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2026-10-03T00:00:00.000Z	yearn-kong	0.01316450948252168	\N	126.82843599553911	1.0012935183480607	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2026-10-04T00:00:00.000Z	yearn-kong	0.01316450948252168	\N	129.09753326672154	1.001293879293697	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2026-10-01T00:00:00.000Z	yearn-kong	1.408069632091724	\N	1.080229620640189	1.0328401670561376	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2026-10-02T00:00:00.000Z	yearn-kong	1.4035362791986472	\N	1.0668347706389618	1.0328786632405238	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2026-10-03T00:00:00.000Z	yearn-kong	1.3855212081637092	\N	1.074817254199484	1.0329153312849058	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2026-10-04T00:00:00.000Z	yearn-kong	1.367689599973687	\N	1.0940468920908606	1.0329516255778117	assets_per_share
VAULT_YEARN	8453	0x25f32ec89ce7732a4e9f8f3340a09259f823b7d3	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	93.14080410964685	\N	\N
VAULT_YEARN	8453	0x25f32ec89ce7732a4e9f8f3340a09259f823b7d3	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	92.93399986048014	\N	\N
VAULT_YEARN	8453	0x25f32ec89ce7732a4e9f8f3340a09259f823b7d3	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	93.23388449345147	\N	\N
VAULT_YEARN	8453	0x25f32ec89ce7732a4e9f8f3340a09259f823b7d3	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	95.24752403450577	\N	\N
VAULT_YEARN	8453	0x7c0fa3905b38d44c0f29150fd61f182d1e097ec2	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	297.60326048637205	\N	\N
VAULT_YEARN	8453	0x7c0fa3905b38d44c0f29150fd61f182d1e097ec2	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	293.91297931103395	\N	\N
VAULT_YEARN	8453	0x7c0fa3905b38d44c0f29150fd61f182d1e097ec2	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	296.11215353195786	\N	\N
VAULT_YEARN	8453	0x7c0fa3905b38d44c0f29150fd61f182d1e097ec2	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	301.4099187710321	\N	\N
VAULT_YEARN	8453	0xd89a4f020c8d256a2a4b0dc40b36ee0b27680776	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	\N	1.0189507089478789	assets_per_share
VAULT_YEARN	8453	0xd89a4f020c8d256a2a4b0dc40b36ee0b27680776	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	\N	1.0189507089478789	assets_per_share
VAULT_YEARN	8453	0xd89a4f020c8d256a2a4b0dc40b36ee0b27680776	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	\N	1.0189507089478789	assets_per_share
VAULT_YEARN	8453	0xd89a4f020c8d256a2a4b0dc40b36ee0b27680776	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	\N	1.0189507089478789	assets_per_share
VAULT_YEARN	8453	0xc3bd0a2193c8f027b82dde3611d18589ef3f62a9	2026-10-01T00:00:00.000Z	yearn-kong	4.822304773099972	\N	767469.5123533484	1.083586	assets_per_share
VAULT_YEARN	8453	0xc3bd0a2193c8f027b82dde3611d18589ef3f62a9	2026-10-02T00:00:00.000Z	yearn-kong	5.602318765696168	\N	767796.2262472359	1.083748	assets_per_share
VAULT_YEARN	8453	0xc3bd0a2193c8f027b82dde3611d18589ef3f62a9	2026-10-03T00:00:00.000Z	yearn-kong	6.401471014072513	\N	767985.6137422429	1.083914	assets_per_share
VAULT_YEARN	8453	0xc3bd0a2193c8f027b82dde3611d18589ef3f62a9	2026-10-04T00:00:00.000Z	yearn-kong	7.19568867211251	\N	767948.4367409488	1.084079	assets_per_share
VAULT_YEARN	8453	0xbb808a822dd7aed1635956b85ca5e55478cca957	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	67.73876662519771	\N	\N
VAULT_YEARN	8453	0xbb808a822dd7aed1635956b85ca5e55478cca957	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	67.58836353489464	\N	\N
VAULT_YEARN	8453	0xbb808a822dd7aed1635956b85ca5e55478cca957	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	67.80646144978289	\N	\N
VAULT_YEARN	8453	0xbb808a822dd7aed1635956b85ca5e55478cca957	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	69.27092657054965	\N	\N
VAULT_YEARN	8453	0x989381f7efb45f97e46be9f390a69c5d94bf9e17	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	251.79917536264514	1.0143052678446685	assets_per_share
VAULT_YEARN	8453	0x989381f7efb45f97e46be9f390a69c5d94bf9e17	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	248.7723634713261	1.0143052678446685	assets_per_share
VAULT_YEARN	8453	0x989381f7efb45f97e46be9f390a69c5d94bf9e17	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	250.75289113304726	1.0143052678446685	assets_per_share
VAULT_YEARN	8453	0x989381f7efb45f97e46be9f390a69c5d94bf9e17	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	254.3446486576576	1.0143052678446685	assets_per_share
VAULT_YEARN	8453	0x945df73d55557ea23c0c35cd350d8de3b745287e	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	181.69558329111828	\N	\N
VAULT_YEARN	8453	0x945df73d55557ea23c0c35cd350d8de3b745287e	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	181.7083756615959	\N	\N
VAULT_YEARN	8453	0x945df73d55557ea23c0c35cd350d8de3b745287e	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	181.71113495697895	\N	\N
VAULT_YEARN	8453	0x945df73d55557ea23c0c35cd350d8de3b745287e	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	181.7036755986783	\N	\N
VAULT_YEARN	8453	0x03c5aff0cd5e40889d689fd9d9caff286b1bd7fb	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	50.804074968898284	\N	\N
VAULT_YEARN	8453	0x03c5aff0cd5e40889d689fd9d9caff286b1bd7fb	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	50.69127265117098	\N	\N
VAULT_YEARN	8453	0x03c5aff0cd5e40889d689fd9d9caff286b1bd7fb	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	50.85484608733717	\N	\N
VAULT_YEARN	8453	0x03c5aff0cd5e40889d689fd9d9caff286b1bd7fb	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	51.95319492791224	\N	\N
VAULT_YEARN	8453	0xdd120ded7c1c9e4978f92847bcb24847a9dbb071	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xdd120ded7c1c9e4978f92847bcb24847a9dbb071	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xdd120ded7c1c9e4978f92847bcb24847a9dbb071	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xdd120ded7c1c9e4978f92847bcb24847a9dbb071	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x44da1202285ed9678dab99b55aadb2fa549fdfdc	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x44da1202285ed9678dab99b55aadb2fa549fdfdc	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x44da1202285ed9678dab99b55aadb2fa549fdfdc	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x44da1202285ed9678dab99b55aadb2fa549fdfdc	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x7bc9e2d216b22611d9805c12e0c682391720752f	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x7bc9e2d216b22611d9805c12e0c682391720752f	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x7bc9e2d216b22611d9805c12e0c682391720752f	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x7bc9e2d216b22611d9805c12e0c682391720752f	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xa72a60e6167e8fc5e523184911475c4b37b835e2	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xa72a60e6167e8fc5e523184911475c4b37b835e2	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xa72a60e6167e8fc5e523184911475c4b37b835e2	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xa72a60e6167e8fc5e523184911475c4b37b835e2	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xb9acb02818bddd3ac178fa51a0587101e54748b0	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xb9acb02818bddd3ac178fa51a0587101e54748b0	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xb9acb02818bddd3ac178fa51a0587101e54748b0	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xb9acb02818bddd3ac178fa51a0587101e54748b0	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x8436027a799ac6c8b512e68b4d3852217c63647d	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x8436027a799ac6c8b512e68b4d3852217c63647d	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x8436027a799ac6c8b512e68b4d3852217c63647d	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0x8436027a799ac6c8b512e68b4d3852217c63647d	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xfdb431e661372fa1146efb70bf120ecded944a78	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	2014.9808239601662	\N	\N
VAULT_YEARN	8453	0xfdb431e661372fa1146efb70bf120ecded944a78	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	2015.1226897157255	\N	\N
VAULT_YEARN	8453	0xfdb431e661372fa1146efb70bf120ecded944a78	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	2015.1532899492797	\N	\N
VAULT_YEARN	8453	0xfdb431e661372fa1146efb70bf120ecded944a78	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	2015.0705666179656	\N	\N
VAULT_YEARN	8453	0x4d81c7d534d703e0a0aecadf668c0e0253e1f1c3	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1408.8894827199663	\N	\N
VAULT_YEARN	8453	0x4d81c7d534d703e0a0aecadf668c0e0253e1f1c3	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1391.4192496058658	\N	\N
VAULT_YEARN	8453	0x4d81c7d534d703e0a0aecadf668c0e0253e1f1c3	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1401.830403789677	\N	\N
VAULT_YEARN	8453	0x4d81c7d534d703e0a0aecadf668c0e0253e1f1c3	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1426.910659009505	\N	\N
VAULT_YEARN	8453	0x953370e91b70897a0cecc97b58e99d7946c841de	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	1.2628768598483568	78.775026	assets_per_share
VAULT_YEARN	8453	0x953370e91b70897a0cecc97b58e99d7946c841de	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	1.262965773339627	78.775026	assets_per_share
VAULT_YEARN	8453	0x953370e91b70897a0cecc97b58e99d7946c841de	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	1.2629849518481278	78.775026	assets_per_share
VAULT_YEARN	8453	0x953370e91b70897a0cecc97b58e99d7946c841de	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	1.2629331055081312	78.775026	assets_per_share
VAULT_YEARN	8453	0x0ace53f57a14acfd4d43c7d4c46be4b4a5347eff	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	54.8073558636659	\N	\N
VAULT_YEARN	8453	0x0ace53f57a14acfd4d43c7d4c46be4b4a5347eff	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	54.81121460358904	\N	\N
VAULT_YEARN	8453	0x0ace53f57a14acfd4d43c7d4c46be4b4a5347eff	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	54.81204692808066	\N	\N
VAULT_YEARN	8453	0x0ace53f57a14acfd4d43c7d4c46be4b4a5347eff	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	54.809796858500036	\N	\N
VAULT_YEARN	8453	0xf115c134c23c7a05fbd489a8be3116ebf54b0d9f	2026-10-01T00:00:00.000Z	yearn-kong	4.217366152303725	\N	1529238.5237491347	\N	\N
VAULT_YEARN	8453	0xf115c134c23c7a05fbd489a8be3116ebf54b0d9f	2026-10-02T00:00:00.000Z	yearn-kong	4.355289597768319	\N	1529176.5387671962	\N	\N
VAULT_YEARN	8453	0xf115c134c23c7a05fbd489a8be3116ebf54b0d9f	2026-10-03T00:00:00.000Z	yearn-kong	4.633442378576547	\N	1524094.5513921303	\N	\N
VAULT_YEARN	8453	0xf115c134c23c7a05fbd489a8be3116ebf54b0d9f	2026-10-04T00:00:00.000Z	yearn-kong	5.514657137339896	\N	1525007.7781507669	\N	\N
VAULT_YEARN	8453	0xb13cf163d916917d9cd6e836905ca5f12a1def4b	2026-10-01T00:00:00.000Z	yearn-kong	3.0159148970199112	\N	662837.9296328302	1.043535	assets_per_share
VAULT_YEARN	8453	0xb13cf163d916917d9cd6e836905ca5f12a1def4b	2026-10-02T00:00:00.000Z	yearn-kong	3.5307816638407985	\N	663191.9912458508	1.043672	assets_per_share
VAULT_YEARN	8453	0xb13cf163d916917d9cd6e836905ca5f12a1def4b	2026-10-03T00:00:00.000Z	yearn-kong	4.245648840495164	\N	657292.0262288328	1.043815	assets_per_share
VAULT_YEARN	8453	0xb13cf163d916917d9cd6e836905ca5f12a1def4b	2026-10-04T00:00:00.000Z	yearn-kong	4.9554203716439815	\N	658472.5980095972	1.043957	assets_per_share
VAULT_YEARN	8453	0x70fffbacb53ef74903ac074aae769414a70970d1	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1.133213	assets_per_share
VAULT_YEARN	8453	0x70fffbacb53ef74903ac074aae769414a70970d1	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1.133356	assets_per_share
VAULT_YEARN	8453	0x70fffbacb53ef74903ac074aae769414a70970d1	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1.133445	assets_per_share
VAULT_YEARN	8453	0x70fffbacb53ef74903ac074aae769414a70970d1	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1.133533	assets_per_share
VAULT_YEARN	8453	0xd63f18aa7beb87799fd1b368aead90a6a1c86f6c	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xd63f18aa7beb87799fd1b368aead90a6a1c86f6c	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xd63f18aa7beb87799fd1b368aead90a6a1c86f6c	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xd63f18aa7beb87799fd1b368aead90a6a1c86f6c	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	8453	0xfcfbc79409e6a9358ad4d617e8684d21f39e9009	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	2.332072605086558	1	assets_per_share
VAULT_YEARN	8453	0xfcfbc79409e6a9358ad4d617e8684d21f39e9009	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	2.3322367958511574	1	assets_per_share
VAULT_YEARN	8453	0xfcfbc79409e6a9358ad4d617e8684d21f39e9009	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	2.332272211556127	1	assets_per_share
VAULT_YEARN	8453	0xfcfbc79409e6a9358ad4d617e8684d21f39e9009	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	2.3321764702902725	1	assets_per_share
VAULT_YEARN	8453	0x0de119f5790c4ecf6eed80aac7c25d2dcad10f0f	2026-10-01T00:00:00.000Z	yearn-kong	2.5606035308101127	\N	19547.975051908128	1.023178	assets_per_share
VAULT_YEARN	8453	0x0de119f5790c4ecf6eed80aac7c25d2dcad10f0f	2026-10-02T00:00:00.000Z	yearn-kong	2.5604256698841255	\N	19627.091426535313	1.023249	assets_per_share
VAULT_YEARN	8453	0x0de119f5790c4ecf6eed80aac7c25d2dcad10f0f	2026-10-03T00:00:00.000Z	yearn-kong	2.5347492744742794	\N	19626.19719902173	1.023317	assets_per_share
VAULT_YEARN	8453	0x0de119f5790c4ecf6eed80aac7c25d2dcad10f0f	2026-10-04T00:00:00.000Z	yearn-kong	2.509077780743496	\N	19641.833769096564	1.023384	assets_per_share
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
