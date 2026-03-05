import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Placeholder returns screen. Detailed returns modeling and data storage
/// will be added when the Return entity is introduced.
class ReturnsScreen extends ConsumerWidget {
  const ReturnsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Returns dashboard coming soon. It will show 2-week no-reason returns, '
          'their statuses, and per-supplier financial impact.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

