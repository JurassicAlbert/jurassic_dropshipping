import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/database/app_database.dart';
import 'package:jurassic_dropshipping/data/models/listing.dart';
import 'package:jurassic_dropshipping/data/models/order.dart';
import 'package:jurassic_dropshipping/features/dashboard/dashboard_screen.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_secure_storage.dart';

void main() {
  group('DashboardScreen', () {
    late AppDatabase db;

    setUp(() {
      Fixtures.reset();
      db = AppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() => db.close());

    List<Override> baseOverrides(AppDatabase db,
        {List<Listing> listings = const [],
        List<Order> orders = const []}) {
      return [
        dbProvider.overrideWithValue(db),
        secureStorageProvider.overrideWithValue(MockSecureStorage()),
        listingsProvider.overrideWith((_) async => listings),
        ordersProvider.overrideWith((_) async => orders),
        rulesProvider.overrideWith((_) async => Fixtures.defaultRules),
      ];
    }

    testWidgets('shows Dashboard title', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        ProviderScope(
          overrides: baseOverrides(db),
          child: const MaterialApp(home: Scaffold(body: DashboardScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('shows listing counts when data loaded', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      final listings = [
        Fixtures.listing(status: ListingStatus.active),
        Fixtures.listing(status: ListingStatus.active),
        Fixtures.listing(status: ListingStatus.pendingApproval),
      ];
      await tester.pumpWidget(
        ProviderScope(
          overrides: baseOverrides(db, listings: listings),
          child: const MaterialApp(home: Scaffold(body: DashboardScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('Active: 2'), findsOneWidget);
      expect(find.text('Pending approval: 1'), findsOneWidget);
    });

    testWidgets('shows order summary when data loaded', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      final orders = [
        Fixtures.order(sellingPrice: 100.0, sourceCost: 60.0),
        Fixtures.order(sellingPrice: 50.0, sourceCost: 25.0),
      ];
      await tester.pumpWidget(
        ProviderScope(
          overrides: baseOverrides(db, orders: orders),
          child: const MaterialApp(home: Scaffold(body: DashboardScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('Total sales: 150.00 PLN'), findsOneWidget);
      expect(find.text('Est. profit: 65.00 PLN'), findsOneWidget);
    });

    testWidgets('shows no order data message in chart', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
      await tester.pumpWidget(
        ProviderScope(
          overrides: baseOverrides(db),
          child: const MaterialApp(home: Scaffold(body: DashboardScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('No order data yet.'), findsOneWidget);
    });
  });
}
