import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/main.dart';
import 'package:jurassic_dropshipping/services/auth_service.dart';

class _UnlockedAuthService extends AuthService {
  @override
  Future<bool> get isPasswordSet async => true;

  @override
  Future<bool> get isLocked async => false;
}

class _LockedAuthService extends AuthService {
  @override
  Future<bool> get isPasswordSet async => false;

  @override
  Future<bool> get isLocked async => true;
}

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('hive_test_');
    Hive.init(tempDir.path);
  });

  tearDown(() async {
    await Hive.close();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  testWidgets('App renders login screen when locked', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(_LockedAuthService()),
          ],
          child: const JurassicDropshippingApp(),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pump();
    expect(find.text('Jurassic Dropshipping'), findsWidgets);
    expect(find.text('Set Password'), findsOneWidget);
  });

  testWidgets('App renders dashboard when unlocked', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(_UnlockedAuthService()),
          ],
          child: const JurassicDropshippingApp(),
        ),
      );
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pump();
    expect(find.text('Dashboard'), findsWidgets);
  });
}
