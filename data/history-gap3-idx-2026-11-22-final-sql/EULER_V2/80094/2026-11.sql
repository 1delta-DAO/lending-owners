-- Generated from EULER_V2/80094/2026-11.ndjson (88 rows)
-- Apply with:  psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f <this file>
--
-- Safe to re-run: every insert upserts on (market_id, data_ts).
-- Safe against the markets FK: rows for unknown markets are skipped, not
-- fatal, and the count is echoed before COMMIT.
\set ON_ERROR_STOP on
BEGIN;

DO $$
BEGIN
  IF (SELECT relkind FROM pg_class WHERE oid = to_regclass('lending_snapshots')) IS DISTINCT FROM 'v'
     OR (SELECT relkind FROM pg_class WHERE oid = to_regclass('market_index_snapshots')) IS DISTINCT FROM 'v' THEN
    RAISE EXCEPTION 'this file writes the compact history layout (yield-tracer 0205); lending_snapshots / market_index_snapshots are not views here';
  END IF;
END $$;

CREATE TEMP TABLE _hist_stage (
  market_uid           text,
  data_ts              timestamptz,
  source               text,
  block_number         bigint,
  deposit_rate         numeric,
  variable_borrow_rate numeric,
  total_deposits       numeric,
  total_debt           numeric,
  total_deposits_usd   numeric,
  total_debt_usd       numeric,
  utilization          numeric,
  supply_index         numeric(60,30),
  borrow_index         numeric(60,30),
  index_kind           text
) ON COMMIT DROP;

