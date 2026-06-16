import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_pill_button.dart';

class OnboardingInvitationPage extends StatelessWidget {
  const OnboardingInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.illustrationPeach,
                  borderRadius: BorderRadius.circular(AppRadius.large),
                ),
                child: const Icon(
                  Icons.family_restroom_rounded,
                  size: 120,
                  color: AppColors.primary500,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('가족 초대하기', style: AppTextStyles.heading),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '함께할 가족을 초대하여 안심을 시작하세요',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: AppSpacing.xl),
              _InviteButton(
                backgroundColor: AppColors.kakaoYellow,
                foregroundColor: AppColors.black,
                icon: Icons.chat_bubble_rounded,
                label: '카카오톡으로 초대 링크 보내기',
              ),
              const SizedBox(height: AppSpacing.sm),
              _InviteButton(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.textPrimary,
                icon: Icons.copy_rounded,
                label: '초대 코드 복사하기',
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.textDisabled)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                    child: Text('또는', style: AppTextStyles.caption),
                  ),
                  const Expanded(child: Divider(color: AppColors.textDisabled)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppPillButton(
                variant: AppPillButtonVariant.primary,
                label: '가족과 함께 시작하기 →',
                onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
                child: Text(
                  '나중에 할게요',
                  style: AppTextStyles.caption.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
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
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
        ),
        icon: Icon(icon),
        label: Text(label, style: AppTextStyles.body),
      ),
    );
  }
}
