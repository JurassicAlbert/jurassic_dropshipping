# Decision logic

## Listing decisions

A product is **accepted for listing** only if all of the following hold (see `ListingDecider`):

1. **Max source price**: `sourceCost <= rules.maxSourcePrice` (if `maxSourcePrice` is set).
2. **Not blacklisted**: product id and supplier id are not in `blacklistedProductIds` / `blacklistedSupplierIds`.
3. **Min profit margin**: after applying `PricingCalculator`, the profit margin (after estimated marketplace fee) is `>= rules.minProfitPercent`.

Selling price is computed as:

- `sellingPrice = sourceCost * (1 + defaultMarkupPercent/100) / (1 - marketplaceFeePercent/100)`  
  so that after fee the margin meets the desired markup.

When accepted, a `Listing` is created with status `draft` or `pendingApproval` (if `manualApprovalListings` is true), and a `DecisionLog` entry is written with:

- **reason**: e.g. `"Profit margin 35.0% >= 25%"`.
- **criteriaSnapshot**: `sourceCost`, `sellingPrice`, `marginPercent`, `minProfitPercent`.

## Supplier selection

When multiple sources (or variants) are available for the same product, `SupplierSelector`:

1. Drops any candidate whose supplier or product is blacklisted.
2. If `preferredSupplierCountries` is set, keeps only candidates from those countries (or falls back to all if none match).
3. Applies `maxSourcePrice` if set.
4. Sorts by total cost (base price + shipping), then by estimated delivery days.
5. Picks the first and logs the reason (e.g. lowest total cost, country).

## Order flow and approval

- **New orders** from targets are stored with status `pending` or `pendingApproval` depending on `manualApprovalOrders`.
- **Fulfillment** (place source order, then update tracking) runs only when the order is approved (by user or automatically when approval is off).

All listing and order decisions that create or update entities record a `DecisionLog` entry so you can see why a product was listed or an order fulfilled.
