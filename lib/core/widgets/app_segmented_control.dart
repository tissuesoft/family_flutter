import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected,
  });

  final List<AppSegmentedControlItem<T>> items;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Row(
        children: items.map((item) {
          final isSelected = item.value == selected;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.large),
              onTap: () => onSelected(item.value),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary500 : AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                ),
                child: Center(
                  child: Text(
                    item.label,
                    style: isSelected
                        ? AppTextStyles.caption.copyWith(color: AppColors.white)
                        : AppTextStyles.caption.copyWith(color: AppColors.tabInactive),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AppSegmentedControlItem<T> {
  const AppSegmentedControlItem({required this.label, required this.value});

  final String label;
  final T value;
}

