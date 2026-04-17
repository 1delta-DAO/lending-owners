import type { ChainFreshness, ChainId } from "./types.js";

/** Average seconds between blocks, used to convert block lag to minutes. */
const BLOCK_SECONDS: Partial<Record<string, number>> = {
  "1": 12, // Ethereum
  "10": 2, // Optimism
  "56": 3, // BNB Smart Chain
  "100": 5, // Gnosis
  "137": 2, // Polygon
  "1284": 12, // Moonbeam
  "8453": 2, // Base
  "42161": 0.25, // Arbitrum One
  "43114": 2, // Avalanche
  "534352": 3, // Scroll
  "34443": 2, // Mode
  "252": 2, // Fraxtal
  "57073": 2, // Ink
  "21000000": 2, // Corn
  "743111": 2, // Hemi Network
  "146": 1, // Sonic
  "130": 1, // Unichain
};

const STALE_MINUTES_WARN = 30;

/** Cached list of RPC URLs per chain, fetched once from the rpc-tester repo. */
const rpcListCache = new Map<string, string[]>();

async function fetchRpcList(
  chainId: ChainId,
  signal?: AbortSignal,
): Promise<string[]> {
  const key = String(chainId);
  if (rpcListCache.has(key)) return rpcListCache.get(key)!;
  try {
    const url = `https://raw.githubusercontent.com/1delta-DAO/rpc-tester/main/rpcs/${key}.json`;
    const res = await fetch(url, { signal });
    if (!res.ok) return [];
    const data = (await res.json()) as { rpcs: Array<{ url: string }> };
    const urls = data.rpcs.map((r) => r.url).filter(Boolean);
    rpcListCache.set(key, urls);
    return urls;
  } catch {
    return [];
  }
}

async function querySubgraphBlock(
  subgraphUrl: string,
  signal?: AbortSignal,
): Promise<number> {
  const res = await fetch(subgraphUrl, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ query: "{ _meta { block { number } } }" }),
    signal,
  });
  if (!res.ok) throw new Error(`subgraph _meta HTTP ${res.status}`);
  const json = (await res.json()) as {
    data?: { _meta: { block: { number: number } } };
  };
  const block = json.data?._meta?.block?.number;
  if (block == null) throw new Error("subgraph _meta returned no block number");
  return block;
}

async function tryRpcBlock(
  rpcUrl: string,
  signal?: AbortSignal,
): Promise<number> {
  const res = await fetch(rpcUrl, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jsonrpc: "2.0",
      id: 1,
      method: "eth_blockNumber",
      params: [],
    }),
    signal,
  });
  if (!res.ok) throw new Error(`RPC HTTP ${res.status}`);
  const json = (await res.json()) as { result?: string };
  if (!json.result) throw new Error("RPC returned no block result");
  return parseInt(json.result, 16);
}

/** Tries each RPC in the chain's list in order, returning the first success. */
async function queryRpcBlock(
  chainId: ChainId,
  signal?: AbortSignal,
): Promise<number> {
  const rpcs = await fetchRpcList(chainId, signal);
  if (rpcs.length === 0) throw new Error("no RPCs available");
  let lastErr = new Error("no RPCs tried");
  for (const url of rpcs) {
    try {
      return await tryRpcBlock(url, signal);
    } catch (err) {
      lastErr = err as Error;
    }
  }
  throw lastErr;
}

/**
 * Checks how far behind a subgraph is relative to the chain tip.
 * Logs a warning if the lag exceeds STALE_MINUTES_WARN.
 * Returns null on any failure — freshness checks are non-fatal.
 */
export async function checkSubgraphFreshness(
  lenderKey: string,
  subgraphUrl: string,
  chainId: ChainId,
  signal?: AbortSignal,
): Promise<ChainFreshness | null> {
  try {
    const [subgraphBlock, rpcBlock] = await Promise.all([
      querySubgraphBlock(subgraphUrl, signal),
      queryRpcBlock(chainId, signal),
    ]);
    const blocksBehind = Math.max(0, rpcBlock - subgraphBlock);
    const secondsPerBlock = BLOCK_SECONDS[String(chainId)] ?? 12;
    const minutesBehind = Math.round((blocksBehind * secondsPerBlock) / 60);
    if (minutesBehind > STALE_MINUTES_WARN) {
      console.warn(
        `[${lenderKey}] chain ${chainId}: subgraph is ${blocksBehind} blocks (~${minutesBehind} min) behind tip (subgraph=${subgraphBlock} rpc=${rpcBlock})`,
      );
    }
    return { subgraphBlock, rpcBlock, blocksBehind, minutesBehind };
  } catch (err) {
    console.warn(
      `[${lenderKey}] chain ${chainId}: freshness check failed: ${(err as Error).message}`,
    );
    return null;
  }
}
