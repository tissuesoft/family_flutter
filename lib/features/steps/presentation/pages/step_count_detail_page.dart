import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/heat_map_circles.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_shell.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';

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
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: AppSpacing.md),
          Text('내 걸음 수', style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '2025년 1월 27일 월요일',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.lg),
          _TodayStepsCard(totalSteps: '6,248', percent: 0.62),
          const SizedBox(height: AppSpacing.lg),
          _SectionCard(
            title: '이달의 걸음 수',
            rightLabel: '목표 달성 90%',
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: SimpleBarChart(
                values: [0.3, 0.45, 0.4, 0.55, 0.5, 0.62, 0.4, 0.75, 0.58, 0.82],
                height: 110,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionCard(
            title: '우리 가족 오늘 걸음 수',
            rightLabel: '목표 달성 62%',
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  _MemberWalkRow(name: '아버지', value: '4,523걸음', color: AppColors.primary500),
                  const SizedBox(height: AppSpacing.sm),
                  _MemberWalkRow(name: '어머니', value: '2,103걸음', color: AppColors.primary100),
                  const SizedBox(height: AppSpacing.sm),
                  _MemberWalkRow(name: '아들', value: '5,983걸음', color: AppColors.orange),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionCard(
            title: '이번달 탐색',
            rightLabel: '월간 활동',
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이번달 평균: 7,234 걸음', style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.md),
                  HeatMapCircles(
                    values: const [
                      0.1, 0.25, 0.3, 0.45, 0.2, 0.6, 0.7,
                      0.1, 0.3, 0.35, 0.5, 0.4, 0.7, 0.8,
                      0.2, 0.15, 0.4, 0.55, 0.6, 0.3, 0.9,
                      0.1, 0.25, 0.35, 0.5, 0.45, 0.6, 0.7,
                      0.12, 0.22, 0.32, 0.42, 0.52, 0.62, 0.72,
                    ],
                    columns: 7,
                    rows: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _TodayStepsCard extends StatelessWidget {
  const _TodayStepsCard({required this.totalSteps, required this.percent});

  final String totalSteps;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 10,
                      backgroundColor: AppColors.primary100.withOpacity(0.35),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary500),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(totalSteps, style: AppTextStyles.heading),
                        const SizedBox(height: AppSpacing.xs),
                        Text('${(percent * 100).round()}%', style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text('3,752걸음 더 모으면 목표 달성!', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.rightLabel,
    required this.child,
  });

  final String title;
  final String rightLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
              Text(rightLabel, style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _MemberWalkRow extends StatelessWidget {
  const _MemberWalkRow({required this.name, required this.value, required this.color});

  final String name;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 10, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(name, style: AppTextStyles.caption),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: color.withOpacity(0.18),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 220,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(value, style: AppTextStyles.body),
      ],
    );
  }
}

