import type { AdminTransport } from "./adminTransport";
import { HttpTransport } from "./httpTransport";
import { MockTransportFixed, createDefaultMockState } from "./mockTransportFixed";

type TransportMode = "mock" | "http";

let mockSingleton: MockTransportFixed | null = null;

function resolveMode(): TransportMode {
  const raw = process.env.NEXT_PUBLIC_ADMIN_TRANSPORT;
  if (raw === "http") return "http";
  return "mock";
}

export function resetMockTransportState(): void {
  mockSingleton = new MockTransportFixed(createDefaultMockState());
}

export function getAdminTransport(): AdminTransport {
  const mode = resolveMode();
  if (mode === "http") {
    return new HttpTransport();
  }
  if (!mockSingleton) {
    mockSingleton = new MockTransportFixed(createDefaultMockState());
  }
  return mockSingleton;
}

