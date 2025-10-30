class CourtModel {
  final String id;
  final String name;
  final String location;
  final int pricePerHour;
  final String imageUrl;
  final int? distanceKm;

  const CourtModel({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerHour,
    required this.imageUrl,
    required this.distanceKm,
  });
}
