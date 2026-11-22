-- Generated from VAULT_LLAMA/42161/2026-08.ndjson (155 vault rows)
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
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-01T23:00:00.000Z	defillama-api	4.71591172832575	\N	26880	1.07658	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-02T23:00:00.000Z	defillama-api	4.732671269280786	\N	26883	1.07673	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-03T23:00:00.000Z	defillama-api	4.639806858719453	\N	25812	1.07684	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-04T23:00:00.000Z	defillama-api	4.902699312125947	\N	26782	1.07706	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-05T23:00:00.000Z	defillama-api	4.699216609438395	\N	26722	1.07718	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-06T23:00:00.000Z	defillama-api	4.864596460052439	\N	26786	1.07734	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-07T23:00:00.000Z	defillama-api	4.679446037059165	\N	26790	1.07749	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-08T23:00:00.000Z	defillama-api	4.738488862088275	\N	29797	1.07764	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-09T23:00:00.000Z	defillama-api	4.714051891241411	\N	29800	1.07777	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-10T23:00:00.000Z	defillama-api	4.677642219164113	\N	29804	1.07791	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-11T23:00:00.000Z	defillama-api	4.671487110741168	\N	29793	1.07808	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-12T23:00:00.000Z	defillama-api	4.733911394083634	\N	29796	1.0782	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-13T23:00:00.000Z	defillama-api	4.612843422435731	\N	29800	1.07835	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-14T23:00:00.000Z	defillama-api	4.679588885991848	\N	29804	1.07848	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-15T23:00:00.000Z	defillama-api	4.674559763273578	\N	29808	1.07864	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-16T23:00:00.000Z	defillama-api	4.633906637607765	\N	29812	1.07876	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-17T23:00:00.000Z	defillama-api	4.6376396163338995	\N	29816	1.0789	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-18T23:00:00.000Z	defillama-api	4.671763705488274	\N	29819	1.07904	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-19T23:00:00.000Z	defillama-api	4.660262965927586	\N	29824	1.07919	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-20T23:00:00.000Z	defillama-api	4.739700277056613	\N	29829	1.07938	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-21T23:00:00.000Z	defillama-api	4.720748285080845	\N	29832	1.0795	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-22T23:00:00.000Z	defillama-api	4.660635493536347	\N	29278	1.07962	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-23T23:00:00.000Z	defillama-api	4.81128859952662	\N	28897	1.07985	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-24T23:00:00.000Z	defillama-api	4.717782069008081	\N	28900	1.07994	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-25T23:00:00.000Z	defillama-api	4.694522201376117	\N	28903	1.08006	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-26T23:00:00.000Z	defillama-api	4.79893706852863	\N	28848	1.0802	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-27T23:00:00.000Z	defillama-api	4.76261562667446	\N	27488	1.08034	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-28T23:00:00.000Z	defillama-api	4.710131248231164	\N	27401	1.08046	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-29T23:00:00.000Z	defillama-api	4.809735467503629	\N	27607	1.0807	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-30T23:00:00.000Z	defillama-api	4.731593600126871	\N	27608	1.08076	assets_per_share
VAULT_LLAMA	42161	0x000000001dc8bd45d7e7829fb1c969cbe4d0d1ec	2026-08-31T23:00:00.000Z	defillama-api	4.773141632341549	\N	27612	1.08091	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-01T23:00:00.000Z	defillama-api	3.450576889818535	\N	31675	1.01011	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-02T23:00:00.000Z	defillama-api	3.4709202584082277	\N	31679	1.0102	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-03T23:00:00.000Z	defillama-api	3.517069566782993	\N	31676	1.01031	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-04T23:00:00.000Z	defillama-api	3.54773727195834	\N	31686	1.0104	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-05T23:00:00.000Z	defillama-api	3.5990403457475395	\N	31681	1.01051	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-06T23:00:00.000Z	defillama-api	3.6606530510852053	\N	32165	1.01062	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-07T23:00:00.000Z	defillama-api	3.6990247952672917	\N	32170	1.01072	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-08T23:00:00.000Z	defillama-api	3.685744045966999	\N	32177	1.01082	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-09T23:00:00.000Z	defillama-api	3.6930881616825673	\N	32181	1.01093	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-10T23:00:00.000Z	defillama-api	3.705596546410561	\N	32166	1.01104	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-11T23:00:00.000Z	defillama-api	3.7206860152849686	\N	32168	1.01115	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-12T23:00:00.000Z	defillama-api	3.7151555208225773	\N	32169	1.01125	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-13T23:00:00.000Z	defillama-api	3.7019153854345177	\N	50167	1.01134	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-14T23:00:00.000Z	defillama-api	3.6422570495631135	\N	50175	1.01142	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-15T23:00:00.000Z	defillama-api	3.6058312719688956	\N	47974	1.0115	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-16T23:00:00.000Z	defillama-api	3.5668258107079964	\N	47979	1.01158	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-17T23:00:00.000Z	defillama-api	3.5123387462476785	\N	46780	1.01167	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-18T23:00:00.000Z	defillama-api	3.4810814391050826	\N	46789	1.01175	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-19T23:00:00.000Z	defillama-api	3.4214455109093933	\N	46786	1.01184	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-20T23:00:00.000Z	defillama-api	3.354095740348839	\N	46800	1.01192	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-21T23:00:00.000Z	defillama-api	3.294500426065383	\N	45816	1.012	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-22T23:00:00.000Z	defillama-api	3.237503001685127	\N	45818	1.01208	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-23T23:00:00.000Z	defillama-api	3.1547213449556466	\N	45802	1.01216	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-24T23:00:00.000Z	defillama-api	3.084836005839975	\N	45789	1.01224	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-25T23:00:00.000Z	defillama-api	3.0278448836185134	\N	45794	1.01233	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-26T23:00:00.000Z	defillama-api	2.98891364778342	\N	45803	1.01241	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-27T23:00:00.000Z	defillama-api	2.9706268836804384	\N	45800	1.0125	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-28T22:00:00.000Z	defillama-api	2.9935821469706525	\N	45800	1.01258	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-29T23:00:00.000Z	defillama-api	3.01135003333286	\N	45805	1.01267	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-30T23:00:00.000Z	defillama-api	3.023973257398893	\N	45406	1.01276	assets_per_share
VAULT_LLAMA	42161	0xeba62b842081cef5a8184318dc5c4e4aaca9f651	2026-08-31T23:00:00.000Z	defillama-api	3.046897009895133	\N	45412	1.01285	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-01T23:00:00.000Z	defillama-api	2.3901175310925282	\N	199342	1.00709	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-02T23:00:00.000Z	defillama-api	2.27513114268163	\N	203119	1.00712	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-03T23:00:00.000Z	defillama-api	2.18797788846814	\N	200568	1.00716	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-04T23:00:00.000Z	defillama-api	2.1320882435560407	\N	202258	1.0072	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-05T23:00:00.000Z	defillama-api	2.079683692457479	\N	205796	1.00724	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-06T23:00:00.000Z	defillama-api	2.0219405126198353	\N	205426	1.00727	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-07T23:00:00.000Z	defillama-api	1.955514358442656	\N	206684	1.0073	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-08T23:00:00.000Z	defillama-api	1.7158054465227224	\N	207442	1.00734	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-09T23:00:00.000Z	defillama-api	1.524460701674002	\N	207218	1.00737	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-10T23:00:00.000Z	defillama-api	1.4184030717956375	\N	202378	1.0074	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-11T23:00:00.000Z	defillama-api	1.3272528484264967	\N	208553	1.00744	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-12T23:00:00.000Z	defillama-api	1.264708824066929	\N	208155	1.00746	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-13T23:00:00.000Z	defillama-api	1.24356578155016	\N	209637	1.00749	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-14T23:00:00.000Z	defillama-api	1.241234683035941	\N	208246	1.00753	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-15T23:00:00.000Z	defillama-api	1.2409090714982085	\N	208995	1.00757	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-16T23:00:00.000Z	defillama-api	1.2456398920335232	\N	207803	1.0076	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-17T23:00:00.000Z	defillama-api	1.2294909602417192	\N	212333	1.00763	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-18T23:00:00.000Z	defillama-api	1.2115410115143277	\N	213312	1.00767	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-19T23:00:00.000Z	defillama-api	1.2004457108361066	\N	250787	1.0077	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-20T23:00:00.000Z	defillama-api	1.235545934363813	\N	258441	1.00775	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-21T23:00:00.000Z	defillama-api	1.3802701094078884	\N	281567	1.00784	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-22T23:00:00.000Z	defillama-api	1.428981595452683	\N	269229	1.00789	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-23T23:00:00.000Z	defillama-api	1.4600393342334428	\N	274256	1.00794	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-24T23:00:00.000Z	defillama-api	1.4918757397452964	\N	276566	1.00798	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-25T23:00:00.000Z	defillama-api	1.5321717430794024	\N	274054	1.00803	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-26T23:00:00.000Z	defillama-api	1.579362308135046	\N	279474	1.00807	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-27T23:00:00.000Z	defillama-api	1.5821086488898572	\N	281919	1.00811	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-28T22:00:00.000Z	defillama-api	1.667981864628132	\N	271593	1.00818	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-29T23:00:00.000Z	defillama-api	1.752925862064103	\N	277054	1.00825	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-30T23:00:00.000Z	defillama-api	1.8031253578243422	\N	279279	1.0083	assets_per_share
VAULT_LLAMA	42161	0xfe8f223f3d81462f55bf8609897b8cecfa4b195c	2026-08-31T23:00:00.000Z	defillama-api	1.8656875884204283	\N	279245	1.00836	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-01T23:00:00.000Z	defillama-api	4.08334514361286	\N	247342	1.05809	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-02T23:00:00.000Z	defillama-api	4.03601593106373	\N	244405	1.05821	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-03T23:00:00.000Z	defillama-api	4.016853166888268	\N	244177	1.05832	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-04T23:00:00.000Z	defillama-api	4.011608370291242	\N	244345	1.05844	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-05T23:00:00.000Z	defillama-api	4.037620180596946	\N	244388	1.05856	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-06T23:00:00.000Z	defillama-api	4.289060210993512	\N	236766	1.05867	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-07T23:00:00.000Z	defillama-api	4.691440445725448	\N	236720	1.05881	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-08T23:00:00.000Z	defillama-api	4.304349248229755	\N	239405	1.05894	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-09T23:00:00.000Z	defillama-api	4.1174377219732605	\N	239855	1.05906	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-10T23:00:00.000Z	defillama-api	4.114981280523011	\N	239753	1.05919	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-11T23:00:00.000Z	defillama-api	4.390549475985495	\N	239850	1.05929	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-12T23:00:00.000Z	defillama-api	4.332813298546512	\N	233091	1.05941	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-13T23:00:00.000Z	defillama-api	3.919494616866359	\N	232994	1.05952	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-14T23:00:00.000Z	defillama-api	3.8529221125571667	\N	232450	1.05964	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-15T23:00:00.000Z	defillama-api	3.8478516756867975	\N	232397	1.05975	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-16T23:00:00.000Z	defillama-api	3.844445008738262	\N	232378	1.05987	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-17T23:00:00.000Z	defillama-api	3.8504684720663818	\N	231928	1.05999	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-18T23:00:00.000Z	defillama-api	3.8541734411978723	\N	231916	1.0601	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-19T23:00:00.000Z	defillama-api	3.8562993694313263	\N	231628	1.06021	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-20T23:00:00.000Z	defillama-api	3.8614090197341966	\N	233970	1.06033	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-21T23:00:00.000Z	defillama-api	3.850661038029557	\N	233706	1.06043	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-22T23:00:00.000Z	defillama-api	3.8684898452601146	\N	234378	1.06055	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-23T23:00:00.000Z	defillama-api	3.8538464291804075	\N	240139	1.06067	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-24T23:00:00.000Z	defillama-api	3.843184576979297	\N	238294	1.06078	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-25T23:00:00.000Z	defillama-api	3.9172636526529914	\N	237816	1.0609	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-26T23:00:00.000Z	defillama-api	4.121410882973464	\N	238059	1.06102	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-27T23:00:00.000Z	defillama-api	4.121679775082043	\N	237891	1.06114	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-28T23:00:00.000Z	defillama-api	4.148891096278362	\N	238892	1.06127	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-29T22:00:00.000Z	defillama-api	4.127465857095558	\N	240139	1.06138	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-30T23:00:00.000Z	defillama-api	4.131313675159731	\N	239933	1.06151	assets_per_share
VAULT_LLAMA	42161	0x0000000f2eb9f69274678c76222b35eec7588a65	2026-08-31T23:00:00.000Z	defillama-api	4.137454778785354	\N	239351	1.06167	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-01T23:00:00.000Z	defillama-api	7.488610912176341	\N	146078	1.00807	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-02T23:00:00.000Z	defillama-api	6.790057923922177	\N	155092	1.00824	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-03T23:00:00.000Z	defillama-api	6.100487612670236	\N	157497	1.00842	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-04T23:00:00.000Z	defillama-api	6.854442178649833	\N	165086	1.00865	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-05T23:00:00.000Z	defillama-api	6.8475700246040105	\N	173157	1.00886	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-06T23:00:00.000Z	defillama-api	6.557067813517392	\N	185119	1.00905	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-07T23:00:00.000Z	defillama-api	6.451389713646449	\N	195348	1.0092	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-08T23:00:00.000Z	defillama-api	6.31964658523998	\N	197453	1.00936	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-09T23:00:00.000Z	defillama-api	6.264995664650996	\N	199637	1.00954	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-10T23:00:00.000Z	defillama-api	6.31937419193207	\N	218726	1.0097	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-11T23:00:00.000Z	defillama-api	6.582088784412576	\N	216715	1.00987	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-12T23:00:00.000Z	defillama-api	5.879131987640562	\N	221087	1.01006	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-13T23:00:00.000Z	defillama-api	6.337546816936879	\N	219321	1.01023	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-14T23:00:00.000Z	defillama-api	6.358128267081042	\N	212518	1.0104	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-15T23:00:00.000Z	defillama-api	6.298653394054554	\N	213494	1.01057	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-16T23:00:00.000Z	defillama-api	6.259435059874363	\N	217486	1.01078	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-17T23:00:00.000Z	defillama-api	6.570992783494489	\N	222339	1.01096	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-18T23:00:00.000Z	defillama-api	6.406772530098692	\N	223999	1.01114	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-19T23:00:00.000Z	defillama-api	6.159450610354611	\N	219324	1.01132	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-20T23:00:00.000Z	defillama-api	6.528058976584816	\N	224549	1.0115	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-21T23:00:00.000Z	defillama-api	4.996556662817397	\N	231926	1.01168	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-22T23:00:00.000Z	defillama-api	6.049331589252915	\N	233660	1.01189	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-23T23:00:00.000Z	defillama-api	5.99682200217444	\N	250917	1.01202	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-24T23:00:00.000Z	defillama-api	6.244959001122652	\N	256743	1.01215	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-25T23:00:00.000Z	defillama-api	5.809058984240778	\N	255390	1.01227	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-26T23:00:00.000Z	defillama-api	5.7330353424589475	\N	259663	1.01237	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-27T23:00:00.000Z	defillama-api	5.909243702362232	\N	265888	1.01252	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-28T23:00:00.000Z	defillama-api	5.689740211778371	\N	273896	1.01268	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-29T22:00:00.000Z	defillama-api	5.521954336984436	\N	273923	1.01281	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-30T23:00:00.000Z	defillama-api	5.64628472616846	\N	269006	1.01293	assets_per_share
VAULT_LLAMA	42161	0x5dd8bfa6c5c68d05d25ef6143e05c11e26c4cdb7	2026-08-31T23:00:00.000Z	defillama-api	5.7176048567697535	\N	283088	1.01306	assets_per_share
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
