# No-API Write Workflow Contracts

This document defines deterministic request/response contracts for **mocking and stress/retetest** the remaining admin *write workflows* **without** requiring the Dart API or warehouse connectivity.

It is derived from the Flutter admin UI flows:
- `lib/features/approval/approval_screen.dart`
- `lib/features/returns/returns_screen.dart`
- `lib/features/incidents/incidents_screen.dart`
- `lib/features/incidents/incident_detail_screen.dart`
- `lib/features/capital/capital_screen.dart`
- `lib/features/return_policies/return_policies_screen.dart`
- `lib/features/suppliers/suppliers_screen.dart`
- `lib/features/dashboard/dashboard_screen.dart` (risk-triggered refresh buttons)

## Contract framing

All contracts target the **transport layer** in `admin_next/src/lib` (to be added by the next plan steps):
- `AdminTransport` interface methods for each workflow.
- `MockTransport` will implement these methods using in-memory deterministic state.
- Later, `HttpTransport` will map the same methods to real Dart endpoints.

### Common response fields

- `requestId: string` (unique per call; used for idempotency/dedup in mock)
- `ok: boolean`
- `message?: string`
- `warnings?: { code: string; details?: string }[]`

### Common error shape

- `error: { code: string; message: string; details?: Record<string, unknown> }`

Error codes (examples; mock may use subset initially):
- `not_found`
- `validation_error`
- `conflict`
- `external_integration_required` (e.g., marketplace write not mocked yet)

## Selected workflows

## 1) Approval queue (listings + orders)

Source UI:
- `ApprovalScreen` → pending listings tiles: `Reject` (sets listing back to draft) and `Approve` (publish to marketplace listing id, set active)
- Pending order tile: `Reject` (confirm cancel on marketplace) and `Approve & Fulfill` (fulfill order and enqueue)

### 1.1 Listing approve/reject

#### Reject listing
Method:
- `approval.rejectListing(listingId)`

Request
```json
{
  "listingId": "string",
  "requestId": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "listing": { "id": "string", "status": "draft" }
}
```

Error
- `not_found` if listing does not exist in mock state.

Optimistic/behavior rules (mock):
- Listing transitions: `active|paused|pendingApproval` → `draft`
- Pending listing queue updates after write completes (or immediately if optimistic mode is enabled).

#### Approve listing
Method:
- `approval.approveListing(listingId)`

Request
```json
{
  "listingId": "string",
  "requestId": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "listing": {
    "id": "string",
    "status": "active",
    "publishedAt": "ISO-8601 string"
  }
}
```

Mock assumptions:
- Marketplace “createListing” is **simulated**.
- If you want marketplace-specific fields later, extend response with `targetListingId` and `targetPlatformId`.

### 1.2 Order approve/reject

#### Reject order (cancel on marketplace)
Method:
- `approval.rejectOrder(orderId, reason?)`

Request
```json
{
  "orderId": "string",
  "requestId": "string",
  "reason": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "order": { "id": "string", "status": "cancelled" }
}
```

#### Approve & fulfill order
Method:
- `approval.approveAndFulfillOrder(orderId)`

Request
```json
{
  "orderId": "string",
  "requestId": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "order": { "id": "string", "status": "sourceOrderPlaced", "approvedAt": "ISO-8601 string" }
}
```

Mock behavior:
- Pending order queue visibility:
  - Orders with mock status `pendingApproval` move to `sourceOrderPlaced` after success.
- Fulfillment/enqueue is simulated (no external HTTP calls).

## 2) Returns workflow (edit + compute routing + optional returned-stock insert)

Source UI:
- `ReturnsScreen` list: tap return → edit dialog
- In dialog:
  - status dropdown (`requested` → … → `refunded` / `rejected`)
  - refund amount, shipping cost, restocking fee, notes
  - “Compute routing” button (uses return policies + supplier data)
  - optional checkbox when status == `received`: “Add to returned stock”
  - Save calls `returnRepository.update(updated)` and may insert `ReturnedStock` when status==received and checkbox selected

### 2.1 Update return (Save)
Method:
- `returns.updateReturn(returnId, patch, routing?)`

Request
```json
{
  "returnId": "string",
  "requestId": "string",
  "patch": {
    "status": "requested|approved|shipped|received|refunded|rejected",
    "notes": "string|null",
    "refundAmount": "number|null",
    "returnShippingCost": "number|null",
    "restockingFee": "number|null",
    "returnRoutingDestination": "sellerAddress|supplierWarehouse|returnCenter|disposal|null",
    "resolvedAtOverride": "ISO-8601 string|null"
  },
  "addToReturnedStock": true
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "return": {
    "id": "string",
    "orderId": "string",
    "status": "requested|...|rejected",
    "resolvedAt": "ISO-8601 string|null"
  },
  "returnedStockCreated": {
    "created": true,
    "rowsInserted": 0
  }
}
```

Mock behavior:
- If `patch.status` is `received` and `addToReturnedStock === true`, insert a returned-stock row with quantity=1 and sourceReturnId=returnId.

### 2.2 Compute routing
Method:
- `returns.computeRouting(returnId)`

Request
```json
{
  "returnId": "string",
  "requestId": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "routing": {
    "destination": "sellerAddress|supplierWarehouse|returnCenter|disposal"
  }
}
```

Mock behavior:
- Deterministic mapping based on:
  - return reason (if present in mock state)
  - supplier return policy (if present)

## 3) Incidents workflow (create + process-enqueue -> resolve)

