# Money Safety Guide — Jurasic Dropshipping

This document explains built-in protections against financial loss and how to configure them properly.

## Pricing Guardrails

### Minimum Profit Margin (`minProfitPercent`)
- Set in Settings → Rules → "Min profit %"
- The system **will not create listings** where the expected profit margin (after marketplace fees) falls below this threshold
- **Recommendation:** Start with 25% for the Polish market. Never go below 15%.

### Absolute Minimum Profit
- The system enforces a hard floor of **5 PLN profit per item**, regardless of percentage
- This prevents micro-profit listings that become losses after any fee variation

### Maximum Source Price (`maxSourcePrice`)
- Set in Settings → Rules (optional)
- Blocks products costing more than this from being listed
- **Recommendation:** Set to 200 PLN initially. Higher-priced items carry more risk if returned.

### Selling Price Sanity Check
- The system rejects any calculated selling price exceeding 10x the source cost
- This catches data errors (e.g. a supplier reporting 0.01 PLN cost)

### Return Risk Buffer (`calculateSafeSellingPrice`)
- When using the safe pricing mode, the system adds a buffer based on expected return rate
- Default: 5% return rate × (selling price + 20 PLN avg return shipping)
- This ensures profitability even with returns

## Marketplace Fees

### Allegro
- ~10% commission (varies by category, 8-15%)
- The system defaults to 10% (`PricingCalculator.marketplaceFeePercent`)
- **Action:** Check your Allegro category fee schedule and adjust if needed

### Temu
- Commission varies by category (typically 5-15%)
- Currently uses the same 10% default

## Return Policy (Polish Law — 14-day no-reason returns)

### Legal Requirement
- Polish consumers have **14 calendar days** to return online purchases without reason
- This is **mandatory** and cannot be waived

### Financial Impact
Each return costs you:
1. **Full refund** to buyer (selling price minus restocking fee if applicable)
2. **Return shipping** (often seller-paid, ~20-30 PLN domestic)
3. **Lost marketplace fee** (already paid on the sale, not always refunded)
4. **Source cost** if item cannot be returned to supplier

### Mitigation Strategies
1. **Price in the return rate:** Use `calculateSafeSellingPrice` which adds a buffer
2. **Check supplier return policy:** The Supplier model tracks `returnWindowDays`, `returnShippingCost`, and `acceptsNoReasonReturns`
3. **Prefer suppliers with returns:** `SupplierSelector` can prioritize suppliers that accept returns
4. **Monitor return rates:** Check the Returns screen regularly; if a product has high returns, blacklist it

### Return Cost Calculation
Use `PricingCalculator.estimateReturnCost` to preview worst-case scenarios:
- `refundAmount` = sellingPrice - restockingFee
- `netLoss` = refundAmount + returnShippingCost - restockingFee

## Approval Gates

### Manual Approval for Listings (`manualApprovalListings`)
- When ON: scanner creates listings as "Pending Approval" — you review before publishing
- **Recommendation:** Keep ON until you trust your rules and margins

### Manual Approval for Orders (`manualApprovalOrders`)
- When ON: new orders wait for your approval before auto-fulfillment
- **Recommendation:** Keep ON initially, then switch to auto once you're confident

## Blacklists

### Product Blacklist (`blacklistedProductIds`)
- Add product IDs that should never be listed (high return rate, quality issues)

### Supplier Blacklist (`blacklistedSupplierIds`)
- Add suppliers with poor quality, slow shipping, or bad return policies

## Monitoring Checklist

1. **Daily:** Check Dashboard for new orders, pending approvals
2. **Weekly:** Review profit trend chart, check for declining margins
3. **Weekly:** Check Returns screen for patterns (products/suppliers with high return rates)
4. **Monthly:** Review and update `minProfitPercent` based on actual marketplace fee rates
5. **Monthly:** Run price refresh to catch supplier price changes

## Common Money-Loss Scenarios

| Scenario | Protection | Configuration |
|----------|-----------|---------------|
| Supplier raises price after listing | Price refresh service | Run regularly via Automation |
| Product has high return rate | Blacklist product | Add to `blacklistedProductIds` |
| Marketplace fee higher than estimated | Adjust `marketplaceFeePercent` | Currently hardcoded at 10% |
| Currency fluctuation | N/A | Manual monitoring required |
| Shipping cost changes | Price refresh | Refresh offers regularly |
| Listing at tiny profit | Absolute minimum 5 PLN floor | Automatic |
| Data error (0.01 PLN cost) | 10x sanity check | Automatic |
