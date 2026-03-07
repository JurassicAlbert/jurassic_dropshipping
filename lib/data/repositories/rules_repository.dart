import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';

/// Repository for single-user rules (profit thresholds, approval toggles, etc.).
class RulesRepository {
  RulesRepository(this._db);
  final AppDatabase _db;

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
    );
  }

  Future<UserRules> get() async {
    final row = await (_db.select(_db.userRulesTable)..limit(1)).getSingleOrNull();
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
    if (existing != null) {
      await (_db.update(_db.userRulesTable)..where((t) => t.id.equals(existing.id))).write(
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
        ),
      );
    } else {
      await _db.into(_db.userRulesTable).insert(
        UserRulesTableCompanion.insert(
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
        ),
      );
    }
  }
}
