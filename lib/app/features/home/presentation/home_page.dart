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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loggedUser = ref.watch(userProvider);
    final sportsList = ref.watch(sportsProvider);
    final nearbyCourts = ref.watch(nearbyCourtsProvider);

    // Theming variables
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    // final textTheme = theme.textTheme;

    // Pages for each tab
    final List<Widget> pages = [
      SingleChildScrollView(
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
      ),
      const Center(child: Text('Courts coming soon')),
      const Center(child: Text('Tournaments coming soon')),
      const Center(child: Text('Bookings coming soon')),
      const Center(child: Text('Profile coming soon')),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          height: 75,
          backgroundColor: cs.primary.withOpacity(0.08),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.sports_rounded),
              selectedIcon: Icon(Icons.sports_rounded),
              label: 'Courts',
            ),
            NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined),
              selectedIcon: Icon(Icons.emoji_events),
              label: 'Tournaments',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today),
              label: 'Bookings',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
