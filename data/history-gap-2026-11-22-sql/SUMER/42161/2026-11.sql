-- Generated from SUMER/42161/2026-11.ndjson (108 rows)
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
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-21T20:00:00.000Z	archival-rpc	526327423	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-21T19:00:00.000Z	archival-rpc	526315886	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-22T08:00:00.000Z	archival-rpc	526460101	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-22T10:00:00.000Z	archival-rpc	526484752	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-22T09:00:00.000Z	archival-rpc	526472688	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x3c752d0d78bbfdda6bf4b6000a01228b732441ae	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x4de3741e1676ed14d661b1398196dc221ca4d37a	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xdb7fe9c415281e383595c262e49568ddc18e8bd4	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x873449359d2d99691436e724c6c219a39b159b4a	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1167e762541374febeea0f6ed2ad4473afa1ccea	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x1a9cfa6c676ebbed450db3cef03e399465f1202c	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x59ac82d3efb5dc6c4389ccff7ab7ab6c72c6ac05	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x142017b52c99d3dfe55e49d79df0baf7f4478c0c	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xe4b55045ed14815c7c42eeef8ee431b89422c389	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x9c93423939c4e3d48d99bad147ad808be89b2043	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xac6baf36b28d19ea10959102158beb3d933c1fbf	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xd5bda72030d9531fb311ddfe09af5502c3492e0c	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x7ecac6929fdc7f98395857fc8b460f14c6898609	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xee67db245248bdc84a6634e9a3e30ff78eeb6179	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x32be989f762470473878456ab3fb8f6a5bb0205c	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0xaec7d67d07e1f5833a8587fdcb0b7fe50347a8f5	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x6c6e01110563305537d303e468b23a453bed2197	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
SUMER:42161:0x54525258ba4f089e72f062b0cc66774639b2e259	2026-11-22T11:00:00.000Z	archival-rpc	526496964	0	0	0	0	0	0	0	\N	\N	\N
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