Source UI:
- `IncidentsScreen` list: create incident via dialog:
  - orderId input
  - incidentType dropdown
  - for `damageClaim`: optional attachment IDs comma-separated
- `IncidentDetailScreen` when status is `open`:
  - “Process (enqueue job)” button enqueues `BackgroundJobType.processIncident`

### 3.1 Create incident
Method:
- `incidents.createIncident(orderId, incidentType, attachmentIds?)`

Request
```json
{
  "orderId": "string",
  "requestId": "string",
  "incidentType": "damageClaim|customerReturn14d|... (IncidentType enum name)",
  "attachmentIds": ["string"]
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "incident": { "id": 123, "orderId": "string", "status": "open" }
}
```

### 3.2 Process incident (enqueue -> eventual resolve in mock)
Method:
- `incidents.processIncident(incidentId)`

Request
```json
{
  "incidentId": 123,
  "requestId": "string"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "incident": { "id": 123, "status": "resolved", "resolvedAt": "ISO-8601 string" }
}
```

Mock behavior options:
- immediate resolution (simpler)
- delayed resolution with internal timers (more realistic for concurrency tests)

## 4) Capital workflow (record adjustments + ledger append)

Source UI:
- `CapitalScreen`
  - form: Amount (signed), Note (optional)
  - calls `capitalManagementService.recordAdjustment(amount, referenceId: note)`
  - refreshes:
    - `capitalBalanceProvider`
    - ledger recent entries

### 4.1 Record capital adjustment
Method:
- `capital.recordAdjustment(amount, referenceId?)`

Request
```json
{
  "requestId": "string",
  "amount": 1000.0,
  "referenceId": "string|null"
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "balance": 12345.67,
  "ledgerEntry": {
    "id": 1,
    "type": "supplier_prepayment|...|adjustment",
    "amount": 1000.0,
    "currency": "PLN",
    "referenceId": "string|null",
    "createdAt": "ISO-8601 string"
  }
}
```

Mock behavior:
- Maintain an in-memory ledger array and balance sum (sum of signed amounts).

## 5) Return Policies (supplier-level upsert)

Source UI:
- `ReturnPoliciesScreen`
  - list policies
  - dialog Add policy / Edit policy (insert/update)

Model mapping:
- `SupplierReturnPolicy` includes:
  - `supplierId: string`
  - `policyType`
  - `returnWindowDays?: int`
  - `restockingFeePercent?: double`
  - `returnShippingPaidBy?: seller|customer|supplier|null`
  - `requiresRma: bool`
  - `warehouseReturnSupported: bool`
  - `virtualRestockSupported: bool`

### 5.1 Upsert return policy
Method:
- `policies.upsertSupplierReturnPolicy(policy)`

Request
```json
{
  "requestId": "string",
  "policy": {
    "supplierId": "string",
    "policyType": "noReturns|defectOnly|returnWindow|fullReturns|returnToWarehouse|sellerHandlesReturns",
    "returnWindowDays": 14,
    "restockingFeePercent": 5.0,
    "returnShippingPaidBy": "seller|customer|supplier|null",
    "requiresRma": false,
    "warehouseReturnSupported": true,
    "virtualRestockSupported": false
  }
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "policy": {
    "supplierId": "string",
    "policyType": "string"
  }
}
```

Mock behavior:
- Enforce “one policy per supplier” semantics: upsert by `supplierId`.

## 6) Supplier reliability refresh

Source UI:
- `SuppliersScreen` button “Refresh reliability scores”
  - calls `supplierReliabilityScoringService.evaluateAll()`

### 6.1 Refresh reliability scores
Method:
- `suppliers.refreshReliabilityScores()`

Request
```json
{
  "requestId": "string",
  "windowDays": 90
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "scoresUpdated": true,
  "updatedSuppliersCount": 10
}
```

Mock behavior:
- Deterministically compute each supplier score using:
  - orders/cancellations/late shipments stats present in mock dataset (or seeded defaults).

## 7) Risk-triggered refresh (listing health + customer metrics)

Source UI (Dashboard operational buttons that affect risk cards and pause events):
- “Refresh listing health” → `listingHealthScoringService.evaluateAll()` (can set `ListingStatus.paused`)
- “Refresh customer metrics” → `customerAbuseScoringService.evaluateAll()`

### 7.1 Refresh listing health
Method:
- `risk.refreshListingHealth()`

Request
```json
{
  "requestId": "string",
  "windowDays": 90
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "metricsRefreshed": true,
  "pausedListingsDelta": 3
}
```

### 7.2 Refresh customer metrics
Method:
- `risk.refreshCustomerMetrics()`

Request
```json
{
  "requestId": "string",
  "windowDays": 90
}
```

Response
```json
{
  "requestId": "string",
  "ok": true,
  "metricsRefreshed": true,
  "abuseSignalsUpdated": 7
}
```

Mock behavior:
- Update listing health dataset and risk indicators based on seeded history.

## Concurrency + idempotency rules (required for stress/retetest)

Mock transport must support:
- concurrent writes:
  - simultaneous approve/reject of different items must not deadlock the UI
  - order of completion may differ; final state must match deterministic outcome rules
- idempotency:
  - if two calls share the same `requestId`, the second call returns the same final state response without double-applying

## Next implementation steps (from this plan)

After contracts are agreed, the next tasks implement:
1) the `AdminTransport` interface + `MockTransport`
2) deterministic fixture state + transitions
3) UI write controls in admin_next pages that call transport methods
4) tests:
   - MSW route mocking
   - Playwright `page.route` stubs for latency and failure
   - synthetic stress loops for repeated actions

