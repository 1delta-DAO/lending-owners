import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

/**
 * Aave's history API has no listing endpoint — every query needs an explicit
 * (market, chainId, underlyingToken) triple. The repo already keeps that list
 * fresh: `data/AAVE_V3.json` is rewritten daily by the ownership runner, so
 * reading it costs nothing and cannot drift from what we actually track.
 */
export interface AaveReserve {
  chainId: number;
  market: string;
  underlyingToken: string;
  symbol: string;
}

/** Pool addresses per chain, keyed by the `market` argument the API expects. */
const POOL_BY_CHAIN: Record<string, string> = {
  "1": "0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2",
  "10": "0x794a61358D6845594F94dc1DB02A252b5b4814aD",
  "137": "0x794a61358D6845594F94dc1DB02A252b5b4814aD",
  "8453": "0xA238Dd80C259a72e81d7e4664a9801593F98d1c5",
  "42161": "0x794a61358D6845594F94dc1DB02A252b5b4814aD",
  "43114": "0x794a61358D6845594F94dc1DB02A252b5b4814aD",
  "59144": "0xc47b8C00b0f69a36fa8a0Ea8c08d0F1E064B25E5",
  "100": "0xb50201558B00496A145fE76f7424749556E326D8",
  "56": "0x6807dc923806fE8Fd134338EABCA509979a7e0cB",
  "534352": "0x11fCfe756c05AD438e312a7fd934381537D3cFfe",
  "1088": "0x90df02551bB792286e8D4f13E0e357b4Bf1D6a57",
  "146": "0x5362dBb1e601abF3a4c14c22ffEdA64042E5eAA3",
  "324": "0x78e30497a3c7527d953c6B1E3541b021A98Ac43c",
};

interface OwnershipFile {
  markets: Record<string, { chainId: string; underlying: string; name?: string }>;
}

/** Reads the committed ownership snapshot; returns [] if it is absent so a
 *  fresh clone fails with a clear "0 reserves" rather than a stack trace. */
export function loadAaveV3Reserves(dataDir?: string): AaveReserve[] {
  const root =
    dataDir ??
    path.resolve(path.dirname(fileURLToPath(import.meta.url)), "../../..", "data");
  let parsed: OwnershipFile;
  try {
    parsed = JSON.parse(readFileSync(path.join(root, "AAVE_V3.json"), "utf8")) as OwnershipFile;
  } catch {
    console.warn("[AAVE_V3] data/AAVE_V3.json not readable — run `pnpm fetch:aave-v3` first");
    return [];
  }

  const out: AaveReserve[] = [];
  const seen = new Set<string>();
  for (const m of Object.values(parsed.markets ?? {})) {
    const chainId = String(m.chainId);
    const market = POOL_BY_CHAIN[chainId];
    if (!market) continue;
    const key = `${chainId}:${m.underlying.toLowerCase()}`;
    if (seen.has(key)) continue;
    seen.add(key);
    out.push({
      chainId: Number(chainId),
      market,
      underlyingToken: m.underlying,
      symbol: m.name ?? m.underlying,
    });
  }
  return out;
}
