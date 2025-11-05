import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/sport_card.dart';
import 'package:riyada_frontend/app/shared/models/sport_model.dart';

class SportsCategories extends StatelessWidget {
  final List<Sport> sportsList;
  const SportsCategories({super.key, required this.sportsList});

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
                "Popular Sports",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  context.goNamed(
                    'courts',
                    queryParameters: {'sport': 'all_sports'},
                  );
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
        SizedBox(
          height: 85,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: sportsList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) => SportCard(
              sport: sportsList[index],
              onTap: () => context.goNamed(
                'courts',
                queryParameters: {'sport': sportsList[index].name},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
