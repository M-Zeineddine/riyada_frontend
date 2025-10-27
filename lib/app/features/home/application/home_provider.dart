import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';

final nearbyCourtsProvider = Provider<List<CourtModel>>((ref) {
  return const [
    CourtModel(
      id: 'c1',
      name: 'Green Field Court',
      location: 'Beirut, Lebanon',
      pricePerHour: 30.0,
      imageUrl: 'https://picsum.photos/seed/field1/400/250',
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25.0,
      imageUrl: 'https://picsum.photos/seed/field2/400/250',
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25.0,
      imageUrl: 'https://picsum.photos/seed/field3/400/250',
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25.0,
      imageUrl: 'https://picsum.photos/seed/field4/400/250',
    ),
  ];
});
