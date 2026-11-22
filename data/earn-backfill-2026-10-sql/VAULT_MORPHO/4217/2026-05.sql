-- Generated from VAULT_MORPHO/4217/2026-05.ndjson (118 vault rows)
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
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-07T00:00:00.000Z	morpho-api	\N	\N	1.999830585093333	1.998023976001998	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-08T00:00:00.000Z	morpho-api	2.1534105474785292	\N	2.000337468043237	1.998141858001998	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-09T00:00:00.000Z	morpho-api	2.1532838040627666	\N	2.0002603787811406	1.998259740001998	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-10T00:00:00.000Z	morpho-api	2.153156360407138	\N	2.0005741499857312	1.998377622001998	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-11T00:00:00.000Z	morpho-api	2.1530296169913754	\N	2.0004488878472433	1.998495504001998	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-12T00:00:00.000Z	morpho-api	1.3027521557518185	\N	9.049166335573311	1.998566835254132	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-13T00:00:00.000Z	morpho-api	3.1840368869495705	\N	413.0101423137031	1.998741185613498	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-14T00:00:00.000Z	morpho-api	0.08759720628859213	\N	431.46605893978125	1.998745982455894	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-15T00:00:00.000Z	morpho-api	0.1301661882280314	\N	444.56601624135925	1.998753110406443	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-16T00:00:00.000Z	morpho-api	0.10364250258021457	\N	447.43358872990797	1.998758785901355	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-17T00:00:00.000Z	morpho-api	0.09860637746328393	\N	447.47643004116196	1.99876418566118	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-18T00:00:00.000Z	morpho-api	0.0984432215744846	\N	447.47651522928743	1.9987695764884	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-19T00:00:00.000Z	morpho-api	0.07550336356132448	\N	5746.276671139596	1.99877371110607	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-20T00:00:00.000Z	morpho-api	3.633948703551937	\N	2005504.5531500604	1.998785239803447	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-21T00:00:00.000Z	morpho-api	3.454323873341991	\N	2008026.4520167103	1.998786592245786	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-22T00:00:00.000Z	morpho-api	3.458044947990402	\N	2009688.875470668	1.998788155108178	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-23T00:00:00.000Z	morpho-api	3.4355609461300674	\N	2019532.2413977906	1.998789152916477	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-24T00:00:00.000Z	morpho-api	3.3617913764771856	\N	2014396.0694318325	1.998789735312959	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-25T00:00:00.000Z	morpho-api	3.29771872848994	\N	2014511.6279170793	1.998790592653093	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-26T00:00:00.000Z	morpho-api	3.3459631545440516	\N	2062706.350361773	1.998791443058742	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-27T00:00:00.000Z	morpho-api	3.339213542474795	\N	2068000.1845611897	1.998792293194134	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-28T00:00:00.000Z	morpho-api	3.337716429641091	\N	2070122.2597097817	1.998793070369862	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-29T00:00:00.000Z	morpho-api	3.33391482740808	\N	2072412.9547464321	1.998793764700453	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-30T00:00:00.000Z	morpho-api	3.3329568992712666	\N	2080566.286303882	1.998794378262752	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-05-31T00:00:00.000Z	morpho-api	3.3387289764874595	\N	2075405.728102668	1.998794884180441	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-01T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-02T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-03T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-04T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-05T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-06T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-07T00:00:00.000Z	morpho-api	25263.491520852454	\N	0.9999047935568329	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-08T00:00:00.000Z	morpho-api	0	\N	1.0000992271948352	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-09T00:00:00.000Z	morpho-api	0	\N	1.000001689301995	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-10T00:00:00.000Z	morpho-api	0	\N	1.000099556513538	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-11T00:00:00.000Z	morpho-api	0	\N	0.9999779496055382	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-12T00:00:00.000Z	morpho-api	0	\N	0.9999996004874746	1.998001998001998	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-13T00:00:00.000Z	morpho-api	1.0584825815840304	\N	0.9999330193228463	1.998059939944056	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-14T00:00:00.000Z	morpho-api	2.737312562217653	\N	0.999907676948718	1.998209789794206	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-15T00:00:00.000Z	morpho-api	1.4963110590571205	\N	0.9999508625119523	1.998291707712288	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-16T00:00:00.000Z	morpho-api	0.07298950244205571	\N	0.9999553581773581	1.998295703708292	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-17T00:00:00.000Z	morpho-api	0.07298880220218962	\N	1.0000504009998854	1.998299699704296	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-18T00:00:00.000Z	morpho-api	0.03649440110109481	\N	1.0000488940726078	1.998301697702298	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-19T00:00:00.000Z	morpho-api	0.10948320330328443	\N	100475.18543274511	1.998307691696304	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-20T00:00:00.000Z	morpho-api	3.429694336531952	\N	116206.74848654802	1.998307692254452	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-21T00:00:00.000Z	morpho-api	3.4401804285266735	\N	119195.24988251203	1.998307696217362	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-22T00:00:00.000Z	morpho-api	3.440193032844263	\N	121276.19099871328	1.998307700762722	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-23T00:00:00.000Z	morpho-api	3.4401657234894856	\N	121289.18763736033	1.99830770338106	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-24T00:00:00.000Z	morpho-api	3.440130711496181	\N	161285.4918806476	1.99830770338106	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-25T00:00:00.000Z	morpho-api	4.470098825493096	\N	161313.70667392513	1.99830770339756	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-26T00:00:00.000Z	morpho-api	3.4401272102968505	\N	132206.43334816679	1.998307703414037	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-27T00:00:00.000Z	morpho-api	3.4401286107765827	\N	132659.02801191513	1.998307703429145	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-28T00:00:00.000Z	morpho-api	3.440130711496181	\N	133159.44958310458	1.998307703448679	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-29T00:00:00.000Z	morpho-api	3.4401202078981896	\N	132869.96275864684	1.998307703460435	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-30T00:00:00.000Z	morpho-api	3.440121608377922	\N	141945.99721331403	1.998307703460435	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-05-31T00:00:00.000Z	morpho-api	3.44251012656116	\N	141818.87371560122	1.998307703478081	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-21T00:00:00.000Z	morpho-api	\N	\N	0.999698176698492	1	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-22T00:00:00.000Z	morpho-api	\N	\N	1.9988448718441947	1.00000049999975	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-23T00:00:00.000Z	morpho-api	\N	\N	10.004957876779118	1.000000642856923	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-24T00:00:00.000Z	morpho-api	\N	\N	10.005982072056394	1.000000942557326	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-25T00:00:00.000Z	morpho-api	\N	\N	14.994003099098908	1.000001409024423	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-26T00:00:00.000Z	morpho-api	\N	\N	10.9956159936	1.000001781618672	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-27T00:00:00.000Z	morpho-api	\N	\N	13.99313207216079	1.000002216683739	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-28T00:00:00.000Z	morpho-api	\N	\N	11.993999628897019	1.00000261070656	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-29T00:00:00.000Z	morpho-api	\N	\N	21.991196030061477	1.000003004646346	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-30T00:00:00.000Z	morpho-api	\N	\N	8017.4852343193215	1.000003285089118	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-05-31T00:00:00.000Z	morpho-api	\N	\N	8014.952485256767	1.000003538198447	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-01T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-02T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-03T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-04T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-05T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-06T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-07T00:00:00.000Z	morpho-api	0.03646359054698678	\N	0.9999047935568329	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-08T00:00:00.000Z	morpho-api	0	\N	1.0000992271948352	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-09T00:00:00.000Z	morpho-api	0	\N	1.000001689301995	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-10T00:00:00.000Z	morpho-api	0	\N	1.000099556513538	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-11T00:00:00.000Z	morpho-api	0	\N	0.9999779496055382	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-12T00:00:00.000Z	morpho-api	0	\N	0.9999996004874746	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-13T00:00:00.000Z	morpho-api	0	\N	0.9999040221352015	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-14T00:00:00.000Z	morpho-api	0	\N	0.9998036974681607	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-15T00:00:00.000Z	morpho-api	0	\N	0.9998058908027575	1.000000998999	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-16T00:00:00.000Z	morpho-api	-0.10950000906007062	\N	0.9998053870693555	0.999997999002002	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-17T00:00:00.000Z	morpho-api	0.1825000151001177	\N	0.9999034156387426	1.000002998996998	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-18T00:00:00.000Z	morpho-api	0.07299930580018099	\N	0.9999029089778225	1.000004998994996	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-19T00:00:00.000Z	morpho-api	0.10949930882020453	\N	101905.93084571786	1.000007998991993	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-20T00:00:00.000Z	morpho-api	3.44012370909752	\N	106939.77370421593	1.000007999293336	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-21T00:00:00.000Z	morpho-api	3.4401790280469413	\N	108856.68925311338	1.00000800127317	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-22T00:00:00.000Z	morpho-api	3.4401860304456022	\N	108826.60982030928	1.000008003513991	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-23T00:00:00.000Z	morpho-api	3.4401748266077448	\N	108836.68372717687	1.000008004827247	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-24T00:00:00.000Z	morpho-api	3.4401132054995287	\N	108847.79258540581	1.00000800483643	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-25T00:00:00.000Z	morpho-api	3.4401286107765827	\N	108845.94194490665	1.000008004845626	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-26T00:00:00.000Z	morpho-api	3.440130711496181	\N	108845.9992709628	1.000008004873177	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-27T00:00:00.000Z	morpho-api	3.4401104045400643	\N	108845.96938503382	1.000008004965007	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-28T00:00:00.000Z	morpho-api	3.4401279105367166	\N	108845.86565194935	1.000008005121078	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-29T00:00:00.000Z	morpho-api	3.440106903340734	\N	108856.81197843137	1.000008005185357	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-30T00:00:00.000Z	morpho-api	3.440124409337386	\N	108956.55305160854	1.000008005222063	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-05-31T00:00:00.000Z	morpho-api	3.440130711496181	\N	108935.6875394508	1.000008005350503	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-12T00:00:00.000Z	morpho-api	\N	\N	1.0000016004846757	1.000002999997	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-13T00:00:00.000Z	morpho-api	\N	\N	300.9709056825761	1.000086021502269	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-14T00:00:00.000Z	morpho-api	\N	\N	308.43995506741555	1.000088301709703	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-15T00:00:00.000Z	morpho-api	\N	\N	308.4417314976472	1.000091689358058	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-16T00:00:00.000Z	morpho-api	\N	\N	307.8192554902506	1.000094395695758	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-17T00:00:00.000Z	morpho-api	\N	\N	307.84872811978136	1.000096958636555	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-18T00:00:00.000Z	morpho-api	\N	\N	307.84878735089234	1.000099524825692	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-19T00:00:00.000Z	morpho-api	\N	\N	307.75817887791845	1.000101490071803	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-20T00:00:00.000Z	morpho-api	\N	\N	307.75951335407774	1.000106966774189	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-21T00:00:00.000Z	morpho-api	\N	\N	307.78991378475354	1.000107613193985	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-22T00:00:00.000Z	morpho-api	\N	\N	307.705103940246	1.00010835381566	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-23T00:00:00.000Z	morpho-api	\N	\N	300.8556469056527	1.000108826935482	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-24T00:00:00.000Z	morpho-api	\N	\N	300.88644291846396	1.000109106028831	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-25T00:00:00.000Z	morpho-api	\N	\N	300.8869825220895	1.000109514701234	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-26T00:00:00.000Z	morpho-api	\N	\N	300.88726893119997	1.000109916728558	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-27T00:00:00.000Z	morpho-api	\N	\N	300.8596844355134	1.000110322078422	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-28T00:00:00.000Z	morpho-api	\N	\N	300.85675187645967	1.000110697495458	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-29T00:00:00.000Z	morpho-api	\N	\N	400.84794675569935	1.00011102976605	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-30T00:00:00.000Z	morpho-api	\N	\N	408.8436237943999	1.00011132543857	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-05-31T00:00:00.000Z	morpho-api	\N	\N	400.97007962336204	1.000111567585799	assets_per_share
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
