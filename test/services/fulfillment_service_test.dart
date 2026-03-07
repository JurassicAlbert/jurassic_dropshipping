import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/data/repositories/listing_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/order_repository.dart';
import 'package:jurassic_dropshipping/data/repositories/product_repository.dart';
import 'package:jurassic_dropshipping/domain/platforms.dart';
import 'package:jurassic_dropshipping/services/fulfillment_service.dart';

import '../fixtures/test_database.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_source_platform.dart';
import '../mocks/mock_target_platform.dart';

class _TrackingSourcePlatform extends MockSourcePlatform {
  _TrackingSourcePlatform({required this.trackingNumber, super.products, super.mockId});
  final String trackingNumber;

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    return SourceOrderResult(
      sourceOrderId: 'mock_order_${request.productId}',
      trackingNumber: trackingNumber,
    );
  }
}

class _ThrowingSourcePlatform extends MockSourcePlatform {
  _ThrowingSourcePlatform({super.mockId});

  @override
  Future<SourceOrderResult> placeOrder(PlaceOrderRequest request) async {
    throw Exception('Source platform error');
  }
}

void main() {
  late AppDatabase db;
  late OrderRepository orderRepo;
  late ListingRepository listingRepo;
  late ProductRepository productRepo;

  setUp(() {
    Fixtures.reset();
    db = createTestDatabase();
    orderRepo = OrderRepository(db);
    listingRepo = ListingRepository(db);
    productRepo = ProductRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('FulfillmentService', () {
    test('fulfillOrder: successfully places source order, updates status to sourceOrderPlaced', () async {
      final product = Fixtures.product(
        id: 'prod_1',
        sourcePlatformId: 'mock_source',
      );
      await productRepo.upsert(product);

      final listing = Fixtures.listing(
        id: 'listing_1',
        productId: 'prod_1',
        targetPlatformId: 'mock_target',
      );
      await listingRepo.insert(listing);

      final order = Fixtures.order(
        id: 'order_1',
        listingId: 'listing_1',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(order);

      final mockSource = MockSourcePlatform(
        mockId: 'mock_source',
        products: [product],
      );
      final mockTarget = MockTargetPlatform(mockId: 'mock_target');

      final service = FulfillmentService(
        orderRepository: orderRepo,
        listingRepository: listingRepo,
        productRepository: productRepo,
        sources: [mockSource],
        targets: [mockTarget],
      );

      await service.fulfillOrder(order);

      final updated = await orderRepo.getByLocalId('order_1');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.sourceOrderPlaced);
      expect(updated.sourceOrderId, 'mock_order_prod_1');
    });

    test('fulfillOrder: updates tracking when source returns tracking number', () async {
      final product = Fixtures.product(
        id: 'prod_1',
        sourcePlatformId: 'mock_source',
      );
      await productRepo.upsert(product);

      final listing = Fixtures.listing(
        id: 'listing_1',
        productId: 'prod_1',
        targetPlatformId: 'mock_target',
      );
      await listingRepo.insert(listing);

      final order = Fixtures.order(
        id: 'order_1',
        listingId: 'listing_1',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(order);

      final trackingSource = _TrackingSourcePlatform(
        mockId: 'mock_source',
        trackingNumber: 'TRACK123',
        products: [product],
      );
      final mockTarget = MockTargetPlatform(mockId: 'mock_target');

      final service = FulfillmentService(
        orderRepository: orderRepo,
        listingRepository: listingRepo,
        productRepository: productRepo,
        sources: [trackingSource],
        targets: [mockTarget],
      );

      await service.fulfillOrder(order);

      final updated = await orderRepo.getByLocalId('order_1');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.shipped);
      expect(updated.trackingNumber, 'TRACK123');
      expect(mockTarget.lastTrackingOrderId, order.targetOrderId);
      expect(mockTarget.lastTrackingNumber, 'TRACK123');
    });

    test('fulfillOrder: sets failed status when listing not found', () async {
      final order = Fixtures.order(
        id: 'order_1',
        listingId: 'nonexistent_listing',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(order);

      final service = FulfillmentService(
        orderRepository: orderRepo,
        listingRepository: listingRepo,
        productRepository: productRepo,
        sources: [MockSourcePlatform(mockId: 'mock_source')],
        targets: [MockTargetPlatform(mockId: 'mock_target')],
      );

      await service.fulfillOrder(order);

      final updated = await orderRepo.getByLocalId('order_1');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.failed);
    });

    test('fulfillOrder: sets failed status when product not found', () async {
      final listing = Fixtures.listing(
        id: 'listing_1',
        productId: 'nonexistent_product',
        targetPlatformId: 'mock_target',
      );
      await listingRepo.insert(listing);

      final order = Fixtures.order(
        id: 'order_1',
        listingId: 'listing_1',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(order);

      final service = FulfillmentService(
        orderRepository: orderRepo,
        listingRepository: listingRepo,
        productRepository: productRepo,
        sources: [MockSourcePlatform(mockId: 'mock_source')],
        targets: [MockTargetPlatform(mockId: 'mock_target')],
      );

      await service.fulfillOrder(order);

      final updated = await orderRepo.getByLocalId('order_1');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.failed);
    });

    test('fulfillOrder: sets failed status when source platform throws', () async {
      final product = Fixtures.product(
        id: 'prod_1',
        sourcePlatformId: 'mock_source',
      );
      await productRepo.upsert(product);

      final listing = Fixtures.listing(
        id: 'listing_1',
        productId: 'prod_1',
        targetPlatformId: 'mock_target',
      );
      await listingRepo.insert(listing);

      final order = Fixtures.order(
        id: 'order_1',
        listingId: 'listing_1',
        targetPlatformId: 'mock_target',
        status: OrderStatus.pending,
      );
      await orderRepo.insert(order);

      final throwingSource = _ThrowingSourcePlatform(mockId: 'mock_source');
      final mockTarget = MockTargetPlatform(mockId: 'mock_target');

      final service = FulfillmentService(
        orderRepository: orderRepo,
        listingRepository: listingRepo,
        productRepository: productRepo,
        sources: [throwingSource],
        targets: [mockTarget],
      );

      await service.fulfillOrder(order);

      final updated = await orderRepo.getByLocalId('order_1');
      expect(updated, isNotNull);
      expect(updated!.status, OrderStatus.failed);
    });
  });
}
