import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class AlertCard extends StatelessWidget {
  const AlertCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.warning_amber_rounded,
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
        color: AppColors.alertBackground,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.warning),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.warning),
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

