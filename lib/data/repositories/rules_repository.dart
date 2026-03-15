import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Repository for single-user rules (profit thresholds, approval toggles, etc.). Scoped by [tenantId].
class RulesRepository {
  RulesRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  static List<String> _jsonList(String? json) {
    if (json == null || json.isEmpty) return [];
    final list = jsonDecode(json) as List<dynamic>?;
    return (list ?? []).map((e) => e as String).toList();
  }

  static Map<String, double> _jsonMap(String? json) {
    if (json == null || json.isEmpty) return {};
    final map = jsonDecode(json) as Map<String, dynamic>?;
    return (map ?? {}).map((k, v) => MapEntry(k, (v as num).toDouble()));
  }

  static Map<String, int> _jsonMapInt(String? json) {
    if (json == null || json.isEmpty) return {};
    final map = jsonDecode(json) as Map<String, dynamic>?;
    return (map ?? {}).map((k, v) => MapEntry(k, (v as num).toInt()));
  }

  static Map<String, dynamic> _jsonMapDynamic(String? json) {
    if (json == null || json.isEmpty) return {};
    final map = jsonDecode(json) as Map<String, dynamic>?;
    return map ?? {};
  }

  static Map<String, dynamic>? _jsonMapNullable(String? json) {
    if (json == null || json.isEmpty) return null;
    final map = jsonDecode(json) as Map<String, dynamic>?;
    return map;
  }

  static UserRules _rowToRules(UserRulesRow row) {
    return UserRules(
      minProfitPercent: row.minProfitPercent,
      maxSourcePrice: row.maxSourcePrice,
      preferredSupplierCountries: _jsonList(row.preferredSupplierCountries),
      manualApprovalListings: row.manualApprovalListings,
      manualApprovalOrders: row.manualApprovalOrders,
      scanIntervalMinutes: row.scanIntervalMinutes,
      blacklistedProductIds: _jsonList(row.blacklistedProductIds),
      blacklistedSupplierIds: _jsonList(row.blacklistedSupplierIds),
      defaultMarkupPercent: row.defaultMarkupPercent,
      searchKeywords: _jsonList(row.searchKeywords),
      marketplaceFees: _jsonMap(row.marketplaceFeesJson),
      paymentFees: _jsonMap(row.paymentFeesJson),
      sellerReturnAddress: _jsonMapNullable(row.sellerReturnAddressJson),
      marketplaceReturnPolicy: _jsonMapDynamic(row.marketplaceReturnPolicyJson),
      targetsReadOnly: row.targetsReadOnly,
      pricingStrategy: row.pricingStrategy,
      categoryMinProfitPercent: _jsonMap(row.categoryMinProfitPercentJson),
      premiumWhenBetterReviewsPercent: row.premiumWhenBetterReviewsPercent,
      minSalesCountForPremium: row.minSalesCountForPremium,
      kpiDrivenStrategyEnabled: row.kpiDrivenStrategyEnabled,
      rateLimitMaxRequestsPerSecond: _jsonMapInt(row.rateLimitMaxRequestsPerSecondJson),
      incidentRulesJson: row.incidentRulesJson,
      riskScoreThreshold: row.riskScoreThreshold,
      defaultReturnRatePercent: row.defaultReturnRatePercent,
      defaultReturnCostPerUnit: row.defaultReturnCostPerUnit,
      blockFulfillWhenInsufficientStock: row.blockFulfillWhenInsufficientStock,
      autoPauseListingWhenMarginBelowThreshold: row.autoPauseListingWhenMarginBelowThreshold,
      defaultSupplierProcessingDays: row.defaultSupplierProcessingDays,
      defaultSupplierShippingDays: row.defaultSupplierShippingDays,
      marketplaceMaxDeliveryDays: row.marketplaceMaxDeliveryDays,
      listingHealthMaxReturnRatePercent: row.listingHealthMaxReturnRatePercent,
      listingHealthMaxLateRatePercent: row.listingHealthMaxLateRatePercent,
      autoPauseListingWhenHealthPoor: row.autoPauseListingWhenHealthPoor,
      safetyStockBuffer: row.safetyStockBuffer,
      customerAbuseMaxReturnRatePercent: row.customerAbuseMaxReturnRatePercent,
      customerAbuseMaxComplaintRatePercent: row.customerAbuseMaxComplaintRatePercent,
      priceRefreshIntervalMinutesBySource: _jsonMapInt(row.priceRefreshIntervalMinutesBySourceJson),
    );
  }

