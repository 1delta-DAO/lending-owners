-- Generated from VAULT_LLAMA_LST/1/2026-08.ndjson (93 vault rows)
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
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-01T23:00:00.000Z	defillama-api	\N	\N	27901540	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-02T23:00:00.000Z	defillama-api	\N	\N	28420654	1.12719	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-03T23:00:00.000Z	defillama-api	\N	\N	28039666	1.12807	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-04T23:00:00.000Z	defillama-api	\N	\N	28198729	1.12815	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-05T23:00:00.000Z	defillama-api	\N	\N	28500446	1.12823	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-06T23:00:00.000Z	defillama-api	\N	\N	28303569	1.12823	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-07T23:00:00.000Z	defillama-api	\N	\N	28463492	1.12823	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-08T23:00:00.000Z	defillama-api	\N	\N	28573695	1.12823	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-09T23:00:00.000Z	defillama-api	\N	\N	28506069	1.12851	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-10T23:00:00.000Z	defillama-api	\N	\N	27902715	1.12858	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-11T23:00:00.000Z	defillama-api	\N	\N	27938306	1.12864	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-12T23:00:00.000Z	defillama-api	\N	\N	27890462	1.12871	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-13T23:00:00.000Z	defillama-api	\N	\N	28004098	1.12875	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-14T23:00:00.000Z	defillama-api	\N	\N	27750251	1.12875	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-15T23:00:00.000Z	defillama-api	\N	\N	27852214	1.12891	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-16T23:00:00.000Z	defillama-api	\N	\N	27664721	1.12896	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-17T23:00:00.000Z	defillama-api	\N	\N	28085188	1.12896	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-18T23:00:00.000Z	defillama-api	\N	\N	28395499	1.12896	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-19T23:00:00.000Z	defillama-api	\N	\N	33407484	1.12917	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-20T23:00:00.000Z	defillama-api	\N	\N	34320123	1.12923	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-21T23:00:00.000Z	defillama-api	\N	\N	37048538	1.12929	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-22T23:00:00.000Z	defillama-api	\N	\N	35506015	1.12934	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-23T23:00:00.000Z	defillama-api	\N	\N	35993531	1.12941	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-24T23:00:00.000Z	defillama-api	\N	\N	36264576	1.12948	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-25T23:00:00.000Z	defillama-api	\N	\N	35843743	1.12955	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-26T23:00:00.000Z	defillama-api	\N	\N	36422859	1.12961	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-27T23:00:00.000Z	defillama-api	\N	\N	36725000	1.12969	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-28T23:00:00.000Z	defillama-api	\N	\N	35595872	1.12974	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-29T23:00:00.000Z	defillama-api	\N	\N	35713927	1.12977	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-30T23:00:00.000Z	defillama-api	\N	\N	35962373	1.12987	assets_per_share
VAULT_LLAMA_LST	1	0xf951e335afb289353dc249e82926178eac7ded78	2026-08-31T23:00:00.000Z	defillama-api	\N	\N	35991177	1.12993	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-01T23:00:00.000Z	defillama-api	2.297328046196867	\N	589686154	1.11421	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-02T23:00:00.000Z	defillama-api	2.297572429910133	\N	600710900	1.11433	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-03T23:00:00.000Z	defillama-api	2.297572429910133	\N	593559547	1.11433	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-04T23:00:00.000Z	defillama-api	2.2978266169815242	\N	598553520	1.11445	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-05T23:00:00.000Z	defillama-api	2.2980808040529155	\N	608799198	1.11458	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-06T23:00:00.000Z	defillama-api	2.2980808040529155	\N	608191220	1.11458	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-07T23:00:00.000Z	defillama-api	2.2983349911243067	\N	611350696	1.1147	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-08T23:00:00.000Z	defillama-api	2.2983349911243067	\N	612048970	1.1147	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-09T23:00:00.000Z	defillama-api	2.298589178195698	\N	612930700	1.11483	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-10T23:00:00.000Z	defillama-api	2.298589178195698	\N	598893277	1.11483	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-11T23:00:00.000Z	defillama-api	2.298842665027223	\N	601081999	1.11495	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-12T23:00:00.000Z	defillama-api	2.2990968520986144	\N	599462435	1.11508	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-13T23:00:00.000Z	defillama-api	2.2990968520986144	\N	603321886	1.11508	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-14T23:00:00.000Z	defillama-api	2.2993510391700056	\N	600283389	1.1152	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-15T22:00:00.000Z	defillama-api	2.2993510391700056	\N	602039395	1.1152	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-16T23:00:00.000Z	defillama-api	2.299605226241397	\N	599074680	1.11532	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-17T23:00:00.000Z	defillama-api	2.299605226241397	\N	608324887	1.11532	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-18T22:00:00.000Z	defillama-api	2.299859413312788	\N	610930087	1.11545	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-19T23:00:00.000Z	defillama-api	1.7298319512804028	\N	719056196	1.11545	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-20T23:00:00.000Z	defillama-api	2.3001136003841793	\N	740016643	1.11557	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-21T23:00:00.000Z	defillama-api	2.3003677874555706	\N	806404639	1.1157	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-22T23:00:00.000Z	defillama-api	2.3003677874555706	\N	771583172	1.1157	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-23T23:00:00.000Z	defillama-api	2.3006212742870957	\N	784776792	1.11582	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-24T23:00:00.000Z	defillama-api	2.3006212742870957	\N	791217820	1.11582	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-25T23:00:00.000Z	defillama-api	2.300875461358487	\N	784916256	1.11595	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-26T23:00:00.000Z	defillama-api	2.8682301078220007	\N	797671524	1.11607	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-27T23:00:00.000Z	defillama-api	2.301129648429878	\N	804709820	1.11607	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-28T23:00:00.000Z	defillama-api	2.3013838355012695	\N	781497909	1.1162	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-29T23:00:00.000Z	defillama-api	2.3013838355012695	\N	784908767	1.1162	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-30T23:00:00.000Z	defillama-api	2.3016380225726607	\N	790781145	1.11632	assets_per_share
VAULT_LLAMA_LST	1	0x8c1bed5b9a0928467c9b1341da1d7bd5e10b6549	2026-08-31T23:00:00.000Z	defillama-api	2.3016380225726607	\N	790092430	1.11632	assets_per_share
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-01T23:00:00.000Z	defillama-api	2.384180897507804	\N	18943864	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-02T23:00:00.000Z	defillama-api	2.384503708086072	\N	19311776	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-03T23:00:00.000Z	defillama-api	2.3813491274893295	\N	19061249	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-04T23:00:00.000Z	defillama-api	2.3809885039582923	\N	19216919	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-05T23:00:00.000Z	defillama-api	2.37804889700044	\N	19578400	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-06T23:00:00.000Z	defillama-api	2.3788884845998837	\N	19508982	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-07T23:00:00.000Z	defillama-api	2.3752563404144666	\N	19671042	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-08T23:00:00.000Z	defillama-api	1.8541343308697833	\N	19605728	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-09T23:00:00.000Z	defillama-api	2.306113955796718	\N	19573155	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-10T23:00:00.000Z	defillama-api	2.3088007761629115	\N	19126833	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-11T23:00:00.000Z	defillama-api	2.3159341196787864	\N	19301886	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-12T23:00:00.000Z	defillama-api	2.3181909927671995	\N	19268536	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-13T23:00:00.000Z	defillama-api	2.31694036436636	\N	19340092	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-14T23:00:00.000Z	defillama-api	2.3172820814210127	\N	19290032	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-15T23:00:00.000Z	defillama-api	2.3171063212146237	\N	19342571	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-16T23:00:00.000Z	defillama-api	2.3214933239756874	\N	19377226	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-17T23:00:00.000Z	defillama-api	2.3199499953108216	\N	19543428	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-18T23:00:00.000Z	defillama-api	2.3196958082394303	\N	19586733	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-19T23:00:00.000Z	defillama-api	2.321063376697907	\N	23446584	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-20T23:00:00.000Z	defillama-api	2.3278543029192633	\N	23646779	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-21T23:00:00.000Z	defillama-api	2.3331299100703973	\N	25202985	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-22T23:00:00.000Z	defillama-api	2.66205078141013	\N	24686031	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-23T23:00:00.000Z	defillama-api	2.07950793225109	\N	25121165	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-24T23:00:00.000Z	defillama-api	2.6135668733218154	\N	25527564	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-25T23:00:00.000Z	defillama-api	2.61721022134509	\N	25200964	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-26T23:00:00.000Z	defillama-api	2.6151060005474847	\N	25633134	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-27T23:00:00.000Z	defillama-api	2.6145605136917993	\N	25815918	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-28T23:00:00.000Z	defillama-api	2.62432115718525	\N	24905560	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-29T23:00:00.000Z	defillama-api	2.6274288217109643	\N	24999184	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-30T23:00:00.000Z	defillama-api	2.628948342220383	\N	25170034	\N	\N
VAULT_LLAMA_LST	1	0xf1376bcef0f78459c0ed0ba5ddce976f1ddf51f4	2026-08-31T23:00:00.000Z	defillama-api	2.5432438842898364	\N	25212601	\N	\N
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
