import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/features/approval/approval_screen.dart';
import 'package:jurassic_dropshipping/features/dashboard/dashboard_screen.dart';
import 'package:jurassic_dropshipping/features/decision_log/decision_log_screen.dart';
import 'package:jurassic_dropshipping/features/orders/orders_screen.dart';
import 'package:jurassic_dropshipping/features/products/products_screen.dart';
import 'package:jurassic_dropshipping/features/settings/settings_screen.dart';
import 'package:jurassic_dropshipping/features/shell/shell_screen.dart';
import 'package:jurassic_dropshipping/features/suppliers/suppliers_screen.dart';
import 'package:jurassic_dropshipping/features/marketplaces/marketplaces_screen.dart';
import 'package:jurassic_dropshipping/features/returns/returns_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
        GoRoute(path: '/products', builder: (context, state) => const ProductsScreen()),
        GoRoute(path: '/orders', builder: (context, state) => const OrdersScreen()),
        GoRoute(path: '/suppliers', builder: (context, state) => const SuppliersScreen()),
        GoRoute(path: '/marketplaces', builder: (context, state) => const MarketplacesScreen()),
        GoRoute(path: '/returns', builder: (context, state) => const ReturnsScreen()),
        GoRoute(path: '/approval', builder: (context, state) => const ApprovalScreen()),
        GoRoute(path: '/decision-log', builder: (context, state) => const DecisionLogScreen()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      ],
    ),
  ],
);
