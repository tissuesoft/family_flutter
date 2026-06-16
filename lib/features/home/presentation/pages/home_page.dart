import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/components/health_score_card.dart';
import '../../../../../core/components/medication_list_item.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_pill_button.dart';
import '../../../../../core/widgets/app_shell.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.home,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Text('가족안심', style: AppTextStyles.heading.copyWith(color: AppColors.primary500)),
          const SizedBox(height: AppSpacing.md),
          HealthScoreCard(
            title: '오늘 내 건강 점수',
            scoreText: '87점',
            percentText: '87%',
            subTitle: '좋음',
            metrics: const [
              HealthScoreCardMetric(
                label: '안심체크',
                valueText: '완료',
                color: AppColors.primary100,
                icon: Icons.shield_rounded,
              ),
              HealthScoreCardMetric(
                label: '걸음',
                valueText: '6,248',
                color: AppColors.orange,
                icon: Icons.directions_walk_rounded,
              ),
              HealthScoreCardMetric(
                label: '약복용',
                valueText: '2/3',
                color: AppColors.primary500,
                icon: Icons.medication_rounded,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: '오늘 안심 체크'),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                AppPillButton(
                  variant: AppPillButtonVariant.primary,
                  label: '오늘도 괜찮아요',
                  icon: const Icon(Icons.check_rounded, color: AppColors.white),
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('오늘 13:24 완료', style: AppTextStyles.caption),
                Text('가족들이 확인할 수 있어요', style: AppTextStyles.caption),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(
            title: '오늘 가족 건강 현황',
            trailing: TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/family'),
              child: Text('전체보기 >', style: AppTextStyles.caption.copyWith(color: AppColors.primary500)),
            ),
          ),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: const [
                _FamilySummaryRow(
                  name: '어머니 (김순자, 68세)',
                  safe: '안심 완료',
                  steps: '4,523보',
                  med: '혈압약',
                  mood: '기분 좋음',
                  isWarning: false,
                ),
                Divider(height: AppSpacing.lg),
                _FamilySummaryRow(
                  name: '아버지 (박종국, 71세)',
                  safe: '안심 대기',
                  steps: '2,103보',
                  med: '혈압약 미복용',
                  mood: '기분 보통',
                  isWarning: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: '오늘 약 복용'),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: const [
                MedicationListItem(
                  name: '혈압약',
                  timeText: '복용완료 (오전 8:00)',
                  statusType: MedicationStatusType.completed,
                  statusLabel: '복용완료',
                ),
                MedicationListItem(
                  name: '당뇨약',
                  timeText: '오후 1:00 예정',
                  statusType: MedicationStatusType.scheduled,
                  statusLabel: '예정',
                ),
                MedicationListItem(
                  name: '비타민C',
                  timeText: '복용완료',
                  statusType: MedicationStatusType.completed,
                  statusLabel: '복용완료',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: '오늘 기분은 어때요?'),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('😠', style: TextStyle(fontSize: 24)),
                Text('😟', style: TextStyle(fontSize: 24)),
                Text('😐', style: TextStyle(fontSize: 24)),
                Text('😊', style: TextStyle(fontSize: 32)),
                Text('😄', style: TextStyle(fontSize: 24)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionHeader(title: '내 걸음 수'),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('6,248 보', style: AppTextStyles.heading),
                const SizedBox(height: AppSpacing.xs),
                Text('오늘 목표까지 3,752보 남았어요', style: AppTextStyles.caption),
                const SizedBox(height: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: const LinearProgressIndicator(
                    value: 0.62,
                    minHeight: 8,
                    backgroundColor: AppColors.primary100,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const SimpleBarChart(
                  values: [0.4, 0.5, 0.45, 0.55, 0.62, 0.48, 0.52],
                  height: 80,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
          ?trailing,
        ],
      ),
    );
  }
}

class _FamilySummaryRow extends StatelessWidget {
  const _FamilySummaryRow({
    required this.name,
    required this.safe,
    required this.steps,
    required this.med,
    required this.mood,
    required this.isWarning,
  });

  final String name;
  final String safe;
  final String steps;
  final String med;
  final String mood;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppTextStyles.body),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _Tag(label: safe, color: isWarning ? AppColors.warning : AppColors.primary500),
            _Tag(label: steps, color: AppColors.textSecondary),
            _Tag(label: med, color: isWarning ? AppColors.error : AppColors.primary500),
            _Tag(label: mood, color: AppColors.warning),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(color: color)),
    );
  }
}
