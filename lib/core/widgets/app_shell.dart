import 'package:flutter/material.dart';

import '../../app/tab_navigation.dart';
import 'app_bottom_navigation_bar.dart';
import '../theme/app_colors.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.body,
    required this.selectedTab,
  });

  final Widget body;
  final AppTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: body,
      bottomNavigationBar: AppBottomNavigationBar(
        selectedTab: selectedTab,
        onSelectedTab: (tab) => TabNavigation.switchTab(context, tab),
      ),
    );
  }
}
