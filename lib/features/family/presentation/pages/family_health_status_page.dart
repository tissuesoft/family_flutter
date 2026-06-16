import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_pill_button.dart';
import '../../../../../core/widgets/app_shell.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_card.dart';

class FamilyHealthStatusPage extends StatelessWidget {
  const FamilyHealthStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.family,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: AppSpacing.md),
          Text(
            '오늘 가족 건강 현황',
            style: AppTextStyles.heading,
          ),
          const SizedBox(height: AppSpacing.md),
          _FamilySafetyCard(
            title: '가족 4명 중 3명 안심 완료',
            percent: 0.75,
            percentText: '75%',
          ),
          const SizedBox(height: AppSpacing.lg),
          _MemberStatusCard(
            name: '어머니',
            ageText: '김수진, 68세',
            safeLabel: '안심',
            walkLabel: '4,523걸음',
            medLabel: '복용완료',
            tone: _MemberTone.success,
            onTap: () => Navigator.of(context).pushNamed('/family/member'),
          ),
          _MemberStatusCard(
            name: '아버지',
            ageText: '박종국, 71세',
            safeLabel: '주의 필요',
            walkLabel: '2,103걸음',
            medLabel: '복용 미완료',
            tone: _MemberTone.error,
            onTap: () => Navigator.of(context).pushNamed('/family/member'),
          ),
          _MemberStatusCard(
            name: '아들',
            ageText: '전병학, 35세',
            safeLabel: '안심',
            walkLabel: '8,112걸음',
            medLabel: '복용예정',
            tone: _MemberTone.scheduled,
            onTap: () => Navigator.of(context).pushNamed('/family/member'),
          ),
          _MemberStatusCard(
            name: '딸',
            ageText: '정승수, 32세',
            safeLabel: '안심',
            walkLabel: '5,983걸음',
            medLabel: '복용완료',
            tone: _MemberTone.success,
            onTap: () => Navigator.of(context).pushNamed('/family/member'),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppPillButton(
            variant: AppPillButtonVariant.primary,
            label: '가족 초대하기',
            icon: const Icon(Icons.group_add_rounded, color: AppColors.white),
            height: 56,
            onPressed: () => {},
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _FamilySafetyCard extends StatelessWidget {
  const _FamilySafetyCard({
    required this.title,
    required this.percent,
    required this.percentText,
  });

  final String title;
  final double percent;
  final String percentText;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.large,
      padding: const EdgeInsets.all(AppSpacing.lg),
      color: AppColors.primary500,
      showShadow: true,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary700, AppColors.primary500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.sectionTitle.copyWith(color: AppColors.white),
              ),
            ),
            SizedBox(
              width: 108,
              height: 108,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: percent,
                    strokeWidth: 10,
                    backgroundColor: AppColors.white.withOpacity(0.18),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        percentText,
                        style: AppTextStyles.display.copyWith(fontSize: 28, color: AppColors.white),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '완료',
                        style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _MemberTone { success, error, scheduled }

class _MemberStatusCard extends StatelessWidget {
  const _MemberStatusCard({
    required this.name,
    required this.ageText,
    required this.safeLabel,
    required this.walkLabel,
    required this.medLabel,
    required this.tone,
    this.onTap,
  });

  final String name;
  final String ageText;
  final String safeLabel;
  final String walkLabel;
  final String medLabel;
  final _MemberTone tone;
  final VoidCallback? onTap;

  Color get safeBg => switch (tone) {
        _MemberTone.success => AppColors.primary100,
        _MemberTone.error => AppColors.error.withOpacity(0.12),
        _MemberTone.scheduled => AppColors.calendarScheduledBg,
      };

  Color get safeColor => switch (tone) {
        _MemberTone.success => AppColors.primary700,
        _MemberTone.error => AppColors.error,
        _MemberTone.scheduled => AppColors.orange,
      };

  Color get dotColor => switch (tone) {
        _MemberTone.success => AppColors.primary500,
        _MemberTone.error => AppColors.error,
        _MemberTone.scheduled => AppColors.warning,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        onTap: onTap,
        child: AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          radius: AppRadius.medium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyles.cardTitle),
                        const SizedBox(height: AppSpacing.xs),
                        Text(ageText, style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 1.0,
                    ),
                    decoration: BoxDecoration(
                      color: safeBg,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      safeLabel,
                      style: AppTextStyles.caption.copyWith(color: safeColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: _StatRow(label: '걸음 수', value: walkLabel, tone: tone),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _StatRow(label: '약 복용', value: medLabel, tone: tone),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value, required this.tone});

  final String label;
  final String value;
  final _MemberTone tone;

  Color get toneColor => switch (tone) {
        _MemberTone.success => AppColors.primary500,
        _MemberTone.error => AppColors.error,
        _MemberTone.scheduled => AppColors.warning,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: toneColor),
              const SizedBox(width: AppSpacing.xs),
              Text(label, style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: AppTextStyles.body),
        ],
      ),
    );
  }
}

