import 'package:flutter/material.dart';

import '../../../../../app/tab_routes.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/components/medication_list_item.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_shell.dart';

class MyMedicationsPage extends StatefulWidget {
  const MyMedicationsPage({super.key});

  @override
  State<MyMedicationsPage> createState() => _MyMedicationsPageState();
}

class _MyMedicationsPageState extends State<MyMedicationsPage> {
  String _segment = 'mine';

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.meds,
      onSelectedTab: (tab) {
        Navigator.of(context).pushReplacementNamed(TabRoutes.routeForTab(tab));
      },
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
        children: [
          const _MedPageHeader(),
          const SizedBox(height: 16),
          _MedSegmentControl(
            selected: _segment,
            onSelected: (value) => setState(() => _segment = value),
          ),
          const SizedBox(height: 16),
          if (_segment == 'mine') ..._buildMyMedications() else ..._buildFamilyOverview(),
        ],
      ),
    );
  }

  List<Widget> _buildMyMedications() {
    return const [
      _TodayMedicationSection(),
      SizedBox(height: 16),
      _StreakSection(),
      SizedBox(height: 16),
      _RegisteredMedicationSection(),
      SizedBox(height: 16),
      _ReminderSettingsSection(),
    ];
  }

  List<Widget> _buildFamilyOverview() {
    return const [
      _FamilyOverviewBanner(),
      SizedBox(height: 16),
      _FamilyMedicationCard(
        name: '어머니',
        subtitle: '2가지 약 등록',
        badge: '모두 완료',
        isSuccess: true,
      ),
      SizedBox(height: 12),
      _FamilyMedicationCard(
        name: '아버지',
        subtitle: '1가지 약 등록',
        badge: '미복용 있음',
        isSuccess: false,
      ),
      SizedBox(height: 12),
      _FamilyMedicationCard(
        name: '아들',
        subtitle: '약 없음',
        badge: '미등록',
        isNeutral: true,
      ),
    ];
  }
}

class _MedPageHeader extends StatelessWidget {
  const _MedPageHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '약 복용 관리',
      style: TextStyle(
        fontSize: 18,
        height: 28 / 18,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.textDark,
      ),
    );
  }
}

class _MedCard extends StatelessWidget {
  const _MedCard({required this.child});

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

class _MedSegmentControl extends StatelessWidget {
  const _MedSegmentControl({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.progressTrack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          _tab('mine', '내 복용'),
          _tab('family', '가족 현황'),
        ],
      ),
    );
  }

  Widget _tab(String value, String label) {
    final isSelected = selected == value;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onSelected(value),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            height: 41,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary500 : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? const [
                      BoxShadow(
                        blurRadius: 12,
                        offset: Offset(0, 4),
                        color: Color(0x4000C4A1),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  height: 21 / 14,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppColors.tabInactive,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TodayMedicationSection extends StatelessWidget {
  const _TodayMedicationSection();

  @override
  Widget build(BuildContext context) {
    return _MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '오늘 약 복용',
            style: TextStyle(
              fontSize: 15.375,
              height: 24 / 15.375,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          MedicationListItem(
            name: '혈압약',
            timeText: '복용완료 (오전 8:00)',
            statusType: MedicationStatusType.completed,
          ),
          MedicationListItem(
            name: '당뇨약',
            timeText: '오후 1:00 예정',
            statusType: MedicationStatusType.scheduled,
          ),
          MedicationListItem(
            name: '비타민C',
            timeText: '복용완료',
            statusType: MedicationStatusType.completed,
          ),
        ],
      ),
    );
  }
}

class _StreakSection extends StatelessWidget {
  const _StreakSection();

  static const _weeklyValues = [0.6, 0.85, 0.7, 0.78, 0.65, 0.82, 0.95];

  @override
  Widget build(BuildContext context) {
    return _MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '복용 연속 12일째! 🎉',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.36,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '꾸준히 잘 복용하고 있어요',
                style: TextStyle(
                  fontSize: 12,
                  height: 18 / 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.tabInactive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이달 복용률',
                style: TextStyle(
                  fontSize: 14,
                  height: 21 / 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                '94%',
                style: TextStyle(
                  fontSize: 14,
                  height: 21 / 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.94,
              minHeight: 10,
              backgroundColor: AppColors.progressTrack,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 90,
            child: SimpleBarChart(
              values: _weeklyValues,
              labels: const ['월', '화', '수', '목', '금', '토', '일'],
              highlightIndex: 6,
              height: 90,
              activeColor: AppColors.primary600,
              inactiveColor: Color(0x9900C4A1),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisteredMedicationSection extends StatelessWidget {
  const _RegisteredMedicationSection();

  @override
  Widget build(BuildContext context) {
    return _MedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '내 약 목록',
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMintBg,
                      border: Border.all(
                        color: AppColors.primary500.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 10, color: AppColors.primary500),
                        SizedBox(width: 5),
                        Text(
                          '약 추가하기',
                          style: TextStyle(
                            fontSize: 12,
                            height: 18 / 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _RegisteredMedRow(
            name: '혈압약',
            schedule: '아침 복용 · 오전 8:00',
          ),
          const SizedBox(height: 12),
          const _RegisteredMedRow(
            name: '당뇨약',
            schedule: '점심 복용 · 오후 1:00',
          ),
          const SizedBox(height: 12),
          const _RegisteredMedRow(
            name: '수면영양제',
            schedule: '저녁 복용 · 오후 7:00',
          ),
        ],
      ),
    );
  }
}

class _RegisteredMedRow extends StatelessWidget {
  const _RegisteredMedRow({
    required this.name,
    required this.schedule,
  });

  final String name;
  final String schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryMintBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.medication_liquid_rounded,
              size: 18,
              color: AppColors.primary500,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 21 / 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  schedule,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 16 / 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.tabInactive,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.borderLight),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.edit_outlined, size: 12, color: AppColors.tabInactive),
          ),
        ],
      ),
    );
  }
}

