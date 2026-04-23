// skip xxx placeholder values for api keys
export function isPlaceholderEnvValue(value: string): boolean {
  return value?.trim()?.toLowerCase() === "xxx";
}
