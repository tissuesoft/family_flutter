import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum MedicationStatusType { completed, notTaken, scheduled }

class MedicationListItem extends StatelessWidget {
  const MedicationListItem({
    super.key,
    required this.name,
    required this.timeText,
    required this.statusType,
  });

  final String name;
  final String timeText;
  final MedicationStatusType statusType;

  @override
  Widget build(BuildContext context) {
    final isCompleted = statusType == MedicationStatusType.completed;
    final isActive = isCompleted;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary500.withValues(alpha: 0.05)
            : AppColors.surfaceMuted,
        border: Border.all(
          color: isActive
              ? AppColors.primary500.withValues(alpha: 0.1)
              : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  color: Color(0x0D000000),
                ),
              ],
            ),
            child: Icon(
              Icons.medication_liquid_rounded,
              size: 16,
              color: isActive ? AppColors.primary500 : AppColors.tabInactive,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  timeText,
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w500,
                    color: isActive ? AppColors.primary500 : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isActive ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 20,
            color: isActive ? AppColors.primary500 : AppColors.tabInactive,
          ),
        ],
      ),
    );
  }
}
