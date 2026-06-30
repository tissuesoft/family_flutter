import 'package:flutter/material.dart';

import '../core/widgets/app_bottom_navigation_bar.dart';
import '../features/family/presentation/pages/family_health_status_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/medications/presentation/pages/my_medications_page.dart';
import '../features/settings/presentation/pages/app_settings_page.dart';
import '../features/steps/presentation/pages/step_count_detail_page.dart';
import 'tab_routes.dart';

class TabNavigation {
  static void switchTab(BuildContext context, AppTab tab) {
    final routeName = TabRoutes.routeForTab(tab);
    if (ModalRoute.of(context)?.settings.name == routeName) {
      return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, _, _) => _pageForTab(tab),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  static Widget _pageForTab(AppTab tab) {
    return switch (tab) {
      AppTab.home => const HomePage(),
      AppTab.family => const FamilyHealthStatusPage(),
      AppTab.steps => const StepCountDetailPage(),
      AppTab.meds => const MyMedicationsPage(),
      AppTab.settings => const AppSettingsPage(),
    };
  }
}
