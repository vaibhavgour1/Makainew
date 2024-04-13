import 'package:go_router/go_router.dart';
import 'package:makaihealth/screens/Patient_Info/view/patientinfo_form_screen.dart';
import 'package:makaihealth/screens/assessment/view/assessment_screen.dart';
import 'package:makaihealth/screens/doctor_info/view/doctor_info_screen.dart';
import 'package:makaihealth/screens/home/views/home_view.dart';
import 'package:makaihealth/screens/login_signup/view/Verifyotp_screen.dart';
import 'package:makaihealth/screens/login_signup/view/login_signup_screen.dart';
import 'package:makaihealth/screens/login_signup/view/loginwith_email_screen.dart';
import 'package:makaihealth/screens/medical_condition/view/medical_condition_screen.dart';
import 'package:makaihealth/screens/medication_screen/view/medication_screen.dart';
import 'package:makaihealth/screens/movile_number/view/enter_mobile_number.dart';
import 'package:makaihealth/screens/notification/view/notification_screen.dart';
import 'package:makaihealth/screens/onboarding/view/onboarding_screen.dart';
import 'package:makaihealth/screens/reports/view/reports_screen.dart';
import 'package:makaihealth/screens/spalsh/view/splash_screen.dart';
import 'package:makaihealth/screens/summery/view/summery_screen.dart';
import 'package:makaihealth/screens/user_home_menu/view/user_home_screen.dart';
import 'package:makaihealth/screens/user_profile/view/edit_profile_screen.dart';
import 'package:makaihealth/screens/user_profile/view/user_profile_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'SplashScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'OnboardingPage',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/OnboardingPage',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      name: 'LoginSignupScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/LoginSignupScreen',
      builder: (context, state) => const LoginSignupScreen(),
    ),
    GoRoute(
      name: 'EnterMobileNUmber',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/EnterMobileNUmber',
      builder: (context, state) => const EnterMobileNUmber(),
    ),
    GoRoute(
      name: 'VerifyOtpScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/VerifyOtpScreen',
      builder: (context, state) =>  const VerifyOtpScreen(verify: '', mobile: '',),
    ),
    GoRoute(
      name: 'HomeView',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/HomeView',
      builder: (context, state) =>  HomeView(),
    ),
    GoRoute(
      name: 'LoginwithEmailScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/LoginwithEmailScreen',
      builder: (context, state) => const LoginwithEmailScreen(),
    ),
    GoRoute(
      name: 'PatientInfoFormScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/PatientInfoFormScreen',
      builder: (context, state) => const PatientInfoFormScreen(),
    ),
    GoRoute(
      name: 'PatientProfileScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/PatientProfileScreen',
      builder: (context, state) => const PatientProfileScreen(),
    ),
    GoRoute(
      name: 'EditProfileScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/EditProfileScreen',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      name: 'MedicalConditionScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/MedicalConditionScreen',
      builder: (context, state) => const MedicalConditionScreen(),
    ),
    GoRoute(
      name: 'DoctorInfoScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/DoctorInfoScreen',
      builder: (context, state) => const DoctorInfoScreen(),
    ),
    GoRoute(
      name: 'UserProfileHomeScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/UserProfileHomeScreen',
      builder: (context, state) => const UserProfileHomeScreen(),
    ),
    GoRoute(
      name: 'MedicationScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/MedicationScreen',
      builder: (context, state) => const MedicationScreen(),
    ),
    GoRoute(
      name: 'AssessmentScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/AssessmentScreen',
      builder: (context, state) => const AssessmentScreen(),
    ),
    GoRoute(
      name: 'ReportsScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/ReportsScreen',
      builder: (context, state) => const ReportsScreen(),
    ),
    GoRoute(
      name: 'NotificationScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/NotificationScreen',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      name: 'SummeryScreen',
      // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/SummeryScreen',
      builder: (context, state) => const SummeryScreen(),
    ),
  ],
);
