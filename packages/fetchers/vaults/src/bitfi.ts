import {
  type ChainId,
  type HistoryContext,
  type HistoryFetcher,
  type HistoryPoint,
  PacedClient,
  bucketStart,
  makeMarketUid,
} from "@lending-owners/core";

/**
 * `VAULT_BITFI` — bfBTC and the bfUSD vaults, replayed from the ledgers the
 * CONTRACTS keep. No archival RPC, no API: `StakedBitFiStablecoin.epochRatios
 * (epoch)` returns `(startRatio, endRatio, startTime, endTime)` per epoch and
 * `Bfbtc.ratio(epoch)` returns the epoch's close, so the whole life of both
 * products is one loop over epoch indices against ANY node (this is contract
 * storage, not historical state). BITFI.md in lending-sdks is the source of
 * every fact below; the margin-fetcher `bitfiFetcher` reads the same ledgers
 * for the spot rate.
 *
 * ## The two clocks
 *
 * The vaults carry their own timestamps. bfBTC does not — `ratio(epoch)` is
 * just a number — but both ledgers are pushed in the SAME multisig batch
 * (bfBTC epoch 416 landed at 1788858683 against the vaults' epoch-281
 * `startTime` 1788858731, 48 s apart), so bfBTC's epoch `e` is dated by vault
 * epoch `e − 135`. That offset is pinned here and re-checked at runtime: if
 * the anchor pair ever drifts by more than an epoch, the module refuses
 * rather than mis-date a year of NAV.
 *
 * ## Scales and signs
 *
 *  - bfBTC `ratio` is INVERTED and 1e8-scaled — bfBTC per BTC, only ever
 *    falls — so BTC per bfBTC (assets per share) is `1e8 / ratio`.
 *  - the vaults' `endRatio` is assets per share × 1e8, growing (1.0 → 1.028),
 *    on the 6-decimal bfUSD vaults too — normalising by `decimals()` reads
 *    102.79 instead of 1.0279.
 *  - `ratio(currentEpoch)` is 0: the live epoch is unwritten. The loop stops
 *    at the first zero.
 *  - an epoch is ~89,580 s, not a day. Points are bucketed on the epoch's
 *    END time (the vaults') and never assumed 86,400 apart.
 *
 * ## One product, six chains
 *
 * bfBTC is a single NAV pushed to every chain a few minutes apart, under a
 * chain-LOCAL epoch index (417 / 444 / 76 for the same ratio) and, on TAC and
 * GOAT, a ratio that runs 3.9 % stale. The registered chains (1 / 56 / 8453 /
 * 43111 / 1672 / 200901) all track mainnet, so the Ethereum series is emitted
 * under each chain's uid, stamped `observedTs` with mainnet's clock. That is a
 * statement about the PRODUCT, not a per-chain measurement — the alternative,
 * a chain-local replay with no timestamps, would be a series with no x-axis.
 */

const LENDER_KEY = "VAULT_BITFI";
const RPC_LIST = "https://raw.githubusercontent.com/1delta-DAO/rpc-tester/main/rpcs/1.json";
const ETH = "1" as ChainId;

const BFBTC = "0xcdfb58c8c859cb3f62ebe9cf2767f9e036c7fb15";
/** bfBTC's address is a vanity pair — `0xCdFb…` on 1/1116/200901, `0x623F…` on
 *  the rest. Mirrors of the mainnet NAV, see header. */
const BFBTC_MIRRORS: Array<{ chainId: ChainId; address: string }> = [
  { chainId: "56" as ChainId, address: "0x623f2774d9f27b59bc6b954544487532ce79d9df" },
  { chainId: "8453" as ChainId, address: "0x623f2774d9f27b59bc6b954544487532ce79d9df" },
  { chainId: "43111" as ChainId, address: "0x623f2774d9f27b59bc6b954544487532ce79d9df" },
  { chainId: "1672" as ChainId, address: "0x623f2774d9f27b59bc6b954544487532ce79d9df" },
  { chainId: "200901" as ChainId, address: "0xcdfb58c8c859cb3f62ebe9cf2767f9e036c7fb15" },
];
const VAULTS: Array<{ address: string; symbol: string }> = [
  { address: "0xde5d4ab42251ba9af6f247cf07c9a4793fa6ed88", symbol: "hbfUSD" },
  { address: "0x4f85cbfdefbdb3fa96fcf1e38b0ee68db9ae438b", symbol: "pbfUSD" },
];

