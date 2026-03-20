import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/data/models/user_rules.dart';
import 'package:jurassic_dropshipping/domain/decision_engine/pricing_calculator.dart';
import 'package:jurassic_dropshipping/features/shared/app_spacing.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_section.dart';
import 'package:jurassic_dropshipping/features/shared/screen_help_texts.dart';
import 'package:jurassic_dropshipping/features/shared/section_header.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.label,
    required this.description,
  });

  final String label;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keywordsController = TextEditingController();
  final _minProfitController = TextEditingController();
  final _markupController = TextEditingController();
  final _allegroFeeController = TextEditingController();
  final _temuFeeController = TextEditingController();
  final _allegroPaymentFeeController = TextEditingController();
  final _temuPaymentFeeController = TextEditingController();
  final _categoryMinProfitController = TextEditingController();
  final _premiumPercentController = TextEditingController();
  final _minSalesForPremiumController = TextEditingController();
  final _cjEmailController = TextEditingController();
  final _cjApiKeyController = TextEditingController();
  final _allegroClientIdController = TextEditingController();
  final _allegroClientSecretController = TextEditingController();
  final _api2cartApiKeyController = TextEditingController();
  final _api2cartStoreKeyController = TextEditingController();
  bool _rulesLoaded = false;
  bool _allegroConnecting = false;
  bool? _allegroConnected;
  bool _showSaveBanner = false;
  String _pricingStrategy = PricingStrategyId.alwaysBelowLowest;
  bool _kpiDrivenStrategyEnabled = false;
  bool _blockFulfillWhenInsufficientStock = false;
  bool _autoPauseListingWhenMarginBelowThreshold = false;
  final _listingHealthMaxReturnRatePercentController = TextEditingController();
  final _listingHealthMaxLateRatePercentController = TextEditingController();
  bool _autoPauseListingWhenHealthPoor = false;
  final _safetyStockBufferController = TextEditingController();
  final _customerAbuseMaxReturnRatePercentController = TextEditingController();
  final _customerAbuseMaxComplaintRatePercentController = TextEditingController();
  final _priceRefreshIntervalBySourceController = TextEditingController();
  final _sellerReturnStreetController = TextEditingController();
  final _sellerReturnCityController = TextEditingController();
  final _sellerReturnZipController = TextEditingController();
  final _sellerReturnCountryController = TextEditingController();
  final _incidentRulesController = TextEditingController();
  final _riskScoreThresholdController = TextEditingController();
  final _defaultReturnRatePercentController = TextEditingController();
  final _defaultReturnCostPerUnitController = TextEditingController();
  final _defaultSupplierProcessingDaysController = TextEditingController();
  final _defaultSupplierShippingDaysController = TextEditingController();
  final _marketplaceMaxDeliveryDaysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAllegroStatus();
  }

  Future<void> _checkAllegroStatus() async {
    final storage = ref.read(secureStorageProvider);
    final token = await storage.read(SecureKeys.allegroAccessToken);
    if (mounted) {
      setState(() => _allegroConnected = token != null && token.isNotEmpty);
    }
  }

  @override
  void dispose() {
    _keywordsController.dispose();
    _minProfitController.dispose();
    _markupController.dispose();
    _allegroFeeController.dispose();
    _temuFeeController.dispose();
    _allegroPaymentFeeController.dispose();
    _temuPaymentFeeController.dispose();
    _categoryMinProfitController.dispose();
    _premiumPercentController.dispose();
    _minSalesForPremiumController.dispose();
    _cjEmailController.dispose();
    _cjApiKeyController.dispose();
    _allegroClientIdController.dispose();
    _allegroClientSecretController.dispose();
    _api2cartApiKeyController.dispose();
    _api2cartStoreKeyController.dispose();
    _sellerReturnStreetController.dispose();
    _sellerReturnCityController.dispose();
    _sellerReturnZipController.dispose();
    _sellerReturnCountryController.dispose();
    _incidentRulesController.dispose();
    _riskScoreThresholdController.dispose();
    _defaultReturnRatePercentController.dispose();
    _defaultReturnCostPerUnitController.dispose();
    _defaultSupplierProcessingDaysController.dispose();
    _defaultSupplierShippingDaysController.dispose();
    _marketplaceMaxDeliveryDaysController.dispose();
    _listingHealthMaxReturnRatePercentController.dispose();
    _listingHealthMaxLateRatePercentController.dispose();
    _safetyStockBufferController.dispose();
    _customerAbuseMaxReturnRatePercentController.dispose();
    _customerAbuseMaxComplaintRatePercentController.dispose();
    _priceRefreshIntervalBySourceController.dispose();
    super.dispose();
  }

  String? _validatePositiveNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    final parsed = double.tryParse(value);
    if (parsed == null) return '$fieldName must be a number';
    if (parsed <= 0) return '$fieldName must be positive';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(rulesProvider);
    final cs = Theme.of(context).colorScheme;
    rulesAsync.whenData((rules) {
      if (!_rulesLoaded) {
        _rulesLoaded = true;
        _keywordsController.text = rules.searchKeywords.join(', ');
        _minProfitController.text = rules.minProfitPercent.toString();
        _markupController.text = rules.defaultMarkupPercent.toString();
        _allegroFeeController.text = (rules.marketplaceFees['allegro'] ?? 10.0).toString();
        _temuFeeController.text = (rules.marketplaceFees['temu'] ?? 10.0).toString();
         _allegroPaymentFeeController.text = (rules.paymentFees['allegro'] ?? 0.0).toString();
         _temuPaymentFeeController.text = (rules.paymentFees['temu'] ?? 0.0).toString();
        if (rules.categoryMinProfitPercent.isNotEmpty) {
          _categoryMinProfitController.text = rules.categoryMinProfitPercent.entries
              .map((e) => '${e.key}:${e.value}')
              .join(', ');
        }
        _premiumPercentController.text = rules.premiumWhenBetterReviewsPercent.toString();
        _minSalesForPremiumController.text = rules.minSalesCountForPremium.toString();
        _pricingStrategy = rules.pricingStrategy;
        _kpiDrivenStrategyEnabled = rules.kpiDrivenStrategyEnabled;
        final seller = rules.sellerReturnAddressParsed;
        if (seller != null) {
          _sellerReturnStreetController.text = seller.street ?? '';
          _sellerReturnCityController.text = seller.city ?? '';
          _sellerReturnZipController.text = seller.zip ?? '';
          _sellerReturnCountryController.text = seller.countryCode ?? '';
        }
        _incidentRulesController.text = rules.incidentRulesJson?.trim() ?? '[]';
        _riskScoreThresholdController.text = rules.riskScoreThreshold != null ? rules.riskScoreThreshold!.toString() : '';
        _defaultReturnRatePercentController.text = rules.defaultReturnRatePercent != null ? rules.defaultReturnRatePercent!.toString() : '';
        _defaultReturnCostPerUnitController.text = rules.defaultReturnCostPerUnit != null ? rules.defaultReturnCostPerUnit!.toString() : '';
        _blockFulfillWhenInsufficientStock = rules.blockFulfillWhenInsufficientStock;
        _autoPauseListingWhenMarginBelowThreshold = rules.autoPauseListingWhenMarginBelowThreshold;
        _defaultSupplierProcessingDaysController.text = rules.defaultSupplierProcessingDays.toString();
        _defaultSupplierShippingDaysController.text = rules.defaultSupplierShippingDays.toString();
        _marketplaceMaxDeliveryDaysController.text = rules.marketplaceMaxDeliveryDays != null ? rules.marketplaceMaxDeliveryDays!.toString() : '';
        _listingHealthMaxReturnRatePercentController.text = rules.listingHealthMaxReturnRatePercent != null ? rules.listingHealthMaxReturnRatePercent!.toString() : '';
        _listingHealthMaxLateRatePercentController.text = rules.listingHealthMaxLateRatePercent != null ? rules.listingHealthMaxLateRatePercent!.toString() : '';
        _autoPauseListingWhenHealthPoor = rules.autoPauseListingWhenHealthPoor;
        _safetyStockBufferController.text = rules.safetyStockBuffer.toString();
        _customerAbuseMaxReturnRatePercentController.text = rules.customerAbuseMaxReturnRatePercent != null ? rules.customerAbuseMaxReturnRatePercent!.toString() : '';
        _customerAbuseMaxComplaintRatePercentController.text = rules.customerAbuseMaxComplaintRatePercent != null ? rules.customerAbuseMaxComplaintRatePercent!.toString() : '';
        if (rules.priceRefreshIntervalMinutesBySource.isNotEmpty) {
          _priceRefreshIntervalBySourceController.text = rules.priceRefreshIntervalMinutesBySource.entries
              .map((e) => '${e.key}:${e.value}')
              .join(', ');
        }
      }
    });
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenHelpSection(
              description: ScreenHelpTexts.settings,
              howToUse: 'How to use: Edit rules and save. Connect marketplaces in Integrations. Use Developer tools for demo data.',
            ),
            if (_showSaveBanner)
              MaterialBanner(
                content: Text(ref.watch(appLocalizationsProvider).rulesSaved),
                leading: Icon(Icons.check_circle, color: cs.primary),
                backgroundColor: cs.primaryContainer,
                actions: [
                  TextButton(
                    onPressed: () => setState(() => _showSaveBanner = false),
                    child: Text(ref.watch(appLocalizationsProvider).dismiss),
                  ),
                ],
              ),
            if (_showSaveBanner) const SizedBox(height: 12),

            // ─── Plan & usage (Phase B5) ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.credit_card, color: cs.primary),
                        const SizedBox(width: 8),
                        Text('Plan & usage', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ref.watch(billingUsageProvider).when(
                      data: (usage) {
                        final overListings = !usage.plan.hasUnlimitedListings && usage.listingsCount >= usage.plan.maxListings;
                        final overOrders = !usage.plan.hasUnlimitedOrdersPerMonth && usage.ordersThisMonth >= usage.plan.maxOrdersPerMonth;
                        final overLimit = overListings || overOrders;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Plan: ${usage.plan.name}', style: Theme.of(context).textTheme.bodyMedium),
                            Text(
                              'Listings: ${usage.listingsCount}${usage.plan.hasUnlimitedListings ? '' : ' / ${usage.plan.maxListings}'}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(
                              'Orders this month: ${usage.ordersThisMonth}${usage.plan.hasUnlimitedOrdersPerMonth ? '' : ' / ${usage.plan.maxOrdersPerMonth}'}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            if (overLimit) ...[
                              const SizedBox(height: 8),
                              Material(
                                color: cs.errorContainer,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    'Limit reached. Upgrade your plan to add more listings or orders.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onErrorContainer),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                      loading: () => const SizedBox(height: 24, child: Center(child: CircularProgressIndicator())),
                      error: (_, __) => Text('Could not load usage', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.error)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Business rules & automation ───
            SectionHeader(
              title: 'Business rules & automation',
              subtitle: 'Pricing, margins, fees and automation thresholds.',
              icon: Icons.tune,
              infoTooltip: 'These rules control how the system decides prices, which listings to create, '
                  'and when to pause or reject. Min profit % is required for every listing. Save after editing.',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.rule, color: cs.primary),
                        const SizedBox(width: 8),
                        Text('Rules', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    rulesAsync.when(
                      data: (_) => const SizedBox.shrink(),
                      loading: () => const SizedBox.shrink(),
                      error: (_, _) => const SizedBox.shrink(),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _keywordsController,
                      decoration: const InputDecoration(labelText: 'Search keywords (comma-separated)', border: OutlineInputBorder()),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _minProfitController,
                      decoration: const InputDecoration(
                        labelText: 'Min profit %',
                        helperText: 'Minimum profit margin required for listings; below this, listings can be auto-paused.',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) => _validatePositiveNumber(v, 'Min profit %'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _markupController,
                      decoration: const InputDecoration(labelText: 'Default markup %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (v) => _validatePositiveNumber(v, 'Default markup %'),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _pricingStrategy,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Pricing strategy',
                        helperText: 'How selling price is set relative to competitors and cost.',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: PricingStrategyId.alwaysBelowLowest,
                          child: Text('Always 0.01 below lowest (if safe)', overflow: TextOverflow.ellipsis),
                        ),
                        DropdownMenuItem(
                          value: PricingStrategyId.premiumWhenBetterReviews,
                          child: Text('Premium when better reviews', overflow: TextOverflow.ellipsis),
                        ),
                        DropdownMenuItem(
                          value: PricingStrategyId.matchLowest,
                          child: Text('Match lowest (if safe)', overflow: TextOverflow.ellipsis),
                        ),
                        DropdownMenuItem(
                          value: PricingStrategyId.fixedMarkup,
                          child: Text('Fixed markup (ignore competitors)', overflow: TextOverflow.ellipsis),
                        ),
                        DropdownMenuItem(
                          value: PricingStrategyId.listAtMinEvenIfAboveLowest,
                          child: Text('List at min even if above lowest', overflow: TextOverflow.ellipsis),
                        ),
                        DropdownMenuItem(
                          value: PricingStrategyId.returnRateAware,
                          child: Text('Return-rate aware (P_min includes return cost)', overflow: TextOverflow.ellipsis),
                        ),
                      ],
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => _pricingStrategy = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _allegroFeeController,
                      decoration: const InputDecoration(labelText: 'Allegro fee %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _temuFeeController,
                      decoration: const InputDecoration(labelText: 'Temu fee %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _allegroPaymentFeeController,
                      decoration: const InputDecoration(labelText: 'Allegro payment fee %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _temuPaymentFeeController,
                      decoration: const InputDecoration(labelText: 'Temu payment fee %', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _categoryMinProfitController,
                      decoration: const InputDecoration(
                        labelText: 'Per-category min profit % (e.g. electronics:25, toys:20)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _premiumPercentController,
                      decoration: const InputDecoration(
                        labelText: 'Premium % when better reviews',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _minSalesForPremiumController,
                      decoration: const InputDecoration(
                        labelText: 'Min sales count for premium pricing',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Enable KPI-driven strategy suggestions'),
                      subtitle: const Text('Allow analytics to recommend which pricing strategy to use.'),
                      value: _kpiDrivenStrategyEnabled,
                      onChanged: (v) {
                        setState(() => _kpiDrivenStrategyEnabled = v);
                      },
                    ),
                    const SizedBox(height: 12),
                    Text('Seller return address (when customer sends return to you)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _sellerReturnStreetController,
                      decoration: const InputDecoration(labelText: 'Street', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sellerReturnCityController,
                      decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sellerReturnZipController,
                      decoration: const InputDecoration(labelText: 'ZIP', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sellerReturnCountryController,
                      decoration: const InputDecoration(labelText: 'Country code', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    Text('Incident decision rules (JSON)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Optional. JSON array of { "condition": "...", "action": "..." }. Conditions: return_shipping_gt_source_cost, defect_no_returns, default. Actions: auto_refund_without_return, process_return, request_rma, pending_manual.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _incidentRulesController,
                      decoration: const InputDecoration(
                        labelText: 'Incident rules JSON',
                        helperText: 'Optional. Conditions: return_shipping_gt_source_cost, defect_no_returns, default. Actions: auto_refund_without_return, process_return, request_rma, pending_manual.',
                        border: OutlineInputBorder(),
                        hintText: '[{"condition":"return_shipping_gt_source_cost","action":"auto_refund_without_return"}]',
                      ),
                      maxLines: 6,
                    ),
                    const SizedBox(height: 12),
                    Text('Order risk scoring (Phase 16)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _riskScoreThresholdController,
                      decoration: const InputDecoration(
                        labelText: 'Risk score threshold (0–100, empty = off)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 50',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Text('Customer abuse (Phase 25)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'When order sync runs, customer return and complaint rates (from stored metrics) are checked. If a customer exceeds the thresholds below, their new orders are set to Pending approval. Run "Refresh customer metrics" on Dashboard to update metrics.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _customerAbuseMaxReturnRatePercentController,
                      decoration: const InputDecoration(
                        labelText: 'Max return rate (%)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 30 (empty = no check)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _customerAbuseMaxComplaintRatePercentController,
                      decoration: const InputDecoration(
                        labelText: 'Max complaint rate (%)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 15 (empty = no check)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Text('Return-rate pricing (Phase 17)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'When pricing strategy is "Return-rate aware", P_min uses expected cost = sourceCost + (returnRate%/100)×returnCostPerUnit. Set defaults below (empty = 0).',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _defaultReturnRatePercentController,
                      decoration: const InputDecoration(
                        labelText: 'Default return rate % (e.g. 15)',
                        border: OutlineInputBorder(),
                        hintText: 'optional',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _defaultReturnCostPerUnitController,
                      decoration: const InputDecoration(
                        labelText: 'Default return cost per unit (PLN)',
                        border: OutlineInputBorder(),
                        hintText: 'optional',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    CheckboxListTile(
                      value: _blockFulfillWhenInsufficientStock,
                      onChanged: (v) => setState(() => _blockFulfillWhenInsufficientStock = v ?? false),
                      title: const Text('Block fulfillment when insufficient stock'),
                      subtitle: const Text(
                        'When on, orders are not placed at supplier if inventory availableToSell < order quantity (prevents overselling).',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      value: _autoPauseListingWhenMarginBelowThreshold,
                      onChanged: (v) => setState(() => _autoPauseListingWhenMarginBelowThreshold = v ?? false),
                      title: const Text('Auto-pause listing when margin below threshold'),
                      subtitle: const Text(
                        'When on, ProfitGuard will set listing status to Paused when profit margin drops below Min profit % (price drift protection).',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 12),
                    Text('Shipping validation (Phase 21)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Expected delivery = processing + shipping days. If "Marketplace max delivery days" is set, listings are rejected when expected > max.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _defaultSupplierProcessingDaysController,
                      decoration: const InputDecoration(
                        labelText: 'Default supplier processing (days)',
                        border: OutlineInputBorder(),
                        hintText: '2',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _defaultSupplierShippingDaysController,
                      decoration: const InputDecoration(
                        labelText: 'Default supplier shipping (days)',
                        border: OutlineInputBorder(),
                        hintText: '7',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _marketplaceMaxDeliveryDaysController,
                      decoration: const InputDecoration(
                        labelText: 'Marketplace max delivery (days, empty = no check)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 14',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    Text('Listing health (Phase 26)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'When "Refresh listing health" is run, per-listing return/incident and late delivery rates are computed. If auto-pause is on and a listing exceeds the thresholds below, it is set to Paused.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _listingHealthMaxReturnRatePercentController,
                      decoration: const InputDecoration(
                        labelText: 'Max return+incident rate (%)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 20 (empty = no limit)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _listingHealthMaxLateRatePercentController,
                      decoration: const InputDecoration(
                        labelText: 'Max late delivery rate (%)',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. 10 (empty = no limit)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    CheckboxListTile(
                      value: _autoPauseListingWhenHealthPoor,
                      onChanged: (v) => setState(() => _autoPauseListingWhenHealthPoor = v ?? false),
                      title: const Text('Auto-pause listing when health poor'),
                      subtitle: const Text(
                        'When on, listings whose return or late rate exceeds the above thresholds are set to Paused after listing health refresh.',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 12),
                    Text('Price refresh (per warehouse)',
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      'Warehouses publish new prices 1–2×/day (XML/CSV/API). Set refresh interval per source (minutes). Key = source id (e.g. cj, api2cart). Default 720 (12h).',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _priceRefreshIntervalBySourceController,
                      decoration: const InputDecoration(
                        labelText: 'Source refresh interval (e.g. cj:720, api2cart:360)',
                        border: OutlineInputBorder(),
                        hintText: 'empty = 720 for all',
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        final rules = await ref.read(rulesRepositoryProvider).get();
                        final fees = Map<String, double>.from(rules.marketplaceFees);
                        final paymentFees = Map<String, double>.from(rules.paymentFees);
                        final allegroFee = double.tryParse(_allegroFeeController.text);
                        final temuFee = double.tryParse(_temuFeeController.text);
                        if (allegroFee != null) fees['allegro'] = allegroFee;
                        if (temuFee != null) fees['temu'] = temuFee;
                        final allegroPaymentFee = double.tryParse(_allegroPaymentFeeController.text);
                        final temuPaymentFee = double.tryParse(_temuPaymentFeeController.text);
                        if (allegroPaymentFee != null) paymentFees['allegro'] = allegroPaymentFee;
                        if (temuPaymentFee != null) paymentFees['temu'] = temuPaymentFee;
                        final sellerStreet = _sellerReturnStreetController.text.trim();
                        final sellerCity = _sellerReturnCityController.text.trim();
                        final sellerZip = _sellerReturnZipController.text.trim();
                        final sellerCountry = _sellerReturnCountryController.text.trim();
                        Map<String, dynamic>? sellerReturnAddress;
                        if (sellerStreet.isNotEmpty || sellerCity.isNotEmpty || sellerZip.isNotEmpty || sellerCountry.isNotEmpty) {
                          sellerReturnAddress = {
                            if (sellerStreet.isNotEmpty) 'street': sellerStreet,
                            if (sellerCity.isNotEmpty) 'city': sellerCity,
                            if (sellerZip.isNotEmpty) 'zip': sellerZip,
                            if (sellerCountry.isNotEmpty) 'countryCode': sellerCountry,
                          };
                        }
                        // Parse per-category min profit % in "category:percent" format.
                        final categoryMinProfit = <String, double>{};
                        final rawCategories = _categoryMinProfitController.text.trim();
                        if (rawCategories.isNotEmpty) {
                          for (final part in rawCategories.split(',')) {
                            final item = part.trim();
                            if (item.isEmpty) continue;
                            final pieces = item.split(':');
                            if (pieces.length != 2) continue;
                            final key = pieces[0].trim();
                            final value = double.tryParse(pieces[1].trim());
                            if (key.isEmpty || value == null) continue;
                            categoryMinProfit[key] = value;
                          }
                        }
                        final priceRefreshBySource = <String, int>{};
                        final rawPriceRefresh = _priceRefreshIntervalBySourceController.text.trim();
                        if (rawPriceRefresh.isNotEmpty) {
                          for (final part in rawPriceRefresh.split(',')) {
                            final item = part.trim();
                            if (item.isEmpty) continue;
                            final pieces = item.split(':');
                            if (pieces.length != 2) continue;
                            final key = pieces[0].trim();
                            final value = int.tryParse(pieces[1].trim());
                            if (key.isEmpty || value == null || value <= 0) continue;
                            priceRefreshBySource[key] = value;
                          }
                        }
                        final incidentRulesJsonRaw = _incidentRulesController.text.trim();
                        final incidentRulesJson = incidentRulesJsonRaw.isEmpty ? null : incidentRulesJsonRaw;
                        final riskThresholdRaw = _riskScoreThresholdController.text.trim();
                        final riskScoreThreshold = riskThresholdRaw.isEmpty ? null : double.tryParse(riskThresholdRaw);
                        final defaultReturnRateRaw = _defaultReturnRatePercentController.text.trim();
                        final defaultReturnRatePercent = defaultReturnRateRaw.isEmpty ? null : double.tryParse(defaultReturnRateRaw);
                        final defaultReturnCostRaw = _defaultReturnCostPerUnitController.text.trim();
                        final defaultReturnCostPerUnit = defaultReturnCostRaw.isEmpty ? null : double.tryParse(defaultReturnCostRaw);
                        final updated = rules.copyWith(
                          searchKeywords: _keywordsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                          minProfitPercent: double.tryParse(_minProfitController.text) ?? rules.minProfitPercent,
                          defaultMarkupPercent: double.tryParse(_markupController.text) ?? rules.defaultMarkupPercent,
                          marketplaceFees: fees,
                          paymentFees: paymentFees,
                          pricingStrategy: _pricingStrategy,
                          categoryMinProfitPercent: categoryMinProfit.isNotEmpty
                              ? categoryMinProfit
                              : rules.categoryMinProfitPercent,
                          premiumWhenBetterReviewsPercent:
                              double.tryParse(_premiumPercentController.text) ?? rules.premiumWhenBetterReviewsPercent,
                          minSalesCountForPremium:
                              int.tryParse(_minSalesForPremiumController.text) ?? rules.minSalesCountForPremium,
                          kpiDrivenStrategyEnabled: _kpiDrivenStrategyEnabled,
                          sellerReturnAddress: sellerReturnAddress,
                          incidentRulesJson: incidentRulesJson,
                          riskScoreThreshold: riskScoreThreshold,
                          defaultReturnRatePercent: defaultReturnRatePercent,
                          defaultReturnCostPerUnit: defaultReturnCostPerUnit,
                          blockFulfillWhenInsufficientStock: _blockFulfillWhenInsufficientStock,
                          safetyStockBuffer: int.tryParse(_safetyStockBufferController.text.trim()) ?? rules.safetyStockBuffer,
                          autoPauseListingWhenMarginBelowThreshold: _autoPauseListingWhenMarginBelowThreshold,
                          defaultSupplierProcessingDays: int.tryParse(_defaultSupplierProcessingDaysController.text.trim()) ?? rules.defaultSupplierProcessingDays,
                          defaultSupplierShippingDays: int.tryParse(_defaultSupplierShippingDaysController.text.trim()) ?? rules.defaultSupplierShippingDays,
                          marketplaceMaxDeliveryDays: () {
                            final raw = _marketplaceMaxDeliveryDaysController.text.trim();
                            if (raw.isEmpty) return null;
                            return int.tryParse(raw);
                          }(),
                          listingHealthMaxReturnRatePercent: () {
                            final raw = _listingHealthMaxReturnRatePercentController.text.trim();
                            if (raw.isEmpty) return null;
                            return double.tryParse(raw);
                          }(),
                          listingHealthMaxLateRatePercent: () {
                            final raw = _listingHealthMaxLateRatePercentController.text.trim();
                            if (raw.isEmpty) return null;
                            return double.tryParse(raw);
                          }(),
                          autoPauseListingWhenHealthPoor: _autoPauseListingWhenHealthPoor,
                          customerAbuseMaxReturnRatePercent: () {
                            final raw = _customerAbuseMaxReturnRatePercentController.text.trim();
                            if (raw.isEmpty) return null;
                            return double.tryParse(raw);
                          }(),
                          customerAbuseMaxComplaintRatePercent: () {
                            final raw = _customerAbuseMaxComplaintRatePercentController.text.trim();
                            if (raw.isEmpty) return null;
                            return double.tryParse(raw);
                          }(),
                          priceRefreshIntervalMinutesBySource: priceRefreshBySource.isNotEmpty
                              ? priceRefreshBySource
                              : rules.priceRefreshIntervalMinutesBySource,
                        );
                        await ref.read(rulesRepositoryProvider).save(updated);
                        ref.invalidate(rulesProvider);
                        if (mounted) {
                          setState(() => _showSaveBanner = true);
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) setState(() => _showSaveBanner = false);
                          });
                        }
                      },
                      child: const Text('Save rules'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Marketplace integrations ───
            const SectionHeader(
              title: 'Marketplace integrations',
              subtitle: 'Connect Allegro, CJ, API2Cart and Temu. Configure credentials and OAuth.',
              icon: Icons.extension,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Connect marketplaces and sources here. When you later switch from demo to real APIs, use the "API features" card below as a checklist for what to enable.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── API Features (what to enable later) ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag, color: cs.primary),
                        const SizedBox(width: 8),
                        Text(
                          'API features (enable later)',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'This app starts in a very safe mode. After you connect real Allegro / CJ / API2Cart accounts and verify behaviour on test data, you can gradually enable these features.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    _FeatureRow(
                      label: 'Targets read-only',
                      description: 'When ON, automation never writes to marketplaces (no new listings, no auto-cancel, no tracking pushes). Turn OFF only when you are ready for live changes.',
                    ),
                    const SizedBox(height: 8),
                    _FeatureRow(
                      label: 'Manual approval for orders',
                      description: 'When ON, new orders must be approved manually. Consider turning OFF only after several orders have been safely fulfilled end-to-end.',
                    ),
                    const SizedBox(height: 8),
                    _FeatureRow(
                      label: 'Manual approval for listings',
                      description: 'When ON, scanned products stay in Pending until you approve them. Recommended to keep ON in production.',
                    ),
                    const SizedBox(height: 8),
                    _FeatureRow(
                      label: 'Temu / Amazon targets',
                      description: 'These are stub/experimental targets. Keep them disabled until a real, stable API is implemented and reviewed.',
                    ),
                    const SizedBox(height: 8),
                    _FeatureRow(
                      label: 'Marketplace messaging (future)',
                      description: 'Planned messages/inbox integration will start as read-only and stay behind a feature flag until fully tested.',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'See MANUAL_API_FEATURES.md in the repo for a step-by-step checklist when you first connect real APIs.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── Feature flags (DB toggles) ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.toggle_on, color: cs.primary),
                        const SizedBox(width: 8),
                        Text('Feature flags', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Toggle features without redeploying. Changes apply immediately.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    ref.watch(featureFlagsProvider).when(
                      data: (flags) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SwitchListTile(
                            title: const Text('Enable Temu target'),
                            subtitle: const Text('Show Temu in target marketplaces (experimental).'),
                            value: flags[kFeatureFlagTemuTarget] ?? false,
                            onChanged: (value) async {
                              await ref.read(featureFlagRepositoryProvider).set(kFeatureFlagTemuTarget, value);
                              ref.invalidate(featureFlagsProvider);
                            },
                          ),
                          SwitchListTile(
                            title: const Text('Enable marketplace messaging'),
                            subtitle: const Text('Show Messages/inbox when implemented.'),
                            value: flags[kFeatureFlagMessages] ?? false,
                            onChanged: (value) async {
                              await ref.read(featureFlagRepositoryProvider).set(kFeatureFlagMessages, value);
                              ref.invalidate(featureFlagsProvider);
                            },
                          ),
                        ],
                      ),
                      loading: () => const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator())),
                      error: (_, __) => Text('Could not load flags', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.error)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── CJ Dropshipping ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_shipping, color: cs.secondary),
                        const SizedBox(width: 8),
                        Text('CJ Dropshipping', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _cjEmailController,
                      decoration: const InputDecoration(labelText: 'CJ Email', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _cjApiKeyController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'CJ API Key', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () async {
                        final email = _cjEmailController.text.trim();
                        final apiKey = _cjApiKeyController.text.trim();
                        if (email.isEmpty || apiKey.isEmpty) return;
                        final storage = ref.read(secureStorageProvider);
                        await storage.write(SecureKeys.cjEmail, email);
                        await storage.write(SecureKeys.cjApiKey, apiKey);
                        final client = ref.read(cjClientProvider);
                        final ok = await client.ensureToken(email: email, apiKey: apiKey);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(ok ? 'CJ connected.' : 'CJ token failed.')),
                          );
                        }
                      },
                      child: const Text('Save CJ credentials'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── Allegro ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.storefront, color: cs.secondary),
                        const SizedBox(width: 8),
                        Text('Allegro', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _allegroClientIdController,
                      decoration: const InputDecoration(labelText: 'Client ID', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _allegroClientSecretController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Client Secret', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _allegroConnected == true ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _allegroConnected == true ? 'Connected' : 'Not connected',
                          style: TextStyle(
                            color: _allegroConnected == true ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _allegroConnecting
                          ? null
                          : () async {
                              final clientId = _allegroClientIdController.text.trim();
                              final clientSecret = _allegroClientSecretController.text.trim();
                              if (clientId.isEmpty || clientSecret.isEmpty) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Enter Client ID and Client Secret first.')),
                                  );
                                }
                                return;
                              }
                              final storage = ref.read(secureStorageProvider);
                              await storage.write(SecureKeys.allegroClientId, clientId);
                              await storage.write(SecureKeys.allegroClientSecret, clientSecret);

                              setState(() => _allegroConnecting = true);
                              final oauth = ref.read(allegroOAuthProvider);
                              final ok = await oauth.authorize();
                              setState(() => _allegroConnecting = false);
                              if (ok) await _checkAllegroStatus();

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(ok ? 'Allegro connected!' : 'Allegro OAuth failed.')),
                                );
                              }
                            },
                      child: _allegroConnecting
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Connect Allegro (OAuth)'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ─── API2Cart ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.api, color: cs.secondary),
                        const SizedBox(width: 8),
                        Text('API2Cart', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _api2cartApiKeyController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'API Key', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _api2cartStoreKeyController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Store Key', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: () async {
                        final apiKey = _api2cartApiKeyController.text.trim();
                        final storeKey = _api2cartStoreKeyController.text.trim();
                        if (apiKey.isEmpty || storeKey.isEmpty) return;
                        final storage = ref.read(secureStorageProvider);
                        await storage.write(SecureKeys.api2cartApiKey, apiKey);
                        await storage.write(SecureKeys.api2cartStoreKey, storeKey);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('API2Cart credentials saved.')),
                          );
                        }
                      },
                      child: const Text('Save API2Cart credentials'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Appearance ───
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette, color: cs.tertiary),
                        const SizedBox(width: 8),
                        Text(ref.watch(appLocalizationsProvider).appearance, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Language: Polish (default) / English
                    Row(
                      children: [
                        Icon(Icons.language, size: 20, color: cs.onSurfaceVariant),
                        const SizedBox(width: 8),
                        Text(ref.watch(appLocalizationsProvider).language, style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<Locale>(
                            key: ValueKey(ref.watch(localeProvider).valueOrNull?.languageCode ?? 'pl'),
                            initialValue: ref.watch(localeProvider).valueOrNull ?? const Locale('pl'),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            items: const [
                              DropdownMenuItem(value: Locale('pl'), child: Text('Polski')),
                              DropdownMenuItem(value: Locale('en'), child: Text('English')),
                            ],
                            onChanged: (Locale? value) async {
                              if (value != null) {
                                await ref.read(localeProvider.notifier).setLocale(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<ThemeMode>(
                      segments: [
                        ButtonSegment(value: ThemeMode.system, label: Text(ref.watch(appLocalizationsProvider).themeSystem)),
                        ButtonSegment(value: ThemeMode.light, label: Text(ref.watch(appLocalizationsProvider).themeLight)),
                        ButtonSegment(value: ThemeMode.dark, label: Text(ref.watch(appLocalizationsProvider).themeDark)),
                      ],
                      selected: {ref.watch(themeModeProvider)},
                      onSelectionChanged: (modes) {
                        ref.read(themeModeProvider.notifier).state = modes.first;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Developer Tools ───
            Card(
              color: cs.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.developer_mode, color: cs.error),
                        const SizedBox(width: 8),
                        Text('Developer Tools', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'These actions affect the live database.',
                      style: TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      icon: const Icon(Icons.dataset),
                      label: const Text('Load demo data'),
                      onPressed: () async {
                        final seedService = ref.read(seedServiceProvider);
                        try {
                          final result = await seedService.seedAll();
                          _invalidateAllProviders(ref);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Seeded ${result.total} entities (${result.orders} orders, ${result.listings} listings, ${result.products} products).')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Seed failed: $e')),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      icon: const Icon(Icons.bolt),
                      label: const Text('Load heavy demo data (~20k orders)'),
                      onPressed: () async {
                        final seedService = ref.read(seedServiceProvider);
                        try {
                          final result = await seedService.seedHeavy();
                          _invalidateAllProviders(ref);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Seeded HEAVY demo: ${result.total} entities '
                                  '(${result.orders} orders, ${result.listings} listings, ${result.products} products).',
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Heavy seed failed: $e')),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      icon: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
                      label: Text('Drop all data', style: TextStyle(color: Theme.of(context).colorScheme.error)),
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Drop all data?'),
                            content: const Text('This will permanently delete all data from the database.'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                              FilledButton(
                                style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Delete everything'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed != true) return;
                        final seedService = ref.read(seedServiceProvider);
                        try {
                          await seedService.dropAll();
                          _invalidateAllProviders(ref);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All data dropped.')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Drop failed: $e')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _invalidateAllProviders(WidgetRef ref) {
    ref.invalidate(listingsProvider);
    ref.invalidate(ordersProvider);
    ref.invalidate(rulesProvider);
    ref.invalidate(suppliersProvider);
    ref.invalidate(supplierOffersProvider);
    ref.invalidate(returnRequestsProvider);
    ref.invalidate(decisionLogsProvider);
    ref.invalidate(marketplaceAccountsProvider);
    ref.invalidate(pendingListingsProvider);
    ref.invalidate(pendingOrdersProvider);
  }
}
