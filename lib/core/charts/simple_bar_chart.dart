import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({
    super.key,
    required this.values,
    this.labels = const [],
    this.highlightIndex,
    this.height = 96,
    this.activeColor = AppColors.primary500,
    this.inactiveColor = AppColors.borderDefault,
  });

  final List<double> values;
  final List<String> labels;
  final int? highlightIndex;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _BarChartPainter(
          values: values,
          labels: labels,
          highlightIndex: highlightIndex,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
        ),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.values,
    required this.labels,
    this.highlightIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  final List<double> values;
  final List<String> labels;
  final int? highlightIndex;
  final Color activeColor;
  final Color inactiveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    const left = 0.0;
    const rightPad = 0.0;
    const top = 0.0;
    const labelHeight = 20.0;
    const bottom = labelHeight;

    final chartBottom = size.height - bottom;
    final chartW = size.width - left - rightPad;
    final barW = chartW / values.length;
    const barPadding = 6.0;

    for (var i = 0; i < values.length; i++) {
      final v = values[i];
      final h = (chartBottom - top) * v.clamp(0.0, 1.0);
      final x = left + barW * i + barPadding / 2;
      final y = chartBottom - h;
      final isHighlight = highlightIndex == i;
      final color = isHighlight ? activeColor : inactiveColor;

      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barW - barPadding, h),
        const Radius.circular(4),
      );
      canvas.drawRRect(r, Paint()..color = color);
    }

    if (labels.length == values.length) {
      for (var i = 0; i < labels.length; i++) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: const TextStyle(
              fontSize: 10,
              height: 12 / 10,
              color: AppColors.tabInactive,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        final x = left + barW * i + (barW - textPainter.width) / 2;
        textPainter.paint(canvas, Offset(x, size.height - labelHeight + 4));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.values != values ||
        oldDelegate.labels != labels ||
        oldDelegate.highlightIndex != highlightIndex ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor;
  }
}
