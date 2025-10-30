import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/features/court/data/court_model.dart';
import 'package:riyada_frontend/app/features/home/application/home_provider.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/hero_banner.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/nearby_courts.dart';
import 'package:riyada_frontend/app/features/home/presentation/widgets/sports_categories.dart';
import 'package:riyada_frontend/app/features/user/application/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser = ref.watch(userProvider);
    final sportsList = ref.watch(sportsProvider);
    final nearbyCourts = ref.watch(nearbyCourtsProvider);

    // Theming variables
    // final theme = Theme.of(context);
    // final cs = theme.colorScheme;
    // final textTheme = theme.textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroBanner(loggedUser: loggedUser),

            SizedBox(height: 10),

            SportsCategories(sportsList: sportsList),

            SizedBox(height: 20),

            NearbyCourts(nearbyCourtsList: nearbyCourts),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class CourtBox extends StatelessWidget {
  final CourtModel court;
  final VoidCallback? onTap;

  const CourtBox({super.key, required this.court, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        width: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(court.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(court.name),
      ),
    );
  }
}
