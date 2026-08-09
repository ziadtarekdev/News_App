import 'dart:io';

void main() {
  final directories = [
    // Core
    'lib/core/config',
    'lib/core/routes',
    'lib/core/theme',

    // Splash Module
    'lib/modules/splash/data',
    'lib/modules/splash/domain',
    'lib/modules/splash/presentation/bloc',
    'lib/modules/splash/presentation/pages',
    'lib/modules/splash/presentation/widgets',
  ];

  for (final dir in directories) {
    Directory(dir).createSync(recursive: true);
    print('✓ $dir');
  }

  _createFile(
    'lib/core/config/app_config.dart',
    appConfig,
  );

  _createFile(
    'lib/core/routes/app_routes.dart',
    appRoutes,
  );

  _createFile(
    'lib/core/routes/app_router.dart',
    appRouter,
  );

  _createFile(
    'lib/core/theme/app_theme.dart',
    appTheme,
  );

  _createFile(
    'lib/modules/splash/presentation/pages/splash_page.dart',
    splashPage,
  );

  _createFile(
    'lib/modules/splash/presentation/bloc/splash_bloc.dart',
    splashBloc,
  );

  print('\nProject generated successfully 🚀');
}

void _createFile(String path, String content) {
  final file = File(path);

  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync(content);
    print('✓ ${file.path}');
  }
}

const appConfig = '''
class AppConfig {
  const AppConfig._();

  static const appName = 'Flutter App';
}
''';

const appRoutes = '''
abstract final class AppRoutes {
  static const splash = '/';
}
''';

const appRouter = '''
import 'package:flutter/material.dart';

import '../../modules/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }
}
''';

const appTheme = '''
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
    );
  }
}
''';

const splashPage = '''
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
''';

const splashBloc = '''
class SplashBloc {}
''';