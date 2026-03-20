import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/auth/auth_gate.dart';
import 'package:jurassic_dropshipping/features/shared/command_palette_overlay.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  static const int _railBreakpoint = 600;

  static const _routes = [
    '/dashboard',
    '/analytics',
    '/profit-dashboard',
    '/products',
    '/orders',
    '/suppliers',
    '/marketplaces',
    '/returns',
    '/incidents',
    '/risk-dashboard',
    '/returned-stock',
    '/capital',
    '/approval',
    '/decision-log',
    '/return-policies',
    '/settings',
    '/how-it-works',
  ];

  /// Nav labels come from [appLocalizationsProvider] (localized).
  static List<String> _labels(WidgetRef ref) =>
      ref.watch(appLocalizationsProvider).navLabels;

  static const _icons = [
    Icons.dashboard,
    Icons.analytics,
    Icons.trending_up,
    Icons.inventory_2,
    Icons.shopping_cart,
    Icons.store,
    Icons.public,
    Icons.assignment_return,
    Icons.warning_amber,
    Icons.warning_amber_rounded,
    Icons.inventory,
    Icons.account_balance,
    Icons.pending_actions,
    Icons.list_alt,
    Icons.policy,
    Icons.settings,
    Icons.help_outline,
  ];

  String _pageTitle(WidgetRef ref, String path) {
    final idx = _routes.indexOf(path);
    final l10n = ref.watch(appLocalizationsProvider);
    if (idx >= 0) return l10n.navLabelAt(idx);
    return l10n.appTitle;
  }

  Widget _buildNavItems(BuildContext context, WidgetRef ref) {
    final current = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);

    Widget sectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
        child: Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      );
    }

    final labels = _labels(ref);
    Widget navTile(int index) {
      final tooltip = index < ScreenHelpTexts.navTooltips.length
          ? ScreenHelpTexts.navTooltips[index]
          : labels[index];
      final selected = current == _routes[index];
      return Tooltip(
        message: tooltip,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          child: ListTile(
            leading: Icon(_icons[index]),
            title: Text(labels[index]),
            selected: selected,
            selectedTileColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.55),
            selectedColor: theme.colorScheme.onPrimaryContainer,
            onTap: () {
              context.go(_routes[index]);
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('MAIN'),
        for (var i = 0; i < 5; i++) navTile(i),
        const Divider(indent: 16, endIndent: 16),
        sectionHeader('OPERATIONS'),
        for (var i = 5; i < 12; i++) navTile(i),
        const Divider(indent: 16, endIndent: 16),
        sectionHeader('ADMIN'),
        for (var i = 12; i < 17; i++) navTile(i),
        const SizedBox(height: 12),
      ],
    );
  }

  /// Opens the "Jump to order by ID" dialog. Exposed for command palette.
  static void showJumpToOrderDialog(BuildContext context, WidgetRef ref) {
    final l10n = ref.read(appLocalizationsProvider);
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.jumpToOrder),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.orderId,
            hintText: l10n.orderIdHint,
            border: const OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            final id = value.trim();
            if (id.isNotEmpty) {
              Navigator.of(ctx).pop();
              context.go('/orders?orderId=${Uri.encodeComponent(id)}');
            }
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () {
              final id = controller.text.trim();
              if (id.isNotEmpty) {
                Navigator.of(ctx).pop();
                context.go('/orders?orderId=${Uri.encodeComponent(id)}');
              }
            },
            child: Text(l10n.go),
          ),
        ],
      ),
    );
  }

  Future<void> _lockApp(BuildContext context, WidgetRef ref) async {
    final auth = ref.read(authServiceProvider);
    await auth.lock();
    if (context.mounted) {
      final gate = context.findAncestorStateOfType<AuthGateState>();
      gate?.lockOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final useRail = width >= _railBreakpoint && height >= 640;
    final currentPath = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);
    final rulesAsync = ref.watch(rulesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle(ref, currentPath)),
        leading: useRail
            ? null
            : Builder(
                builder: (ctx) => Tooltip(
                  message: ref.watch(appLocalizationsProvider).openNav,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
              ),
        actions: [
          rulesAsync.when(
            data: (rules) {
              final readOnly = rules.targetsReadOnly;
              final bg = readOnly ? Colors.orange.shade100 : Colors.green.shade100;
              final fg = readOnly ? Colors.orange.shade800 : Colors.green.shade800;
              final l10n = ref.watch(appLocalizationsProvider);
              final label = readOnly ? l10n.readOnlyLabel : l10n.liveWritesLabel;
              return Tooltip(
                message: readOnly ? l10n.readOnlyTooltip : l10n.liveWritesTooltip,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          readOnly ? Icons.visibility_off : Icons.play_circle_outline,
                          size: 16,
                          color: fg,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          label,
                          style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          Tooltip(
            message: ref.watch(appLocalizationsProvider).searchTooltip,
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showCommandPalette(context, ref),
            ),
          ),
          Tooltip(
            message: ref.watch(appLocalizationsProvider).helpTooltip,
            child: IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () => showCommandPalette(context, ref),
            ),
          ),
          Tooltip(
            message: ref.watch(appLocalizationsProvider).jumpToOrderTooltip,
            child: IconButton(
              icon: const Icon(Icons.pin_drop_outlined),
              onPressed: () => showJumpToOrderDialog(context, ref),
            ),
          ),
          Tooltip(
            message: 'Lock the app; you will need to re-enter the password to continue',
            child: IconButton(
              icon: const Icon(Icons.lock_outline),
              onPressed: () => _lockApp(context, ref),
            ),
          ),
        ],
      ),
      drawer: useRail
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: 36,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jurassic Dropshipping',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Admin panel',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildNavItems(context, ref),
                ],
              ),
            ),
      body: Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
              const _OpenCommandPaletteIntent(),
        },
        child: Actions(
          actions: {
            _OpenCommandPaletteIntent: CallbackAction<_OpenCommandPaletteIntent>(
              onInvoke: (_) {
                showCommandPalette(context, ref);
                return null;
              },
            ),
          },
          child: useRail
              ? Row(
                  children: [
                    NavigationRail(
                      extended: width >= 800,
                      destinations: [
                        for (var i = 0; i < _routes.length; i++)
                          NavigationRailDestination(
                            icon: Icon(_icons[i]),
                            label: Text(_labels(ref)[i]),
                          ),
                      ],
                      selectedIndex: _selectedIndex(currentPath),
                      onDestinationSelected: (i) => context.go(_routes[i]),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: child),
                  ],
                )
              : child,
        ),
      ),
    );
  }

  int _selectedIndex(String path) {
    final i = _routes.indexOf(path);
    return i >= 0 ? i : 0;
  }
}

class _OpenCommandPaletteIntent extends Intent {
  const _OpenCommandPaletteIntent();
}
