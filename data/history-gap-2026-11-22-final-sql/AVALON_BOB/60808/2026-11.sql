-- Generated from AVALON_BOB/60808/2026-11.ndjson (30 rows)
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
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-21T19:00:00.000Z	archival-rpc	41212806	0.05457648625916097	0.5584493135161269	0.15684146	0.0251157	9412.714748731998	1507.29864294	0.1601343165257452	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-21T19:00:00.000Z	archival-rpc	41212806	0.05165212429130496	0.5432816911605931	0.008679194232028956	0.001222800516188928	520.476684123671	73.32929083002497	0.140888714262945	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-21T19:00:00.000Z	archival-rpc	41212806	0.08016002131300685	0.8441170077556092	0.1835829907836314	0.02744902796428697	11052.600450297323	1652.5667086220724	0.14951836140766464	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-21T19:00:00.000Z	archival-rpc	41212806	1.0941778417243726	3.1186576054084876	1.9551135262391264	0.950508484662079	117707.46597085976	57225.29337137381	0.486165366821683	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-21T19:00:00.000Z	archival-rpc	41212806	0.8563120557921038	2.2120605207321185	0.00101032	0.00056619	60.633546544000005	33.979439898	0.5604066038482857	\N	\N	\N
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-21T20:00:00.000Z	archival-rpc	41214606	0.05457648625916097	0.5584493135161269	0.15684147	0.02511572	9471.2333692738	1516.6705932897553	0.16013443383309273	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-21T20:00:00.000Z	archival-rpc	41214606	0.05165212429130496	0.5432816911605931	0.008679194743754183	0.001222801274551029	520.4767148109725	73.32933630772499	0.1408887933331597	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-21T20:00:00.000Z	archival-rpc	41214606	0.08016002131300685	0.8441170077556092	0.18358300758226656	0.027449054414288684	11092.618461392462	1658.5515824892539	0.14951849180261584	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-21T20:00:00.000Z	archival-rpc	41214606	1.0941778417243726	3.1186576054084876	1.9551159678034793	0.950511868583651	117623.12213808461	57184.42049129217	0.48616649049801675	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-21T20:00:00.000Z	archival-rpc	41214606	0.8563120557921038	2.2120605207321185	0.00101032	0.00056619	61.01049995033014	34.19068707625052	0.5604066038482857	\N	\N	\N
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-22T09:00:00.000Z	archival-rpc	41238006	0.05457648625916097	0.5584493135161269	0.15684159	0.02511593	9392.167850094715	1504.0209058785324	0.16013565024430065	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-22T09:00:00.000Z	archival-rpc	41238006	0.05165212429130496	0.5432816911605931	0.00867920139618211	0.001222811133301103	516.786142637746	72.80990726072423	0.14088982125002938	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-22T09:00:00.000Z	archival-rpc	41238006	0.08016002131300685	0.8441170077556092	0.18358322596452362	0.02744939826662962	10993.815039156498	1643.7972799202528	0.14952018694743963	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-22T09:00:00.000Z	archival-rpc	41238006	1.0941778417243726	3.1186576054084876	1.9551477081400668	0.9505558606597431	117083.31283859408	56923.693663052196	0.4861810985953626	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T09:00:00.000Z	archival-rpc	41238006	0.8563120557921038	2.2120605207321185	0.00101034	0.00056621	60.5023378407774	33.9064361589431	0.5604153057386623	\N	\N	\N
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-22T08:00:00.000Z	archival-rpc	41236206	0.05457648625916097	0.5584493135161269	0.15684158	0.02511591	9280.174974857135	1486.085765348475	0.16013553293712038	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-22T08:00:00.000Z	archival-rpc	41236206	0.05165212429130496	0.5432816911605931	0.008679200884456886	0.001222810374932893	511.38970058889487	72.04956306908404	0.140889742179232	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-22T08:00:00.000Z	archival-rpc	41236206	0.08016002131300685	0.8441170077556092	0.18358320916588847	0.02744937181629667	10867.99817447042	1624.9837016429206	0.14952005655099435	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-22T08:00:00.000Z	archival-rpc	41236206	1.0941778417243726	3.1186576054084876	1.9551452665757139	0.9505524765816487	115413.04624697634	56111.511924654886	0.4861799748754567	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T08:00:00.000Z	archival-rpc	41236206	0.8563120557921038	2.2120605207321185	0.00101034	0.00056621	59.780907487014325	33.50213554666982	0.5604153057386623	\N	\N	\N
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-22T10:00:00.000Z	archival-rpc	41239806	0.05457648625916097	0.5584493135161269	0.1568416	0.02511595	9594.424144319999	1536.410474565	0.16013576755146594	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-22T10:00:00.000Z	archival-rpc	41239806	0.05165212429130496	0.5432816911605931	0.008679201907907335	0.001222811891669783	516.7861731074279	72.80995241631021	0.1408899003208716	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-22T10:00:00.000Z	archival-rpc	41239806	0.08016002131300685	0.8441170077556092	0.1835832427631588	0.02744942471698805	11198.418192895346	1674.3910419525323	0.14952031734399976	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-22T10:00:00.000Z	archival-rpc	41239806	1.09513065844834	3.120015182937901	1.9549442237405186	0.9505592456453018	119415.18255327496	58063.65443472801	0.48623343525706153	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T10:00:00.000Z	archival-rpc	41239806	0.8563120557921038	2.2120605207321185	0.00101034	0.00056621	61.805225717999996	34.636594467	0.5604153057386623	\N	\N	\N
AVALON_BOB:60808:0x03c7054bcb39f7b2e5b2c7acb37583e32d70cfa3	2026-11-22T11:00:00.000Z	archival-rpc	41241606	0.05457648625916097	0.5584493135161269	0.15684161	0.02511596	9594.424756047	1536.411086292	0.1601358211000257	\N	\N	\N
AVALON_BOB:60808:0xbba2ef945d523c4e2608c9e1214c2cc64d4fc2e2	2026-11-22T11:00:00.000Z	archival-rpc	41241606	0.05165212429130496	0.5432816911605931	0.008679202419632562	0.001222812650038934	516.7862035771097	72.80999757192421	0.1408899793917587	\N	\N	\N
AVALON_BOB:60808:0x541fd749419ca806a8bc7da8ac23d346f2df8b77	2026-11-22T11:00:00.000Z	archival-rpc	41241606	0.08016002131300685	0.8441170077556092	0.18358325956179394	0.02744945116737196	11198.419217597484	1674.3926554029538	0.14952044774067486	\N	\N	\N
AVALON_BOB:60808:0xcc0966d8418d412c599a6421b760a847eb169a8c	2026-11-22T11:00:00.000Z	archival-rpc	41241606	1.0952539623970658	3.120190823789918	1.9548371097326536	0.9505626312345176	119408.63963575954	58063.86123896791	0.48626181000038304	\N	\N	\N
AVALON_BOB:60808:0x0555e30da8f98308edb960aa94c0db47230d2b9c	2026-11-22T11:00:00.000Z	archival-rpc	41241606	0	0	0	0	0	0	0	\N	\N	\N
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
