import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xFFFF6B35);
  static const primarySoft = Color(0xFFFFE8DF);
  static const background = Color(0xFFFFFBF8);
  static const surface = Colors.white;
  static const textPrimary = Color(0xFF211A17);
  static const textSecondary = Color(0xFF8D817B);
  static const divider = Color(0xFFF1EAE6);
  static const star = Color(0xFFFFB800);
}

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 30,
          height: 1.15,
          fontWeight: FontWeight.w800,
        ),
        headlineSmall: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        bodyMedium: TextStyle(color: AppColors.textSecondary, fontSize: 14),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primarySoft,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(WidgetState.selected)
                ? AppColors.primary
                : AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          );
        }),
      ),
    );
  }
}
