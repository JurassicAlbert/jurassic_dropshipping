import { GET } from "./route";

describe("proxy route", () => {
  it("rejects disallowed routes", async () => {
    const response = await GET(new Request("http://localhost:3001/api/unknown") as never, {
      params: Promise.resolve({ proxy: ["unknown"] }),
    });
    expect(response.status).toBe(404);
  });

  it("proxies allowed routes", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async () => ({
        ok: true,
        json: async () => ({ ok: true }),
      })) as unknown as typeof fetch,
    );
    const response = await GET(new Request("http://localhost:3001/api/returns") as never, {
      params: Promise.resolve({ proxy: ["returns"] }),
    });
    expect(response.status).toBe(200);
  });
});