  Future<UserRules> get() async {
    final row = await (_db.select(_db.userRulesTable)
          ..where((t) => t.tenantId.equals(tenantId))
          ..limit(1))
        .getSingleOrNull();
    if (row != null) return _rowToRules(row);
    const defaultRules = UserRules();
    await save(defaultRules);
    return defaultRules;
  }

  Future<void> save(UserRules rules) async {
    final existing = await (_db.select(_db.userRulesTable)..limit(1)).getSingleOrNull();
    final countries = jsonEncode(rules.preferredSupplierCountries);
    final blacklistedProducts = jsonEncode(rules.blacklistedProductIds);
    final blacklistedSuppliers = jsonEncode(rules.blacklistedSupplierIds);
    final keywords = jsonEncode(rules.searchKeywords);
    final feesJson = jsonEncode(rules.marketplaceFees);
    final sellerReturnJson = rules.sellerReturnAddress != null
        ? jsonEncode(rules.sellerReturnAddress)
        : null;
    final marketplaceReturnPolicyJson = jsonEncode(rules.marketplaceReturnPolicy);
    final paymentFeesJson = jsonEncode(rules.paymentFees);
    final categoryMinProfitPercentJson = jsonEncode(rules.categoryMinProfitPercent);
    final rateLimitMaxRequestsPerSecondJson = jsonEncode(rules.rateLimitMaxRequestsPerSecond);
    final incidentRulesJson = rules.incidentRulesJson;
    final riskScoreThreshold = rules.riskScoreThreshold;
    final defaultReturnRatePercent = rules.defaultReturnRatePercent;
    final defaultReturnCostPerUnit = rules.defaultReturnCostPerUnit;
    final blockFulfillWhenInsufficientStock = rules.blockFulfillWhenInsufficientStock;
    final autoPauseListingWhenMarginBelowThreshold = rules.autoPauseListingWhenMarginBelowThreshold;
    final defaultSupplierProcessingDays = rules.defaultSupplierProcessingDays;
    final defaultSupplierShippingDays = rules.defaultSupplierShippingDays;
    final marketplaceMaxDeliveryDays = rules.marketplaceMaxDeliveryDays;
    final listingHealthMaxReturnRatePercent = rules.listingHealthMaxReturnRatePercent;
    final listingHealthMaxLateRatePercent = rules.listingHealthMaxLateRatePercent;
    final autoPauseListingWhenHealthPoor = rules.autoPauseListingWhenHealthPoor;
    final safetyStockBuffer = rules.safetyStockBuffer;
    final customerAbuseMaxReturnRatePercent = rules.customerAbuseMaxReturnRatePercent;
    final customerAbuseMaxComplaintRatePercent = rules.customerAbuseMaxComplaintRatePercent;
    final priceRefreshIntervalMinutesBySourceJson = jsonEncode(rules.priceRefreshIntervalMinutesBySource);
    if (existing != null) {
      await (_db.update(_db.userRulesTable)
            ..where((t) => t.tenantId.equals(tenantId) & t.id.equals(existing.id)))
        .write(
        UserRulesTableCompanion(
          minProfitPercent: Value(rules.minProfitPercent),
          maxSourcePrice: Value(rules.maxSourcePrice),
          preferredSupplierCountries: Value(countries),
          manualApprovalListings: Value(rules.manualApprovalListings),
          manualApprovalOrders: Value(rules.manualApprovalOrders),
          scanIntervalMinutes: Value(rules.scanIntervalMinutes),
          blacklistedProductIds: Value(blacklistedProducts),
          blacklistedSupplierIds: Value(blacklistedSuppliers),
          defaultMarkupPercent: Value(rules.defaultMarkupPercent),
          searchKeywords: Value(keywords),
          marketplaceFeesJson: Value(feesJson),
          sellerReturnAddressJson: Value(sellerReturnJson),
          marketplaceReturnPolicyJson: Value(marketplaceReturnPolicyJson),
          targetsReadOnly: Value(rules.targetsReadOnly),
          paymentFeesJson: Value(paymentFeesJson),
          pricingStrategy: Value(rules.pricingStrategy),
          categoryMinProfitPercentJson: Value(categoryMinProfitPercentJson),
          premiumWhenBetterReviewsPercent: Value(rules.premiumWhenBetterReviewsPercent),
          minSalesCountForPremium: Value(rules.minSalesCountForPremium),
          kpiDrivenStrategyEnabled: Value(rules.kpiDrivenStrategyEnabled),
          rateLimitMaxRequestsPerSecondJson: Value(rateLimitMaxRequestsPerSecondJson),
          incidentRulesJson: Value(incidentRulesJson),
          riskScoreThreshold: Value(riskScoreThreshold),
          defaultReturnRatePercent: Value(defaultReturnRatePercent),
          defaultReturnCostPerUnit: Value(defaultReturnCostPerUnit),
          blockFulfillWhenInsufficientStock: Value(blockFulfillWhenInsufficientStock),
          autoPauseListingWhenMarginBelowThreshold: Value(autoPauseListingWhenMarginBelowThreshold),
          defaultSupplierProcessingDays: Value(defaultSupplierProcessingDays),
          defaultSupplierShippingDays: Value(defaultSupplierShippingDays),
          marketplaceMaxDeliveryDays: Value(marketplaceMaxDeliveryDays),
          listingHealthMaxReturnRatePercent: Value(listingHealthMaxReturnRatePercent),
          listingHealthMaxLateRatePercent: Value(listingHealthMaxLateRatePercent),
          autoPauseListingWhenHealthPoor: Value(autoPauseListingWhenHealthPoor),
          safetyStockBuffer: Value(safetyStockBuffer),
          customerAbuseMaxReturnRatePercent: Value(customerAbuseMaxReturnRatePercent),
          customerAbuseMaxComplaintRatePercent: Value(customerAbuseMaxComplaintRatePercent),
        ),
      );
    } else {
      await _db.into(_db.userRulesTable).insert(
        UserRulesTableCompanion.insert(
          tenantId: Value(tenantId),
          minProfitPercent: rules.minProfitPercent,
          maxSourcePrice: Value(rules.maxSourcePrice),
          preferredSupplierCountries: countries,
          manualApprovalListings: rules.manualApprovalListings,
          manualApprovalOrders: rules.manualApprovalOrders,
          scanIntervalMinutes: rules.scanIntervalMinutes,
          blacklistedProductIds: blacklistedProducts,
          blacklistedSupplierIds: blacklistedSuppliers,
          defaultMarkupPercent: rules.defaultMarkupPercent,
          searchKeywords: keywords,
          marketplaceFeesJson: Value(feesJson),
          sellerReturnAddressJson: Value(sellerReturnJson),
          marketplaceReturnPolicyJson: Value(marketplaceReturnPolicyJson),
          targetsReadOnly: Value(rules.targetsReadOnly),
          paymentFeesJson: Value(paymentFeesJson),
          pricingStrategy: Value(rules.pricingStrategy),
          categoryMinProfitPercentJson: Value(categoryMinProfitPercentJson),
          premiumWhenBetterReviewsPercent: Value(rules.premiumWhenBetterReviewsPercent),
          minSalesCountForPremium: Value(rules.minSalesCountForPremium),
          kpiDrivenStrategyEnabled: Value(rules.kpiDrivenStrategyEnabled),
          rateLimitMaxRequestsPerSecondJson: Value(rateLimitMaxRequestsPerSecondJson),
          incidentRulesJson: Value(incidentRulesJson),
          riskScoreThreshold: Value(riskScoreThreshold),
          defaultReturnRatePercent: Value(defaultReturnRatePercent),
          defaultReturnCostPerUnit: Value(defaultReturnCostPerUnit),
          blockFulfillWhenInsufficientStock: Value(blockFulfillWhenInsufficientStock),
          autoPauseListingWhenMarginBelowThreshold: Value(autoPauseListingWhenMarginBelowThreshold),
          defaultSupplierProcessingDays: Value(defaultSupplierProcessingDays),
          defaultSupplierShippingDays: Value(defaultSupplierShippingDays),
          marketplaceMaxDeliveryDays: Value(marketplaceMaxDeliveryDays),
          listingHealthMaxReturnRatePercent: Value(listingHealthMaxReturnRatePercent),
          listingHealthMaxLateRatePercent: Value(listingHealthMaxLateRatePercent),
          autoPauseListingWhenHealthPoor: Value(autoPauseListingWhenHealthPoor),
          safetyStockBuffer: Value(safetyStockBuffer),
          customerAbuseMaxReturnRatePercent: Value(customerAbuseMaxReturnRatePercent),
          customerAbuseMaxComplaintRatePercent: Value(customerAbuseMaxComplaintRatePercent),
          priceRefreshIntervalMinutesBySourceJson: Value(priceRefreshIntervalMinutesBySourceJson),
        ),
      );
    }
  }
}
