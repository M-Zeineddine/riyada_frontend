class CourtModel {
  final String id;
  final String name;
  final String location;
  final int pricePerHour;
  final String imageUrl;
  final int? distanceKm;
  final String sport;
  final List<String>? amenities;
  final double lat;
  final double lng;

  const CourtModel({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerHour,
    required this.imageUrl,
    required this.distanceKm,
    required this.sport,
    this.amenities,
    required this.lat,
    required this.lng,
  });
}
