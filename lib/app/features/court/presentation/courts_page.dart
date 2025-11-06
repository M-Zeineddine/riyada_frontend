// lib/app/features/court/courts_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';
import 'package:riyada_frontend/app/features/court/application/courts_search_provider.dart';
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
    final filters = ref.watch(courtsFilterProvider);
    final searchQuery = ref.watch(courtsSearchQueryProvider);
    final nearbyCourtsList = ref.watch(searchedCourtsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Courts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CourtsSearchBar(onFilterTap: () {}),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: nearbyCourtsList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final court = nearbyCourtsList[index];
                return NearbyCourtCard(
                  court: court,
                  onTap: () => context.pushNamed(
                    'courtDetail',
                    pathParameters: {'id': court.id},
                  ),
                  onBook: () => context.pushNamed(
                    'courtDetail',
                    pathParameters: {'id': court.id},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
