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
      lat: 33.8938,
      lng: 35.5018,
    ),
    BookingModel(
      id: 'b2',
      courtId: 'c3',
      courtName: 'Seaside Court',
      courtLocation: 'Tyre, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field3/400/250',
      sport: 'Tennis',
      date: DateTime.now().add(const Duration(days: 5)),
      timeSlot: '2:00 PM - 3:30 PM',
      durationHours: 1.5,
      pricePerHour: 28,
      status: BookingStatus.confirmed,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      lat: 33.5600,
      lng: 35.3750,
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
      lat: 33.2710,
      lng: 35.2038,
    ),
    BookingModel(
      id: 'b4',
      courtId: 'c4',
      courtName: 'Downtown Sports Hub',
      courtLocation: 'Beirut, Lebanon',
      courtImageUrl: 'https://picsum.photos/seed/field4/400/250',
      sport: 'Padel',
      date: DateTime.now().subtract(const Duration(days: 2)),
      timeSlot: '6:00 PM - 8:00 PM',
      durationHours: 2.0,
      pricePerHour: 35,
      status: BookingStatus.cancelled,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      lat: 33.8925,
      lng: 35.4955,
    ),
  ];
});

final upcomingBookingsProvider = Provider<List<BookingModel>>((ref) {
  final all = ref.watch(allBookingsProvider);
  final now = DateTime.now();
  final list = all.where((b) => b.date.isAfter(now)).toList();
  list.sort((a, b) => a.date.compareTo(b.date));
  return list;
});

final pastBookingsProvider = Provider<List<BookingModel>>((ref) {
  final all = ref.watch(allBookingsProvider);
  final now = DateTime.now();
  final list = all.where((b) => b.date.isBefore(now)).toList();
  list.sort((a, b) => b.date.compareTo(a.date));
  return list;
});

// Selected date for booking
class SelectedBookingDate extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void setDate(DateTime date) {
    state = date;
    ref.read(selectedTimeSlotProvider.notifier).clear();
  }

  void clear() {
    state = null;
    ref.read(selectedTimeSlotProvider.notifier).clear();
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

final selectedDurationProvider = NotifierProvider<SelectedDuration, double>(
  () => SelectedDuration(),
);

class SelectedDuration extends Notifier<double> {
  @override
  double build() => 1.0; // Default 1 hour

  void setDuration(double hours) {
    state = hours;
    ref.read(selectedTimeSlotProvider.notifier).clear();
  }

  void clear() {
    state = 1.0;
    ref.read(selectedTimeSlotProvider.notifier).clear();
  }
}

final totalPriceProvider = Provider.family<double, double>((ref, pricePerHour) {
  final hours = ref.watch(selectedDurationProvider);
  return pricePerHour * hours;
});

final canConfirmBookingProvider = Provider<bool>((ref) {
  final date = ref.watch(selectedBookingDateProvider);
  final slot = ref.watch(selectedTimeSlotProvider);
  return date != null && slot != null;
});
