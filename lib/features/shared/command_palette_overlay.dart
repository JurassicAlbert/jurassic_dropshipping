import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jurassic_dropshipping/features/shell/shell_screen.dart';

/// A command palette entry: either a route or an action.
class CommandPaletteItem {
  const CommandPaletteItem.route(this.label, this.path) : callback = null;
  const CommandPaletteItem.action(this.label, this.callback) : path = null;

  final String label;
  final String? path;
  final VoidCallback? callback;

  bool get isRoute => path != null;
}

/// Static list of routes and labels (must match shell navigation).
const List<CommandPaletteItem> commandPaletteRoutes = [
  CommandPaletteItem.route('Dashboard', '/dashboard'),
  CommandPaletteItem.route('Analytics', '/analytics'),
  CommandPaletteItem.route('Profit', '/profit-dashboard'),
  CommandPaletteItem.route('Products', '/products'),
  CommandPaletteItem.route('Orders', '/orders'),
  CommandPaletteItem.route('Suppliers', '/suppliers'),
  CommandPaletteItem.route('Marketplaces', '/marketplaces'),
  CommandPaletteItem.route('Returns', '/returns'),
  CommandPaletteItem.route('Incidents', '/incidents'),
  CommandPaletteItem.route('Risk dashboard', '/risk-dashboard'),
  CommandPaletteItem.route('Returned stock', '/returned-stock'),
  CommandPaletteItem.route('Capital', '/capital'),
  CommandPaletteItem.route('Approval Queue', '/approval'),
  CommandPaletteItem.route('Decision Log', '/decision-log'),
  CommandPaletteItem.route('Return policies', '/return-policies'),
  CommandPaletteItem.route('Settings', '/settings'),
];

/// Shows the command palette as a modal. [shellContext] is used for navigation and for opening jump-to-order after close.
void showCommandPalette(BuildContext shellContext, WidgetRef ref) {
  final queryController = TextEditingController();
  final queryFocus = FocusNode();
  final allItems = List<CommandPaletteItem>.from(commandPaletteRoutes)
    ..addAll([
      CommandPaletteItem.action('Jump to order…', () => ShellScreen.showJumpToOrderDialog(shellContext, ref)),
    ]);

  showDialog<void>(
    context: shellContext,
    barrierDismissible: true,
    builder: (ctx) => _CommandPaletteDialog(
      items: allItems,
      queryController: queryController,
      queryFocus: queryFocus,
      shellContext: shellContext,
      ref: ref,
    ),
  );
  WidgetsBinding.instance.addPostFrameCallback((_) => queryFocus.requestFocus());
}

class _CommandPaletteDialog extends ConsumerStatefulWidget {
  const _CommandPaletteDialog({
    required this.items,
    required this.queryController,
    required this.queryFocus,
    required this.shellContext,
    required this.ref,
  });
  final List<CommandPaletteItem> items;
  final TextEditingController queryController;
  final FocusNode queryFocus;
  final BuildContext shellContext;
  final WidgetRef ref;

  @override
  ConsumerState<_CommandPaletteDialog> createState() => _CommandPaletteDialogState();
}

class _CommandPaletteDialogState extends ConsumerState<_CommandPaletteDialog> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    widget.queryController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    widget.queryController.removeListener(_onQueryChanged);
    super.dispose();
  }

  void _onQueryChanged() {
    setState(() => _query = widget.queryController.text.toLowerCase());
  }

  List<CommandPaletteItem> get _filtered {
    if (_query.isEmpty) return widget.items;
    return widget.items
        .where((i) => i.label.toLowerCase().contains(_query))
        .toList();
  }

  void _onSelect(CommandPaletteItem item) {
    Navigator.of(context).pop();
    if (item.isRoute && item.path != null) {
      widget.shellContext.go(item.path!);
    } else if (item.callback != null) {
      item.callback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Semantics(
        label: 'Search: go to any screen or action, or jump to an order by ID',
        child: SizedBox(
          width: 440,
          height: 480,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Search or go to',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                child: Text(
                  'Type to find any screen or action. Select with Enter or tap. You can also jump to an order by choosing "Jump to order…". Shortcut: Ctrl+K',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: widget.queryController,
                  focusNode: widget.queryFocus,
                  decoration: const InputDecoration(
                    hintText: 'Search screens, actions…',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) {
                    if (filtered.isNotEmpty) _onSelect(filtered.first);
                  },
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final item = filtered[i];
                    return Semantics(
                      button: true,
                      label: item.label,
                      child: ListTile(
                        leading: Icon(
                          item.isRoute ? Icons.open_in_new : Icons.touch_app,
                          size: 20,
                        ),
                        title: Text(item.label),
                        onTap: () => _onSelect(item),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
