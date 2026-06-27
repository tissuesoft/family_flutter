import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_shell.dart';

class StepCountDetailPage extends StatelessWidget {
  const StepCountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.steps,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 112),
        children: const [
          _StepsPageHeader(),
          SizedBox(height: 20),
          _TodayStepsCard(),
          SizedBox(height: 20),
          _FatherActivityAlert(),
          SizedBox(height: 20),
          _WeeklyStepsSection(),
          SizedBox(height: 20),
          _FamilyStepsSection(),
          SizedBox(height: 20),
          _MonthlyStatsSection(),
        ],
      ),
    );
  }
}

class _StepsPageHeader extends StatelessWidget {
  const _StepsPageHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '내 걸음 수',
          style: TextStyle(
            fontSize: 18,
            height: 24 / 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '2025년 1월 27일 월요일',
          style: TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w500,
            color: AppColors.tabInactive,
          ),
        ),
      ],
    );
  }
}

class _StepsCard extends StatelessWidget {
  const _StepsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 4),
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _TodayStepsCard extends StatelessWidget {
  const _TodayStepsCard();

  @override
  Widget build(BuildContext context) {
    return _StepsCard(
      child: Column(
        children: [
          const Text(
            '오늘 걸음 수',
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              fontWeight: FontWeight.w600,
              color: AppColors.tabInactive,
            ),
          ),
          const SizedBox(height: 16),
          const _StepRingProgress(
            steps: 6248,
            percent: 0.62,
            goal: 10000,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary500.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              '🏃 3,752보 더 걸으면 목표 달성!',
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _MiniStatTile(
                  icon: Icons.local_fire_department_rounded,
                  iconBg: AppColors.statOrangeBg,
                  iconColor: AppColors.statOrangeIcon,
                  value: '248',
                  unit: 'kcal',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MiniStatTile(
                  icon: Icons.route_rounded,
                  iconBg: AppColors.infoBg,
                  iconColor: AppColors.statBlueIcon,
                  value: '4.7',
                  unit: 'km',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MiniStatTile(
                  icon: Icons.timer_rounded,
                  iconBg: AppColors.statPurpleBg,
                  iconColor: AppColors.statPurpleIcon,
                  value: '52',
                  unit: '분',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepRingProgress extends StatelessWidget {
  const _StepRingProgress({
    required this.steps,
    required this.percent,
    required this.goal,
  });

  final int steps;
  final double percent;
  final int goal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(180, 180),
            painter: _RingPainter(percent: percent),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatNumber(steps),
                style: const TextStyle(
                  fontSize: 36,
                  height: 1,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.8,
                  color: AppColors.primary500,
                ),
              ),
              const Text(
                '보',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.tabInactive,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${(percent * 100).round()}%',
                style: const TextStyle(
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '목표: ${_formatNumber(goal)}보',
                style: const TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.tabInactive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatNumber(int value) {
    return value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.percent});

  final double percent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 14;
    const strokeWidth = 14.0;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = AppColors.primaryTrack;

    final valuePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.primary500;

    const startAngle = -math.pi / 2;
    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * math.pi * percent.clamp(0.0, 1.0),
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}

class _MiniStatTile extends StatelessWidget {
  const _MiniStatTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 14, color: iconColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: AppColors.textDark,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w500,
              color: AppColors.tabInactive,
            ),
          ),
        ],
      ),
    );
  }
}

class _FatherActivityAlert extends StatelessWidget {
  const _FatherActivityAlert();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.alertBannerBg,
        border: Border.all(color: AppColors.alertBannerBorder),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFFEF3C7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 14,
              color: AppColors.warningAmber,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              '아버지 최근 3일 활동량이\n많이 줄었어요',
              style: TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w600,
                color: AppColors.alertBannerText,
              ),
            ),
          ),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '확인하기',
                style: TextStyle(
                  fontSize: 12,
                  height: 16 / 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.alertBannerAction,
                ),
              ),
              Icon(Icons.chevron_right, size: 12, color: AppColors.alertBannerAction),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklyStepsSection extends StatelessWidget {
  const _WeeklyStepsSection();

  static const _values = [0.48, 0.64, 0.53, 0.72, 0.67, 0.41, 0.54];

  @override
  Widget build(BuildContext context) {
    return _StepsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '이번 주 걸음 수',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '평균 6,721보',
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tabInactive,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '점선: 목표 10,000보',
            style: TextStyle(
              fontSize: 11.4,
              height: 16 / 11.4,
              fontWeight: FontWeight.w400,
              color: AppColors.tabInactive,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: Stack(
              children: [
                Positioned(
                  left: 28,
                  right: 0,
                  top: 36,
                  bottom: 28,
                  child: CustomPaint(
                    painter: _GoalLinePainter(goalY: 0.28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: SimpleBarChart(
                    values: _values,
                    labels: const ['월', '화', '수', '목', '금', '토', '일'],
                    highlightIndex: 6,
                    height: 180,
                    activeColor: AppColors.primary500,
                    inactiveColor: AppColors.primaryBarLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalLinePainter extends CustomPainter {
  _GoalLinePainter({required this.goalY});

  final double goalY;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * goalY;
    final paint = Paint()
      ..color = AppColors.primary500
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    var startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }

    const textStyle = TextStyle(
      fontSize: 9,
      height: 11 / 9,
      color: AppColors.primary500,
    );
    final textPainter = TextPainter(
      text: const TextSpan(text: '목표', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(size.width - textPainter.width, y - 14));
  }

  @override
  bool shouldRepaint(covariant _GoalLinePainter oldDelegate) {
    return oldDelegate.goalY != goalY;
  }
}

class _FamilyStepsSection extends StatelessWidget {
  const _FamilyStepsSection();

  @override
  Widget build(BuildContext context) {
    return _StepsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '우리 가족 오늘 걸음 수',
            style: TextStyle(
              fontSize: 15.25,
              height: 24 / 15.25,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          _FamilyStepRow(
            name: '나',
            steps: 6248,
            progress: 0.625,
            isMe: true,
            valueColor: AppColors.primary500,
            trackColor: AppColors.primary500.withValues(alpha: 0.1),
            fillColor: AppColors.primary500,
          ),
          const SizedBox(height: 12),
          _FamilyStepRow(
            name: '어머니',
            steps: 4523,
            progress: 0.452,
            valueColor: AppColors.textBody,
            trackColor: AppColors.progressTrack,
            fillColor: AppColors.primary500.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          _FamilyStepRow(
            name: '아버지',
            steps: 2103,
            progress: 0.21,
            showWarning: true,
            valueColor: AppColors.dangerRed,
            trackColor: AppColors.featureRedBg,
            fillColor: AppColors.dangerRedLight,
          ),
          const SizedBox(height: 12),
          _FamilyStepRow(
            name: '딸',
            steps: 5983,
            progress: 0.598,
            valueColor: AppColors.textBody,
            trackColor: AppColors.progressTrack,
            fillColor: AppColors.primary500.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 2,
                child: CustomPaint(painter: _DashedLinePainter()),
              ),
              const SizedBox(width: 6),
              const Text(
                '목표 10,000보 기준',
                style: TextStyle(
                  fontSize: 10,
                  height: 15 / 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.tabInactive,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderDefault
      ..strokeWidth = 2;
    const dash = 4.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dash, 0), paint);
      x += dash * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FamilyStepRow extends StatelessWidget {
  const _FamilyStepRow({
    required this.name,
    required this.steps,
    required this.progress,
    required this.valueColor,
    required this.trackColor,
    required this.fillColor,
    this.isMe = false,
    this.showWarning = false,
  });

  final String name;
  final int steps;
  final double progress;
  final Color valueColor;
  final Color trackColor;
  final Color fillColor;
  final bool isMe;
  final bool showWarning;

  @override
  Widget build(BuildContext context) {
    final formatted = steps.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]},',
        );

    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                if (isMe) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary500,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      '나',
                      style: TextStyle(
                        fontSize: 10,
                        height: 15 / 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                if (showWarning) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.warning_amber_rounded, size: 12, color: AppColors.warningIcon),
                ],
              ],
            ),
            const Spacer(),
            Text(
              '$formatted보',
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: isMe ? FontWeight.w800 : FontWeight.w600,
                color: valueColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(fillColor),
          ),
        ),
      ],
    );
  }
}

class _MonthlyStatsSection extends StatelessWidget {
  const _MonthlyStatsSection();

  static const _heatmap = [
    [0.0, 0.0, 0.2, 0.35, 0.55, 0.2, 0.3],
    [0.6, 0.8, 0.45, 0.7, 0.9, 0.25, 0.5],
    [0.75, 0.65, 1.0, 0.8, 0.55, 0.3, 0.4],
    [0.65, 0.5, 0.85, 0.9, 0.7, 0.3, 0.45],
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
  ];

  @override
  Widget build(BuildContext context) {
    return _StepsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '이번 달 통계',
            style: TextStyle(
              fontSize: 15.625,
              height: 24 / 15.625,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _MonthStatTile(
                  icon: Icons.directions_walk_rounded,
                  iconColor: AppColors.primary500,
                  value: '7,234',
                  label: '월 평균',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MonthStatTile(
                  icon: Icons.emoji_events_rounded,
                  iconColor: Color(0xFFFACC15),
                  value: '12,847',
                  label: '최고 기록',
                  subLabel: '1월 15일',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MonthStatTile(
                  icon: Icons.local_fire_department_rounded,
                  iconColor: AppColors.statOrangeIcon,
                  value: '5일째',
                  label: '연속 달성',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '1월 활동 히트맵',
            style: TextStyle(
              fontSize: 11.6,
              height: 16 / 11.6,
              fontWeight: FontWeight.w600,
              color: AppColors.tabInactive,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              _HeatmapDayLabel('월'),
              _HeatmapDayLabel('화'),
              _HeatmapDayLabel('수'),
              _HeatmapDayLabel('목'),
              _HeatmapDayLabel('금'),
              _HeatmapDayLabel('토'),
              _HeatmapDayLabel('일'),
            ],
          ),
          const SizedBox(height: 6),
          ...List.generate(_heatmap.length, (row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: List.generate(7, (col) {
                  final intensity = _heatmap[row][col];
                  final isToday = row == 2 && col == 2;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: col < 6 ? 6 : 0),
                      child: _HeatmapCell(
                        intensity: intensity,
                        isToday: isToday,
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                '적음',
                style: TextStyle(fontSize: 10, color: AppColors.tabInactive),
              ),
              const SizedBox(width: 6),
              ...[0.2, 0.5, 0.75, 1.0].map(
                (opacity) => Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.only(left: 6),
                  decoration: BoxDecoration(
                    color: opacity >= 1
                        ? AppColors.primary500
                        : AppColors.primary500.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '많음',
                style: TextStyle(fontSize: 10, color: AppColors.tabInactive),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthStatTile extends StatelessWidget {
  const _MonthStatTile({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.subLabel,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final String? subLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              height: 18 / 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              height: 15 / 10,
              fontWeight: FontWeight.w500,
              color: AppColors.tabInactive,
            ),
          ),
          if (subLabel != null)
            Text(
              subLabel!,
              style: const TextStyle(
                fontSize: 9,
                height: 14 / 9,
                fontWeight: FontWeight.w500,
                color: AppColors.tabInactive,
              ),
            ),
        ],
      ),
    );
  }
}

class _HeatmapDayLabel extends StatelessWidget {
  const _HeatmapDayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9,
          height: 14 / 9,
          fontWeight: FontWeight.w500,
          color: Color(0xFFD1D5DB),
        ),
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  const _HeatmapCell({
    required this.intensity,
    this.isToday = false,
  });

  final double intensity;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    if (intensity <= 0) {
      return Container(
        height: 37,
        decoration: BoxDecoration(
          color: AppColors.progressTrack,
          borderRadius: BorderRadius.circular(999),
        ),
      );
    }

    return Container(
      height: 37,
      decoration: BoxDecoration(
        color: intensity >= 1
            ? AppColors.primary500
            : AppColors.primary500.withValues(alpha: intensity),
        borderRadius: BorderRadius.circular(999),
        boxShadow: isToday
            ? [
                BoxShadow(
                  color: AppColors.primary500.withValues(alpha: 0.4),
                  blurRadius: 0,
                  spreadRadius: 2,
                ),
              ]
            : null,
        border: isToday ? Border.all(color: Colors.white, width: 1) : null,
      ),
    );
  }
}
