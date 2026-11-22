-- Generated from MOONWELL/8453/2026-11.ndjson (105 rows)
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
MOONWELL:8453:0x703843c3379b52f9ff486c9f5892218d2a065cc8	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.000220443089776403	\N	exchange_rate
MOONWELL:8453:0x628ff693426583d9a7fb391e54366292f509d457	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	208320748.470984217988681331	\N	exchange_rate
MOONWELL:8453:0x3bf93770f2d4a794c3d9ebefbaebae2a8f09a5e5	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	216733575.27418452795649088	\N	exchange_rate
MOONWELL:8453:0x73b06d8d18de422e269645eace15400de7462417	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	212558003.549565820180640849	\N	exchange_rate
MOONWELL:8453:0xedc817a28e8b93b03976fbd4a3ddbc9f7d176c22	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.000245027816781771	\N	exchange_rate
MOONWELL:8453:0x627fe393bc6edda28e99ae648fd6ff362514304b	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	204387626.839872341713377883	\N	exchange_rate
MOONWELL:8453:0xcb1dacd30638ae38f2b94ea64f066045b7d45f44	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	200572906.400940412848003737	\N	exchange_rate
MOONWELL:8453:0x73902f619ceb9b31fd8efecf435cbdf89e369ba6	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	234653290.215074149780581789	\N	exchange_rate
MOONWELL:8453:0xb8051464c8c92209c92f3a4cd9c73746c4c3cfb3	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	200826151.812910847786873705	\N	exchange_rate
MOONWELL:8453:0xf877acafa28c19b96727966690b2f44d35ad5976	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.020400751854142002	\N	exchange_rate
MOONWELL:8453:0xb682c840b5f4fc58b20769e691a6fa1305a501a2	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.000234105451222881	\N	exchange_rate
MOONWELL:8453:0xfc41b49d064ac646015b459c522820db9472f4b5	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	200315967.962152253295497931	\N	exchange_rate
MOONWELL:8453:0xdc7810b47eaab250de623f0ee07764afa5f71ed1	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	202605245.741992905134340645	\N	exchange_rate
MOONWELL:8453:0xb6419c6c2e60c4025d6d06ee4f913ce89425a357	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	233154545.82548596214483951	\N	exchange_rate
MOONWELL:8453:0x9a858ebff1beb0d3495bb0e2897c1528ed84a218	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	201489389.552929516066922933	\N	exchange_rate
MOONWELL:8453:0x10ff57877b79e9bd949b3815220ec87b9fc5d2ee	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.020105419846951417	\N	exchange_rate
MOONWELL:8453:0xde8df9d942d78ede3ca06e60712582f79cfffc64	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	231720532.806285604998628834	\N	exchange_rate
MOONWELL:8453:0x6308204872bdb7432df97b04b42443c714904f3e	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	206093344.54633769421495384	\N	exchange_rate
MOONWELL:8453:0xb4fb8fed5b3aaa8434f0b19b1b623d977e07e86d	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	0.000205268652156884	\N	exchange_rate
MOONWELL:8453:0x2f90bb22eb3979f5ffad31ea6c3f0792ca66da32	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	998200939.037477812680363266	\N	exchange_rate
MOONWELL:8453:0xd64bcb70c613a6d1f4d7d57ba64bb4a0767a9682	2026-11-21T20:00:00.000Z	archival-rpc	60504126	\N	\N	\N	\N	\N	\N	\N	200002645.859719557565290795	\N	exchange_rate
MOONWELL:8453:0x703843c3379b52f9ff486c9f5892218d2a065cc8	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.000220443089776403	\N	exchange_rate
MOONWELL:8453:0x628ff693426583d9a7fb391e54366292f509d457	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	208331490.704049513394319347	\N	exchange_rate
MOONWELL:8453:0x3bf93770f2d4a794c3d9ebefbaebae2a8f09a5e5	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	216733605.747109494767794421	\N	exchange_rate
MOONWELL:8453:0x73b06d8d18de422e269645eace15400de7462417	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	212558003.549565820180640849	\N	exchange_rate
MOONWELL:8453:0xedc817a28e8b93b03976fbd4a3ddbc9f7d176c22	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.000245075603556981	\N	exchange_rate
MOONWELL:8453:0x627fe393bc6edda28e99ae648fd6ff362514304b	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	204391485.478999421342036281	\N	exchange_rate
MOONWELL:8453:0xcb1dacd30638ae38f2b94ea64f066045b7d45f44	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	200572906.400940412848003737	\N	exchange_rate
MOONWELL:8453:0x73902f619ceb9b31fd8efecf435cbdf89e369ba6	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	234670352.397711307540131274	\N	exchange_rate
MOONWELL:8453:0xb8051464c8c92209c92f3a4cd9c73746c4c3cfb3	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	200826151.812910847786873705	\N	exchange_rate
MOONWELL:8453:0xf877acafa28c19b96727966690b2f44d35ad5976	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.020400754831143901	\N	exchange_rate
MOONWELL:8453:0xb682c840b5f4fc58b20769e691a6fa1305a501a2	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.000234105451222881	\N	exchange_rate
MOONWELL:8453:0xfc41b49d064ac646015b459c522820db9472f4b5	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	200315967.962152253295497931	\N	exchange_rate
MOONWELL:8453:0xdc7810b47eaab250de623f0ee07764afa5f71ed1	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	202605454.846747219357943935	\N	exchange_rate
MOONWELL:8453:0xb6419c6c2e60c4025d6d06ee4f913ce89425a357	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	233154545.82548596214483951	\N	exchange_rate
MOONWELL:8453:0x9a858ebff1beb0d3495bb0e2897c1528ed84a218	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	201489389.552929516066922933	\N	exchange_rate
MOONWELL:8453:0x10ff57877b79e9bd949b3815220ec87b9fc5d2ee	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.020105419884082705	\N	exchange_rate
MOONWELL:8453:0xde8df9d942d78ede3ca06e60712582f79cfffc64	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	231720532.806285604998628834	\N	exchange_rate
MOONWELL:8453:0x6308204872bdb7432df97b04b42443c714904f3e	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	206093350.599579038741095121	\N	exchange_rate
MOONWELL:8453:0xb4fb8fed5b3aaa8434f0b19b1b623d977e07e86d	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	0.000205268673825236	\N	exchange_rate
MOONWELL:8453:0x2f90bb22eb3979f5ffad31ea6c3f0792ca66da32	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	998201751.177817123436228145	\N	exchange_rate
MOONWELL:8453:0xd64bcb70c613a6d1f4d7d57ba64bb4a0767a9682	2026-11-22T09:00:00.000Z	archival-rpc	60738126	\N	\N	\N	\N	\N	\N	\N	200002645.859719557565290795	\N	exchange_rate
MOONWELL:8453:0x703843c3379b52f9ff486c9f5892218d2a065cc8	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.000220443089776403	\N	exchange_rate
MOONWELL:8453:0x628ff693426583d9a7fb391e54366292f509d457	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	208330545.109552862202573381	\N	exchange_rate
MOONWELL:8453:0x3bf93770f2d4a794c3d9ebefbaebae2a8f09a5e5	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	216733605.747109494767794421	\N	exchange_rate
MOONWELL:8453:0x73b06d8d18de422e269645eace15400de7462417	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	212558003.549565820180640849	\N	exchange_rate
MOONWELL:8453:0xedc817a28e8b93b03976fbd4a3ddbc9f7d176c22	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.000245075603556981	\N	exchange_rate
MOONWELL:8453:0x627fe393bc6edda28e99ae648fd6ff362514304b	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	204391485.478999421342036281	\N	exchange_rate
MOONWELL:8453:0xcb1dacd30638ae38f2b94ea64f066045b7d45f44	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	200572906.400940412848003737	\N	exchange_rate
MOONWELL:8453:0x73902f619ceb9b31fd8efecf435cbdf89e369ba6	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	234670352.397711307540131274	\N	exchange_rate
MOONWELL:8453:0xb8051464c8c92209c92f3a4cd9c73746c4c3cfb3	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	200826151.812910847786873705	\N	exchange_rate
MOONWELL:8453:0xf877acafa28c19b96727966690b2f44d35ad5976	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.020400754831143901	\N	exchange_rate
MOONWELL:8453:0xb682c840b5f4fc58b20769e691a6fa1305a501a2	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.000234105451222881	\N	exchange_rate
MOONWELL:8453:0xfc41b49d064ac646015b459c522820db9472f4b5	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	200315967.962152253295497931	\N	exchange_rate
MOONWELL:8453:0xdc7810b47eaab250de623f0ee07764afa5f71ed1	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	202605454.846747219357943935	\N	exchange_rate
MOONWELL:8453:0xb6419c6c2e60c4025d6d06ee4f913ce89425a357	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	233154545.82548596214483951	\N	exchange_rate
MOONWELL:8453:0x9a858ebff1beb0d3495bb0e2897c1528ed84a218	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	201489389.552929516066922933	\N	exchange_rate
MOONWELL:8453:0x10ff57877b79e9bd949b3815220ec87b9fc5d2ee	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.020105419884082705	\N	exchange_rate
MOONWELL:8453:0xde8df9d942d78ede3ca06e60712582f79cfffc64	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	231720532.806285604998628834	\N	exchange_rate
MOONWELL:8453:0x6308204872bdb7432df97b04b42443c714904f3e	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	206093350.599579038741095121	\N	exchange_rate
MOONWELL:8453:0xb4fb8fed5b3aaa8434f0b19b1b623d977e07e86d	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	0.000205268673825236	\N	exchange_rate
MOONWELL:8453:0x2f90bb22eb3979f5ffad31ea6c3f0792ca66da32	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	998201751.177817123436228145	\N	exchange_rate
MOONWELL:8453:0xd64bcb70c613a6d1f4d7d57ba64bb4a0767a9682	2026-11-22T08:00:00.000Z	archival-rpc	60720126	\N	\N	\N	\N	\N	\N	\N	200002645.859719557565290795	\N	exchange_rate
MOONWELL:8453:0x703843c3379b52f9ff486c9f5892218d2a065cc8	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.000220443089776403	\N	exchange_rate
MOONWELL:8453:0x628ff693426583d9a7fb391e54366292f509d457	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	208333192.154227515686888547	\N	exchange_rate
MOONWELL:8453:0x3bf93770f2d4a794c3d9ebefbaebae2a8f09a5e5	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	216733605.747109494767794421	\N	exchange_rate
MOONWELL:8453:0x73b06d8d18de422e269645eace15400de7462417	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	212558003.549565820180640849	\N	exchange_rate
MOONWELL:8453:0xedc817a28e8b93b03976fbd4a3ddbc9f7d176c22	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.000245093569482374	\N	exchange_rate
MOONWELL:8453:0x627fe393bc6edda28e99ae648fd6ff362514304b	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	204391485.478999421342036281	\N	exchange_rate
MOONWELL:8453:0xcb1dacd30638ae38f2b94ea64f066045b7d45f44	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	200572906.400940412848003737	\N	exchange_rate
MOONWELL:8453:0x73902f619ceb9b31fd8efecf435cbdf89e369ba6	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	234670352.397711307540131274	\N	exchange_rate
MOONWELL:8453:0xb8051464c8c92209c92f3a4cd9c73746c4c3cfb3	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	200826151.812910847786873705	\N	exchange_rate
MOONWELL:8453:0xf877acafa28c19b96727966690b2f44d35ad5976	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.020400754831143901	\N	exchange_rate
MOONWELL:8453:0xb682c840b5f4fc58b20769e691a6fa1305a501a2	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.000234105451222881	\N	exchange_rate
MOONWELL:8453:0xfc41b49d064ac646015b459c522820db9472f4b5	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	200315967.962152253295497931	\N	exchange_rate
MOONWELL:8453:0xdc7810b47eaab250de623f0ee07764afa5f71ed1	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	202605454.846747219357943935	\N	exchange_rate
MOONWELL:8453:0xb6419c6c2e60c4025d6d06ee4f913ce89425a357	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	233154545.82548596214483951	\N	exchange_rate
MOONWELL:8453:0x9a858ebff1beb0d3495bb0e2897c1528ed84a218	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	201489389.552929516066922933	\N	exchange_rate
MOONWELL:8453:0x10ff57877b79e9bd949b3815220ec87b9fc5d2ee	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.020105419884082705	\N	exchange_rate
MOONWELL:8453:0xde8df9d942d78ede3ca06e60712582f79cfffc64	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	231720532.806285604998628834	\N	exchange_rate
MOONWELL:8453:0x6308204872bdb7432df97b04b42443c714904f3e	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	206093350.599579038741095121	\N	exchange_rate
MOONWELL:8453:0xb4fb8fed5b3aaa8434f0b19b1b623d977e07e86d	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	0.000205268673825236	\N	exchange_rate
MOONWELL:8453:0x2f90bb22eb3979f5ffad31ea6c3f0792ca66da32	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	998201751.177817123436228145	\N	exchange_rate
MOONWELL:8453:0xd64bcb70c613a6d1f4d7d57ba64bb4a0767a9682	2026-11-22T11:00:00.000Z	archival-rpc	60774126	\N	\N	\N	\N	\N	\N	\N	200002645.859719557565290795	\N	exchange_rate
MOONWELL:8453:0x703843c3379b52f9ff486c9f5892218d2a065cc8	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.000220443089776403	\N	exchange_rate
MOONWELL:8453:0x628ff693426583d9a7fb391e54366292f509d457	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	208332444.568262320860945323	\N	exchange_rate
MOONWELL:8453:0x3bf93770f2d4a794c3d9ebefbaebae2a8f09a5e5	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	216733605.747109494767794421	\N	exchange_rate
MOONWELL:8453:0x73b06d8d18de422e269645eace15400de7462417	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	212558003.549565820180640849	\N	exchange_rate
MOONWELL:8453:0xedc817a28e8b93b03976fbd4a3ddbc9f7d176c22	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.000245089145142281	\N	exchange_rate
MOONWELL:8453:0x627fe393bc6edda28e99ae648fd6ff362514304b	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	204391485.478999421342036281	\N	exchange_rate
MOONWELL:8453:0xcb1dacd30638ae38f2b94ea64f066045b7d45f44	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	200572906.400940412848003737	\N	exchange_rate
MOONWELL:8453:0x73902f619ceb9b31fd8efecf435cbdf89e369ba6	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	234670352.397711307540131274	\N	exchange_rate
MOONWELL:8453:0xb8051464c8c92209c92f3a4cd9c73746c4c3cfb3	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	200826151.812910847786873705	\N	exchange_rate
MOONWELL:8453:0xf877acafa28c19b96727966690b2f44d35ad5976	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.020400754831143901	\N	exchange_rate
MOONWELL:8453:0xb682c840b5f4fc58b20769e691a6fa1305a501a2	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.000234105451222881	\N	exchange_rate
MOONWELL:8453:0xfc41b49d064ac646015b459c522820db9472f4b5	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	200315967.962152253295497931	\N	exchange_rate
MOONWELL:8453:0xdc7810b47eaab250de623f0ee07764afa5f71ed1	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	202605454.846747219357943935	\N	exchange_rate
MOONWELL:8453:0xb6419c6c2e60c4025d6d06ee4f913ce89425a357	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	233154545.82548596214483951	\N	exchange_rate
MOONWELL:8453:0x9a858ebff1beb0d3495bb0e2897c1528ed84a218	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	201489389.552929516066922933	\N	exchange_rate
MOONWELL:8453:0x10ff57877b79e9bd949b3815220ec87b9fc5d2ee	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.020105419884082705	\N	exchange_rate
MOONWELL:8453:0xde8df9d942d78ede3ca06e60712582f79cfffc64	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	231720532.806285604998628834	\N	exchange_rate
MOONWELL:8453:0x6308204872bdb7432df97b04b42443c714904f3e	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	206093350.599579038741095121	\N	exchange_rate
MOONWELL:8453:0xb4fb8fed5b3aaa8434f0b19b1b623d977e07e86d	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	0.000205268673825236	\N	exchange_rate
MOONWELL:8453:0x2f90bb22eb3979f5ffad31ea6c3f0792ca66da32	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	998201751.177817123436228145	\N	exchange_rate
MOONWELL:8453:0xd64bcb70c613a6d1f4d7d57ba64bb4a0767a9682	2026-11-22T10:00:00.000Z	archival-rpc	60756127	\N	\N	\N	\N	\N	\N	\N	200002645.859719557565290795	\N	exchange_rate
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
