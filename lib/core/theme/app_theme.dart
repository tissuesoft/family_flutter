import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary500,
        onPrimary: AppColors.white,
        secondary: AppColors.primary600,
        onSecondary: AppColors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        background: AppColors.background,
        onBackground: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.display,
        displayMedium: AppTextStyles.heading,
        headlineMedium: AppTextStyles.heading,
        titleLarge: AppTextStyles.sectionTitle,
        titleMedium: AppTextStyles.sectionTitle,
        bodyMedium: AppTextStyles.body,
        labelSmall: AppTextStyles.caption,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
    );
  }
}

