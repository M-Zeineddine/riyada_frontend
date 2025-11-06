// lib/app/features/court/courts_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';
import 'package:riyada_frontend/app/features/court/application/courts_search_provider.dart';
import 'package:riyada_frontend/app/features/court/presentation/widgets/courts_search_bar.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text('Courts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CourtsSearchBar(onFilterTap: () {}),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Court $index'),
                    subtitle: Text(
                      'Search: $searchQuery, Sport: ${filters.sport}',
                    ),
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
