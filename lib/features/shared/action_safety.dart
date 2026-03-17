import 'package:flutter/material.dart';

/// Risk level for UI actions; used to decide confirmation and button style.
enum ActionRiskLevel {
  low,
  medium,
  high,
}

/// Styling and confirmation for action safety UX.
/// Low risk: Outlined, no confirm. Medium: Filled or Outlined, optional confirm. High: destructive style + confirm.
class ActionSafety {
  ActionSafety._();

  /// Returns foreground color for a destructive (high-risk) text button.
  static Color destructiveForeground(BuildContext context) =>
      Theme.of(context).colorScheme.error;

  /// Returns style for a destructive filled button (e.g. Reject, Delete, Write off).
  static ButtonStyle destructiveFilledButton(BuildContext context) =>
      FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error);
}
