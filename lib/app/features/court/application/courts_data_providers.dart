// courts_data_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';
import 'package:riyada_frontend/app/features/court/application/courts_search_provider.dart';

final allCourtsProvider = Provider<List<CourtModel>>((ref) {
  return const [
    CourtModel(
      id: 'c1',
      name: 'Green Field Court',
      location: 'Beirut, Lebanon',
      pricePerHour: 30,
      imageUrl: 'https://picsum.photos/seed/field1/400/250',
      distanceKm: 3,
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field2/400/250',
      distanceKm: 5,
    ),
    CourtModel(
      id: 'c3',
      name: 'Seaside Court',
      location: 'Tyre, Lebanon',
      pricePerHour: 28,
      imageUrl: 'https://picsum.photos/seed/field3/400/250',
      distanceKm: 8,
    ),
    CourtModel(
      id: 'c4',
      name: 'Downtown Sports Hub',
      location: 'Beirut, Lebanon',
      pricePerHour: 35,
      imageUrl: 'https://picsum.photos/seed/field4/400/250',
      distanceKm: 10,
    ),
  ];
});

final filteredCourtsProvider = Provider<List<CourtModel>>((ref) {
  final all = ref.watch(allCourtsProvider);
  final q = ref.watch(courtsSearchQueryProvider).trim().toLowerCase();
  final filter = ref.watch(courtsFilterProvider);

  var items = q.isEmpty
      ? all
      : all.where((c) {
          final name = c.name.toLowerCase();
          final loc = c.location.toLowerCase();
          return name.contains(q) || loc.contains(q);
        }).toList();

  if (filter.sport != null && filter.sport!.isNotEmpty) {
    final s = filter.sport!.toLowerCase();
    items = items.where((c) {
      return c.name.toLowerCase().contains(s);
    }).toList();
  }

  switch (filter.sort) {
    case 'nearby':
      items.sort(
        (a, b) => (a.distanceKm ?? 1 << 30).compareTo(b.distanceKm ?? 1 << 30),
      );
      break;
    case 'priceAsc':
      items.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
      break;
    case 'priceDesc':
      items.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
      break;
    default:
      break;
  }

  return items;
});
