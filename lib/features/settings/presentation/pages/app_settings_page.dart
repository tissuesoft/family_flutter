import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/components/toggle_row.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_card.dart';
import '../../../../../core/widgets/app_pill_button.dart';
import '../../../../../core/widgets/app_shell.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _safeCheck = true;
  bool _missedMed = true;
  bool _stepDrop = true;
  bool _healthDrop = true;
  bool _sos = true;
  bool _dailySummary = false;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.settings,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: AppSpacing.md),
          Center(child: Text('설정', style: AppTextStyles.heading)),
          const SizedBox(height: AppSpacing.lg),
          _ProfileCard(),
          const SizedBox(height: AppSpacing.lg),
          _FamilyMembersCard(),
          const SizedBox(height: AppSpacing.lg),
          _NotificationCard(
            safeCheck: _safeCheck,
            missedMed: _missedMed,
            stepDrop: _stepDrop,
            healthDrop: _healthDrop,
            sos: _sos,
            dailySummary: _dailySummary,
            onSafeCheckChanged: (value) => setState(() => _safeCheck = value),
            onMissedMedChanged: (value) => setState(() => _missedMed = value),
            onStepDropChanged: (value) => setState(() => _stepDrop = value),
            onHealthDropChanged: (value) => setState(() => _healthDrop = value),
            onSosChanged: (value) => setState(() => _sos = value),
            onDailySummaryChanged: (value) => setState(() => _dailySummary = value),
          ),
          const SizedBox(height: AppSpacing.lg),
          _PrivacyCard(),
          const SizedBox(height: AppSpacing.lg),
          _PremiumCard(),
          const SizedBox(height: AppSpacing.lg),
          _AppInfoCard(),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('김민준', style: AppTextStyles.heading),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary50,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text('나', style: AppTextStyles.caption.copyWith(color: AppColors.primary500)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text('프리미엄', style: AppTextStyles.caption.copyWith(color: AppColors.orange)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text('건강 리포트 →', style: AppTextStyles.body.copyWith(color: AppColors.primary500)),
        ],
      ),
    );
  }
}

class _FamilyMembersCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('가족 구성원', style: AppTextStyles.sectionTitle)),
              Text('수정', style: AppTextStyles.caption),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const _FamilyMemberRow(name: '어머니', role: '부모'),
          const _FamilyMemberRow(name: '아버지', role: '부모'),
          const _FamilyMemberRow(name: '딸', role: '자녀'),
          const SizedBox(height: AppSpacing.md),
          AppPillButton(
            variant: AppPillButtonVariant.secondary,
            label: '가족 초대하기',
            icon: const Icon(Icons.add_rounded, color: AppColors.primary500),
            onPressed: () => Navigator.of(context).pushNamed('/onboarding'),
          ),
        ],
      ),
    );
  }
}

class _FamilyMemberRow extends StatelessWidget {
  const _FamilyMemberRow({required this.name, required this.role});

