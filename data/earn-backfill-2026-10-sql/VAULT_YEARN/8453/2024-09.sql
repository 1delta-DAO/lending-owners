-- Generated from VAULT_YEARN/8453/2024-09.ndjson (106 vault rows)
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
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-01T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-03T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-05T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-06T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-07T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-09T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-10T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-11T00:00:00.000Z	yearn-kong	0	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-12T00:00:00.000Z	yearn-kong	0.010435674724362798	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-13T00:00:00.000Z	yearn-kong	0.09913505856218308	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-14T00:00:00.000Z	yearn-kong	0.187831641440539	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-15T00:00:00.000Z	yearn-kong	0.27653172551822536	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-16T00:00:00.000Z	yearn-kong	0.3600052192354042	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-17T00:00:00.000Z	yearn-kong	0.44870600355295664	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-22T00:00:00.000Z	yearn-kong	0.6051900069081739	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-09-26T00:00:00.000Z	yearn-kong	0.25563166623499	\N	0	\N	\N
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-01T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-02T00:00:00.000Z	yearn-kong	\N	\N	0	1	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-03T00:00:00.000Z	yearn-kong	0	\N	0	1	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-04T00:00:00.000Z	yearn-kong	0	\N	0	1.000009	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-05T00:00:00.000Z	yearn-kong	0.3026205622091993	\N	0	1.000058	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-06T00:00:00.000Z	yearn-kong	0.558265533001645	\N	0	1.000107	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-07T00:00:00.000Z	yearn-kong	0.8139000001960994	\N	0	1.000156	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-08T00:00:00.000Z	yearn-kong	1.074735148876016	\N	0	1.000156	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-09T00:00:00.000Z	yearn-kong	\N	\N	0	1.000255	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-10T00:00:00.000Z	yearn-kong	1.5859494645553696	\N	0	1.000304	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-11T00:00:00.000Z	yearn-kong	1.7945453187451221	\N	0	1.000353	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-12T00:00:00.000Z	yearn-kong	1.7996731752845108	\N	0	1.000403	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-13T00:00:00.000Z	yearn-kong	1.7995849450613832	\N	0	1.000452	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-14T00:00:00.000Z	yearn-kong	1.7525904471682452	\N	0	1.000492	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-15T00:00:00.000Z	yearn-kong	1.5960266164682935	\N	0	1.000512	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-16T00:00:00.000Z	yearn-kong	1.8358384636485425	\N	0	1.000607	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-17T00:00:00.000Z	yearn-kong	2.070385907515515	\N	0	1.000701	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-18T00:00:00.000Z	yearn-kong	2.3049074425074423	\N	0	1.000795	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-19T00:00:00.000Z	yearn-kong	2.534181379942879	\N	0	1.000889	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-20T00:00:00.000Z	yearn-kong	2.7738328721937933	\N	0	1.000984	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-21T00:00:00.000Z	yearn-kong	2.7738328721937933	\N	0	1.001078	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-22T00:00:00.000Z	yearn-kong	3.4460071244524215	\N	0	1.001173	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-23T00:00:00.000Z	yearn-kong	3.4404801311893607	\N	0	1.001267	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-24T00:00:00.000Z	yearn-kong	3.4401566203712264	\N	0	1.001361	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-25T00:00:00.000Z	yearn-kong	3.335574395890717	\N	0	1.001435	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-26T00:00:00.000Z	yearn-kong	2.845585050792465	\N	0	1.001435	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-27T00:00:00.000Z	yearn-kong	2.350354410296518	\N	0	1.001435	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-28T00:00:00.000Z	yearn-kong	1.8603993769517047	\N	0	1.001435	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-29T00:00:00.000Z	yearn-kong	1.5007302728520244	\N	0	1.001461	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-09-30T00:00:00.000Z	yearn-kong	1.5474761855927	\N	0	1.001564	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-01T00:00:00.000Z	yearn-kong	0	\N	0.728259	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-02T00:00:00.000Z	yearn-kong	0	\N	0.761025	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-03T00:00:00.000Z	yearn-kong	0	\N	0.72723117	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-04T00:00:00.000Z	yearn-kong	0	\N	0.734124	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-05T00:00:00.000Z	yearn-kong	0	\N	0.70973778	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-06T00:00:00.000Z	yearn-kong	0	\N	0.66658638	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-07T00:00:00.000Z	yearn-kong	0	\N	0.6825150000000001	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-08T00:00:00.000Z	yearn-kong	0	\N	0.6886601099999999	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-09T00:00:00.000Z	yearn-kong	0	\N	0.70740687	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-10T00:00:00.000Z	yearn-kong	0	\N	0.7168710000000001	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-11T00:00:00.000Z	yearn-kong	0	\N	0.701811	1	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-12T00:00:00.000Z	yearn-kong	0.013283550259757249	\N	0.70854906	1.000002545852787	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-13T00:00:00.000Z	yearn-kong	0.09425788789485523	\N	0.97723508	1.0000025467463862	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-14T00:00:00.000Z	yearn-kong	0.17462301684645354	\N	0.9673498799999999	1.0000180662121696	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-15T00:00:00.000Z	yearn-kong	0.2549846445987214	\N	0.9277565199999999	1.0000488691251137	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-16T00:00:00.000Z	yearn-kong	0.3353413706719266	\N	0.9181898	1.0000642723628614	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-17T00:00:00.000Z	yearn-kong	0.4157086003431232	\N	0.9368321599999999	1.000079676075111	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-18T00:00:00.000Z	yearn-kong	\N	\N	0.949832	1.00009507919216	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-19T00:00:00.000Z	yearn-kong	\N	\N	0.9858134	1.0001104838534491	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-20T00:00:00.000Z	yearn-kong	\N	\N	1.0246202	1.0001258886327107	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-21T00:00:00.000Z	yearn-kong	\N	\N	1.04535052	1.0001412945997579	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-22T00:00:00.000Z	yearn-kong	0.5519738778048122	\N	1.03336	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-23T00:00:00.000Z	yearn-kong	\N	\N	1.05913772	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-24T00:00:00.000Z	yearn-kong	\N	\N	1.06118244	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-25T00:00:00.000Z	yearn-kong	\N	\N	1.03167432	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-26T00:00:00.000Z	yearn-kong	0.23050846031935635	\N	1.05259424	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-27T00:00:00.000Z	yearn-kong	\N	\N	1.078344	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-28T00:00:00.000Z	yearn-kong	\N	\N	1.07187216	1.0001546679573616	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-29T00:00:00.000Z	yearn-kong	0.06434504129515517	\N	1.06364952	1.000167001958866	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-09-30T00:00:00.000Z	yearn-kong	\N	\N	1.04082776	1.0001670042155966	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-01T00:00:00.000Z	yearn-kong	0	\N	0.728259	1	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-02T00:00:00.000Z	yearn-kong	\N	\N	0.761025	1	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-03T00:00:00.000Z	yearn-kong	0	\N	0.72723117	1	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-04T00:00:00.000Z	yearn-kong	0	\N	0.734124	1.0000050591566547	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-05T00:00:00.000Z	yearn-kong	0.16526501127600568	\N	0.70973778	1.0000316747861688	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-06T00:00:00.000Z	yearn-kong	0.3041351810395554	\N	0.66658638	1.0000582924486332	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-07T00:00:00.000Z	yearn-kong	0.4430158544010965	\N	0.6825150000000001	1.0000849096795779	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-08T00:00:00.000Z	yearn-kong	0.5818916260835749	\N	0.6886601099999999	1.0000849109119188	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-09T00:00:00.000Z	yearn-kong	\N	\N	0.70740687	1.0001381483923102	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-10T00:00:00.000Z	yearn-kong	0.8596578744857197	\N	0.7168710000000001	1.0001647711068617	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-11T00:00:00.000Z	yearn-kong	\N	\N	0.701811	1.0001913958550934	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-12T00:00:00.000Z	yearn-kong	0.9721563106523945	\N	0.70854906	1.0002180201718815	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-13T00:00:00.000Z	yearn-kong	0.9721822195274399	\N	0.73292631	1.0002446465225108	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-14T00:00:00.000Z	yearn-kong	0.9458230902481546	\N	0.7255124099999999	1.0002662112073648	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-15T00:00:00.000Z	yearn-kong	0.8777149599126233	\N	0.69581739	1.0002797792326947	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-16T00:00:00.000Z	yearn-kong	1.0659737476714781	\N	0.6886423499999998	1.0003424956693785	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-17T00:00:00.000Z	yearn-kong	1.2542192308728772	\N	0.70262412	1.0004052185190853	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-18T00:00:00.000Z	yearn-kong	1.4424955246283844	\N	0.712374	1.000467946330586	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-19T00:00:00.000Z	yearn-kong	1.6307816217420168	\N	0.73936005	1.0005306834612913	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-20T00:00:00.000Z	yearn-kong	1.819089426291498	\N	0.76846515	1.0005934255556574	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-21T00:00:00.000Z	yearn-kong	1.8190978291698912	\N	0.78401289	1.000656182783003	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-22T00:00:00.000Z	yearn-kong	2.2902829329041197	\N	0.77502	1.0007189391657918	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-23T00:00:00.000Z	yearn-kong	2.2904264820766684	\N	0.79435329	1.0007817121390479	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-24T00:00:00.000Z	yearn-kong	2.290570031249217	\N	0.79588683	1.0008444857217738	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-25T00:00:00.000Z	yearn-kong	2.2198198958989224	\N	0.77375574	1.0008936835799442	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-26T00:00:00.000Z	yearn-kong	1.8927035426941075	\N	0.78944568	1.0008936835799442	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-27T00:00:00.000Z	yearn-kong	1.5655094628641564	\N	0.808758	1.0008936835799442	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-28T00:00:00.000Z	yearn-kong	1.238267766723311	\N	0.8039041200000001	1.0008936835799442	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-29T00:00:00.000Z	yearn-kong	0.9894655399023122	\N	0.79773714	1.000908728557184	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-09-30T00:00:00.000Z	yearn-kong	0.9722004257639583	\N	0.7806208199999999	1.0009681984977163	assets_per_share
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
