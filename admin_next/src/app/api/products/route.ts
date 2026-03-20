import { NextResponse } from "next/server";

export async function GET() {
  const dartUrl = process.env.DART_PRODUCTS_URL ?? "http://127.0.0.1:4000/products";

  try {
    const res = await fetch(dartUrl, { method: "GET", cache: "no-store" });
    if (!res.ok) {
      return NextResponse.json({ error: "dart_api_error", status: res.status }, { status: 502 });
    }
    const data = await res.json();
    return NextResponse.json(data);
  } catch {
    return NextResponse.json({ error: "dart_api_unreachable" }, { status: 503 });
  }
}

