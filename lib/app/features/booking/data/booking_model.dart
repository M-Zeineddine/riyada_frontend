class BookingModel {
  final String id;
  final String courtId;
  final String courtName;
  final String courtLocation;
  final String courtImageUrl;
  final String sport;
  final DateTime date;
  final String timeSlot;
  final double durationHours;
  final int pricePerHour;
  final BookingStatus status;
  final DateTime createdAt;
  final double lat;
  final double lng;

  const BookingModel({
    required this.id,
    required this.courtId,
    required this.courtName,
    required this.courtLocation,
    required this.courtImageUrl,
    required this.sport,
    required this.date,
    required this.timeSlot,
    required this.durationHours,
    required this.pricePerHour,
    required this.status,
    required this.createdAt,
    required this.lat,
    required this.lng,
  });

  double get totalPrice => pricePerHour * durationHours;

  bool get isUpcoming =>
      date.isAfter(DateTime.now()) && status == BookingStatus.confirmed;
  bool get isPast => date.isBefore(DateTime.now());
}

enum BookingStatus { confirmed, cancelled, completed }
