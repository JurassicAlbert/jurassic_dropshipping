import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/decision_log.dart';
import 'package:jurassic_dropshipping/data/models/marketplace_account.dart';
import 'package:jurassic_dropshipping/data/repositories/decision_log_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/financial_ledger_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/incident_record_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/marketplace_account_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/returned_stock_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/supplier_return_policy_repository.dart';
import 'package:jurassic_dropshipping/domain/post_order/incident_record.dart';
import 'package:jurassic_dropshipping/domain/post_order/returned_stock.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';

import '../../fixtures/test_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  test('MarketplaceAccountRepository supports upsert and getAll', () async {
    final repo = MarketplaceAccountRepository(db);
    await repo.upsert(
      const MarketplaceAccount(
        id: 'acc_1',
        platformId: 'allegro',
        displayName: 'Allegro Main',
        isActive: true,
      ),
    );
    await repo.upsert(
      const MarketplaceAccount(
        id: 'acc_1',
        platformId: 'allegro',
        displayName: 'Allegro Main Updated',
        isActive: true,
      ),
    );
    final all = await repo.getAll();
    expect(all, hasLength(1));
    expect(all.first.displayName, 'Allegro Main Updated');
  });

  test('IncidentRecordRepository insert and getByStatus', () async {
    final repo = IncidentRecordRepository(db);
    await repo.insert(
      IncidentRecord(
        id: 0,
        orderId: 'ord_1',
        incidentType: IncidentType.damageClaim,
        status: IncidentStatus.open,
        createdAt: DateTime.now(),
      ),
    );
    final open = await repo.getByStatus(IncidentStatus.open);
    expect(open, hasLength(1));
    expect(open.first.orderId, 'ord_1');
  });

  test('ReturnedStockRepository consumeForFulfillment decrements FIFO', () async {
    final repo = ReturnedStockRepository(db);
    await repo.insert(
      ReturnedStock(
        id: 0,
        productId: 'prod_1',
        supplierId: 'sup_1',
        quantity: 2,
        createdAt: DateTime(2025, 1, 1),
      ),
    );
    await repo.insert(
      ReturnedStock(
        id: 0,
        productId: 'prod_1',
        supplierId: 'sup_1',
        quantity: 5,
        createdAt: DateTime(2025, 1, 2),
      ),
    );
    final consumed = await repo.consumeForFulfillment('prod_1', 6, supplierId: 'sup_1');
    expect(consumed, isTrue);
    final available = await repo.getAvailableQuantity('prod_1', supplierId: 'sup_1');
    expect(available, 1);
  });

  test('SupplierReturnPolicyRepository upsert persists by supplier', () async {
    final repo = SupplierReturnPolicyRepository(db);
    await repo.upsert(
      const SupplierReturnPolicy(
        id: 0,
        supplierId: 'sup_1',
        policyType: SupplierReturnPolicyType.returnWindow,
        returnWindowDays: 14,
        requiresRma: true,
      ),
    );
    await repo.upsert(
      const SupplierReturnPolicy(
        id: 0,
        supplierId: 'sup_1',
        policyType: SupplierReturnPolicyType.fullReturns,
        returnWindowDays: 30,
        requiresRma: false,
      ),
    );
    final policy = await repo.getBySupplierId('sup_1');
    expect(policy, isNotNull);
    expect(policy!.returnWindowDays, 30);
    expect(policy.policyType, SupplierReturnPolicyType.fullReturns);
  });

  test('DecisionLog and ledger repositories expose diagnostics data', () async {
    final logs = DecisionLogRepository(db);
    final ledger = FinancialLedgerRepository(db);
    await logs.insert(
      DecisionLog(
        id: 'log_1',
        type: DecisionLogType.incident,
        entityId: 'ord_1',
        reason: 'auto_refund_threshold',
        createdAt: DateTime.now(),
      ),
    );
    await ledger.append(type: LedgerEntryType.adjustment.name, amount: 50, orderId: 'ord_1');
    await ledger.append(type: LedgerEntryType.loss.name, amount: -5, orderId: 'ord_1');

    final entries = await ledger.getEntriesByOrderId('ord_1');
    final total = await ledger.getBalance();
    final allLogs = await logs.getAll();

    expect(entries.length, 2);
    expect(total, 45);
    expect(allLogs.length, 1);
  });
}

