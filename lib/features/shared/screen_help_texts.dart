/// Centralized screen-level help copy for the admin UI.
class ScreenHelpTexts {
  ScreenHelpTexts._();

  static const String dashboard = 'Overview of KPIs, automation status, listings and orders. '
      'Use refresh actions to update metrics; run a scan to discover and create listings from suppliers.';

  static const String analytics = 'Analytics on orders, listings, returns and suppliers. '
      'View profit by platform, margin strategy KPIs, issues and returns analysis.';

  static const String products = 'All listings (products listed on marketplaces). '
      'Filter by status: Active, Pending, Draft. Run a scan from Dashboard to add new products.';

  static const String orders = 'Orders synchronized from marketplaces. '
      'Orders move through lifecycle stages: supplier fulfillment, shipment, delivery, returns and incidents. '
      'Search by order ID or tracking number; use Backfill lifecycle to sync state from marketplace.';

  static const String approval = 'Manually approve or reject pending listings and orders. '
      'Approve a listing to publish it to the marketplace; approve an order to place it with the supplier. '
      'Reject to cancel or set back to draft.';

  static const String suppliers = 'Registered suppliers with reliability scores. '
      'Use "Refresh reliability scores" to re-evaluate all suppliers.';

  static const String marketplaces = 'Target marketplaces and connection status. '
      'Shows order and revenue stats per platform. Connect marketplaces in Settings.';

  static const String returns = 'Customer return requests. '
      'Edit status, refund amount, routing and restock. Use "Compute routing" to determine return destination.';

  static const String incidents = 'Post-order incidents (returns, complaints, damage). '
      'Create incidents or process them via background jobs. Filter by order to see related incidents.';

  static const String returnedStock = 'Stock returned from customers or suppliers. '
      'Reduce quantity or write off items that are not restockable.';

  static const String capital = 'Available capital, adjustments and ledger. '
      'Record initial capital or corrections. Orders queued for capital wait for funds before fulfillment.';

  static const String decisionLog = 'Decision log entries from scanner and automation. '
      'Shows why listings or orders were accepted, rejected or paused.';

  static const String returnPolicies = 'Supplier return policies control return routing and restock. '
      'Add or edit policies per supplier (return window, restocking fee, RMA, etc.).';

  static const String settings = 'Plan usage, business rules, integrations and feature flags. '
      'Save rules after editing. Connect Allegro, CJ and API2Cart in Integrations.';

  static const String howItWorks = 'Chart of what the system does automatically and when you need to take action. '
      'Settings-aware and written for non-technical users.';

  static const String riskDashboard = 'Overview of products, suppliers and listings with elevated risk. '
      'Use this to find high return rates, negative margin, reliability issues and delivery delays.';

  static const String profitDashboard = 'Profit leaders, margin risk, return cost and supplier loss. '
      'Use this to see top profitable products and products below margin threshold.';

  /// Short tooltip for each nav item (same order as shell _routes).
  static const List<String> navTooltips = [
    dashboard,
    analytics,
    profitDashboard,
    products,
    orders,
    suppliers,
    marketplaces,
    returns,
    incidents,
    riskDashboard,
    returnedStock,
    capital,
    approval,
    decisionLog,
    returnPolicies,
    settings,
    howItWorks,
  ];
}
