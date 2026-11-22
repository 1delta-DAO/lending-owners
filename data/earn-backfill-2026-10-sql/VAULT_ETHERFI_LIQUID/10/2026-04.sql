-- Generated from VAULT_ETHERFI_LIQUID/10/2026-04.ndjson (87 vault rows)
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
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-02T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.151057	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-03T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.151057	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-04T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.151057	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-05T00:00:00.000Z	sevenseas-api	\N	0.019998	0.01999620018	1.151057	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-06T00:00:00.000Z	sevenseas-api	\N	27.673004	27.671343619760002	1.151993	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-07T00:00:00.000Z	sevenseas-api	\N	90.782907	90.7738287093	1.152124	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-08T00:00:00.000Z	sevenseas-api	\N	50895965.734905	50888840.299702115	1.152124	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-09T00:00:00.000Z	sevenseas-api	5.979597137984524	79964838.339351	79958441.15228385	1.152377	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-10T00:00:00.000Z	sevenseas-api	5.814818466852778	80542946.218035	80528822.2069862	1.152524	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-11T00:00:00.000Z	sevenseas-api	5.633807303489884	80262626.965842	80250024.9307821	1.152656	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-12T00:00:00.000Z	sevenseas-api	5.070426573140896	61087747.365714	61078092.44724285	1.152656	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-13T00:00:00.000Z	sevenseas-api	5.37916651627797	60994430.376905	60986501.10095601	1.152923	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-14T00:00:00.000Z	sevenseas-api	5.290282467911838	61050289.981697	61037469.42080084	1.153059	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-15T00:00:00.000Z	sevenseas-api	4.8833376626878495	61095398.589309	61078902.83168989	1.153059	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-16T00:00:00.000Z	sevenseas-api	5.180052520670395	61236402.133694	61222317.76120325	1.153344	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-17T00:00:00.000Z	sevenseas-api	5.139131540257136	61280528.53731	61268885.23688791	1.153488	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-18T00:00:00.000Z	sevenseas-api	5.095398186188927	61386051.664551	61374388.314734735	1.153628	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-19T00:00:00.000Z	sevenseas-api	4.795668881118989	61160394.636137	61150608.972995214	1.153628	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-20T00:00:00.000Z	sevenseas-api	4.5292428321679346	61160394.636137	61149997.369048856	1.153628	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-21T00:00:00.000Z	sevenseas-api	5.013515495117228	61102302.779473	61085194.13469475	1.154061	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-22T00:00:00.000Z	sevenseas-api	4.9879806126023	60845340.746907	60834628.924668506	1.154203	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-23T00:00:00.000Z	sevenseas-api	4.940717635223734	59164724.585396	59154313.368810706	1.154329	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-24T00:00:00.000Z	sevenseas-api	4.899192655098784	58015628.011775	58002135.3171683	1.154456	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-25T00:00:00.000Z	sevenseas-api	4.859899847818509	58502038.317818	58493509.30565164	1.154582	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-26T00:00:00.000Z	sevenseas-api	4.819917693042126	58911481.943742	58904095.6221359	1.154705	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-27T00:00:00.000Z	sevenseas-api	4.627120985320441	59306896.18727	59300055.72986376	1.154705	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-28T00:00:00.000Z	sevenseas-api	4.769913486206547	58650938.692515	58639132.84506558	1.154968	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-29T00:00:00.000Z	sevenseas-api	4.7611954989260425	56907953.259325	56897418.459017634	1.155111	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x08c6f91e2b681faf5e17227f2a44c307b3c1364c	2026-04-30T00:00:00.000Z	sevenseas-api	4.734980233695643	56536887.547887	56525181.58532021	1.155238	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-02T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.02560116	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-03T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.02560116	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-04T00:00:00.000Z	sevenseas-api	\N	\N	\N	1.02560116	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-05T00:00:00.000Z	sevenseas-api	\N	0.00000399	0.2686512404181858	1.02560116	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-06T00:00:00.000Z	sevenseas-api	\N	0.00001399	0.9667037266094	1.02599244	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-07T00:00:00.000Z	sevenseas-api	\N	0.00238366	163.7578233856	1.02604748	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-08T00:00:00.000Z	sevenseas-api	\N	34.1674336	2462309.586468928	1.02604748	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-09T00:00:00.000Z	sevenseas-api	2.817266843630817	49.48205404	3509285.0860562543	1.02615529	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-10T00:00:00.000Z	sevenseas-api	2.730468099315375	49.72344786	3570113.075874462	1.02621494	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-11T00:00:00.000Z	sevenseas-api	2.6460334736753377	44.18812274	3223317.650069007	1.02627031	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-12T00:00:00.000Z	sevenseas-api	2.381430126307804	44.19106519	3224622.4688249514	1.02627031	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-13T00:00:00.000Z	sevenseas-api	2.5278136740445323	44.24190934	3129126.6925502154	1.02638247	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-14T00:00:00.000Z	sevenseas-api	2.4833922769743983	46.59129564	3474848.8161379015	1.02643852	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-15T00:00:00.000Z	sevenseas-api	2.2923621018225213	46.25683629	3430938.0997981136	1.02643852	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-16T00:00:00.000Z	sevenseas-api	2.4053255193838674	46.28514985	3462625.499910712	1.02654737	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-17T00:00:00.000Z	sevenseas-api	2.380279419080951	46.33099788	3476026.2195275677	1.0266044	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-18T00:00:00.000Z	sevenseas-api	2.357630060598137	46.16281727	3556029.8353005117	1.0266611	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-19T00:00:00.000Z	sevenseas-api	2.2189459393864817	46.32177257	3514247.5526555157	1.0266611	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-20T00:00:00.000Z	sevenseas-api	2.095671164976122	46.32177257	3423674.2831584653	1.0266611	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-21T00:00:00.000Z	sevenseas-api	2.3028817146569907	46.35307839	3509258.0680411365	1.02683061	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-22T00:00:00.000Z	sevenseas-api	2.29034037949023	46.3695387	3535374.3916745814	1.02688827	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-23T00:00:00.000Z	sevenseas-api	2.278637568364095	46.3766535	3639575.596099448	1.02694572	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-24T00:00:00.000Z	sevenseas-api	2.2656530182124808	46.55666167	3643712.149539544	1.02700172	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-25T00:00:00.000Z	sevenseas-api	2.247762922644947	46.91987337	3630776.136850627	1.02705382	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-26T00:00:00.000Z	sevenseas-api	2.2340328346223775	46.99927303	3647280.8250052477	1.02710772	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-27T00:00:00.000Z	sevenseas-api	2.1446715212374823	47.01196433	3706651.9185442547	1.02710772	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-28T00:00:00.000Z	sevenseas-api	2.222799522994654	46.72549949	3604793.4373487392	1.02722506	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-29T00:00:00.000Z	sevenseas-api	2.215935228408494	46.9450278	3580589.9998805127	1.02728231	assets_per_share
VAULT_ETHERFI_LIQUID	10	0x5f46d540b6ed704c3c8789105f30e075aa900726	2026-04-30T00:00:00.000Z	sevenseas-api	2.199850559563034	47.00292998	3562073.036087245	1.02733192	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-02T00:00:00.000Z	sevenseas-api	\N	0.009999999999999998	233573767553.20972	1.0287355183912503	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-03T00:00:00.000Z	sevenseas-api	\N	0.009999999999999998	224654362392.71976	1.0287355183912503	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-04T00:00:00.000Z	sevenseas-api	\N	0.009999999999999998	223787703279.65106	1.0287355183912503	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-05T00:00:00.000Z	sevenseas-api	\N	0.009999999999999998	225596378598.92715	1.0287355183912503	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-06T00:00:00.000Z	sevenseas-api	\N	0.011590685666869946	267592518224.25162	1.0894813151887885	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-07T00:00:00.000Z	sevenseas-api	\N	0.15018403808730235	3445323645102.611	1.089588191873222	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-08T00:00:00.000Z	sevenseas-api	\N	34954.87434563458	856703082287916400	1.089588191873222	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-09T00:00:00.000Z	sevenseas-api	309.4274956479838	38524.426797061235	919016397872485100	1.089783008418087	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-10T00:00:00.000Z	sevenseas-api	271.23681804529133	38538.566551252	919655417073023200	1.0898929865816318	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-11T00:00:00.000Z	sevenseas-api	241.51283774793052	38555.977719190116	944845969527529300	1.089997861104917	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-12T00:00:00.000Z	sevenseas-api	217.36155397313746	38610.77228106985	964175194539840800	1.089997861104917	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-13T00:00:00.000Z	sevenseas-api	198.2836432337914	38570.32341222387	921831538444020400	1.0902093729560947	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-14T00:00:00.000Z	sevenseas-api	182.07574409277098	38556.827086798454	997978220576346200	1.0903161600304008	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-15T00:00:00.000Z	sevenseas-api	168.0699176240963	38541.92576046379	976252742797652600	1.0903161600304008	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-16T00:00:00.000Z	sevenseas-api	156.59967310336768	38559.25919125288	990241155340123900	1.0905271633901135	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-17T00:00:00.000Z	sevenseas-api	146.40589602648754	38577.03514818779	988985232273473400	1.0906312493546795	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-18T00:00:00.000Z	sevenseas-api	137.477911716823	38609.296981127794	1019674325167830500	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-19T00:00:00.000Z	sevenseas-api	129.39097573348047	38614.40644110011	986106704116087400	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-20T00:00:00.000Z	sevenseas-api	122.20258819273155	38614.40644110011	947244608301505700	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-21T00:00:00.000Z	sevenseas-api	115.77087302469305	38118.018875262766	955954682523405300	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-22T00:00:00.000Z	sevenseas-api	109.9823293734584	38125.00139158196	963170345746585600	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-23T00:00:00.000Z	sevenseas-api	104.74507559376991	38129.939670982974	988404677675570000	1.0907315340744732	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-24T00:00:00.000Z	sevenseas-api	100.5985091236116	38112.285336581896	966212673438352000	1.0911126062684733	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-25T00:00:00.000Z	sevenseas-api	96.42962949730315	38152.92777058433	961682000116403800	1.0912454759926542	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-26T00:00:00.000Z	sevenseas-api	92.50130191045601	38178.41554603452	965180137198611200	1.0913060661870104	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-27T00:00:00.000Z	sevenseas-api	88.80124983403776	38198.48521803721	985603930376388500	1.0913060661870104	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-28T00:00:00.000Z	sevenseas-api	85.38581714811325	38234.7898178756	961659009943211500	1.0913060661870104	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-29T00:00:00.000Z	sevenseas-api	82.2233794759609	38245.91909399624	953078649974893600	1.0913060661870104	assets_per_share
VAULT_ETHERFI_LIQUID	10	0xf0bb20865277abd641a307ece5ee04e79073416c	2026-04-30T00:00:00.000Z	sevenseas-api	79.2868302089623	38256.11419367478	940745730693101000	1.0913060661870104	assets_per_share
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
