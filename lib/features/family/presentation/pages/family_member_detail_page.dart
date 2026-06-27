import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/charts/sparkline_chart.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_shell.dart';

enum ReportPeriod { today, week, month }

class FamilyMemberDetailPage extends StatefulWidget {
  const FamilyMemberDetailPage({super.key});

  @override
  State<FamilyMemberDetailPage> createState() => _FamilyMemberDetailPageState();
}

class _FamilyMemberDetailPageState extends State<FamilyMemberDetailPage> {
  ReportPeriod _period = ReportPeriod.week;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.family,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 112),
        children: [
          const _DetailGradientHeader(title: '아버지'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                _PeriodControls(
                  period: _period,
                  onPeriodChanged: (value) => setState(() => _period = value),
                  dateLabel: _dateLabel,
                ),
                const SizedBox(height: 12),
                _MonthlyHealthScoreCard(
                  title: _scoreTitle,
                  trendLabel: _trendLabel,
                ),
                const SizedBox(height: 20),
                if (_period == ReportPeriod.today) ...const [
                  _TodaySafeCheckSection(),
                  SizedBox(height: 20),
                  _TodayMedicationScheduleSection(),
                  SizedBox(height: 20),
                  _MoodSection(),
                  SizedBox(height: 20),
                ],
                _StepsTrendSection(
                  title: _stepsTitle,
                  useWeeklyChart: _period == ReportPeriod.week,
                ),
                if (_period == ReportPeriod.week) ...const [
                  SizedBox(height: 20),
                  _WeeklyMedicationSection(),
                ],
                const SizedBox(height: 20),
                const _SafeCheckTimelineSection(),
                const SizedBox(height: 20),
                const _FamilyMonthlyScoresSection(),
                if (_period == ReportPeriod.week || _period == ReportPeriod.month) ...const [
                  SizedBox(height: 20),
                  _HealthInsightSection(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String get _dateLabel {
    return switch (_period) {
      ReportPeriod.today => '2025년 1월 27일',
      ReportPeriod.week => '2025년 1월',
      ReportPeriod.month => '2025년 1월',
    };
  }

  String get _scoreTitle {
    return switch (_period) {
      ReportPeriod.today => '오늘 통합 건강 점수',
      ReportPeriod.week => '이번 달 종합 건강 점수',
      ReportPeriod.month => '이번 달 종합 건강 점수',
    };
  }

  String get _trendLabel {
    return switch (_period) {
      ReportPeriod.today => '어제 대비 +2점 상승',
      ReportPeriod.week => '지난 달 대비 +7점 상승',
      ReportPeriod.month => '지난 달 대비 +7점 상승',
    };
  }

  String get _stepsTitle {
    return switch (_period) {
      ReportPeriod.today => '오늘 걸음 수 추이',
      ReportPeriod.week => '이번 달 걸음 수 추이',
      ReportPeriod.month => '이번 달 걸음 수 추이',
    };
  }
}

class _DetailGradientHeader extends StatelessWidget {
  const _DetailGradientHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE6F9F5),
            Color(0xFFF0FDF9),
            AppColors.background,
          ],
          stops: [0.0, 0.4, 1.0],
        ),
      ),
      child: Row(
        children: [
          _HeaderIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                height: 28 / 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.35,
                color: AppColors.textDark,
              ),
            ),
          ),
          const _HeaderIconButton(icon: Icons.more_horiz_rounded),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                offset: Offset(0, 4),
                color: Color(0x0D000000),
              ),
            ],
          ),
          child: Icon(icon, size: 14, color: AppColors.textDark),
        ),
      ),
    );
  }
}

class _PeriodControls extends StatelessWidget {
  const _PeriodControls({
    required this.period,
    required this.onPeriodChanged,
    required this.dateLabel,
  });

