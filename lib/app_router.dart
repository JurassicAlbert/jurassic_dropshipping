import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/features/approval/approval_screen.dart';
import 'package:jurassic_dropshipping/features/dashboard/dashboard_screen.dart';
import 'package:jurassic_dropshipping/features/decision_log/decision_log_screen.dart';
import 'package:jurassic_dropshipping/features/orders/orders_screen.dart';
import 'package:jurassic_dropshipping/features/products/products_screen.dart';
import 'package:jurassic_dropshipping/features/settings/settings_screen.dart';
import 'package:jurassic_dropshipping/features/analytics/analytics_screen.dart';
import 'package:jurassic_dropshipping/features/shell/shell_screen.dart';
import 'package:jurassic_dropshipping/features/suppliers/suppliers_screen.dart';
import 'package:jurassic_dropshipping/features/marketplaces/marketplaces_screen.dart';
import 'package:jurassic_dropshipping/features/returns/returns_screen.dart';
import 'package:jurassic_dropshipping/features/incidents/incident_detail_screen.dart';
import 'package:jurassic_dropshipping/features/incidents/incidents_screen.dart';
import 'package:jurassic_dropshipping/features/return_policies/return_policies_screen.dart';
import 'package:jurassic_dropshipping/features/returned_stock/returned_stock_screen.dart';
import 'package:jurassic_dropshipping/features/capital/capital_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
        GoRoute(path: '/analytics', builder: (context, state) => const AnalyticsScreen()),
        GoRoute(path: '/products', builder: (context, state) => const ProductsScreen()),
        GoRoute(
          path: '/orders',
          builder: (context, state) => OrdersScreen(
            highlightOrderId: state.uri.queryParameters['orderId'],
            initialQueuedForCapitalFilter: state.uri.queryParameters['queued'] == '1',
          ),
        ),
        GoRoute(path: '/suppliers', builder: (context, state) => const SuppliersScreen()),
        GoRoute(path: '/marketplaces', builder: (context, state) => const MarketplacesScreen()),
        GoRoute(path: '/returns', builder: (context, state) => const ReturnsScreen()),
        GoRoute(
          path: '/incidents',
          builder: (context, state) => IncidentsScreen(filterOrderId: state.uri.queryParameters['orderId']),
        ),
        GoRoute(
          path: '/incidents/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '');
            if (id == null) return const IncidentsScreen();
            return IncidentDetailScreen(incidentId: id);
          },
        ),
        GoRoute(path: '/returned-stock', builder: (context, state) => const ReturnedStockScreen()),
        GoRoute(path: '/capital', builder: (context, state) => const CapitalScreen()),
        GoRoute(path: '/approval', builder: (context, state) => const ApprovalScreen()),
        GoRoute(
          path: '/decision-log',
          builder: (context, state) => DecisionLogScreen(
            filterEntityId: state.uri.queryParameters['entityId'],
          ),
        ),
        GoRoute(path: '/return-policies', builder: (context, state) => const ReturnPoliciesScreen()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      ],
    ),
  ],
);
