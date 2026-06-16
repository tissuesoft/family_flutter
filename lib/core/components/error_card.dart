import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.error_rounded,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.errorBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.error),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.error),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.cardTitle),
                const SizedBox(height: AppSpacing.xs),
                Text(message, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

