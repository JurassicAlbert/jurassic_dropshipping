# Pricing path audit (p1)

**Purpose:** Document where [`PricingCalculator`](../lib/domain/decision_engine/pricing_calculator.dart) and platform fees participate in the pipeline so margins stay consistent with [`MONEY_SAFETY.md`](MONEY_SAFETY.md).

## Flow

| Stage | Component | Uses `PricingCalculator`? | Notes |
|-------|-----------|---------------------------|--------|
| Scan → candidate offer | [`Scanner`](../lib/domain/decision_engine/scanner.dart) | Yes (injected) | Computes list price / margin for sourcing decision. |
| Listing decision | [`ListingDecider`](../lib/domain/decision_engine/listing_decider.dart) | Yes (injected) | Approves/rejects draft listings using fees + rules. |
| Settings / rules | [`SettingsScreen`](../lib/features/settings/settings_screen.dart) | Reads calculator for previews | User adjusts min profit %, fees maps. |
| Profit guard | [`ProfitGuardService`](../lib/services/profit_guard_service.dart) | Yes | Pauses listings when margin below threshold. |
| Dynamic pricing | [`DynamicPricingEngine`](../lib/services/product_intelligence/dynamic_pricing_engine.dart) | Yes | Risk-adjusted pricing wrapper. |
| Competitor pricing | [`CompetitorPricingService`](../lib/services/competitor_pricing_service.dart), [`AllegroCompetitorPricingService`](../lib/services/allegro_competitor_pricing_service.dart) | Yes | Uses calculator for P_min / competitor comparisons. |

## Gaps / vigilance

- **Approval UI** (Flutter / Next): ensure displayed margin matches the same fee maps as `UserRules.marketplaceFees` / `paymentFees` — do not duplicate ad-hoc percentages in UI-only code.
- **Order sync / fulfillment**: shipping and cost snapshots should align with listing-time assumptions where still valid; major repricing flows go through services above.
- **Price refresh jobs**: must use repository product + listing data and feed [`PricingCalculator`] through the same strategy fields as listing creation.

## Conclusion

The calculator is **wired** into scan, listing decisions, guardrails, and pricing intelligence. Remaining work is **consistency checks** when adding new surfaces (new admin charts, approval screens) so no parallel margin math diverges from `UserRules` and `PricingCalculator`.
