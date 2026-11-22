-- Generated from LISTA_DAO/56/2026-11.ndjson (30 rows)
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
LISTA_DAO_02E3E78089E25120193128AAC38CB28A6D9EF4D8ABA8134A9235100F699AB26B:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0.024999963699201544	0	0	0	0	0	\N	\N	\N
LISTA_DAO_047B6180CB0027DB078ECB51752B0A63A997AD31B79792B4C7365F746372A832:56:0x21caef8a43163eea865baee23b9c2e327696a3bf	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_0804656ABF94FADE08755E3E83476F599B72E380FF2B34C81819C86A7B300B64:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0.024999963699201544	16.833617728591207	0	16.798063107914295	0	0	\N	\N	\N
LISTA_DAO_08839B6E6EC8FD51CC601561F35B9D563F07685D4C31BD07812FC345A33F2B65:56:0xce24439f2d9c6a2289f741120fe202248b666666	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_08839B6E6EC8FD51CC601561F35B9D563F07685D4C31BD07812FC345A33F2B65:56:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_08910A66E6B1C5E0A04A66BD4013143467D7ED76A0CDF40D456C8F22EC377AAC:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_0A55356620B49A0F46971FBDE5663EA3CD6522FEF33287BCE2AF46BD50D7F9EC:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.3253062331509682	1.5951275084802319	14496.304330743586	3264.0022725627996	14465.686396440535	3257.108308082874	0.22516099262903466	\N	\N	\N
LISTA_DAO_0FF603AB5CF4B44E603EC8109ACF7B84F36133278B9F20CA404D216E593D0964:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	31.401613974679776	34.352022132466686	43774.95144601276	43774.95144601276	43700.971778069004	43700.971778069004	1	\N	\N	\N
LISTA_DAO_10A30E6ECC9119AA45B79355B5C75EDEF77C91528131462205BBAC457F3DC274:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	2.705817173520586	3.0019934282421445	8239017.567409552	8239017.567409552	8225093.62772063	8225093.62772063	1	\N	\N	\N
LISTA_DAO_174A1298D2F4A0BAAEF5524DFE61F4A16690EB0EDDB0D3C19078ACFAEDA71AC4:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	10.31643507900526	14.046367061482101	5533.617587801785	4430.660019181111	5524.2657740784	4423.172203748695	0.8006805582207172	\N	\N	\N
LISTA_DAO_17CF480BED9804DD61D809855FD54CDAC6A86C222FCD0456778B820D9F07E507:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0.024999963699201544	0	0	0	0	0	\N	\N	\N
LISTA_DAO_1EDAAC0BCC846C559A7D6EBDEB53583BC784F116EE31A1084F29D4D437773B8F:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_20C99BCCF90E1489CA5074DFB9FFB53E1928B4A6368F557DD5EE2B7D4319DBC1:56:0x55d398326f99059ff775485246999027b3197955	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_211CAB18D1ECD7428BDEC32EA3B379AF98553B5B718B5A44979594643DC095A2:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_212D0A36FCCB86FF79994D6094271C21149C6A65E97E5ED797429EE56F44CE64:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-21T20:00:00.000Z	archival-rpc	134947363	0.010988163978709053	0.046756416338666895	65.1902930998579	17.019502945111483	65.05260337799582	16.983555712551055	0.26107418966564794	\N	\N	\N
LISTA_DAO_02E3E78089E25120193128AAC38CB28A6D9EF4D8ABA8134A9235100F699AB26B:56:0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0.024999963699201544	0	0	0	0	0	\N	\N	\N
LISTA_DAO_047B6180CB0027DB078ECB51752B0A63A997AD31B79792B4C7365F746372A832:56:0x21caef8a43163eea865baee23b9c2e327696a3bf	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_0804656ABF94FADE08755E3E83476F599B72E380FF2B34C81819C86A7B300B64:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0.024999963699201544	16.833617728591207	0	16.8074655250966	0	0	\N	\N	\N
LISTA_DAO_08839B6E6EC8FD51CC601561F35B9D563F07685D4C31BD07812FC345A33F2B65:56:0xce24439f2d9c6a2289f741120fe202248b666666	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_08839B6E6EC8FD51CC601561F35B9D563F07685D4C31BD07812FC345A33F2B65:56:0x211cc4dd073734da055fbf44a2b4667d5e5fe5d2	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_08910A66E6B1C5E0A04A66BD4013143467D7ED76A0CDF40D456C8F22EC377AAC:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_0A55356620B49A0F46971FBDE5663EA3CD6522FEF33287BCE2AF46BD50D7F9EC:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.32526701971846705	1.5949328417974584	14496.304330743586	3264.0022725627996	14473.783307224472	3258.931416552214	0.22516099262903466	\N	\N	\N
LISTA_DAO_0FF603AB5CF4B44E603EC8109ACF7B84F36133278B9F20CA404D216E593D0964:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	31.40676984081381	34.35758413772305	43774.95144601276	43774.95144601276	43700.971778069004	43700.971778069004	1	\N	\N	\N
LISTA_DAO_10A30E6ECC9119AA45B79355B5C75EDEF77C91528131462205BBAC457F3DC274:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	2.705817173520586	3.0019934282421445	8239017.567409552	8239017.567409552	8225093.62772063	8225093.62772063	1	\N	\N	\N
LISTA_DAO_174A1298D2F4A0BAAEF5524DFE61F4A16690EB0EDDB0D3C19078ACFAEDA71AC4:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	10.316246014241415	14.046114274890442	5533.617587801785	4430.660019181111	5524.2657740784	4423.172203748695	0.8006805582207172	\N	\N	\N
LISTA_DAO_17CF480BED9804DD61D809855FD54CDAC6A86C222FCD0456778B820D9F07E507:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0.024999963699201544	0	0	0	0	0	\N	\N	\N
LISTA_DAO_1EDAAC0BCC846C559A7D6EBDEB53583BC784F116EE31A1084F29D4D437773B8F:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_20C99BCCF90E1489CA5074DFB9FFB53E1928B4A6368F557DD5EE2B7D4319DBC1:56:0x55d398326f99059ff775485246999027b3197955	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_211CAB18D1ECD7428BDEC32EA3B379AF98553B5B718B5A44979594643DC095A2:56:0x7130d2a12b9bcbfae4f2634d864a1ee1ce3ead9c	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0	0	0	0	0	0	0	\N	\N	\N
LISTA_DAO_212D0A36FCCB86FF79994D6094271C21149C6A65E97E5ED797429EE56F44CE64:56:0x8d0d000ee44948fc98c9b98a4fa4921476f08b0d	2026-11-22T08:00:00.000Z	archival-rpc	135043334	0.010988163978709053	0.046756416338666895	65.19033670181429	17.019546547067876	65.08905895042444	16.993105490138745	0.2610746838893717	\N	\N	\N
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
