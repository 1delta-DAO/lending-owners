import type { Address, ChainId } from "@lending-owners/core";
import { makeMarketUid } from "@lending-owners/core";

const ADDR = /^0x[0-9a-fA-F]{40}$/;

export const SILO_V2_MARKETS_URL =
  "https://raw.githubusercontent.com/1delta-DAO/lender-metadata/refs/heads/main/data/silo-v2-markets.json";
export const SILO_V3_MARKETS_URL =
  "https://raw.githubusercontent.com/1delta-DAO/lender-metadata/refs/heads/main/data/silo-v3-markets.json";

export interface SiloSideMeta {
  silo: string;
  token: string;
  decimals: number;
  symbol: string;
}

export interface SiloJsonMarket {
  siloConfig: string;
  name: string;
  silo0: SiloSideMeta;
  silo1: SiloSideMeta;
}

type JsonChain = Record<string, SiloJsonMarket[]>;

export interface SiloIndexEntry {
  siloConfig: string;
  protocol: "v2" | "v3";
}

/** chainId (string) -> (vault address lowercased) -> { siloConfig, protocol } */
export type SiloVaultIndex = Partial<Record<ChainId, ReadonlyMap<string, SiloIndexEntry>>>;

/** Merged v2 + v3 rows for disambiguation when subgraph market id is not a bare vault. */
export type SiloMarketRow = SiloJsonMarket & { protocol: "v2" | "v3" };
type RowWithVer = SiloMarketRow;

function normalizeAddr(s: string): string {
  if (!s?.startsWith("0x") || s.length < 3) return s;
  return `0x${s.slice(2).toLowerCase()}`;
}

/** Public API: `SILO_V2_` + 40-hex of siloConfig (uppercase) */
export function siloLenderKeyPrefix(
  version: "v2" | "v3",
  siloConfigFullHex: string,
): string {
  const hex = siloConfigFullHex.toLowerCase().replace(/^0x/i, "");
  if (!/^[0-9a-f]{40}$/.test(hex)) {
    throw new Error(`[SILO] invalid siloConfig address: ${siloConfigFullHex}`);
  }
  return `${version === "v2" ? "SILO_V2" : "SILO_V3"}_${hex.toUpperCase()}`;
}

function parseJsonObject(raw: unknown, label: string): JsonChain {
  if (raw === null || typeof raw !== "object" || Array.isArray(raw)) {
    throw new Error(`[SILO] ${label}: expected object keyed by chainId`);
  }
  return raw as JsonChain;
}

function pushIndexFromChainList(
  index: Map<ChainId, Map<string, SiloIndexEntry>>,
  chainKey: string,
  markets: SiloJsonMarket[] | undefined,
  protocol: "v2" | "v3",
) {
  if (!markets || markets.length === 0) return;
  const chainId = chainKey as ChainId;
  let m = index.get(chainId);
  if (!m) {
    m = new Map();
    index.set(chainId, m);
  }
  for (const row of markets) {
    for (const side of [row.silo0, row.silo1] as const) {
      const v = normalizeAddr(side.silo);
      const prev = m.get(v);
      if (prev && (prev.siloConfig !== row.siloConfig || prev.protocol !== protocol)) {
        // Same vault in two different configs should not happen; last wins.
      }
      m.set(v, { siloConfig: row.siloConfig, protocol });
    }
  }
}

function mergeRows(
  v2: JsonChain,
  v3: JsonChain,
): ReadonlyMap<ChainId, readonly RowWithVer[]> {
  const out = new Map<ChainId, RowWithVer[]>();
  for (const [c, list] of Object.entries(v2)) {
    if (!list?.length) continue;
    const a = (out.get(c as ChainId) ?? ([] as RowWithVer[])) as RowWithVer[];
    for (const m of list) a.push({ ...m, protocol: "v2" } as RowWithVer);
    out.set(c as ChainId, a);
  }
  for (const [c, list] of Object.entries(v3)) {
    if (!list?.length) continue;
    const a = (out.get(c as ChainId) ?? ([] as RowWithVer[])) as RowWithVer[];
    for (const m of list) a.push({ ...m, protocol: "v3" } as RowWithVer);
    out.set(c as ChainId, a);
  }
  return out;
}

