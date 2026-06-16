import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({
    super.key,
    required this.values,
    this.color = AppColors.primary500,
    this.height = 140,
  });

  final List<double> values;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _BarChartPainter(values: values, color: color),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final maxV = values.reduce((a, b) => a > b ? a : b);
    final left = AppSpacing.sm;
    final right = size.width - AppSpacing.sm;
    final top = AppSpacing.sm;
    final bottom = size.height - AppSpacing.sm;

    final chartW = right - left;
    final barW = chartW / values.length;
    final padding = AppSpacing.xs;

    for (var i = 0; i < values.length; i++) {
      final v = values[i];
      final t = maxV.abs() < 0.0001 ? 0 : (v / maxV).clamp(0.0, 1.0);
      final h = (bottom - top) * t;
      final x = left + barW * i + padding / 2;
      final y = bottom - h;

      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barW - padding, h),
        Radius.circular(AppRadius.small),
      );

      final fill = Paint()..color = color.withOpacity(0.85);
      canvas.drawRRect(r, fill);
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color;
  }
}
