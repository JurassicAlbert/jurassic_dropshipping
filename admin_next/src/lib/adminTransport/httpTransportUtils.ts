import type { AdminError, MockErrorCode, TransportResponse } from "./types";

export function mkFailExternal<T>(
  requestId: string,
  code: MockErrorCode,
  message: string,
): TransportResponse<T> {
  const error: AdminError = { code, message };
  return { requestId, ok: false, error } as TransportResponse<T>;
}

