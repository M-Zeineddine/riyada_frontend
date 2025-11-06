// lib/app/features/court/presentation/widgets/active_filters_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';

class ActiveFiltersRow extends ConsumerWidget {
  const ActiveFiltersRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(courtsFilterProvider);
    final hasFilters =
        (filter.sport != null && filter.sport != 'all_sports') ||
        (filter.sort != null && filter.sort!.isNotEmpty);

    if (!hasFilters) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 8, left: 16, right: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          if (filter.sport != null && filter.sport != 'all_sports')
            _ActiveFilterChip(
              label: filter.sport!,
              onRemove: () =>
                  ref.read(courtsFilterProvider.notifier).setSport(null),
            ),
          if (filter.sort != null && filter.sort!.isNotEmpty)
            _ActiveFilterChip(
              label: _getSortLabel(filter.sort!),
              onRemove: () =>
                  ref.read(courtsFilterProvider.notifier).setSort(null),
            ),
        ],
      ),
    );
  }

  String _getSortLabel(String sort) {
    switch (sort) {
      case 'nearby':
        return 'Nearby';
      case 'price_low':
        return 'Price: Low';
      case 'price_high':
        return 'Price: High';
      default:
        return sort;
    }
  }
}

class _ActiveFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _ActiveFilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 12, right: 4, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12),
            child: Icon(Icons.close, size: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
