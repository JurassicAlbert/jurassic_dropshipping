import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/features/auth/auth_gate.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  static const int _railBreakpoint = 600;

  static const _routes = [
    '/dashboard',
    '/analytics',
    '/products',
    '/orders',
    '/suppliers',
    '/marketplaces',
    '/returns',
    '/approval',
    '/decision-log',
    '/settings',
  ];

  static const _labels = [
    'Dashboard',
    'Analytics',
    'Products',
    'Orders',
    'Suppliers',
    'Marketplaces',
    'Returns',
    'Approval Queue',
    'Decision Log',
    'Settings',
  ];

  static const _icons = [
    Icons.dashboard,
    Icons.analytics,
    Icons.inventory_2,
    Icons.shopping_cart,
    Icons.store,
    Icons.public,
    Icons.assignment_return,
    Icons.pending_actions,
    Icons.list_alt,
    Icons.settings,
  ];

  String _pageTitle(String path) {
    final idx = _routes.indexOf(path);
    if (idx >= 0) return _labels[idx];
    return 'Jurassic Dropshipping';
  }

  Widget _buildNavItems(BuildContext context) {
    final current = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);

    Widget sectionHeader(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Text(
          title,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );
    }

    Widget navTile(int index) {
      return ListTile(
        leading: Icon(_icons[index]),
        title: Text(_labels[index]),
        selected: current == _routes[index],
        onTap: () {
          context.go(_routes[index]);
          Navigator.of(context).pop();
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader('MAIN'),
        for (var i = 0; i < 4; i++) navTile(i),
        const Divider(indent: 16, endIndent: 16),
        sectionHeader('OPERATIONS'),
        for (var i = 4; i < 7; i++) navTile(i),
        const Divider(indent: 16, endIndent: 16),
        sectionHeader('ADMIN'),
        for (var i = 7; i < 10; i++) navTile(i),
      ],
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
    final useRail = width >= _railBreakpoint;
    final currentPath = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle(currentPath)),
        leading: useRail
            ? null
            : Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock_outline),
            tooltip: 'Lock app',
            onPressed: () => _lockApp(context, ref),
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
                      color: theme.colorScheme.primaryContainer,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          size: 36,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Jurassic Dropshipping',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildNavItems(context),
                ],
              ),
            ),
      body: useRail
          ? Row(
              children: [
                NavigationRail(
                  extended: width >= 800,
                  destinations: [
                    for (var i = 0; i < _routes.length; i++)
                      NavigationRailDestination(
                        icon: Icon(_icons[i]),
                        label: Text(_labels[i]),
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
    );
  }

  int _selectedIndex(String path) {
    final i = _routes.indexOf(path);
    return i >= 0 ? i : 0;
  }
}
