-- Generated from VAULT_LLAMA/8453/2026-07.ndjson (151 vault rows)
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
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-01T23:00:00.000Z	defillama-api	\N	\N	905372	1.12494	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-02T23:00:00.000Z	defillama-api	78.14087233590783	\N	883843	1.14193	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-03T23:00:00.000Z	defillama-api	78.14087233590783	\N	892126	1.14193	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-04T23:00:00.000Z	defillama-api	78.14087233590783	\N	877535	1.14193	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-05T23:00:00.000Z	defillama-api	78.14087233590783	\N	867600	1.14193	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-06T23:00:00.000Z	defillama-api	88.02102436682446	\N	846940	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-07T23:00:00.000Z	defillama-api	88.02102436682446	\N	929599	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-08T23:00:00.000Z	defillama-api	88.02102436682446	\N	836348	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-09T23:00:00.000Z	defillama-api	9.880153431396366	\N	815178	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-10T23:00:00.000Z	defillama-api	9.880153431396366	\N	854509	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-11T23:00:00.000Z	defillama-api	9.880153431396366	\N	820656	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-12T23:00:00.000Z	defillama-api	9.880153431396366	\N	779117	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-13T22:00:00.000Z	defillama-api	\N	\N	822128	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-14T23:00:00.000Z	defillama-api	\N	\N	857078	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-15T23:00:00.000Z	defillama-api	\N	\N	874192	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-16T23:00:00.000Z	defillama-api	\N	\N	855396	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-17T23:00:00.000Z	defillama-api	\N	\N	818166	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-18T23:00:00.000Z	defillama-api	\N	\N	869648	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-19T23:00:00.000Z	defillama-api	\N	\N	850412	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-20T23:00:00.000Z	defillama-api	\N	\N	820943	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-21T23:00:00.000Z	defillama-api	\N	\N	816211	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-22T23:00:00.000Z	defillama-api	\N	\N	820744	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-23T23:00:00.000Z	defillama-api	\N	\N	858404	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-24T23:00:00.000Z	defillama-api	\N	\N	838799	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-25T23:00:00.000Z	defillama-api	\N	\N	825761	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-26T23:00:00.000Z	defillama-api	\N	\N	830777	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-27T19:00:00.000Z	defillama-api	\N	\N	907621	1.14409	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-28T14:00:00.000Z	defillama-api	18.337266802603835	\N	842191	1.14812	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-30T23:00:00.000Z	defillama-api	18.337266802603835	\N	956061	1.14812	assets_per_share
VAULT_LLAMA	8453	0x2c71f70e2ec720ae061ae7e0316fc9654d94f417	2026-07-31T23:00:00.000Z	defillama-api	18.337266802603835	\N	914951	1.14812	assets_per_share
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-01T23:00:00.000Z	defillama-api	1.5576254622118313	\N	153133	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-02T23:00:00.000Z	defillama-api	1.6400471956501406	\N	155896	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-03T23:00:00.000Z	defillama-api	1.632128183004511	\N	158593	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-04T23:00:00.000Z	defillama-api	1.571723391435853	\N	160232	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-05T23:00:00.000Z	defillama-api	1.4430179035684887	\N	304112	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-06T23:00:00.000Z	defillama-api	1.451179199207786	\N	254365	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-07T23:00:00.000Z	defillama-api	1.5970489666727872	\N	340978	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-08T23:00:00.000Z	defillama-api	1.764333469722601	\N	322832	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-09T23:00:00.000Z	defillama-api	1.7227252168794394	\N	313392	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-10T23:00:00.000Z	defillama-api	1.8590815255237203	\N	346624	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-11T23:00:00.000Z	defillama-api	1.7873118409283961	\N	363390	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-12T23:00:00.000Z	defillama-api	1.7200124876382006	\N	361511	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-13T22:00:00.000Z	defillama-api	1.7847972795692613	\N	351317	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-14T23:00:00.000Z	defillama-api	1.752886648631602	\N	373808	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-15T23:00:00.000Z	defillama-api	1.8065236218944847	\N	378764	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-16T23:00:00.000Z	defillama-api	1.7708968179874773	\N	373346	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-17T23:00:00.000Z	defillama-api	1.7265492267881655	\N	363801	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-18T23:00:00.000Z	defillama-api	1.798313309464561	\N	349648	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-19T23:00:00.000Z	defillama-api	1.8407142338361382	\N	361112	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-20T23:00:00.000Z	defillama-api	1.6993295027134536	\N	361905	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-21T23:00:00.000Z	defillama-api	1.6789364170932686	\N	377440	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-22T23:00:00.000Z	defillama-api	1.6894484179630354	\N	376109	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-23T23:00:00.000Z	defillama-api	1.7878328193887683	\N	371158	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-24T23:00:00.000Z	defillama-api	1.7642452394994734	\N	359355	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-25T23:00:00.000Z	defillama-api	1.7429817557257365	\N	360771	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-26T23:00:00.000Z	defillama-api	1.7559130853328497	\N	366538	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-27T23:00:00.000Z	defillama-api	1.9279746247491403	\N	358204	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-28T14:00:00.000Z	defillama-api	1.8320060508614233	\N	353375	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-30T23:00:00.000Z	defillama-api	0.8086615057578683	\N	368179	\N	\N
VAULT_LLAMA	8453	0xfc8a6526ffcd8248b8d0f8dac8037dbe438924ce	2026-07-31T23:00:00.000Z	defillama-api	0.8112804028570508	\N	357564	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-01T23:00:00.000Z	defillama-api	5.410591689880562	\N	1744823	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-02T23:00:00.000Z	defillama-api	5.59912217070746	\N	1778668	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-03T23:00:00.000Z	defillama-api	5.691742897795393	\N	1895567	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-04T23:00:00.000Z	defillama-api	5.638307593613945	\N	1915607	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-05T23:00:00.000Z	defillama-api	5.5622391364806845	\N	1898860	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-06T23:00:00.000Z	defillama-api	5.579680010825427	\N	2025852	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-07T23:00:00.000Z	defillama-api	5.692215559705005	\N	2035961	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-08T23:00:00.000Z	defillama-api	5.491848924421561	\N	1929505	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-09T23:00:00.000Z	defillama-api	5.442028258428877	\N	2122758	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-10T23:00:00.000Z	defillama-api	5.565994522882534	\N	2190736	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-11T23:00:00.000Z	defillama-api	5.583339464365622	\N	2200769	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-12T23:00:00.000Z	defillama-api	5.454348978872758	\N	2217745	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-13T22:00:00.000Z	defillama-api	5.454206830179942	\N	2087504	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-14T23:00:00.000Z	defillama-api	5.787383059185913	\N	1203313	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-15T23:00:00.000Z	defillama-api	5.948467638461352	\N	1167565	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-16T23:00:00.000Z	defillama-api	5.929432317941519	\N	1034610	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-17T23:00:00.000Z	defillama-api	5.9042285844412845	\N	1015814	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-18T23:00:00.000Z	defillama-api	6.069050343882054	\N	1016730	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-19T23:00:00.000Z	defillama-api	6.22706997326361	\N	1016401	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-20T23:00:00.000Z	defillama-api	6.194431793105082	\N	1012837	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-21T23:00:00.000Z	defillama-api	6.231411460433378	\N	1007746	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-22T23:00:00.000Z	defillama-api	6.23838234830032	\N	1000467	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-23T23:00:00.000Z	defillama-api	6.349419383866461	\N	996993	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-24T23:00:00.000Z	defillama-api	6.3044751883012395	\N	973169	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-25T23:00:00.000Z	defillama-api	6.310793452612984	\N	963653	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-26T23:00:00.000Z	defillama-api	6.363401773512578	\N	929465	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-27T23:00:00.000Z	defillama-api	6.552159832295956	\N	929813	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-28T14:00:00.000Z	defillama-api	6.352760228267584	\N	915486	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-30T23:00:00.000Z	defillama-api	5.9097716832212654	\N	1134765	\N	\N
VAULT_LLAMA	8453	0x11820afe50ea96851ee2bdbae329d97771e41ec6	2026-07-31T23:00:00.000Z	defillama-api	5.775282914299851	\N	1127448	\N	\N
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-01T23:00:00.000Z	defillama-api	2.476548838004078	\N	615190	1.00521	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-02T23:00:00.000Z	defillama-api	3.0567325790542554	\N	473877	1.00524	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-03T23:00:00.000Z	defillama-api	3.128391625750737	\N	285185	1.00527	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-04T23:00:00.000Z	defillama-api	3.0600300085836807	\N	286494	1.0053	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-05T23:00:00.000Z	defillama-api	3.008021793249327	\N	287255	1.00534	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-06T23:00:00.000Z	defillama-api	3.0454321080952695	\N	289970	1.00537	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-07T23:00:00.000Z	defillama-api	3.252710811096904	\N	285228	1.0054	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-08T23:00:00.000Z	defillama-api	3.1150352505449064	\N	278506	1.00544	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-09T23:00:00.000Z	defillama-api	3.091419661060968	\N	278955	1.00547	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-10T23:00:00.000Z	defillama-api	3.234559193288078	\N	286473	1.0055	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-11T23:00:00.000Z	defillama-api	3.144333286542178	\N	289228	1.00553	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-12T23:00:00.000Z	defillama-api	3.0678271794926104	\N	287760	1.00557	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-13T22:00:00.000Z	defillama-api	3.093998644487783	\N	280471	1.0056	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-14T23:00:00.000Z	defillama-api	3.036896184127613	\N	300418	1.00563	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-15T23:00:00.000Z	defillama-api	3.06817659918579	\N	309290	1.00567	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-16T23:00:00.000Z	defillama-api	3.062891188676531	\N	298566	1.0057	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-17T23:00:00.000Z	defillama-api	3.0068572943520167	\N	295699	1.00574	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-18T23:00:00.000Z	defillama-api	3.0601756584758277	\N	299643	1.00577	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-19T23:00:00.000Z	defillama-api	3.1064559117055524	\N	304329	1.0058	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-20T23:00:00.000Z	defillama-api	3.0100307814251437	\N	290401	1.00584	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-21T23:00:00.000Z	defillama-api	3.0844963895049204	\N	293442	1.00588	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-22T23:00:00.000Z	defillama-api	3.0894897999900195	\N	301340	1.00591	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-23T23:00:00.000Z	defillama-api	3.2104296277424282	\N	293615	1.00595	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-24T23:00:00.000Z	defillama-api	3.1679852884991533	\N	290763	1.00598	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-25T23:00:00.000Z	defillama-api	3.1567849518410185	\N	292796	1.00602	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-26T23:00:00.000Z	defillama-api	3.1268798078798454	\N	303721	1.00605	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-27T23:00:00.000Z	defillama-api	3.2779341513133886	\N	295985	1.00608	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-28T14:00:00.000Z	defillama-api	3.192474077096108	\N	292512	1.0061	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-30T23:00:00.000Z	defillama-api	2.671203616699813	\N	289695	1.00619	assets_per_share
VAULT_LLAMA	8453	0x0e70c10fa06931f7b878653a15aecc86145c1af7	2026-07-31T23:00:00.000Z	defillama-api	2.714930095137902	\N	280824	1.00622	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-01T23:00:00.000Z	defillama-api	5.4285514419660785	\N	506909	1.00259	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-02T23:00:00.000Z	defillama-api	6.378113813099162	\N	512570	1.0029	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-03T23:00:00.000Z	defillama-api	6.624559732770763	\N	517636	1.00311	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-04T23:00:00.000Z	defillama-api	7.362242124742124	\N	522078	1.00331	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-05T23:00:00.000Z	defillama-api	6.458429925260134	\N	526652	1.00349	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-06T23:00:00.000Z	defillama-api	6.0093653988957385	\N	526189	1.00365	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-07T23:00:00.000Z	defillama-api	6.1096698580342945	\N	527892	1.00382	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-08T23:00:00.000Z	defillama-api	7.491635948397857	\N	582442	1.00399	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-09T23:00:00.000Z	defillama-api	7.323113421264793	\N	628485	1.00418	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-10T23:00:00.000Z	defillama-api	6.678107075330786	\N	597494	1.00435	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-11T23:00:00.000Z	defillama-api	6.7700891836608434	\N	747243	1.00452	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-12T23:00:00.000Z	defillama-api	6.5236180553540635	\N	759352	1.00468	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-13T23:00:00.000Z	defillama-api	6.947074109575624	\N	722795	1.00484	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-14T23:00:00.000Z	defillama-api	6.657478709115594	\N	738567	1.005	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-15T23:00:00.000Z	defillama-api	7.257979209640553	\N	762728	1.00517	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-16T23:00:00.000Z	defillama-api	6.752107023899612	\N	752090	1.00533	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-17T23:00:00.000Z	defillama-api	6.970869660705148	\N	782236	1.00549	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-18T23:00:00.000Z	defillama-api	5.93352241899936	\N	784193	1.00564	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-19T23:00:00.000Z	defillama-api	5.825098678613472	\N	784103	1.00578	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-20T23:00:00.000Z	defillama-api	6.264910935627199	\N	785959	1.00593	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-21T23:00:00.000Z	defillama-api	6.3364208312322035	\N	786381	1.00608	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-22T23:00:00.000Z	defillama-api	5.766730884815274	\N	786543	1.00623	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-23T23:00:00.000Z	defillama-api	6.4868778700599705	\N	839107	1.00638	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-24T23:00:00.000Z	defillama-api	6.234126290394215	\N	843427	1.00649	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-25T23:00:00.000Z	defillama-api	6.0070868183714765	\N	842457	1.00663	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-26T22:00:00.000Z	defillama-api	6.024064133924867	\N	842676	1.00675	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-27T23:00:00.000Z	defillama-api	6.534644732525408	\N	842634	1.00688	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-28T23:00:00.000Z	defillama-api	6.576929417079214	\N	840901	1.00709	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-29T23:00:00.000Z	defillama-api	7.602448907206849	\N	734522	1.0074	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-30T23:00:00.000Z	defillama-api	7.853868630647298	\N	736038	1.00765	assets_per_share
VAULT_LLAMA	8453	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-07-31T23:00:00.000Z	defillama-api	7.266971690000901	\N	736162	1.00786	assets_per_share
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
