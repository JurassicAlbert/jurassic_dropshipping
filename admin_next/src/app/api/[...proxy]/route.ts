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
  "risk",
]);

export async function GET(
  _request: NextRequest,
  context: { params: Promise<{ proxy: string[] }> },
) {
  return proxyRequest("GET", _request, context);
}

export async function POST(
  request: NextRequest,
  context: { params: Promise<{ proxy: string[] }> },
) {
  return proxyRequest("POST", request, context);
}

export async function PATCH(
  request: NextRequest,
  context: { params: Promise<{ proxy: string[] }> },
) {
  return proxyRequest("PATCH", request, context);
}

async function proxyRequest(
  method: "GET" | "POST" | "PATCH",
  request: NextRequest,
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
    const init: RequestInit = method === "GET"
      ? { method: "GET", cache: "no-store" }
      : {
          method,
          cache: "no-store",
          body: await request.text(),
          headers: {
            "content-type": request.headers.get("content-type") ?? "application/json",
          },
        };
    const res = await fetch(url, init);
    if (!res.ok) {
      return NextResponse.json({ error: "dart_api_error", status: res.status }, { status: 502 });
    }
    const data = await res.json();
    return NextResponse.json(data);
  } catch {
    return NextResponse.json({ error: "dart_api_unreachable" }, { status: 503 });
  }
}

