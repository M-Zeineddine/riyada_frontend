import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';

class CourtsPage extends ConsumerStatefulWidget {
  const CourtsPage({super.key});

  @override
  ConsumerState<CourtsPage> createState() => _CourtsPageState();
}

class _CourtsPageState extends ConsumerState<CourtsPage> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(courtsFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Courts')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sport: ${filters.sport}'),
            Text('Sort: ${filters.sort}'),
          ],
        ),
      ),
    );
  }
}
