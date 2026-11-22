-- Generated from VAULT_MORPHO/747474/2026-03.ndjson (74 vault rows)
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
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-01T00:00:00.000Z	morpho-api	3.6033216122888234	\N	99940.05004777739	1.000527319005713	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-02T00:00:00.000Z	morpho-api	9.439281711465242	\N	100308.8917064886	1.000575140707289	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-03T00:00:00.000Z	morpho-api	1.106292158681299	\N	100089.79658378712	1.000589923926149	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-04T00:00:00.000Z	morpho-api	0.048121884077545474	\N	121.0861071456866	1.000591243108668	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-05T00:00:00.000Z	morpho-api	0.5386560157916165	\N	121.16251720037741	1.000606009640747	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-06T00:00:00.000Z	morpho-api	0.6843171117765223	\N	121.08629122475176	1.000624769585477	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-07T00:00:00.000Z	morpho-api	0.6447962739741797	\N	121.29711395895477	1.00064244643071	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-08T00:00:00.000Z	morpho-api	1.5268142078639357	\N	121.10160864213199	1.000659197267212	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-09T00:00:00.000Z	morpho-api	1.4843236527894987	\N	120.88916336185791	1.000675055166723	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-10T00:00:00.000Z	morpho-api	0.60465502365048	\N	120.95113278128028	1.000691632376588	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-11T00:00:00.000Z	morpho-api	1.2862194925133963	\N	121.08096729995316	1.000703331504747	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-12T00:00:00.000Z	morpho-api	0.5150740378212504	\N	120.91655539748439	1.000717453137889	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-13T00:00:00.000Z	morpho-api	2.6400716524932477	\N	121.08085346236986	1.000770847462731	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-14T00:00:00.000Z	morpho-api	2.2238812871222535	\N	121.12557684547117	1.000812782429531	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-15T00:00:00.000Z	morpho-api	2.3780594005984312	\N	121.05247033388765	1.000858719076917	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-16T00:00:00.000Z	morpho-api	2.339122562844409	\N	121.13816112550114	1.000922861717382	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-17T00:00:00.000Z	morpho-api	3.0573746990114614	\N	121.36049082861368	1.000977942700983	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-18T00:00:00.000Z	morpho-api	1.2559642286191774	\N	121.01767944923463	1.001012386918587	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-19T00:00:00.000Z	morpho-api	0.6533553058574171	\N	121.05103726429505	1.001023771865213	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-20T00:00:00.000Z	morpho-api	0.9752422677422601	\N	121.34242192304694	1.001044408631209	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-21T00:00:00.000Z	morpho-api	1.329838834251973	\N	121.00212155043377	1.001074214537226	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-22T00:00:00.000Z	morpho-api	1.2400904910947474	\N	121.0554173283175	1.001101490455103	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-23T00:00:00.000Z	morpho-api	1.2687863208071803	\N	121.02911477697305	1.00112876637298	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-24T00:00:00.000Z	morpho-api	1.3256857116061838	\N	120.8492372036947	1.001156869084367	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-25T00:00:00.000Z	morpho-api	1.2846173436997788	\N	121.25948658905703	1.001184723757701	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-26T00:00:00.000Z	morpho-api	1.2801091994418812	\N	121.04459055212232	1.001211958335903	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-27T00:00:00.000Z	morpho-api	1.288442754088237	\N	121.27391361543361	1.001239639382601	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-28T00:00:00.000Z	morpho-api	1.3396547966948447	\N	120.8837567140904	1.001268717710329	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-29T00:00:00.000Z	morpho-api	1.544257182928277	\N	120.97614758413154	1.001303459573597	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-30T00:00:00.000Z	morpho-api	1.5631881677080628	\N	120.84000924186378	1.00133908610592	assets_per_share
VAULT_MORPHO	747474	0x6a31358e58b8692ce5317181ff3379a5766a7aba	2026-03-31T00:00:00.000Z	morpho-api	1.4732955751384225	\N	121.0933038705802	1.001372017291402	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-20T00:00:00.000Z	morpho-api	\N	\N	1.0257217640723546e-8	1.000018953877	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-21T00:00:00.000Z	morpho-api	3.5992224081127233	\N	1.0571915756961839e-8	1.0001175694459998	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-22T00:00:00.000Z	morpho-api	3.599212604754598	\N	9.861390816110175e-9	1.0002161944749999	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-23T00:00:00.000Z	morpho-api	3.599203501636339	\N	1.1563529037642917e-8	1.0003148289659998	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-24T00:00:00.000Z	morpho-api	3.582550397140949	\N	1.2526357496951934e-8	1.0004130167499996	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-25T00:00:00.000Z	morpho-api	3.599249017227635	\N	1.0738889820060394e-8	1.0005116719129994	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-26T00:00:00.000Z	morpho-api	3.5992560196262957	\N	1.1259648354214319e-8	1.0006103369849995	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-27T00:00:00.000Z	morpho-api	1.6139814668747476	\N	13.9277019920713	1.0006545836135492	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-28T00:00:00.000Z	morpho-api	0.4980925208286635	\N	1.193919170598332e-8	1.0006682390089994	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-29T00:00:00.000Z	morpho-api	3.5758091879500853	\N	1.2117036030488872e-8	1.0007662766559993	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-30T00:00:00.000Z	morpho-api	3.5758392982643272	\N	1.1327540354499567e-8	1.000864324724999	assets_per_share
VAULT_MORPHO	747474	0x9b1ae9548e4b46ceb6650f6cec702baf5cf2b8cc	2026-03-31T00:00:00.000Z	morpho-api	2.39447442353935	\N	7.521751624164836	1.0009299856221323	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-01T00:00:00.000Z	morpho-api	4.0489262534748605	\N	1576973.7309402565	1.003867908971104	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-02T00:00:00.000Z	morpho-api	11.389394419580867	\N	1582846.9404274374	1.003973953643587	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-03T00:00:00.000Z	morpho-api	4.416151645969535	\N	1179544.4154254126	1.004080343217231	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-04T00:00:00.000Z	morpho-api	3.706779951784256	\N	1707256.8418248831	1.004182318399194	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-05T00:00:00.000Z	morpho-api	3.310830719982505	\N	2845575.6512478245	1.004273409580762	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-06T00:00:00.000Z	morpho-api	2.4532385531017553	\N	4765995.228416641	1.004340911095697	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-07T00:00:00.000Z	morpho-api	3.1480928743832237	\N	4768691.942405234	1.004404780781452	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-08T00:00:00.000Z	morpho-api	3.215697532255035	\N	4761308.176061256	1.00446849501582	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-09T00:00:00.000Z	morpho-api	3.1213514141370524	\N	4753170.6409263965	1.004529872104527	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-10T00:00:00.000Z	morpho-api	2.6880289802022617	\N	3957254.041878742	1.004603853060699	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-11T00:00:00.000Z	morpho-api	3.95424472046102	\N	3961562.620929676	1.004689660054865	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-12T00:00:00.000Z	morpho-api	3.9539919338693608	\N	3045132.4300574353	1.004798502529813	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-13T00:00:00.000Z	morpho-api	4.607221196550881	\N	3049678.038408887	1.004906644804772	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-14T00:00:00.000Z	morpho-api	4.656969737837358	\N	3050038.6278962223	1.00501620634602	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-15T00:00:00.000Z	morpho-api	4.690034364074336	\N	3048392.1780293644	1.005126444194314	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-16T00:00:00.000Z	morpho-api	6.427120800367447	\N	2806203.443350372	1.00530344797857	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-17T00:00:00.000Z	morpho-api	7.597038153761559	\N	2811702.0504830764	1.005485107370758	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-18T00:00:00.000Z	morpho-api	3.94549802429367	\N	2804529.176991036	1.005593802005434	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-19T00:00:00.000Z	morpho-api	5.609038267451183	\N	2805685.166394747	1.005742099235177	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-20T00:00:00.000Z	morpho-api	5.730644723556111	\N	2812973.3770347205	1.005894214915744	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-21T00:00:00.000Z	morpho-api	7.211948942043023	\N	2805537.651077501	1.006086669879425	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-22T00:00:00.000Z	morpho-api	7.813860425898156	\N	2807280.117135305	1.006295734456408	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-23T00:00:00.000Z	morpho-api	4.389101379942417	\N	2806347.473545425	1.006409416895578	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-24T00:00:00.000Z	morpho-api	3.0104187143109584	\N	2806213.091483542	1.006484321980265	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-25T00:00:00.000Z	morpho-api	2.8272590732569824	\N	3072314.2726793108	1.006554978924951	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-26T00:00:00.000Z	morpho-api	2.7964233105137737	\N	3066997.290798885	1.006624296122284	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-27T00:00:00.000Z	morpho-api	2.906700585825206	\N	3072840.1379674473	1.006696882382192	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-28T00:00:00.000Z	morpho-api	2.8230065165502083	\N	3063079.163138066	1.006767146861417	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-29T00:00:00.000Z	morpho-api	2.8240876869034537	\N	3065528.0441284655	1.006837480061793	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-30T00:00:00.000Z	morpho-api	2.811846793804307	\N	3062183.337710312	1.006907839713293	assets_per_share
VAULT_MORPHO	747474	0xe9f691cf56a15e662764d2a8245c1cf2c909a4d9	2026-03-31T00:00:00.000Z	morpho-api	2.8103902948828363	\N	3053896.739449794	1.006977941860997	assets_per_share
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
