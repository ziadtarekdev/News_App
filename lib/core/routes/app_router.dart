import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/modules/home/pages/home_view.dart';

import '../../modules/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
