-- Generated from XPERT/57073/2026-11.ndjson (30 rows)
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
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-21T20:00:00.000Z	archival-rpc	61792789	192.53588367149632	192.00587561805094	0.009580868360519188	0.010674872170303723	16.11221743396435	17.95201176090348	1.114186289657491	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-21T20:00:00.000Z	archival-rpc	61792789	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015333160318450476	0.42186529943579637	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-21T20:00:00.000Z	archival-rpc	61792789	186.88827759270055	187.6105484054591	10.529303	11.65407	10.527832266956962	11.652442159502401	1.1068225503625453	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-21T20:00:00.000Z	archival-rpc	61792789	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238424936000001	0.00004891719	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-21T20:00:00.000Z	archival-rpc	61792789	167.79210342754425	172.3998477032751	0.00030192	0.00032648	18.17811982608	19.65683810552	1.081346051934287	\N	\N	\N
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-21T19:00:00.000Z	archival-rpc	61789189	192.53617777224008	192.00610319600742	0.009579680074584132	0.010673551852598105	16.10384455193906	17.942688953395223	1.1141866711098345	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-21T19:00:00.000Z	archival-rpc	61789189	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015327093254304789	0.4216983746936454	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-21T19:00:00.000Z	archival-rpc	61789189	186.88760046075004	187.61001832388047	10.527125	11.65165	10.52561446283375	11.6499781047415	1.1068216630846504	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-21T19:00:00.000Z	archival-rpc	61789189	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238424936000001	0.00004891719	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-21T19:00:00.000Z	archival-rpc	61789189	167.77763787239053	172.38811098287954	0.00030187000000000004	0.00032642	18.128882815125703	19.603239568401403	1.081326398780932	\N	\N	\N
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-22T10:00:00.000Z	archival-rpc	61843189	192.5317746639621	192.00269442833928	0.009597504363609987	0.010693356618182387	16.457543332657064	18.33668141715714	1.1141809592426388	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-22T10:00:00.000Z	archival-rpc	61843189	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015634641399252153	0.4301600282317632	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-22T10:00:00.000Z	archival-rpc	61843189	186.89769301794001	187.61791352837065	10.55979	11.687944	10.5583150085328	11.68631142798208	1.106834889708981	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-22T10:00:00.000Z	archival-rpc	61843189	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238637216000001	0.00004891964	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-22T10:00:00.000Z	archival-rpc	61843189	167.85666834415736	172.45222564525875	0.00030270000000000004	0.00032735	18.464436818792667	19.968065386956653	1.0814337628014534	\N	\N	\N
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-22T08:00:00.000Z	archival-rpc	61835989	192.53236076473002	192.0031481837725	0.009595127791739872	0.010690715982771149	15.911969949689162	17.728826040749404	1.114181719598819	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-22T08:00:00.000Z	archival-rpc	61835989	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015120091603155899	0.4160030834600078	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-22T08:00:00.000Z	archival-rpc	61835989	186.896338754039	187.61685406545325	10.555435	11.683105	10.5539606168392	11.6814731038936	1.10683311488347	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-22T08:00:00.000Z	archival-rpc	61835989	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238424936000001	0.00004891719	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-22T08:00:00.000Z	archival-rpc	61835989	167.85413277560224	172.45016904077204	0.00030259	0.00032723	17.864144463941468	19.318827432947447	1.081430318252421	\N	\N	\N
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-22T09:00:00.000Z	archival-rpc	61839589	192.532068064466	192.0029213060559	0.00959631607767493	0.010692036300476769	16.1652877487546	18.0110619552679	1.1141813393736526	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-22T09:00:00.000Z	archival-rpc	61839589	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015358900650123833	0.42257349999611343	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-22T09:00:00.000Z	archival-rpc	61839589	186.89701238479017	187.61738134607242	10.557613	11.685525	10.55613831261616	11.683892765868	1.106833997419682	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-22T09:00:00.000Z	archival-rpc	61839589	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238637216000001	0.00004891964	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-22T09:00:00.000Z	archival-rpc	61839589	167.8422490048348	172.44052883853556	0.00030265	0.00032729	18.084094957726343	19.556396625522073	1.0814141747893606	\N	\N	\N
XPERT:57073:0x5e935d83268adb44992e25bcf39e8d3f03cf906f	2026-11-22T11:00:00.000Z	archival-rpc	61846789	192.53148196369807	192.00246755062267	0.009598692649545045	0.010694676935888006	16.459580973540245	18.3389454625829	1.1141805792057429	\N	\N	\N
XPERT:57073:0x1b8eec91df44dd904dbd03bf6a3b723fb738bc39	2026-11-22T11:00:00.000Z	archival-rpc	61846789	9999.99	9999.99	0.000009117614702253001	0.000250855347274872	0.015634641399252153	0.4301600282317632	27.51326475913537	\N	\N	\N
XPERT:57073:0x99793c9ae73866a432b95d6bd3e143684bffb283	2026-11-22T11:00:00.000Z	archival-rpc	61846789	186.89836594845133	187.61844010874995	10.561968	11.690364	10.56049270430976	11.68873108995648	1.1068357715153085	\N	\N	\N
XPERT:57073:0x92bd8f8c28c427dce89ea626a05689a8259c5ce3	2026-11-22T11:00:00.000Z	archival-rpc	61846789	0.000006302158794824209	0.0057706767364607	0.04245600000000001	0.000049	0.04238637216000001	0.00004891964	0.0011541360467307328	\N	\N	\N
XPERT:57073:0x32316c282e577f261b5ece606b4cab89bf55e5c5	2026-11-22T11:00:00.000Z	archival-rpc	61846789	167.84478807458925	172.4425889442216	0.00030276	0.00032741	18.468096766625923	19.97172533478991	1.0814176245210727	\N	\N	\N
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
