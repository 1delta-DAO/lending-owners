-- Generated from VAULT_YEARN/8453/2024-10.ndjson (114 vault rows)
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
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-03T00:00:00.000Z	yearn-kong	0.9024222233477985	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-04T00:00:00.000Z	yearn-kong	0.9024369283849865	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-11T00:00:00.000Z	yearn-kong	1.0169709618423894	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-12T00:00:00.000Z	yearn-kong	1.01697446304172	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-14T00:00:00.000Z	yearn-kong	0.9386575356984395	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-16T00:00:00.000Z	yearn-kong	0.9698973368443831	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-17T00:00:00.000Z	yearn-kong	1.0428770359283135	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-18T00:00:00.000Z	yearn-kong	1.0428413236951428	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-19T00:00:00.000Z	yearn-kong	1.042811913620767	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-20T00:00:00.000Z	yearn-kong	0.9645867176999445	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-21T00:00:00.000Z	yearn-kong	0.8759293482540897	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-22T00:00:00.000Z	yearn-kong	1.0427222829179073	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-23T00:00:00.000Z	yearn-kong	1.214701894269865	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-24T00:00:00.000Z	yearn-kong	1.3814885267748878	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-25T00:00:00.000Z	yearn-kong	1.5377904677649212	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-26T00:00:00.000Z	yearn-kong	1.704554692594229	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-27T00:00:00.000Z	yearn-kong	1.9390426160725838	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-28T00:00:00.000Z	yearn-kong	2.1943906851618067	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-29T00:00:00.000Z	yearn-kong	2.147352072157105	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-30T00:00:00.000Z	yearn-kong	2.048217713834788	\N	0	\N	\N
VAULT_YEARN	8453	0xd80c675366966ef42b175125bbf1acb1db4151ac	2024-10-31T00:00:00.000Z	yearn-kong	1.9073847717265835	\N	17.008382718500002	\N	\N
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-01T00:00:00.000Z	yearn-kong	1.5890088125303237	\N	0	1.001666	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-02T00:00:00.000Z	yearn-kong	1.7399294101494434	\N	0	1.001769	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-03T00:00:00.000Z	yearn-kong	2.2763852722818	\N	0	1.001872	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-04T00:00:00.000Z	yearn-kong	2.8075634265434246	\N	0	1.001872	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-05T00:00:00.000Z	yearn-kong	3.343923355814127	\N	0	1.002077	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-06T00:00:00.000Z	yearn-kong	3.7447329525264195	\N	0	1.00218	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-07T00:00:00.000Z	yearn-kong	3.739154141513268	\N	0	1.00218	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-08T00:00:00.000Z	yearn-kong	3.743978794190639	\N	0	1.002385	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-09T00:00:00.000Z	yearn-kong	3.608195981996687	\N	0	1.002462	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-10T00:00:00.000Z	yearn-kong	3.6807492350021676	\N	0	1.002578	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-11T00:00:00.000Z	yearn-kong	4.283975069085955	\N	0	1.002797	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-12T00:00:00.000Z	yearn-kong	4.887006936726834	\N	0	1.003016	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-13T00:00:00.000Z	yearn-kong	5.489826631688288	\N	0	1.003235	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-14T00:00:00.000Z	yearn-kong	5.489753806742215	\N	0	1.003454	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-15T00:00:00.000Z	yearn-kong	6.700145724636286	\N	0	1.003673	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-16T00:00:00.000Z	yearn-kong	7.442902054677347	\N	0	1.003893	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-17T00:00:00.000Z	yearn-kong	7.442902054677347	\N	0	1.004112	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-18T00:00:00.000Z	yearn-kong	7.9755843241713364	\N	0	1.004327	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-19T00:00:00.000Z	yearn-kong	7.9790379071909	\N	0	1.004547	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-20T00:00:00.000Z	yearn-kong	7.395701686263578	\N	0	1.004654	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-21T00:00:00.000Z	yearn-kong	6.402216069290034	\N	0	1.004682	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-22T00:00:00.000Z	yearn-kong	6.089233357542412	\N	0	1.004841	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-23T00:00:00.000Z	yearn-kong	5.776353581055105	\N	0	1.005	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-24T00:00:00.000Z	yearn-kong	5.458527310153727	\N	0	1.005159	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-25T00:00:00.000Z	yearn-kong	5.151113606061131	\N	0	1.005319	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-26T00:00:00.000Z	yearn-kong	4.833465896325606	\N	0	1.005478	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-27T00:00:00.000Z	yearn-kong	5.102758542108177	\N	0	1.005637	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-28T00:00:00.000Z	yearn-kong	5.787449581973192	\N	0	1.005797	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-29T00:00:00.000Z	yearn-kong	5.786495855275575	\N	0	1.005956	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-30T00:00:00.000Z	yearn-kong	5.790786224935118	\N	0	1.006116	assets_per_share
VAULT_YEARN	8453	0xb3f14e3fda2147fa7574fd003ba40df266e0b90c	2024-10-31T00:00:00.000Z	yearn-kong	5.649793628137445	\N	0	1.006248	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-01T00:00:00.000Z	yearn-kong	\N	\N	1.22445315	1.0002629942687875	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-02T00:00:00.000Z	yearn-kong	\N	\N	1.18347425	1.0003050108664318	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-03T00:00:00.000Z	yearn-kong	1.0034206201936513	\N	1.17484615	1.0003470261306648	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-04T00:00:00.000Z	yearn-kong	1.0034423276295001	\N	1.448934	1.0003854026314019	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-05T00:00:00.000Z	yearn-kong	\N	\N	1.449522	1.0004199462908867	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-06T00:00:00.000Z	yearn-kong	\N	\N	1.4634064199999999	1.0004544891373923	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-07T00:00:00.000Z	yearn-kong	\N	\N	1.6957940299999998	1.0004544923360632	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-08T00:00:00.000Z	yearn-kong	\N	\N	1.70991023	1.0005234933056657	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-09T00:00:00.000Z	yearn-kong	\N	\N	1.6573111799999998	1.0005492462177263	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-10T00:00:00.000Z	yearn-kong	\N	\N	1.6687509999999999	1.0005653058560442	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-11T00:00:00.000Z	yearn-kong	1.0956282057605904	\N	1.7037712299999999	1.000595486404048	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-12T00:00:00.000Z	yearn-kong	1.095625404801126	\N	1.7354855	1.000625671567751	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-13T00:00:00.000Z	yearn-kong	1.0500790029510654	\N	1.7259970000000002	1.000655858552713	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-14T00:00:00.000Z	yearn-kong	1.0274304447221994	\N	1.840482	1.000686045262637	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-15T00:00:00.000Z	yearn-kong	1.0050598817201717	\N	1.82432271	1.0007162358904842	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-16T00:00:00.000Z	yearn-kong	1.028177600659319	\N	1.82846286	1.0007464283400844	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-17T00:00:00.000Z	yearn-kong	1.1018589400890733	\N	1.8213972	1.0007766226116015	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-18T00:00:00.000Z	yearn-kong	1.1018911511229135	\N	1.8492389999999999	1.000806211284515	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-19T00:00:00.000Z	yearn-kong	1.1019247626364859	\N	1.85507476	1.0008364119598265	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-20T00:00:00.000Z	yearn-kong	1.0213621660426497	\N	1.92020409	1.0008511449307915	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-21T00:00:00.000Z	yearn-kong	0.8841270563664239	\N	1.866872	1.000855022826699	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-22T00:00:00.000Z	yearn-kong	0.8437113120152162	\N	1.8330837	1.0008774674213559	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-23T00:00:00.000Z	yearn-kong	0.8032752607078919	\N	1.76523655	1.000899904710285	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-24T00:00:00.000Z	yearn-kong	0.7628777225932026	\N	1.7727762500000002	1.0009223497593525	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-25T00:00:00.000Z	yearn-kong	0.722416462650699	\N	1.7077682999999997	1.0009448015303934	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-26T00:00:00.000Z	yearn-kong	0.6820154233366793	\N	1.7362100000000003	1.0009672475539482	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-27T00:00:00.000Z	yearn-kong	0.7221993882922106	\N	1.7549139999999999	1.0009896857507037	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-28T00:00:00.000Z	yearn-kong	0.8190229550564254	\N	1.79763227	1.0010121332677278	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-29T00:00:00.000Z	yearn-kong	0.8190411612929438	\N	1.84684549	1.001034597901188	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-30T00:00:00.000Z	yearn-kong	0.8190593675294622	\N	1.8595514	1.0010570240466252	assets_per_share
VAULT_YEARN	8453	0x630db4ae19219025df594c943b638b5acb5e9d18	2024-10-31T00:00:00.000Z	yearn-kong	0.7749799681988634	\N	119.82919199999999	1.001071018028386	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-01T00:00:00.000Z	yearn-kong	0.9549304099465417	\N	0.73467189	1.0010276755055942	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-02T00:00:00.000Z	yearn-kong	1.0084749515471003	\N	0.7100845499999999	1.001087156828085	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-03T00:00:00.000Z	yearn-kong	1.3185481666511123	\N	0.70490769	1.001146645219787	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-04T00:00:00.000Z	yearn-kong	1.6286024752787398	\N	0.724467	1.0011466493512657	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-05T00:00:00.000Z	yearn-kong	1.9387219062139138	\N	0.724761	1.0012656445933543	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-06T00:00:00.000Z	yearn-kong	2.1703948654305805	\N	0.7317032099999999	1.001325155578066	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-07T00:00:00.000Z	yearn-kong	2.1705244098058074	\N	0.72676887	1.0013251610886706	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-08T00:00:00.000Z	yearn-kong	2.1705244098058074	\N	0.73281867	1.0014441987724991	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-09T00:00:00.000Z	yearn-kong	2.0922635016518143	\N	0.7102762199999999	1.001488669493083	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-10T00:00:00.000Z	yearn-kong	1.9048295964552153	\N	0.7151789999999999	1.0015121972865295	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-11T00:00:00.000Z	yearn-kong	1.8251415994541276	\N	0.7301876700000001	1.00155641942733	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-12T00:00:00.000Z	yearn-kong	1.745454302692906	\N	0.7437795	1.001600648545053	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-13T00:00:00.000Z	yearn-kong	1.6657565023336929	\N	0.7397130000000001	1.001644878497567	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-14T00:00:00.000Z	yearn-kong	1.6657074855430665	\N	0.7887780000000001	1.0016891123565779	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-15T00:00:00.000Z	yearn-kong	1.5063335922604892	\N	0.78185259	1.0017333531948778	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-16T00:00:00.000Z	yearn-kong	1.5050829638596497	\N	0.7836269400000001	1.0017775969170712	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-17T00:00:00.000Z	yearn-kong	1.6129570159506557	\N	0.7805988	1.0018218424991323	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-18T00:00:00.000Z	yearn-kong	1.6130270399372648	\N	0.792645	1.0018651997706267	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-19T00:00:00.000Z	yearn-kong	1.6130984644036062	\N	0.79503204	1.0019094643604858	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-20T00:00:00.000Z	yearn-kong	1.4951787711936504	\N	0.8229446100000001	1.0019310561637784	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-21T00:00:00.000Z	yearn-kong	1.3243230448267695	\N	0.800088	1.0019425090083578	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-22T00:00:00.000Z	yearn-kong	1.43905104472708	\N	0.7856072999999999	1.0020087810902043	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-23T00:00:00.000Z	yearn-kong	1.5537454331138179	\N	0.7565299500000001	1.0020750650088384	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-24T00:00:00.000Z	yearn-kong	1.6685448574804695	\N	0.7597612499999999	1.0021413684413736	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-25T00:00:00.000Z	yearn-kong	1.7833484832863178	\N	0.7319007	1.002207706744176	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-26T00:00:00.000Z	yearn-kong	1.8981163968589954	\N	0.7443991799999999	1.00227401544933	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-27T00:00:00.000Z	yearn-kong	2.130858622351184	\N	0.75227091	1.0023403175749643	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-28T00:00:00.000Z	yearn-kong	2.4166363150612824	\N	0.7704138300000001	1.0024066515078482	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-29T00:00:00.000Z	yearn-kong	2.4167966699906174	\N	0.79150521	1.0024730495116823	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-30T00:00:00.000Z	yearn-kong	2.4169563246800863	\N	0.7969506	1.0025393318921407	assets_per_share
VAULT_YEARN	8453	0x81bdd5e8fbde5a85a2d38761d03d2307fe69a329	2024-10-31T00:00:00.000Z	yearn-kong	2.357619398907218	\N	0.7555573199999999	1.0025942641006549	assets_per_share
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
