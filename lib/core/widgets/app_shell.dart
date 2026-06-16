import 'package:flutter/material.dart';

import 'app_bottom_navigation_bar.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.body,
    required this.selectedTab,
    required this.onSelectedTab,
  });

  final Widget body;
  final AppTab selectedTab;
  final ValueChanged<AppTab> onSelectedTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
          ),
          child: body,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: AppBottomNavigationBar(
          selectedTab: selectedTab,
          onSelectedTab: onSelectedTab,
        ),
      ),
    );
  }
}

