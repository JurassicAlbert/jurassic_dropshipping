import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/return_request.dart';
import 'package:jurassic_dropshipping/features/returns/returns_screen.dart';
import '../fixtures/test_fixtures.dart';

void main() {
  group('ReturnsScreen', () {
    testWidgets('shows empty message when no returns', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            returnRequestsProvider
                .overrideWith((_) async => <ReturnRequest>[]),
          ],
          child: const MaterialApp(home: Scaffold(body: ReturnsScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('No return requests yet.'), findsOneWidget);
    });

    testWidgets('shows return cards when data present', (tester) async {
      final returns = [
        Fixtures.returnRequest(
            orderId: 'order_ABC', reason: ReturnReason.noReason),
      ];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            returnRequestsProvider.overrideWith((_) async => returns),
          ],
          child: const MaterialApp(home: Scaffold(body: ReturnsScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('Order: order_ABC'), findsOneWidget);
    });
  });
}
