import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  type LenderKey,
  type MarketUid,
  PacedClient,
  bucketStart,
  mapWithConcurrency,
} from "@lending-owners/core";

/**
 * Fluid vaults as LENDING markets — the same `apr-history` route the earn-side
 * `VAULT_FLUID` module reads, keyed the way `lending_snapshots` needs it.
 *
 * ── Why a second Fluid module ───────────────────────────────────────────────
 * `VAULT_FLUID` emits one series per vault under `VAULT_FLUID:<chain>:<vault>`,
 * which no `markets` row carries. The live lending fetcher records a Fluid
 * vault as TWO markets, one per side, keyed by the vault's numeric id and the
 * side's token (verified against the prod book 2026-09-15):
 *
 *   FLUID_8453_1:8453:0x0000000000000000000000000000000000000000   ETH   depositRate
 *   FLUID_8453_1:8453:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913   USDC  variableBorrowRate
 *
 * so the supply-side row carries `supplyApr` and the borrow-side row carries
 * `borrowApr`; when both sides are the same token the one row carries both.
 * The vault's native-ETH sentinel `0xeeee…eeee` is `0x0000…0000` in our uids.
 *
 * ── What is deliberately NOT emitted ────────────────────────────────────────
 * Smart-collateral / smart-debt vaults (`type` 2, 3, 4 — DEX legs). Their live
 * rate is per-token liquidity rate PLUS the DEX trading yield
 * (margin-fetcher: `liquidityByToken[token].supplyRate + supplyDexTrading`),
 * and `apr-history` carries only the liquidity half. Emitting that would
 * back-fill a number systematically below the live one and paint a step into
 * every chart at the boundary. A gap is honest; a lower number is not. They
 * are counted and named in the log instead. Type-1 vaults are 26 of 33 on
 * Base and 21 of 32 on Plasma.
 *
 * Totals are not on this route either — rates only, hourly, block-stamped,
 * to vault inception (bounds MUST be ISO; unix seconds → HTTP 500).
 *
 * The uid is CONSTRUCTED, not resolved: the family resolver keys on the leaf
 * token and a chain has many Fluid vaults on the same token, so it would
 * answer "ambiguous" for every one of them. Rows for a (vault, side) the book
 * does not hold are skipped at the SQL `JOIN markets`, counted per file.
 */

const LENDER_KEY = "FLUID" as LenderKey;
const API = "https://api.fluid.instadapp.io";
const NATIVE_SENTINEL = "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee";
const ZERO = "0x0000000000000000000000000000000000000000";

/** Mirrors margin-fetcher `lending/public-data/fluid/apiData.ts`
 *  SUPPORTED_CHAINS — the chains the vault router serves rosters for. */
const CHAINS: ChainId[] = ["1", "56", "137", "8453", "9745", "42161"] as ChainId[];

interface TokenSide {
  token0?: { address?: string };
  token1?: { address?: string };
}

interface VaultRow {
  id: string | number;
  address: string;
  type?: string | number;
  supplyToken?: TokenSide;
  borrowToken?: TokenSide;
}

interface AprPoint {
  supplyApr?: number | string | null; // 1e2 scale: 187 = 1.87 %
  borrowApr?: number | string | null;
  blocknumber?: number | null;
  timestamp: number; // unix seconds
}

interface Market {
  chainId: ChainId;
  vaultId: string;
  address: string;
  supplyLeaf: string;
  borrowLeaf: string;
}

const num = (v: unknown): number | undefined => {
  if (v == null || v === "") return undefined;
  const n = Number(v);
  return Number.isFinite(n) ? n : undefined;
};

const leafOf = (side: TokenSide | undefined): string | undefined => {
  const a = side?.token0?.address?.toLowerCase();
  if (!a || a === ZERO) return undefined;
  return a === NATIVE_SENTINEL ? ZERO : a;
};

export interface FluidLendingHistoryConfig {
  concurrency?: number;
}

export function createFluidLendingHistoryFetcher(
  config: FluidLendingHistoryConfig = {},
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
      const skippedDex: string[] = [];
      for (const chainId of chains) {
        let vaults: VaultRow[] = [];
        try {
          vaults = (await client.getJson<VaultRow[]>(`${API}/v2/${chainId}/vaults`)) ?? [];
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} roster failed: ${(err as Error).message}`);
          continue;
        }
        for (const v of vaults) {
          if (String(v.type ?? "1") !== "1") {
            skippedDex.push(`${chainId}:${v.id}`);
            continue;
          }
          const supplyLeaf = leafOf(v.supplyToken);
          const borrowLeaf = leafOf(v.borrowToken);
          if (!supplyLeaf || !borrowLeaf) continue;
          markets.push({
            chainId,
            vaultId: String(v.id),
            address: v.address.toLowerCase(),
            supplyLeaf,
            borrowLeaf,
          });
        }
      }
      if (skippedDex.length) {
        console.log(
          `[${LENDER_KEY}] ${skippedDex.length} smart-collateral/debt vault(s) skipped — ` +
            `apr-history lacks their trading-yield leg: ${skippedDex.slice(0, 12).join(",")}` +
            (skippedDex.length > 12 ? " …" : ""),
        );
      }

      const start = ctx.from.toISOString();
      const end = ctx.to.toISOString();
      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      const results = await mapWithConcurrency(markets, config.concurrency ?? 3, async (m) => {
        const url = `${API}/v2/${m.chainId}/vaults/${m.address}/apr-history?start=${start}&end=${end}`;
        try {
          return { m, rows: (await client.getJson<AprPoint[]>(url)) ?? [] };
        } catch (err) {
          console.warn(`[${LENDER_KEY}] ${m.chainId}:${m.vaultId} skipped: ${(err as Error).message}`);
          return { m, rows: [] as AprPoint[] };
        } finally {
          done += 1;
          ctx.onProgress?.(done, markets.length, `${LENDER_KEY} ${m.chainId}:${m.vaultId}`);
        }
      });

      for (const { m, rows } of results) {
        if (rows.length === 0) continue;
        const lenderKey = `FLUID_${m.chainId}_${m.vaultId}` as LenderKey;
        const supplyUid = `${lenderKey}:${m.chainId}:${m.supplyLeaf}` as MarketUid;
        const borrowUid = `${lenderKey}:${m.chainId}:${m.borrowLeaf}` as MarketUid;
        const sameToken = m.supplyLeaf === m.borrowLeaf;

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
          const borrow = num(p.borrowApr);
          if (supply === undefined && borrow === undefined) continue;
          const base = {
            lenderKey,
            chainId: m.chainId,
            dataTs: new Date(bucket).toISOString(),
            observedTs: new Date(p.timestamp * 1000).toISOString(),
            source: "fluid-api" as const,
            blockNumber: p.blocknumber ?? undefined,
          };
          if (sameToken) {
            yield {
              ...base,
              marketUid: supplyUid,
              depositRate: supply !== undefined ? supply / 100 : undefined,
              variableBorrowRate: borrow !== undefined ? borrow / 100 : undefined,
            };
            continue;
          }
          if (supply !== undefined) {
            yield { ...base, marketUid: supplyUid, depositRate: supply / 100 };
          }
          if (borrow !== undefined) {
            yield { ...base, marketUid: borrowUid, variableBorrowRate: borrow / 100 };
          }
        }
      }
    },
  };
}
