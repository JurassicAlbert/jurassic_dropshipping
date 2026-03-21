"use client";

import { useSyncExternalStore } from "react";

const emptySubscribe = () => () => {};

/**
 * True on the client, false during SSR. Avoids hydration mismatch for Recharts
 * (server and initial client paint both match; after hydration charts render).
 */
export function useClientMounted(): boolean {
  return useSyncExternalStore(emptySubscribe, () => true, () => false);
}