export function buildSiloIndexFromData(v2: unknown, v3: unknown): {
  byVault: SiloVaultIndex;
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>;
} {
  const a = parseJsonObject(v2, "silo-v2-markets");
  const b = parseJsonObject(v3, "silo-v3-markets");
  const inner = new Map<ChainId, Map<string, SiloIndexEntry>>();
  for (const [c, list] of Object.entries(a)) pushIndexFromChainList(inner, c, list, "v2");
  for (const [c, list] of Object.entries(b)) pushIndexFromChainList(inner, c, list, "v3");
  const byVault: SiloVaultIndex = {};
  for (const [c, m] of inner) {
    byVault[c] = m;
  }
  return { byVault, rowsByChain: mergeRows(a, b) };
}

export async function loadSiloLenderMetadata(
  signal?: AbortSignal,
): Promise<{ byVault: SiloVaultIndex; rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]> }> {
  const [r2, r3] = await Promise.all([
    fetch(SILO_V2_MARKETS_URL, { signal }),
    fetch(SILO_V3_MARKETS_URL, { signal }),
  ]);
  if (!r2.ok) {
    throw new Error(`[SILO] silo-v2-markets.json HTTP ${r2.status}`);
  }
  if (!r3.ok) {
    throw new Error(`[SILO] silo-v3-markets.json HTTP ${r3.status}`);
  }
  const [j2, j3] = await Promise.all([r2.json() as Promise<unknown>, r3.json() as Promise<unknown>]);
  return buildSiloIndexFromData(j2, j3);
}

export interface SubgraphLikeMarketV3 {
  id: string;
  inputToken: { id: string };
  silo?: { id: string } | null;
}

/**
 * All 40-hex `0x…` addresses in a subgraph `market.id`, regardless of separators
 * (hyphen, ` - `, concatenation, etc.), deduplicated, lowercased.
 */
export function idSegmentsToAddresses(id: string): string[] {
  const seen = new Set<string>();
  const out: string[] = [];
  for (const m of id.matchAll(/0x[0-9a-fA-F]{40}/g)) {
    const a = normalizeAddr(m[0]!);
    if (!seen.has(a)) {
      seen.add(a);
      out.push(a);
    }
  }
  return out;
}

/**
 * Resolves a vault from hyphen-composite ids: try each 0x segment against the
 * vault index; disambiguate with input token on metadata if multiple match.
 */
function tryResolveFromIdSegments(
  idTrim: string,
  tLc: string,
  want: "v2" | "v3",
  map: ReadonlyMap<string, SiloIndexEntry>,
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
  chainId: ChainId,
): { vault: string; entry: SiloIndexEntry } | null {
  const segs = idSegmentsToAddresses(idTrim);
  if (segs.length === 0) return null;
  const cands: { v: string; e: SiloIndexEntry }[] = [];
  for (const s of segs) {
    const e = map.get(s);
    if (e && e.protocol === want) cands.push({ v: s, e });
  }
  if (cands.length === 0) return null;
  if (cands.length === 1) return { vault: cands[0]!.v, entry: cands[0]!.e };
  const rows = rowsByChain.get(chainId) ?? [];
  for (const { v, e } of cands) {
    for (const row of rows) {
      if (row.protocol !== want) continue;
      for (const side of [row.silo0, row.silo1] as const) {
        if (normalizeAddr(side.silo) === v && side.token.toLowerCase() === tLc) {
          return { vault: v, entry: e };
        }
      }
    }
  }
  return null;
}

/** A subgraph id may use `siloConfig-token-token` instead of `vault-token-token` — first segment = siloConfig. */
function tryResolveSiloConfigSegment(
  siloConfigCandidate: string,
  tLc: string,
  want: "v2" | "v3",
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
  chainId: ChainId,
  map: ReadonlyMap<string, SiloIndexEntry>,
): { vault: string; entry: SiloIndexEntry } | null {
  const c = siloConfigCandidate.toLowerCase();
  for (const row of rowsByChain.get(chainId) ?? []) {
    if (row.protocol !== want) continue;
    if (row.siloConfig.toLowerCase() !== c) continue;
    for (const side of [row.silo0, row.silo1] as const) {
      if (side.token.toLowerCase() === tLc) {
        const vault = normalizeAddr(side.silo);
        return {
          vault,
          entry: (map.get(vault) ?? { siloConfig: row.siloConfig, protocol: want }) as SiloIndexEntry,
        };
      }
    }
  }
  return null;
}

