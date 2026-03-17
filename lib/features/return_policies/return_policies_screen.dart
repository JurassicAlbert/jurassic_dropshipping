import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/domain/post_order/supplier_return_policy.dart';
import 'package:jurassic_dropshipping/features/shared/empty_state.dart';
import 'package:jurassic_dropshipping/features/shared/error_card.dart';
import 'package:jurassic_dropshipping/features/shared/info_icon.dart';
import 'package:jurassic_dropshipping/features/shared/loading_skeleton.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';

/// Supplier return policies (Phase 11). View and edit policies per supplier.
class ReturnPoliciesScreen extends ConsumerStatefulWidget {
  const ReturnPoliciesScreen({super.key});

  @override
  ConsumerState<ReturnPoliciesScreen> createState() => _ReturnPoliciesScreenState();
}

class _ReturnPoliciesScreenState extends ConsumerState<ReturnPoliciesScreen> {
  @override
  Widget build(BuildContext context) {
    final async = ref.watch(supplierReturnPoliciesProvider);

    return async.when(
      loading: () => const LoadingSkeleton(),
      error: (e, _) => ErrorCard(
        message: 'Failed to load policies.',
        onRetry: () => ref.invalidate(supplierReturnPoliciesProvider),
      ),
      data: (policies) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ScreenHelpSection(
                description: ScreenHelpTexts.returnPolicies,
                howToUse: 'How to use: Tap a policy to edit, or "Add policy" to create one per supplier.',
              ),
            ),
            if (policies.isEmpty)
              const Expanded(
                child: EmptyState(
                  icon: Icons.policy_outlined,
                  title: 'No return policies',
                  subtitle: 'Add supplier return policies to control return routing and restock',
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: policies.length,
                  itemBuilder: (context, index) {
                    final p = policies[index];
                    return InkWell(
                      onTap: () => _openPolicyDialog(context, ref, policy: p),
                      child: _PolicyCard(policy: p),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                    message: 'Create a new return policy for a supplier (return window, restocking fee, RMA).',
                    child: FilledButton.icon(
                      onPressed: () => _openPolicyDialog(context, ref),
                      icon: const Icon(Icons.add),
                      label: const Text('Add policy'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InfoIcon(
                    tooltip: 'Add one policy per supplier. It defines return window, restocking fee, who pays return shipping, and RMA rules. '
                        'The Returns screen uses this when you click "Compute routing" to suggest where a return should go.',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _openPolicyDialog(BuildContext context, WidgetRef ref, {SupplierReturnPolicy? policy}) async {
    final isEditing = policy != null;
    final repo = ref.read(supplierReturnPolicyRepositoryProvider);
    final supplierIdController = TextEditingController(text: policy?.supplierId ?? '');
    var policyType = policy?.policyType ?? SupplierReturnPolicyType.returnWindow;
    final windowController = TextEditingController(text: policy?.returnWindowDays?.toString() ?? '');
    final restockingController = TextEditingController(text: policy?.restockingFeePercent?.toString() ?? '');
    var returnShippingPaidBy = policy?.returnShippingPaidBy;
    var requiresRma = policy?.requiresRma ?? false;
    var warehouseReturnSupported = policy?.warehouseReturnSupported ?? false;
    var virtualRestockSupported = policy?.virtualRestockSupported ?? false;

    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit policy' : 'Add return policy'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: supplierIdController,
                      decoration: const InputDecoration(labelText: 'Supplier ID', border: OutlineInputBorder()),
                      readOnly: isEditing,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<SupplierReturnPolicyType>(
                      initialValue: policyType,
                      decoration: const InputDecoration(labelText: 'Policy type', border: OutlineInputBorder()),
                      items: SupplierReturnPolicyType.values
                          .map((t) => DropdownMenuItem(value: t, child: Text(_policyTypeLabel(t))))
                          .toList(),
                      onChanged: (v) => setState(() => policyType = v ?? policyType),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: windowController,
                      decoration: const InputDecoration(labelText: 'Return window (days)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: restockingController,
                      decoration: const InputDecoration(labelText: 'Restocking fee %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<ReturnShippingPaidBy?>(
                      initialValue: returnShippingPaidBy,
                      decoration: const InputDecoration(labelText: 'Return shipping paid by', border: OutlineInputBorder()),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('—')),
                        ...ReturnShippingPaidBy.values.map((v) => DropdownMenuItem(value: v, child: Text(v.name))),
                      ],
                      onChanged: (v) => setState(() => returnShippingPaidBy = v),
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      title: const Text('Requires RMA'),
                      value: requiresRma,
                      onChanged: (v) => setState(() => requiresRma = v ?? false),
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Warehouse return supported'),
                      value: warehouseReturnSupported,
                      onChanged: (v) => setState(() => warehouseReturnSupported = v ?? false),
                      contentPadding: EdgeInsets.zero,
                    ),
                    CheckboxListTile(
                      title: const Text('Virtual restock supported'),
                      value: virtualRestockSupported,
                      onChanged: (v) => setState(() => virtualRestockSupported = v ?? false),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () async {
                    final supplierId = supplierIdController.text.trim();
                    if (supplierId.isEmpty) return;
                    final window = int.tryParse(windowController.text.trim());
                    final restocking = double.tryParse(restockingController.text.trim());
                    final p = SupplierReturnPolicy(
                      id: policy?.id ?? 0,
                      supplierId: supplierId,
                      policyType: policyType,
                      returnWindowDays: window,
                      restockingFeePercent: restocking,
                      returnShippingPaidBy: returnShippingPaidBy,
                      requiresRma: requiresRma,
                      warehouseReturnSupported: warehouseReturnSupported,
                      virtualRestockSupported: virtualRestockSupported,
                    );
                    final navigator = Navigator.of(ctx);
                    if (isEditing) {
                      await repo.update(p);
                    } else {
                      await repo.insert(p);
                    }
                    if (!context.mounted) return;
                    ref.invalidate(supplierReturnPoliciesProvider);
                    navigator.pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    supplierIdController.dispose();
    windowController.dispose();
    restockingController.dispose();
  }

  static String _policyTypeLabel(SupplierReturnPolicyType t) {
    return switch (t) {
      SupplierReturnPolicyType.noReturns => 'No returns',
      SupplierReturnPolicyType.defectOnly => 'Defect only',
      SupplierReturnPolicyType.returnWindow => 'Return window',
      SupplierReturnPolicyType.fullReturns => 'Full returns',
      SupplierReturnPolicyType.returnToWarehouse => 'Return to warehouse',
      SupplierReturnPolicyType.sellerHandlesReturns => 'Seller handles returns',
    };
  }
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.policy});

  final SupplierReturnPolicy policy;

  static String _policyTypeLabel(SupplierReturnPolicyType t) {
    return switch (t) {
      SupplierReturnPolicyType.noReturns => 'No returns',
      SupplierReturnPolicyType.defectOnly => 'Defect only',
      SupplierReturnPolicyType.returnWindow => 'Return window',
      SupplierReturnPolicyType.fullReturns => 'Full returns',
      SupplierReturnPolicyType.returnToWarehouse => 'Return to warehouse',
      SupplierReturnPolicyType.sellerHandlesReturns => 'Seller handles returns',
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              policy.supplierId,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Type: ${_policyTypeLabel(policy.policyType)}', style: theme.textTheme.bodyMedium),
            if (policy.returnWindowDays != null)
              Text('Window: ${policy.returnWindowDays} days', style: theme.textTheme.bodySmall),
            if (policy.restockingFeePercent != null)
              Text('Restocking: ${policy.restockingFeePercent}%', style: theme.textTheme.bodySmall),
            if (policy.returnShippingPaidBy != null)
              Text('Return shipping: ${policy.returnShippingPaidBy!.name}', style: theme.textTheme.bodySmall),
            Wrap(
              spacing: 8,
              children: [
                if (policy.requiresRma) Chip(label: Text('RMA required', style: theme.textTheme.labelSmall), visualDensity: VisualDensity.compact),
                if (policy.warehouseReturnSupported) Chip(label: Text('Warehouse return', style: theme.textTheme.labelSmall), visualDensity: VisualDensity.compact),
                if (policy.virtualRestockSupported) Chip(label: Text('Virtual restock', style: theme.textTheme.labelSmall), visualDensity: VisualDensity.compact),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
