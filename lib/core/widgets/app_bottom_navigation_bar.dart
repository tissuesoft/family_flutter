import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum AppTab { home, family, steps, meds, settings }

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onSelectedTab,
  });

  final AppTab selectedTab;
  final ValueChanged<AppTab> onSelectedTab;

  int _indexFromTab(AppTab tab) {
    switch (tab) {
      case AppTab.home:
        return 0;
      case AppTab.family:
        return 1;
      case AppTab.steps:
        return 2;
      case AppTab.meds:
        return 3;
      case AppTab.settings:
        return 4;
    }
  }

  AppTab _tabFromIndex(int index) {
    switch (index) {
      case 0:
        return AppTab.home;
      case 1:
        return AppTab.family;
      case 2:
        return AppTab.steps;
      case 3:
        return AppTab.meds;
      case 4:
        return AppTab.settings;
      default:
        return AppTab.home;
    }
  }

  BottomNavigationBarItem _item({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(icon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _indexFromTab(selectedTab);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary500,
      unselectedItemColor: AppColors.tabInactive,
      selectedLabelStyle: AppTextStyles.caption.copyWith(
        color: AppColors.primary500,
      ),
      unselectedLabelStyle: AppTextStyles.caption.copyWith(
        color: AppColors.tabInactive,
      ),
      currentIndex: selectedIndex,
      onTap: (index) => onSelectedTab(_tabFromIndex(index)),
      items: <BottomNavigationBarItem>[
        _item(icon: Icons.home_outlined, label: '홈'),
        _item(icon: Icons.family_restroom_outlined, label: '가족'),
        _item(icon: Icons.directions_walk_outlined, label: '걸음'),
        _item(icon: Icons.medical_services_outlined, label: '약'),
        _item(icon: Icons.settings_outlined, label: '설정'),
      ],
    );
  }
}

