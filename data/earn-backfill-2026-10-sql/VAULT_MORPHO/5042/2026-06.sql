-- Generated from VAULT_MORPHO/5042/2026-06.ndjson (107 vault rows)
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
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-04T00:00:00.000Z	morpho-api	\N	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-05T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-06T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-07T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-08T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-09T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-10T00:00:00.000Z	morpho-api	0	\N	\N	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-11T00:00:00.000Z	morpho-api	0	\N	0.009998328062582487	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-12T00:00:00.000Z	morpho-api	0	\N	0.009997769145590989	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-13T00:00:00.000Z	morpho-api	0	\N	0.009998534607530913	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-14T00:00:00.000Z	morpho-api	0	\N	0.009998317464097189	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-15T00:00:00.000Z	morpho-api	0	\N	0.00999707830957434	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-16T00:00:00.000Z	morpho-api	0	\N	0.009998275926950986	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-17T00:00:00.000Z	morpho-api	0	\N	1.009826450800277	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-18T00:00:00.000Z	morpho-api	0	\N	0.5098956254914399	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-19T00:00:00.000Z	morpho-api	0	\N	1.7600168204164917	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-20T00:00:00.000Z	morpho-api	0	\N	1.7596596766185142	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-21T00:00:00.000Z	morpho-api	0	\N	1.7597727522905449	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-22T00:00:00.000Z	morpho-api	0	\N	1.7596904758079102	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-23T00:00:00.000Z	morpho-api	0	\N	1.7596676563536178	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-24T00:00:00.000Z	morpho-api	0	\N	4.0592061422540775	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-25T00:00:00.000Z	morpho-api	0	\N	3.309322817643752	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-26T00:00:00.000Z	morpho-api	0	\N	3.308946368423136	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-27T00:00:00.000Z	morpho-api	0	\N	3.3091038915856545	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-28T00:00:00.000Z	morpho-api	0	\N	3.3092445681512426	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-29T00:00:00.000Z	morpho-api	0	\N	3.3089534908988223	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-06-30T00:00:00.000Z	morpho-api	0	\N	3.808590335561679	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-12T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-13T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-14T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-15T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-16T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-17T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-18T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-19T00:00:00.000Z	morpho-api	0	\N	1.0000095570548249	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-20T00:00:00.000Z	morpho-api	0	\N	0.9998066344423376	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-21T00:00:00.000Z	morpho-api	0	\N	0.9998708819832641	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-22T00:00:00.000Z	morpho-api	0	\N	0.9998241339817672	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-23T00:00:00.000Z	morpho-api	0	\N	0.9998111683827373	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-24T00:00:00.000Z	morpho-api	0	\N	2.009606981756329	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-25T00:00:00.000Z	morpho-api	0	\N	2.1095683218212438	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-26T00:00:00.000Z	morpho-api	0.1383884047356787	\N	2.10933634711292	1.000003791467397	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-27T00:00:00.000Z	morpho-api	0.11467688239008567	\N	1.59958083202161	1.000006933316099	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-28T00:00:00.000Z	morpho-api	0.13687378590532262	\N	1.5996548320040336	1.000010683306943	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-29T00:00:00.000Z	morpho-api	0.13687308566545653	\N	1.5995201263531356	1.000014433297787	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-06-30T00:00:00.000Z	morpho-api	0.09124825695039362	\N	1.5994380038343186	1.000016933291683	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-19T00:00:00.000Z	morpho-api	\N	\N	2.0000191141096497	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-20T00:00:00.000Z	morpho-api	0	\N	1.9996132688846753	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-21T00:00:00.000Z	morpho-api	0	\N	1.9997417639665283	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-22T00:00:00.000Z	morpho-api	0	\N	1.9996482679635343	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-23T00:00:00.000Z	morpho-api	0	\N	1.9996223367654746	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-24T00:00:00.000Z	morpho-api	0	\N	1.9996089370709742	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-25T00:00:00.000Z	morpho-api	0	\N	1.9995908263708473	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-26T00:00:00.000Z	morpho-api	0	\N	1.9993633646061246	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-27T00:00:00.000Z	morpho-api	0	\N	1.999458544764746	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-28T00:00:00.000Z	morpho-api	0	\N	1.9995435457107205	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-29T00:00:00.000Z	morpho-api	0	\N	1.9993676682168111	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-06-30T00:00:00.000Z	morpho-api	0	\N	1.999260018667548	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-12T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-13T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-14T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-15T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-16T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-17T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-18T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-19T00:00:00.000Z	morpho-api	0	\N	1.1462403337540863	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-20T00:00:00.000Z	morpho-api	0	\N	1.1472717813301139	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-21T00:00:00.000Z	morpho-api	0	\N	1.1464981823755886	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-22T00:00:00.000Z	morpho-api	0	\N	1.1458777924939019	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-23T00:00:00.000Z	morpho-api	0	\N	1.1421916290005383	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-24T00:00:00.000Z	morpho-api	0	\N	1.13827193732242	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-25T00:00:00.000Z	morpho-api	0	\N	1.1354073696498306	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-26T00:00:00.000Z	morpho-api	0	\N	1.1358354867275016	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-27T00:00:00.000Z	morpho-api	0	\N	1.1386069495962072	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-28T00:00:00.000Z	morpho-api	0	\N	1.1384141695654177	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-29T00:00:00.000Z	morpho-api	0	\N	1.1384509664153974	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-06-30T00:00:00.000Z	morpho-api	0	\N	1.1417348864419088	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-19T00:00:00.000Z	morpho-api	\N	\N	1.7193605006311294	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-20T00:00:00.000Z	morpho-api	0	\N	1.7209076719951708	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-21T00:00:00.000Z	morpho-api	0	\N	1.719747273563383	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-22T00:00:00.000Z	morpho-api	0	\N	1.7188166887408527	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-23T00:00:00.000Z	morpho-api	0	\N	1.7132874435008074	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-24T00:00:00.000Z	morpho-api	0	\N	1.7074079059836298	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-25T00:00:00.000Z	morpho-api	0	\N	1.7031110544747459	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-26T00:00:00.000Z	morpho-api	0	\N	1.7037532300912523	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-27T00:00:00.000Z	morpho-api	0	\N	1.7079104243943108	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-28T00:00:00.000Z	morpho-api	0	\N	1.7076212543481266	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-29T00:00:00.000Z	morpho-api	0	\N	1.7076764496230963	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-06-30T00:00:00.000Z	morpho-api	0	\N	1.7126023296628632	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-13T00:00:00.000Z	morpho-api	\N	\N	0.9998534607530912	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-14T00:00:00.000Z	morpho-api	0	\N	0.9998317464097188	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-15T00:00:00.000Z	morpho-api	0	\N	0.999707830957434	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-16T00:00:00.000Z	morpho-api	0	\N	0.9998275926950985	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-17T00:00:00.000Z	morpho-api	0	\N	0.999828169109185	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-18T00:00:00.000Z	morpho-api	-1.496529183775408	\N	0.9997973436915507	0.999959000039222	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-19T00:00:00.000Z	morpho-api	-0.3285003773001449	\N	1.000011557073939	0.99995000043522	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-20T00:00:00.000Z	morpho-api	-0.2920028251196527	\N	0.9998086340556066	0.999942000787219	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-21T00:00:00.000Z	morpho-api	-0.32850597921907365	\N	0.9998728817250282	0.999933001183217	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-22T00:00:00.000Z	morpho-api	-0.29200772679871534	\N	0.9998261336300351	0.999925001535216	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-23T00:00:00.000Z	morpho-api	-0.29201017763824666	\N	0.9998131680050741	0.999917001887215	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-24T00:00:00.000Z	morpho-api	-0.292012628477778	\N	0.9998064681444242	0.999909002239213	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-25T00:00:00.000Z	morpho-api	-0.32851683293699807	\N	0.9997974127762501	0.999900002635212	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-26T00:00:00.000Z	morpho-api	-0.2920175301568406	\N	0.999683681666427	0.99989200298721	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-27T00:00:00.000Z	morpho-api	-0.29201998099637194	\N	0.9997312718409178	0.999884003339209	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-28T00:00:00.000Z	morpho-api	-0.2920220817159702	\N	0.999773772398906	0.999876003691208	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-29T00:00:00.000Z	morpho-api	-0.29202453255550154	\N	0.9996858334760739	0.999868004043206	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-06-30T00:00:00.000Z	morpho-api	-0.32853048761438686	\N	0.9996320085937928	0.999859004439205	assets_per_share
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
