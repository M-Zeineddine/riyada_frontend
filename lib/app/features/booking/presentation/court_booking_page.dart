import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/booking/application/booking_providers.dart';

class CourtBookingPage extends ConsumerStatefulWidget {
  final CourtModel court;

  const CourtBookingPage({super.key, required this.court});

  @override
  ConsumerState<CourtBookingPage> createState() => _CourtBookingPageState();
}

class _CourtBookingPageState extends ConsumerState<CourtBookingPage> {
  final DateFormat _fmt = DateFormat('h:mm a');

  List<DateTime> _buildHalfHourStarts() {
    // e.g., 8:00 to 20:00
    final open = DateTime(2000, 1, 1, 8, 0);
    final close = DateTime(2000, 1, 1, 20, 0);
    final step = const Duration(minutes: 30);

    final starts = <DateTime>[];
    var t = open;
    while (t.add(step).isBefore(close) || t.add(step).isAtSameMomentAs(close)) {
      // last start can be 19:30 so that 19:30-20:00 is valid
      starts.add(t);
      t = t.add(step);
    }
    return starts;
  }

  String _label(DateTime start) {
    final end = start.add(const Duration(minutes: 30));
    return '${_fmt.format(start)} - ${_fmt.format(end)}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null) {
      ref.read(selectedBookingDateProvider.notifier).setDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedBookingDateProvider);
    final selectedTimeSlot = ref.watch(selectedTimeSlotProvider);
    final selectedDuration = ref.watch(selectedDurationProvider);
    final canConfirm = ref.watch(canConfirmBookingProvider);
    final total = ref.watch(
      totalPriceProvider(widget.court.pricePerHour.toDouble()),
    );

    final starts = _buildHalfHourStarts();
    final labels = starts.map(_label).toList();

    final durationHours = selectedDuration; // 1.0, 1.5, 2.0
    final slotsNeeded = (durationHours * 2).round(); // 2, 3, 4

    // figure out current start index (if any) from the stored label
    final selectedStartIndex = selectedTimeSlot == null
        ? -1
        : labels.indexOf(selectedTimeSlot);

    // compute selected end label to show somewhere
    String? selectedRangeText;
    if (selectedStartIndex >= 0) {
      final endDT = starts[selectedStartIndex].add(
        Duration(minutes: (slotsNeeded * 30)),
      );
      selectedRangeText =
          '${_fmt.format(starts[selectedStartIndex])} - ${_fmt.format(endDT)}';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Book Court')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Court Info Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.court.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.court.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.court.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.court.pricePerHour}/hour',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Select Date
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Date',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () => _selectDate(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            selectedDate != null
                                ? DateFormat(
                                    'EEE, MMM dd, yyyy',
                                  ).format(selectedDate)
                                : 'Choose a date',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Select Time Slot
            if (selectedDate != null) ...[
              // 1) Select Duration (moved before slots)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Duration',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _DurationOption(
                            duration: 1.0,
                            label: '1 Hour',
                            price: widget.court.pricePerHour,
                            isSelected: selectedDuration == 1.0,
                            onTap: () => ref
                                .read(selectedDurationProvider.notifier)
                                .setDuration(1.0),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DurationOption(
                            duration: 1.5,
                            label: '1.5 Hours',
                            price: (widget.court.pricePerHour * 1.5).toInt(),
                            isSelected: selectedDuration == 1.5,
                            onTap: () => ref
                                .read(selectedDurationProvider.notifier)
                                .setDuration(1.5),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DurationOption(
                            duration: 2.0,
                            label: '2 Hours',
                            price: widget.court.pricePerHour * 2,
                            isSelected: selectedDuration == 2.0,
                            onTap: () => ref
                                .read(selectedDurationProvider.notifier)
                                .setDuration(2.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2) Select Time Slot (now uses dynamicSlots)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select Time Slot',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: starts.length,
                itemBuilder: (context, index) {
                  final label = labels[index];

                  // mock availability (replace with real availability per half-hour)
                  final isAvailable = index % 5 != 0;

                  // this index can start a full range?
                  final fitsRange = index + slotsNeeded <= starts.length;

                  // in selection?
                  final inSelection =
                      (selectedStartIndex >= 0) &&
                      index >= selectedStartIndex &&
                      index < selectedStartIndex + slotsNeeded;

                  final isEnabled = isAvailable && fitsRange;

                  return InkWell(
                    onTap: isEnabled
                        ? () {
                            // store ONLY the start label; we infer the range on build
                            ref
                                .read(selectedTimeSlotProvider.notifier)
                                .setTimeSlot(label);
                          }
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isAvailable
                            ? Colors.grey.shade200
                            : inSelection
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceVariant.withOpacity(0.5),
                        border: Border.all(
                          color: !isAvailable
                              ? Colors.grey.shade300
                              : inSelection
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outline.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: !isAvailable
                                ? Colors.grey.shade400
                                : inSelection
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            fontWeight: inSelection
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ],
        ),
      ),
      bottomNavigationBar: canConfirm
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Booking confirmed! Total: \$${total.toStringAsFixed(0)}',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Confirm Booking - \$${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}

class _DurationOption extends StatelessWidget {
  final double duration;
  final String label;
  final int price;
  final bool isSelected;
  final VoidCallback onTap;

  const _DurationOption({
    required this.duration,
    required this.label,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withOpacity(0.5),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$$price',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
