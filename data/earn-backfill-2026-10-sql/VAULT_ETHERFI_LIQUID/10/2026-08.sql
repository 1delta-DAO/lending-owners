-- Generated from VAULT_ETHERFI_LIQUID/10/2026-08.ndjson (93 vault rows)
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
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-01T00:00:00.000Z	sevenseas-api	5.23191243807755	59016286.18326	59000815.06383706	1.169838	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-02T00:00:00.000Z	sevenseas-api	5.223838532622622	58997141.508998	58985804.61828563	1.170001	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-03T00:00:00.000Z	sevenseas-api	5.395111927134658	59765797.699544	59753670.62153279	1.170165	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-04T00:00:00.000Z	sevenseas-api	5.397461996896639	60237159.80488	60222278.8169218	1.170337	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-05T00:00:00.000Z	sevenseas-api	5.227851942355106	60653451.575984	60637803.592011906	1.170509	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-06T00:00:00.000Z	sevenseas-api	5.061181362204026	60957152.490841	60943524.30025863	1.170509	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-07T00:00:00.000Z	sevenseas-api	5.231599145329198	61753247.552976	61738891.15798488	1.170842	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-08T00:00:00.000Z	sevenseas-api	5.231599145329198	61691897.332924	61674800.65741613	1.170842	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-09T00:00:00.000Z	sevenseas-api	5.227692576856597	61957512.395368	61950778.23334575	1.171012	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-10T00:00:00.000Z	sevenseas-api	5.402214085425142	62325747.748123	62313882.79552419	1.171348	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-11T00:00:00.000Z	sevenseas-api	5.062777862552484	63339662.297046	63331421.806981154	1.171348	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-12T00:00:00.000Z	sevenseas-api	5.091266392264574	64048945.497798	64036318.88868256	1.17154	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-13T00:00:00.000Z	sevenseas-api	5.26333909909058	64104414.099461	64093168.90313967	1.171705	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-14T00:00:00.000Z	sevenseas-api	5.079414045596171	64238900.171098	64226052.39106378	1.171857	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-15T00:00:00.000Z	sevenseas-api	5.226653186710198	65321355.465228	65312735.005947255	1.172179	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-16T00:00:00.000Z	sevenseas-api	5.224845288760315	66039773.301589	66033129.03999713	1.172349	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-17T00:00:00.000Z	sevenseas-api	5.047972671066351	66537166.345563	66526998.13580207	1.172349	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-18T00:00:00.000Z	sevenseas-api	5.0982805191157645	67001447.737081	66990294.67609069	1.172571	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-19T00:00:00.000Z	sevenseas-api	5.395237385648899	67423454.201501	67414689.15245481	1.172856	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-20T00:00:00.000Z	sevenseas-api	5.053103368564245	68180472.45167	68167414.52758606	1.172856	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-21T00:00:00.000Z	sevenseas-api	5.378101977303218	69975858.742105	69967862.60072654	1.173168	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-22T00:00:00.000Z	sevenseas-api	5.192940826001413	70109286.629397	70102627.64935294	1.173168	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-23T00:00:00.000Z	sevenseas-api	5.416136355401316	70023419.501787	70019393.85539985	1.17354	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-24T00:00:00.000Z	sevenseas-api	5.2532320901262874	70242120.822891	70235799.03201693	1.173717	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-25T00:00:00.000Z	sevenseas-api	5.090145932631396	70910188.086361	70900535.79155868	1.173717	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-26T00:00:00.000Z	sevenseas-api	5.138300305160418	71369411.109103	71365782.68824221	1.173939	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-27T00:00:00.000Z	sevenseas-api	5.145851757958786	72121649.613607	72114871.62097631	1.174123	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-28T00:00:00.000Z	sevenseas-api	5.282172603315974	72197076.725833	72193414.89010146	1.174254	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-29T00:00:00.000Z	sevenseas-api	5.171465852190267	72268190.820877	72267160.27647589	1.174475	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-30T00:00:00.000Z	sevenseas-api	5.345200472450935	72438723.716027	72433653.00536688	1.174642	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-08-31T00:00:00.000Z	sevenseas-api	5.183509739525338	72970310.510435	72965932.29180437	1.174822	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-01T00:00:00.000Z	sevenseas-api	1.6766827395475932	58.41786935	3669556.573332412	1.0322854	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-02T00:00:00.000Z	sevenseas-api	1.6567382455317043	58.54817156	3672196.9410061818	1.03232637	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-03T00:00:00.000Z	sevenseas-api	1.7075564822248441	58.67968313	3723555.0876208595	1.03236943	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-04T00:00:00.000Z	sevenseas-api	1.6870444171732446	58.71417442	3728400.765110465	1.03241023	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-05T00:00:00.000Z	sevenseas-api	1.6053435207098528	58.77910597	3772433.7928349627	1.03245621	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-06T00:00:00.000Z	sevenseas-api	1.5414142094172023	59.06154748	3816272.98741167	1.03245621	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-07T00:00:00.000Z	sevenseas-api	1.5818485865690641	59.0799009	3790408.666713412	1.03254519	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-08T00:00:00.000Z	sevenseas-api	1.5818485865690641	59.00205671	3826488.4759177123	1.03254519	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-09T00:00:00.000Z	sevenseas-api	1.5676277270881722	59.42432524	3856141.267049416	1.03258995	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-10T00:00:00.000Z	sevenseas-api	1.5999812434475902	59.43771033	3866301.8040374266	1.03267583	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-11T00:00:00.000Z	sevenseas-api	1.4738937473065428	59.44776477	3799375.0113801854	1.03267583	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-12T00:00:00.000Z	sevenseas-api	1.4652754208652863	59.48098452	3780329.2666996056	1.03272353	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-13T00:00:00.000Z	sevenseas-api	1.5127634373224432	60.07652523	3806641.006262569	1.03276379	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-14T00:00:00.000Z	sevenseas-api	1.4664373169575065	61.58329409	3900486.553573554	1.03280339	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-15T00:00:00.000Z	sevenseas-api	1.5100709026372061	62.21237847	3916291.869992263	1.0328847	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-16T00:00:00.000Z	sevenseas-api	1.5141379683869378	64.55965119	4071819.4472837774	1.03292963	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-17T00:00:00.000Z	sevenseas-api	1.4644041516160424	65.84868246	4140185.7047609636	1.03292963	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-18T00:00:00.000Z	sevenseas-api	1.4263123123837558	67.06217856	4317445.581445787	1.03294042	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-19T00:00:00.000Z	sevenseas-api	1.5133408186830177	66.99304542	4333442.463270883	1.03301422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-20T00:00:00.000Z	sevenseas-api	1.4139327409800284	67.54770848	4682687.67586401	1.03301422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-21T00:00:00.000Z	sevenseas-api	1.5036897776516622	67.59802308	4944014.755933545	1.03309034	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-22T00:00:00.000Z	sevenseas-api	1.4493487628256307	67.62419852	5294010.446779846	1.03309034	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-23T00:00:00.000Z	sevenseas-api	1.5110419127319215	67.67034305	5210998.205829911	1.03318114	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-24T00:00:00.000Z	sevenseas-api	1.4621062762273003	69.71025199	5406792.000327872	1.03322637	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-25T00:00:00.000Z	sevenseas-api	1.4140905903533265	69.80891587	5496643.516476567	1.03322637	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-26T00:00:00.000Z	sevenseas-api	1.4111874336131147	69.97734681	5491479.288649431	1.03326929	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-27T00:00:00.000Z	sevenseas-api	1.3574069359924334	70.57473222	5581771.097720888	1.03326929	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-28T00:00:00.000Z	sevenseas-api	1.386794570415343	71.44203604	5736680.295914297	1.03329422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-29T00:00:00.000Z	sevenseas-api	1.2903839737125018	71.72272394	5572295.481205445	1.03329422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-30T00:00:00.000Z	sevenseas-api	1.2903839737125018	72.77033467	5694192.255600692	1.03329422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-08-31T00:00:00.000Z	sevenseas-api	1.1890100031120823	74.44062796	5768145.555532376	1.03329422	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-01T00:00:00.000Z	sevenseas-api	3.6332988511179347	28428.04709603056	58242477.63053587	1.1009863609786943	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-02T00:00:00.000Z	sevenseas-api	3.6136734812840188	28417.332917985485	57711695.22440155	1.1010856904159134	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-03T00:00:00.000Z	sevenseas-api	3.7228352272766068	28394.30402419174	58813879.17457723	1.101184189451339	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-04T00:00:00.000Z	sevenseas-api	3.7136752793637	28391.546661673772	57980220.971294746	1.1012864760719598	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-05T00:00:00.000Z	sevenseas-api	3.580271510977924	28443.308864766324	58559812.20391635	1.1013890474541321	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-06T00:00:00.000Z	sevenseas-api	3.4596784342208178	28588.261433566553	59954366.309068054	1.1013890474541321	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-07T00:00:00.000Z	sevenseas-api	3.557107463199112	28941.36893940977	60455147.99887842	1.101589292846629	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-08T00:00:00.000Z	sevenseas-api	3.557107463199112	29100.726062981954	61318210.84863014	1.101589292846629	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-09T00:00:00.000Z	sevenseas-api	3.539280506629309	29245.277133505875	61643784.93386246	1.1016868521690844	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-10T00:00:00.000Z	sevenseas-api	3.628694898445757	29277.93737654795	61527984.79495643	1.1018806910514212	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-11T00:00:00.000Z	sevenseas-api	3.3823711100530174	29360.029879302914	60562731.6324413	1.1018806910514212	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-12T00:00:00.000Z	sevenseas-api	3.375277900425222	29366.662902442917	60831936.21192168	1.1019902121071572	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-13T00:00:00.000Z	sevenseas-api	3.4480720279532044	29423.26240448224	60722078.76229324	1.10205596264663	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-14T00:00:00.000Z	sevenseas-api	3.3065992063500915	29683.98680804047	61621194.89588564	1.1021439496247116	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-15T00:00:00.000Z	sevenseas-api	3.341668932414928	29763.15607041123	61558890.367760085	1.1022963449344603	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-16T00:00:00.000Z	sevenseas-api	3.309396180425465	30289.496727412858	62792553.013204664	1.1023814320085856	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-17T00:00:00.000Z	sevenseas-api	3.181929263113459	32136.591224587555	66281840.49794306	1.1023814320085856	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-18T00:00:00.000Z	sevenseas-api	3.193476678991636	32158.142932379935	67729298.09028055	1.1025047427006105	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-19T00:00:00.000Z	sevenseas-api	3.339314917670118	32214.523842516643	68030861.63767801	1.1026365507203146	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-20T00:00:00.000Z	sevenseas-api	3.0940462278563357	32233.27805191144	80190372.23916404	1.1026365507203146	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-21T00:00:00.000Z	sevenseas-api	3.2941564744207765	32238.901463809772	82826057.28257586	1.1028174459317304	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-22T00:00:00.000Z	sevenseas-api	3.1589647360812525	32264.929467288082	89453320.00859497	1.1028174459317304	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-23T00:00:00.000Z	sevenseas-api	3.2543241751461873	32292.454101168838	86012053.53967592	1.1030125379932738	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-24T00:00:00.000Z	sevenseas-api	3.1129333808164295	32307.755023445017	87332408.82587542	1.1031026343243306	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-25T00:00:00.000Z	sevenseas-api	3.0069807346569055	32350.871818951968	88593058.54473403	1.1031026343243306	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-26T00:00:00.000Z	sevenseas-api	3.015272406569628	32494.78730677608	87273431.29157205	1.1032168321068823	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-27T00:00:00.000Z	sevenseas-api	2.998546186883333	32535.941962092147	89759626.43901183	1.1033108037206536	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-28T00:00:00.000Z	sevenseas-api	3.074377797415632	32610.838550857112	90381838.73964942	1.1033794010982636	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-29T00:00:00.000Z	sevenseas-api	2.9825751324953056	32615.796807449868	87679333.63174488	1.1034932359494052	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-30T00:00:00.000Z	sevenseas-api	3.0766285786838523	32677.5479766038	88583060.86478655	1.1035783320066401	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-08-31T00:00:00.000Z	sevenseas-api	2.964270502732539	32711.599597314253	87083366.70177366	1.1036687895215107	assets_per_share
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
