import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class HeatMapCircles extends StatelessWidget {
  const HeatMapCircles({
    super.key,
    required this.values,
    this.columns = 7,
    this.rows = 5,
  });

  final List<double> values; // intensity 0..1
  final int columns;
  final int rows;

  @override
  Widget build(BuildContext context) {
    final total = columns * rows;
    final v = values.take(total).toList();
    while (v.length < total) {
      v.add(0);
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: List.generate(total, (i) {
        final intensity = v[i].clamp(0.0, 1.0);
        final color = AppColors.primary500.withOpacity(0.15 + 0.85 * intensity);
        final isEmpty = intensity <= 0.001;

        return Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: isEmpty ? AppColors.surface : color,
            border: Border.all(
              color: isEmpty ? AppColors.surface : AppColors.primary500.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        );
      }),
    );
  }
}

