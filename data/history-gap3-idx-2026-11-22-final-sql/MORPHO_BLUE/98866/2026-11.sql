-- Generated from MORPHO_BLUE/98866/2026-11.ndjson (32 rows)
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
MORPHO_BLUE_097E62371B537C5084F15E39318DA45DD9FCA767F0C148D49C343CB93A707871:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001001709239021027698200472	0.000001001977180062119952532532	assets_per_share
MORPHO_BLUE_11F7ACEACE6C4D4559369A93FE7A5BDA98AAE67E5001E73996D7F71E40CEF0D0:98866:0xea237441c92cae6fc17caaf9a7acb3f953be4bd1	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001001419915943884320473914	0.000001002149185707600985170675	assets_per_share
MORPHO_BLUE_1CDECBB3F756F9A8D3B388BAE9D9D2B9B14091CEF8E921A636E8107F50F2EECE:98866:0xca59ca09e5602fae8b629dee83ffa819741f14be	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001014989063889625437537845	0.00000101786054386295350494212	assets_per_share
MORPHO_BLUE_47994B98C35FF54B5C9E6375ADCEB7FE687808FB4D69EAE830A695CE491FA9A9:98866:0x78add880a697070c1e765ac44d65323a0dcce913	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_47ED86ADF820D3FD4B3DE6F57BD2B275ACA9B4C567B93FC842FB5D5374BB2061:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_4BDE7EDC4360A5F897F7E7F44228DA8094993E51FAE47F9E3D42B20B68FA6E49:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001405992457587515176098818	0.000001786514528240559345269806	assets_per_share
MORPHO_BLUE_4D82BBD86A6F245A236B2B71F9CEFB9FF353069A46B2B6E6EEBC001849167E4C:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000002278945343198271555482413	0.000001145362715866774511529851	assets_per_share
MORPHO_BLUE_4E5B50278BF256F0AF3D2B696545CBA3DE02DACBA6BEA930BDD5CF83DD4304F4:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000017289191114930253169632649	0.000018097823734831531374638453	assets_per_share
MORPHO_BLUE_5BCABDF144D98C9FD1C9A264637EEBB577DDEF77F86A7E4EC7EA8A028FD942FF:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000003698598413804409629442251	0.000003801339267889085575863364	assets_per_share
MORPHO_BLUE_5E8E0BE08062C65B150966B39696DFAC1563479AF588F9E98A9AF54E398F42C8:98866:0x78add880a697070c1e765ac44d65323a0dcce913	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000014752054410483557024977251	0.000015577642033412387786215202	assets_per_share
MORPHO_BLUE_678693CCE66DB976B3727AF8C5FC72DD6D91EC32B9B620602D163854C164A6D6:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_785C9611983BE32F4F7B1D1B46351CAFBA708E7640ABAD97CF4DA63161AB0743:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001285031281118022082214731	0.000001330105040034692002300432	assets_per_share
MORPHO_BLUE_7A96549CAE736C913D12C78EE4C155C2D2F874031FCE5ACDD07BDBF23D7644C7:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001080578332017030717992854	0.000001090758103867093454886692	assets_per_share
MORPHO_BLUE_8243EE11B8F23C49D7734907316031D0A5030CBC0A77D5E649422678708C9798:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000016738789593222861574041528	0.000018167595092580504507396961	assets_per_share
MORPHO_BLUE_82E7AB8CCABAAC59B5F397507ED031EBF19A9A5B2657C00C93BC2423CD0A890D:98866:0x222365ef19f7947e5484218551b56bb3965aa7af	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000016801645264785357943017816	0.000016821833762325297198615055	assets_per_share
MORPHO_BLUE_86C9CFD279A9B7BF78E24D9C5DDBBB2863182BC510806F5ABA38E22E2AB7A726:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001326581921549810544806974	0.00000125	assets_per_share
MORPHO_BLUE_8D009383866DFFAAC5FE25AF684E93F8DD5A98FED1991C298624ECC3A860F39F:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000016956417187655978587491777	0.000024142496498591672757821117	assets_per_share
MORPHO_BLUE_8FB9E1717AEB595213A52DDF25092214359BB89246E52247AEF69A7FC39C61E7:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_930567A509735F4E62958241719EB316450981F74F32ACDBA044B493E1D10F14:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_970B184DB9382337BF6B693017CF30936A26001FB26BAC24E238C77629A75046:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001099045260236284066561061	0.000001113408421888959223230792	assets_per_share
MORPHO_BLUE_9D0C773A6C32844767A68EB354475D6EA19C9A07623120879363A3EBFE1E56C6:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000002261321031696246776480789	0.000002918815747155136937010166	assets_per_share
MORPHO_BLUE_9EA0AD4BD724595B9D2B4FE037E9ED063DE91B2D63D15E08734F58D6F271A9B3:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001060156774273793651836217	0.00000107130597866096282689486	assets_per_share
MORPHO_BLUE_A05B28928AB7AEA096978928CFB3545333B30B36695BF1510922AC1D6A2C044A:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000003546828640978927187023513	0.000003987649601204784535363896	assets_per_share
MORPHO_BLUE_A39E210A871820D48B6C96E441C0B0FD2DDDDE3CFCC0074AB7E716DF0751B549:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000005803591353073413000349002	0.000006759674581290228249424518	assets_per_share
MORPHO_BLUE_A9B89BE85D058D23345E95A046A8BEA9E7888EC8B37233962E5F4EDDDB02E862:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_C867A94E57716E4BE14D59A9D1BF5E976E96745F7A4ADCD04197F003501139D7:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001045188141255914196109167	0.000001050322976099230081322229	assets_per_share
MORPHO_BLUE_CC1844818341A6E2F50C6C6A0240D8B3C7E3E64B1AC686D6914245EF56C39DF0:98866:0x78add880a697070c1e765ac44d65323a0dcce913	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_CF3BB7B9935F60D79DA7B7BC6405328E6F990B6894895F1DF7ACFB4C82BC4C5A:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001122193815887678036957378	0.000001138489519453184224459843	assets_per_share
MORPHO_BLUE_E70DD0172A62A91B8E9D67BF4815A2F72120B7F92DACAC5448C2F075CD6F1079:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000002079528749804571443186726	0.000002305716826587582253260664	assets_per_share
MORPHO_BLUE_EDB714D1EEB68F13F6F346BEE67CB1CD309819575DCA8D12351D09B8D309B7FA:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_EDBAEBC3842F276B4D07E35FC24BEA59CD93A3E501E9677F9A4F283F992F4950:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001	\N	assets_per_share
MORPHO_BLUE_F98BEF5D1335D4EE4D60ED9892DFED64AE3DFAB662FCB234E38312D7DA9FD5D0:98866:0xdddd73f5df1f0dc31373357beac77545dc5a6f3f	2026-11-22T11:00:00.000Z	archival-rpc	107434363	\N	\N	\N	\N	\N	\N	\N	0.000001000746486741761128129234	0.000001000988376357987082498253	assets_per_share
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