class _ReminderSettingsSection extends StatefulWidget {
  const _ReminderSettingsSection();

  @override
  State<_ReminderSettingsSection> createState() => _ReminderSettingsSectionState();
}

class _ReminderSettingsSectionState extends State<_ReminderSettingsSection> {
  bool _reminderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return _MedCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primaryMintBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.notifications_active_rounded, size: 15, color: AppColors.primary500),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '복용 알림 설정',
                    style: TextStyle(
                      fontSize: 14,
                      height: 21 / 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                _MedSwitch(
                  value: _reminderEnabled,
                  onChanged: (value) => setState(() => _reminderEnabled = value),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primaryMintBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.schedule_rounded, size: 15, color: AppColors.primary500),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '알림 시간 설정',
                          style: TextStyle(
                            fontSize: 14,
                            height: 21 / 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          '복용 30분 전 알림',
                          style: TextStyle(
                            fontSize: 11,
                            height: 16 / 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.tabInactive,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 14, color: AppColors.tabInactive),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedSwitch extends StatelessWidget {
  const _MedSwitch({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: value ? AppColors.primary500 : AppColors.progressTrack,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 2),
                color: Color(0x26000000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FamilyOverviewBanner extends StatelessWidget {
  const _FamilyOverviewBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.alertBannerBg,
        border: Border.all(color: AppColors.alertBannerBorder),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, size: 16, color: AppColors.warningAmber),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '오늘 복용 현황 3명 완료 · 1명 미복용',
              style: TextStyle(
                fontSize: 14,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyMedicationCard extends StatelessWidget {
  const _FamilyMedicationCard({
    required this.name,
    required this.subtitle,
    required this.badge,
    this.isSuccess = false,
    this.isNeutral = false,
  });

  final String name;
  final String subtitle;
  final String badge;
  final bool isSuccess;
  final bool isNeutral;

  @override
  Widget build(BuildContext context) {
    final badgeColor = isSuccess
        ? AppColors.success
        : isNeutral
            ? AppColors.tabInactive
            : AppColors.dangerRed;
    final badgeBg = isSuccess
        ? AppColors.successBg
        : isNeutral
            ? AppColors.progressTrack
            : AppColors.featureRedBg;

    return _MedCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 18 / 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeBg,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: 12,
                height: 18 / 12,
                fontWeight: FontWeight.w700,
                color: badgeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
