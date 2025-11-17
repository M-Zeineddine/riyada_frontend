import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/shared/models/sport_category_model.dart';

final nearbyCourtsProvider = Provider<List<CourtModel>>((ref) {
  return const [
    CourtModel(
      id: 'c1',
      name: 'Green Field Court',
      location: 'Beirut, Lebanon',
      pricePerHour: 30,
      imageUrl: 'https://picsum.photos/seed/field1/400/250',
      distanceKm: 3,
      sport: 'Football',
      lat: 33.8938,
      lng: 35.5018,
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field2/400/250',
      distanceKm: 5,
      sport: 'Football',
      lat: 33.5600,
      lng: 35.3750,
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field3/400/250',
      distanceKm: 8,
      sport: 'Football',
      lat: 33.2710,
      lng: 35.2038,
    ),
    CourtModel(
      id: 'c2',
      name: 'Urban Sports Arena',
      location: 'Saida, Lebanon',
      pricePerHour: 25,
      imageUrl: 'https://picsum.photos/seed/field4/400/250',
      distanceKm: 10,
      sport: 'Football',
      lat: 33.8925,
      lng: 35.4955,
    ),
  ];
});

final sportsProvider = Provider<List<SportCategory>>((ref) {
  return const [
    SportCategory(name: 'Tennis', iconAsset: '🎾'),
    SportCategory(name: 'Basketball', iconAsset: '🏀'),
    SportCategory(name: 'Football', iconAsset: '⚽'),
    SportCategory(name: 'Padel', iconAsset: '🎾'),
    SportCategory(name: 'Volleyball', iconAsset: '🏐'),
    SportCategory(name: 'Badminton', iconAsset: '🏸'),
    SportCategory(name: 'Table Tennis', iconAsset: '🏓'),
    SportCategory(name: 'Handball', iconAsset: '🤾‍♂️'),
  ];
});
