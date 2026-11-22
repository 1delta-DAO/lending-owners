-- Generated from VAULT_YEARN/747474/2026-10.ndjson (96 vault rows)
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
VAULT_YEARN	747474	0x543cc24962b540430dd1121e83e8564770da6810	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x543cc24962b540430dd1121e83e8564770da6810	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x543cc24962b540430dd1121e83e8564770da6810	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x543cc24962b540430dd1121e83e8564770da6810	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x8fb1c10ad4417eca341a1d903ff437d25ff87a4e	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x8fb1c10ad4417eca341a1d903ff437d25ff87a4e	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x8fb1c10ad4417eca341a1d903ff437d25ff87a4e	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x8fb1c10ad4417eca341a1d903ff437d25ff87a4e	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x9a6bd7b6fd5c4f87eb66356441502fc7dcdd185b	2026-10-01T00:00:00.000Z	yearn-kong	0.3813324248369554	\N	1432284.0814975738	1.026259	assets_per_share
VAULT_YEARN	747474	0x9a6bd7b6fd5c4f87eb66356441502fc7dcdd185b	2026-10-02T00:00:00.000Z	yearn-kong	0.4982682810350525	\N	1432535.497809276	1.026282	assets_per_share
VAULT_YEARN	747474	0x9a6bd7b6fd5c4f87eb66356441502fc7dcdd185b	2026-10-03T00:00:00.000Z	yearn-kong	0.6101182950857265	\N	1432530.283688892	1.026304	assets_per_share
VAULT_YEARN	747474	0x9a6bd7b6fd5c4f87eb66356441502fc7dcdd185b	2026-10-04T00:00:00.000Z	yearn-kong	0.721965508176936	\N	1432546.0338482119	1.026326	assets_per_share
VAULT_YEARN	747474	0xc1ec6d26902949bf6cbb0c9859dbead1e87fb243	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	26748.528143693165	1.030244	assets_per_share
VAULT_YEARN	747474	0xc1ec6d26902949bf6cbb0c9859dbead1e87fb243	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	26750.020502283733	1.030244	assets_per_share
VAULT_YEARN	747474	0xc1ec6d26902949bf6cbb0c9859dbead1e87fb243	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	26746.787038766135	1.030244	assets_per_share
VAULT_YEARN	747474	0xc1ec6d26902949bf6cbb0c9859dbead1e87fb243	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	26747.29416726266	1.030244	assets_per_share
VAULT_YEARN	747474	0x93fec6639717b6215a48e5a72a162c50dcc40d68	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	46605.73452406891	1.055117	assets_per_share
VAULT_YEARN	747474	0x93fec6639717b6215a48e5a72a162c50dcc40d68	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	46608.334759413185	1.055117	assets_per_share
VAULT_YEARN	747474	0x93fec6639717b6215a48e5a72a162c50dcc40d68	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	46602.700881485966	1.055117	assets_per_share
VAULT_YEARN	747474	0x93fec6639717b6215a48e5a72a162c50dcc40d68	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	46179.448497831676	1.055117	assets_per_share
VAULT_YEARN	747474	0xaa0362ecc584b985056e47812931270b99c91f9d	2026-10-01T00:00:00.000Z	yearn-kong	0.000051817750090776826	\N	1655866.2847862742	1.00245866	assets_per_share
VAULT_YEARN	747474	0xaa0362ecc584b985056e47812931270b99c91f9d	2026-10-02T00:00:00.000Z	yearn-kong	0.000051817750090776826	\N	1652404.6579986026	1.00245866	assets_per_share
VAULT_YEARN	747474	0xaa0362ecc584b985056e47812931270b99c91f9d	2026-10-03T00:00:00.000Z	yearn-kong	0.000051817750090776826	\N	1503445.3745452121	1.00245866	assets_per_share
VAULT_YEARN	747474	0xaa0362ecc584b985056e47812931270b99c91f9d	2026-10-04T00:00:00.000Z	yearn-kong	0.000051817750090776826	\N	1534991.8064695061	1.00245866	assets_per_share
VAULT_YEARN	747474	0x80c34bd3a3569e126e7055831036aa7b212cb159	2026-10-01T00:00:00.000Z	yearn-kong	0.3047352866047959	\N	7265849.113546094	1.027365	assets_per_share
VAULT_YEARN	747474	0x80c34bd3a3569e126e7055831036aa7b212cb159	2026-10-02T00:00:00.000Z	yearn-kong	0.39615230136291757	\N	7258155.512030998	1.027383	assets_per_share
VAULT_YEARN	747474	0x80c34bd3a3569e126e7055831036aa7b212cb159	2026-10-03T00:00:00.000Z	yearn-kong	0.4926460551502032	\N	6668821.944443615	1.027402	assets_per_share
VAULT_YEARN	747474	0x80c34bd3a3569e126e7055831036aa7b212cb159	2026-10-04T00:00:00.000Z	yearn-kong	0.5942165479666528	\N	6674321.105260319	1.027422	assets_per_share
VAULT_YEARN	747474	0xe007ca01894c863d7898045ed5a3b4abf0b18f37	2026-10-01T00:00:00.000Z	yearn-kong	0.1227401444481302	\N	7290010.071997052	1.016302889561225	assets_per_share
VAULT_YEARN	747474	0xe007ca01894c863d7898045ed5a3b4abf0b18f37	2026-10-02T00:00:00.000Z	yearn-kong	0.15863023854478797	\N	7193008.621365034	1.016309880172829	assets_per_share
VAULT_YEARN	747474	0xe007ca01894c863d7898045ed5a3b4abf0b18f37	2026-10-03T00:00:00.000Z	yearn-kong	0.19538232791660448	\N	7179096.749096137	1.016317038736042	assets_per_share
VAULT_YEARN	747474	0xe007ca01894c863d7898045ed5a3b4abf0b18f37	2026-10-04T00:00:00.000Z	yearn-kong	0.23209520385591986	\N	7288213.275088578	1.01632418963962	assets_per_share
VAULT_YEARN	747474	0xd46dfdaa7caa8739b0e3274e2c085dffc8d4776a	2026-10-01T00:00:00.000Z	yearn-kong	0.2694039839212792	\N	26.90247680277595	\N	\N
VAULT_YEARN	747474	0xd46dfdaa7caa8739b0e3274e2c085dffc8d4776a	2026-10-02T00:00:00.000Z	yearn-kong	0.2694039839212792	\N	26.904370885415673	\N	\N
VAULT_YEARN	747474	0xd46dfdaa7caa8739b0e3274e2c085dffc8d4776a	2026-10-03T00:00:00.000Z	yearn-kong	0.2694039839212792	\N	26.90477943623837	\N	\N
VAULT_YEARN	747474	0xd46dfdaa7caa8739b0e3274e2c085dffc8d4776a	2026-10-04T00:00:00.000Z	yearn-kong	0.2694039839212792	\N	26.903674977835962	\N	\N
VAULT_YEARN	747474	0x156c729c78076b7cd815d01ca6967c00c5ac8d9c	2026-10-01T00:00:00.000Z	yearn-kong	6.6360576713719865	\N	3.658318708194281	\N	\N
VAULT_YEARN	747474	0x156c729c78076b7cd815d01ca6967c00c5ac8d9c	2026-10-02T00:00:00.000Z	yearn-kong	6.849700854516527	\N	3.6589608719999998	\N	\N
VAULT_YEARN	747474	0x156c729c78076b7cd815d01ca6967c00c5ac8d9c	2026-10-03T00:00:00.000Z	yearn-kong	7.1344751034985165	\N	3.658972412938073	\N	\N
VAULT_YEARN	747474	0x156c729c78076b7cd815d01ca6967c00c5ac8d9c	2026-10-04T00:00:00.000Z	yearn-kong	7.450152338250859	\N	3.6596125785224576	\N	\N
VAULT_YEARN	747474	0x78ec25fba1baf6b7dc097ebb8115a390a2a4ee12	2026-10-01T00:00:00.000Z	yearn-kong	5.219321870697513	\N	10968.783759700027	1.09623	assets_per_share
VAULT_YEARN	747474	0x78ec25fba1baf6b7dc097ebb8115a390a2a4ee12	2026-10-02T00:00:00.000Z	yearn-kong	5.395430796539813	\N	10969.556022531084	1.096255	assets_per_share
VAULT_YEARN	747474	0x78ec25fba1baf6b7dc097ebb8115a390a2a4ee12	2026-10-03T00:00:00.000Z	yearn-kong	5.519179286395115	\N	10969.72259848102	1.096281	assets_per_share
VAULT_YEARN	747474	0x78ec25fba1baf6b7dc097ebb8115a390a2a4ee12	2026-10-04T00:00:00.000Z	yearn-kong	5.623886853811655	\N	10969.817455476441	1.096303	assets_per_share
VAULT_YEARN	747474	0xf7ede5332c6b4a235be4aa3c019222cfe72e984f	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	20336.64793800874	1.120878	assets_per_share
VAULT_YEARN	747474	0xf7ede5332c6b4a235be4aa3c019222cfe72e984f	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	20337.782563850225	1.120878	assets_per_share
VAULT_YEARN	747474	0xf7ede5332c6b4a235be4aa3c019222cfe72e984f	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	20335.32419272698	1.120878	assets_per_share
VAULT_YEARN	747474	0xf7ede5332c6b4a235be4aa3c019222cfe72e984f	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	19911.57386138356	1.120878	assets_per_share
VAULT_YEARN	747474	0x58b369aec52dd904f70122cf72ed311f7aae3bac	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	10.511875011797141	1.011534	assets_per_share
VAULT_YEARN	747474	0x58b369aec52dd904f70122cf72ed311f7aae3bac	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	10.512615105734096	1.011534	assets_per_share
VAULT_YEARN	747474	0x58b369aec52dd904f70122cf72ed311f7aae3bac	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	10.512774742901174	1.011534	assets_per_share
VAULT_YEARN	747474	0x58b369aec52dd904f70122cf72ed311f7aae3bac	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	10.512343186774688	1.011534	assets_per_share
VAULT_YEARN	747474	0x1769111aa8ea46fee3ba23ef9b57f3cbe1873408	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	17.694845	0.9971230447067008	assets_per_share
VAULT_YEARN	747474	0x1769111aa8ea46fee3ba23ef9b57f3cbe1873408	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	17.694845	0.9971230447067008	assets_per_share
VAULT_YEARN	747474	0x1769111aa8ea46fee3ba23ef9b57f3cbe1873408	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	17.694845	0.9971230447067008	assets_per_share
VAULT_YEARN	747474	0x1769111aa8ea46fee3ba23ef9b57f3cbe1873408	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	17.694845	0.9971230447067008	assets_per_share
VAULT_YEARN	747474	0xea79c91540c7e884e6e0069ce036e52f7bbb1194	2026-10-01T00:00:00.000Z	yearn-kong	0.0073245089993179135	\N	121.25577491686121	2.6421915260699085	assets_per_share
VAULT_YEARN	747474	0xea79c91540c7e884e6e0069ce036e52f7bbb1194	2026-10-02T00:00:00.000Z	yearn-kong	0.0073245089993179135	\N	119.75220300422346	2.6421915260699085	assets_per_share
VAULT_YEARN	747474	0xea79c91540c7e884e6e0069ce036e52f7bbb1194	2026-10-03T00:00:00.000Z	yearn-kong	0.0073245089993179135	\N	120.64823678389207	2.6421915260699085	assets_per_share
VAULT_YEARN	747474	0xea79c91540c7e884e6e0069ce036e52f7bbb1194	2026-10-04T00:00:00.000Z	yearn-kong	0.0073245089993179135	\N	122.80676363719911	2.6421915260699085	assets_per_share
VAULT_YEARN	747474	0x2f817617a682a18851e3eacbd945b214be70474e	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x2f817617a682a18851e3eacbd945b214be70474e	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x2f817617a682a18851e3eacbd945b214be70474e	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x2f817617a682a18851e3eacbd945b214be70474e	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x1166da048a9b0e840a57dd9dce5378e6c32e53c4	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x1166da048a9b0e840a57dd9dce5378e6c32e53c4	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x1166da048a9b0e840a57dd9dce5378e6c32e53c4	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x1166da048a9b0e840a57dd9dce5378e6c32e53c4	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0xf352cdbe225b82cc458aca3c127f2935d7ee12cb	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	5.824432073330703	1	assets_per_share
VAULT_YEARN	747474	0xf352cdbe225b82cc458aca3c127f2935d7ee12cb	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	5.824842145449982	1	assets_per_share
VAULT_YEARN	747474	0xf352cdbe225b82cc458aca3c127f2935d7ee12cb	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	5.824930597399323	1	assets_per_share
VAULT_YEARN	747474	0xf352cdbe225b82cc458aca3c127f2935d7ee12cb	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	5.824691480273051	1	assets_per_share
VAULT_YEARN	747474	0x0432337365d89c0d73f1d0cb263791f8f1b98d43	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	1187762.7587076155	1.22042306	assets_per_share
VAULT_YEARN	747474	0x0432337365d89c0d73f1d0cb263791f8f1b98d43	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	1185285.77192586	1.2203187	assets_per_share
VAULT_YEARN	747474	0x0432337365d89c0d73f1d0cb263791f8f1b98d43	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	1037862.4548026766	1.2203187	assets_per_share
VAULT_YEARN	747474	0x0432337365d89c0d73f1d0cb263791f8f1b98d43	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	1059567.7894965985	1.22023221	assets_per_share
VAULT_YEARN	747474	0xa03e39cdeac8c2823a6edc80956207294807c20d	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	203.0831686803555	1	assets_per_share
VAULT_YEARN	747474	0xa03e39cdeac8c2823a6edc80956207294807c20d	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	200.5649368801248	1	assets_per_share
VAULT_YEARN	747474	0xa03e39cdeac8c2823a6edc80956207294807c20d	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	202.06564378950299	1	assets_per_share
VAULT_YEARN	747474	0xa03e39cdeac8c2823a6edc80956207294807c20d	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	205.68081571308178	1	assets_per_share
VAULT_YEARN	747474	0x17e6ee30d939d1c0186ef98265e9a4e38a056aa1	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x17e6ee30d939d1c0186ef98265e9a4e38a056aa1	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x17e6ee30d939d1c0186ef98265e9a4e38a056aa1	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x17e6ee30d939d1c0186ef98265e9a4e38a056aa1	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x2f0b01d1f36fb2c72f7deb441a2a262e655d6888	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	3.510746267080614	1.3235472512123807	assets_per_share
VAULT_YEARN	747474	0x2f0b01d1f36fb2c72f7deb441a2a262e655d6888	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	3.467213004576626	1.3235472512123807	assets_per_share
VAULT_YEARN	747474	0x2f0b01d1f36fb2c72f7deb441a2a262e655d6888	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	3.4931560761483227	1.3235472512123807	assets_per_share
VAULT_YEARN	747474	0x2f0b01d1f36fb2c72f7deb441a2a262e655d6888	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	3.555652399295297	1.3235472512123807	assets_per_share
VAULT_YEARN	747474	0x3384246d42cac0b8dd9bbdbe902a06d0814244f7	2026-10-01T00:00:00.000Z	yearn-kong	0	\N	8.464189318650702	1.07796745	assets_per_share
VAULT_YEARN	747474	0x3384246d42cac0b8dd9bbdbe902a06d0814244f7	2026-10-02T00:00:00.000Z	yearn-kong	0	\N	8.44653791065119	1.07796745	assets_per_share
VAULT_YEARN	747474	0x3384246d42cac0b8dd9bbdbe902a06d0814244f7	2026-10-03T00:00:00.000Z	yearn-kong	0	\N	8.472692393997114	1.07796745	assets_per_share
VAULT_YEARN	747474	0x3384246d42cac0b8dd9bbdbe902a06d0814244f7	2026-10-04T00:00:00.000Z	yearn-kong	0	\N	8.650521606523183	1.07796745	assets_per_share
VAULT_YEARN	747474	0x518ea05c41f89e36985a94c6df8782f6d3f45111	2026-10-01T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x518ea05c41f89e36985a94c6df8782f6d3f45111	2026-10-02T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x518ea05c41f89e36985a94c6df8782f6d3f45111	2026-10-03T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
VAULT_YEARN	747474	0x518ea05c41f89e36985a94c6df8782f6d3f45111	2026-10-04T00:00:00.000Z	yearn-kong	\N	\N	\N	1	assets_per_share
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
