import 'package:flutter/material.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.filterChips = const [],
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final List<Widget> filterChips;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                    )
                  : null,
              border: const OutlineInputBorder(),
              isDense: true,
            ),
          ),
          if (filterChips.isNotEmpty) ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: filterChips),
            ),
          ],
        ],
      ),
    );
  }
}
