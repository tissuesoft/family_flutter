import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/family/presentation/pages/family_health_status_page.dart';
import '../features/family/presentation/pages/family_member_detail_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/lock/presentation/pages/lock_screen_notification_page.dart';
import '../features/medications/presentation/pages/medication_management_page.dart';
import '../features/medications/presentation/pages/my_medications_page.dart';
import '../features/onboarding/presentation/pages/onboarding_invitation_page.dart';
import '../features/settings/presentation/pages/app_settings_page.dart';
import '../features/steps/presentation/pages/step_count_detail_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '가족안심',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: '/onboarding',
      routes: {
        '/home': (_) => const HomePage(),
        '/family': (_) => const FamilyHealthStatusPage(),
        '/steps': (_) => const StepCountDetailPage(),
        '/meds': (_) => const MyMedicationsPage(),
        '/settings': (_) => const AppSettingsPage(),
        '/onboarding': (_) => const OnboardingInvitationPage(),
        '/lock': (_) => const LockScreenNotificationPage(),
        '/family/member': (_) => const FamilyMemberDetailPage(),
        '/meds/management': (_) => const MedicationManagementPage(),
      },
    );
  }
}
