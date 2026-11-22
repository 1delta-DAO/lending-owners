-- Generated from CREAM_FINANCE/8453/2026-11.ndjson (42 rows)
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
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0.16666619124805493	0.001012788930652377	0	1.7032146619013822	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.1611300948667349	0.514581769195388	0.00011703624676549098	0.000040719123969502	0.22529517702552235	0.07838445350537432	0.3479189148221074	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.07456714286036004	0.29689470082416847	57.536875999999715	16.056394	57.5331579670726	16.05535643581972	0.27906266582843464	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0.43980105317587004	0.5680870973634455	21.30748050692961	18.328619459167065	21.305287967185446	18.326733444224715	0.8601964673019993	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-21T20:00:00.000Z	archival-rpc	60504126	2.3279257273856047	2.5865747272035833	0	0.003629	0	0.00362849310128	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-21T20:00:00.000Z	archival-rpc	60504126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0.16666619124805493	0.001012788930652377	0	1.702540729561733	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.16112449294780617	0.514574066556861	0.00011703504178031599	0.000040717785097085	0.2251806706908262	0.07834284516612725	0.34791105704491054	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.07456574238062785	0.2968926001045702	57.53658499999991	16.056071	57.53286698587721	16.05503345669198	0.27905846341071555	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0.4397940507772091	0.5680835961641151	21.306850385797823	18.327919324576186	21.304657910893123	18.326033381677686	0.860189046842547	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-21T19:00:00.000Z	archival-rpc	60486126	2.3279257273856047	2.5865747272035833	0	0.003629	0	0.0036284792747899998	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-21T19:00:00.000Z	archival-rpc	60486126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	1.9999452781860327	0.001012788930652377	0	1.706073910053605	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-22T09:00:00.000Z	archival-rpc	60738126	1.9344679490274075	6.175729786761508	0.000117051911572777	0.000040736529310931	0.22570359363039116	0.07854960191564479	0.34802105120344895	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0.8950486975578542	3.5628827600220347	57.540653999999705	16.060592	57.535959833446384	16.05928177690464	0.2791173002656536	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-22T09:00:00.000Z	archival-rpc	60738126	5.278268762864968	6.817003854209247	21.315672081642873	18.337721208848464	21.31797417422769	18.33970168273902	0.8602928933515059	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-22T09:00:00.000Z	archival-rpc	60738126	27.9253151738601	31.026809185874527	0	0.003636	0	0.00363549212352	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	1.9999452781860327	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-22T09:00:00.000Z	archival-rpc	60738126	0	1.9999452781860327	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0.16666619124805493	0.001012788930652377	0	1.6795468887649119	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.16120362005267452	0.5146763015773104	0.00011705070658760098	0.000040735190438513	0.2221919365936293	0.07732572587479157	0.34801319552929566	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.0745867495766106	0.2969185089796156	57.54036299999991	16.060269	57.535668857186366	16.05895880325498	0.2791130984001618	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0.4398787798010062	0.568129111755411	21.315041960511085	18.33702107425759	21.312848642693346	18.335134194789045	0.8602854785943809	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-22T08:00:00.000Z	archival-rpc	60720126	2.3279257273856047	2.5865747272035833	0	0.003636	0	0.00363549212352	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-22T08:00:00.000Z	archival-rpc	60720126	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0.16666619124805493	0.001012788930652377	0	1.7367033221933776	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.16121552413039808	0.5146917068543644	0.00011705311662489699	0.00004073786825773	0.2297423308685373	0.07995697233879205	0.34802890715226914	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.07458955053607497	0.29692201017894604	57.54094499999951	16.060915	57.53625080970641	16.0596047505543	0.27912150208864556	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0.43989138411859585	0.5681354139142059	21.31630223778139	18.338421382335707	21.311222989284172	18.334051703288722	0.8603003080821572	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-22T10:00:00.000Z	archival-rpc	60756127	2.3279257273856047	2.5865747272035833	0	0.003637	0	0.0036364919838400003	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-22T10:00:00.000Z	archival-rpc	60756127	0	0.16666619124805493	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0xba2e90b4dcdb235e46b9554360e31f2afa1d8b35	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	1.9999452781860327	0.001012788930652377	0	1.7367033221933776	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x7896d186c2b6d977c93d77e272ea4e1721eb428c	2026-11-22T11:00:00.000Z	archival-rpc	60774126	1.9346142991594206	6.175918851525353	0.00011705432154312899	0.000040739207055766	0.22974469578398002	0.07995960002261818	0.34803676206653783	\N	\N	\N
CREAM_FINANCE:8453:0xef1b7c8ba6c3f6bcb248b56c96a80d5234898793	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0.8950872107504892	3.562929676093063	57.54123499999961	16.061237	57.536540786048306	16.05992672428554	0.2791256913411766	\N	\N	\N
CREAM_FINANCE:8453:0x69f2959f0fbc5057b06a0c5f55b15b209d90d32f	2026-11-22T11:00:00.000Z	archival-rpc	60774126	5.278424216115241	6.817086482513446	21.31693232390645	18.33912147803022	21.31185292527231	18.334751632164433	0.8603077215506902	\N	\N	\N
CREAM_FINANCE:8453:0x7da57da16c2874d6a0277b5d5412e689b815fd60	2026-11-22T11:00:00.000Z	archival-rpc	60774126	27.9253151738601	31.026809185874527	0	0.003637	0	0.0036364919838400003	0	\N	\N	\N
CREAM_FINANCE:8453:0xfce1271d975d4ffa676967e7940b58b0b9176e3f	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	1.9999452781860327	0	0	0	0	0	\N	\N	\N
CREAM_FINANCE:8453:0x97dfbff1e89eac4fb84a372d6a4ec9cf52225afb	2026-11-22T11:00:00.000Z	archival-rpc	60774126	0	1.9999452781860327	0	0	0	0	0	\N	\N	\N
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
