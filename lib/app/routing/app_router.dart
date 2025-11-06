import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/app_shell_scaffold.dart';

import 'package:riyada_frontend/app/features/welcome/welcome_page.dart';
import 'package:riyada_frontend/app/features/home/presentation/home_page.dart';
import 'package:riyada_frontend/app/features/court/presentation/courts_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'welcome',
        pageBuilder: (c, s) => const NoTransitionPage(child: WelcomePage()),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navShell) =>
            AppShellScaffold(shell: navShell),
        branches: [
          // 0) Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (_, __) => const HomePage(),
              ),
            ],
          ),

          // 1) Courts
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/courts',
                name: 'courts',
                builder: (_, __) => const CourtsPage(),
                // routes: [
                //   GoRoute(
                //     path: 'detail/:id', // /courts/detail/123
                //     name: 'courtDetail',
                //     builder: (_, s) => CourtDetailPage(id: s.pathParameters['id']!),
                //   ),
                // ],
              ),
            ],
          ),

          // 2) Tournaments
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tournaments',
                name: 'tournaments',
                builder: (_, __) => const Center(child: Text("dfjkdf")),
              ),
            ],
          ),

          // 3) Bookings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/bookings',
                name: 'bookings',
                builder: (_, __) => const Center(child: Text("dfjkdf")),
              ),
            ],
          ),

          // 4) Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (_, __) => const Center(child: Text("dfjkdf")),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
