-- Generated from VAULT_MORPHO/5042/2026-07.ndjson (186 vault rows)
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
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-01T00:00:00.000Z	morpho-api	0	\N	3.8385789001432253	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-02T00:00:00.000Z	morpho-api	0	\N	5.558510265647037	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-03T00:00:00.000Z	morpho-api	0	\N	5.558971943788513	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-04T00:00:00.000Z	morpho-api	0	\N	5.559838170819618	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-05T00:00:00.000Z	morpho-api	0	\N	5.55871242822773	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-06T00:00:00.000Z	morpho-api	0	\N	5.55828088751023	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-07T00:00:00.000Z	morpho-api	0	\N	5.559856079559256	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-08T00:00:00.000Z	morpho-api	0	\N	5.56249671299521	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-09T00:00:00.000Z	morpho-api	0	\N	5.562465061805398	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-10T00:00:00.000Z	morpho-api	0	\N	5.561987867570766	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-11T00:00:00.000Z	morpho-api	0	\N	5.762525212115161	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-12T00:00:00.000Z	morpho-api	0	\N	5.761875384180872	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-13T00:00:00.000Z	morpho-api	0	\N	5.761979378927555	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-14T00:00:00.000Z	morpho-api	0	\N	5.7623751726722166	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-15T00:00:00.000Z	morpho-api	0	\N	5.762320018605436	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-16T00:00:00.000Z	morpho-api	0	\N	5.762154560790137	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-17T00:00:00.000Z	morpho-api	0	\N	5.762488927069138	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-18T00:00:00.000Z	morpho-api	0	\N	4.32255159340706	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-19T00:00:00.000Z	morpho-api	0	\N	4.322343738170602	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-20T00:00:00.000Z	morpho-api	0	\N	4.322138157573189	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-21T00:00:00.000Z	morpho-api	0	\N	5.322142355855307	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-22T00:00:00.000Z	morpho-api	0	\N	5.272547722452295	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-23T00:00:00.000Z	morpho-api	0	\N	8.2727444843411	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-24T00:00:00.000Z	morpho-api	0	\N	6.772112318235546	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-25T00:00:00.000Z	morpho-api	0	\N	6.77302673460075	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-26T00:00:00.000Z	morpho-api	0	\N	6.772592191724472	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-27T00:00:00.000Z	morpho-api	0	\N	6.772667435326485	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-28T00:00:00.000Z	morpho-api	0	\N	6.781931494542766	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-29T00:00:00.000Z	morpho-api	0	\N	6.272103241661672	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-30T00:00:00.000Z	morpho-api	0	\N	6.281774136632859	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0007d5a04246f5382957035df34f7e82102e	2026-07-31T00:00:00.000Z	morpho-api	0	\N	3.7818507709853564	1	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-01T00:00:00.000Z	morpho-api	0.11405997106805899	\N	1.5994428621069443	1.000020058284052	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-02T00:00:00.000Z	morpho-api	0.09741526945106216	\N	1.099730261684961	1.000022727252066	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-03T00:00:00.000Z	morpho-api	0.19908589656836284	\N	1.0998276018520903	1.000028181792562	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-04T00:00:00.000Z	morpho-api	0.5972506873064276	\N	1.1000169820093437	1.000044545414049	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-05T00:00:00.000Z	morpho-api	0.13272066325953347	\N	1.0997982523038128	1.00004818177438	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-06T00:00:00.000Z	morpho-api	0.03318016581488337	\N	1.099713871120356	1.000049090864462	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-07T00:00:00.000Z	morpho-api	0.5640586174138207	\N	1.1000425246936747	1.000064545395867	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-08T00:00:00.000Z	morpho-api	0.16589802811495247	\N	1.100956594481119	1.000069090846281	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-09T00:00:00.000Z	morpho-api	0	\N	1.1009503299226042	1.000069090846281	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-10T00:00:00.000Z	morpho-api	0.03314935526077534	\N	1.1008568811024817	1.000069999110726	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-11T00:00:00.000Z	morpho-api	0.03314935526077534	\N	1.1009681830100706	1.000070907375172	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-12T00:00:00.000Z	morpho-api	0.03314935526077534	\N	1.1008450289147316	1.000071815639617	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-13T00:00:00.000Z	morpho-api	0	\N	1.1008648978102364	1.000071815639617	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-14T00:00:00.000Z	morpho-api	0.03314935526077534	\N	1.100941516740283	1.000072723904063	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-15T00:00:00.000Z	morpho-api	0.1991965344672053	\N	1.09993711370401	1.000078181747107	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-16T00:00:00.000Z	morpho-api	0.7631137034280755	\N	1.0999285266117673	1.000099090819008	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-17T00:00:00.000Z	morpho-api	0.2986053868170302	\N	1.1000013523050869	1.000107272629752	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-18T00:00:00.000Z	morpho-api	0.4976702761894103	\N	1.100018887834765	1.000120908980991	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-19T00:00:00.000Z	morpho-api	0	\N	1.0999659920668143	1.000120908980991	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-20T00:00:00.000Z	morpho-api	0.03317806509528509	\N	1.0999146749580435	1.000121818071074	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-21T00:00:00.000Z	morpho-api	0.23224365470753128	\N	1.099963744789219	1.000128181701652	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-22T00:00:00.000Z	morpho-api	0.1990648893723801	\N	1.1000526378176987	1.000133636242148	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-23T00:00:00.000Z	morpho-api	0.1658861240372289	\N	1.1001180212663884	1.000138181692562	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-24T00:00:00.000Z	morpho-api	0.29859348273930664	\N	1.1000168108876918	1.000146363503305	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-25T00:00:00.000Z	morpho-api	0.19906138817304964	\N	1.1001713426141302	1.000151818043801	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-26T00:00:00.000Z	morpho-api	0	\N	1.1001007579791728	1.000151818043801	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-27T00:00:00.000Z	morpho-api	0	\N	1.100112980115286	1.000151818043801	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-28T00:00:00.000Z	morpho-api	0.23223665230887036	\N	2.0998431659472	1.00015818167438	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-29T00:00:00.000Z	morpho-api	0.23223525182913818	\N	1.1000237233404402	1.000164545304958	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-30T00:00:00.000Z	morpho-api	0.03317596437568682	\N	1.099967345724815	1.000165454395041	assets_per_share
VAULT_MORPHO	5042	0xdeccd53be5453215821184824b519e04c7e00bc7	2026-07-31T00:00:00.000Z	morpho-api	0.2322331511095399	\N	1.0998547760717972	1.000171818025619	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-01T00:00:00.000Z	morpho-api	0	\N	1.9992598438245965	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-02T00:00:00.000Z	morpho-api	0	\N	1.9994641243334668	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-03T00:00:00.000Z	morpho-api	0	\N	1.999630195607379	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-04T00:00:00.000Z	morpho-api	0	\N	1.9999417880646109	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-05T00:00:00.000Z	morpho-api	0	\N	1.9995368446862338	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-06T00:00:00.000Z	morpho-api	0	\N	1.999381614212313	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-07T00:00:00.000Z	morpho-api	0	\N	1.9999482300572866	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-08T00:00:00.000Z	morpho-api	0	\N	1.9997831112132478	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-09T00:00:00.000Z	morpho-api	0	\N	1.9997717322375643	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-10T00:00:00.000Z	morpho-api	0	\N	1.9996001752874353	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-11T00:00:00.000Z	morpho-api	0	\N	1.9998005282279194	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-12T00:00:00.000Z	morpho-api	0	\N	1.9995750148985345	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-13T00:00:00.000Z	morpho-api	0	\N	1.9996111047622134	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-14T00:00:00.000Z	morpho-api	0	\N	1.9997484592223689	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-15T00:00:00.000Z	morpho-api	0	\N	1.9997293188060026	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-16T00:00:00.000Z	morpho-api	0	\N	1.9996718990786684	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-17T00:00:00.000Z	morpho-api	0	\N	1.9997879360306567	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-18T00:00:00.000Z	morpho-api	0	\N	1.9997925484187185	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-19T00:00:00.000Z	morpho-api	0	\N	1.9996963859220918	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-20T00:00:00.000Z	morpho-api	0	\N	1.9996012757683037	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-21T00:00:00.000Z	morpho-api	0	\N	1.999677759104004	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-22T00:00:00.000Z	morpho-api	0	\N	1.999828455320423	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-23T00:00:00.000Z	morpho-api	0	\N	1.9999382290199688	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-24T00:00:00.000Z	morpho-api	0	\N	1.9997378763429932	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-25T00:00:00.000Z	morpho-api	0	\N	2.0000078944635318	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-26T00:00:00.000Z	morpho-api	0	\N	1.9998795782443446	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-27T00:00:00.000Z	morpho-api	0	\N	1.9999017969368036	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-28T00:00:00.000Z	morpho-api	0	\N	1.9996849460541841	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-29T00:00:00.000Z	morpho-api	0	\N	1.99971408948244	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-30T00:00:00.000Z	morpho-api	0	\N	1.9996097840626639	1	assets_per_share
VAULT_MORPHO	5042	0xbeef0016cb2fd5c352ea7ca08a9f54739dfa7298	2026-07-31T00:00:00.000Z	morpho-api	0	\N	1.9993924245230539	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-01T00:00:00.000Z	morpho-api	0	\N	1.1412289080541	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-02T00:00:00.000Z	morpho-api	0	\N	1.13784011811843	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-03T00:00:00.000Z	morpho-api	0	\N	1.1422245520737961	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-04T00:00:00.000Z	morpho-api	0	\N	1.143889790343566	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-05T00:00:00.000Z	morpho-api	0	\N	1.1426974795555973	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-06T00:00:00.000Z	morpho-api	0	\N	1.1431774018626633	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-07T00:00:00.000Z	morpho-api	0	\N	1.143988761933033	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-08T00:00:00.000Z	morpho-api	0	\N	1.1400408500370158	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-09T00:00:00.000Z	morpho-api	0	\N	1.1415929615115705	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-10T00:00:00.000Z	morpho-api	0	\N	1.1428160943826289	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-11T00:00:00.000Z	morpho-api	0	\N	1.1411530392973779	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-12T00:00:00.000Z	morpho-api	0	\N	1.140911395371375	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-13T00:00:00.000Z	morpho-api	0	\N	1.1400305172700183	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-14T00:00:00.000Z	morpho-api	0	\N	1.13793651608548	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-15T00:00:00.000Z	morpho-api	0	\N	1.142361089347231	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-16T00:00:00.000Z	morpho-api	0	\N	1.1464738500399363	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-17T00:00:00.000Z	morpho-api	0	\N	1.144310192152991	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-18T00:00:00.000Z	morpho-api	0	\N	1.143271023417737	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-19T00:00:00.000Z	morpho-api	0	\N	1.1433331078331008	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-20T00:00:00.000Z	morpho-api	0	\N	1.142270339550951	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-21T00:00:00.000Z	morpho-api	0	\N	1.141224264813697	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-22T00:00:00.000Z	morpho-api	0	\N	1.1401390447970023	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-23T00:00:00.000Z	morpho-api	0	\N	1.140982296476538	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-24T00:00:00.000Z	morpho-api	0	\N	1.1373505171782117	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-25T00:00:00.000Z	morpho-api	0	\N	1.1368356126814505	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-26T00:00:00.000Z	morpho-api	0	\N	1.1364558130282387	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-27T00:00:00.000Z	morpho-api	0	\N	1.1393209823878432	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-28T00:00:00.000Z	morpho-api	0	\N	1.1365488773973513	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-29T00:00:00.000Z	morpho-api	0	\N	1.1384281724485374	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-30T00:00:00.000Z	morpho-api	0	\N	1.146515268046911	1	assets_per_share
VAULT_MORPHO	5042	0x05863f54b05e96092069ef30c9ca6060336e50b9	2026-07-31T00:00:00.000Z	morpho-api	0	\N	1.1520834069592447	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-01T00:00:00.000Z	morpho-api	0	\N	1.71184336208115	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-02T00:00:00.000Z	morpho-api	0	\N	1.706760177177645	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-03T00:00:00.000Z	morpho-api	0	\N	1.7133368281106942	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-04T00:00:00.000Z	morpho-api	0	\N	1.715834685515349	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-05T00:00:00.000Z	morpho-api	0	\N	1.714046219333396	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-06T00:00:00.000Z	morpho-api	0	\N	1.7147661027939949	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-07T00:00:00.000Z	morpho-api	0	\N	1.7159831428995493	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-08T00:00:00.000Z	morpho-api	0	\N	1.7100612750555237	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-09T00:00:00.000Z	morpho-api	0	\N	1.7123894422673558	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-10T00:00:00.000Z	morpho-api	0	\N	1.7142241415739434	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-11T00:00:00.000Z	morpho-api	0	\N	1.7117295589460668	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-12T00:00:00.000Z	morpho-api	0	\N	1.7113670930570626	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-13T00:00:00.000Z	morpho-api	0	\N	1.7100457759050274	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-14T00:00:00.000Z	morpho-api	0	\N	1.70690477412822	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-15T00:00:00.000Z	morpho-api	0	\N	1.7135416340208462	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-16T00:00:00.000Z	morpho-api	0	\N	1.7197107750599043	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-17T00:00:00.000Z	morpho-api	0	\N	1.7164652882294864	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-18T00:00:00.000Z	morpho-api	0	\N	1.7149065351266055	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-19T00:00:00.000Z	morpho-api	0	\N	1.7149996617496512	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-20T00:00:00.000Z	morpho-api	0	\N	1.7134055093264267	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-21T00:00:00.000Z	morpho-api	0	\N	1.7118363972205455	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-22T00:00:00.000Z	morpho-api	0	\N	1.7102085671955036	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-23T00:00:00.000Z	morpho-api	0	\N	1.711473444714807	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-24T00:00:00.000Z	morpho-api	0	\N	1.7060257757673174	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-25T00:00:00.000Z	morpho-api	0	\N	1.7052534190221758	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-26T00:00:00.000Z	morpho-api	0	\N	1.704683719542358	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-27T00:00:00.000Z	morpho-api	0	\N	1.7089814735817648	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-28T00:00:00.000Z	morpho-api	0	\N	1.7048233160960269	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-29T00:00:00.000Z	morpho-api	0	\N	1.7076422586728062	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-30T00:00:00.000Z	morpho-api	0	\N	1.7197729020703667	1	assets_per_share
VAULT_MORPHO	5042	0xbeef00be37bde921bae06fad223125bab16c41d1	2026-07-31T00:00:00.000Z	morpho-api	0	\N	1.728125110438867	1	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-01T00:00:00.000Z	morpho-api	-0.2920294342345642	\N	0.9996319211721422	0.999851004791203	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-02T00:00:00.000Z	morpho-api	-0.27498629613376124	\N	2.4993321548809577	0.999843472073695	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-03T00:00:00.000Z	morpho-api	-0.30660142584792993	\N	2.4995397441394194	0.99983507338853	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-04T00:00:00.000Z	morpho-api	-0.2920035253595188	\N	2.4999292350225515	0.999827074640753	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-05T00:00:00.000Z	morpho-api	-0.3066063275269926	\N	2.4994230553946366	0.999818675955588	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-06T00:00:00.000Z	morpho-api	-0.3066087783665239	\N	2.4992290171470053	0.999810277270423	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-07T00:00:00.000Z	morpho-api	-0.23360352052748112	\N	2.4999392874680684	0.999803878409621	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-08T00:00:00.000Z	morpho-api	-0.2771094234077509	\N	2.509732804030404	0.999796287892702	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-09T00:00:00.000Z	morpho-api	-0.2908376259824763	\N	2.5097185233874737	0.99978832139159	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-10T00:00:00.000Z	morpho-api	-0.30538195812113145	\N	2.5095032189861697	0.999779956565422	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-11T00:00:00.000Z	morpho-api	-0.3053847590805958	\N	2.5097546624273597	0.999771591739254	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-12T00:00:00.000Z	morpho-api	-0.2908449785010703	\N	2.509471642635198	0.999763625238142	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-13T00:00:00.000Z	morpho-api	-0.30538966075965845	\N	2.50951693550434	0.999755260411974	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-14T00:00:00.000Z	morpho-api	-0.3053921115991898	\N	2.509689315695221	0.999746895585807	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-15T00:00:00.000Z	morpho-api	-0.2867870884770696	\N	3.5095299538278315	0.99973904042623	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-16T00:00:00.000Z	morpho-api	-0.30186465327375345	\N	3.499430822567417	0.999730772353436	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-17T00:00:00.000Z	morpho-api	-0.2920014246399205	\N	3.499633887523489	0.999722774498116	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-18T00:00:00.000Z	morpho-api	-0.2458528165050211	\N	1.0001092521157657	0.999716040698592	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-19T00:00:00.000Z	morpho-api	-0.29194050377157055	\N	1.0000611606261467	0.999708044633448	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-20T00:00:00.000Z	morpho-api	-0.3284359552324645	\N	1.000013595420021	0.999699049060161	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-21T00:00:00.000Z	morpho-api	-0.2919454054506332	\N	1.0000518452333467	0.999691052995017	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-22T00:00:00.000Z	morpho-api	-0.2919478562901645	\N	1.0001272093907032	0.999683056929872	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-23T00:00:00.000Z	morpho-api	-0.2919499570097628	\N	1.000182107931375	0.999675060864728	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-24T00:00:00.000Z	morpho-api	-0.32844645883045587	\N	1.0000819102553271	0.999666065291441	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-25T00:00:00.000Z	morpho-api	-0.29195520880875847	\N	1.0002169480725263	0.999658069226297	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-26T00:00:00.000Z	morpho-api	-0.29195730952835675	\N	1.0001527762972553	0.999650073161153	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-27T00:00:00.000Z	morpho-api	-0.29195976036788807	\N	1.0001638880097756	0.999642077096009	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-28T00:00:00.000Z	morpho-api	-0.2919622112074194	\N	1.0000554394738468	0.999634081030865	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-29T00:00:00.000Z	morpho-api	-0.32846011350784465	\N	1.0000700142917498	0.999625085457578	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-30T00:00:00.000Z	morpho-api	-0.291967112886482	\N	1.0000178504733346	0.999617089392434	assets_per_share
VAULT_MORPHO	5042	0x8e357432cc12ff425c36432f312968aeb16112af	2026-07-31T00:00:00.000Z	morpho-api	-0.29196886348614726	\N	1.9996053598162655	0.999609093336285	assets_per_share
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
