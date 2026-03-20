import 'package:flutter/material.dart';

import 'info_icon.dart';

/// Section header for dashboard, settings, and list screens.
/// Provides clear visual hierarchy between logical blocks.
/// [infoTooltip] when set shows an info icon explaining how to use this section.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.infoTooltip,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  /// If set, an info icon is shown next to the title with this explanation.
  final String? infoTooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (infoTooltip != null && infoTooltip!.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      InfoIcon(tooltip: infoTooltip!),
                    ],
                  ],
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
