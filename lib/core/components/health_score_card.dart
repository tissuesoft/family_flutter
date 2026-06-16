import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';

class HealthScoreCardMetric {
  const HealthScoreCardMetric({
    required this.label,
    required this.valueText,
    required this.color,
    this.icon = Icons.circle,
  });

  final String label;
  final String valueText;
  final Color color;
  final IconData icon;
}

class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({
    super.key,
    required this.title,
    required this.scoreText,
    required this.percentText,
    this.subTitle,
    this.metrics = const [],
  });

  final String title;
  final String? subTitle;
  final String scoreText;
  final String percentText;
  final List<HealthScoreCardMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 304,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary700, AppColors.primary500],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: AppColors.shadow,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.cardTitle.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: AppTextStyles.caption.copyWith(color: AppColors.white),
                  ),
              ],
            ),
            const Spacer(),
            Center(
              child: _Gauge(scoreText: scoreText, percentText: percentText),
            ),
            const Spacer(),
            if (metrics.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.md),
                child: Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  children: metrics.map((m) {
                    return _MetricChip(metric: m);
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.metric});

  final HealthScoreCardMetric metric;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: metric.color.withOpacity(0.16),
            shape: BoxShape.circle,
          ),
          child: Icon(metric.icon, size: 13, color: metric.color),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(metric.valueText, style: AppTextStyles.caption.copyWith(color: AppColors.white)),
            Text(metric.label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.9))),
          ],
        ),
      ],
    );
  }
}

class _Gauge extends StatelessWidget {
  const _Gauge({required this.scoreText, required this.percentText});

  final String scoreText;
  final String percentText;

  @override
  Widget build(BuildContext context) {
    final percent = double.tryParse(percentText.replaceAll('%', '').trim()) ?? 0;

    return SizedBox(
      width: 170,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: _SemiCirclePainter(value: percent / 100),
            size: const Size(170, 120),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                scoreText,
                style: AppTextStyles.display.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                percentText,
                style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.92)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  _SemiCirclePainter({required this.value});

  final double value; // 0..1

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 8;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..color = AppColors.white.withOpacity(0.16);

    final valuePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..color = AppColors.white;

    final startAngle = math.pi; // 180deg
    final sweep = math.pi * value.clamp(0.0, 1.0);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, math.pi, false, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      -sweep,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SemiCirclePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}

 

