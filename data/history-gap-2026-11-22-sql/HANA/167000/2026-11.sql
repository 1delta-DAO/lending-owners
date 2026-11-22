-- Generated from HANA/167000/2026-11.ndjson (24 rows)
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
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.8923973342677795	3.252162511119215	1652.373041	1128.050545	1652.135941992347	1127.888681027298	0.6826851546290751	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.13273225420031515	1.0304649599100986	5.2691578388509965	0.9145951154120887	8857.675631737757	1537.4728020025684	0.17357519804560026	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.0125641086810382	1.3643128065908792	12565.768264113942	158.02694696002158	751.8342928323696	9.455058808895194	0.012575987686429344	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-21T19:00:00.000Z	archival-rpc	14321760	0.010420471751428923	0.35142835318787663	1937.440319	82.224769	1937.1623156886267	82.21297056789618	0.042439897731889824	\N	\N	\N
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.8923973342677795	3.252162511119215	1652.374724	1128.054733	1652.1439202985518	1127.8971663148945	0.6826869938250156	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.13273225420031515	1.0304649599100986	5.269158637237531	0.914596191278268	8861.18318951851	1538.0832032799738	0.1735753759271451	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0.0125641086810382	1.3643128065908792	12565.768444339014	158.0271930768501	751.8343036155852	9.45507353454251	0.01257600709235118	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-21T20:00:00.000Z	archival-rpc	14323560	0	0	0	0	0	0	0	\N	\N	\N
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0	0	0	0	0	0	0	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.13273225420031515	1.0304649599100986	5.269168217875946	0.9146091017711337	8738.064584702746	1516.7314973775412	0.17357751052021295	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.0125641086810382	1.3643128065908792	12565.770607039876	158.03014650867996	751.8344330141734	9.455250244098549	0.012576239965748283	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T08:00:00.000Z	archival-rpc	14345160	0.010420471751428923	0.35142835318787663	1937.440619	82.225198	1937.1699972943381	82.21371278434337	0.04244011258649058	\N	\N	\N
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.8923973342677795	3.252162511119215	1652.39829	1128.113365	1652.167483006853	1127.9557901251767	0.6827127405221413	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.13275648567641266	1.030559015976912	5.268790385253267	0.9146112535428456	9034.78058366593	1568.3508720026725	0.17359036641555078	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.0125641086810382	1.3643128065908792	12565.770967490022	158.03063875268273	751.8344545806049	9.455279696012187	0.01257627877840025	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T10:00:00.000Z	archival-rpc	14348760	0.010420471751428923	0.35142835318787663	1937.440665	82.225264	1937.170043287913	82.21377877512448	0.04244014564440867	\N	\N	\N
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.8923973342677795	3.252162511119215	1652.396606	1128.109177	1652.165799242074	1127.9516027101567	0.6827109017918184	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.13273225420031515	1.0304649599100986	5.269169016262481	0.9146101776537654	8876.076262521641	1540.6887997477147	0.1735776884041794	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.0125641086810382	1.3643128065908792	12565.770787264948	158.03039263048976	751.8344437973891	9.455264970043906	0.0125762593720593	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T09:00:00.000Z	archival-rpc	14346960	0.010420471751428923	0.35142835318787663	1937.440642	82.225231	1937.1700202911254	82.21374577973391	0.04244012911544982	\N	\N	\N
HANA:167000:0x07d83526730c7438048d55a4fc0b850e2aab6f0b	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.8923973342677795	3.252162511119215	1652.399973	1128.117554	1652.1691657717715	1127.9599785400571	0.6827145802670622	\N	\N	\N
HANA:167000:0xa51894664a773981c6c112c43ce576f315d5b1b6	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.13275648567641266	1.030559015976912	5.268791183730538	0.9146123295262105	9034.78195287336	1568.3527170701175	0.17359054432645488	\N	\N	\N
HANA:167000:0xa9d23408b9ba935c230493c40c73824df71a0975	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.0125641086810382	1.3643128065908792	12565.771147715093	158.03088487525886	751.8344653638206	9.455294422003396	0.012576298184771137	\N	\N	\N
HANA:167000:0x19e26b0638bf63aa9fa4d14c6baf8d52ebe86c5c	2026-11-22T11:00:00.000Z	archival-rpc	14350560	0.010420471751428923	0.35142835318787663	1937.440688	82.225297	1937.1700662847002	82.21381177051504	0.04244016217336714	\N	\N	\N
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
