import { NextRequest, NextResponse } from "next/server";

const dartBase = () => process.env.DART_API_BASE_URL ?? "http://127.0.0.1:4000";

export async function GET() {
  try {
    const res = await fetch(`${dartBase()}/rules`, { method: "GET", cache: "no-store" });
    if (!res.ok) {
      return NextResponse.json({ error: "dart_api_error", status: res.status }, { status: 502 });
    }
    const data = await res.json();
    return NextResponse.json(data);
  } catch {
    return NextResponse.json({ error: "dart_api_unreachable" }, { status: 503 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const res = await fetch(`${dartBase()}/rules`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
      cache: "no-store",
    });
    if (!res.ok) {
      return NextResponse.json({ error: "dart_api_error", status: res.status }, { status: 502 });
    }
    const data = await res.json();
    return NextResponse.json(data);
  } catch {
    return NextResponse.json({ error: "dart_api_unreachable" }, { status: 503 });
  }
}