function tryUniqueInputTokenInProtocol(
  tLc: string,
  want: "v2" | "v3",
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
  chainId: ChainId,
  map: ReadonlyMap<string, SiloIndexEntry>,
): { vault: string; entry: SiloIndexEntry } | null {
  const byToken: { row: RowWithVer; side: SiloSideMeta }[] = [];
  for (const row of rowsByChain.get(chainId) ?? []) {
    if (row.protocol !== want) continue;
    for (const side of [row.silo0, row.silo1] as const) {
      if (side.token.toLowerCase() === tLc) byToken.push({ row, side });
    }
  }
  if (byToken.length !== 1) return null;
  const g = byToken[0]!;
  const vault = normalizeAddr(g.side.silo);
  return {
    vault,
    entry: (map.get(vault) ?? { siloConfig: g.row.siloConfig, protocol: want }) as SiloIndexEntry,
  };
}

function entryForVault(
  vault: string,
  want: "v2" | "v3",
  map: ReadonlyMap<string, SiloIndexEntry>,
  row: RowWithVer,
): SiloIndexEntry {
  return (map.get(vault) ?? { siloConfig: row.siloConfig, protocol: want }) as SiloIndexEntry;
}

/**
 * Join subgraph market to metadata by inputToken + all address segments in `id`
 * (hyphen or space-separated). Picks the unique (row, side) where `silo0|1.silo`
 * or `siloConfig` appears in `id` and that side’s token is `inputToken`.
 */
function tryMatchByTokenAndIdSegments(
  idTrim: string,
  tLc: string,
  want: "v2" | "v3",
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
  chainId: ChainId,
  map: ReadonlyMap<string, SiloIndexEntry>,
): { vault: string; entry: SiloIndexEntry } | null {
  const segs = new Set(idSegmentsToAddresses(idTrim));
  if (segs.size === 0) return null;
  type T = { row: RowWithVer; vault: string };
  const cands: T[] = [];
  for (const row of rowsByChain.get(chainId) ?? []) {
    if (row.protocol !== want) continue;
    for (const side of [row.silo0, row.silo1] as const) {
      if (side.token.toLowerCase() !== tLc) continue;
      const vault = normalizeAddr(side.silo);
      const sc = normalizeAddr(row.siloConfig);
      if (segs.has(vault) || segs.has(sc)) {
        cands.push({ row, vault });
      }
    }
  }
  if (cands.length === 0) return null;
  if (cands.length === 1) {
    const g = cands[0]!;
    return { vault: g.vault, entry: entryForVault(g.vault, want, map, g.row) };
  }
  const segsA = idSegmentsToAddresses(idTrim);
  if (segsA.length > 0) {
    const first = segsA[0]!;
    const a = cands.filter((c) => c.vault === first);
    if (a.length === 1) {
      const g = a[0]!;
      return { vault: g.vault, entry: entryForVault(g.vault, want, map, g.row) };
    }
  }
  return null;
}

/**
 * Match by `inputToken` and presence of the **silo vault** in `id` (full 0x+40
 * substring). Avoids the common-asset false positives from only checking the token
 * in `id` (e.g. WETH appears in most Arbitrum markets).
 * Second pass: `siloConfig` in `id` and token on a matching side.
 */
function tryMatchByTokenAndIdInclusion(
  idTrim: string,
  tLc: string,
  want: "v2" | "v3",
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
  chainId: ChainId,
  map: ReadonlyMap<string, SiloIndexEntry>,
): { vault: string; entry: SiloIndexEntry } | null {
  const idL = idTrim.toLowerCase();
  const segsA = idSegmentsToAddresses(idTrim);
  type T = { row: RowWithVer; vault: string };
  const byVault: T[] = [];
  for (const row of rowsByChain.get(chainId) ?? []) {
    if (row.protocol !== want) continue;
    for (const side of [row.silo0, row.silo1] as const) {
      if (side.token.toLowerCase() !== tLc) continue;
      const vault = normalizeAddr(side.silo);
      if (idL.includes(vault)) byVault.push({ row, vault });
    }
  }
  if (byVault.length === 1) {
    const g = byVault[0]!;
    return { vault: g.vault, entry: entryForVault(g.vault, want, map, g.row) };
  }
  if (byVault.length > 1 && segsA.length > 0) {
    const f = segsA[0]!;
    const hit = byVault.filter((c) => c.vault === f);
    if (hit.length === 1) {
      const g = hit[0]!;
      return { vault: g.vault, entry: entryForVault(g.vault, want, map, g.row) };
    }
  }
  if (byVault.length > 1) return null;

  for (const row of rowsByChain.get(chainId) ?? []) {
    if (row.protocol !== want) continue;
    const sc = normalizeAddr(row.siloConfig);
    if (!idL.includes(sc)) continue;
    for (const side of [row.silo0, row.silo1] as const) {
      if (side.token.toLowerCase() !== tLc) continue;
      const vault = normalizeAddr(side.silo);
      return { vault, entry: entryForVault(vault, want, map, row) };
    }
  }
  return null;
}

