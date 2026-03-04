import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  static const int _railBreakpoint = 600;

  Widget _buildNavItems(BuildContext context) {
    final current = GoRouterState.of(context).uri.path;
    final navItems = [
      (route: '/dashboard', label: 'Dashboard', icon: Icons.dashboard),
      (route: '/products', label: 'Products', icon: Icons.inventory_2),
      (route: '/orders', label: 'Orders', icon: Icons.shopping_cart),
      (route: '/approval', label: 'Approval queue', icon: Icons.pending_actions),
      (route: '/decision-log', label: 'Decision log', icon: Icons.list_alt),
      (route: '/settings', label: 'Settings', icon: Icons.settings),
    ];
    return Column(
      children: [
        for (final item in navItems)
          ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
            selected: current == item.route,
            onTap: () => context.go(item.route),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final useRail = width >= _railBreakpoint;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jurassic Dropshipping'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: useRail ? null : Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
      ),
      drawer: useRail ? null : Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
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
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(icon: Icon(Icons.inventory_2), label: Text('Products')),
                    NavigationRailDestination(icon: Icon(Icons.shopping_cart), label: Text('Orders')),
                    NavigationRailDestination(icon: Icon(Icons.pending_actions), label: Text('Approval')),
                    NavigationRailDestination(icon: Icon(Icons.list_alt), label: Text('Decision log')),
                    NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
                  ],
                  selectedIndex: _selectedIndex(GoRouterState.of(context).uri.path),
                  onDestinationSelected: (i) => context.go(_routeAt(i)),
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            )
          : child,
    );
  }

  int _selectedIndex(String path) {
    final routes = ['/dashboard', '/products', '/orders', '/approval', '/decision-log', '/settings'];
    final i = routes.indexOf(path);
    return i >= 0 ? i : 0;
  }

  String _routeAt(int index) {
    return ['/dashboard', '/products', '/orders', '/approval', '/decision-log', '/settings'][index];
  }
}
