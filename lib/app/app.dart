import 'package:flutter/material.dart';
import 'package:riyada_frontend/app/routing/app_router.dart';
import '../core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();
    return MaterialApp.router(
      title: 'Your App',
      theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
