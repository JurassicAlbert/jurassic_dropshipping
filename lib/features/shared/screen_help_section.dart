import 'package:flutter/material.dart';

/// Top-of-screen explanation for each main view.
/// Use for consistent context help across the admin UI.
/// [description] explains what the screen does; [howToUse] optionally explains how to use it.
class ScreenHelpSection extends StatelessWidget {
  const ScreenHelpSection({
    super.key,
    required this.description,
    this.title,
    this.howToUse,
  });

  final String description;
  final String? title;
  /// Optional second paragraph: "How to use: ..."
  final String? howToUse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          if (howToUse != null && howToUse!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              howToUse!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