  final String name;
  final String role;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(child: Text(name, style: AppTextStyles.body)),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(role, style: AppTextStyles.caption.copyWith(color: AppColors.primary500)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('건강 정보 공유 중', style: AppTextStyles.caption),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textDisabled),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.safeCheck,
    required this.missedMed,
    required this.stepDrop,
    required this.healthDrop,
    required this.sos,
    required this.dailySummary,
    required this.onSafeCheckChanged,
    required this.onMissedMedChanged,
    required this.onStepDropChanged,
    required this.onHealthDropChanged,
    required this.onSosChanged,
    required this.onDailySummaryChanged,
  });

  final bool safeCheck;
  final bool missedMed;
  final bool stepDrop;
  final bool healthDrop;
  final bool sos;
  final bool dailySummary;
  final ValueChanged<bool> onSafeCheckChanged;
  final ValueChanged<bool> onMissedMedChanged;
  final ValueChanged<bool> onStepDropChanged;
  final ValueChanged<bool> onHealthDropChanged;
  final ValueChanged<bool> onSosChanged;
  final ValueChanged<bool> onDailySummaryChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('알림 설정', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ToggleRow(
            title: '안심 체크 미완료 알림',
            value: safeCheck,
            onChanged: onSafeCheckChanged,
          ),
          ToggleRow(
            title: '약 미복용 알림',
            value: missedMed,
            onChanged: onMissedMedChanged,
          ),
          ToggleRow(
            title: '걸음 수 현저히 감소',
            value: stepDrop,
            onChanged: onStepDropChanged,
          ),
          ToggleRow(
            title: '건강 점수 하락',
            value: healthDrop,
            onChanged: onHealthDropChanged,
          ),
          ToggleRow(
            title: '가족 SOS 호출',
            subtitle: '중요 알림 — 항상 활성화',
            value: sos,
            onChanged: onSosChanged,
          ),
          ToggleRow(
            title: '일일 건강 요약 알림',
            value: dailySummary,
            onChanged: onDailySummaryChanged,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(child: Text('알림 시간', style: AppTextStyles.body)),
              Text('매일 오후 9:00', style: AppTextStyles.caption),
              const SizedBox(width: AppSpacing.sm),
              Text('편집', style: AppTextStyles.caption.copyWith(color: AppColors.primary500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('내 정보 공개 범위', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          const _PrivacyRow(icon: Icons.directions_walk_rounded, label: '걸음 수', badge: '가족 전체'),
          const _PrivacyRow(icon: Icons.medication_rounded, label: '약 복용', badge: '가족 전체'),
          const _PrivacyRow(icon: Icons.sentiment_satisfied_alt_rounded, label: '기분', badge: '가족 전체'),
          const _PrivacyRow(icon: Icons.favorite_rounded, label: '건강 점수', badge: '나만 보기'),
        ],
      ),
    );
  }
}

class _PrivacyRow extends StatelessWidget {
  const _PrivacyRow({
    required this.icon,
    required this.label,
    required this.badge,
  });

  final IconData icon;
  final String label;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary500),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(label, style: AppTextStyles.body)),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary50,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(badge, style: AppTextStyles.caption.copyWith(color: AppColors.primary500)),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textDisabled),
        ],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.orange, AppColors.premiumOrange],
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('가족안심 프리미엄', style: AppTextStyles.sectionTitle.copyWith(color: AppColors.white)),
          const SizedBox(height: AppSpacing.sm),
          Text('현재: 무료 플랜 (기본 기능)', style: AppTextStyles.caption.copyWith(color: AppColors.white)),
          const SizedBox(height: AppSpacing.md),
          Text('• 가족 구성원 무제한 추가', style: AppTextStyles.body.copyWith(color: AppColors.white)),
          Text('• AI 건강 분석 및 리포트', style: AppTextStyles.body.copyWith(color: AppColors.white)),
          Text('• 긴급 SOS 자동 감지', style: AppTextStyles.body.copyWith(color: AppColors.white)),
          const SizedBox(height: AppSpacing.md),
          AppPillButton(
            variant: AppPillButtonVariant.secondary,
            label: '프리미엄 시작하기 - 월 4,900원',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      radius: AppRadius.large,
      child: Column(
        children: [
          _InfoRow(label: '앱 버전', value: '1.0.0'),
          _InfoRow(label: '이용약관', value: ''),
          _InfoRow(label: '개인정보처리방침', value: ''),
          _InfoRow(label: '로그아웃', value: '', isDanger: true),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isDanger = false,
  });

  final String label;
  final String value;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: isDanger ? AppColors.error : AppColors.textPrimary,
              ),
            ),
          ),
          if (value.isNotEmpty) Text(value, style: AppTextStyles.caption),
          if (!isDanger && value.isEmpty)
            const Icon(Icons.chevron_right_rounded, color: AppColors.textDisabled),
          if (isDanger) const Icon(Icons.logout_rounded, color: AppColors.error),
        ],
      ),
    );
  }
}
