import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

enum AppPillButtonVariant { primary, secondary, warning }

class AppPillButton extends StatelessWidget {
  const AppPillButton({
    super.key,
    required this.variant,
    required this.label,
    this.icon,
    this.onPressed,
    this.height = 48,
  });

  final AppPillButtonVariant variant;
  final String label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bg = switch (variant) {
      AppPillButtonVariant.primary => AppColors.primary500,
      AppPillButtonVariant.secondary => AppColors.surface,
      AppPillButtonVariant.warning => AppColors.warning,
    };

    final fg = switch (variant) {
      AppPillButtonVariant.primary => AppColors.white,
      AppPillButtonVariant.secondary => AppColors.textPrimary,
      AppPillButtonVariant.warning => AppColors.black,
    };

    final border = switch (variant) {
      AppPillButtonVariant.secondary => BorderSide(color: AppColors.textDisabled),
      AppPillButtonVariant.primary => BorderSide.none,
      AppPillButtonVariant.warning => BorderSide.none,
    };

    return SizedBox(
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          side: border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(label, style: AppTextStyles.cardTitle),
          ],
        ),
      ),
    );
  }
}

