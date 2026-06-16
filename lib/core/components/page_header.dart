import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.trailing,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack) ...[
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.heading.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

