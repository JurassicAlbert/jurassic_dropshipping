import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Applies return window, grace period, and marketplace rules for late returns.
class ReturnPolicyService {
  /// Return window end date: [deliveredAt] + [supplierReturnWindowDays], or [order.promisedDeliveryMax] + 2 days if no deliveredAt.
  static DateTime? returnWindowEnd(
    Order order, {
    int? supplierReturnWindowDays,
  }) {
    final base = order.deliveredAt ?? order.promisedDeliveryMax;
    if (base == null) return null;
    final days = supplierReturnWindowDays ?? 14;
    return base.add(Duration(days: days));
  }

  /// Grace period end: return window end + [graceDays] (e.g. 1–2 days).
  static DateTime? gracePeriodEnd(
    Order order, {
    int? supplierReturnWindowDays,
    int graceDays = 2,
  }) {
    final end = returnWindowEnd(order, supplierReturnWindowDays: supplierReturnWindowDays);
    if (end == null) return null;
    return end.add(Duration(days: graceDays));
  }

  /// True if [returnRequestedAt] is within return window + grace (accept return).
  static bool isWithinGrace(
    DateTime returnRequestedAt,
    Order order, {
    int? supplierReturnWindowDays,
    int graceDays = 2,
  }) {
    final graceEnd = gracePeriodEnd(
      order,
      supplierReturnWindowDays: supplierReturnWindowDays,
      graceDays: graceDays,
    );
    if (graceEnd == null) return true;
    return !returnRequestedAt.isAfter(graceEnd);
  }

  /// True if [returnRequestedAt] is after grace period (late return; apply marketplace policy).
  static bool isLateReturn(
    DateTime returnRequestedAt,
    Order order, {
    int? supplierReturnWindowDays,
    int graceDays = 2,
  }) {
    final graceEnd = gracePeriodEnd(
      order,
      supplierReturnWindowDays: supplierReturnWindowDays,
      graceDays: graceDays,
    );
    if (graceEnd == null) return false;
    return returnRequestedAt.isAfter(graceEnd);
  }

  /// Whether to accept the return: within grace => true; after grace => !marketplacePolicy.rejectAfterGrace.
  static bool shouldAcceptReturn(
    DateTime returnRequestedAt,
    Order order, {
    int? supplierReturnWindowDays,
    int graceDays = 2,
    MarketplaceReturnPolicy? marketplacePolicy,
  }) {
    if (isWithinGrace(returnRequestedAt, order, supplierReturnWindowDays: supplierReturnWindowDays, graceDays: graceDays)) {
      return true;
    }
    if (marketplacePolicy != null && marketplacePolicy.rejectAfterGrace) {
      return false;
    }
    return true;
  }

  /// Suggested refund amount for a late return (e.g. partial per marketplace). Returns null if full refund.
  static double? suggestedRefundForLateReturn(
    double sellingPrice, {
    MarketplaceReturnPolicy? marketplacePolicy,
  }) {
    if (marketplacePolicy == null || !marketplacePolicy.rejectAfterGrace) return null;
    return sellingPrice;
  }
}
