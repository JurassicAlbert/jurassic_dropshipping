import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/app_router.dart';
import 'package:jurassic_dropshipping/features/auth/auth_gate.dart';
import 'package:jurassic_dropshipping/l10n/app_localizations.dart';

void main() async {
  // Log a hint when Flutter web engine throws null from JS (no stack trace).
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    final e = details.exception;
    if (kIsWeb && e.toString().contains('null')) {
      debugPrint(
        'Tip: If the app failed to load, try refreshing, or run with: '
        'flutter run -d chrome --web-renderer html',
      );
    }
  };

  // Run app in a zone so we can catch uncaught async errors. Binding and runApp
  // must run in the same zone to avoid "Zone mismatch" (ensureInitialized inside zone).
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _init();
    runApp(
      const ProviderScope(
        child: JurassicDropshippingApp(),
      ),
    );
  }, (Object error, StackTrace? stack) {
    _reportError(error, stack);
  });
}

Future<void> _init() async {
  try {
    await Hive.initFlutter();
  } catch (e, _) {
    if (kIsWeb) {
      // On web, Hive may fail (e.g. private browsing, storage disabled). Continue without Hive.
      debugPrint('Hive.initFlutter failed (web): $e');
      debugPrint('Auth/automation persistence may be limited.');
    } else {
      rethrow;
    }
  }
}

void _reportError(Object error, StackTrace? stack) {
  debugPrint('Uncaught error: $error');
  if (stack != null) debugPrint(stack.toString());
  // Flutter web engine sometimes throws null from JS with no stack; show a recognizable message.
  final isOpaqueNull = error.toString() == 'null' || (error is Error && error.toString().contains('null'));
  if (kIsWeb && isOpaqueNull) {
    debugPrint(
      'This may be a known Flutter web engine issue. Try: refresh the page, use Chrome/Edge, '
      'or run with: flutter run -d chrome --web-renderer html',
    );
  }
}

ThemeData _buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1565C0),
    brightness: Brightness.light,
  );
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: colorScheme.surface,
    textTheme: _buildTextTheme(Typography.material2021().black),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.surfaceContainerLow,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.08),
      margin: const EdgeInsets.all(0),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: colorScheme.surfaceContainerLow,
      indicatorColor: colorScheme.primaryContainer,
      selectedIconTheme: IconThemeData(color: colorScheme.onPrimaryContainer),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      labelType: NavigationRailLabelType.all,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      iconColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    ),
    dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    titleLarge: base.titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: (base.titleLarge?.fontSize ?? 22) + 1,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: (base.titleMedium?.fontSize ?? 16) + 1,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontSize: (base.bodyLarge?.fontSize ?? 14) + 0.5,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontSize: (base.bodyMedium?.fontSize ?? 13) + 0.5,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: (base.labelLarge?.fontSize ?? 14) + 0.5,
    ),
  );
}

ThemeData _buildDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1565C0),
    brightness: Brightness.dark,
  );
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: colorScheme.surface,
    textTheme: _buildTextTheme(Typography.material2021().white),
    cardTheme: CardThemeData(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.surfaceContainerLow,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.22),
      margin: const EdgeInsets.all(0),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: colorScheme.surfaceContainerLow,
      indicatorColor: colorScheme.primaryContainer,
      selectedIconTheme: IconThemeData(color: colorScheme.onPrimaryContainer),
      unselectedIconTheme: IconThemeData(color: colorScheme.onSurfaceVariant),
      labelType: NavigationRailLabelType.all,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      iconColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
    ),
    dividerTheme: DividerThemeData(color: colorScheme.outlineVariant, thickness: 1, space: 1),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
    ),
  );
}

class JurassicDropshippingApp extends ConsumerWidget {
  const JurassicDropshippingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(localeProvider);
    final locale = localeAsync.valueOrNull ?? AppLocalizations.defaultLocale;
    return MaterialApp.router(
      title: 'Jurasic Dropshipping',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: goRouter,
      builder: (context, child) => AuthGate(
        child: AutomationStarter(child: child ?? const SizedBox()),
      ),
    );
  }
}

/// Starts scan, order sync, price/product refresh automatically when the app loads.
class AutomationStarter extends ConsumerStatefulWidget {
  const AutomationStarter({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AutomationStarter> createState() => _AutomationStarterState();
}

class _AutomationStarterState extends ConsumerState<AutomationStarter> {
  static bool _didStart = false;

  @override
  Widget build(BuildContext context) {
    if (!_didStart) {
      _didStart = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(automationSchedulerProvider).startAll();
      });
    }
    return widget.child;
  }
}
