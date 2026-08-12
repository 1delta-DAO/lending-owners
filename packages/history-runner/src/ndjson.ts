import { appendFile, mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { type HistoryPoint, pointKey } from "@lending-owners/core";

/**
 * NDJSON sink for history output.
 *
 * Layout: `<out>/<LENDER_KEY>/<chainId>/<yyyy-mm>.ndjson`, one line per
 * `(marketUid, dataTs)`. Sharding by month keeps any single file re-writable
 * and makes a partial re-run cheap to reason about; sharding by chain matches
 * how the ingest side batches POSTs.
 *
 * Appends are **deduplicated against what is already on disk**. This is what
 * makes the daily capture job (plan §0.9 A0) safe to run twice in a day, or to
 * re-run after a failure: Compound's 30-day window re-serves 29 days we
 * already have, and without dedup every run would multiply them.
 */
export class NdjsonSink {
  private readonly seen = new Map<string, Set<string>>();
  private readonly counts = new Map<string, number>();
  private written = 0;
  private skipped = 0;

  /**
   * @param family the lender family, e.g. `COMPOUND_V3` — NOT the per-market
   *   lender key. Morpho, LlamaLend and Compound all key markets individually
   *   (`COMPOUND_V3_USDC`, `MORPHO_BLUE_<id>`), so deriving the directory from
   *   a row would shard one family across thousands of directories, or — if
   *   split on `_` — file Compound V3 under `COMPOUND`.
   */
  constructor(
    private readonly outDir: string,
    private readonly family: string,
  ) {}

  /** Writes points, dropping any whose key is already present in the target
   *  file (on disk or written earlier in this run). Returns rows written. */
  async write(points: HistoryPoint[]): Promise<number> {
    if (points.length === 0) return 0;
    const byFile = new Map<string, HistoryPoint[]>();
    for (const p of points) {
      const file = this.fileFor(p);
      let bucket = byFile.get(file);
      if (!bucket) byFile.set(file, (bucket = []));
      bucket.push(p);
    }

    let written = 0;
    for (const [file, bucket] of byFile) {
      const seen = await this.loadSeen(file);
      const fresh: HistoryPoint[] = [];
      for (const p of bucket) {
        const key = pointKey(p);
        if (seen.has(key)) {
          this.skipped += 1;
          continue;
        }
        seen.add(key);
        fresh.push(p);
      }
      if (fresh.length === 0) continue;
      // Sorting within the append keeps a file readable and diffable; the file
      // as a whole is only sorted if it was written in one pass.
      fresh.sort((a, b) => pointKey(a).localeCompare(pointKey(b)));
      const body = `${fresh.map((p) => JSON.stringify(p)).join("\n")}\n`;
      await mkdir(path.dirname(file), { recursive: true });
      await appendFile(file, body, "utf8");
      this.counts.set(file, (this.counts.get(file) ?? 0) + fresh.length);
      written += fresh.length;
    }
    this.written += written;
    return written;
  }

  get stats(): { written: number; skipped: number; files: number } {
    return { written: this.written, skipped: this.skipped, files: this.counts.size };
  }

  /** Per-run record of what landed where, so a resumed run can skip shards and
   *  so the ingest side knows exactly which files are new. */
  async writeManifest(meta: Record<string, unknown>): Promise<string> {
    const file = path.join(this.outDir, "manifest.json");
    let prior: unknown[] = [];
    try {
      prior = JSON.parse(await readFile(file, "utf8")) as unknown[];
      if (!Array.isArray(prior)) prior = [];
    } catch {
      // First run: no manifest yet.
    }
    const entry = {
      ...meta,
      files: Object.fromEntries([...this.counts].map(([f, n]) => [path.relative(this.outDir, f), n])),
      written: this.written,
      skippedAsDuplicate: this.skipped,
    };
    prior.push(entry);
    await mkdir(this.outDir, { recursive: true });
    await writeFile(file, `${JSON.stringify(prior, null, 2)}\n`, "utf8");
    return file;
  }

  private fileFor(p: HistoryPoint): string {
    const month = p.dataTs.slice(0, 7); // yyyy-mm
    return path.join(this.outDir, this.family, String(p.chainId), `${month}.ndjson`);
  }

  private async loadSeen(file: string): Promise<Set<string>> {
    const cached = this.seen.get(file);
    if (cached) return cached;
    const set = new Set<string>();
    try {
      const existing = await readFile(file, "utf8");
      for (const line of existing.split("\n")) {
        if (!line) continue;
        try {
          set.add(pointKey(JSON.parse(line) as HistoryPoint));
        } catch {
          // A truncated final line from an interrupted append. Ignoring it
          // means we may re-append that one row — harmless, and far better
          // than refusing to write the shard at all.
        }
      }
    } catch {
      // No file yet.
    }
    this.seen.set(file, set);
    return set;
  }
}
