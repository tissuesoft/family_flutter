import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class ToggleRow extends StatelessWidget {
  const ToggleRow({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body),
                if (subtitle != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle!, style: AppTextStyles.caption),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary500,
            activeThumbColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}

