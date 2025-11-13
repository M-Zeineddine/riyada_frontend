import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/booking/presentation/court_booking_page.dart';
import 'package:riyada_frontend/app/features/court/application/courts_filter_provider.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/nearby_court_card.dart';

class NearbyCourts extends ConsumerWidget {
  final List<CourtModel> nearbyCourtsList;
  const NearbyCourts({super.key, required this.nearbyCourtsList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: Row(
            children: [
              Text(
                "Nearby Courts",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  ref.read(courtsFilterProvider.notifier).reset();
                  ref.read(courtsFilterProvider.notifier).setSort('nearby');
                  context.goNamed('courts');
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: nearbyCourtsList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, i) {
            final court = nearbyCourtsList[i];
            return NearbyCourtCard(
              court: court,
              onTap: () => context.pushNamed(
                'courtDetail',
                pathParameters: {'id': court.id},
              ),
              onBook: () => context.pushNamed(
                'courtBooking',
                pathParameters: {'id': court.id},
                extra: court,
              ),
            );
          },
        ),
      ],
    );
  }
}
