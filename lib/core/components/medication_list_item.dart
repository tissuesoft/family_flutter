import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

enum MedicationStatusType { completed, notTaken, scheduled }

class MedicationListItem extends StatelessWidget {
  const MedicationListItem({
    super.key,
    required this.name,
    required this.timeText,
    required this.statusType,
    required this.statusLabel,
  });

  final String name;
  final String timeText;
  final MedicationStatusType statusType;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final circleBg = switch (statusType) {
      MedicationStatusType.completed => AppColors.primary500.withOpacity(0.18),
      MedicationStatusType.notTaken => AppColors.error.withOpacity(0.12),
      MedicationStatusType.scheduled => AppColors.warning.withOpacity(0.14),
    };

    final circleBorder = switch (statusType) {
      MedicationStatusType.completed => AppColors.primary500,
      MedicationStatusType.notTaken => AppColors.error,
      MedicationStatusType.scheduled => AppColors.warning,
    };

    final icon = switch (statusType) {
      MedicationStatusType.completed => Icons.check_rounded,
      MedicationStatusType.notTaken => Icons.close_rounded,
      MedicationStatusType.scheduled => Icons.access_time_rounded,
    };

    final iconColor = switch (statusType) {
      MedicationStatusType.completed => AppColors.primary500,
      MedicationStatusType.notTaken => AppColors.error,
      MedicationStatusType.scheduled => AppColors.warning,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: circleBg,
              borderRadius: BorderRadius.circular(AppRadius.small),
              border: Border.all(color: circleBorder.withOpacity(0.35)),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.xs),
                Text(timeText, style: AppTextStyles.caption),
              ],
            ),
          ),
          Text(
            statusLabel,
            style: AppTextStyles.caption.copyWith(
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

