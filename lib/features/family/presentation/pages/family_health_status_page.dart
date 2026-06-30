import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/components/page_header.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_shell.dart';

enum _FamilyGroup { ourFamily, couple, friends }

class FamilyHealthStatusPage extends StatefulWidget {
  const FamilyHealthStatusPage({super.key});

  @override
  State<FamilyHealthStatusPage> createState() => _FamilyHealthStatusPageState();
}

class _FamilyHealthStatusPageState extends State<FamilyHealthStatusPage> {
  _FamilyGroup _group = _FamilyGroup.ourFamily;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.family,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _FamilyPageHeader(
                group: _group,
                onGroupChanged: (value) => setState(() => _group = value),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 128),
                  children: [
                    if (_group == _FamilyGroup.ourFamily) ...const [
                      _FamilySummaryCard(),
                      SizedBox(height: 16),
                      _FamilyMembersSectionHeader(),
                      SizedBox(height: 16),
                      _FamilyMemberCard(
                        relation: '어머니',
                        fullName: '김순자 · 68세',
                        statusLabel: '안심 완료',
                        statusType: _MemberStatusType.completed,
                        lastUpdated: '마지막 업데이트 · 오늘 13:24',
                        metrics: [
                          _MemberMetric(
                            emoji: '👟',
                            value: '4,523보',
                            label: '걸음수',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '혈압약 ✓',
                            label: '약 복용',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '120/80',
                            label: '혈압 (정상)',
                            style: _MetricStyle.neutral,
                          ),
                          _MemberMetric(
                            emoji: '😊',
                            value: '기분 좋음',
                            label: '기분 상태',
                            style: _MetricStyle.mood,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _FamilyMemberCard(
                        relation: '아버지',
                        fullName: '김철수 · 71세',
                        statusLabel: '안심 대기',
                        statusType: _MemberStatusType.waiting,
                        alertMessage: '아직 오늘 안심 체크를 하지 않았어요',
                        lastUpdated: '마지막 업데이트 · 오늘 09:12',
                        isHighlighted: true,
                        metrics: [
                          _MemberMetric(
                            emoji: '👟',
                            value: '2,103보',
                            label: '걸음수',
                            style: _MetricStyle.muted,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '혈압약 미복용',
                            label: '약 복용',
                            style: _MetricStyle.danger,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '120/80',
                            label: '혈압 (정상)',
                            style: _MetricStyle.neutral,
                          ),
                          _MemberMetric(
                            emoji: '😐',
                            value: '기분 보통',
                            label: '기분 상태',
                            style: _MetricStyle.neutral,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _FamilyMemberCard(
                        relation: '아들',
                        fullName: '김민준 · 35세',
                        statusLabel: '안심 완료',
                        statusType: _MemberStatusType.completed,
                        lastUpdated: '마지막 업데이트 · 오늘 11:58',
                        metrics: [
                          _MemberMetric(
                            emoji: '👟',
                            value: '8,112보',
                            label: '걸음수',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '비타민 ✓',
                            label: '약 복용',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '🩺',
                            value: '정상',
                            label: '건강 상태',
                            style: _MetricStyle.neutralDark,
                          ),
                          _MemberMetric(
                            emoji: '😊',
                            value: '기분 좋음',
                            label: '기분 상태',
                            style: _MetricStyle.mood,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _FamilyMemberCard(
                        relation: '딸',
                        fullName: '김지영 · 32세',
                        statusLabel: '안심 완료',
                        statusType: _MemberStatusType.completed,
                        lastUpdated: '마지막 업데이트 · 오늘 10:33',
                        metrics: [
                          _MemberMetric(
                            emoji: '👟',
                            value: '5,983보',
                            label: '걸음수',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '💊',
                            value: '비타민C ✓',
                            label: '약 복용',
                            style: _MetricStyle.success,
                          ),
                          _MemberMetric(
                            emoji: '🩺',
                            value: '정상',
                            label: '건강 상태',
                            style: _MetricStyle.neutralDark,
                          ),
                          _MemberMetric(
                            emoji: '😊',
                            value: '기분 좋음',
                            label: '기분 상태',
                            style: _MetricStyle.mood,
                          ),
                        ],
                      ),
                    ] else
                      const _EmptyGroupPlaceholder(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 8,
            child: _InviteFamilyButton(
              onPressed: () => Navigator.of(context).pushNamed('/onboarding'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyPageHeader extends StatelessWidget {
  const _FamilyPageHeader({
    required this.group,
    required this.onGroupChanged,
  });

  final _FamilyGroup group;
  final ValueChanged<_FamilyGroup> onGroupChanged;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.background.withValues(alpha: 0.95),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: ScreenTitle('약 복용 관리'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _GroupTab(
                      label: '우리 가족',
                      isSelected: group == _FamilyGroup.ourFamily,
                      onTap: () => onGroupChanged(_FamilyGroup.ourFamily),
                    ),
                    const SizedBox(width: 16),
                    _GroupTab(
                      label: '나와 아내',
                      isSelected: group == _FamilyGroup.couple,
                      onTap: () => onGroupChanged(_FamilyGroup.couple),
                    ),
                    const SizedBox(width: 16),
                    _GroupTab(
                      label: '친구들',
                      isSelected: group == _FamilyGroup.friends,
                      onTap: () => onGroupChanged(_FamilyGroup.friends),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTab extends StatelessWidget {
  const _GroupTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                height: 22 / 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.success : AppColors.tabInactive,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.success : Colors.transparent,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyGroupPlaceholder extends StatelessWidget {
  const _EmptyGroupPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          '표시할 구성원이 없습니다',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.tabInactive,
          ),
        ),
      ),
    );
  }
}

class _FamilySummaryCard extends StatelessWidget {
  const _FamilySummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment(-0.62, 1.0),
          end: Alignment(0.62, -0.79),
          colors: [
            AppColors.primary500,
            AppColors.primary600,
            AppColors.primary700,
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 4),
            color: Color(0x4000C4A1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘 현황',
                      style: TextStyle(
                        fontSize: 13,
                        height: 20 / 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '가족 4명 중 3명 안심 완료',
                      style: TextStyle(
                        fontSize: 18,
                        height: 22 / 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '75%',
                      style: TextStyle(
                        fontSize: 20,
                        height: 1,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '완료율',
                      style: TextStyle(
                        fontSize: 10,
                        height: 15 / 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 10,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '1명 아직 안심 체크를 하지 않았어요',
            style: TextStyle(
              fontSize: 11,
              height: 16 / 11,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _SummaryStatChip(
                  icon: Icons.verified_rounded,
                  text: '안심\n3/4',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _SummaryStatChip(
                  icon: Icons.directions_walk_rounded,
                  text: '걸음 평균\n5,180보',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _SummaryStatChip(
                  icon: Icons.medication_rounded,
                  text: '약\n2/3',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryStatChip extends StatelessWidget {
  const _SummaryStatChip({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                height: 18 / 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyMembersSectionHeader extends StatelessWidget {
  const _FamilyMembersSectionHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '가족 구성원',
            style: TextStyle(
              fontSize: 15,
              height: 22 / 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0078125,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            '4명',
            style: TextStyle(
              fontSize: 12,
              height: 18 / 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.0927734,
              color: AppColors.tabInactive,
            ),
          ),
        ],
      ),
    );
  }
}

enum _MemberStatusType { completed, waiting }

enum _MetricStyle { success, neutral, neutralDark, mood, danger, muted }

class _MemberMetric {
  const _MemberMetric({
    required this.emoji,
    required this.value,
    required this.label,
    required this.style,
  });

  final String emoji;
  final String value;
  final String label;
  final _MetricStyle style;
}

class _FamilyMemberCard extends StatelessWidget {
  const _FamilyMemberCard({
    required this.relation,
    required this.fullName,
    required this.statusLabel,
    required this.statusType,
    required this.lastUpdated,
    required this.metrics,
    this.alertMessage,
    this.isHighlighted = false,
  });

  final String relation;
  final String fullName;
  final String statusLabel;
  final _MemberStatusType statusType;
  final String lastUpdated;
  final List<_MemberMetric> metrics;
  final String? alertMessage;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final isWaiting = statusType == _MemberStatusType.waiting;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: isHighlighted
            ? const Border.fromBorderSide(
                BorderSide(color: AppColors.alertOrangeBorder),
              )
            : null,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 2),
            color: isHighlighted
                ? const Color(0x1FF97316)
                : const Color(0x12000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relation,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 19 / 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.0195312,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      fullName,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 18 / 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.00878906,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(label: statusLabel, isWaiting: isWaiting),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/family/member'),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        '상세',
                        style: TextStyle(
                          fontSize: 12,
                          height: 18 / 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.0761719,
                          color: AppColors.tabInactive,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 12,
                      color: AppColors.tabInactive,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (alertMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.alertOrangeBg,
                border: Border.all(color: AppColors.alertOrangeBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 13,
                    color: AppColors.featureOrange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alertMessage!,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 18 / 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.00292969,
                        color: AppColors.featureOrange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final tileWidth = (constraints.maxWidth - 8) / 2;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: metrics
                    .map(
                      (metric) => SizedBox(
                        width: tileWidth,
                        child: _MetricTile(metric: metric),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            lastUpdated,
            style: const TextStyle(
              fontSize: 11,
              height: 16 / 11,
              fontWeight: FontWeight.w500,
              color: AppColors.tabInactive,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.label,
    required this.isWaiting,
  });

  final String label;
  final bool isWaiting;

  @override
  Widget build(BuildContext context) {
    if (isWaiting) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.warningYellowBg,
          border: Border.all(color: AppColors.warningYellowBorder),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('⚠️', style: TextStyle(fontSize: 12, height: 1)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                height: 18 / 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.0234375,
                color: AppColors.warningAmber,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.successBg,
        border: Border.all(color: AppColors.successBorder),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, size: 13, color: AppColors.success),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              height: 18 / 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.0234375,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.metric});

  final _MemberMetric metric;

  @override
  Widget build(BuildContext context) {
    final (bg, border, valueColor) = switch (metric.style) {
      _MetricStyle.success => (
          AppColors.successBg,
          AppColors.successBorder,
          AppColors.success,
        ),
      _MetricStyle.neutral => (
          AppColors.background,
          AppColors.borderDefault,
          AppColors.textSecondary,
        ),
      _MetricStyle.muted => (
          AppColors.progressTrack,
          AppColors.borderDefault,
          AppColors.textSecondary,
        ),
      _MetricStyle.neutralDark => (
          AppColors.background,
          AppColors.borderDefault,
          AppColors.textPrimary,
        ),
      _MetricStyle.mood => (
          AppColors.warningYellowBg,
          AppColors.warningYellowBorder,
          AppColors.warningAmber,
        ),
      _MetricStyle.danger => (
          AppColors.featureRedBg,
          AppColors.featureRedBorder,
          AppColors.dangerRed,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(metric.emoji, style: const TextStyle(fontSize: 16, height: 1)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.value,
                  style: TextStyle(
                    fontSize: 13,
                    height: 16 / 13,
                    fontWeight: FontWeight.w700,
                    color: valueColor,
                  ),
                ),
                Text(
                  metric.label,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 15 / 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.tabInactive,
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

class _InviteFamilyButton extends StatelessWidget {
  const _InviteFamilyButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 4),
            color: Color(0x5900C4A1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary500, AppColors.primary600],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.group_add_rounded, size: 20, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  '가족 초대하기 +',
                  style: TextStyle(
                    fontSize: 16,
                    height: 24 / 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
