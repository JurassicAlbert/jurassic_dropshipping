import type { NextRequest } from "next/server";
import { describe, expect, it, vi, beforeEach, afterEach } from "vitest";
import { GET, POST } from "./route";

describe("/api/rules", () => {
  const orig = process.env.DART_API_BASE_URL;

  beforeEach(() => {
    process.env.DART_API_BASE_URL = "http://127.0.0.1:4000";
  });

  afterEach(() => {
    process.env.DART_API_BASE_URL = orig;
    vi.restoreAllMocks();
  });

  it("GET returns 502 when Dart responds non-OK", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn().mockResolvedValue({
        ok: false,
        status: 500,
        json: async () => ({}),
      }),
    );
    const res = await GET();
    expect(res.status).toBe(502);
  });

  it("POST forwards body to Dart /rules", async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      ok: true,
      json: async () => ({ minProfitPercent: 30 }),
    });
    vi.stubGlobal("fetch", fetchMock);

    const req = new Request("http://localhost/api/rules", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ minProfitPercent: 30 }),
    });
    const res = await POST(req as unknown as NextRequest);
    expect(res.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/rules",
      expect.objectContaining({ method: "POST" }),
    );
  });
});
