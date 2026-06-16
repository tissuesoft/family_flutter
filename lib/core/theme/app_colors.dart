import 'package:flutter/material.dart';

/// 디자인가이드의 Color System을 코드화한 값들입니다.
/// UI에서는 반드시 이 파일의 값을 참조하세요.
class AppColors {
  // Primary
  static const Color primary500 = Color(0xFF10C9A7);
  static const Color primary600 = Color(0xFF08B996);
  static const Color primary700 = Color(0xFF07967A);

  static const Color primary50 = Color(0xFFEAFBF7);
  static const Color primary100 = Color(0xFFD6F7F0);

  // Background / Surface
  static const Color background = Color(0xFFF6F8F8);
  static const Color surface = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFF1F2233);
  static const Color textSecondary = Color(0xFF8A90A0);
  static const Color textDisabled = Color(0xFFC8CDD8);

  // States
  static const Color success = Color(0xFF10C9A7);
  static const Color warning = Color(0xFFF5B92F);
  static const Color error = Color(0xFFFF6B6B);
  static const Color orange = Color(0xFFFF8A26);

  // Cards
  static const Color alertBackground = Color(0xFFFFF8E7);
  static const Color errorBackground = Color(0xFFFFF1F1);

  // Marketing / special screens
  static const Color kakaoYellow = Color(0xFFFEE500);
  static const Color illustrationPeach = Color(0xFFFFE8D6);
  static const Color premiumOrange = Color(0xFFFFAE4E);
  static const Color lockScreenTop = Color(0xFF0B1B3A);
  static const Color lockScreenBottom = Color(0xFF050A18);

  // Additional used colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color shadow = Color(0x0F000000);

  // Bottom navigation inactive
  static const Color tabInactive = Color(0xFFA5ACB8);

  // Medication calendar (from guide)
  static const Color calendarNotTakenBg = Color(0xFFFFD8D8);
  static const Color calendarScheduledBg = Color(0xFFE7EAF0);
}

