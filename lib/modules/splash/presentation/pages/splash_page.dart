import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/gen/assets.gen.dart';
import 'package:news_app_cycle19_sun/core/routes/app_routes.dart';
import 'package:news_app_cycle19_sun/main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
        AppRoutes.home,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Assets.images.newsLogoImg.image()));
  }
}
