import 'package:flutter/material.dart';
import 'package:news_app_cycle19_sun/core/l10n/app_localizations.dart';
import 'package:news_app_cycle19_sun/core/providers/settings_provider.dart';
import 'package:news_app_cycle19_sun/core/routes/app_router.dart';
import 'package:news_app_cycle19_sun/core/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      title: 'News App',
      theme: AppTheme.light(),
      navigatorKey: navigatorKey,
      locale: Locale(vm.currentLanguage),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRouter.onGenerateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
