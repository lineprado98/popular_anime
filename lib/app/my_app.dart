import 'package:flutter/material.dart';
import 'package:popular_anime/app/core/config/routes/app_routes.dart';
import 'package:popular_anime/app/core/config/theme/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
