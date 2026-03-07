import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jurassic_dropshipping/main.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: JurassicDropshippingApp()),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Jurassic Dropshipping'), findsWidgets);
  });
}
