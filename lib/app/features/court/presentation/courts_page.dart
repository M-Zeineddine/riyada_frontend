// lib/app/features/court/courts_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_data_providers.dart';
import 'package:riyada_frontend/app/features/court/presentation/widgets/courts_search_bar.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/nearby_court_card.dart';

class CourtsPage extends ConsumerStatefulWidget {
  const CourtsPage({super.key});

  @override
  ConsumerState<CourtsPage> createState() => _CourtsPageState();
}

class _CourtsPageState extends ConsumerState<CourtsPage> {
  @override
  Widget build(BuildContext context) {
    final courts = ref.watch(filteredCourtsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Courts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: CourtsSearchBar(onFilterTap: () {}),
          ),

          Expanded(
            child: courts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No results found',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Try adjusting your search or filters.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: courts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (_, i) {
                      final court = courts[i];
                      return NearbyCourtCard(
                        court: court,
                        onTap: () => {
                          // context.pushNamed(
                          //   'courtDetail',
                          //   pathParameters: {'id': court.id},
                          // ),
                        },
                        onBook: () => {
                          // context.pushNamed(
                          //   'courtDetail',
                          //   pathParameters: {'id': court.id},
                          // ),
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
