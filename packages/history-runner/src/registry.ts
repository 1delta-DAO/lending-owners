import type { ChainId, MarketUid, UidResolver } from "@lending-owners/core";

/**
 * The authoritative list of `market_uid`s, fetched from the live book.
 *
 * Why not construct uids locally: each family keys its leaf differently
 * (vToken, mToken, vault, silo, underlying), the rule lives in `yield-tracer`'s
 * `computeMarketUid`, and both history tables have an FK to `markets` — so a
 * locally-derived uid that is even slightly off is a rejected insert, not a
 * recoverable mistake. Looking the uid up in the book we are going to write
 * into makes the join true by construction, and has the useful side effect of
 * refusing to collect history for markets that do not exist.
 *
 * This is a stopgap for A1, not a replacement: once `computeMarketUid` is
 * shared, a fetcher can derive uids offline and this becomes a cross-check.
 */
const META_URL =
  process.env.LENDING_META_URL ?? "https://yields-r0.1delta.io/meta/lending/complete";

interface MetaMarket {
  underlying?: string;
  name?: string;
}
type MetaResponse = {
  items: Record<string, Record<string, Record<string, MetaMarket>>>;
};

export interface MarketRegistry {
  /** (chainId, leaf) → uid, where leaf is whatever the uid's third segment is. */
  resolve: UidResolver;
  /** (chainId, family, leaf) → uid, when a leaf is ambiguous across families. */
  resolveIn: (chainId: ChainId, family: string, leafAddress: string) => MarketUid | undefined;
  /** All uids for a family prefix, for coverage reporting. */
  countFor: (familyPrefix: string) => number;
  size: number;
}

const key = (chainId: string, leaf: string): string => `${chainId}:${leaf.toLowerCase()}`;

export async function loadMarketRegistry(signal?: AbortSignal): Promise<MarketRegistry> {
  const res = await fetch(META_URL, { signal });
  if (!res.ok) throw new Error(`market registry HTTP ${res.status} from ${META_URL}`);
  const body = (await res.json()) as MetaResponse;

  // Stored as plain strings: `MarketUid` is a template-literal union over
  // every chain id, and combining two of them (`a ?? b`) overflows TS's union
  // limit. The cast happens once, at the boundary.
  const byLeaf = new Map<string, string>();
  const byFamilyLeaf = new Map<string, string>();
  // A leaf can repeat across families (two protocols listing the same token as
  // the uid leaf). Those entries are dropped from the family-agnostic map so a
  // caller gets `undefined` and reports a miss, rather than a confident wrong
  // uid — the failure mode that would put Venus history on a Moonwell market.
  const ambiguous = new Set<string>();
  const familyCounts = new Map<string, number>();

  for (const [chainId, lenders] of Object.entries(body.items ?? {})) {
    for (const [lenderKey, markets] of Object.entries(lenders ?? {})) {
      const family = lenderKey.split("_")[0]!;
      for (const uid of Object.keys(markets ?? {})) {
        const leaf = uid.slice(uid.lastIndexOf(":") + 1);
        const k = key(chainId, leaf);
        if (byLeaf.has(k) && byLeaf.get(k) !== uid) ambiguous.add(k);
        else byLeaf.set(k, uid);
        byFamilyLeaf.set(`${family}|${k}`, uid);
        familyCounts.set(lenderKey, (familyCounts.get(lenderKey) ?? 0) + 1);
      }
    }
  }
  for (const k of ambiguous) byLeaf.delete(k);

  return {
    size: byLeaf.size + ambiguous.size,
    resolve: (chainId: ChainId, leafAddress: string) =>
      byLeaf.get(key(String(chainId), leafAddress)) as MarketUid | undefined,
    resolveIn: (chainId: ChainId, family: string, leafAddress: string) => {
      const k = key(String(chainId), leafAddress);
      const hit = byFamilyLeaf.get(`${family}|${k}`) ?? byLeaf.get(k);
      return hit as MarketUid | undefined;
    },
    countFor: (familyPrefix: string) => {
      let n = 0;
      for (const [lenderKey, count] of familyCounts) {
        if (lenderKey.startsWith(familyPrefix)) n += count;
      }
      return n;
    },
  };
}
