import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(
    this.title, {
    super.key,
    this.textAlign = TextAlign.start,
  });

  final String title;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: AppTextStyles.pageTitle,
    );
  }
}

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
          child: ScreenTitle(title),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