/** Pure helper for unit tests. */
export function makeSiloApiMarketUid(
  version: "v2" | "v3",
  siloConfig: string,
  chainId: ChainId,
  siloVault: string,
) {
  const prefix = siloLenderKeyPrefix(version, siloConfig);
  return makeMarketUid(prefix, chainId, siloVault as Address);
}

/**
 * Resolve { vault, index entry } for a v2 or v3 subgraph market row.
 * V2: `market.id` is the silo (vault) contract. Lookup byVault.
 * V3: try direct lookup; if `market.id` is composite, match metadata rows.
 */
export function resolveSiloMarket(
  chainId: ChainId,
  market: SubgraphLikeMarketV3,
  label: "V2" | "V3",
  byVault: SiloVaultIndex,
  rowsByChain: ReadonlyMap<ChainId, readonly RowWithVer[]>,
): { vault: string; entry: SiloIndexEntry } | null {
  const tLc = market.inputToken.id.toLowerCase();
  const map = byVault[chainId];
  if (!map || map.size === 0) return null;

  const v2Mode = label === "V2";

  const idTrim = market.id.trim();
  if (ADDR.test(idTrim)) {
    const vault = normalizeAddr(idTrim);
    const e = map.get(vault);
    if (e && (v2Mode ? e.protocol === "v2" : e.protocol === "v3")) {
      return { vault, entry: e };
    }
  }

  const want: "v2" | "v3" = v2Mode ? "v2" : "v3";
  const fromSegs = tryResolveFromIdSegments(idTrim, tLc, want, map, rowsByChain, chainId);
  if (fromSegs) return fromSegs;

  for (const seg of idSegmentsToAddresses(idTrim)) {
    const r = tryResolveSiloConfigSegment(seg, tLc, want, rowsByChain, chainId, map);
    if (r) return r;
  }

  const fromUnique = tryUniqueInputTokenInProtocol(tLc, want, rowsByChain, chainId, map);
  if (fromUnique) return fromUnique;

  const fromTokenSegs = tryMatchByTokenAndIdSegments(
    idTrim,
    tLc,
    want,
    rowsByChain,
    chainId,
    map,
  );
  if (fromTokenSegs) return fromTokenSegs;

  const fromInclusion = tryMatchByTokenAndIdInclusion(
    idTrim,
    tLc,
    want,
    rowsByChain,
    chainId,
    map,
  );
  if (fromInclusion) return fromInclusion;

  if (v2Mode) {
    return null;
  }

  // V3: composite " - " or disambiguation
  const parts = idTrim.split(/ - /).map((p) => p.trim()).filter(Boolean);
  if (parts.length === 2) {
    const left = parts[0]!.toLowerCase();
    for (const row of rowsByChain.get(chainId) ?? []) {
      if (row.protocol !== "v3") continue;
      for (const side of [row.silo0, row.silo1] as const) {
        if (side.silo.toLowerCase() === left && side.token.toLowerCase() === tLc) {
          const vault = normalizeAddr(side.silo);
          return {
            vault,
            entry: (map.get(vault) ?? { siloConfig: row.siloConfig, protocol: "v3" }) as SiloIndexEntry,
          };
        }
      }
    }
  }

  const parent = market.silo?.id;
  if (parent) {
    const p = parent.toLowerCase();
    const rows = rowsByChain.get(chainId) ?? [];
    const cands: RowWithVer[] = [];
    for (const row of rows) {
      if (row.protocol !== "v3") continue;
      if (row.silo0.token.toLowerCase() === tLc || row.silo1.token.toLowerCase() === tLc) cands.push(row);
    }
    for (const row of cands) {
      for (const side of [row.silo0, row.silo1] as const) {
        if (side.token.toLowerCase() !== tLc) continue;
        if (p === side.silo.toLowerCase() || p === market.id.split(/ - /)[0]?.trim().toLowerCase()) {
          const vault = normalizeAddr(side.silo);
          return { vault, entry: { siloConfig: row.siloConfig, protocol: "v3" } };
        }
      }
    }
  }

  return null;
}
