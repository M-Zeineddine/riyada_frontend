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

final sportsProvider = Provider<List<Sport>>((ref) {
  return const [
    Sport(name: 'Tennis', iconAsset: '🎾'),
    Sport(name: 'Basketball', iconAsset: '🏀'),
    Sport(name: 'Football', iconAsset: '⚽'),
    Sport(name: 'Padel', iconAsset: '🎾'),
    Sport(name: 'Volleyball', iconAsset: '🏐'),
    Sport(name: 'Badminton', iconAsset: '🏸'),
    Sport(name: 'Table Tennis', iconAsset: '🏓'),
    Sport(name: 'Handball', iconAsset: '🤾‍♂️'),
  ];
});

class Sport {
  final String name;
  final String iconAsset; // can also use an IconData instead

  const Sport({required this.name, required this.iconAsset});
}
