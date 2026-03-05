import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/services/secure_storage_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _keywordsController = TextEditingController();
  final _minProfitController = TextEditingController();
  final _markupController = TextEditingController();
  final _cjEmailController = TextEditingController();
  final _cjApiKeyController = TextEditingController();
  bool _rulesLoaded = false;

  @override
  void dispose() {
    _keywordsController.dispose();
    _minProfitController.dispose();
    _markupController.dispose();
    _cjEmailController.dispose();
    _cjApiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rulesAsync = ref.watch(rulesProvider);
    rulesAsync.whenData((rules) {
      if (!_rulesLoaded) {
        _rulesLoaded = true;
        _keywordsController.text = rules.searchKeywords.join(', ');
        _minProfitController.text = rules.minProfitPercent.toString();
        _markupController.text = rules.defaultMarkupPercent.toString();
      }
    });
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Rules', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          rulesAsync.when(
            data: (_) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          TextField(
            controller: _keywordsController,
            decoration: const InputDecoration(labelText: 'Search keywords (comma-separated)', border: OutlineInputBorder()),
            maxLines: 1,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _minProfitController,
            decoration: const InputDecoration(labelText: 'Min profit %', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _markupController,
            decoration: const InputDecoration(labelText: 'Default markup %', border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () async {
              final rules = await ref.read(rulesRepositoryProvider).get();
              final updated = rules.copyWith(
                searchKeywords: _keywordsController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                minProfitPercent: double.tryParse(_minProfitController.text) ?? rules.minProfitPercent,
                defaultMarkupPercent: double.tryParse(_markupController.text) ?? rules.defaultMarkupPercent,
              );
              await ref.read(rulesRepositoryProvider).save(updated);
              ref.invalidate(rulesProvider);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rules saved.')));
            },
            child: const Text('Save rules'),
          ),
          const SizedBox(height: 24),
          const Text('CJ Dropshipping', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
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
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ok ? 'CJ connected.' : 'CJ token failed.')),
                );
              }
            },
            child: const Text('Save CJ credentials'),
          ),
        ],
      ),
    );
  }
}
