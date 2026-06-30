import 'package:flutter/material.dart';

import '../../../../../core/components/health_score_card.dart';
import '../../../../../core/components/medication_list_item.dart';
import '../../../../../core/components/page_header.dart';
import '../../../../../core/charts/simple_bar_chart.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_bottom_navigation_bar.dart';
import '../../../../../core/widgets/app_shell.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      selectedTab: AppTab.home,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 96),
          children: const [
            const ScreenTitle('가족안심'),
            SizedBox(height: 24),
            HealthScoreCard(
              title: '오늘 내 건강 점수',
              score: 87,
              percent: 0.87,
              moodLabel: '좋음 😊',
              metrics: [
                HealthScoreCardMetric(
                  label: '안심체크 ✓',
                  icon: Icons.verified_rounded,
                ),
                HealthScoreCardMetric(
                  label: '걸음수 ✓',
                  icon: Icons.directions_walk_rounded,
                ),
                HealthScoreCardMetric(
                  label: '약복용 ✓',
                  icon: Icons.medication_rounded,
                ),
              ],
            ),
            SizedBox(height: 24),
            _SafetyCheckSection(),
            SizedBox(height: 24),
            _FamilyHealthSection(),
            SizedBox(height: 24),
            _MedicationSection(),
            SizedBox(height: 24),
            _MoodSection(),
            SizedBox(height: 24),
            _StepsSection(),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({required this.child});

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
            blurRadius: 16,
            offset: Offset(0, 2),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    this.trailing,
  });

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    if (trailing != null) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                height: 26 / 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          trailing!,
        ],
      );
    }

    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        height: 26 / 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _SafetyCheckSection extends StatelessWidget {
  const _SafetyCheckSection();

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SectionTitle(title: '오늘 안심 체크'),
          const SizedBox(height: 16),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(0, 10),
                  color: Color(0x4D22C55E),
                ),
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0, 4),
                  color: Color(0x4D22C55E),
                ),
              ],
            ),
            child: Material(
              color: AppColors.primary500,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(24),
                child: const SizedBox(
                  height: 72,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up_alt_rounded, color: Colors.white, size: 21),
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
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 13, color: AppColors.success),
              const SizedBox(width: 4),
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

class _FamilyHealthSection extends StatelessWidget {
  const _FamilyHealthSection();

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SectionTitle(
            title: '오늘 가족 건강 현황',
            trailing: TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/family'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '전체보기',
                    style: TextStyle(
                      fontSize: 14,
                      height: 21 / 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const _FamilyMemberRow(
            name: '어머니 (김순자, 68세)',
            tags: [
              _FamilyTag('안심 완료', _FamilyTagStyle.success),
              _FamilyTag('👟 4,523보', _FamilyTagStyle.info),
              _FamilyTag('💊 혈압약 ✓', _FamilyTagStyle.success),
              _FamilyTag('😊 기분 좋음', _FamilyTagStyle.neutral),
            ],
          ),
          Divider(height: 32, color: AppColors.borderDefault),
          const _FamilyMemberRow(
            name: '아버지 (김철수, 71세)',
            tags: [
              _FamilyTag('⚠️ 안심 대기', _FamilyTagStyle.neutral),
              _FamilyTag('👟 2,103보', _FamilyTagStyle.neutral),
              _FamilyTag('💊 혈압약 미복용', _FamilyTagStyle.neutral),
              _FamilyTag('😐 기분 보통', _FamilyTagStyle.neutral),
            ],
          ),
          Divider(height: 32, color: AppColors.borderDefault),
          const _FamilyMemberRow(
            name: '아들 (김민준, 35세)',
            tags: [
              _FamilyTag('안심 완료', _FamilyTagStyle.success),
              _FamilyTag('👟 8,112보', _FamilyTagStyle.success),
              _FamilyTag('😊 기분 좋음', _FamilyTagStyle.neutral),
            ],
          ),
          Divider(height: 32, color: AppColors.borderDefault),
          const _FamilyMemberRow(
            name: '딸 (김지영, 32세)',
            tags: [
              _FamilyTag('안심 완료', _FamilyTagStyle.success),
              _FamilyTag('👟 5,983보', _FamilyTagStyle.info),
              _FamilyTag('💊 비타민 ✓', _FamilyTagStyle.success),
              _FamilyTag('😊 기분 좋음', _FamilyTagStyle.neutral),
            ],
          ),
        ],
      ),
    );
  }
}

enum _FamilyTagStyle { success, info, neutral }

class _FamilyTag {
  const _FamilyTag(this.label, this.style);

  final String label;
  final _FamilyTagStyle style;
}

class _FamilyMemberRow extends StatelessWidget {
  const _FamilyMemberRow({
    required this.name,
    required this.tags,
  });

  final String name;
  final List<_FamilyTag> tags;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.successAvatarBg,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surface, width: 2),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 1),
                color: Color(0x0D000000),
              ),
            ],
          ),
          child: const Icon(Icons.person_rounded, size: 18, color: AppColors.success),
        ),
        const SizedBox(width: 16),
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
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) => _FamilyTagChip(tag: tag)).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FamilyTagChip extends StatelessWidget {
  const _FamilyTagChip({required this.tag});

  final _FamilyTag tag;

  @override
  Widget build(BuildContext context) {
    final (bg, border, textColor) = switch (tag.style) {
      _FamilyTagStyle.success => (
          AppColors.successBg,
          AppColors.successBorder,
          AppColors.success,
        ),
      _FamilyTagStyle.info => (
          AppColors.infoBg,
          AppColors.infoBorder,
          AppColors.textSecondary,
        ),
      _FamilyTagStyle.neutral => (
          AppColors.progressTrack,
          AppColors.borderDefault,
          AppColors.textSecondary,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        tag.label,
        style: TextStyle(
          fontSize: 13,
          height: 20 / 13,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class _MedicationSection extends StatelessWidget {
  const _MedicationSection();

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
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

class _MoodSection extends StatelessWidget {
  const _MoodSection();

  static const _moods = ['😢', '😟', '😐', '😊', '😄'];

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
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
              final isSelected = index == 3;
              return Opacity(
                opacity: isSelected ? 1 : 0.5,
                child: Text(
                  _moods[index],
                  style: TextStyle(
                    fontSize: isSelected ? 39.6 : 27,
                    height: isSelected ? 44 / 39.6 : 32 / 27,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _StepsSection extends StatelessWidget {
  const _StepsSection();

  @override
  Widget build(BuildContext context) {
    return _HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 걸음 수',
            style: TextStyle(
              fontSize: 16,
              height: 24 / 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.66,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '6,248',
                style: TextStyle(
                  fontSize: 36,
                  height: 40 / 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.8,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '보',
                style: TextStyle(
                  fontSize: 18,
                  height: 28 / 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.tabInactive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '오늘 목표까지 3,752보 남았어요',
            style: TextStyle(
              fontSize: 13.234,
              height: 20 / 13.234,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.6248,
              minHeight: 12,
              backgroundColor: AppColors.progressTrack,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary500),
            ),
          ),
          const SizedBox(height: 16),
          const SimpleBarChart(
            values: [0.4, 0.55, 0.45, 0.5, 0.62, 0.35, 0.35],
            labels: ['월', '화', '수', '목', '금', '토', '일'],
            highlightIndex: 4,
            height: 96,
          ),
        ],
      ),
    );
  }
}
