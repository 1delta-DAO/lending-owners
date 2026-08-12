/**
 * Shared paced HTTP client for the history fetchers.
 *
 * Every source this repo backfills from is a free public API with an
 * undocumented or lightly-documented rate limit, and a backfill is by far the
 * heaviest thing we point at them. Pacing is therefore not an optimization —
 * it is the difference between a run that finishes and one that gets us
 * blocked. Generalized from the client in `fetcher-morpho-blue`, which stays
 * as-is for now.
 */

export const sleep = (ms: number, signal?: AbortSignal): Promise<void> =>
  new Promise((resolve, reject) => {
    const timer = setTimeout(resolve, ms);
    signal?.addEventListener(
      "abort",
      () => {
        clearTimeout(timer);
        reject(new Error("aborted"));
      },
      { once: true },
    );
  });

export interface PacedClientConfig {
  /** Log prefix, e.g. the lender key. */
  label: string;
  /** Max in-flight requests. */
  concurrency?: number;
  /** Minimum gap between request starts, in ms. */
  minIntervalMs?: number;
  /** Attempts on 429/5xx/network error before giving up. */
  maxAttempts?: number;
  signal?: AbortSignal;
}

/** Retried: transient by nature. A 4xx other than 429 is a bug in our request
 *  and retrying it just burns budget against the same wrong URL. */
const RETRYABLE_STATUS = new Set([429, 500, 502, 503, 504, 522, 524]);

export class PacedClient {
  private active = 0;
  private readonly queue: Array<() => void> = [];
  private nextSlotAt = 0;
  private readonly concurrency: number;
  private readonly minIntervalMs: number;
  private readonly maxAttempts: number;

  constructor(private readonly cfg: PacedClientConfig) {
    this.concurrency = cfg.concurrency ?? 6;
    this.minIntervalMs = cfg.minIntervalMs ?? 130;
    this.maxAttempts = cfg.maxAttempts ?? 5;
  }

  async getJson<T>(url: string, init?: RequestInit): Promise<T> {
    return this.run(() => this.execute<T>(url, { ...init, method: "GET" }));
  }

  /**
   * POSTs a GraphQL document and returns `data`. Partial `errors` alongside a
   * present `data` are warned about, not thrown: Morpho returns per-field
   * errors for markets it has not finished indexing while still serving every
   * other market in the batch, and failing the batch would lose all of them.
   */
  async graphql<T>(
    url: string,
    query: string,
    variables?: Record<string, unknown>,
  ): Promise<T> {
    return this.run(async () => {
      const json = await this.execute<{
        data?: T;
        errors?: Array<{ message: string }>;
      }>(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(variables ? { query, variables } : { query }),
      });
      if (!json?.data) {
        const msg = json?.errors?.map((e) => e.message).join("; ") ?? "no data";
        throw new Error(`[${this.cfg.label}] GraphQL: ${msg}`);
      }
      if (json.errors?.length) {
        const head = json.errors.slice(0, 3).map((e) => e.message).join("; ");
        const more = json.errors.length > 3 ? ` (+${json.errors.length - 3} more)` : "";
        console.warn(`[${this.cfg.label}] GraphQL partial errors: ${head}${more}`);
      }
      return json.data;
    });
  }

  private async run<T>(fn: () => Promise<T>): Promise<T> {
    await this.acquire();
    try {
      await this.pace();
      return await fn();
    } finally {
      this.release();
    }
  }

  private async execute<T>(url: string, init: RequestInit): Promise<T> {
    let lastErr: unknown;
    for (let attempt = 0; attempt < this.maxAttempts; attempt += 1) {
      try {
        const res = await fetch(url, { ...init, signal: this.cfg.signal });
        if (RETRYABLE_STATUS.has(res.status)) {
          const retryAfter = Number(res.headers.get("retry-after"));
          const waitMs = Number.isFinite(retryAfter)
            ? Math.min(retryAfter * 1000, 90_000)
            : Math.min(2000 * 2 ** attempt, 60_000);
          if (attempt + 1 < this.maxAttempts) {
            console.warn(
              `[${this.cfg.label}] HTTP ${res.status}, retrying in ${Math.round(waitMs / 1000)}s — ${url}`,
            );
            await sleep(waitMs, this.cfg.signal);
            continue;
          }
        }
        if (!res.ok) {
          const body = await res.text().catch(() => "");
          throw new Error(`HTTP ${res.status} ${url} ${body.slice(0, 200)}`);
        }
        return (await res.json()) as T;
      } catch (err) {
        lastErr = err;
        if ((err as Error)?.name === "AbortError") throw err;
        if (attempt + 1 >= this.maxAttempts) break;
        await sleep(Math.min(1000 * 2 ** attempt, 30_000), this.cfg.signal);
      }
    }
    throw new Error(`[${this.cfg.label}] ${(lastErr as Error)?.message ?? "request failed"}`);
  }

  private pace(): Promise<void> {
    const now = Date.now();
    const startAt = Math.max(now, this.nextSlotAt);
    this.nextSlotAt = startAt + this.minIntervalMs;
    return startAt > now ? sleep(startAt - now, this.cfg.signal) : Promise.resolve();
  }

  private acquire(): Promise<void> {
    if (this.active < this.concurrency) {
      this.active += 1;
      return Promise.resolve();
    }
    return new Promise((resolve) => {
      this.queue.push(() => {
        this.active += 1;
        resolve();
      });
    });
  }

  private release(): void {
    this.active -= 1;
    this.queue.shift()?.();
  }
}

/** Runs `items` through `worker` with at most `limit` in flight, preserving
 *  input order in the result. Used to fan out per-market history requests. */
export async function mapWithConcurrency<T, R>(
  items: readonly T[],
  limit: number,
  worker: (item: T, index: number) => Promise<R>,
): Promise<R[]> {
  const out = new Array<R>(items.length);
  let next = 0;
  const runners = Array.from({ length: Math.min(limit, items.length) }, async () => {
    for (;;) {
      const i = next++;
      if (i >= items.length) return;
      out[i] = await worker(items[i]!, i);
    }
  });
  await Promise.all(runners);
  return out;
}
