import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class OnboardingInvitationPage extends StatelessWidget {
  const OnboardingInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.onboardingGradientTop,
              AppColors.onboardingGradientMid,
              AppColors.background,
            ],
            stops: [0.0, 0.4, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(32, 48, 32, 0),
                  child: Column(
                    children: const [
                      _FamilyIllustration(),
                      SizedBox(height: 40),
                      _OnboardingHeadline(),
                      SizedBox(height: 32),
                      _PageIndicators(),
                      SizedBox(height: 32),
                      _FeatureHighlights(),
                    ],
                  ),
                ),
              ),
              const _InvitationBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FamilyIllustration extends StatelessWidget {
  const _FamilyIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.onboardingIllustrationGlow.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFE8D6).withValues(alpha: 0.8),
                  const Color(0xFFE6F9F5).withValues(alpha: 0.9),
                  const Color(0xFFD6F0FF).withValues(alpha: 0.7),
                ],
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('👨‍👩‍👧‍👦', style: TextStyle(fontSize: 72, height: 1)),
                SizedBox(height: 12),
                Text(
                  '함께하는 가족',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onboardingTextMuted,
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

class _OnboardingHeadline extends StatelessWidget {
  const _OnboardingHeadline();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '사랑하는 가족의 오늘을\n가장 간단하게 확인하는 방법',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            height: 33 / 24,
            fontWeight: FontWeight.w800,
            color: AppColors.onboardingTextDark,
          ),
        ),
        SizedBox(height: 16),
        Text(
          '매일 아침 부모님의 건강을 확인하고,\n멀리 있어도 곁에 있는 것처럼 안부를 전하세요.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 26 / 16,
            fontWeight: FontWeight.w400,
            color: AppColors.onboardingTextMuted,
          ),
        ),
      ],
    );
  }
}

class _PageIndicators extends StatelessWidget {
  const _PageIndicators();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 24,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.onboardingAccent,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
        const SizedBox(width: 8),
        _dot(),
        const SizedBox(width: 8),
        _dot(),
      ],
    );
  }

  Widget _dot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: AppColors.onboardingDotInactive,
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}

class _FeatureHighlights extends StatelessWidget {
  const _FeatureHighlights();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FeatureItem(
          icon: Icons.favorite_rounded,
          label: '실시간 건강',
          backgroundColor: AppColors.infoBg,
          iconColor: AppColors.featureBlue,
        ),
        _FeatureItem(
          icon: Icons.chat_bubble_rounded,
          label: '따뜻한 안부',
          backgroundColor: AppColors.featureOrangeBg,
          iconColor: AppColors.featureOrange,
        ),
        _FeatureItem(
          icon: Icons.emergency_rounded,
          label: '응급 대응',
          backgroundColor: AppColors.featureRedBg,
          iconColor: AppColors.featureRed,
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            height: 16 / 11,
            fontWeight: FontWeight.w700,
            color: AppColors.onboardingTextMuted,
          ),
        ),
      ],
    );
  }
}

class _InvitationBottomSheet extends StatelessWidget {
  const _InvitationBottomSheet();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.onboardingGradientMid,
            AppColors.background,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        border: Border(top: BorderSide(color: AppColors.sheetBorderTop)),
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            offset: Offset(0, -15),
            color: Color(0x1A000000),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Column(
              children: [
                Text(
                  '가족 초대하기',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    height: 28 / 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onboardingTextDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '함께할 가족을 초대하여 안심을 시작하세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 20 / 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onboardingTextMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _InviteButton(
              backgroundColor: AppColors.kakaoYellow,
              foregroundColor: AppColors.kakaoText,
              border: null,
              icon: Icons.chat_bubble_rounded,
              label: '카카오톡으로 초대 링크 보내기',
              height: 56,
            ),
            const SizedBox(height: 12),
            _InviteButton(
              backgroundColor: AppColors.surfaceMuted,
              foregroundColor: AppColors.onboardingTextDark,
              border: const BorderSide(color: AppColors.borderLight),
              icon: Icons.copy_rounded,
              label: '초대 코드 복사하기',
              height: 56,
            ),
            const SizedBox(height: 8),
            const _OrDivider(),
            const SizedBox(height: 8),
            _PrimaryCtaButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                minimumSize: const Size(double.infinity, 36),
              ),
              child: const Text(
                '나중에 할게요',
                style: TextStyle(
                  fontSize: 14,
                  height: 20 / 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.tabInactive,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InviteButton extends StatelessWidget {
  const _InviteButton({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.label,
    required this.height,
    this.border,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String label;
  final double height;
  final BorderSide? border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: border ?? BorderSide.none,
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: border == null ? 20 : 18, color: foregroundColor),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  height: 24 / 16,
                  fontWeight: FontWeight.w700,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.tabInactive, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '또는',
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w500,
              color: AppColors.tabInactive,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.tabInactive, height: 1)),
      ],
    );
  }
}

class _PrimaryCtaButton extends StatelessWidget {
  const _PrimaryCtaButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 10),
            color: Color(0x6600C8B0),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: Material(
          color: AppColors.onboardingAccent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '가족과 함께 시작하기',
                  style: TextStyle(
                    fontSize: 18,
                    height: 28 / 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
