import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/home/application/home_provider.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/hero_banner.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/nearby_courts.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/sports_categories.dart';
import 'package:riyada_frontend/app/features/user/application/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final loggedUser = ref.watch(userProvider);
    final sportsList = ref.watch(sportsProvider);
    final nearbyCourts = ref.watch(nearbyCourtsProvider);

    // Theming variables
    // final theme = Theme.of(context);
    // final cs = theme.colorScheme;
    // final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroBanner(loggedUser: loggedUser),
          const SizedBox(height: 10),
          SportsCategories(sportsList: sportsList),
          const SizedBox(height: 20),
          NearbyCourts(nearbyCourtsList: nearbyCourts),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
