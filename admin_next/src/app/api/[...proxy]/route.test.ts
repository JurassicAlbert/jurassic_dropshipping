import { GET, PATCH, POST } from "./route";

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

  it("proxies POST for allowed routes with body", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ ok: true, saved: true }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await POST(
      new Request("http://localhost:3001/api/return-policies", {
        method: "POST",
        body: JSON.stringify({ policy: { supplierId: "sup_1" } }),
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["return-policies"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/return-policies",
      expect.objectContaining({
        method: "POST",
        body: JSON.stringify({ policy: { supplierId: "sup_1" } }),
      }),
    );
  });

  it("proxies POST for returns compute-routing subpath", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ returnId: "ret_1", routing: { destination: "sellerAddress" } }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await POST(
      new Request("http://localhost:3001/api/returns/ret_1/compute-routing", {
        method: "POST",
        body: "{}",
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["returns", "ret_1", "compute-routing"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/returns/ret_1/compute-routing",
      expect.objectContaining({ method: "POST", body: "{}" }),
    );
  });

  it("proxies POST for nested supplier refresh route", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ updatedSuppliersCount: 3 }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await POST(
      new Request("http://localhost:3001/api/suppliers/reliability/refresh", {
        method: "POST",
        body: JSON.stringify({ windowDays: 90 }),
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["suppliers", "reliability", "refresh"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/suppliers/reliability/refresh",
      expect.objectContaining({
        method: "POST",
        body: JSON.stringify({ windowDays: 90 }),
      }),
    );
  });

  it("proxies POST for nested approval action route", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ ok: true }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await POST(
      new Request("http://localhost:3001/api/approval/listings/lst-1/approve", {
        method: "POST",
        body: "{}",
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["approval", "listings", "lst-1", "approve"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/approval/listings/lst-1/approve",
      expect.objectContaining({ method: "POST" }),
    );
  });

  it("proxies PATCH for allowed nested routes with body", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ ok: true, updated: true }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await PATCH(
      new Request("http://localhost:3001/api/incidents/1234", {
        method: "PATCH",
        body: JSON.stringify({ status: "resolved" }),
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["incidents", "1234"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/incidents/1234",
      expect.objectContaining({
        method: "PATCH",
        body: JSON.stringify({ status: "resolved" }),
      }),
    );
  });

  it("proxies POST for nested risk refresh route", async () => {
    const fetchMock = vi.fn(async () => ({
      ok: true,
      json: async () => ({ metricsRefreshed: true }),
    })) as unknown as typeof fetch;
    vi.stubGlobal("fetch", fetchMock);

    const response = await POST(
      new Request("http://localhost:3001/api/risk/listing-health/refresh", {
        method: "POST",
        body: JSON.stringify({ windowDays: 90 }),
        headers: { "content-type": "application/json" },
      }) as never,
      { params: Promise.resolve({ proxy: ["risk", "listing-health", "refresh"] }) },
    );

    expect(response.status).toBe(200);
    expect(fetchMock).toHaveBeenCalledWith(
      "http://127.0.0.1:4000/risk/listing-health/refresh",
      expect.objectContaining({
        method: "POST",
        body: JSON.stringify({ windowDays: 90 }),
      }),
    );
  });
});

