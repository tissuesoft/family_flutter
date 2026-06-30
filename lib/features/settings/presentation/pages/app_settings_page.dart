import 'package:flutter/material.dart';

import '../../../../../core/components/page_header.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
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
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 112),
          children: [
            const ScreenTitle('설정'),
          const SizedBox(height: 20),
          const _ProfileSection(),
          const SizedBox(height: 20),
          const _FamilyMembersSection(),
          const SizedBox(height: 20),
          _NotificationSection(
            safeCheck: _safeCheck,
            missedMed: _missedMed,
            stepDrop: _stepDrop,
            healthDrop: _healthDrop,
            sos: _sos,
            dailySummary: _dailySummary,
            onSafeCheckChanged: (v) => setState(() => _safeCheck = v),
            onMissedMedChanged: (v) => setState(() => _missedMed = v),
            onStepDropChanged: (v) => setState(() => _stepDrop = v),
            onHealthDropChanged: (v) => setState(() => _healthDrop = v),
            onSosChanged: (v) => setState(() => _sos = v),
            onDailySummaryChanged: (v) => setState(() => _dailySummary = v),
          ),
          const SizedBox(height: 20),
          const _PrivacySection(),
          const SizedBox(height: 20),
          const _PremiumSection(),
          const SizedBox(height: 20),
          const _AppInfoSection(),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
        color: AppColors.tabInactive,
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF1F3F6));
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '김민준',
                style: TextStyle(
                  fontSize: 18,
                  height: 28 / 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.35,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '나',
                  style: TextStyle(
                    fontSize: 11,
                    height: 16 / 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFFBD724),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '자녀',
                  style: TextStyle(
                    fontSize: 11,
                    height: 16 / 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '프로필 편집',
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.6,
                      color: AppColors.primary500,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right,
                    size: 10,
                    color: AppColors.primary500,
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

class _FamilyMembersSection extends StatelessWidget {
  const _FamilyMembersSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _SectionTitle('가족 구성원'),
                Text(
                  '4명',
                  style: TextStyle(
                    fontSize: 12,
                    height: 18 / 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.11,
                    color: AppColors.tabInactive,
                  ),
                ),
              ],
            ),
          ),
          const _FamilyMemberRow(name: '어머니', role: '부모'),
          const _SettingsDivider(),
          const _FamilyMemberRow(name: '아버지', role: '부모'),
          const _SettingsDivider(),
          const _FamilyMemberRow(name: '딸', role: '형제자매'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.of(context).pushNamed('/onboarding'),
                borderRadius: BorderRadius.circular(16),
                child: Ink(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary500.withValues(alpha: 0.3),
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _InviteIcon(),
                      SizedBox(width: 8),
                      Text(
                        '가족 초대하기',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.59,
                          color: AppColors.primary500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InviteIcon extends StatelessWidget {
  const _InviteIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary500.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_add_alt_1_rounded,
        size: 14,
        color: AppColors.primary500,
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
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.82,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5F9F6),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          role,
                          style: const TextStyle(
                            fontSize: 10,
                            height: 15 / 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                            color: AppColors.primary500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '건강 정보 공유 중',
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.54,
                      color: AppColors.tabInactive,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 14, color: Color(0xFFD1D5DB)),
          ],
        ),
      ),
    );
  }
}

class _NotificationSection extends StatelessWidget {
  const _NotificationSection({
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
    return _SettingsCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: _SectionTitle('알림 설정'),
          ),
          _NotificationToggleRow(
            title: '안심 체크 미완료 알림',
            value: safeCheck,
            onChanged: onSafeCheckChanged,
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
          ),
          const _SettingsDivider(),
          _NotificationToggleRow(
            title: '약 미복용 알림',
            value: missedMed,
            onChanged: onMissedMedChanged,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          const _SettingsDivider(),
          _NotificationToggleRow(
            title: '걸음 수 현저히 감소',
            value: stepDrop,
            onChanged: onStepDropChanged,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          const _SettingsDivider(),
          _NotificationToggleRow(
            title: '건강 점수 하락',
            value: healthDrop,
            onChanged: onHealthDropChanged,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          const _SettingsDivider(),
          _NotificationToggleRow(
            title: '일일 건강 요약 알림',
            value: dailySummary,
            onChanged: onDailySummaryChanged,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          const _SettingsDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '알림 시간',
                        style: TextStyle(
                          fontSize: 14,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.75,
                          color: AppColors.textDark,
                        ),
                      ),
                      Text(
                        '매일 오후 9:00',
                        style: TextStyle(
                          fontSize: 12,
                          height: 16 / 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.46,
                          color: AppColors.tabInactive,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(8),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '편집',
                        style: TextStyle(
                          fontSize: 11.25,
                          height: 16 / 11.25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.edit_outlined,
                        size: 10,
                        color: AppColors.primary500,
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

class _NotificationToggleRow extends StatelessWidget {
  const _NotificationToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.subtitleColor,
    this.showAlertDot = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final bool showAlertDot;
  final bool value;
  final ValueChanged<bool> onChanged;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
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
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.59,
                        color: AppColors.textDark,
                      ),
                    ),
                    if (showAlertDot) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.dangerRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.55,
                      color: subtitleColor ?? AppColors.tabInactive,
                    ),
                  ),
              ],
            ),
          ),
          _SettingsSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  const _SettingsSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 24,
        padding: EdgeInsets.fromLTRB(value ? 20 : 2, 2, value ? 2 : 20, 2),
        decoration: BoxDecoration(
          color: value ? AppColors.primary500 : AppColors.borderDefault,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 1),
                color: Color(0x0D000000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrivacySection extends StatelessWidget {
  const _PrivacySection();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: _SectionTitle('내 정보 공개 범위'),
          ),
          const _PrivacyRow(
            icon: Icons.directions_walk_rounded,
            label: '걸음 수',
            badge: '가족 전체',
            isShared: true,
          ),
          const _SettingsDivider(),
          const _PrivacyRow(
            icon: Icons.medication_liquid_rounded,
            label: '약 복용',
            badge: '가족 전체',
            isShared: true,
          ),
          const _SettingsDivider(),
          const _PrivacyRow(
            icon: Icons.sentiment_satisfied_alt_rounded,
            label: '기분',
            badge: '가족 전체',
            isShared: true,
          ),
          const _SettingsDivider(),
          const _PrivacyRow(
            icon: Icons.favorite_rounded,
            label: '건강 점수',
            badge: '나만 보기',
            isShared: false,
          ),
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
    required this.isShared,
  });

