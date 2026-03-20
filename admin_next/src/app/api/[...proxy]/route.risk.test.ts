import { GET } from "./route";

describe("proxy route risk paths (TP-C)", () => {
  it("returns 503 when Dart API is unreachable", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async () => {
        throw new Error("ECONNREFUSED");
      }) as unknown as typeof fetch,
    );
    const response = await GET(new Request("http://localhost:3001/api/returns") as never, {
      params: Promise.resolve({ proxy: ["returns"] }),
    });
    expect(response.status).toBe(503);
    const body = await response.json();
    expect(body).toMatchObject({ error: "dart_api_unreachable" });
  });

  it("returns 502 when Dart API responds non-OK", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async () => ({
        ok: false,
        status: 500,
      })) as unknown as typeof fetch,
    );
    const response = await GET(new Request("http://localhost:3001/api/capital") as never, {
      params: Promise.resolve({ proxy: ["capital"] }),
    });
    expect(response.status).toBe(502);
  });
});
