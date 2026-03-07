import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/settings/settings_screen.dart';
import '../fixtures/test_fixtures.dart';
import '../mocks/mock_secure_storage.dart';

void main() {
  group('SettingsScreen', () {
    testWidgets('shows all section headers', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(MockSecureStorage()),
            rulesProvider.overrideWith((_) async => Fixtures.defaultRules),
          ],
          child: const MaterialApp(home: Scaffold(body: SettingsScreen())),
        ),
      );
      await tester.pump();
      expect(find.text('Rules'), findsOneWidget);
      expect(find.text('CJ Dropshipping'), findsOneWidget);
    });

    testWidgets('loads rules into text fields', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageProvider.overrideWithValue(MockSecureStorage()),
            rulesProvider.overrideWith((_) async => Fixtures.defaultRules),
          ],
          child: const MaterialApp(home: Scaffold(body: SettingsScreen())),
        ),
      );
      await tester.pump();
      final minProfitField = find.widgetWithText(TextField, '25.0');
      expect(minProfitField, findsOneWidget);
    });
  });
}
