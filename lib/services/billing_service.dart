import 'package:jurassic_dropshipping/data/repositories/billing_plan_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/tenant_plan_repository.dart';

/// Usage snapshot for the current tenant (Phase B5).
class BillingUsage {
  const BillingUsage({
    required this.listingsCount,
    required this.ordersThisMonth,
    required this.plan,
  });
  final int listingsCount;
  final int ordersThisMonth;
  final BillingPlan plan;
}

/// Billing and plan limits (Phase B5). Usage is tracked via listing/order counts; over-limit blocks or prompts upgrade.
class BillingService {
  BillingService({
    required this.listingRepository,
    required this.orderRepository,
    required this.tenantPlanRepository,
    required this.billingPlanRepository,
  });

  final ListingRepository listingRepository;
  final OrderRepository orderRepository;
  final TenantPlanRepository tenantPlanRepository;
  final BillingPlanRepository billingPlanRepository;

  /// Current plan for the tenant (repos are tenant-scoped). Defaults to default plan if none set.
  Future<BillingPlan> getCurrentPlan() async {
    final tenantPlan = await tenantPlanRepository.getByTenantId(listingRepository.tenantId);
    if (tenantPlan != null) {
      final plan = await billingPlanRepository.getById(tenantPlan.planId);
      if (plan != null) return plan;
    }
    return billingPlanRepository.getDefaultPlan();
  }

  /// Usage for the current tenant.
  Future<BillingUsage> getUsage() async {
    final plan = await getCurrentPlan();
    final listingsCount = await listingRepository.count();
    final ordersThisMonth = await orderRepository.countThisMonth();
    return BillingUsage(
      listingsCount: listingsCount,
      ordersThisMonth: ordersThisMonth,
      plan: plan,
    );
  }

  /// True if the tenant can create one more listing (under plan limit).
  Future<bool> canCreateListing() async {
    final usage = await getUsage();
    if (usage.plan.hasUnlimitedListings) return true;
    return usage.listingsCount < usage.plan.maxListings;
  }

  /// True if the tenant can create one more order this month (under plan limit).
  Future<bool> canCreateOrder() async {
    final usage = await getUsage();
    if (usage.plan.hasUnlimitedOrdersPerMonth) return true;
    return usage.ordersThisMonth < usage.plan.maxOrdersPerMonth;
  }

  /// True if any limit is exceeded (listings or orders this month).
  Future<bool> isOverLimit() async {
    final canListing = await canCreateListing();
    final canOrder = await canCreateOrder();
    return !canListing || !canOrder;
  }
}
