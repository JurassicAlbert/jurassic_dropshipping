import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/rules_repository.dart';
import 'package:jurassic_dropshipping/services/order_sync_service.dart';

import '../fixtures/test_database.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_target_platform.dart';

class MockTargetWithOrders extends MockTargetPlatform {
  MockTargetWithOrders({required this.mockOrders, super.mockId});
  final List<Order> mockOrders;

  @override
  Future<List<Order>> getOrders(DateTime since) async => mockOrders;
}

class _ThrowingTarget extends MockTargetPlatform {
  _ThrowingTarget({super.mockId});

  @override
  Future<List<Order>> getOrders(DateTime since) async {
    throw Exception('Target platform error');
  }
}

void main() {
  late AppDatabase db;
  late OrderRepository orderRepo;
  late RulesRepository rulesRepo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    orderRepo = OrderRepository(db);
    rulesRepo = RulesRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('OrderSyncService', () {
    test('syncOrders: inserts new orders from target', () async {
      await rulesRepo.save(Fixtures.defaultRules);

      final mockOrders = [
        Fixtures.order(id: 'new_order_1', targetPlatformId: 'mock_target'),
        Fixtures.order(id: 'new_order_2', targetPlatformId: 'mock_target'),
      ];

      final target = MockTargetWithOrders(
        mockId: 'mock_target',
        mockOrders: mockOrders,
      );

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [target],
      );

      await service.syncOrders(DateTime.now().subtract(const Duration(days: 1)));

      final all = await orderRepo.getAll();
      expect(all.length, 2);
    });

    test('syncOrders: skips existing orders (no duplicates)', () async {
      await rulesRepo.save(Fixtures.defaultRules);

      final existingOrder = Fixtures.order(
        id: 'existing_order',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(existingOrder);

      final mockOrders = [
        Fixtures.order(id: 'existing_order', targetPlatformId: 'mock_target'),
        Fixtures.order(id: 'brand_new_order', targetPlatformId: 'mock_target'),
      ];

      final target = MockTargetWithOrders(
        mockId: 'mock_target',
        mockOrders: mockOrders,
      );

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [target],
      );

      final added = await service.syncOrders(
        DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(added, 1);
      final all = await orderRepo.getAll();
      expect(all.length, 2);
    });

    test('syncOrders: sets pendingApproval status when manualApprovalOrders is true', () async {
      await rulesRepo.save(Fixtures.defaultRules.copyWith(manualApprovalOrders: true));

      final mockOrders = [
        Fixtures.order(id: 'approval_order', targetPlatformId: 'mock_target'),
      ];

      final target = MockTargetWithOrders(
        mockId: 'mock_target',
        mockOrders: mockOrders,
      );

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [target],
      );

      await service.syncOrders(DateTime.now().subtract(const Duration(days: 1)));

      final inserted = await orderRepo.getByLocalId('approval_order');
      expect(inserted, isNotNull);
      expect(inserted!.status, OrderStatus.pendingApproval);
    });

    test('syncOrders: sets pending status when manualApprovalOrders is false', () async {
      await rulesRepo.save(Fixtures.defaultRules.copyWith(manualApprovalOrders: false));

      final mockOrders = [
        Fixtures.order(id: 'auto_order', targetPlatformId: 'mock_target'),
      ];

      final target = MockTargetWithOrders(
        mockId: 'mock_target',
        mockOrders: mockOrders,
      );

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [target],
      );

      await service.syncOrders(DateTime.now().subtract(const Duration(days: 1)));

      final inserted = await orderRepo.getByLocalId('auto_order');
      expect(inserted, isNotNull);
      expect(inserted!.status, OrderStatus.pending);
    });

    test('syncOrders: returns count of added orders', () async {
      await rulesRepo.save(Fixtures.defaultRules);

      final mockOrders = [
        Fixtures.order(id: 'count_1', targetPlatformId: 'mock_target'),
        Fixtures.order(id: 'count_2', targetPlatformId: 'mock_target'),
        Fixtures.order(id: 'count_3', targetPlatformId: 'mock_target'),
      ];

      final target = MockTargetWithOrders(
        mockId: 'mock_target',
        mockOrders: mockOrders,
      );

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [target],
      );

      final added = await service.syncOrders(
        DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(added, 3);
    });

    test('syncOrders: handles target exception gracefully', () async {
      await rulesRepo.save(Fixtures.defaultRules);

      final throwingTarget = _ThrowingTarget(mockId: 'bad_target');

      final service = OrderSyncService(
        orderRepository: orderRepo,
        rulesRepository: rulesRepo,
        targets: [throwingTarget],
      );

      final added = await service.syncOrders(
        DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(added, 0);
      final all = await orderRepo.getAll();
      expect(all, isEmpty);
    });
  });
}
