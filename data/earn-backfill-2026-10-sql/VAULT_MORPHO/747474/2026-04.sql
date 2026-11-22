-- Generated from VAULT_MORPHO/747474/2026-04.ndjson (109 vault rows)
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
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-25T00:00:00.000Z	morpho-api	\N	\N	1.000023917464949	1.000114999885	assets_per_share
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-26T00:00:00.000Z	morpho-api	3.920649312405544	\N	0.9999251343213299	1.000206999793	assets_per_share
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-27T00:00:00.000Z	morpho-api	3.859578592724233	\N	1.0023180766640953	1.000298999701	assets_per_share
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-28T00:00:00.000Z	morpho-api	3.8368635117080885	\N	1.0006064124905565	1.000390999609	assets_per_share
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-29T00:00:00.000Z	morpho-api	3.6506998416285796	\N	1.0003421208153827	1.000477999522	assets_per_share
VAULT_MORPHO	747474	0xca44cbe1fb03691d43d2d93aa460e2fcb03878fe	2026-04-30T00:00:00.000Z	morpho-api	3.8299283360743175	\N	1.0024320429379532	1.00056999943	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-25T00:00:00.000Z	morpho-api	\N	\N	1.0000790885686601	1.000076999923	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-26T00:00:00.000Z	morpho-api	5.269977922850444	\N	1.0002249764325937	1.000206999793	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-27T00:00:00.000Z	morpho-api	5.014620750642962	\N	1.0005960965566385	1.000332999667	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-28T00:00:00.000Z	morpho-api	4.9418476223195285	\N	1.0006478583729754	1.000457999542	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-29T00:00:00.000Z	morpho-api	2.7318268831066916	\N	1.0005404554476962	1.000521999478	assets_per_share
VAULT_MORPHO	747474	0x4284d4f9f4d61ea57b8f0943547c7c19c5b9b249	2026-04-30T00:00:00.000Z	morpho-api	3.949628739263744	\N	1.0004318311986014	1.00061999938	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-01T00:00:00.000Z	morpho-api	1.0616973828092569	\N	121.12600583848757	1.001401145226741	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-02T00:00:00.000Z	morpho-api	1.0086290043176405	\N	121.04663231696487	1.001428818005503	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-03T00:00:00.000Z	morpho-api	1.6266249978968972	\N	120.9808111182265	1.001467578085227	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-04T00:00:00.000Z	morpho-api	1.2458653692704047	\N	121.249187644492	1.001495713868354	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-05T00:00:00.000Z	morpho-api	1.1894960600500326	\N	121.01736115930805	1.001522047241631	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-06T00:00:00.000Z	morpho-api	1.1553859756929796	\N	121.38554252629032	1.001547777055645	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-07T00:00:00.000Z	morpho-api	1.2468793165965053	\N	121.1188971112338	1.001576227020306	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-08T00:00:00.000Z	morpho-api	1.299805546395305	\N	120.84497275616145	1.00160581796001	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-09T00:00:00.000Z	morpho-api	1.2400015606317538	\N	15.984342396344044	1.001632642322496	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-10T00:00:00.000Z	morpho-api	1.2143475728976227	\N	15.993302127805592	1.001659405980236	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-11T00:00:00.000Z	morpho-api	1.2000031592407367	\N	15.988416573699917	1.001685731914602	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-12T00:00:00.000Z	morpho-api	1.1788804236800843	\N	15.98942367386039	1.001712057848967	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-13T00:00:00.000Z	morpho-api	1.304759743447903	\N	16.05037924432883	1.00174213569797	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-14T00:00:00.000Z	morpho-api	1.293029325211137	\N	16.00863966095606	1.001771150504491	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-15T00:00:00.000Z	morpho-api	1.2479338778348392	\N	15.977403095088857	1.001797851630321	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-16T00:00:00.000Z	morpho-api	1.3306322060202547	\N	16.02451746452079	1.001825365670988	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-17T00:00:00.000Z	morpho-api	1.7863756202274317	\N	16.03421740476092	1.001864573178939	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-18T00:00:00.000Z	morpho-api	1.9960967598819934	\N	15.995567968057568	1.001908220452543	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-19T00:00:00.000Z	morpho-api	1.2806791946928797	\N	16.043815846977143	1.001932545365769	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-20T00:00:00.000Z	morpho-api	3.432896533439589	\N	16.05508590514933	1.002015587743056	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-21T00:00:00.000Z	morpho-api	5.41028568505908	\N	16.005445022949306	1.00215090679761	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-22T00:00:00.000Z	morpho-api	6.285890822255169	\N	16.0392686257137	1.002307736829414	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-23T00:00:00.000Z	morpho-api	7.24529506470617	\N	16.04515528340105	1.002492956348633	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-24T00:00:00.000Z	morpho-api	8.457906742975752	\N	16.03218461290172	1.002705689908519	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-25T00:00:00.000Z	morpho-api	8.241891847404759	\N	16.036678938018323	1.002907605447871	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-26T00:00:00.000Z	morpho-api	4.246564754240012	\N	16.03508312377288	1.003009157270697	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-27T00:00:00.000Z	morpho-api	4.132807286794105	\N	16.07340218014134	1.003109020731937	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-28T00:00:00.000Z	morpho-api	4.137146673244274	\N	16.04592584140324	1.003209572044194	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-29T00:00:00.000Z	morpho-api	3.9780815857426433	\N	16.041672098304492	1.003305871186529	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-04-30T00:00:00.000Z	morpho-api	4.1815285761970244	\N	16.075181778354953	1.00340786073273	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-24T00:00:00.000Z	morpho-api	\N	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-25T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-26T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-27T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-28T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-29T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x5920a6fc553af799542eda628adfcc9ea52e141c	2026-04-30T00:00:00.000Z	morpho-api	0	\N	0	1	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-01T00:00:00.000Z	morpho-api	0	\N	7.130046619670778	1.0009299856229	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-02T00:00:00.000Z	morpho-api	0	\N	6.82504116053747	1.000929985623639	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-03T00:00:00.000Z	morpho-api	0	\N	6.061599698006809	1.0009299856243514	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-04T00:00:00.000Z	morpho-api	0	\N	5.997756474156209	1.000929985625038	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-05T00:00:00.000Z	morpho-api	0.00002240767571493052	\N	6.197107716908871	1.0009299862422372	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-06T00:00:00.000Z	morpho-api	0.00017856116585335258	\N	5.823908480319483	1.000929991140109	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-07T00:00:00.000Z	morpho-api	0.00017015828746025363	\N	5.7297994103028325	1.0009299958151698	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-08T00:00:00.000Z	morpho-api	0.00016315588879933784	\N	6.0186215313469145	1.0009300002799328	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-09T00:00:00.000Z	morpho-api	0.00015545325027233048	\N	5.885840987583936	1.0009300045464924	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-10T00:00:00.000Z	morpho-api	0.0001484508516114147	\N	5.766515723187107	1.0009300086110158	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-11T00:00:00.000Z	morpho-api	0.0001414484529504989	\N	5.793155754759311	1.000930012490484	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-12T00:00:00.000Z	morpho-api	0.0001351462941556747	\N	5.713258492016494	1.0009300161952415	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-13T00:00:00.000Z	morpho-api	0.0001288441353608505	\N	5.312222116868941	1.0009300197356341	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-14T00:00:00.000Z	morpho-api	0.00012324221643211786	\N	5.57033757497002	1.0009300231220113	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-15T00:00:00.000Z	morpho-api	0.0001183405373694768	\N	5.39494600705261	1.0009300263647247	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-16T00:00:00.000Z	morpho-api	2.4336591462059687	\N	5.501603416456289	1.0009967661868935	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-17T00:00:00.000Z	morpho-api	1.5516384113567483	\N	5.778707551176161	1.0010393201098078	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-18T00:00:00.000Z	morpho-api	1.5469370008958094	\N	6.39878083291176	1.0010817468877438	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-19T00:00:00.000Z	morpho-api	1.5422509957119246	\N	6.5147519823093445	1.00112404694605	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-20T00:00:00.000Z	morpho-api	1.1829278101060936	\N	29.011159969778095	1.0011564928805015	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-21T00:00:00.000Z	morpho-api	1.5628044362614446	\N	30.85565961542055	1.0011993598705866	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-22T00:00:00.000Z	morpho-api	3.3272338388457	\N	31.61287511828654	1.0012906304605869	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-23T00:00:00.000Z	morpho-api	7.726269521768359	\N	31.562955655487144	1.0015026047040358	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-24T00:00:00.000Z	morpho-api	8.793851020172383	\N	172.5226151783283	1.0017439232082017	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-25T00:00:00.000Z	morpho-api	2.9101695741218236	\N	904.7639698887152	1.0018237961096854	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-26T00:00:00.000Z	morpho-api	9.739931098451393	\N	567.4212416075717	1.0020911658768032	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-27T00:00:00.000Z	morpho-api	11.926128276940062	\N	528.5121189809837	1.0024186458882018	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-28T00:00:00.000Z	morpho-api	4.577879745681912	\N	489.10135020234907	1.0025443784872798	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-29T00:00:00.000Z	morpho-api	5.120243531564483	\N	494.78597919582023	1.002685025917333	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-04-30T00:00:00.000Z	morpho-api	14.46610414177485	\N	529.1913886295803	1.003082500450064	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-01T00:00:00.000Z	morpho-api	2.63453695659166	\N	2809420.213608157	1.007050627243487	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-02T00:00:00.000Z	morpho-api	2.513466884224158	\N	2807694.963139733	1.007119977263075	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-03T00:00:00.000Z	morpho-api	3.7093057169812482	\N	1807454.0957007115	1.007216549292967	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-04T00:00:00.000Z	morpho-api	3.441501080914122	\N	1911679.378864741	1.007305570879594	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-05T00:00:00.000Z	morpho-api	3.073689587651529	\N	1908123.5082505578	1.007384177097915	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-06T00:00:00.000Z	morpho-api	3.0061353470500762	\N	1913846.0215035633	1.007461250295065	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-07T00:00:00.000Z	morpho-api	2.134209970350298	\N	4509331.384382312	1.007514412324814	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-08T00:00:00.000Z	morpho-api	2.2388986312904535	\N	4498176.992123605	1.007570158923795	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-09T00:00:00.000Z	morpho-api	2.7715647952675226	\N	2005203.122428223	1.00763953360723	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-10T00:00:00.000Z	morpho-api	2.6826441356320174	\N	2006419.63772359	1.007707090594131	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-11T00:00:00.000Z	morpho-api	2.6275009464171717	\N	2005831.2799457265	1.007773082541585	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-12T00:00:00.000Z	morpho-api	2.5572388782535427	\N	2006033.5442548988	1.007837710049564	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-13T00:00:00.000Z	morpho-api	2.5728731337437694	\N	2013742.5467279973	1.007903061364933	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-14T00:00:00.000Z	morpho-api	2.368715399825305	\N	2608155.1703098905	1.007962029442928	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-15T00:00:00.000Z	morpho-api	2.48963982230066	\N	2104745.1836938383	1.008023281151299	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-16T00:00:00.000Z	morpho-api	2.566914792723196	\N	2110846.257141404	1.008085221744384	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-17T00:00:00.000Z	morpho-api	2.650135499848716	\N	2112174.1536074392	1.008148616623405	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-18T00:00:00.000Z	morpho-api	2.713892339656354	\N	2107456.7081249086	1.008212444970182	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-19T00:00:00.000Z	morpho-api	2.567900030214787	\N	2113849.0588125107	1.008272620039643	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-20T00:00:00.000Z	morpho-api	2.9459742389548182	\N	2115116.0984750735	1.008342681080986	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-21T00:00:00.000Z	morpho-api	7.620181781575752	\N	1509138.8221464439	1.00854020630605	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-22T00:00:00.000Z	morpho-api	8.485902332822093	\N	1512419.695335473	1.008759182965996	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-23T00:00:00.000Z	morpho-api	8.939475003444386	\N	1513072.454546137	1.008992660069162	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-24T00:00:00.000Z	morpho-api	9.708188525081596	\N	1511884.0183763064	1.009241589060781	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-25T00:00:00.000Z	morpho-api	10.463313191877432	\N	1515702.4621856487	1.00950680303086	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-26T00:00:00.000Z	morpho-api	8.516235323341448	\N	1515729.323783273	1.009727393826245	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-27T00:00:00.000Z	morpho-api	8.121559127616251	\N	1519518.5243049397	1.009938828187983	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-28T00:00:00.000Z	morpho-api	8.251942390202771	\N	1516998.066637129	1.010154471694203	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-29T00:00:00.000Z	morpho-api	8.625958008678936	\N	1522888.6365077207	1.010380688127577	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-04-30T00:00:00.000Z	morpho-api	5.200076478217852	\N	816482.5506411757	1.010511828229161	assets_per_share
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
