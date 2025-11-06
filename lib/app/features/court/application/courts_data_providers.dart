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
      sport: 'Football',
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field2/400/250',
      distanceKm: 5,
      sport: 'Basketball',
    ),
    CourtModel(
      id: 'c3',
      name: 'Seaside Court',
      location: 'Tyre, Lebanon',
      pricePerHour: 28,
      imageUrl: 'https://picsum.photos/seed/field3/400/250',
      distanceKm: 8,
      sport: 'Tennis',
    ),
    CourtModel(
      id: 'c4',
      name: 'Downtown Sports Hub',
      location: 'Beirut, Lebanon',
      pricePerHour: 35,
      imageUrl: 'https://picsum.photos/seed/field4/400/250',
      distanceKm: 10,
      sport: 'Padel',
    ),
    CourtModel(
      id: 'c5',
      name: 'Beach Volleyball Arena',
      location: 'Jounieh, Lebanon',
      pricePerHour: 20,
      imageUrl: 'https://picsum.photos/seed/field5/400/250',
      distanceKm: 7,
      sport: 'Volleyball',
    ),
    CourtModel(
      id: 'c6',
      name: 'City Football Stadium',
      location: 'Tripoli, Lebanon',
      pricePerHour: 40,
      imageUrl: 'https://picsum.photos/seed/field6/400/250',
      distanceKm: 12,
      sport: 'Football',
    ),
  ];
});

final filteredCourtsProvider = Provider<List<CourtModel>>((ref) {
  final all = ref.watch(allCourtsProvider);
  final q = ref.watch(courtsSearchQueryProvider).trim().toLowerCase();
  final filter = ref.watch(courtsFilterProvider);

  List<CourtModel> items = q.isEmpty
      ? List<CourtModel>.from(all)
      : all.where((c) {
          final name = c.name.toLowerCase();
          final loc = c.location.toLowerCase();
          return name.contains(q) || loc.contains(q);
        }).toList();

  if (filter.sport != null &&
      filter.sport!.isNotEmpty &&
      filter.sport != 'all_sports') {
    items = items
        .where((c) => c.sport.toLowerCase() == filter.sport!.toLowerCase())
        .toList();
  }

  switch (filter.sort) {
    case 'nearby':
      items.sort(
        (a, b) => (a.distanceKm ?? 1 << 30).compareTo(b.distanceKm ?? 1 << 30),
      );
      break;
    case 'price_low':
      items.sort((a, b) => a.pricePerHour.compareTo(b.pricePerHour));
      break;
    case 'price_high':
      items.sort((a, b) => b.pricePerHour.compareTo(a.pricePerHour));
      break;
    default:
      break;
  }

  return items;
});
