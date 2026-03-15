import 'package:drift/drift.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';

/// Ledger entry type (Phase 14). Stored as text in DB.
class LedgerEntryType {
  const LedgerEntryType._(this.name);
  final String name;
  static const supplierPrepayment = LedgerEntryType._('supplier_prepayment');
  static const marketplaceHeld = LedgerEntryType._('marketplace_held');
  static const marketplaceReleased = LedgerEntryType._('marketplace_released');
  static const refund = LedgerEntryType._('refund');
  static const loss = LedgerEntryType._('loss');
  static const adjustment = LedgerEntryType._('adjustment');
}

/// Repository for financial ledger (Phase 14). Append-only; balance = sum(amount) per tenant.
class FinancialLedgerRepository {
  FinancialLedgerRepository(this._db, {this.tenantId = 1});
  final AppDatabase _db;
  final int tenantId;

  /// Appends an entry. [amount] is signed: positive = inflow, negative = outflow.
  Future<int> append({
    required String type,
    required double amount,
    String? orderId,
    String currency = 'PLN',
    String? referenceId,
  }) async {
    return await _db.into(_db.financialLedger).insert(
      FinancialLedgerCompanion.insert(
        tenantId: Value(tenantId),
        type: type,
        amount: amount,
        orderId: Value(orderId),
        currency: Value(currency),
        referenceId: Value(referenceId),
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Current balance for the tenant (sum of all amounts). Positive = available capital.
  Future<double> getBalance() async {
    final rows = await (_db.select(_db.financialLedger)
          ..where((t) => t.tenantId.equals(tenantId)))
        .get();
    return rows.fold<double>(0, (s, r) => s + r.amount);
  }

  /// Entries for a given order (for diagnostics).
  Future<List<FinancialLedgerRow>> getEntriesByOrderId(String orderId) async {
    return await (_db.select(_db.financialLedger)
          ..where((t) => t.tenantId.equals(tenantId) & t.orderId.equals(orderId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Recent ledger entries (newest first), e.g. for activity list on Capital screen.
  Future<List<FinancialLedgerRow>> getRecentEntries({int limit = 30}) async {
    return await (_db.select(_db.financialLedger)
          ..where((t) => t.tenantId.equals(tenantId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }
}
