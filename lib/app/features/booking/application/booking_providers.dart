import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riyada_frontend/app/features/booking/data/booking_model.dart';

// All bookings provider (mock data)
final allBookingsProvider = Provider<List<BookingModel>>((ref) {
  return [
    BookingModel(
      id: 'b1',
      courtId: 'c1',
      courtName: 'Green Field Court',
      courtLocation: 'Beirut, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field1/400/250',
      sport: 'Football',
      date: DateTime.now().add(const Duration(days: 2)),
      timeSlot: '10:00 AM - 11:00 AM',
      durationHours: 1.0,
      pricePerHour: 30,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    BookingModel(
      id: 'b2',
      courtId: 'c3',
      courtName: 'Seaside Court',
      courtLocation: 'Tyre, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field3/400/250',
      sport: 'Tennis',
      date: DateTime.now().add(const Duration(days: 5)),
      timeSlot: '2:00 PM - 3:00 PM',
      durationHours: 1.5,
      pricePerHour: 28,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    BookingModel(
      id: 'b3',
      courtId: 'c2',
      courtName: 'Urban Sports Arena',
      courtLocation: 'Saida, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field2/400/250',
      sport: 'Basketball',
      date: DateTime.now().subtract(const Duration(days: 5)),
      timeSlot: '4:00 PM - 5:00 PM',
      durationHours: 1.0,
      pricePerHour: 25,
      status: BookingStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    BookingModel(
      id: 'b4',
      courtId: 'c4',
      courtName: 'Downtown Sports Hub',
      courtLocation: 'Beirut, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field4/400/250',
      sport: 'Padel',
      date: DateTime.now().subtract(const Duration(days: 2)),
      timeSlot: '6:00 PM - 7:00 PM',
      durationHours: 2.0,
      pricePerHour: 35,
      status: BookingStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];
});

// Upcoming bookings
final upcomingBookingsProvider = Provider<List<BookingModel>>((ref) {
  final all = ref.watch(allBookingsProvider);
  return all.where((b) => b.isUpcoming).toList()
    ..sort((a, b) => a.date.compareTo(b.date));
});

// Past bookings
final pastBookingsProvider = Provider<List<BookingModel>>((ref) {
  final all = ref.watch(allBookingsProvider);
  return all.where((b) => b.isPast).toList()
    ..sort((a, b) => b.date.compareTo(a.date));
});

// Selected date for booking
class SelectedBookingDate extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void setDate(DateTime date) {
    state = date;
  }

  void clear() {
    state = null;
  }
}

final selectedBookingDateProvider =
    NotifierProvider<SelectedBookingDate, DateTime?>(() {
      return SelectedBookingDate();
    });

// Selected time slot for booking
class SelectedTimeSlot extends Notifier<String?> {
  @override
  String? build() => null;

  void setTimeSlot(String slot) {
    state = slot;
  }

  void clear() {
    state = null;
  }
}

final selectedTimeSlotProvider = NotifierProvider<SelectedTimeSlot, String?>(
  () {
    return SelectedTimeSlot();
  },
);

class SelectedDuration extends Notifier<double> {
  @override
  double build() => 1.0; // Default 1 hour

  void setDuration(double hours) {
    state = hours;
  }

  void clear() {
    state = 1.0;
  }
}

final selectedDurationProvider = NotifierProvider<SelectedDuration, double>(() {
  return SelectedDuration();
});
