import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color berry = Color(0xFF93426E);
  static const Color berryPop = Color(0xFFFF9DCE);
  static const Color mint = Color(0xFF286864);
  static const Color lemon = Color(0xFFCABD64);
  static const Color background = Color(0xFFFFF8F9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSoft = Color(0xFFFBE9F1);
  static const Color surfaceLow = Color(0xFFFFF0F6);
  static const Color plumInk = Color(0xFF22191E);
  static const Color plumMuted = Color(0xFF524349);
}

abstract final class AppTheme {
  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.berry,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.berry,
      secondary: AppColors.mint,
      surface: AppColors.background,
      onSurface: AppColors.plumInk,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.berry,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: AppColors.berry,
          letterSpacing: -0.8,
        ),
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: AppColors.plumInk,
          letterSpacing: -1.1,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: AppColors.plumInk,
          letterSpacing: -0.8,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color: AppColors.plumInk,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.plumInk,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: AppColors.plumInk,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: AppColors.plumMuted,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceSoft,
        selectedColor: AppColors.berryPop,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.plumInk,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: AppColors.berryPop.withValues(alpha: 0.35),
        labelTextStyle: const WidgetStatePropertyAll<TextStyle>(
          TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.berry,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
