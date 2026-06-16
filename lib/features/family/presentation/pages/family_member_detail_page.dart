import 'package:flutter/material.dart';

import '../../../../../core/charts/sparkline_chart.dart';
import '../../../../../core/components/alert_card.dart';
import '../../../../../core/components/health_score_card.dart';
import '../../../../../core/components/page_header.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_pill_button.dart';
import '../../../../../core/widgets/app_segmented_control.dart';
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
      onSelectedTab: (_) {},
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const PageHeader(
            title: '아버지',
            showBack: true,
            trailing: Icon(Icons.more_horiz_rounded),
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.18),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                '안심 체크 대기 중',
                style: AppTextStyles.caption.copyWith(color: AppColors.orange),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Center(
            child: Text('마지막 확인: 어제 오후 11:42', style: AppTextStyles.caption),
          ),
          const SizedBox(height: AppSpacing.md),
          AppPillButton(
            variant: AppPillButtonVariant.secondary,
            label: '안심 확인 요청 보내기',
            icon: const Icon(Icons.info_outline_rounded, color: AppColors.primary500),
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.lg),
          AppSegmentedControl<ReportPeriod>(
            selected: _period,
            onSelected: (value) => setState(() => _period = value),
            items: const [
              AppSegmentedControlItem(label: '오늘', value: ReportPeriod.today),
              AppSegmentedControlItem(label: '주간', value: ReportPeriod.week),
              AppSegmentedControlItem(label: '월간', value: ReportPeriod.month),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Text(
              _periodLabel,
              style: AppTextStyles.body,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          HealthScoreCard(
            title: _scoreTitle,
            scoreText: '82점',
            percentText: '82%',
            subTitle: '지난주보다 +7점 상승',
            metrics: const [
              HealthScoreCardMetric(
                label: '안심체크',
                valueText: '95%',
                color: AppColors.primary100,
              ),
              HealthScoreCardMetric(
                label: '걸음 수',
                valueText: '78%',
                color: AppColors.orange,
              ),
              HealthScoreCardMetric(
                label: '약 복용',
                valueText: '94%',
                color: AppColors.primary500,
              ),
              HealthScoreCardMetric(
                label: '비타민',
                valueText: '88%',
                color: AppColors.primary500,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            radius: AppRadius.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_stepsTitle, style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.sm),
                Text('7,234 보 / 일 평균', style: AppTextStyles.heading),
                const SizedBox(height: AppSpacing.xs),
                Text('최고 12,847보 · 최저 1,209보', style: AppTextStyles.caption),
                const SizedBox(height: AppSpacing.md),
                const SparklineChart(
                  values: [1.2, 1.8, 2.1, 2.4, 2.0, 2.6, 2.3],
                  height: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            radius: AppRadius.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(_medicationTitle, style: AppTextStyles.sectionTitle)),
                    Text('90%', style: AppTextStyles.body.copyWith(color: AppColors.primary500)),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const _MedicationGrid(),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            radius: AppRadius.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('안심 체크 기록', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.md),
                const _TimelineItem(
                  icon: Icons.warning_amber_rounded,
                  color: AppColors.warning,
                  title: '오늘 미완료',
                  subtitle: '1회 남음',
                ),
                const _TimelineItem(
                  icon: Icons.check_circle_rounded,
                  color: AppColors.primary500,
                  title: '어제',
                  subtitle: '1월 26일 (일) 오후 11:42',
                ),
                const _TimelineItem(
                  icon: Icons.close_rounded,
                  color: AppColors.error,
                  title: '1월 23일 미완료',
                  subtitle: '체크 기록 없음',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            radius: AppRadius.large,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('우리 가족 이번 주 건강 점수', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.md),
                const _FamilyScoreRow(name: '딸', score: 87, color: AppColors.primary500),
                const _FamilyScoreRow(name: '아버지', score: 68, color: AppColors.orange),
                const _FamilyScoreRow(name: '어머니', score: 91, color: AppColors.primary700),
                const _FamilyScoreRow(name: '나', score: 92, color: AppColors.primary500),
                const SizedBox(height: AppSpacing.md),
                const AlertCard(
                  title: '아버지 주의 필요',
                  message: '이번 주 건강 점수가 낮아요. 확인해보세요.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            radius: AppRadius.large,
            color: AppColors.primary50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이번 주 건강 인사이트', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.md),
                const _InsightTile(
                  icon: Icons.directions_walk_rounded,
                  title: '걸음 수가 늘었어요',
                  subtitle: '지난 주보다 12% 더 많이 걸었어요.',
                ),
                const _InsightTile(
                  icon: Icons.medication_rounded,
                  title: '약 복용률이 꾸준해요',
                  subtitle: '이번 주도 94% 복용률을 유지하고 있어요.',
                ),
                const _InsightTile(
                  icon: Icons.warning_amber_rounded,
                  title: '아버지 활동량 감소',
                  subtitle: '이번 주 활동량이 많이 줄었어요. 확인해보세요.',
                  highlight: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  String get _periodLabel {
    return switch (_period) {
      ReportPeriod.today => '2025년 1월 27일(월)',
      ReportPeriod.week => '2025년 1월 13일 - 1월 19일',
      ReportPeriod.month => '2025년 1월',
    };
  }

  String get _scoreTitle {
    return switch (_period) {
      ReportPeriod.today => '오늘 통합 건강 점수',
      ReportPeriod.week => '이번 주 종합 건강 점수',
      ReportPeriod.month => '이번 달 종합 건강 점수',
    };
  }

  String get _stepsTitle {
    return switch (_period) {
      ReportPeriod.today => '오늘 걸음 수 추이',
      ReportPeriod.week => '이번 주 걸음 수 추이',
      ReportPeriod.month => '이번 달 걸음 수 추이',
    };
  }

  String get _medicationTitle {
    return switch (_period) {
      ReportPeriod.today => '오늘 약 복용',
      ReportPeriod.week => '이번 주 약 복용 현황',
      ReportPeriod.month => '이번 달 복용 현황',
    };
  }
}

class _MedicationGrid extends StatelessWidget {
  const _MedicationGrid();

  @override
  Widget build(BuildContext context) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];
    const rows = ['아침', '점심', '저녁'];

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 48),
            ...days.map(
              (day) => Expanded(
                child: Center(child: Text(day, style: AppTextStyles.caption)),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...rows.map((row) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Row(
              children: [
                SizedBox(
                  width: 48,
                  child: Text(row, style: AppTextStyles.caption),
                ),
                ...List.generate(7, (index) {
                  final isMissed = row == '점심' && index == 3;
                  final isDone = !isMissed && index != 6;
                  final color = isMissed
                      ? AppColors.error
                      : isDone
                          ? AppColors.primary500
                          : AppColors.calendarScheduledBg;
                  return Expanded(
                    child: Center(
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: color.withOpacity(isDone || isMissed ? 1 : 0.4),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isMissed
                              ? Icons.close_rounded
                              : isDone
                                  ? Icons.check_rounded
                                  : Icons.circle_outlined,
                          size: 14,
                          color: isDone || isMissed ? AppColors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.xs),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyScoreRow extends StatelessWidget {
  const _FamilyScoreRow({
    required this.name,
    required this.score,
    required this.color,
  });

  final String name;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(width: 48, child: Text(name, style: AppTextStyles.caption)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 10,
                backgroundColor: color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('$score점', style: AppTextStyles.body),
        ],
      ),
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.highlight = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: highlight ? AppColors.alertBackground : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        children: [
          Icon(icon, color: highlight ? AppColors.warning : AppColors.primary500),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.xs),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
