import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jurassic Dropshipping'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(title: const Text('Dashboard'), leading: const Icon(Icons.dashboard), onTap: () => context.go('/dashboard')),
            ListTile(title: const Text('Products'), leading: const Icon(Icons.inventory_2), onTap: () => context.go('/products')),
            ListTile(title: const Text('Orders'), leading: const Icon(Icons.shopping_cart), onTap: () => context.go('/orders')),
            ListTile(title: const Text('Approval queue'), leading: const Icon(Icons.pending_actions), onTap: () => context.go('/approval')),
            ListTile(title: const Text('Decision log'), leading: const Icon(Icons.list_alt), onTap: () => context.go('/decision-log')),
            ListTile(title: const Text('Settings'), leading: const Icon(Icons.settings), onTap: () => context.go('/settings')),
          ],
        ),
      ),
      body: child,
    );
  }
}
