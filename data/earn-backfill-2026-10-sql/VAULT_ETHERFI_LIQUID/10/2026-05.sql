-- Generated from VAULT_ETHERFI_LIQUID/10/2026-05.ndjson (93 vault rows)
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
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-01T00:00:00.000Z	sevenseas-api	4.571705053223378	56385459.976205	56370235.902011424	1.155238	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-02T00:00:00.000Z	sevenseas-api	4.585263805354412	56609577.554308	56596557.351470515	1.155395	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-03T00:00:00.000Z	sevenseas-api	4.868539669770384	56436642.825141	56427048.59586073	1.155663	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-04T00:00:00.000Z	sevenseas-api	4.868539669770384	56504564.008462	56499368.978847064	1.155663	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-05T00:00:00.000Z	sevenseas-api	5.030260592365609	56651293.353493	56641096.12068938	1.155816	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-06T00:00:00.000Z	sevenseas-api	4.190766205465857	55597086.059024	55588746.49611515	1.155961	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-07T00:00:00.000Z	sevenseas-api	4.201905929107237	55739437.60391	55728289.71638922	1.156103	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-08T00:00:00.000Z	sevenseas-api	4.360309017663673	55855200.478177	55846263.64610049	1.156253	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-09T00:00:00.000Z	sevenseas-api	4.362519094590382	55988297.352409	55981578.75672671	1.156509	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-10T00:00:00.000Z	sevenseas-api	4.206781521830764	56167317.015069	56154795.07341366	1.156509	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-11T00:00:00.000Z	sevenseas-api	4.381518278943131	56171750.479855	56160632.40528252	1.156807	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-12T00:00:00.000Z	sevenseas-api	4.526126326212405	56320080.348513	56307679.79322186	1.156944	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-13T00:00:00.000Z	sevenseas-api	4.243316046836387	56467003.463278	56454032.42791245	1.156944	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-14T00:00:00.000Z	sevenseas-api	4.3863179016280744	56548540.87863	56534403.74341034	1.157216	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-15T00:00:00.000Z	sevenseas-api	4.568861321637952	56487171.717241	56471920.18087734	1.157389	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-16T00:00:00.000Z	sevenseas-api	4.432704668627492	56776065.236032	56759251.572073005	1.157546	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-17T00:00:00.000Z	sevenseas-api	4.436370382700031	56756452.460206	56741863.214101106	1.157694	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-18T00:00:00.000Z	sevenseas-api	4.453760946625022	56998058.498698	56986658.88699826	1.157851	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-19T00:00:00.000Z	sevenseas-api	4.606684303779055	56972392.044581	56956466.55183278	1.157996	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-20T00:00:00.000Z	sevenseas-api	4.6752361535374245	57147887.677023	57130743.31071989	1.158061	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-21T00:00:00.000Z	sevenseas-api	4.216992573760548	57248276.092265	57230100.337088466	1.158061	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-22T00:00:00.000Z	sevenseas-api	4.403052727004327	57367773.807909	57347631.4088473	1.15838	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-23T00:00:00.000Z	sevenseas-api	4.423652182349979	57580715.12865	57561713.49265754	1.158526	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-24T00:00:00.000Z	sevenseas-api	4.449512728650385	57500446.251052	57482621.11271417	1.158678	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-25T00:00:00.000Z	sevenseas-api	4.494339365530897	56870118.605521	56854194.97231146	1.158847	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-26T00:00:00.000Z	sevenseas-api	4.533899711758805	56970858.768689	56951272.757152915	1.159008	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-27T00:00:00.000Z	sevenseas-api	4.697217038117744	56330195.020553	56308495.50282718	1.159163	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-28T00:00:00.000Z	sevenseas-api	4.588698561345368	56446741.38473	56424673.53118564	1.159324	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-29T00:00:00.000Z	sevenseas-api	4.437510045932013	56594244.231586	56564289.46405666	1.159324	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-30T00:00:00.000Z	sevenseas-api	4.635018931164114	56773584.132308	56746290.799472235	1.159639	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-05-31T00:00:00.000Z	sevenseas-api	4.635018931164114	56824490.547383	56801723.247000284	1.159639	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-01T00:00:00.000Z	sevenseas-api	2.123993643716033	47.12454586	3593548.2189185037	1.02733192	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-02T00:00:00.000Z	sevenseas-api	2.1246681962280927	47.3753533	3701013.765177564	1.02739217	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-03T00:00:00.000Z	sevenseas-api	2.2471176807171958	47.54773947	3742947.956931049	1.02749539	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-04T00:00:00.000Z	sevenseas-api	2.2471176807171958	47.23507191	3714826.745364271	1.02749539	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-05T00:00:00.000Z	sevenseas-api	2.3190546768363998	47.37491393	3784173.7384461896	1.02755603	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-06T00:00:00.000Z	sevenseas-api	1.9244227244663494	47.5511661	3844097.6085282685	1.02761527	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-07T00:00:00.000Z	sevenseas-api	1.9263353192974266	47.59397507	3867482.1770465206	1.02767201	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-08T00:00:00.000Z	sevenseas-api	1.9954662981742828	46.16286144	3694383.9155183034	1.02773031	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-09T00:00:00.000Z	sevenseas-api	1.9851904351306273	46.37598534	3716226.195936743	1.02782963	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-10T00:00:00.000Z	sevenseas-api	1.9143548036826643	46.85153693	3783467.0152665954	1.02782963	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-11T00:00:00.000Z	sevenseas-api	1.9891291278481178	46.889558	3866074.9479408106	1.02794816	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-12T00:00:00.000Z	sevenseas-api	2.054498845111004	46.89956252	3835762.407170779	1.0280033	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-13T00:00:00.000Z	sevenseas-api	1.921320648952133	40.65158294	3275734.228960746	1.0280033	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-14T00:00:00.000Z	sevenseas-api	1.9664241556327289	40.63889013	3220144.37612094	1.02809749	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-15T00:00:00.000Z	sevenseas-api	2.0372238173602453	40.62923934	3300350.4904883928	1.02815722	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-16T00:00:00.000Z	sevenseas-api	1.9782098966037776	40.67398735	3215533.4938185834	1.02821646	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-17T00:00:00.000Z	sevenseas-api	1.9722572784610055	40.83899597	3192931.563764772	1.02826856	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-18T00:00:00.000Z	sevenseas-api	1.9689249613786264	41.45891215	3199435.2450774442	1.02832254	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-19T00:00:00.000Z	sevenseas-api	2.0399462880202592	41.46411063	3196206.2352875182	1.02838247	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-20T00:00:00.000Z	sevenseas-api	2.1040586486294437	41.54061144	3184531.442795214	1.02843657	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-21T00:00:00.000Z	sevenseas-api	1.9028630243113371	41.66461141	3223435.9924372546	1.02843657	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-22T00:00:00.000Z	sevenseas-api	1.9631103586372396	42.07126233	3266334.6826499035	1.02854517	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-23T00:00:00.000Z	sevenseas-api	1.9601216118802278	42.08924596	3182554.7632876625	1.02860019	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-24T00:00:00.000Z	sevenseas-api	1.9575861404920365	42.14392419	3229408.9826202774	1.02865414	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-25T00:00:00.000Z	sevenseas-api	1.9683971705917624	42.10075667	3232937.1661208607	1.02871545	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-26T00:00:00.000Z	sevenseas-api	1.9738849786855917	42.94830024	3318003.3610078814	1.02877407	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-27T00:00:00.000Z	sevenseas-api	2.041309909214184	43.88563057	3326440.6820133314	1.02883099	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-28T00:00:00.000Z	sevenseas-api	1.9707576708328602	43.92667317	3256390.584641171	1.02888896	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-29T00:00:00.000Z	sevenseas-api	1.902843532855325	43.96133144	3229732.2574271676	1.02888896	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-30T00:00:00.000Z	sevenseas-api	1.9810218687648318	44.602238	3266978.2146880566	1.02900466	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-05-31T00:00:00.000Z	sevenseas-api	1.9810218687648318	44.6875969	3301143.7469068775	1.02900466	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-01T00:00:00.000Z	sevenseas-api	76.97283023350542	38285.11735258223	942610720604118800	1.0916493772393845	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-02T00:00:00.000Z	sevenseas-api	74.45015690159077	37720.41566776825	942445443610186100	1.0916858094223199	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-03T00:00:00.000Z	sevenseas-api	74.45015690159077	37332.43414484147	944341519952496300	1.0916858094223199	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-04T00:00:00.000Z	sevenseas-api	74.45015690159077	37320.950752549674	945484664414828500	1.0916858094223199	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-05T00:00:00.000Z	sevenseas-api	74.71413386384971	37321.88150509806	956068276033770600	1.091909011458303	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-06T00:00:00.000Z	sevenseas-api	2.7111039783160207	37319.74339888616	959061339790284700	1.091909011458303	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-07T00:00:00.000Z	sevenseas-api	2.591496355756913	37870.05956048206	969574747378926700	1.091909011458303	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-08T00:00:00.000Z	sevenseas-api	2.591496355756913	37935.374643967	948792293867412500	1.091909011458303	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-09T00:00:00.000Z	sevenseas-api	2.7116460456602725	38045.24025840413	959151060642842600	1.0922118624882826	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-10T00:00:00.000Z	sevenseas-api	2.5886018668742885	38219.96882560449	973398253465664300	1.0922118624882826	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-11T00:00:00.000Z	sevenseas-api	2.6906689075526624	38216.848777689964	990890731788624600	1.0924084008480737	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-12T00:00:00.000Z	sevenseas-api	2.7699342744132696	38150.971996040746	976968523092292700	1.092479413790817	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-13T00:00:00.000Z	sevenseas-api	2.533351009531363	38153.617807637485	951967029219871000	1.092479413790817	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-14T00:00:00.000Z	sevenseas-api	2.5751654575787133	38218.67981249349	944229886500213900	1.0926238952466887	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-15T00:00:00.000Z	sevenseas-api	2.662366506056957	38254.93570105534	955760148816760200	1.0927020404896974	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-16T00:00:00.000Z	sevenseas-api	2.53352122535709	37928.711166378336	922666145881410300	1.0927980184985606	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-17T00:00:00.000Z	sevenseas-api	2.519332073170662	37930.54636333913	905204976287910300	1.0928896019189271	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-18T00:00:00.000Z	sevenseas-api	2.5182842197825996	37557.110437984906	874203404558443000	1.0929891549048396	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-19T00:00:00.000Z	sevenseas-api	2.6313049161168647	37357.63373134883	870975296467871700	1.093090477017849	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-20T00:00:00.000Z	sevenseas-api	2.7405979742199604	37269.64113674922	860748425848043100	1.0931884573342285	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-21T00:00:00.000Z	sevenseas-api	2.7405979742199604	37273.73237856731	866770086352579300	1.0931884573342285	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-22T00:00:00.000Z	sevenseas-api	2.95462504979929	37296.422588403686	871494576876746100	1.093380330825034	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-23T00:00:00.000Z	sevenseas-api	3.058161755957467	37318.66111479517	841449571048164100	1.093473150619835	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-24T00:00:00.000Z	sevenseas-api	2.7358869588359607	37267.8184606186	863804155960130300	1.0935661630493867	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-25T00:00:00.000Z	sevenseas-api	2.7019674974423293	37230.24928051192	857570253343027800	1.0936689087114457	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-26T00:00:00.000Z	sevenseas-api	2.7478374572402875	37295.12161186892	861592262393654300	1.0937707771617904	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-27T00:00:00.000Z	sevenseas-api	2.854212164186927	37273.03471570176	845409484740160800	1.0938661914327326	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-28T00:00:00.000Z	sevenseas-api	2.9616770011626103	37248.859680508416	825638545732844300	1.0939625835109463	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-29T00:00:00.000Z	sevenseas-api	2.9616770011626103	37250.95999083221	817597900626151400	1.0939625835109463	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-30T00:00:00.000Z	sevenseas-api	3.1746825622453603	37232.42960801092	818477828772882800	1.0941536418076103	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-05-31T00:00:00.000Z	sevenseas-api	2.7910566233086	37234.39936386495	825373906764050700	1.0941536418076103	assets_per_share
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
