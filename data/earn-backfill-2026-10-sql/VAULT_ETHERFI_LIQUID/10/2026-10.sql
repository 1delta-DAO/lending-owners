-- Generated from VAULT_ETHERFI_LIQUID/10/2026-10.ndjson (81 vault rows)
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
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-01T00:00:00.000Z	sevenseas-api	5.48375941517617	83226882.387014	83226882.387014	1.180305	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-02T00:00:00.000Z	sevenseas-api	5.4922791969458995	84623743.314529	84619373.34442423	1.180485	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-03T00:00:00.000Z	sevenseas-api	5.489395818905118	86349582.677741	86348713.13744344	1.180657	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-04T00:00:00.000Z	sevenseas-api	5.604478989530807	86337558.559118	86336068.37285727	1.180948	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-05T00:00:00.000Z	sevenseas-api	5.487766326473057	86864115.726826	86860032.24474569	1.181006	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-06T00:00:00.000Z	sevenseas-api	5.516000615719115	86674793.234403	86663612.18607576	1.181192	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-07T00:00:00.000Z	sevenseas-api	5.515184497059962	87337959.279941	87329584.44302565	1.181366	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-08T00:00:00.000Z	sevenseas-api	5.512243589144239	87094828.441432	87075537.8078805	1.18155	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-09T00:00:00.000Z	sevenseas-api	5.492676676663233	87987044.710451	87974726.52419153	1.181735	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-10T00:00:00.000Z	sevenseas-api	5.487728179038235	88080315.58763	88068433.55305722	1.181905	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-11T00:00:00.000Z	sevenseas-api	5.472404924171651	88318009.36194	88307452.71028097	1.182073	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-12T00:00:00.000Z	sevenseas-api	5.465351643736316	88125737.062304	88115049.17291309	1.18225	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-13T00:00:00.000Z	sevenseas-api	5.467681678615355	88580298.042643	88566421.05315164	1.182419	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-14T00:00:00.000Z	sevenseas-api	5.485484737265011	89028358.514325	89011966.61295535	1.182609	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-15T00:00:00.000Z	sevenseas-api	5.471241427631238	89491364.859265	89476002.77157326	1.18277	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-16T00:00:00.000Z	sevenseas-api	5.458994422579192	89082918.134048	89071692.79553393	1.182949	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-17T00:00:00.000Z	sevenseas-api	5.44780282056051	89279695.766332	89268376.88650274	1.183125	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-18T00:00:00.000Z	sevenseas-api	5.45940104734786	90082937.419618	90069452.00388628	1.183309	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-19T00:00:00.000Z	sevenseas-api	5.449291673138363	90785472.159606	90772357.29029782	1.183476	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-20T00:00:00.000Z	sevenseas-api	5.485754681113878	91350646.18795	91336175.33208737	1.183665	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-21T00:00:00.000Z	sevenseas-api	5.485916602392264	91479917.795276	91466586.4268557	1.183853	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-22T00:00:00.000Z	sevenseas-api	5.490295722346756	91839079.973843	91821864.7383019	1.184026	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-23T00:00:00.000Z	sevenseas-api	5.473944222296371	92211607.000685	92194873.36036259	1.184198	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-24T00:00:00.000Z	sevenseas-api	5.480341036566749	92722689.624597	92708875.79829673	1.184383	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-25T00:00:00.000Z	sevenseas-api	5.413510689899755	92021995.830476	92009632.67533618	1.184491	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-26T00:00:00.000Z	sevenseas-api	5.224928623471462	91672998.522817	91656779.73591834	1.184491	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-10-27T00:00:00.000Z	sevenseas-api	5.364399612187176	92574013.603075	92539761.21804187	1.184808	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-01T00:00:00.000Z	sevenseas-api	1.4455842338238267	105.8184333	8840512.159524791	1.03452193	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-02T00:00:00.000Z	sevenseas-api	1.3080662618306316	106.96684154	9064476.879247703	1.03456498	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-03T00:00:00.000Z	sevenseas-api	1.3593839843852353	106.91993905	9037816.851730997	1.03460857	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-04T00:00:00.000Z	sevenseas-api	1.3423844755270549	107.55180783	9114455.269603433	1.03467545	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-05T00:00:00.000Z	sevenseas-api	1.309074751037679	107.8708141	9344007.93751757	1.03468993	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-06T00:00:00.000Z	sevenseas-api	1.3614104314122724	107.78993558	9253458.256284766	1.03473439	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-07T00:00:00.000Z	sevenseas-api	1.4102617749920572	107.86563557	9227078.44363338	1.03477589	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-08T00:00:00.000Z	sevenseas-api	1.423033752771278	108.23381765	9013597.60604529	1.03478674	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-09T00:00:00.000Z	sevenseas-api	1.221116451123146	108.60170426	8880981.364360133	1.03478674	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-10T00:00:00.000Z	sevenseas-api	1.2444976130892904	113.90395246	9406509.71719669	1.0348497	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-11T00:00:00.000Z	sevenseas-api	1.1967706387123411	114.29290977	9484158.120188005	1.03485315	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-12T00:00:00.000Z	sevenseas-api	1.1657725282346727	114.70685369	9584431.263150476	1.03486857	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-13T00:00:00.000Z	sevenseas-api	1.1644677488404733	115.06334112	9431716.664505716	1.03490799	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-14T00:00:00.000Z	sevenseas-api	1.1584183096787621	115.15359374	9582012.11049273	1.03494573	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-15T00:00:00.000Z	sevenseas-api	1.153289048072692	116.07472553	9459196.35530842	1.03498256	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-16T00:00:00.000Z	sevenseas-api	1.1519218173832353	118.61991754	9740111.041697191	1.03502576	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-17T00:00:00.000Z	sevenseas-api	1.15607524020959	119.35867411	9739311.880515214	1.03502929	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-18T00:00:00.000Z	sevenseas-api	1.0861227836649445	121.44566196	9858975.175834967	1.03505134	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-19T00:00:00.000Z	sevenseas-api	1.0357133272746417	128.22325758	10519355.53931037	1.03505134	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-20T00:00:00.000Z	sevenseas-api	1.016784847344169	128.95599071	10555427.863919573	1.03507031	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-21T00:00:00.000Z	sevenseas-api	0.9650046020306502	129.70970134	10746921.197814655	1.03507031	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-22T00:00:00.000Z	sevenseas-api	0.9204562240713161	130.64829911	11022164.837054094	1.03507103	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-23T00:00:00.000Z	sevenseas-api	0.9490462012898419	131.12805344	10657386.250756081	1.03510259	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-24T00:00:00.000Z	sevenseas-api	0.9510849331157201	131.60200669	10653252.190619046	1.03512591	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-25T00:00:00.000Z	sevenseas-api	0.9305074979667556	132.76867275	10726348.792379702	1.03512591	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-26T00:00:00.000Z	sevenseas-api	0.9184524206935347	133.39331809	10650811.219195835	1.03515342	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-10-27T00:00:00.000Z	sevenseas-api	0.9184524206935347	133.52105099	10680341.704672853	1.03515342	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-01T00:00:00.000Z	sevenseas-api	3.165810681757926	38044.38167887896	102329904.72167315	1.106635808577388	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-02T00:00:00.000Z	sevenseas-api	3.184244797059832	38078.50141308701	102863359.79224259	1.1067407142338261	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-03T00:00:00.000Z	sevenseas-api	3.175629792761277	38222.20070636337	101944378.4969791	1.1068220628228995	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-04T00:00:00.000Z	sevenseas-api	3.2295373656490116	38218.14744138852	102649720.73806582	1.1069612544795007	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-05T00:00:00.000Z	sevenseas-api	3.167734807851134	38296.13370498888	104749809.91525386	1.106991862723004	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-06T00:00:00.000Z	sevenseas-api	3.191476645855229	38446.83888336575	104334340.08295615	1.1070954589500883	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-07T00:00:00.000Z	sevenseas-api	3.202415620260475	38526.47004370453	103948534.6575625	1.107194300367754	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-08T00:00:00.000Z	sevenseas-api	3.2091660370358226	38504.3948491516	98878130.84077582	1.107296693913318	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-09T00:00:00.000Z	sevenseas-api	3.2143763643883863	38635.024141214155	95598726.9743714	1.1074083146448428	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-10T00:00:00.000Z	sevenseas-api	3.2266361494204325	38700.74529152105	96178705.19103521	1.107510527617464	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-11T00:00:00.000Z	sevenseas-api	3.2319222553567597	38781.17132162377	97111430.54238735	1.1076106897813816	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-12T00:00:00.000Z	sevenseas-api	3.236858614548447	38872.263776051215	98511713.496069	1.1077172810453284	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-13T00:00:00.000Z	sevenseas-api	3.2485456524800242	38884.479596954334	95300063.57263912	1.107819699296695	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-14T00:00:00.000Z	sevenseas-api	3.2673070852517507	38899.26292435399	97172954.52818331	1.1079317922289051	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-15T00:00:00.000Z	sevenseas-api	3.2718081494686504	38935.989950684925	94018940.33722964	1.1080311891678805	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-16T00:00:00.000Z	sevenseas-api	3.276245220443197	38970.8064068765	94961506.42277646	1.1081399442265751	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-17T00:00:00.000Z	sevenseas-api	3.2823655871281443	39087.56987609125	94636776.17552432	1.1082469725348	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-18T00:00:00.000Z	sevenseas-api	3.294317485588601	39145.75087248138	93741562.66529965	1.1083535240617135	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-19T00:00:00.000Z	sevenseas-api	3.2929863571767264	39256.00418370257	94284285.72833318	1.1084538457694937	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-20T00:00:00.000Z	sevenseas-api	3.3190065241668747	39329.447719061856	94551531.96691942	1.108564550086321	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-21T00:00:00.000Z	sevenseas-api	3.3254844839557096	39780.824327061775	97353200.51007721	1.108673213596188	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-22T00:00:00.000Z	sevenseas-api	3.334736540254886	39753.39960056693	98540716.71405667	1.108776166208801	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-23T00:00:00.000Z	sevenseas-api	3.335733069410677	39386.75333180098	93799946.92721736	1.1088795521163866	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-24T00:00:00.000Z	sevenseas-api	3.3459845802360126	39425.99404078513	93915527.00224224	1.108989472029273	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-25T00:00:00.000Z	sevenseas-api	3.342370632356513	38900.186734203344	91348107.41759506	1.109081247462048	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-26T00:00:00.000Z	sevenseas-api	3.3519795843171587	39087.2294452247	90710085.5010021	1.1091894183944453	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-10-27T00:00:00.000Z	sevenseas-api	3.35811812276748	39337.900169162735	91296216.06171432	1.1092964081773242	assets_per_share
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