/** bfBTC epoch ↔ vault epoch, measured 2026-09-10 (416 ↔ 281), with the vault
 *  epoch's `startTime` pinned so a re-indexed ledger is detected rather than
 *  mis-dated. The two ledgers are not in perfect lockstep — bfBTC's write runs
 *  a couple of epochs AHEAD of the vaults' — so the newest bfBTC epochs are
 *  undatable until the vault catches up, and are simply skipped that run. */
const ANCHOR = { bfbtcEpoch: 416, vaultEpoch: 281, vaultStartTime: 1_788_858_731 };
const EPOCH_OFFSET = ANCHOR.bfbtcEpoch - ANCHOR.vaultEpoch;

const SEL = { ratio: "0x008df454", epochRatios: "0x29fda7af", currentEpoch: "0x76671808" } as const;
const RATIO_SCALE = 100_000_000n;

const pad = (n: number | bigint) => n.toString(16).padStart(64, "0");
const word = (hex: string | undefined, i: number): bigint | undefined => {
  if (!hex || hex === "0x") return undefined;
  const w = hex.replace(/^0x/, "").slice(i * 64, i * 64 + 64);
  return w.length === 64 ? BigInt("0x" + w) : undefined;
};
const dec8 = (v: bigint): string => {
  const s = v.toString().padStart(9, "0");
  const frac = s.slice(-8).replace(/0+$/, "");
  return s.slice(0, -8) + (frac ? "." + frac : "");
};

interface RpcResult {
  id: number;
  result?: string;
  error?: { message?: string };
}

