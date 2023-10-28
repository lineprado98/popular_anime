import 'package:flutter/material.dart';
import 'package:popular_anime/app/modules/anime/presenter/pages/home_page.dart';
import 'package:popular_anime/app/modules/anime/presenter/pages/my_list_favorites.dart';

abstract class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.initialRoute: (context) => const HomePage(),
    RouteNames.favorites: (context) => const MyListFavorites()
  };
}

abstract class RouteNames {
  static const String initialRoute = '/';
  static const String favorites = '/favorites';
}
