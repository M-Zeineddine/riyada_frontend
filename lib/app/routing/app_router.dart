import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:riyada_frontend/app/features/home/home_page.dart';
import 'package:riyada_frontend/app/features/welcome/welcome_page.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: WelcomePage()),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
    // (optional) errorBuilder for 404s
    // errorBuilder: (context, state) => const NotFoundPage(),
  );
}