export function createBitfiVaultHistoryFetcher(): HistoryFetcher {
  return {
    lenderKey: LENDER_KEY,
    source: "bitfi-onchain",

    async *fetch(ctx: HistoryContext): AsyncGenerator<HistoryPoint> {
      // ONE attempt per endpoint: failover across the list is this module's
      // own retry, and the client's 429 backoff (up to ~60 s per endpoint)
      // otherwise turns a rate-limited first entry into a ten-minute stall.
      const client = new PacedClient({ label: LENDER_KEY, concurrency: 2, minIntervalMs: 150, maxAttempts: 1, signal: ctx.signal });
      const list = (await client.getJson<{ rpcs: Array<{ url: string }> }>(RPC_LIST)).rpcs.map((r) => r.url);

      const batch = async (calls: Array<{ to: string; data: string }>): Promise<RpcResult[]> => {
        const body = calls.map((c, i) => ({ jsonrpc: "2.0", id: i, method: "eth_call", params: [{ to: c.to, data: c.data }, "latest"] }));
        let lastErr: unknown;
        for (const url of list) {
          try {
            const res = await client.postJson<RpcResult[]>(url, body);
            const arr = (Array.isArray(res) ? res : [res]).sort((a, b) => a.id - b.id);
            if (arr.length === calls.length && arr.every((r) => r.result && !r.error)) return arr;
            lastErr = new Error(arr.find((r) => r.error)?.error?.message ?? "short batch");
          } catch (err) {
            lastErr = err;
          }
        }
        throw lastErr ?? new Error("no RPC");
      };

      const from = ctx.from.getTime();
      const to = ctx.to.getTime();
      const CHUNK = 50;

      // ── 1. the vaults: exact, self-timestamped ───────────────────────────
      // Read in chunks until an epoch with startTime 0 (unwritten).
      const vaultClock = new Map<number, { start: number; end: number }>(); // vault epoch → times (hbfUSD's)
      for (const v of VAULTS) {
        const uid = makeMarketUid(LENDER_KEY, ETH, v.address);
        let epoch = 1;
        let stop = false;
        while (!stop) {
          const idx = Array.from({ length: CHUNK }, (_, i) => epoch + i);
          const out = await batch(idx.map((e) => ({ to: v.address, data: SEL.epochRatios + pad(e) })));
          for (let i = 0; i < idx.length; i += 1) {
            const r = out[i]?.result;
            const endRatio = word(r, 1);
            const startTime = Number(word(r, 2) ?? 0n);
            const endTime = Number(word(r, 3) ?? 0n);
            if (!endRatio || startTime === 0) {
              stop = true;
              break;
            }
            if (v.symbol === "hbfUSD") vaultClock.set(idx[i], { start: startTime, end: endTime });
            const tsMs = (endTime || startTime) * 1000;
            if (tsMs < from || tsMs > to) continue;
            yield {
              marketUid: uid,
              lenderKey: LENDER_KEY,
              chainId: ETH,
              dataTs: bucketStart(tsMs, "1d").toISOString(),
              observedTs: new Date(tsMs).toISOString(),
              source: "bitfi-onchain",
              supplyIndex: dec8(endRatio),
              indexKind: "assets_per_share",
            };
          }
          epoch += CHUNK;
          if (epoch > 5000) stop = true; // a runaway ledger is a bug, not data
        }
        ctx.onProgress?.(1, 3, `${LENDER_KEY} ${v.symbol} ${epoch} epochs`);
      }

      // ── 2. bfBTC: dated by the vaults' clock through the pinned offset ──
      const [cur] = await batch([{ to: BFBTC, data: SEL.currentEpoch }]);
      const currentEpoch = Number(word(cur.result, 0) ?? 0n);
      // Re-check the anchor: the pinned vault epoch must still start when it
      // did when the offset was measured. A re-indexed ledger would move it.
      const anchorVault = vaultClock.get(ANCHOR.vaultEpoch);
      if (!anchorVault || Math.abs(anchorVault.start - ANCHOR.vaultStartTime) > 3600) {
        console.warn(`[${LENDER_KEY}] vault epoch ${ANCHOR.vaultEpoch} no longer starts at ${ANCHOR.vaultStartTime} — the clock was re-indexed; bfBTC skipped, re-pin ANCHOR`);
        return;
      }
      const targets = [{ chainId: ETH, address: BFBTC }, ...BFBTC_MIRRORS].filter(
        (t) => !ctx.chainIds || ctx.chainIds.includes(t.chainId),
      );
      // bfBTC's ledger starts at epoch 0 (`ratio(0)` is written); the vaults' at 1.
      for (let e = 0; e < currentEpoch; e += CHUNK) {
        const idx = Array.from({ length: Math.min(CHUNK, currentEpoch - e) }, (_, i) => e + i);
        const out = await batch(idx.map((k) => ({ to: BFBTC, data: SEL.ratio + pad(k) })));
        for (let i = 0; i < idx.length; i += 1) {
          const ratio = word(out[i]?.result, 0);
          if (!ratio || ratio === 0n) continue;
          // bfBTC epoch `e` is WRITTEN at the START of vault epoch `e − 135`
          // (416 landed 48 s before 281 began), i.e. it is the close of the
          // previous ~89,580 s — so it is dated by that vault epoch's start,
          // never its end (which would label every close a day late).
          const clock = vaultClock.get(idx[i] - EPOCH_OFFSET);
          if (!clock) continue; // before the vaults existed, or the vault write lags: undatable this run
          const tsMs = clock.start * 1000;
          if (tsMs < from || tsMs > to) continue;
          // BTC per bfBTC = 1e8 / ratio, at 8 decimals.
          const pps = dec8((RATIO_SCALE * RATIO_SCALE) / ratio);
          for (const t of targets) {
            yield {
              marketUid: makeMarketUid(LENDER_KEY, t.chainId, t.address),
              lenderKey: LENDER_KEY,
              chainId: t.chainId,
              dataTs: bucketStart(tsMs, "1d").toISOString(),
              observedTs: new Date(tsMs).toISOString(),
              source: "bitfi-onchain",
              supplyIndex: pps,
              indexKind: "assets_per_share",
            };
          }
        }
      }
      ctx.onProgress?.(3, 3, `${LENDER_KEY} bfBTC ${currentEpoch} epochs × ${targets.length} chains`);
    },
  };
}
