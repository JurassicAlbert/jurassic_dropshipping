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
  final _allegroClientIdController = TextEditingController();
  final _allegroClientSecretController = TextEditingController();
  final _api2cartApiKeyController = TextEditingController();
  final _api2cartStoreKeyController = TextEditingController();
  bool _rulesLoaded = false;
  bool _allegroConnecting = false;
  bool? _allegroConnected;

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
    _cjEmailController.dispose();
    _cjApiKeyController.dispose();
    _allegroClientIdController.dispose();
    _allegroClientSecretController.dispose();
    _api2cartApiKeyController.dispose();
    _api2cartStoreKeyController.dispose();
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
              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rules saved.')));
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
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ok ? 'CJ connected.' : 'CJ token failed.')),
                );
              }
            },
            child: const Text('Save CJ credentials'),
          ),
          const SizedBox(height: 24),
          const Text('Allegro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
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
          const SizedBox(height: 24),
          const Text('API2Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
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
    );
  }
}