COPY _hist_stage (market_uid, data_ts, source, block_number, deposit_rate, variable_borrow_rate, total_deposits, total_debt, total_deposits_usd, total_debt_usd, utilization, supply_index, borrow_index, index_kind) FROM stdin;
EULER_V2:80094:0xad9e5e2647efb9137b6b8d688d4906fa51476870	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.307517602220313073349558459873	\N	assets_per_share
EULER_V2:80094:0x6d976915bd9de43de1a60c39e128e320dadda000	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.004619925355182220097270667801	\N	assets_per_share
EULER_V2:80094:0xb758d6ec8111feb9b0ec758a61b7874e5821dffd	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.007264111643407623411789210581	\N	assets_per_share
EULER_V2:80094:0xd538b6aef78e4bdde4fd4576e9e3a403704602bc	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.055724037552208041635483151592	\N	assets_per_share
EULER_V2:80094:0x1371dd58ce95ecd624340f072f97212a2661a280	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.026410268249437207241915291726	\N	assets_per_share
EULER_V2:80094:0x91e1ec1e948f635c127dad41eae1af899399f15a	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.057537885505023035386781460768	\N	assets_per_share
EULER_V2:80094:0x413dfb1814a6b5fe4488c49f86e2a74d285ffd5b	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x85dba39b85218229a4c3b9b037d05cd6eb4cf05d	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x558b16e07b8558b2a54946ca973b7b20b86a8b87	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.570299216192594624164020501501	\N	assets_per_share
EULER_V2:80094:0x3de0ca4af11108c94c9066a935ee67e53b7f9447	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x2cccd307bb616e5f896ab61cae09ef4e5e9fedb7	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.007817217191382176894329200427	\N	assets_per_share
EULER_V2:80094:0xbabf4ce18fbab547ad5939deff825f3e2f8d9402	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x1dfb669df5e70d4238f2cc0a9ee3b1a21ff91bc0	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb8064453b25a91d7a4e8b7e7883a817d5742de34	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x89fd57175eceec45992e07c206e5a864fa6af433	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.039883414186628209081116826286	\N	assets_per_share
EULER_V2:80094:0x66f233ac844c3948a516857ca769872e5941f91c	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.035778172649190276864633844677	\N	assets_per_share
EULER_V2:80094:0x109d6d1799f62216b4a7b0c6e245844abd4dd281	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x027dcafb223f69d41bd413c50854017718419585	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.019691844357001697416853537941	\N	assets_per_share
EULER_V2:80094:0x4f652b92a8cd9e251db4d43b2073f689e94b4dba	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	9.164179104477611940298507462686	\N	assets_per_share
EULER_V2:80094:0x2247b618251b8d913f3fd10b749e7bfa3e3a28db	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.011624714205239030888079233963	\N	assets_per_share
EULER_V2:80094:0xe932da5a4d00536c224f8153f299cdcd8054c444	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.077821008798161045261423200836	\N	assets_per_share
EULER_V2:80094:0x542b1ffd33c239c7afc6511fb8855390aa9c8ac2	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.302795126930619119543712180666	\N	assets_per_share
EULER_V2:80094:0x16c7169421cfb2c78b2d447b9274c61b8b2e846a	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.113592852584556477345245692405	\N	assets_per_share
EULER_V2:80094:0x07346ae3245e04c96e33e8d8e02a638aaa08e719	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.034159106786725250006119843562	\N	assets_per_share
EULER_V2:80094:0x112b77a77753b092306b1c04bd70215fed4e00a1	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.083169025143019957407987036313	\N	assets_per_share
EULER_V2:80094:0x401c4633dca173bf75ac85f2d270d98c063f54cf	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x28c96c7028451454729750171bd3bb95d7261b5a	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x1b33d24c4c78a61da80cfa2d0db72ca0851d5fb1	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.023842024568838624319118314303	\N	assets_per_share
EULER_V2:80094:0x2bf927248f86bd78ce300d00c7c8a175e3e0b38a	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xe318d262290abab80fc6e217c514801e2c0ef999	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.263463603395072557457379397786	\N	assets_per_share
EULER_V2:80094:0x5ba8763891d6a4f934b197b9817757d887b78fec	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xcaa70d2aa873ef057980844e18d9a9560bdffcc0	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.639499305552000017769138492971	\N	assets_per_share
EULER_V2:80094:0xac0476a04c567ebcd49db0a5b8b294a119d7849d	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x028b1f7a949a7a862c3f93987296be30d71f7f97	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	0.944618343174494952774342731817	\N	assets_per_share
EULER_V2:80094:0x746d425dd3cf924fc7a0f37ebed10e35ff589342	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb127dba67c3f83c1accbb9a124e1b6f6bc3e93f3	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x4a0c6479b628a8d6696b0197ac29495f2e95f46c	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x34018ac9dc4b114036ca148aa18c8f75594e5e95	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.811915314035678288610651228632	\N	assets_per_share
EULER_V2:80094:0xe3ece76a7d1b07bcb0b5b6d38091e47c45994043	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x4eb3351066494852a03ffbbde40a9776380ce20d	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.70217409879790583636963864106	\N	assets_per_share
EULER_V2:80094:0x77096d125642c591227e0fcc980436cec467ffae	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb5faa970c515eea59f1af9f2bbe28564a65f131a	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.045802520791190462409068835929	\N	assets_per_share
EULER_V2:80094:0x44812cce64fddc7529dd6d41c9b3e1d0de006d92	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.038400942209239488211809744346	\N	assets_per_share
EULER_V2:80094:0x37dc866cf6fec47dfdc81d4380cf8406d9188929	2026-11-22T09:00:00.000Z	archival-rpc	29161642	\N	\N	\N	\N	\N	\N	\N	1.064536770489709393793505214894	\N	assets_per_share
EULER_V2:80094:0xad9e5e2647efb9137b6b8d688d4906fa51476870	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.307518551504382268564946645569	\N	assets_per_share
EULER_V2:80094:0x6d976915bd9de43de1a60c39e128e320dadda000	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.004619925355182220097270667801	\N	assets_per_share
EULER_V2:80094:0xb758d6ec8111feb9b0ec758a61b7874e5821dffd	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.007264111643407623411789210581	\N	assets_per_share
EULER_V2:80094:0xd538b6aef78e4bdde4fd4576e9e3a403704602bc	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.055724039637528573225656684818	\N	assets_per_share
EULER_V2:80094:0x1371dd58ce95ecd624340f072f97212a2661a280	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.026410280406314105109143328809	\N	assets_per_share
EULER_V2:80094:0x91e1ec1e948f635c127dad41eae1af899399f15a	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.057537885505023035386781460768	\N	assets_per_share
EULER_V2:80094:0x413dfb1814a6b5fe4488c49f86e2a74d285ffd5b	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x85dba39b85218229a4c3b9b037d05cd6eb4cf05d	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x558b16e07b8558b2a54946ca973b7b20b86a8b87	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.570490073562874267591601979381	\N	assets_per_share
EULER_V2:80094:0x3de0ca4af11108c94c9066a935ee67e53b7f9447	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x2cccd307bb616e5f896ab61cae09ef4e5e9fedb7	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.007817217191382176894329200427	\N	assets_per_share
EULER_V2:80094:0xbabf4ce18fbab547ad5939deff825f3e2f8d9402	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x1dfb669df5e70d4238f2cc0a9ee3b1a21ff91bc0	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb8064453b25a91d7a4e8b7e7883a817d5742de34	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x89fd57175eceec45992e07c206e5a864fa6af433	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.039883414186628209081116826286	\N	assets_per_share
EULER_V2:80094:0x66f233ac844c3948a516857ca769872e5941f91c	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.035778172649190276864633844677	\N	assets_per_share
EULER_V2:80094:0x109d6d1799f62216b4a7b0c6e245844abd4dd281	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x027dcafb223f69d41bd413c50854017718419585	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.019691844357001697416853537941	\N	assets_per_share
EULER_V2:80094:0x4f652b92a8cd9e251db4d43b2073f689e94b4dba	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	9.164179104477611940298507462686	\N	assets_per_share
EULER_V2:80094:0x2247b618251b8d913f3fd10b749e7bfa3e3a28db	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.011624714908075173966661783103	\N	assets_per_share
EULER_V2:80094:0xe932da5a4d00536c224f8153f299cdcd8054c444	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.077821008798161045261423200836	\N	assets_per_share
EULER_V2:80094:0x542b1ffd33c239c7afc6511fb8855390aa9c8ac2	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.302795126930619122873109156917	\N	assets_per_share
EULER_V2:80094:0x16c7169421cfb2c78b2d447b9274c61b8b2e846a	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.113592852584556477345245692405	\N	assets_per_share
EULER_V2:80094:0x07346ae3245e04c96e33e8d8e02a638aaa08e719	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.034159106786725250006119843562	\N	assets_per_share
EULER_V2:80094:0x112b77a77753b092306b1c04bd70215fed4e00a1	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.083169174604366513739840417974	\N	assets_per_share
EULER_V2:80094:0x401c4633dca173bf75ac85f2d270d98c063f54cf	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x28c96c7028451454729750171bd3bb95d7261b5a	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x1b33d24c4c78a61da80cfa2d0db72ca0851d5fb1	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.023842024568838624319118314303	\N	assets_per_share
EULER_V2:80094:0x2bf927248f86bd78ce300d00c7c8a175e3e0b38a	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xe318d262290abab80fc6e217c514801e2c0ef999	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.263463603395072557457379397786	\N	assets_per_share
EULER_V2:80094:0x5ba8763891d6a4f934b197b9817757d887b78fec	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xcaa70d2aa873ef057980844e18d9a9560bdffcc0	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.639499337381187925690331840667	\N	assets_per_share
EULER_V2:80094:0xac0476a04c567ebcd49db0a5b8b294a119d7849d	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x028b1f7a949a7a862c3f93987296be30d71f7f97	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	0.944618343174496250949019066652	\N	assets_per_share
EULER_V2:80094:0x746d425dd3cf924fc7a0f37ebed10e35ff589342	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb127dba67c3f83c1accbb9a124e1b6f6bc3e93f3	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x4a0c6479b628a8d6696b0197ac29495f2e95f46c	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x34018ac9dc4b114036ca148aa18c8f75594e5e95	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.811925818364786577972734937518	\N	assets_per_share
EULER_V2:80094:0xe3ece76a7d1b07bcb0b5b6d38091e47c45994043	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0x4eb3351066494852a03ffbbde40a9776380ce20d	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.702187104923283036604045057678	\N	assets_per_share
EULER_V2:80094:0x77096d125642c591227e0fcc980436cec467ffae	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1	\N	assets_per_share
EULER_V2:80094:0xb5faa970c515eea59f1af9f2bbe28564a65f131a	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.045826397833601623138188002591	\N	assets_per_share
EULER_V2:80094:0x44812cce64fddc7529dd6d41c9b3e1d0de006d92	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.038410425366162976172116581565	\N	assets_per_share
EULER_V2:80094:0x37dc866cf6fec47dfdc81d4380cf8406d9188929	2026-11-22T11:00:00.000Z	archival-rpc	29165242	\N	\N	\N	\N	\N	\N	\N	1.064556214095688803625396661079	\N	assets_per_share
\.

