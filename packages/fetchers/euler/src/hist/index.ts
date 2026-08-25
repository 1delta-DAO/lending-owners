import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  mapWithConcurrency,
} from "@lending-owners/core";

const LENDER_KEY = "EULER";
const API = "https://v3.euler.finance/v3";

/**
 * Euler's Data API. Contrary to the original analysis it does **not** decay:
 * history begins at `max(vault createdAt, ~2026-04-23)` — the indexer's genesis
 * — and accumulates from there. What is capped is the *request*: 732 buckets at
 * `1d`, 744 at `1h`, enforced with an explicit `maxBuckets` BAD_REQUEST rather
 * than a silent truncation. See LENDING_HISTORY_BACKFILL_PLAN.md §0.3.1.
 */
const INDEXER_GENESIS = Date.UTC(2026, 3, 23);
const MAX_BUCKETS = { "1d": 732, "1h": 744 } as const;

interface EulerVault {
  chainId: number;
  address: string;
  symbol?: string;
  createdAt?: string;
}

interface TotalsPoint {
  totalAssets: string;
  totalBorrows: string;
  utilization: number;
  supplyApy: number;
  borrowApy: number;
  timestamp: string;
  totalAssetsUsd?: number;
  totalBorrowsUsd?: number;
}

export interface EulerHistoryConfig {
  /** Chains to walk. Defaults to those the Data API is known to serve. */
  chainIds?: ChainId[];
  concurrency?: number;
}

/** Chains the Data API serves, as of 2026-08. */
const DEFAULT_CHAINS = ["1", "130", "8453", "42161", "43114", "56", "9745", "146"] as ChainId[];

/** `limit` is capped at 100 by the API — asking for more silently returns 100,
 *  which quietly truncated Ethereum from 874 vaults to the first 100. Paging on
 *  `offset` is the only way to see the rest. */
const VAULT_PAGE = 100;

async function fetchVaults(client: PacedClient, chainId: ChainId): Promise<EulerVault[]> {
  const out: EulerVault[] = [];
  for (let offset = 0; ; offset += VAULT_PAGE) {
    const res = await client.getJson<{ data?: EulerVault[] } | EulerVault[]>(
      `${API}/evk/vaults?chainId=${chainId}&limit=${VAULT_PAGE}&offset=${offset}`,
    );
    const items = Array.isArray(res) ? res : (res.data ?? []);
    out.push(...items.map((v) => ({ ...v, chainId: Number(v.chainId ?? chainId) })));
    if (items.length < VAULT_PAGE) break;
    if (offset > 20_000) break;
  }
  return out;
}

export function createEulerHistoryFetcher(config: EulerHistoryConfig = {}): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "euler-api",
    earliest: () => new Date(INDEXER_GENESIS),

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (!ctx.resolveUid) throw new Error(`[${LENDER_KEY}] needs a uid resolver`);
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: config.concurrency ?? 4,
        minIntervalMs: 120,
        signal: ctx.signal,
      });

      const chains = (ctx.chainIds ?? config.chainIds ?? DEFAULT_CHAINS).filter(Boolean);
      const resolution = ctx.resolution;
      // Never ask for more buckets than the API accepts — it rejects the whole
      // request rather than trimming it.
      const cap = MAX_BUCKETS[resolution];
      const bucketMs = resolution === "1h" ? 3_600_000 : 86_400_000;
      const to = Math.max(ctx.from.getTime(), ctx.to.getTime());
      const from = Math.max(ctx.from.getTime(), to - (cap - 1) * bucketMs, INDEXER_GENESIS);
      const fromSec = Math.floor(from / 1000);
      const toSec = Math.floor(to / 1000);

      for (const chainId of chains) {
        let vaults: EulerVault[] = [];
        try {
          vaults = await fetchVaults(client, chainId);
        } catch (err) {
          console.warn(`[${LENDER_KEY}] chain ${chainId} vault list: ${(err as Error).message}`);
          continue;
        }
        if (vaults.length === 0) continue;

        let done = 0;
        let unresolved = 0;
        const results = await mapWithConcurrency(vaults, config.concurrency ?? 4, async (v) => {
          try {
            const res = await client.getJson<{ data?: { history?: TotalsPoint[] } }>(
              `${API}/evk/vaults/${chainId}/${v.address}/totals?resolution=${resolution}&from=${fromSec}&to=${toSec}`,
            );
            return { vault: v, points: res.data?.history ?? [] };
          } catch (err) {
            console.warn(`[${LENDER_KEY}] ${chainId}/${v.address}: ${(err as Error).message}`);
            return { vault: v, points: [] as TotalsPoint[] };
          } finally {
            done += 1;
            ctx.onProgress?.(done, vaults.length, `${LENDER_KEY} chain ${chainId}`);
          }
        });

        for (const { vault, points } of results) {
          // Euler's uid leaf is the VAULT address, and the family is keyed
          // `EULER_V2` in our book — not `EULER`.
          const marketUid = ctx.resolveUid(chainId, vault.address);
          if (!marketUid) {
            unresolved += 1;
            continue;
          }
          const lenderKey = marketUid.slice(0, marketUid.indexOf(":"));
          for (const p of points) {
            const tsMs = Date.parse(p.timestamp);
            if (!Number.isFinite(tsMs)) continue;
            yield {
              marketUid,
              lenderKey,
              chainId,
              dataTs: bucketStart(tsMs, resolution).toISOString(),
              observedTs: new Date(tsMs).toISOString(),
              source: "euler-api",
              // Euler already reports percent (8.18 = 8.18 %).
              depositRate: p.supplyApy,
              variableBorrowRate: p.borrowApy,
              totalDepositsUsd: p.totalAssetsUsd,
              totalDebtUsd: p.totalBorrowsUsd,
              utilization: p.utilization,
            };
          }
        }
        if (unresolved > 0) {
          console.warn(`[${LENDER_KEY}] chain ${chainId}: ${unresolved} vault(s) not in the book — skipped`);
        }
      }
    },
  };
}
