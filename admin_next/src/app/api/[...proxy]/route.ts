import { NextRequest, NextResponse } from "next/server";

const allowed = new Set([
  "marketplaces",
  "returns",
  "incidents",
  "risk-dashboard",
  "returned-stock",
  "capital",
  "approval",
  "decision-log",
  "return-policies",
  "profit-dashboard",
  "how-it-works",
  "suppliers",
]);

export async function GET(
  _request: NextRequest,
  context: { params: Promise<{ proxy: string[] }> },
) {
  const { proxy } = await context.params;
  if (!proxy || proxy.length === 0) {
    return NextResponse.json({ error: "not_found" }, { status: 404 });
  }

  const head = proxy[0];
  if (!allowed.has(head)) {
    return NextResponse.json({ error: "not_allowed" }, { status: 404 });
  }

  const path = proxy.join("/");
  const dartBase = process.env.DART_API_BASE_URL ?? "http://127.0.0.1:4000";
  const url = `${dartBase}/${path}`;

  try {
    const res = await fetch(url, { method: "GET", cache: "no-store" });
    if (!res.ok) {
      return NextResponse.json({ error: "dart_api_error", status: res.status }, { status: 502 });
    }
    const data = await res.json();
    return NextResponse.json(data);
  } catch {
    return NextResponse.json({ error: "dart_api_unreachable" }, { status: 503 });
  }
}

