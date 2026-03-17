import 'package:flutter/material.dart';

/// Small info icon with tooltip explaining how to use a field or action.
/// Use next to labels, section headers, or buttons so users understand what something does.
class InfoIcon extends StatelessWidget {
  const InfoIcon({
    super.key,
    required this.tooltip,
    this.size = 18,
    this.icon,
  });

  /// Explanation shown in tooltip (and in dialog if user taps and text is long).
  final String tooltip;
  final double size;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = icon ?? Icons.info_outline;
    return Tooltip(
      message: tooltip,
      preferBelow: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: () {
          if (tooltip.length > 200) {
            showDialog<void>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Help'),
                content: SingleChildScrollView(
                  child: Text(tooltip, style: theme.textTheme.bodyMedium),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Icon(iconData, size: size, color: theme.colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
