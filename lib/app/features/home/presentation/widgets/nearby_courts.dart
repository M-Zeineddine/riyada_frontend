import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/nearby_court_card.dart';

class NearbyCourts extends StatelessWidget {
  final List<CourtModel> nearbyCourtsList;
  const NearbyCourts({super.key, required this.nearbyCourtsList});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => context.goNamed(
                  'courts',
                  queryParameters: {'sort': 'nearby'},
                ),
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
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemCount: nearbyCourtsList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 20),
          itemBuilder: (context, index) => NearbyCourtCard(
            court: nearbyCourtsList[index],
            onTap: () => context.push('/court/${nearbyCourtsList[index].name}'),
          ),
        ),
      ],
    );
  }
}
