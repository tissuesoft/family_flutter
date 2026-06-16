import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/components/toggle_row.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_pill_button.dart';
import '../../../../../core/widgets/app_segmented_control.dart';
import '../../../../../core/widgets/app_shell.dart';

class MyMedicationsPage extends StatefulWidget {
  const MyMedicationsPage({super.key});

  @override
  State<MyMedicationsPage> createState() => _MyMedicationsPageState();
}

class _MyMedicationsPageState extends State<MyMedicationsPage> {
  String _segment = 'mine';

  bool _reminderTime = true;
  bool _reminderDay = true;
  bool _reminderMissed = true;
  bool _reminderHealth = false;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.meds,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: AppSpacing.md),
          Center(child: Text('약 복용 관리', style: AppTextStyles.heading)),
          const SizedBox(height: AppSpacing.md),
          AppSegmentedControl<String>(
            selected: _segment,
            onSelected: (value) => setState(() => _segment = value),
            items: const [
              AppSegmentedControlItem(label: '내 복용', value: 'mine'),
              AppSegmentedControlItem(label: '가족 현황', value: 'family'),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_segment == 'mine') _buildMyMedications() else _buildFamilyOverview(),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildMyMedications() {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('오늘 약 복용', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          const _MedicationActionTile(
            title: '혈압약',
            subtitle: '복용완료 (오전 8:00)',
            isCompleted: true,
          ),
          const _MedicationActionTile(
            title: '당뇨약',
            subtitle: '복용예정 (오후 1:00)',
            isCompleted: true,
          ),
          const _MedicationActionTile(
            title: '비타민D',
            subtitle: '복용완료 (오후 7:00)',
            isCompleted: false,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _PracticeSection(days: 12, percent: 0.94),
          const SizedBox(height: AppSpacing.lg),
          const _MedicationListSection(),
          const SizedBox(height: AppSpacing.lg),
          Text('복용 알림 설정', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ToggleRow(
            title: '복용 시간 알림',
            subtitle: '복용 30분 전 알림',
            value: _reminderTime,
            onChanged: (value) => setState(() => _reminderTime = value),
          ),
          ToggleRow(
            title: '일일 복용 알림',
            subtitle: '매일 오전 8:00',
            value: _reminderDay,
            onChanged: (value) => setState(() => _reminderDay = value),
          ),
          ToggleRow(
            title: '약 미복용 알림',
            subtitle: '가족에게 알림',
            value: _reminderMissed,
            onChanged: (value) => setState(() => _reminderMissed = value),
          ),
          ToggleRow(
            title: '건강 점수 하락',
            subtitle: '주의 필요',
            value: _reminderHealth,
            onChanged: (value) => setState(() => _reminderHealth = value),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyOverview() {
    return Column(
      children: [
        AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          radius: AppRadius.large,
          color: AppColors.alertBackground,
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '오늘 복용 현황 3명 완료 · 1명 미복용',
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _FamilyMedicationCard(
          name: '어머니',
          subtitle: '2가지 약 등록',
          badge: '모두 완료',
          tone: _FamilyTone.success,
        ),
        const _FamilyMedicationCard(
          name: '아버지',
          subtitle: '1가지 약 등록',
          badge: '미복용 있음',
          tone: _FamilyTone.error,
        ),
        const _FamilyMedicationCard(
          name: '아들',
          subtitle: '약 없음',
          badge: '미등록',
          tone: _FamilyTone.neutral,
        ),
        const SizedBox(height: AppSpacing.md),
        AppPillButton(
          variant: AppPillButtonVariant.primary,
          label: '약 추가하기',
          icon: const Icon(Icons.add_rounded, color: AppColors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _MedicationActionTile extends StatelessWidget {
  const _MedicationActionTile({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? AppColors.primary500 : AppColors.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        children: [
          Icon(Icons.medication_rounded, color: color),
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
          Icon(
            isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: color,
          ),
        ],
      ),
    );
  }
}

class _PracticeSection extends StatelessWidget {
  const _PracticeSection({required this.days, required this.percent});

  final int days;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('복용 연속 ${days}일째!', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.xs),
        Text('꾸준히 잘 복용하고 있어요', style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(child: Text('이달 복용률', style: AppTextStyles.body)),
            Text('${(percent * 100).round()}%', style: AppTextStyles.body),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 10,
            backgroundColor: AppColors.primary100,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary500),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const SimpleBarChart(
          values: [0.7, 0.85, 0.9, 0.94, 0.88, 0.92, 0.94],
          height: 90,
        ),
      ],
    );
  }
}

class _MedicationListSection extends StatelessWidget {
  const _MedicationListSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text('내 약 목록', style: AppTextStyles.sectionTitle)),
            AppPillButton(
              variant: AppPillButtonVariant.secondary,
              label: '약 추가하기',
              icon: const Icon(Icons.add_rounded, color: AppColors.primary500),
              height: 40,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        const _MedicationListItem(name: '혈압약', time: '아침 복용 · 오전 8:00'),
        const _MedicationListItem(name: '당뇨약', time: '점심 복용 · 오후 1:00'),
        const _MedicationListItem(name: '비타민C', time: '저녁 복용 · 오후 7:00'),
      ],
    );
  }
}

class _MedicationListItem extends StatelessWidget {
  const _MedicationListItem({required this.name, required this.time});

  final String name;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(AppRadius.small),
            ),
            child: const Icon(Icons.medication_rounded, color: AppColors.primary500),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.body),
                const SizedBox(height: AppSpacing.xs),
                Text(time, style: AppTextStyles.caption),
              ],
            ),
          ),
          const Icon(Icons.edit_outlined, color: AppColors.textDisabled),
        ],
      ),
    );
  }
}

enum _FamilyTone { success, error, neutral }

class _FamilyMedicationCard extends StatelessWidget {
  const _FamilyMedicationCard({
    required this.name,
    required this.subtitle,
    required this.badge,
    required this.tone,
  });

  final String name;
  final String subtitle;
  final String badge;
  final _FamilyTone tone;

  Color get backgroundColor => switch (tone) {
        _FamilyTone.success => AppColors.primary50,
        _FamilyTone.error => AppColors.errorBackground,
        _FamilyTone.neutral => AppColors.surface,
      };

  Color get badgeColor => switch (tone) {
        _FamilyTone.success => AppColors.primary500,
        _FamilyTone.error => AppColors.error,
        _FamilyTone.neutral => AppColors.textSecondary,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        radius: AppRadius.medium,
        color: backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTextStyles.cardTitle),
                  const SizedBox(height: AppSpacing.xs),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                badge,
                style: AppTextStyles.caption.copyWith(color: badgeColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
