import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';

/// Dedicated page explaining what is automated vs where user action is needed.
/// Settings-aware so copy reflects current rules (e.g. manual approval on/off).
/// Written for users who may not understand most of the system.
class HowItWorksScreen extends ConsumerWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rulesAsync = ref.watch(rulesProvider);
    final theme = Theme.of(context);

    return rulesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Could not load settings: $e')),
      data: (rules) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'How the system works',
                icon: Icons.help_outline,
                subtitle: 'What is automated, what needs your action, and how settings affect decisions.',
              ),
              Text(
                'This page explains what happens automatically and when you need to do something yourself. '
                'Think of it as a map: the system handles a lot in the background, but some steps require your decision or action.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),

              _Section(
                title: '1. Products and listings',
                icon: Icons.inventory_2,
                automated: [
                  'The system can discover products from your connected suppliers (e.g. CJ, API2Cart) when you run a scan from the Dashboard.',
                  'For each product it decides whether to create a listing (offer) on your marketplace based on profit, delivery time, and your rules.',
                  'Prices are calculated to stay competitive (e.g. below lowest competitor or with a small premium) using your min profit and fee settings.',
                  'Listing health (return rate, late delivery) is computed so the system can pause risky listings if you turn that on.',
                  if (rules.autoPauseListingWhenMarginBelowThreshold)
                    'With "Auto-pause when margin below threshold" ON: listings whose profit margin drops below your Min profit % are automatically set to Paused.',
                  if (rules.autoPauseListingWhenHealthPoor)
                    'With "Auto-pause when health poor" ON: listings that exceed your max return rate or late delivery rate are automatically paused.',
                ],
                manual: [
                  'Run a scan (Dashboard → Run scan) to discover new products and create draft or pending listings.',
                  if (rules.manualApprovalListings)
                    'Because "Manual approval for listings" is ON: each new listing waits in the Approval queue until you approve it. Go to Approval Queue → approve or reject.',
                  if (!rules.manualApprovalListings)
                    '"Manual approval for listings" is OFF: new listings that pass the rules are published to the marketplace without your approval.',
                  'You can pause, edit, or remove listings from the Products screen.',
                ],
                theme: theme,
              ),

              _Section(
                title: '2. Orders (customer buys on marketplace)',
                icon: Icons.shopping_cart,
                automated: [
                  'Orders from the marketplace (e.g. Allegro) are synced into the app on a schedule.',
                  'The system assigns each order to a listing and a supplier, and calculates cost and profit.',
                  if (rules.riskScoreThreshold != null)
                    'With "Risk score threshold" set: orders with risk score above ${rules.riskScoreThreshold!.toStringAsFixed(0)} are sent to the Approval Queue for your review.',
                  if (rules.riskScoreThreshold == null)
                    'If you set a risk score threshold in Settings: high-risk orders are flagged for your approval.',
                  'Order lifecycle (created → approved → shipped → delivered, or return/refund) can be synced from the marketplace (Backfill lifecycle on Orders screen).',
                ],
                manual: [
                  'Check the Orders screen to see new and existing orders.',
                  if (rules.manualApprovalOrders)
                    'Because "Manual approval for orders" is ON: new orders go to the Approval Queue. You must approve each order before the system places it with the supplier. Go to Approval Queue → Approve or Reject.',
                  if (!rules.manualApprovalOrders)
                    '"Manual approval for orders" is OFF: approved orders are sent to the supplier automatically when the automation runs.',
                  'You can set or change lifecycle (e.g. Shipped, Delivered) and add tracking numbers. Use "Backfill lifecycle" to pull the latest state from the marketplace.',
                ],
                theme: theme,
              ),

              _Section(
                title: '3. Fulfillment (sending the order to the supplier)',
                icon: Icons.local_shipping,
                automated: [
                  'When an order is approved, the system creates a source order with your supplier (e.g. CJ, API2Cart) and sends the customer address and quantity.',
                  'If capital is tracked: the system checks that you have enough funds before fulfilling; otherwise the order stays "Queued for capital" until you add capital.',
                  if (rules.blockFulfillWhenInsufficientStock)
                    'With "Block fulfill when insufficient stock" ON: the system will not place an order with the supplier if available-to-sell is below the order quantity.',
                  if (rules.targetsReadOnly)
                    'Right now "Targets read-only" is ON: the system will not send orders or push tracking to the marketplace. Turn it OFF in Settings when you want live operation.',
                  'Background jobs can process the approval queue and place orders with suppliers on a schedule.',
                ],
                manual: [
                  if (rules.manualApprovalOrders)
                    'After you approve an order in the Approval Queue, fulfillment is triggered (by you clicking Approve there, or by a background job that processes approved orders).',
                  'If an order is "Queued for capital": add or free up capital in the Capital screen, then the system can fulfill.',
                  'If "Targets read-only" is ON in Settings: the system will not send orders or updates to the marketplace; turn it OFF when you are ready for live operation.',
                ],
                theme: theme,
              ),

              _Section(
                title: '4. Returns (customer sends item back)',
                icon: Icons.assignment_return,
                automated: [
                  'Returns can be created manually from the Orders screen (Create return) or, when connected, synced from the marketplace.',
                  'Return routing (send to supplier vs your address vs disposal) can be computed using Return policies and product/supplier data.',
                ],
                manual: [
                  'Open the Returns screen. For each return you can set status (Requested → Approved → Shipped → Received → Refunded), refund amount, and destination.',
                  'Use "Compute routing" in the return edit dialog to let the system suggest where the return should go (supplier, seller, disposal).',
                  'When status is Received you can add the item to Returned stock so it can be sold again.',
                  'If the buyer sent the parcel back without giving a reason, the return still appears; you can process it as usual (no reason / parcel return only).',
                ],
                theme: theme,
              ),

              _Section(
                title: '5. Incidents (complaints, damage, disputes)',
                icon: Icons.warning_amber,
                automated: [
                  'Incidents (e.g. customer return within 14 days, damage claim) can be created automatically by the system or from the Incidents screen.',
                  'Background jobs can process incident rules (e.g. auto-refund, notify) if you have configured them in Settings.',
                ],
                manual: [
                  'Open the Incidents screen to see and manage incidents. You can create an incident manually and link it to an order.',
                  'Resolve incidents (e.g. refund, reject, contact customer) and close them when done.',
                  'Incident rules in Settings define what the system may do automatically; review and adjust as needed.',
                ],
                theme: theme,
              ),

              _Section(
                title: '6. Capital and money flow',
                icon: Icons.account_balance,
                automated: [
                  'The system tracks capital (available funds) and can block fulfillment when there is not enough to cover an order (if you use this feature).',
                  'Financial state on orders (unpaid, supplier_paid, marketplace_held, refunded) can be updated when you or the system records payments and refunds.',
                ],
                manual: [
                  'In the Capital screen you record your starting capital and any adjustments (e.g. money in, corrections).',
                  'If orders stay "Queued for capital", add capital or free it by marking orders as paid so new orders can be fulfilled.',
                ],
                theme: theme,
              ),

              _Section(
                title: '7. Settings and rules',
                icon: Icons.settings,
                automated: [
                  'Your settings (min profit %, blacklists, approval flags, marketplace fees, etc.) drive all automatic decisions. The system does not change these unless you do.',
                ],
                manual: [
                  'Go to Settings to set: min profit, manual approval for listings/orders, marketplace and payment fees, seller return address, return policies, and integrations (Allegro, CJ, API2Cart).',
                  'After changing rules, save. "Targets read-only" turns off all writes to marketplaces (no new listings, no order placement, no tracking push)—useful for testing.',
                  if (rules.riskScoreThreshold != null)
                    'Risk score threshold is set to ${rules.riskScoreThreshold!.toStringAsFixed(0)}: orders above this score go to Approval Queue.',
                  'Use Risk dashboard and Profit dashboard to see where listings or orders need your attention.',
                ],
                theme: theme,
              ),

              const SizedBox(height: AppSpacing.sectionGap),
              _ModulesOverview(theme: theme),
              const SizedBox(height: AppSpacing.sectionGap),
              _DecisionFlowsSection(theme: theme, rules: rules),
              const SizedBox(height: AppSpacing.sectionGap),
              _FlowDiagramsSection(theme: theme, rules: rules),
              const SizedBox(height: AppSpacing.sectionGap),
              Card(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline, color: theme.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Quick reference',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Automated: the system does it without you. '
                        'Your action: you need to do this in the app (or approve/reject). '
                        'Settings change what is automated: e.g. with manual approval ON, new orders and listings wait for you in the Approval Queue.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.automated,
    required this.manual,
    required this.theme,
  });

  final String title;
  final IconData icon;
  final List<String> automated;
  final List<String> manual;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: theme.colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SubSection(
                title: 'What the system does automatically',
                color: Colors.green.shade700,
                items: automated,
                theme: theme,
              ),
              const SizedBox(height: 16),
              _SubSection(
                title: 'When you need to do something',
                color: Colors.orange.shade700,
                items: manual,
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubSection extends StatelessWidget {
  const _SubSection({
    required this.title,
    required this.color,
    required this.items,
    required this.theme,
  });

  final String title;
  final Color color;
  final List<String> items;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(e, style: theme.textTheme.bodyMedium)),
                ],
              ),
            )),
      ],
    );
  }
}

