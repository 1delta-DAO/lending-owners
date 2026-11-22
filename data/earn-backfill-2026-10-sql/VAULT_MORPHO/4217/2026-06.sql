-- Generated from VAULT_MORPHO/4217/2026-06.ndjson (164 vault rows)
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
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-01T00:00:00.000Z	morpho-api	3.306954192083822	\N	2095723.0763840447	1.998795370743887	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-02T00:00:00.000Z	morpho-api	3.3053380384728825	\N	2095635.3704872255	1.998795879400248	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-03T00:00:00.000Z	morpho-api	3.288159053838058	\N	2122400.8051077547	1.998796241536224	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-04T00:00:00.000Z	morpho-api	3.201267689334486	\N	2208249.8111146027	1.998796311507911	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-05T00:00:00.000Z	morpho-api	3.0068888051459908	\N	2318880.975524706	1.998796324990608	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-06T00:00:00.000Z	morpho-api	2.7720920758866896	\N	2521772.2014905796	1.998796337783002	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-07T00:00:00.000Z	morpho-api	2.762605226180881	\N	2532138.607579638	1.998796350333422	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-08T00:00:00.000Z	morpho-api	2.7621976865788156	\N	2534359.810801243	1.998796364291938	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-09T00:00:00.000Z	morpho-api	2.4946885517351802	\N	2812765.09031976	1.998796378257558	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-10T00:00:00.000Z	morpho-api	2.3643746128954035	\N	2942451.391614356	1.998796392619391	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-11T00:00:00.000Z	morpho-api	3.4383156897632716	\N	3104310.270403705	1.998796408373751	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-12T00:00:00.000Z	morpho-api	3.4353487734506416	\N	3207653.7513424484	1.998796425116124	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-13T00:00:00.000Z	morpho-api	3.4394402749882147	\N	6404667.971549151	1.998796443136361	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-14T00:00:00.000Z	morpho-api	3.4393464428461584	\N	6555990.742475238	1.998796454439578	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-15T00:00:00.000Z	morpho-api	3.439221800149994	\N	6566032.096074379	1.99879645864426	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-16T00:00:00.000Z	morpho-api	3.439235804947316	\N	6647738.651255307	1.998796462937283	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-17T00:00:00.000Z	morpho-api	3.4336646965726914	\N	6720008.600594902	1.998796467340411	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-18T00:00:00.000Z	morpho-api	3.4366267112062587	\N	6910966.441217053	1.998796471858037	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-19T00:00:00.000Z	morpho-api	3.4392470087851734	\N	6976075.628160646	1.998796476520668	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-20T00:00:00.000Z	morpho-api	0.00008823022312753892	\N	7051813.253463606	1.998796481369717	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-21T00:00:00.000Z	morpho-api	3.43931213109272	\N	7083989.779428456	1.998796486439378	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-22T00:00:00.000Z	morpho-api	3.435077780622464	\N	7112088.463890776	1.998796492211857	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-23T00:00:00.000Z	morpho-api	3.434793483236831	\N	7186989.64355538	1.998796497823581	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-24T00:00:00.000Z	morpho-api	3.4393471430860245	\N	7236002.273032596	1.998796503808242	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-25T00:00:00.000Z	morpho-api	3.4393534452448193	\N	7220280.084732873	1.998796510212294	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-26T00:00:00.000Z	morpho-api	3.4393786538799986	\N	7271861.89800231	1.998796517074789	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-27T00:00:00.000Z	morpho-api	3.439480888900448	\N	7335268.625420383	1.998796524385778	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-28T00:00:00.000Z	morpho-api	3.4394913924984394	\N	7365192.558849131	1.998796532147103	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-29T00:00:00.000Z	morpho-api	3.439503996816029	\N	7389981.826880149	1.998796540460519	assets_per_share
VAULT_MORPHO	4217	0x9a044ae05e5e6290dcf56afd69548565e957a626	2026-06-30T00:00:00.000Z	morpho-api	3.4395166011336187	\N	7410659.619970915	1.998796549352794	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-01T00:00:00.000Z	morpho-api	3.44251012656116	\N	141832.84282670196	1.998307703478081	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-02T00:00:00.000Z	morpho-api	3.62704503871214	\N	150829.33814248198	1.998307703478081	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-03T00:00:00.000Z	morpho-api	3.440131411736047	\N	142888.8995402484	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-04T00:00:00.000Z	morpho-api	3.4401195076583235	\N	143984.1913080753	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-05T00:00:00.000Z	morpho-api	3.4401335124556454	\N	144136.02876557363	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-06T00:00:00.000Z	morpho-api	3.440124409337386	\N	144150.23815506493	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-07T00:00:00.000Z	morpho-api	3.440132111975913	\N	145245.416491619	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-08T00:00:00.000Z	morpho-api	3.4381406297967487	\N	145449.31407742074	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-09T00:00:00.000Z	morpho-api	3.4401265100569844	\N	145410.31977998192	1.998307703481666	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-10T00:00:00.000Z	morpho-api	3.440131411736047	\N	145332.26717583102	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-11T00:00:00.000Z	morpho-api	3.4401342126955115	\N	145375.836906374	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-12T00:00:00.000Z	morpho-api	3.440122308617788	\N	145499.6881319855	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-13T00:00:00.000Z	morpho-api	3.4401328122157793	\N	145580.53559380048	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-14T00:00:00.000Z	morpho-api	3.4401251095772523	\N	145591.42846624405	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-15T00:00:00.000Z	morpho-api	3.4401251095772523	\N	145818.88411543902	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-16T00:00:00.000Z	morpho-api	3.4401279105367166	\N	145832.9483795693	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-17T00:00:00.000Z	morpho-api	3.4401174069387253	\N	149072.32095278343	1.998307703481678	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-18T00:00:00.000Z	morpho-api	3.4401132054995287	\N	149557.56731964496	1.998307703495081	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-19T00:00:00.000Z	morpho-api	3.4401111047799304	\N	150073.3411663547	1.998307703495081	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-20T00:00:00.000Z	morpho-api	0	\N	151038.9162402809	1.998307703508307	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-21T00:00:00.000Z	morpho-api	3.4302475260261645	\N	161293.2651068219	1.998307703521402	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-22T00:00:00.000Z	morpho-api	3.440045282232518	\N	162287.45834863244	1.998307703558411	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-23T00:00:00.000Z	morpho-api	3.440039680313589	\N	161747.89164891595	1.998307703595826	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-24T00:00:00.000Z	morpho-api	3.4400284764757316	\N	162761.65009747687	1.998307703632771	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-25T00:00:00.000Z	morpho-api	3.44003057719533	\N	163779.8800744603	1.998307703669401	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-26T00:00:00.000Z	morpho-api	3.4400263757561333	\N	163763.4482160768	1.998307703705994	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-27T00:00:00.000Z	morpho-api	3.4400508841514466	\N	163796.0033796096	1.998307703754784	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-28T00:00:00.000Z	morpho-api	3.4400438817527856	\N	163795.8835085567	1.998307703791376	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-29T00:00:00.000Z	morpho-api	3.4400438817527856	\N	163766.72505688458	1.998307703827969	assets_per_share
VAULT_MORPHO	4217	0xc609656ed9ef219c98c8e549bf729144f211f06e	2026-06-30T00:00:00.000Z	morpho-api	3.440045982472384	\N	163780.39444174853	1.998307703852364	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-01T00:00:00.000Z	morpho-api	\N	\N	8015.743906394601	1.000003781598926	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-02T00:00:00.000Z	morpho-api	\N	\N	8010.80018887331	1.000004036164825	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-03T00:00:00.000Z	morpho-api	\N	\N	30468.052716598333	1.000004217301495	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-04T00:00:00.000Z	morpho-api	\N	\N	179239.87906685632	1.000004252300308	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-05T00:00:00.000Z	morpho-api	\N	\N	292191.3559753479	1.000004259047123	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-06T00:00:00.000Z	morpho-api	\N	\N	494884.3604641496	1.000004265445098	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-07T00:00:00.000Z	morpho-api	\N	\N	504023.0568546269	1.000004271725446	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-08T00:00:00.000Z	morpho-api	\N	\N	503516.24913185235	1.000004278709218	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-09T00:00:00.000Z	morpho-api	\N	\N	780559.1363097389	1.000004285695718	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-10T00:00:00.000Z	morpho-api	\N	\N	911272.5188875211	1.000004292881186	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-11T00:00:00.000Z	morpho-api	\N	\N	1071866.8113626	1.000004300762675	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-12T00:00:00.000Z	morpho-api	\N	\N	1174506.0703540223	1.000004309139181	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-13T00:00:00.000Z	morpho-api	\N	\N	1371179.4140629019	1.000004318154452	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-14T00:00:00.000Z	morpho-api	\N	\N	1523663.426226206	1.000004323809847	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-15T00:00:00.000Z	morpho-api	\N	\N	1532549.775822019	1.000004325913219	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-16T00:00:00.000Z	morpho-api	\N	\N	1612631.9727230677	1.000004328061229	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-17T00:00:00.000Z	morpho-api	\N	\N	1682823.1841766657	1.0000043302643	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-18T00:00:00.000Z	morpho-api	\N	\N	1870753.895326671	1.00000433252424	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-19T00:00:00.000Z	morpho-api	\N	\N	1934833.364349851	1.000004334856732	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-20T00:00:00.000Z	morpho-api	\N	\N	2009474.9844895604	1.000004337282984	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-21T00:00:00.000Z	morpho-api	\N	\N	2039950.100973019	1.000004339819542	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-22T00:00:00.000Z	morpho-api	\N	\N	2064746.026143132	1.000004342707188	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-23T00:00:00.000Z	morpho-api	\N	\N	2139671.7245579725	1.000004345514709	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-24T00:00:00.000Z	morpho-api	\N	\N	2187431.889243963	1.000004348508865	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-25T00:00:00.000Z	morpho-api	\N	\N	2171733.9782461748	1.000004351712941	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-26T00:00:00.000Z	morpho-api	\N	\N	2223318.3910932704	1.000004355146433	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-27T00:00:00.000Z	morpho-api	\N	\N	2285640.9970543818	1.000004358803924	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-28T00:00:00.000Z	morpho-api	\N	\N	2306491.0383553887	1.000004362687122	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-29T00:00:00.000Z	morpho-api	\N	\N	2332075.460371518	1.000004366846129	assets_per_share
VAULT_MORPHO	4217	0x83a1491f3e7f8daab8f787a631334b9ca7a87023	2026-06-30T00:00:00.000Z	morpho-api	\N	\N	2350929.4704289264	1.000004371294894	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-01T00:00:00.000Z	morpho-api	3.4401356131752436	\N	108946.4177008172	1.000008005616559	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-02T00:00:00.000Z	morpho-api	3.4380005818235304	\N	108947.12158800752	1.000008005864266	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-03T00:00:00.000Z	morpho-api	3.440101301421805	\N	105000.2216291789	1.000008006140391	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-04T00:00:00.000Z	morpho-api	3.4400978002224747	\N	105607.8643736644	1.00000800641618	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-05T00:00:00.000Z	morpho-api	3.4401202078981896	\N	105608.5228033261	1.000008006444576	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-06T00:00:00.000Z	morpho-api	3.440130711496181	\N	105618.93402838179	1.000008006444576	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-07T00:00:00.000Z	morpho-api	3.440115306219127	\N	105608.6630921008	1.000008006463506	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-08T00:00:00.000Z	morpho-api	3.4381294259588913	\N	105619.6439600056	1.000008006472971	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-09T00:00:00.000Z	morpho-api	3.44012370909752	\N	105609.07541838565	1.000008006491902	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-10T00:00:00.000Z	morpho-api	3.4401118050197965	\N	105508.90928854517	1.000008006512079	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-11T00:00:00.000Z	morpho-api	3.440122308617788	\N	105540.54021839246	1.000008006512079	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-12T00:00:00.000Z	morpho-api	3.440122308617788	\N	105509.26988226171	1.000008006531742	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-13T00:00:00.000Z	morpho-api	3.440114605979261	\N	105529.93156811457	1.000008006531742	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-14T00:00:00.000Z	morpho-api	3.440106903340734	\N	105499.20633597794	1.000008006531742	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-15T00:00:00.000Z	morpho-api	3.4401118050197965	\N	105521.95443725726	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-16T00:00:00.000Z	morpho-api	3.440098500462341	\N	105532.1320534676	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-17T00:00:00.000Z	morpho-api	3.440123008857654	\N	115071.68317134082	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-18T00:00:00.000Z	morpho-api	3.440121608377922	\N	115060.39249419578	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-19T00:00:00.000Z	morpho-api	3.4401048026211356	\N	115071.7913001975	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-20T00:00:00.000Z	morpho-api	0	\N	116042.40652206987	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-21T00:00:00.000Z	morpho-api	3.4401111047799304	\N	116256.00201753982	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-22T00:00:00.000Z	morpho-api	3.440106203100868	\N	116758.1383957405	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-23T00:00:00.000Z	morpho-api	3.44012370909752	\N	116769.16887764428	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-24T00:00:00.000Z	morpho-api	3.4401125052596626	\N	116283.00795788034	1.000008006531956	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-25T00:00:00.000Z	morpho-api	3.4401055028610017	\N	116759.50568151863	1.000008006540518	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-26T00:00:00.000Z	morpho-api	3.440116006458993	\N	117557.6772413484	1.000008006549021	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-27T00:00:00.000Z	morpho-api	3.4401202078981896	\N	117581.04697970382	1.000008006549021	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-28T00:00:00.000Z	morpho-api	3.4401027019015373	\N	117580.96656990131	1.000008006549021	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-29T00:00:00.000Z	morpho-api	3.440113905739395	\N	117560.0351579102	1.000008006557524	assets_per_share
VAULT_MORPHO	4217	0xe5235da8ad839dd2a9de1f1069c89ca3575b5208	2026-06-30T00:00:00.000Z	morpho-api	3.4401181071785913	\N	117569.84773204324	1.000008006557524	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-17T00:00:00.000Z	morpho-api	\N	\N	0.9999003546949079	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-18T00:00:00.000Z	morpho-api	\N	\N	0.9998017245724031	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-19T00:00:00.000Z	morpho-api	\N	\N	0.9999001213187833	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-20T00:00:00.000Z	morpho-api	\N	\N	0.9996047909169601	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-21T00:00:00.000Z	morpho-api	\N	\N	0.9998427541450348	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-22T00:00:00.000Z	morpho-api	\N	\N	0.9998017895493504	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-23T00:00:00.000Z	morpho-api	\N	\N	9.991607626172954	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-24T00:00:00.000Z	morpho-api	\N	\N	9.992090360604323	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-25T00:00:00.000Z	morpho-api	\N	\N	9.989654191792917	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-26T00:00:00.000Z	morpho-api	\N	\N	9.988651940399999	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-27T00:00:00.000Z	morpho-api	\N	\N	9.990637622559161	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-28T00:00:00.000Z	morpho-api	\N	\N	9.990629091272986	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-29T00:00:00.000Z	morpho-api	\N	\N	9.988850589278597	1	assets_per_share
VAULT_MORPHO	4217	0x811bf7d87b8c0bcc37ff47a8d858f9c561512d2e	2026-06-30T00:00:00.000Z	morpho-api	\N	\N	9.98968434487232	1	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-01T00:00:00.000Z	morpho-api	\N	\N	401.00967299183236	1.000111799410903	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-02T00:00:00.000Z	morpho-api	\N	\N	301.06038553756855	1.000112044954367	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-03T00:00:00.000Z	morpho-api	\N	\N	301.0637656994585	1.000112217611689	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-04T00:00:00.000Z	morpho-api	\N	\N	301.0863863499386	1.00011225081502	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-05T00:00:00.000Z	morpho-api	\N	\N	301.08826551336324	1.000112257455686	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-06T00:00:00.000Z	morpho-api	\N	\N	301.1179497544101	1.000112264096352	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-07T00:00:00.000Z	morpho-api	\N	\N	301.0878145142846	1.000112270737018	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-08T00:00:00.000Z	morpho-api	\N	\N	301.11912270696337	1.000112277377685	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-09T00:00:00.000Z	morpho-api	\N	\N	301.0889940366891	1.000112280698018	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-10T00:00:00.000Z	morpho-api	\N	\N	301.0884098025368	1.000112290659017	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-11T00:00:00.000Z	morpho-api	\N	\N	301.1786762779415	1.000112297299683	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-12T00:00:00.000Z	morpho-api	\N	\N	301.1179710197391	1.000112303940349	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-13T00:00:00.000Z	morpho-api	\N	\N	301.17694139668816	1.000112313901349	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-14T00:00:00.000Z	morpho-api	\N	\N	301.0892551798513	1.000112320542015	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-15T00:00:00.000Z	morpho-api	\N	\N	301.1481849872097	1.000112320542015	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-16T00:00:00.000Z	morpho-api	\N	\N	301.1772317971992	1.000112323862348	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-17T00:00:00.000Z	morpho-api	\N	\N	301.17842099359814	1.000112327182681	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-18T00:00:00.000Z	morpho-api	\N	\N	301.1487127687546	1.000112327182681	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-19T00:00:00.000Z	morpho-api	\N	\N	301.178351698641	1.000112330503014	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-20T00:00:00.000Z	morpho-api	\N	\N	301.08939668980935	1.000112333823347	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-21T00:00:00.000Z	morpho-api	\N	\N	301.16107422164396	1.00011233714368	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-22T00:00:00.000Z	morpho-api	\N	\N	301.14873633956637	1.000112340464013	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-23T00:00:00.000Z	morpho-api	\N	\N	301.17704886662693	1.000112340464013	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-24T00:00:00.000Z	morpho-api	\N	\N	301.1916009315113	1.000112343784347	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-25T00:00:00.000Z	morpho-api	\N	\N	301.11816848956266	1.000112343784347	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-26T00:00:00.000Z	morpho-api	\N	\N	301.0879586232	1.00011234710468	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-27T00:00:00.000Z	morpho-api	\N	\N	301.14781404493107	1.000112350425013	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-28T00:00:00.000Z	morpho-api	\N	\N	301.147558885947	1.000112357065679	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-29T00:00:00.000Z	morpho-api	\N	\N	301.0939504952881	1.000112360386012	assets_per_share
VAULT_MORPHO	4217	0x4001391af4ecea1ac3d96dd95f592ba4c12d6df4	2026-06-30T00:00:00.000Z	morpho-api	\N	\N	301.1190833921219	1.000112363706345	assets_per_share
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
