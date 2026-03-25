import { describe, it, expect, beforeAll, afterAll, afterEach } from 'vitest';
import { server } from './server';

beforeAll(() => server.listen({ onUnhandledRequest: 'bypass' }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe('MSW write endpoint handlers', () => {
  it('approves an order', async () => {
    const res = await fetch('/api/approval/orders/ord_1/approve', { method: 'POST' });
    const data = await res.json();
    expect(data.id).toBe('ord_1');
    expect(data.status).toBe('approved');
  });

  it('rejects an order', async () => {
    const res = await fetch('/api/approval/orders/ord_1/reject', { method: 'POST' });
    const data = await res.json();
    expect(data.status).toBe('rejected');
  });

  it('creates an incident', async () => {
    const res = await fetch('/api/incidents', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ orderId: 'ord_1', incidentType: 'customerReturn14d' }),
    });
    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.incident.orderId).toBe('ord_1');
    expect(data.incident.status).toBe('open');
  });

  it('handles 429 rate limit', async () => {
    const res = await fetch('/api/test/fail-429', { method: 'POST' });
    expect(res.status).toBe(429);
  });

  it('handles 500 server error', async () => {
    const res = await fetch('/api/test/fail-500', { method: 'POST' });
    expect(res.status).toBe(500);
  });
});