/// Compact overview of app modules so users can map flows to parts of the app.
class _ModulesOverview extends StatelessWidget {
  const _ModulesOverview({required this.theme});

  final ThemeData theme;

  static const List<({String name, IconData icon, String role})> _modules = [
    (name: 'Dashboard', icon: Icons.dashboard, role: 'Run scans, see status and automation'),
    (name: 'Products', icon: Icons.inventory_2, role: 'Listings, prices, stock, health'),
    (name: 'Approval Queue', icon: Icons.pending_actions, role: 'Approve or reject listings and orders'),
    (name: 'Orders', icon: Icons.shopping_cart, role: 'Customer orders, lifecycle, backfill'),
    (name: 'Fulfillment', icon: Icons.local_shipping, role: 'Send orders to suppliers'),
    (name: 'Returns', icon: Icons.assignment_return, role: 'Return status, refund, routing'),
    (name: 'Capital', icon: Icons.account_balance, role: 'Funds and order payment state'),
    (name: 'Settings', icon: Icons.settings, role: 'Rules, fees, integrations'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.apps, color: theme.colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Modules in this system',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Each flow below uses one or more of these modules. Knowing what each module does helps you see who does what at each step.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
                children: _modules.map((m) => _ModuleChip(
                  theme: theme,
                  name: m.name,
                  icon: m.icon,
                  role: m.role,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleChip extends StatelessWidget {
  const _ModuleChip({required this.theme, required this.name, required this.icon, required this.role});

  final ThemeData theme;
  final String name;
  final IconData icon;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: role,
      preferBelow: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Decision flows section: step-by-step flows with alternative text based on current settings.
class _DecisionFlowsSection extends StatelessWidget {
  const _DecisionFlowsSection({required this.theme, required this.rules});

  final ThemeData theme;
  final UserRules rules;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_tree, color: theme.colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Decision flows (based on your current settings)',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Below are the main flows the system follows. The text in each step reflects your current Settings, so you see exactly what happens in your setup.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),

              _FlowCard(
                theme: theme,
                title: 'Listing flow',
                summary: 'From running a scan to having a listing live on the marketplace.',
                moduleNames: const ['Dashboard', 'Products', 'Approval Queue'],
                steps: _listingFlowSteps(rules),
              ),
              const SizedBox(height: 24),

              _FlowCard(
                theme: theme,
                title: 'Order flow',
                summary: 'From customer purchase to order sent to the supplier (and lifecycle updates).',
                moduleNames: const ['Orders', 'Approval Queue', 'Fulfillment', 'Capital'],
                steps: _orderFlowSteps(rules),
              ),
              const SizedBox(height: 24),

              _FlowCard(
                theme: theme,
                title: 'Return flow',
                summary: 'From return created or synced to refund and optional restock.',
                moduleNames: const ['Orders', 'Returns'],
                steps: _returnFlowSteps(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_FlowItem> _listingFlowSteps(UserRules r) {
    return [
      _FlowItem.step('You run a scan from the Dashboard (Run scan → Scan). The system uses your search keywords from Settings.'),
      _FlowItem.step('For each product found, the system checks: profit margin ≥ Min profit %, delivery time OK, product and supplier not blacklisted. If any check fails, the listing is rejected (see Decision log for reason).'),
      _FlowItem.branch(
        'Manual approval for listings is ${r.manualApprovalListings ? "ON" : "OFF"}',
        r.manualApprovalListings
            ? 'So the new listing goes to Pending. You must go to Approval Queue, then Approve (to publish on the marketplace) or Reject (to cancel or set back to draft).'
            : 'So new listings that pass the checks are created as Draft and can be published by the system without your approval.',
      ),
      if (r.autoPauseListingWhenMarginBelowThreshold || r.autoPauseListingWhenHealthPoor)
        _FlowItem.step(
          'After publishing: ${r.autoPauseListingWhenMarginBelowThreshold && r.autoPauseListingWhenHealthPoor ? "If margin drops below Min profit % or if return/late rate gets too high, the listing is automatically Paused." : r.autoPauseListingWhenMarginBelowThreshold ? "If margin drops below Min profit %, the listing is automatically Paused." : "If return rate or late delivery rate exceeds your limits, the listing is automatically Paused."}',
        ),
    ];
  }

  List<_FlowItem> _orderFlowSteps(UserRules r) {
    final riskVal = r.riskScoreThreshold != null ? r.riskScoreThreshold!.toStringAsFixed(0) : '—';
    return [
      _FlowItem.step('Customer buys on the marketplace. The order is synced into the app (on a schedule).'),
      _FlowItem.step('The system assigns the order to a listing and a supplier, and calculates cost and profit. It may also compute a risk score for the order.'),
      _FlowItem.branch(
        r.riskScoreThreshold != null ? 'Risk score threshold is set to $riskVal' : 'No risk score threshold is set',
        r.riskScoreThreshold != null
            ? 'So if the order\'s risk score is above $riskVal, it goes to the Approval Queue. You must approve or reject it before it can be fulfilled.'
            : 'So no orders are sent to the Approval Queue for risk reasons. They follow the manual approval rule below.',
      ),
      _FlowItem.branch(
        'Manual approval for orders is ${r.manualApprovalOrders ? "ON" : "OFF"}',
        r.manualApprovalOrders
            ? 'So (unless already in queue for risk) the order goes to the Approval Queue. You must go to Approval Queue and Approve (to place with supplier) or Reject (to cancel on marketplace).'
            : 'So approved orders are sent to the supplier automatically when the automation runs—no need to approve each one in the queue.',
      ),
      _FlowItem.branch(
        'Targets read-only is ${r.targetsReadOnly ? "ON" : "OFF"}',
        r.targetsReadOnly
            ? 'So even after approval, the system will not send the order to the supplier or push tracking to the marketplace. This is a safe/dry-run mode. Turn it OFF in Settings for live operation.'
            : 'So when the order is approved, the system will try to place it with the supplier (see next step for possible blocks).',
      ),
      _FlowItem.step(
        'When placing with the supplier: the system checks capital (if balance is too low, the order stays "Queued for capital" until you add funds).'
        '${r.blockFulfillWhenInsufficientStock ? " With \"Block fulfill when insufficient stock\" ON, it also checks that there is enough available stock; if not, fulfillment is blocked." : ""} '
        'If all checks pass, the source order is sent to the supplier.',
      ),
      _FlowItem.step('You or the marketplace can later update status (e.g. Shipped, Delivered) and tracking. Use "Backfill lifecycle" on the Orders screen to sync state from the marketplace.'),
    ];
  }

  List<_FlowItem> _returnFlowSteps() {
    return [
      _FlowItem.step('A return appears in the app—either you create it from the Orders screen (Create return / complaint) or it is synced from the marketplace.'),
      _FlowItem.step('You open the Returns screen and tap the return. In the edit dialog you set the status (e.g. Requested → Approved → Shipped → Received → Refunded) and optionally the refund amount, shipping cost, and restocking fee.'),
      _FlowItem.step('You can click "Compute routing" to let the system suggest where the return should go (seller address, supplier warehouse, return center, or disposal), based on your Return policies and product/supplier data.'),
      _FlowItem.step('When status is Received, you can optionally add the item to Returned stock (checkbox in the dialog) so it can be sold again. Save to apply.'),
    ];
  }
}

class _FlowItem {
  _FlowItem._({required this.isBranch, this.stepText, this.branchCondition, this.branchThen});

  final bool isBranch;
  final String? stepText;
  final String? branchCondition;
  final String? branchThen;

  factory _FlowItem.step(String text) => _FlowItem._(isBranch: false, stepText: text);
  factory _FlowItem.branch(String condition, String thenText) =>
      _FlowItem._(isBranch: true, branchCondition: condition, branchThen: thenText);
}

class _FlowCard extends StatelessWidget {
  const _FlowCard({
    required this.theme,
    required this.title,
    required this.steps,
    this.summary,
    this.moduleNames = const [],
  });

  final ThemeData theme;
  final String title;
  final List<_FlowItem> steps;
  final String? summary;
  final List<String> moduleNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          if (summary != null && summary!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              summary!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (moduleNames.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: moduleNames.map((name) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  name,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              )).toList(),
            ),
          ],
          const SizedBox(height: 16),
          ...steps.asMap().entries.map((e) {
            final i = e.key + 1;
            final item = e.value;
            if (item.isBranch) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StepNumber(theme: theme, number: i),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            left: BorderSide(
                              color: theme.colorScheme.tertiary,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'With your current settings: ${item.branchCondition}',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(item.branchThen ?? '', style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StepNumber(theme: theme, number: i),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(item.stepText ?? '', style: theme.textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StepNumber extends StatelessWidget {
  const _StepNumber({required this.theme, required this.number});

  final ThemeData theme;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text('$number', style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

/// Visual flow diagrams (UML-style) for the same flows; settings-aware labels.
class _FlowDiagramsSection extends StatelessWidget {
  const _FlowDiagramsSection({required this.theme, required this.rules});

  final ThemeData theme;
  final UserRules rules;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_tree_outlined, color: theme.colorScheme.primary, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Flow diagrams (same flows as above)',
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Visual representation of the decision flows. Hover over any box or arrow for details. '
                'This diagram reflects your current Settings—change settings and return here to see the updated flow.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              _DiagramLegend(theme: theme),
              const SizedBox(height: 24),
              _DiagramFlowCard(
                theme: theme,
                title: 'Listing flow',
                moduleNames: const ['Dashboard', 'Products', 'Approval Queue'],
                nodes: _listingDiagramNodes(rules),
              ),
              const SizedBox(height: 24),
              _DiagramFlowCard(
                theme: theme,
                title: 'Order flow',
                moduleNames: const ['Orders', 'Approval Queue', 'Fulfillment', 'Capital'],
                nodes: _orderDiagramNodes(rules),
              ),
              const SizedBox(height: 24),
              _DiagramFlowCard(
                theme: theme,
                title: 'Return flow',
                moduleNames: const ['Orders', 'Returns'],
                nodes: _returnDiagramNodes(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<_DiagramNodeData> _listingDiagramNodes(UserRules r) {
    return [
      _DiagramNodeData('Start', tooltip: 'Start of the listing flow: from scan to marketplace.', isAction: false),
      _DiagramNodeData('Run scan (Dashboard)', tooltip: 'You run a scan from the Dashboard. The system uses your search keywords from Settings to discover products from suppliers.', isAction: true),
      _DiagramNodeData('System: check profit, delivery, blacklist', tooltip: 'For each product the system checks: profit margin ≥ Min profit %, delivery time OK, and that product/supplier are not blacklisted. If any check fails, the listing is rejected.', isAction: false),
      _DiagramNodeData('Reject? → Decision log', tooltip: 'Rejected listings are logged in the Decision log with the reason (e.g. profit too low, delivery too long).', isDecision: true),
      _DiagramNodeData(
        r.manualApprovalListings ? 'Pending → You: Approve or Reject' : 'Draft → Auto publish',
        tooltip: r.manualApprovalListings
            ? 'With your setting: Manual approval for listings is ON. New listings go to Pending. You must go to Approval Queue and Approve (to publish) or Reject (to cancel or set back to draft).'
            : 'With your setting: Manual approval for listings is OFF. New listings that pass checks are created as Draft and can be published by the system without your approval.',
        isAction: r.manualApprovalListings,
      ),
      _DiagramNodeData('Published on marketplace', tooltip: 'The listing is live on the marketplace (e.g. Allegro). Customers can buy it.', isAction: false),
    ];
  }

  List<_DiagramNodeData> _orderDiagramNodes(UserRules r) {
    final riskVal = r.riskScoreThreshold != null ? r.riskScoreThreshold!.toStringAsFixed(0) : '—';
    return [
      _DiagramNodeData('Order synced from marketplace', tooltip: 'When a customer buys, the order is synced into the app from the marketplace (e.g. Allegro) on a schedule.', isAction: false),
      _DiagramNodeData('System: assign listing, supplier, risk score', tooltip: 'The system assigns the order to a listing and supplier, calculates cost and profit, and may compute a risk score.', isAction: false),
      _DiagramNodeData(
        r.riskScoreThreshold != null ? 'Risk > $riskVal?' : 'Risk check',
        tooltip: r.riskScoreThreshold != null
            ? 'Your risk score threshold is $riskVal. If the order\'s risk score is above this, it goes to the Approval Queue for your review.'
            : 'No risk score threshold is set, so orders are not sent to the queue for risk reasons.',
        isDecision: true,
      ),
      _DiagramNodeData(
        r.manualApprovalOrders ? 'Approval Queue → You: Approve/Reject' : 'Auto-fulfill path',
        tooltip: r.manualApprovalOrders
            ? 'With your setting: Manual approval for orders is ON. You must go to Approval Queue and Approve (to place with supplier) or Reject (to cancel on marketplace).'
            : 'With your setting: Manual approval for orders is OFF. Approved orders are sent to the supplier automatically when the automation runs.',
        isAction: r.manualApprovalOrders,
      ),
      _DiagramNodeData(
        r.targetsReadOnly ? 'Read-only: no send' : 'Place order with supplier',
        tooltip: r.targetsReadOnly
            ? 'With your setting: Targets read-only is ON. The system will not send the order to the supplier or push tracking. Turn it OFF in Settings for live operation.'
            : 'The system places the source order with your supplier (e.g. CJ, API2Cart). It checks capital and, if enabled, stock before sending.',
        isAction: false,
      ),
      _DiagramNodeData('Tracking & lifecycle', tooltip: 'You or the marketplace can update status (Shipped, Delivered) and tracking. Use "Backfill lifecycle" on the Orders screen to sync state from the marketplace.', isAction: true),
    ];
  }

  List<_DiagramNodeData> _returnDiagramNodes() {
    return [
      _DiagramNodeData('Return created / synced', tooltip: 'A return appears when you create it from the Orders screen (Create return / complaint) or when it is synced from the marketplace.', isAction: false),
      _DiagramNodeData('You: set status, refund, routing', tooltip: 'In the Returns screen, tap the return and set status (Requested → Approved → Shipped → Received → Refunded), refund amount, shipping cost, and restocking fee.', isAction: true),
      _DiagramNodeData('Compute routing (optional)', tooltip: 'Click "Compute routing" in the edit dialog to let the system suggest where the return should go (seller address, supplier warehouse, return center, or disposal) based on your Return policies.', isAction: true),
      _DiagramNodeData('Received → Add to returned stock (optional)', tooltip: 'When status is Received, you can check "Add to returned stock" in the dialog so the item can be sold again. Save to apply.', isAction: true),
    ];
  }
}

class _DiagramLegend extends StatelessWidget {
  const _DiagramLegend({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: [
        _LegendItem(
          theme: theme,
          label: 'System step',
          color: Colors.green.shade700,
          isDecision: false,
        ),
        _LegendItem(
          theme: theme,
          label: 'Your action',
          color: Colors.orange.shade700,
          isDecision: false,
        ),
        _LegendItem(
          theme: theme,
          label: 'Decision (settings)',
          color: theme.colorScheme.tertiary,
          isDecision: true,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.theme,
    required this.label,
    required this.color,
    required this.isDecision,
  });

  final ThemeData theme;
  final String label;
  final Color color;
  final bool isDecision;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(isDecision ? 12 : 6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DiagramNodeData {
  _DiagramNodeData(this.label, {this.tooltip, this.isAction = false, this.isDecision = false});
  final String label;
  /// Hover text; if null, [label] is used.
  final String? tooltip;
  final bool isAction;
  final bool isDecision;
}

class _DiagramFlowCard extends StatelessWidget {
  const _DiagramFlowCard({
    required this.theme,
    required this.title,
    required this.nodes,
    this.moduleNames = const [],
  });

  final ThemeData theme;
  final String title;
  final List<_DiagramNodeData> nodes;
  final List<String> moduleNames;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          if (moduleNames.isNotEmpty) ...[
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: moduleNames.map((name) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  name,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              )).toList(),
            ),
          ],
          const SizedBox(height: 16),
          ...nodes.asMap().entries.expand((e) => [
                _DiagramNodeWidget(theme: theme, data: e.value),
                if (e.key < nodes.length - 1) _DiagramArrow(theme: theme),
              ]),
        ],
      ),
    );
  }
}

class _DiagramNodeWidget extends StatelessWidget {
  const _DiagramNodeWidget({required this.theme, required this.data});

  final ThemeData theme;
  final _DiagramNodeData data;

  @override
  Widget build(BuildContext context) {
    final isDecision = data.isDecision;
    final isAction = data.isAction;
    Color borderColor;
    Color fillColor;
    IconData icon;
    if (isDecision) {
      borderColor = theme.colorScheme.tertiary;
      fillColor = theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5);
      icon = Icons.tune;
    } else if (isAction) {
      borderColor = Colors.orange.shade700;
      fillColor = Colors.orange.shade50;
      icon = Icons.person;
    } else {
      borderColor = Colors.green.shade700;
      fillColor = Colors.green.shade50;
      icon = Icons.smart_toy_outlined;
    }
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(isDecision ? 20 : 12),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: borderColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              data.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isDecision ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
    return Tooltip(
      message: data.tooltip ?? data.label,
      preferBelow: true,
      child: content,
    );
  }
}

class _DiagramArrow extends StatelessWidget {
  const _DiagramArrow({required this.theme});

  final ThemeData theme;

  static const String _defaultTooltip = 'Then: next step in the flow.';

  @override
  Widget build(BuildContext context) {
    final arrow = Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 2, height: 20, color: theme.colorScheme.outlineVariant),
          const SizedBox(width: 6),
          Icon(Icons.arrow_downward, size: 18, color: theme.colorScheme.outline),
        ],
      ),
    );
    return Tooltip(message: _defaultTooltip, preferBelow: true, child: arrow);
  }
}