  final IconData icon;
  final String label;
  final String badge;
  final bool isShared;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isShared
                    ? AppColors.primary500.withValues(alpha: 0.1)
                    : AppColors.progressTrack,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 14,
                color: isShared ? AppColors.primary500 : AppColors.tabInactive,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.71,
                  color: AppColors.textDark,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isShared
                    ? AppColors.primary500.withValues(alpha: 0.1)
                    : AppColors.progressTrack,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isShared ? Icons.group_rounded : Icons.lock_outline_rounded,
                    size: 10,
                    color: isShared
                        ? AppColors.primary500
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    badge,
                    style: TextStyle(
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.49,
                      color: isShared
                          ? AppColors.primary500
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 12, color: Color(0xFFD1D5DB)),
          ],
        ),
      ),
    );
  }
}

class _PremiumSection extends StatelessWidget {
  const _PremiumSection();

  static const _gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF6D365), Color(0xFFFDA085), Color(0xFFF6A623)],
    stops: [0.0, 0.5, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 10),
            color: Color(0x3300C4A1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('👑', style: TextStyle(fontSize: 20, height: 28 / 20)),
              SizedBox(width: 8),
              Text(
                '가족안심 프리미엄',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.78,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '현재: 무료 플랜 (기본 기능)',
              style: TextStyle(
                fontSize: 12,
                height: 16 / 12,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.46,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const _PremiumFeature('가족 구성원 무제한 추가'),
          const SizedBox(height: 8),
          const _PremiumFeature('AI 건강 분석 및 리포트'),
          const SizedBox(height: 8),
          const _PremiumFeature('응급 SOS 자동 감지 & 신고'),
          const SizedBox(height: 16),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFF6A623), Color(0xFFFDA085)],
                  ).createShader(bounds),
                  child: const Text(
                    '프리미엄 시작하기 · 월 4,900원',
                    style: TextStyle(
                      fontSize: 14,
                      height: 20 / 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.42,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumFeature extends StatelessWidget {
  const _PremiumFeature(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 10, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            height: 16 / 12,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.53,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _AppInfoSection extends StatelessWidget {
  const _AppInfoSection();

  @override
  Widget build(BuildContext context) {
    return _SettingsCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const _AppInfoRow(
            label: '앱 버전',
            trailing: '1.0.0',
            showChevron: false,
          ),
          const _SettingsDivider(),
          const _AppInfoRow(label: '이용약관'),
          const _SettingsDivider(),
          const _AppInfoRow(label: '개인정보처리방침'),
          const _SettingsDivider(),
          const _AppInfoRow(
            label: '로그아웃',
            isDanger: true,
            trailingIcon: Icons.logout_rounded,
          ),
        ],
      ),
    );
  }
}

class _AppInfoRow extends StatelessWidget {
  const _AppInfoRow({
    required this.label,
    this.trailing,
    this.showChevron = true,
    this.isDanger = false,
    this.trailingIcon,
  });

  final String label;
  final String? trailing;
  final bool showChevron;
  final bool isDanger;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: isDanger ? -0.85 : -0.71,
                  color: isDanger
                      ? AppColors.dangerRedLight
                      : AppColors.textDark,
                ),
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.23,
                  color: AppColors.tabInactive,
                ),
              ),
            if (showChevron && !isDanger)
              const Icon(
                Icons.chevron_right,
                size: 14,
                color: Color(0xFFD1D5DB),
              ),
            if (trailingIcon != null)
              Icon(trailingIcon, size: 14, color: const Color(0xFFFCA5A5)),
          ],
        ),
      ),
    );
  }
}