ANALYZE _hist_stage;

INSERT INTO lending_snapshots_data AS t (
    market_id, data_ts, deposit_rate, variable_borrow_rate,
    total_deposits, total_debt, total_deposits_usd, total_debt_usd,
    utilization, source
)
SELECT DISTINCT ON (m.id, s.data_ts)
       m.id, s.data_ts,
       CASE WHEN abs(s.deposit_rate) >= 1e10 THEN NULL ELSE s.deposit_rate END,
       CASE WHEN abs(s.variable_borrow_rate) >= 1e10 THEN NULL ELSE s.variable_borrow_rate END,
       CASE WHEN abs(s.total_deposits) >= 1e22 THEN NULL ELSE s.total_deposits END,
       CASE WHEN abs(s.total_debt) >= 1e22 THEN NULL ELSE s.total_debt END,
       CASE WHEN abs(s.total_deposits_usd) >= 1e30 THEN NULL ELSE s.total_deposits_usd END,
       CASE WHEN abs(s.total_debt_usd) >= 1e30 THEN NULL ELSE s.total_debt_usd END,
       s.utilization, s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.deposit_rate         IS NOT NULL
    OR s.variable_borrow_rate IS NOT NULL
    OR s.total_deposits       IS NOT NULL
    OR s.total_debt           IS NOT NULL
    OR s.total_deposits_usd   IS NOT NULL
    OR s.total_debt_usd       IS NOT NULL
    OR s.utilization          IS NOT NULL
 ORDER BY m.id, s.data_ts, s.ctid DESC
