import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
  mapWithConcurrency,
} from "@lending-owners/core";
import { decimalString, fractionToPercent, num } from "./shared.js";

/**
 * Upshift vaults — HISTORY_APIS.md "upshift" row.
 *
 * Roster: the same global un-paginated listing margin-fetcher's spot fetcher
 * reads (`app.upshift.finance/api/proxy/vaults`, every chain in one call —
 * incl. Solana/Sui/Stellar rows under synthetic ids like `-1`/`101`, filtered
 * out here by requiring a 42-char 0x address). History: the UPSTREAM host —
 * `api.augustdigital.io/api/v1/tokenized_vault/{addr}/historical-timeseries` —
 * because the app's `/api/proxy/` does NOT forward that route, the listing's
 * inline `historical_snapshots` are always empty, and `historical_apy/chart`
 * is a rolling ~30-point window. Daily to inception (`n_days` ≥3000 accepted).
 *
 * Units verified live 2026-08-25 on Kelp Gain: `daily_apy` is a FRACTION —
 * mean 0.0135 over 59 days vs 0.0141 realized from annualizing the
 * `asset_share_ratio` delta over the same span (the listing's headline 6.74
 * "APY" is a percent COMPOSITE incl. underlying/points and matches neither —
 * never calibrate against it). `tvl` is USD (`total_assets × share_price`
 * reproduces it). `asset_share_ratio` is the asset-terms pps → `supplyIndex`;
 * `share_price` is the USD-ish leg and is not emitted.
 *
 * Trap: the history route is ADDRESS-ONLY — no chain parameter exists, so the
 * chain is taken from the roster row, and if two roster rows ever share an
 * address on different chains the response would be ambiguous: those are
 * warned about and skipped (zero collisions in the live listing today).
 */

const LENDER_KEY = "VAULT_UPSHIFT";
const ROSTER_URL = "https://app.upshift.finance/api/proxy/vaults";
const HISTORY_API = "https://api.augustdigital.io/api/v1";
const MAX_N_DAYS = 3000;

const EVM_ADDRESS = /^0x[0-9a-fA-F]{40}$/;

interface RosterVault {
  chainId: number | null;
  address: string | null;
  name: string | null;
}

interface TimeseriesRow {
  tvl?: number | null;
  daily_apy?: number | null; // FRACTION (verified live — see header)
  daily_pnl?: number | null;
  share_price?: number | null;
  total_assets?: number | null;
  total_shares?: number | null;
  asset_share_ratio?: number | null;
  missing?: boolean;
}

interface TimeseriesResponse {
  /** Map keyed by "YYYY-MM-DD". */
  data?: Record<string, TimeseriesRow>;
  trailing_apy?: Record<string, number>;
}

export interface UpshiftVaultHistoryConfig {
  concurrency?: number;
}

export function createUpshiftVaultHistoryFetcher(
  config: UpshiftVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "upshift-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const roster = await client.getJson<{ data?: RosterVault[] }>(ROSTER_URL);
      const rows = (roster.data ?? [])
        .map((v) => ({
          chainId: String(v.chainId ?? "") as ChainId,
          address: (v.address ?? "").toLowerCase(),
          name: v.name ?? "",
        }))
        // Positive numeric chain + EVM address ⇒ an EVM row; the listing also
        // carries Solana (-1/101), Stellar (-3) and test chains.
        .filter((v) => Number(v.chainId) > 0 && EVM_ADDRESS.test(v.address))
        .filter((v) => !ctx.chainIds || ctx.chainIds.includes(v.chainId));

      // Address-only history route: an address serving two chains would be
      // ambiguous — skip BOTH sides of a collision rather than guess.
      const byAddress = new Map<string, typeof rows>();
      for (const v of rows) {
        const list = byAddress.get(v.address) ?? [];
        list.push(v);
        byAddress.set(v.address, list);
      }
      const vaults: typeof rows = [];
      for (const [address, list] of byAddress) {
        const chains = new Set(list.map((v) => v.chainId));
        if (chains.size > 1) {
          console.warn(
            `[${LENDER_KEY}] ${address} appears on chains ${[...chains].join(",")} — ` +
              `history route has no chain param, skipping all (collision)`,
          );
          continue;
        }
        vaults.push(list[0]!);
      }

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const nDays = Math.min(
        MAX_N_DAYS,
        Math.ceil((Date.now() - from) / 86_400_000) + 2,
      );
      let done = 0;

      const results = await mapWithConcurrency(vaults, config.concurrency ?? 3, async (v) => {
        try {
          const res = await client.getJson<TimeseriesResponse>(
            `${HISTORY_API}/tokenized_vault/${v.address}/historical-timeseries?n_days=${nDays}`,
          );
          return { v, data: res.data };
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] ${v.chainId}:${v.address} skipped: ${(err as Error).message}`,
          );
          return { v, data: undefined };
        } finally {
          done += 1;
          ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} ${v.name}`);
        }
      });

      for (const { v, data } of results) {
        if (!data) continue;
        const marketUid = makeMarketUid(LENDER_KEY, v.chainId, v.address);
        for (const [date, row] of Object.entries(data)) {
          if (row.missing === true) continue;
          const tsMs = Date.parse(`${date}T00:00:00Z`);
          if (!Number.isFinite(tsMs) || tsMs < from || tsMs > to) continue;
          const apy = num(row.daily_apy);
          const ratio = decimalString(row.asset_share_ratio);
          const tvl = num(row.tvl);
          if (apy === undefined && ratio === undefined && tvl === undefined) continue;
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: v.chainId,
            dataTs: bucketStart(tsMs, "1d").toISOString(),
            source: "upshift-api",
            depositRate: apy !== undefined ? fractionToPercent(apy) : undefined,
            totalDepositsUsd: tvl,
            supplyIndex: ratio,
            indexKind: ratio !== undefined ? "assets_per_share" : undefined,
          };
        }
      }
    },
  };
}
