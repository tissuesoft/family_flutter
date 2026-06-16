import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 디자인가이드 Typography를 코드화한 TextStyle 모음입니다.
/// UI에서는 반드시 이 파일의 스타일을 참조하세요.
class AppTextStyles {
  static const String _fontFamily = 'Pretendard';

  // Display (48 / Bold)
  static const TextStyle display = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.0,
  );

  // Heading (28 / Bold)
  static const TextStyle heading = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Section Title (20 / SemiBold)
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  // Card Title (18 / SemiBold)
  static const TextStyle cardTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body (14 / Medium)
  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Secondary
  static const TextStyle bodySecondary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Caption (12 / Regular)
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Caption disabled (12 / Regular)
  static const TextStyle captionDisabled = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
    height: 1.3,
  );
}