ON CONFLICT (market_id, data_ts) DO UPDATE SET
    deposit_rate         = COALESCE(excluded.deposit_rate,         t.deposit_rate),
    variable_borrow_rate = COALESCE(excluded.variable_borrow_rate, t.variable_borrow_rate),
    total_deposits       = COALESCE(excluded.total_deposits,       t.total_deposits),
    total_debt           = COALESCE(excluded.total_debt,           t.total_debt),
    total_deposits_usd   = COALESCE(excluded.total_deposits_usd,   t.total_deposits_usd),
    total_debt_usd       = COALESCE(excluded.total_debt_usd,       t.total_debt_usd),
    utilization          = COALESCE(excluded.utilization,          t.utilization),
    -- First-writer provenance: a backfill row merging into a live-cron row must
    -- not relabel it, or DELETE ... WHERE source <> 'live-cron' would delete
    -- live measurements. Mirrors the TypeScript ingest path.
    source               = CASE WHEN t.source = 'live-cron'
                                THEN 'live-cron'
                                ELSE excluded.source END
-- A row the live cron measured is never overwritten by an API's version of
-- the same hour. Added for the 2026-08-26 → 09-14 fetcher-a gap, where ~30 %
-- of hours DO exist: without this guard every one of them would have taken
-- Morpho's / Euler's number in place of our own read. Backfill fills holes;
-- it does not re-measure.
 WHERE t.source <> 'live-cron';

INSERT INTO market_index_snapshots_data AS t (
    market_id, data_ts, block_number, supply_index, borrow_index, index_kind, source
)
SELECT DISTINCT ON (m.id, s.data_ts)
       m.id, s.data_ts, s.block_number, s.supply_index, s.borrow_index,
       COALESCE(s.index_kind, 'unknown'), s.source
  FROM _hist_stage s
  JOIN markets m ON m.market_uid = s.market_uid
 WHERE s.supply_index IS NOT NULL
    OR s.borrow_index IS NOT NULL
 ORDER BY m.id, s.data_ts, s.ctid DESC
ON CONFLICT (market_id, data_ts) DO UPDATE SET
    block_number = COALESCE(excluded.block_number, t.block_number),
    supply_index = COALESCE(excluded.supply_index, t.supply_index),
    borrow_index = COALESCE(excluded.borrow_index, t.borrow_index),
    index_kind   = excluded.index_kind,
    source       = excluded.source
 WHERE t.source <> 'live-cron';

SELECT
    (SELECT count(*) FROM _hist_stage)                                     AS staged_rows,
    (SELECT count(DISTINCT s.market_uid) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS unknown_markets,
    (SELECT count(*) FROM _hist_stage s
       WHERE NOT EXISTS (SELECT 1 FROM markets m WHERE m.market_uid = s.market_uid))
                                                                           AS rows_skipped
\gset _hist_
\echo '  staged=':_hist_staged_rows'  skipped_rows=':_hist_rows_skipped'  unknown_markets=':_hist_unknown_markets

COMMIT;
