import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_cycle19_sun/core/theme/app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarThemeData(
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.mainText,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          color: AppColors.mainText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
