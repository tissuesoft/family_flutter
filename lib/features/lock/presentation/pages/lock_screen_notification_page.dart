import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LockScreenNotificationPage extends StatelessWidget {
  const LockScreenNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lockScreenTop, AppColors.lockScreenBottom],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),
                Text('오후 1:00', style: AppTextStyles.display.copyWith(color: AppColors.white)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '2025년 1월 27일 월요일',
                  style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.8)),
                ),
                const Spacer(),
                _GlassNotificationCard(
                  appName: '가족안심',
                  timeLabel: '5분 전',
                  title: '아버지(김철수) — 혈압약 미복용 알림',
                  message: '오후 12:00 복용 예정이었습니다. 아직 복용 확인이 되지 않았어요.',
                ),
                const SizedBox(height: AppSpacing.md),
                _GlassNotificationCard(
                  appName: '가족안심',
                  timeLabel: '방금 전',
                  title: '약 복용 시간이에요!',
                  message: '당뇨약 복용 예정 시간입니다. 지금 복용해 주세요.',
                  showActions: true,
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.white.withOpacity(0.7)),
                Text(
                  '잠금 해제하려면 위로 스와이프',
                  style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassNotificationCard extends StatelessWidget {
  const _GlassNotificationCard({
    required this.appName,
    required this.timeLabel,
    required this.title,
    required this.message,
    this.showActions = false,
  });

  final String appName;
  final String timeLabel;
  final String title;
  final String message;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(color: AppColors.white.withOpacity(0.18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primary500,
                      borderRadius: BorderRadius.circular(AppRadius.small),
                    ),
                    child: const Icon(Icons.medication_rounded, color: AppColors.white, size: 16),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(appName, style: AppTextStyles.body.copyWith(color: AppColors.primary500)),
                  const Spacer(),
                  Text(timeLabel, style: AppTextStyles.caption.copyWith(color: AppColors.white.withOpacity(0.7))),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: AppTextStyles.cardTitle.copyWith(color: AppColors.white)),
              const SizedBox(height: AppSpacing.sm),
              Text(message, style: AppTextStyles.body.copyWith(color: AppColors.white.withOpacity(0.9))),
              if (showActions) ...[
                const SizedBox(height: AppSpacing.md),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    '오후 1:00 · 당뇨약 (메트포르민 500mg)',
                    style: AppTextStyles.caption.copyWith(color: AppColors.white),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: '나중에 알림',
                        color: AppColors.black.withOpacity(0.35),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _ActionButton(
                        label: '복용 완료',
                        color: AppColors.primary500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: AppTextStyles.body.copyWith(color: AppColors.white)),
    );
  }
}
