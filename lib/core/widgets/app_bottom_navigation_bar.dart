import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum AppTab { home, family, steps, meds, settings }

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.onSelectedTab,
  });

  final AppTab selectedTab;
  final ValueChanged<AppTab> onSelectedTab;

  static const _tabs = <(AppTab, IconData, String)>[
    (AppTab.home, Icons.home_rounded, '홈'),
    (AppTab.family, Icons.people_rounded, '가족'),
    (AppTab.steps, Icons.directions_walk_rounded, '걸음'),
    (AppTab.meds, Icons.medication_rounded, '약'),
    (AppTab.settings, Icons.settings_rounded, '설정'),
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xE6FFFFFF),
            border: Border(top: BorderSide(color: AppColors.borderLight)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _tabs.map((tab) {
                  final isSelected = selectedTab == tab.$1;
                  final color = isSelected
                      ? AppColors.primary500
                      : AppColors.tabInactive;
                  return Expanded(
                    child: InkWell(
                      onTap: () => onSelectedTab(tab.$1),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(tab.$2, size: 28, color: color),
                            const SizedBox(height: 4),
                            Text(
                              tab.$3,
                              style: TextStyle(
                                fontSize: 10,
                                height: 1.5,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
