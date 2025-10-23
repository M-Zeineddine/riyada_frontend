class CourtModel {
  final String id;
  final String name;
  final String location;
  final double pricePerHour;
  final String imageUrl;

  const CourtModel({
    required this.id,
    required this.name,
    required this.location,
    required this.pricePerHour,
    required this.imageUrl,
  });
}
