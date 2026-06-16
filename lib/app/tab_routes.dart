import '../core/widgets/app_bottom_navigation_bar.dart';

class TabRoutes {
  static String routeForTab(AppTab tab) {
    return switch (tab) {
      AppTab.home => '/home',
      AppTab.family => '/family',
      AppTab.steps => '/steps',
      AppTab.meds => '/meds',
      AppTab.settings => '/settings',
    };
  }
}

