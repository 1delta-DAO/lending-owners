import type { ChainId, MarketUid, UidResolver } from "@lending-owners/core";

/**
 * The authoritative list of `market_uid`s, fetched from the live book.
 *
 * Why not construct uids locally: each family keys its leaf differently
 * (vToken, mToken, vault, silo, underlying), the rule lives in `yield-tracer`'s
 * `computeMarketUid`, and both history tables have an FK to `markets` — so a
 * locally-derived uid that is even slightly off is a rejected insert, not a
 * recoverable mistake. Looking the uid up in the book we are going to write
 * into makes the join true by construction.
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
  /**
   * (chainId, leaf) → uid, only when exactly one market in the whole book uses
   * that leaf. Prefer {@link forFamily}: a leaf is very often shared.
   */
  resolve: UidResolver;
  /** A resolver scoped to one lender family — what fetchers should use. */
  forFamily: (familyPrefix: string) => UidResolver;
  /** Total distinct uids indexed. */
  size: number;
}

const key = (chainId: string, leaf: string): string => `${chainId}:${leaf.toLowerCase()}`;
const lenderOf = (uid: string): string => uid.slice(0, uid.indexOf(":"));

export async function loadMarketRegistry(signal?: AbortSignal): Promise<MarketRegistry> {
  const res = await fetch(META_URL, { signal });
  if (!res.ok) throw new Error(`market registry HTTP ${res.status} from ${META_URL}`);
  const body = (await res.json()) as MetaResponse;

  /**
   * (chainId, leaf) → EVERY uid using it, not just the first.
   *
   * A leaf is shared far more often than it looks: Aave's leaf IS the
   * underlying token, and that same token is the loan asset of dozens of Morpho
   * markets on the same chain. Measured on the live book, 1,122 (chain, leaf)
   * pairs are shared, covering **71 % of Aave V3's markets**. Keeping only
   * unambiguous leaves silently reduced Aave to 26 of 283 markets — the lookup
   * did not fail loudly, it just resolved almost nothing.
   *
   * So ambiguity is resolved by the CALLER's family instead of being discarded.
   */
  const byLeaf = new Map<string, string[]>();
  let size = 0;

  for (const [chainId, lenders] of Object.entries(body.items ?? {})) {
    for (const markets of Object.values(lenders ?? {})) {
      for (const uid of Object.keys(markets ?? {})) {
        const leaf = uid.slice(uid.lastIndexOf(":") + 1);
        const k = key(chainId, leaf);
        const bucket = byLeaf.get(k);
        if (bucket) {
          if (!bucket.includes(uid)) bucket.push(uid);
        } else byLeaf.set(k, [uid]);
        size += 1;
      }
    }
  }

  const asUid = (u: string | undefined): MarketUid | undefined =>
    u as unknown as MarketUid | undefined;
  // Written as statements, not a ternary: `MarketUid` is a template-literal
  // union over every chain id, and a conditional whose branches are
  // `MarketUid | undefined` overflows TypeScript's union-size limit.
  function pick(candidates: string[] | undefined): MarketUid | undefined {
    if (!candidates || candidates.length !== 1) return undefined;
    return asUid(candidates[0]);
  }

  return {
    size,
    resolve: (chainId: ChainId, leafAddress: string) =>
      pick(byLeaf.get(key(String(chainId), leafAddress))),
    forFamily:
      (familyPrefix: string): UidResolver =>
      // Explicit return annotation: without it TypeScript infers the union of
      // every `MarketUid` branch and hits its union-size limit.
      (chainId: ChainId, leafAddress: string): MarketUid | undefined => {
        const all = byLeaf.get(key(String(chainId), leafAddress));
        if (!all) return undefined;
        // Exact family first, then prefix — `AAVE_V3` must not match `AAVE_V2`,
        // but `MORPHO_BLUE` must match `MORPHO_BLUE_<marketId>`.
        const exact = all.filter((u) => lenderOf(u) === familyPrefix);
        if (exact.length === 1) return asUid(exact[0]);
        if (exact.length > 1) return undefined;
        const prefixed = all.filter((u) => lenderOf(u).startsWith(familyPrefix));
        if (prefixed.length !== 1) return undefined;
        return asUid(prefixed[0]);
      },
  };
}
