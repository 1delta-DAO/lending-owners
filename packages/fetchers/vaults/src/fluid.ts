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
import { num } from "./shared.js";

/**
 * Fluid vaults + fTokens — HISTORY_APIS.md "fluid" row. Hourly to inception,
 * one request per market, undocumented (recovered from the app bundle).
 *
 * Rosters: `GET /v2/{chain}/vaults` (borrow vaults, a bare array) and
 * `GET /v2/lending/{chain}/tokens` (fTokens, under `.data`). History:
 *  - vault  `GET /v2/{chain}/vaults/{addr}/apr-history?start&end` — rows
 *    `{supplyApr, borrowApr, liquiditySupplyAprToken0/1,
 *    liquidityBorrowAprToken0/1, blocknumber, timestamp}` (verified live);
 *  - fToken `GET /{chain}/fluid-tokens/{addr}/apr-history?start&end` — NOTE
 *    the missing `/v2` prefix on this one — rows
 *    `{supplyApr, liquiditySupplyApr, blocknumber, timestamp}`.
 *
 * Two hard traps from the matrix, both re-verified: bounds MUST be ISO
 * strings (unix seconds → HTTP 500 leaking raw SQL), and omitting them
 * silently serves only ~30 days. Rates are on Fluid's 1e2 scale
 * (187 = 1.87 %) → divided by 100 to percent here. Series are hourly with a
 * per-point `blocknumber` (carried to `blockNumber`) — bucketed to
 * ctx.resolution keeping the LAST point per bucket.
 *
 * ~300 vaults + ~30 fTokens across six chains, so pacing is deliberate
 * (concurrency 3, ≥150 ms) and `ctx.chainIds` filtering is honoured — smoke
 * runs should pass `chainIds: ["1"]`.
 */

const LENDER_KEY = "VAULT_FLUID";
const API = "https://api.fluid.instadapp.io";

/** Mirrors margin-fetcher `lending/public-data/fluid/apiData.ts`
 *  SUPPORTED_CHAINS (verified 2026-08-25 — all six answer both rosters). */
const CHAINS: ChainId[] = ["1", "56", "137", "8453", "9745", "42161"] as ChainId[];

interface VaultRow {
  id?: string;
  type?: string;
  address: string;
}

interface FTokenRow {
  address: string;
  symbol?: string;
}

interface AprPoint {
  supplyApr?: number | null; // 1e2 scale: 187 = 1.87 %
  borrowApr?: number | null; // 1e2 scale (vault route only)
  liquiditySupplyApr?: number | null; // fToken route only
  blocknumber?: number | null;
  timestamp: number; // unix seconds, hourly
}

type Market =
  | { kind: "vault"; chainId: ChainId; address: string }
  | { kind: "ftoken"; chainId: ChainId; address: string };

export interface FluidVaultHistoryConfig {
  concurrency?: number;
}

export function createFluidVaultHistoryFetcher(
  config: FluidVaultHistoryConfig = {},
): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "fluid-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 3,
        minIntervalMs: 150,
        signal: ctx.signal,
      });

      const chains = CHAINS.filter((c) => !ctx.chainIds || ctx.chainIds.includes(c));
      const markets: Market[] = [];
      for (const chainId of chains) {
        try {
          const vaults = await client.getJson<VaultRow[]>(`${API}/v2/${chainId}/vaults`);
          for (const v of vaults ?? []) {
            markets.push({ kind: "vault", chainId, address: v.address.toLowerCase() });
          }
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} vault roster failed: ${(err as Error).message}`);
        }
        try {
          const ftokens = await client.getJson<{ data?: FTokenRow[] }>(
            `${API}/v2/lending/${chainId}/tokens`,
          );
          for (const t of ftokens.data ?? []) {
            markets.push({ kind: "ftoken", chainId, address: t.address.toLowerCase() });
          }
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} fToken roster failed: ${(err as Error).message}`);
        }
      }

      // ISO bounds are MANDATORY (unix → 500; absent → silent 30d window).
      const start = ctx.from.toISOString();
      const end = ctx.to.toISOString();
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      const results = await mapWithConcurrency(markets, config.concurrency ?? 3, async (m) => {
        const url =
          m.kind === "vault"
            ? `${API}/v2/${m.chainId}/vaults/${m.address}/apr-history?start=${start}&end=${end}`
            : // no /v2 prefix on the fToken route (see header)
              `${API}/${m.chainId}/fluid-tokens/${m.address}/apr-history?start=${start}&end=${end}`;
        try {
          const rows = await client.getJson<AprPoint[]>(url);
          return { m, rows: rows ?? [] };
        } catch (err) {
          console.warn(
            `[${LENDER_KEY}] ${m.chainId}:${m.address} (${m.kind}) skipped: ${(err as Error).message}`,
          );
          return { m, rows: [] as AprPoint[] };
        } finally {
          done += 1;
          ctx.onProgress?.(done, markets.length, `${LENDER_KEY} ${m.chainId}:${m.address}`);
        }
      });

      for (const { m, rows } of results) {
        if (rows.length === 0) continue;
        const marketUid = makeMarketUid(LENDER_KEY, m.chainId, m.address);

        // Hourly samples → keep the LAST per bucket.
        const byBucket = new Map<number, AprPoint>();
        for (const p of rows) {
          const tsMs = p.timestamp * 1000;
          if (tsMs < from || tsMs > to) continue;
          const bucket = bucketStart(tsMs, ctx.resolution).getTime();
          const prev = byBucket.get(bucket);
          if (!prev || p.timestamp >= prev.timestamp) byBucket.set(bucket, p);
        }

        for (const [bucket, p] of [...byBucket.entries()].sort((a, b) => a[0] - b[0])) {
          const supply = num(p.supplyApr);
          const borrow = m.kind === "vault" ? num(p.borrowApr) : undefined;
          if (supply === undefined && borrow === undefined) continue;
          yield {
            marketUid,
            lenderKey: LENDER_KEY,
            chainId: m.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(p.timestamp * 1000).toISOString(),
            source: "fluid-api",
            blockNumber: p.blocknumber ?? undefined,
            // 1e2 scale → percent (167 = 1.67 %).
            depositRate: supply !== undefined ? supply / 100 : undefined,
            variableBorrowRate: borrow !== undefined ? borrow / 100 : undefined,
          };
        }
      }
    },
  };
}
