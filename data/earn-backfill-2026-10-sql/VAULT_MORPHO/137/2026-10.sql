-- Generated from VAULT_MORPHO/137/2026-10.ndjson (76 vault rows)
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
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-01T00:00:00.000Z	morpho-api	0	\N	10314.964984484446	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-02T00:00:00.000Z	morpho-api	0	\N	10078.868009030908	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-03T00:00:00.000Z	morpho-api	0	\N	9865.486640218769	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-04T00:00:00.000Z	morpho-api	0	\N	9925.742359944215	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-05T00:00:00.000Z	morpho-api	0	\N	9929.819055288859	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-06T00:00:00.000Z	morpho-api	0	\N	9898.186981997902	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-07T00:00:00.000Z	morpho-api	0	\N	9946.186295129612	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-08T00:00:00.000Z	morpho-api	0	\N	9869.565633418875	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-09T00:00:00.000Z	morpho-api	0	\N	9841.993080746171	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-10T00:00:00.000Z	morpho-api	0	\N	9866.871457679774	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-11T00:00:00.000Z	morpho-api	0	\N	9889.099984238714	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-12T00:00:00.000Z	morpho-api	0	\N	9836.939286880965	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-13T00:00:00.000Z	morpho-api	0	\N	9832.665694901205	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-14T00:00:00.000Z	morpho-api	0	\N	9894.97886313445	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-15T00:00:00.000Z	morpho-api	0	\N	9872.637692208267	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-16T00:00:00.000Z	morpho-api	0	\N	9906.049010009348	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-17T00:00:00.000Z	morpho-api	0	\N	9902.054490231443	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-18T00:00:00.000Z	morpho-api	0	\N	9903.209150775638	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0xbeef0f82e269760429be6255fa00821b7e4b592a	2026-10-19T00:00:00.000Z	morpho-api	0	\N	9900.429563359528	1.0166219276082966	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-01T00:00:00.000Z	morpho-api	12.745226857902026	\N	196877.6769961913	1.0000268675909854	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-02T00:00:00.000Z	morpho-api	12.745504152888998	\N	194993.81597085544	1.0000277483388293	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-03T00:00:00.000Z	morpho-api	12.745452335138907	\N	194996.63447730697	1.0000286278003163	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-04T00:00:00.000Z	morpho-api	12.706343238377826	\N	196285.26807074767	1.000030561745396	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-05T00:00:00.000Z	morpho-api	12.75821350645856	\N	196286.0873066843	1.0000341095000704	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-06T00:00:00.000Z	morpho-api	12.781643532377984	\N	204689.3137848635	1.0000376502490347	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-07T00:00:00.000Z	morpho-api	12.787456923746277	\N	205409.85619442852	1.0000413733005833	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-08T00:00:00.000Z	morpho-api	12.794827648576756	\N	203858.58547205452	1.00004532701318	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-09T00:00:00.000Z	morpho-api	12.795382938790567	\N	203522.72692083387	1.0000492994916084	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-10T00:00:00.000Z	morpho-api	12.763634063261975	\N	205063.03389723186	1.0000537027269825	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-11T00:00:00.000Z	morpho-api	12.779110064542465	\N	204847.4639186431	1.0000585886227162	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-12T00:00:00.000Z	morpho-api	12.777988280276986	\N	204848.75402085326	1.0000634416152232	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-13T00:00:00.000Z	morpho-api	12.776872097930436	\N	204925.2217235128	1.0000682621106851	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-14T00:00:00.000Z	morpho-api	12.775776222540003	\N	203484.1104316199	1.0000730503825364	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-15T00:00:00.000Z	morpho-api	12.77453679797702	\N	202789.97661176365	1.0000778067028746	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-16T00:00:00.000Z	morpho-api	12.773627886630834	\N	200812.67519451145	1.0000825308219636	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-17T00:00:00.000Z	morpho-api	12.772561421314776	\N	201446.5951510325	1.0000872235466418	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-18T00:00:00.000Z	morpho-api	12.771504059116978	\N	201624.99798321436	1.0000918851516412	assets_per_share
VAULT_MORPHO	137	0x902af532d51d4983dbf9b8e29d1f01e430b24435	2026-10-19T00:00:00.000Z	morpho-api	12.770455800037439	\N	201626.0963233073	1.0000965159120205	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-01T00:00:00.000Z	morpho-api	93.90219335223549	\N	11000.40718591394	1.000000544214295	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-02T00:00:00.000Z	morpho-api	20.935004053512785	\N	74503.01033245544	1.0000085781142682	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-03T00:00:00.000Z	morpho-api	16.120032192290523	\N	109252.20064565506	1.0000577846709595	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-04T00:00:00.000Z	morpho-api	22.849793861823287	\N	106765.5611209312	1.0003096609786444	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-05T00:00:00.000Z	morpho-api	21.935795273009262	\N	97292.57538217778	1.0005399839086615	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-06T00:00:00.000Z	morpho-api	16.127895185746866	\N	135677.06758430687	1.0006704756505675	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-07T00:00:00.000Z	morpho-api	15.390454376529306	\N	135581.3133555527	1.0007781142453014	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-08T00:00:00.000Z	morpho-api	14.997743754108228	\N	145925.0137103484	1.0008973890010406	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-09T00:00:00.000Z	morpho-api	16.025964769639245	\N	141056.07607058564	1.0010375415319013	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-10T00:00:00.000Z	morpho-api	15.794256798429274	\N	141383.81740556742	1.0011712351372135	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-11T00:00:00.000Z	morpho-api	13.534864246977918	\N	167346.16799027415	1.0012856426656394	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-12T00:00:00.000Z	morpho-api	12.752658503600856	\N	181202.13456411468	1.0013971898787724	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-13T00:00:00.000Z	morpho-api	13.05025974644991	\N	176186.4306447606	1.0015106373736802	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-14T00:00:00.000Z	morpho-api	12.622960075603373	\N	186869.39169212297	1.0016258347848461	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-15T00:00:00.000Z	morpho-api	13.015184031317517	\N	186888.25078716755	1.001752784266739	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-16T00:00:00.000Z	morpho-api	13.56001826344766	\N	176371.1056493438	1.001881727424267	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-17T00:00:00.000Z	morpho-api	14.365911020775002	\N	177483.4401691817	1.002036388281876	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-18T00:00:00.000Z	morpho-api	13.933879128913418	\N	178745.45003646018	1.0021799307226313	assets_per_share
VAULT_MORPHO	137	0x922c843349e3bd9e4c3572171dfca5e08836151f	2026-10-19T00:00:00.000Z	morpho-api	13.97991079699068	\N	178871.2547811438	1.0023251530996644	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-01T00:00:00.000Z	morpho-api	71.56773401746364	\N	288.57441119299284	1.0144736223304656	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-02T00:00:00.000Z	morpho-api	82.63123610312562	\N	287.88597935199766	1.0167728597811747	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-03T00:00:00.000Z	morpho-api	58.08345789937164	\N	288.0517969040237	1.0183921665814226	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-04T00:00:00.000Z	morpho-api	46.03601306563121	\N	290.1888185104226	1.0196774348753883	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-05T00:00:00.000Z	morpho-api	22.133238406851774	\N	290.4902564131894	1.0202959446843471	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-06T00:00:00.000Z	morpho-api	22.13561292023769	\N	289.7466824219827	1.0209148960839056	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-07T00:00:00.000Z	morpho-api	22.13798673338374	\N	291.3345658073573	1.0215342893975075	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-08T00:00:00.000Z	morpho-api	22.15605012096944	\N	289.271927200749	1.0221545643399677	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-09T00:00:00.000Z	morpho-api	18.315694513049152	\N	288.61377038573795	1.0226676100612655	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-10T00:00:00.000Z	morpho-api	17.117750059014725	\N	289.4839695326301	1.0231473326362186	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-11T00:00:00.000Z	morpho-api	17.348215104462383	\N	290.27905097757764	1.0236337435688692	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-12T00:00:00.000Z	morpho-api	17.08943235882998	\N	289.0741776165184	1.0241131248178617	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-13T00:00:00.000Z	morpho-api	17.87145043792293	\N	289.09519058905056	1.0246146828552787	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-14T00:00:00.000Z	morpho-api	16.99973373270325	\N	291.0677315587989	1.0250920043214424	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-15T00:00:00.000Z	morpho-api	16.68965281496071	\N	290.5481961772663	1.0255608356022154	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-16T00:00:00.000Z	morpho-api	16.452305111869236	\N	291.6677007536875	1.0260232093751023	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-17T00:00:00.000Z	morpho-api	16.224907817274925	\N	291.6844449140606	1.0264793965695715	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-18T00:00:00.000Z	morpho-api	16.001156671663352	\N	291.8510469465245	1.0269294913136444	assets_per_share
VAULT_MORPHO	137	0xf33bea119a0c35320bded9158c6ffe00c120478a	2026-10-19T00:00:00.000Z	morpho-api	17.029826540948534	\N	291.9120924356091	1.0274087382004313	assets_per_share
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
