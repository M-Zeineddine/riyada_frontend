import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';

class CourtsSearchQuery extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

final courtsSearchQueryProvider = NotifierProvider<CourtsSearchQuery, String>(
  () {
    return CourtsSearchQuery();
  },
);

final searchedCourtsProvider = Provider<List<CourtModel>>((ref) {
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
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field3/400/250',
      distanceKm: 8,
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field4/400/250',
      distanceKm: 10,
    ),
  ];
});
