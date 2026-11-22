-- Generated from VAULT_ETHERFI_LIQUID/10/2026-07.ndjson (93 vault rows)
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
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-01T00:00:00.000Z	sevenseas-api	4.926621032909221	56681152.925659	56659223.55440359	1.164657	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-02T00:00:00.000Z	sevenseas-api	4.943791491935379	55811608.939047	55787609.947203204	1.164829	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-03T00:00:00.000Z	sevenseas-api	4.954648643337666	56243306.7505	56221977.60128101	1.164999	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-04T00:00:00.000Z	sevenseas-api	4.954648643337666	56197622.105801	56183885.721029684	1.164999	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-05T00:00:00.000Z	sevenseas-api	4.800249413587738	56271661.629858	56259281.86429943	1.165168	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-06T00:00:00.000Z	sevenseas-api	4.9872366234385135	56365869.855175	56352585.546967536	1.165501	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-07T00:00:00.000Z	sevenseas-api	4.990762897917414	56442304.940238	56430258.45909461	1.16566	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-08T00:00:00.000Z	sevenseas-api	4.992140836215101	55521205.200242	55507672.46168649	1.165829	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-09T00:00:00.000Z	sevenseas-api	4.831177263872925	55867939.63046	55855736.39640652	1.165829	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-10T00:00:00.000Z	sevenseas-api	4.847285903921187	55958609.952506	55945229.68928026	1.166002	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-11T00:00:00.000Z	sevenseas-api	4.854997912245458	56090294.759213	56072906.76783764	1.16617	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-12T00:00:00.000Z	sevenseas-api	5.194376407082046	56089736.004109	56080407.72011416	1.166494	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-13T00:00:00.000Z	sevenseas-api	5.032740831017901	57394407.81846	57383264.694182046	1.166658	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-14T00:00:00.000Z	sevenseas-api	4.869778466624249	57299470.327812	57285095.03669616	1.166658	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-15T00:00:00.000Z	sevenseas-api	5.212160225081782	57480188.602252	57464564.91218802	1.166985	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-16T00:00:00.000Z	sevenseas-api	5.230277753637036	57783145.998929	57770733.60133697	1.167165	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-17T00:00:00.000Z	sevenseas-api	5.077097769003276	58021613.680062	58007841.669838905	1.167336	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-18T00:00:00.000Z	sevenseas-api	5.125750432719984	57868119.827812	57859446.5540122	1.167505	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-19T00:00:00.000Z	sevenseas-api	5.146003187817464	57979392.860884	57972332.71021533	1.167678	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-20T00:00:00.000Z	sevenseas-api	4.97895095588489	58055137.032392	58047892.91239309	1.167678	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-21T00:00:00.000Z	sevenseas-api	5.321064207108583	58350736.684948	58340461.12021778	1.168005	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-22T00:00:00.000Z	sevenseas-api	5.15085936978303	58478846.355412	58471989.710676834	1.168005	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-23T00:00:00.000Z	sevenseas-api	5.033498972953983	58607311.657406	58599566.701170474	1.168182	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-24T00:00:00.000Z	sevenseas-api	5.197691646702954	58487345.398273	58480426.93018584	1.168339	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-25T00:00:00.000Z	sevenseas-api	5.345324130533935	58691216.735578	58686122.33796535	1.168671	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-26T00:00:00.000Z	sevenseas-api	5.188163450941719	58407776.907524	58403712.310329005	1.168827	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-27T00:00:00.000Z	sevenseas-api	5.210476593841399	58450753.592388	58448731.78082124	1.169002	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-28T00:00:00.000Z	sevenseas-api	5.221234022400756	58016827.771587	58010972.713328294	1.169178	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-29T00:00:00.000Z	sevenseas-api	5.047030612840867	57061220.568977	57053695.90582056	1.169178	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-30T00:00:00.000Z	sevenseas-api	5.234462350171294	57324542.232402	57313650.56937784	1.169504	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-07-31T00:00:00.000Z	sevenseas-api	5.063450726980823	57918618.868141	57903410.01801242	1.169504	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-01T00:00:00.000Z	sevenseas-api	1.993885034583346	55.63938024	3256821.4910400594	1.03080546	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-02T00:00:00.000Z	sevenseas-api	1.9988736662485203	55.59407214	3343548.1376361437	1.03086477	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-03T00:00:00.000Z	sevenseas-api	1.9966656610317046	55.57727186	3406267.9415517934	1.03092256	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-04T00:00:00.000Z	sevenseas-api	1.9966656610317046	55.29956597	3461056.2730683032	1.03092256	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-05T00:00:00.000Z	sevenseas-api	1.9262047776425817	55.42876905	3498037.557345735	1.03098066	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-06T00:00:00.000Z	sevenseas-api	1.999549875431202	55.40065687	3524405.730805061	1.03109572	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-07T00:00:00.000Z	sevenseas-api	1.9995631552141604	55.28510251	3545419.870691349	1.03114983	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-08T00:00:00.000Z	sevenseas-api	1.9966871064546532	55.63930962	3538304.055889742	1.03120447	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-09T00:00:00.000Z	sevenseas-api	1.9337753290399735	55.88148614	3475334.841879228	1.03120447	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-10T00:00:00.000Z	sevenseas-api	1.9357754653177683	56.6052804	3573563.2269856767	1.03126121	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-11T00:00:00.000Z	sevenseas-api	1.935144983537055	56.62074867	3628376.308483561	1.03131959	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-12T00:00:00.000Z	sevenseas-api	2.0612802229479956	56.6398105	3613886.1175757484	1.03142634	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-13T00:00:00.000Z	sevenseas-api	1.9952510044039342	56.24872947	3585475.1561762053	1.03148128	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-14T00:00:00.000Z	sevenseas-api	1.9278716307100097	56.32803202	3501491.29044325	1.03148128	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-15T00:00:00.000Z	sevenseas-api	2.0209425177812284	56.52962584	3666413.46118622	1.03156006	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-16T00:00:00.000Z	sevenseas-api	2.004869306024274	56.58944772	3670988.5403209687	1.03160432	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-17T00:00:00.000Z	sevenseas-api	1.9171763933068	56.83657833	3630832.5917797103	1.03164575	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-18T00:00:00.000Z	sevenseas-api	1.9011511435812107	56.87205096	3631492.3710010075	1.03168787	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-19T00:00:00.000Z	sevenseas-api	1.887870286354017	56.92055807	3683406.1554630944	1.03173091	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-20T00:00:00.000Z	sevenseas-api	1.823476041286361	57.04837811	3685899.303734921	1.03173091	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-21T00:00:00.000Z	sevenseas-api	1.9229175419930558	57.20194974	3729323.2139343084	1.03181511	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-22T00:00:00.000Z	sevenseas-api	1.852126165850513	57.21245741	3800252.694597368	1.03181511	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-23T00:00:00.000Z	sevenseas-api	1.7891392967908906	57.25769483	3775695.464931762	1.03186114	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-24T00:00:00.000Z	sevenseas-api	1.8345187134664005	57.30854632	3733042.517965914	1.03189957	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-25T00:00:00.000Z	sevenseas-api	1.855366293921512	57.36373642	3677317.607940892	1.0319862	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-26T00:00:00.000Z	sevenseas-api	1.7710215289467626	57.37617051	3693007.5324281994	1.03202688	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-27T00:00:00.000Z	sevenseas-api	1.7616272371877018	57.38766066	3748081.9268331863	1.03207221	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-28T00:00:00.000Z	sevenseas-api	1.7472091615922447	57.41195007	3658678.8166915695	1.03211778	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-29T00:00:00.000Z	sevenseas-api	1.678657580389912	57.99935496	3703294.674203063	1.03211778	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-30T00:00:00.000Z	sevenseas-api	1.71549758814038	58.28074487	3720680.0157456403	1.03219948	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-07-31T00:00:00.000Z	sevenseas-api	1.6453712484863159	58.21435195	3776053.5642135674	1.03219948	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-01T00:00:00.000Z	sevenseas-api	3.610990132146241	26814.006331065117	461258495086335740	1.0975952121084622	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-02T00:00:00.000Z	sevenseas-api	3.628483008637573	26828.1155774279	474311799222648060	1.0977083042766742	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-03T00:00:00.000Z	sevenseas-api	3.648030508042695	26853.165606817223	500530608274632200	1.0978249936488125	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-04T00:00:00.000Z	sevenseas-api	3.648030508042695	26831.0496643724	517862618450363400	1.0978249936488125	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-05T00:00:00.000Z	sevenseas-api	3.557550432038566	26836.130703035786	522706164476914300	1.097935209076652	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-06T00:00:00.000Z	sevenseas-api	3.7028844440190793	26855.72493399697	525326783478013300	1.0981575115201088	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-07T00:00:00.000Z	sevenseas-api	3.715571350816741	27507.282661762085	545039526418787460	1.0982660496183227	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-08T00:00:00.000Z	sevenseas-api	3.7269504167037004	27584.685560456674	536174495873992600	1.0983780199817326	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-09T00:00:00.000Z	sevenseas-api	3.603218187804791	27842.177181207073	532999172855153800	1.0983780199817326	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-10T00:00:00.000Z	sevenseas-api	3.608056491546237	27999.654770536767	536875814096660200	1.0984913434032693	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-11T00:00:00.000Z	sevenseas-api	3.608750120148692	28029.430092931307	552890244220701200	1.0986041164054388	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-12T00:00:00.000Z	sevenseas-api	3.8551196137005195	28041.717934400367	552030362440825400	1.0988259208735527	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-13T00:00:00.000Z	sevenseas-api	3.857280927218883	28069.32120798033	555583257968474750	1.0989415274074439	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-14T00:00:00.000Z	sevenseas-api	3.615777370275719	28085.66138296284	547493936420007400	1.0989415274074439	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-15T00:00:00.000Z	sevenseas-api	3.854723398120922	28135.58154293739	584115882171854800	1.0991567134195768	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-16T00:00:00.000Z	sevenseas-api	3.860312850178993	28197.44981757169	593400927247921800	1.099277095522223	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-17T00:00:00.000Z	sevenseas-api	3.741800221239481	28242.21343779202	578905093149945100	1.0993910316133948	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-18T00:00:00.000Z	sevenseas-api	3.74421036882856	28172.37019880658	56813502.035922565	1.0995059114322412	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-19T00:00:00.000Z	sevenseas-api	3.7503128432948563	28189.812153531537	57655914.887211025	1.0996184911876825	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-20T00:00:00.000Z	sevenseas-api	3.6213108986910436	28200.357981369412	57904344.94170129	1.0996184911876825	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-21T00:00:00.000Z	sevenseas-api	3.866685610541879	28211.64060449656	59013459.541532844	1.099839601757795	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-22T00:00:00.000Z	sevenseas-api	3.7406535220327144	28222.286020850457	59613143.36199256	1.099839601757795	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-23T00:00:00.000Z	sevenseas-api	3.645317996827028	28236.931770018782	59732503.26725328	1.0999614955955932	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-24T00:00:00.000Z	sevenseas-api	3.7657883544277015	28293.45701408051	58561095.94634096	1.100070084838661	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-25T00:00:00.000Z	sevenseas-api	3.8555506556377255	28308.78501374092	57868469.31122576	1.1002874659015098	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-26T00:00:00.000Z	sevenseas-api	3.7171375407190546	28403.421944961123	58534654.410582475	1.1003830475095873	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-27T00:00:00.000Z	sevenseas-api	3.7160793008197524	28402.83337860115	61117711.25616826	1.1004894823235096	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-28T00:00:00.000Z	sevenseas-api	3.705918417318258	28424.025882044512	59111513.166802816	1.1005983147781317	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-29T00:00:00.000Z	sevenseas-api	3.573130880030373	28461.15767144687	60090526.40171585	1.1005983147781317	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-30T00:00:00.000Z	sevenseas-api	3.6755953816519784	28469.03313262911	59606085.36468974	1.1007947129875375	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-07-31T00:00:00.000Z	sevenseas-api	3.546595344620429	28493.259368246567	60350082.55257915	1.1007947129875375	assets_per_share
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
