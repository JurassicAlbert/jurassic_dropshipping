import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jurassic_dropshipping/app_providers.dart';
import 'package:jurassic_dropshipping/services/messaging/customer_message_analyzer.dart';

class MessageInsights extends ConsumerWidget {
  const MessageInsights({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyzer = ref.watch(customerMessageAnalyzerProvider);
    final responseEngine = ref.watch(responseEngineProvider);
    final analysis = analyzer.analyze(message);
    final suggestion = responseEngine.suggest(analysis: analysis, buyerMessage: message);

    Color colorFor(String cat) {
      switch (cat) {
        case MessageCategory.returnIntent:
          return Colors.orange.shade700;
        case MessageCategory.complaint:
          return Colors.red.shade700;
        case MessageCategory.escalation:
          return Colors.red.shade900;
        case MessageCategory.question:
          return Colors.blue.shade700;
        default:
          return Colors.grey.shade700;
      }
    }

    final catColor = colorFor(analysis.category);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Chip(
              label: Text(analysis.category),
              backgroundColor: catColor.withValues(alpha: 0.12),
              side: BorderSide(color: catColor.withValues(alpha: 0.5)),
              labelStyle: TextStyle(color: catColor, fontWeight: FontWeight.w600),
            ),
            Text(
              'Confidence ${(analysis.confidence * 100).toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            if (analysis.signals.isNotEmpty)
              Tooltip(
                message: analysis.signals.join(', '),
                child: const Icon(Icons.info_outline, size: 16),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                suggestion.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: suggestion.body));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Suggested reply copied.')));
                }
              },
              icon: const Icon(Icons.copy, size: 16),
              label: const Text('Copy reply'),
            ),
          ],
        ),
        Text(
          suggestion.body,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

