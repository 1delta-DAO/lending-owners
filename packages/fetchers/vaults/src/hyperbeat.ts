import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";
import { num } from "./shared.js";

/**
 * Hyperbeat vaults (HyperEVM, chain 999) — HISTORY_APIS.md "hyperbeat" row.
 *
 * The route margin-fetcher's spot fetcher calls with `limit=1` IS the history
 * API: `GET /api/v1/vaults/apy/{vaultAddr}?limit=N&offset=M`, daily rows
 * newest-first since inception, `total_count` on the response. APY only —
 * no share price or TVL series exists (record pps forward from each vault's
 * Pricer `getRate()` if ever needed).
 *
 * Values are PERCENT strings ("4.5669"), matching the repo convention — no
 * scaling. Leading pre-launch rows are all-zero padding and are skipped.
 */

const LENDER_KEY = "VAULT_HYPERBEAT";
const CHAIN_ID = "999" as ChainId;
const API = "https://api.hyperbeat.org/api/v1";
const PAGE = 500;

/** The four live core vaults, mirrored from margin-fetcher's savings
 *  registry (the docs' Midas-era addresses are RETIRED — never use those).
 *  The roster is a pinned list because no public vault-list route exists
 *  (`/vaults` 404s). */
const VAULTS: Array<{ address: string; symbol: string }> = [
  { address: "0x5e105266db42f78fa814322bce7f388b4c2e61eb", symbol: "hbUSDT" },
  { address: "0x057ced81348d57aad579a672d521d7b4396e8a61", symbol: "hbUSDC" },
  { address: "0x81e064d0eb539de7c3170edf38c1a42cbd752a76", symbol: "lstHYPE" },
  { address: "0x441794d6a8f9a3739f5d4e98a728937b33489d29", symbol: "liquidHYPE" },
];

interface ApyRow {
  date: string; // "2026-08-25" — the stable key; `timestamp` drifts intraday
  timestamp: number;
  apy: string;
  apy_since_launch?: string;
}

interface ApyResponse {
  success: boolean;
  history?: ApyRow[];
  total_count?: number;
}

export function createHyperbeatVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "hyperbeat-api",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      if (ctx.chainIds && !ctx.chainIds.includes(CHAIN_ID)) return;
      const client = new PacedClient({
        label: LENDER_KEY,
        concurrency: 2,
        minIntervalMs: 200,
        signal: ctx.signal,
      });

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      let done = 0;

      for (const vault of VAULTS) {
        const marketUid = makeMarketUid(LENDER_KEY, CHAIN_ID, vault.address);
        // Newest-first pages; stop as soon as a page's oldest row predates the
        // window instead of walking the whole archive on every daily run.
        for (let offset = 0; ; offset += PAGE) {
          const res = await client.getJson<ApyResponse>(
            `${API}/vaults/apy/${vault.address}?limit=${PAGE}&offset=${offset}`,
          );
          const rows = res.history ?? [];
          if (rows.length === 0) break;

          let pageFloor = Number.POSITIVE_INFINITY;
          for (const row of rows) {
            const tsMs = Date.parse(`${row.date}T00:00:00Z`);
            if (!Number.isFinite(tsMs)) continue;
            pageFloor = Math.min(pageFloor, tsMs);
            if (tsMs < from || tsMs > to) continue;

            const apy = num(row.apy);
            // Pre-launch padding: every APY field is exactly 0 before the
            // vault's first real accrual day (HISTORY_APIS.md trap).
            if (apy === undefined || (apy === 0 && num(row.apy_since_launch) === 0)) continue;

            yield {
              marketUid,
              lenderKey: LENDER_KEY,
              chainId: CHAIN_ID,
              dataTs: bucketStart(tsMs, "1d").toISOString(),
              observedTs: new Date(row.timestamp * 1000).toISOString(),
              source: "hyperbeat-api",
              depositRate: apy, // already percent
            };
          }

          if (rows.length < PAGE || pageFloor < from) break;
        }
        done += 1;
        ctx.onProgress?.(done, VAULTS.length, `${LENDER_KEY} ${vault.symbol}`);
      }
    },
  };
}
