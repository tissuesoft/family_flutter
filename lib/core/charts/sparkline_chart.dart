import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class SparklineChart extends StatelessWidget {
  const SparklineChart({
    super.key,
    required this.values,
    this.color = AppColors.primary500,
    this.height = 84,
  });

  final List<double> values;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _SparklinePainter(values: values, color: color),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final maxV = values.reduce((a, b) => a > b ? a : b);
    final minV = values.reduce((a, b) => a < b ? a : b);

    double scale(double v) {
      final denom = (maxV - minV).abs() < 0.0001 ? 1 : (maxV - minV);
      return (v - minV) / denom;
    }

    final left = AppSpacing.sm;
    final right = size.width - AppSpacing.sm;
    final top = AppSpacing.sm;
    final bottom = size.height - AppSpacing.sm;

    final points = <Offset>[];
    for (var i = 0; i < values.length; i++) {
      final x = left + (right - left) * (i / (values.length - 1).clamp(1, 999));
      final y = bottom - (bottom - top) * scale(values[i]);
      points.add(Offset(x, y));
    }

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(points.last.dx, bottom)
      ..lineTo(points.first.dx, bottom)
      ..close();

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(0.15);
    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..color = color;
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = color;
    for (final p in points) {
      canvas.drawCircle(p, 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color;
  }
}

