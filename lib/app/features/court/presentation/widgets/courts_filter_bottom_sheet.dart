// lib/app/features/court/presentation/widgets/courts_filter_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';

class CourtsFilterBottomSheet extends ConsumerWidget {
  const CourtsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(courtsFilterProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(courtsFilterProvider.notifier).reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Sports Section
          Text(
            'Sports',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChip(
                label: 'All Sports',
                isSelected:
                    filter.sport == null || filter.sport == 'all_sports',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSport(null);
                },
              ),
              _FilterChip(
                label: 'Football',
                isSelected: filter.sport == 'Football',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSport('Football');
                },
              ),
              _FilterChip(
                label: 'Basketball',
                isSelected: filter.sport == 'Basketball',
                onTap: () {
                  ref
                      .read(courtsFilterProvider.notifier)
                      .setSport('Basketball');
                },
              ),
              _FilterChip(
                label: 'Tennis',
                isSelected: filter.sport == 'Tennis',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSport('Tennis');
                },
              ),
              _FilterChip(
                label: 'Padel',
                isSelected: filter.sport == 'Padel',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSport('Padel');
                },
              ),
              _FilterChip(
                label: 'Volleyball',
                isSelected: filter.sport == 'Volleyball',
                onTap: () {
                  ref
                      .read(courtsFilterProvider.notifier)
                      .setSport('Volleyball');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            'Sort By',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _FilterChip(
                label: 'Nearby',
                isSelected: filter.sort == 'nearby',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSort('nearby');
                },
              ),
              _FilterChip(
                label: 'Price: Low to High',
                isSelected: filter.sort == 'price_low',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSort('price_low');
                },
              ),
              _FilterChip(
                label: 'Price: High to Low',
                isSelected: filter.sort == 'price_high',
                onTap: () {
                  ref.read(courtsFilterProvider.notifier).setSort('price_high');
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: theme.colorScheme.primary,
              ),
              child: const Text(
                'Apply Filters',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
