import 'package:flutter/material.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key, this.count = 5});
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return ListView.builder(
      itemCount: count,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, _) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 200, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
                const SizedBox(height: 10),
                Container(width: 300, height: 12, decoration: BoxDecoration(color: color.withAlpha(150), borderRadius: BorderRadius.circular(4))),
                const SizedBox(height: 8),
                Container(width: 150, height: 12, decoration: BoxDecoration(color: color.withAlpha(100), borderRadius: BorderRadius.circular(4))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