  final ReportPeriod period;
  final ValueChanged<ReportPeriod> onPeriodChanged;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
          decoration: BoxDecoration(
            color: AppColors.progressTrack,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              _periodTab('오늘', ReportPeriod.today),
              _periodTab('주간', ReportPeriod.week),
              _periodTab('월간', ReportPeriod.month),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavCircleButton(icon: Icons.chevron_left, onTap: () {}),
            Text(
              dateLabel,
              style: const TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.31,
                color: AppColors.textDark,
              ),
            ),
            _NavCircleButton(icon: Icons.chevron_right, onTap: () {}),
          ],
        ),
      ],
    );
  }

  Widget _periodTab(String label, ReportPeriod value) {
    final selected = period == value;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onPeriodChanged(value),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 36,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary500 : Colors.transparent,
              border: selected ? null : Border.all(color: const Color(0xFFE9E9EA)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w700,
                  letterSpacing: -0.77,
                  color: selected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavCircleButton extends StatelessWidget {
  const _NavCircleButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                blurRadius: 20,
                offset: Offset(0, 4),
                color: Color(0x0F000000),
              ),
            ],
          ),
          child: Icon(icon, size: 12, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({required this.child});

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
            color: Color(0x0D000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _MonthlyHealthScoreCard extends StatelessWidget {
  const _MonthlyHealthScoreCard({
    required this.title,
    required this.trendLabel,
  });

  final String title;
  final String trendLabel;

  static const _stats = [
    _ScoreStat(label: '안심체크', value: '95%'),
    _ScoreStat(label: '걸음 수', value: '78%'),
    _ScoreStat(label: '약 복용', value: '94%'),
    _ScoreStat(label: '비타민', value: '88%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary500,
            AppColors.primary600,
            AppColors.primary700,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 10),
            color: Color(0x4000C4A1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -32,
            top: -32,
            child: Icon(
              Icons.favorite_rounded,
              size: 96,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            left: -16,
            bottom: -24,
            child: Icon(
              Icons.insights_rounded,
              size: 128,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      height: 20 / 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.57,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _ArcGaugePainter(progress: 0.82),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text(
                          '82점',
                          style: TextStyle(
                            fontSize: 52,
                            height: 63 / 52,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.trending_up_rounded, size: 14, color: Color(0xFF86EFAC)),
                          const SizedBox(width: 6),
                          Text(
                            trendLabel,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 20 / 14,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.51,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: _stats
                      .map(
                        (stat) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        stat.label,
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 15 / 12,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.73,
                                          color: Colors.white.withValues(alpha: 0.7),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        stat.value,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 24 / 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      const Icon(Icons.trending_up_rounded, size: 12, color: Color(0xFF86EFAC)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreStat {
  const _ScoreStat({required this.label, required this.value});

  final String label;
  final String value;
}

class _ArcGaugePainter extends CustomPainter {
  _ArcGaugePainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.72);
    final radius = size.width * 0.38;
    const stroke = 12.0;
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.15);

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.white.withValues(alpha: 0.9);

    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, false, trackPaint);
    canvas.drawArc(rect, startAngle, sweepAngle * progress.clamp(0.0, 1.0), false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ArcGaugePainter oldDelegate) => oldDelegate.progress != progress;
}

class _TodaySafeCheckSection extends StatelessWidget {
  const _TodaySafeCheckSection();

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '오늘 안심 체크',
            style: TextStyle(
              fontSize: 17,
              height: 26 / 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: AppColors.primary500,
            borderRadius: BorderRadius.circular(24),
            elevation: 0,
            shadowColor: const Color(0x4D22C55E),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(24),
              child: Ink(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 15,
                      offset: Offset(0, 10),
                      color: Color(0x4D22C55E),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 21, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      '오늘도 괜찮아요',
                      style: TextStyle(
                        fontSize: 24,
                        height: 36 / 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 13, color: AppColors.success),
              SizedBox(width: 4),
              Text(
                '오늘 13:24 완료',
                style: TextStyle(
                  fontSize: 13,
                  height: 20 / 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '가족들이 확인할 수 있어요',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 20 / 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayMedicationScheduleSection extends StatelessWidget {
  const _TodayMedicationScheduleSection();

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '오늘 내 복용 스케줄',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.69,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryMintBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '1월 27일',
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.27,
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _ScheduleMedRow(
            time: '아침 8:00',
            name: '혈압약',
            completed: true,
          ),
          const SizedBox(height: 12),
          const _ScheduleMedRow(
            time: '점심 1:00',
            name: '당뇨약',
            completed: true,
            showBell: true,
          ),
          const SizedBox(height: 12),
          const _ScheduleMedRow(
            time: '저녁 7:00',
            name: '수면영양제',
            completed: false,
          ),
        ],
      ),
    );
  }
}

class _ScheduleMedRow extends StatelessWidget {
  const _ScheduleMedRow({
    required this.time,
    required this.name,
    required this.completed,
    this.showBell = false,
  });

  final String time;
  final String name;
  final bool completed;
  final bool showBell;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: completed ? AppColors.primaryMintBg : AppColors.surfaceMuted,
        border: Border.all(
          color: completed
              ? AppColors.primary500.withValues(alpha: 0.2)
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
              color: completed ? AppColors.primary500 : AppColors.progressTrack,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medication_liquid_rounded,
              size: 14,
              color: completed ? Colors.white : AppColors.tabInactive,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11.8,
                    height: 16 / 11.8,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tabInactive,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13.7,
                    height: 20 / 13.7,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
          if (showBell)
            const Icon(Icons.notifications_active_rounded, size: 20, color: AppColors.primary500),
          if (!showBell)
            Icon(
              completed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: completed ? AppColors.primary500 : const Color(0xFFD1D5DB),
            ),
        ],
      ),
    );
  }
}

class _MoodSection extends StatelessWidget {
  const _MoodSection();

  static const _moods = ['😢', '😟', '😐', '😊', '😄'];

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '오늘 기분은 어때요?',
            style: TextStyle(
              fontSize: 15.25,
              height: 24 / 15.25,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_moods.length, (index) {
              final selected = index == 3;
              return Opacity(
                opacity: selected ? 1 : 0.5,
                child: Text(
                  _moods[index],
                  style: TextStyle(fontSize: selected ? 39.6 : 27, height: 1),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _StepsTrendSection extends StatelessWidget {
  const _StepsTrendSection({
    required this.title,
    this.useWeeklyChart = false,
  });

  final String title;
  final bool useWeeklyChart;

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.61,
                  color: AppColors.textDark,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '1월',
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '7,234',
                style: TextStyle(
                  fontSize: 24,
                  height: 32 / 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.45,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '보',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.55,
                  color: AppColors.tabInactive,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '/ 일 평균',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.55,
                  color: AppColors.tabInactive,
                ),
              ),
            ],
          ),
          const Text(
            '최고 12,847보 · 최저 1,203보',
            style: TextStyle(
              fontSize: 11.4,
              height: 16 / 11.4,
              fontWeight: FontWeight.w500,
              color: AppColors.tabInactive,
            ),
          ),
          const SizedBox(height: 10),
          if (useWeeklyChart)
            SizedBox(
              height: 150,
              child: SimpleBarChart(
                values: const [0.55, 0.62, 0.78, 0.71, 0.68, 0.82, 0.74],
                labels: const ['월', '화', '수', '목', '금', '토', '일'],
                highlightIndex: 5,
                height: 150,
                activeColor: AppColors.primary500,
                inactiveColor: const Color(0x9900C4A1),
              ),
            )
          else
            const SparklineChart(
              values: [3200, 4100, 5800, 7200, 6800, 8100, 7234],
              height: 140,
            ),
        ],
      ),
    );
  }
}

class _SafeCheckTimelineSection extends StatelessWidget {
  const _SafeCheckTimelineSection();

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '안심 체크 기록',
            style: TextStyle(
              fontSize: 15.375,
              height: 24 / 15.375,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          const _TimelineEntry(
            icon: Icons.warning_amber_rounded,
            iconColor: Color(0xFFFBBF24),
            bgColor: Color(0xFFFFFBEB),
            borderColor: Color(0xFFFDE68A),
            title: '오늘',
            badge: '미완료',
            badgeColor: Color(0xFFF59E0B),
            badgeBg: Color(0xFFFFFBEB),
            subtitle: '1월 27일 (월)',
            showLine: true,
          ),
          const _TimelineEntry(
            icon: Icons.check_rounded,
            iconColor: AppColors.primary500,
            bgColor: AppColors.primaryMintBg,
            borderColor: AppColors.primary500,
            title: '어제',
            subtitle: '1월 26일 (일) · 오후 11:42',
            showLine: true,
          ),
          const _TimelineEntry(
            icon: Icons.check_rounded,
            iconColor: AppColors.primary500,
            bgColor: AppColors.primaryMintBg,
            borderColor: AppColors.primary500,
            title: '1월 25일 (토)',
            subtitle: '오전 10:23',
            showLine: true,
          ),
          const _TimelineEntry(
            icon: Icons.check_rounded,
            iconColor: AppColors.primary500,
            bgColor: AppColors.primaryMintBg,
            borderColor: AppColors.primary500,
            title: '1월 24일 (금)',
            subtitle: '오후 2:15',
            showLine: true,
          ),
          const _TimelineEntry(
            icon: Icons.close_rounded,
            iconColor: AppColors.dangerRedLight,
            bgColor: AppColors.featureRedBg,
            borderColor: Color(0xFFFECACA),
            title: '1월 23일 (목)',
            badge: '미완료',
            badgeColor: AppColors.dangerRedLight,
            badgeBg: AppColors.featureRedBg,
            subtitle: '체크 기록 없음',
            showLine: false,
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
    required this.title,
    required this.subtitle,
    required this.showLine,
    this.badge,
    this.badgeColor,
    this.badgeBg,
  });

  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;
  final String title;
  final String subtitle;
  final bool showLine;
  final String? badge;
  final Color? badgeColor;
  final Color? badgeBg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: showLine ? 16 : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: Icon(icon, size: 12, color: iconColor),
              ),
              if (showLine)
                Container(
                  width: 2,
                  height: 24,
                  margin: const EdgeInsets.only(top: 4),
                  color: AppColors.borderLight,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                          decoration: BoxDecoration(
                            color: badgeBg,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            badge!,
                            style: TextStyle(
                              fontSize: 12,
                              height: 16 / 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.56,
                              color: badgeColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                      color: AppColors.tabInactive,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyMonthlyScoresSection extends StatelessWidget {
  const _FamilyMonthlyScoresSection();

  static const _members = [
    _FamilyScore(name: '딸', score: 87, color: AppColors.primary500),
    _FamilyScore(name: '아버지', score: 58, color: AppColors.featureOrange),
    _FamilyScore(name: '어머니', score: 91, color: AppColors.primary700),
    _FamilyScore(name: '나', score: 82, color: AppColors.primary500),
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '우리 가족 이번 달 건강 점수',
            style: TextStyle(
              fontSize: 15.25,
              height: 24 / 15.25,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: _members.map((member) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        member.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 16 / 13,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: 18,
                            decoration: BoxDecoration(
                              color: member.color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: member.score / 100,
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                color: member.color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${member.score}점',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 15 / 12,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.alertBannerBg,
              border: Border.all(color: AppColors.alertBannerBorder),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFFEF3C7),
                  child: Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.warningAmber),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '아버지 주의 필요',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.59,
                          color: Color(0xFFB45309),
                        ),
                      ),
                      Text(
                        '이번 달 건강 점수가 낮아요 ⚠️ 확인해보세요',
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          letterSpacing: -0.55,
                          color: Color(0xFFD97706),
                        ),
                      ),
                    ],
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

class _FamilyScore {
  const _FamilyScore({required this.name, required this.score, required this.color});

  final String name;
  final int score;
  final Color color;
}

enum _MedCellState { done, missed, pending, future }

class _WeeklyMedicationSection extends StatelessWidget {
  const _WeeklyMedicationSection();

  static const _days = ['월', '화', '수', '목', '금', '토', '일'];
  static const _dayColors = [
    AppColors.tabInactive,
    AppColors.tabInactive,
    AppColors.tabInactive,
    AppColors.dangerRedLight,
    AppColors.tabInactive,
    AppColors.tabInactive,
    AppColors.statBlueIcon,
  ];

  @override
  Widget build(BuildContext context) {
    return _DetailCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '이번 주 약 복용 현황',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.06,
                  color: AppColors.textDark,
                ),
              ),
              const Text(
                '96%',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 64),
              ...List.generate(_days.length, (index) {
                return Expanded(
                  child: Center(
                    child: Text(
                      _days[index],
                      style: TextStyle(
                        fontSize: 12,
                        height: 16 / 12,
                        fontWeight: FontWeight.w700,
                        color: _dayColors[index],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 8),
          const _WeeklyMedRow(
            label: '아침 혈압약',
            states: [
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.missed,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.future,
            ],
          ),
          const _WeeklyMedRow(
            label: '점심 비타민',
            states: [
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.future,
            ],
          ),
          const _WeeklyMedRow(
            label: '저녁 혈당약',
            states: [
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.done,
              _MedCellState.future,
            ],
            highlightIndex: 5,
          ),
          const Divider(height: 32, thickness: 1, color: AppColors.borderLight),
          Row(
            children: [
              _legendDot(AppColors.primary500, '복용완료'),
              const SizedBox(width: 16),
              _legendDot(AppColors.dangerRedLight, '미복용', isHollow: true),
              const SizedBox(width: 16),
              _legendDot(AppColors.borderDefault, '예정', isHollow: true),
              const Spacer(),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '96%',
                    style: TextStyle(
                      fontSize: 14,
                      height: 20 / 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary500,
                    ),
                  ),
                  Text(
                    '복용률',
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      color: AppColors.tabInactive,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label, {bool isHollow = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isHollow ? Colors.transparent : color,
            shape: BoxShape.circle,
            border: isHollow ? Border.all(color: color, width: isHollow ? 2 : 0) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _WeeklyMedRow extends StatelessWidget {
  const _WeeklyMedRow({
    required this.label,
    required this.states,
    this.highlightIndex,
  });

  final String label;
  final List<_MedCellState> states;
  final int? highlightIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.22,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ...List.generate(states.length, (index) {
            return Expanded(
              child: Center(child: _MedCellIcon(state: states[index], highlighted: highlightIndex == index)),
            );
          }),
        ],
      ),
    );
  }
}

class _MedCellIcon extends StatelessWidget {
  const _MedCellIcon({required this.state, this.highlighted = false});

  final _MedCellState state;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 32,
      decoration: BoxDecoration(
        color: switch (state) {
          _MedCellState.done => highlighted ? AppColors.primary500.withValues(alpha: 0.8) : AppColors.primary500,
          _MedCellState.missed => AppColors.featureRedBg,
          _MedCellState.pending => Colors.transparent,
          _MedCellState.future => Colors.transparent,
        },
        border: switch (state) {
          _MedCellState.missed => Border.all(color: const Color(0xFFFECACA)),
          _MedCellState.future => Border.all(color: AppColors.borderDefault, width: 2),
          _MedCellState.done when highlighted => Border.all(color: AppColors.primary500, width: 2),
          _ => null,
        },
        borderRadius: BorderRadius.circular(999),
      ),
      child: Center(
        child: switch (state) {
          _MedCellState.done => const Icon(Icons.check, size: 9, color: Colors.white),
          _MedCellState.missed => const Text('✕', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.dangerRedLight)),
          _MedCellState.future => const Text('일', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.tabInactive)),
          _MedCellState.pending => null,
        },
      ),
    );
  }
}

class _HealthInsightSection extends StatelessWidget {
  const _HealthInsightSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0FDF9), Color(0xFFE6F9F5)],
        ),
        border: Border.all(color: AppColors.primary500.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 4),
            color: Color(0x0F000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary500.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.lightbulb_outline_rounded, size: 14, color: AppColors.primary500),
              ),
              const SizedBox(width: 8),
              const Text(
                '이번 달 건강 인사이트',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.7,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 4),
              const Text('✨', style: TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          const _InsightTile(
            emoji: '👣',
            title: '걸음 수가 늘었어요',
            subtitle: '지난 달보다 12% 더 많이 걸었어요!',
          ),
          const SizedBox(height: 12),
          const _InsightTile(
            emoji: '💊',
            title: '약 복용률이 꾸준해요',
            subtitle: '이번 달도 94% 복용률을 유지하고 있어요',
          ),
          const SizedBox(height: 12),
          const _InsightTile(
            emoji: '⚠️',
            title: '아버지 활동량 감소',
            subtitle: '이번 달 활동량이 많이 줄었어요. 확인해보세요',
            isWarning: true,
          ),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.isWarning = false,
  });

  final String emoji;
  final String title;
  final String subtitle;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWarning ? AppColors.alertBannerBg : AppColors.surface,
        border: isWarning ? Border.all(color: const Color(0xFFFEF3C7)) : null,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isWarning
            ? null
            : const [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  color: Color(0x0F000000),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(emoji, style: const TextStyle(fontSize: 20, height: 28 / 20)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.67,
                    color: isWarning ? const Color(0xFFB45309) : AppColors.textDark,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    height: 16 / 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: isWarning ? -0.59 : -0.42,
                    color: isWarning ? const Color(0xFFD97706) : AppColors.textSecondary,
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
