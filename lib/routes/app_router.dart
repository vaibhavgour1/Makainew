
import 'package:go_router/go_router.dart';
import 'package:makaihealth/screens/login_signup/view/login_signup_screen.dart';
import 'package:makaihealth/screens/movile_number/view/enter_mobile_number.dart';
import 'package:makaihealth/screens/onboarding/view/onboarding_screen.dart';
import 'package:makaihealth/screens/spalsh/view/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'SplashScreen', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: 'OnboardingPage', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/OnboardingPage',
      builder: (context, state) =>   OnboardingScreen(),
    ),
    GoRoute(
      name: 'LoginSignupScreen', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/LoginSignupScreen',
      builder: (context, state) => const LoginSignupScreen(),
    ),
    GoRoute(
      name: 'EnterMobileNUmber', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/EnterMobileNUmber',
      builder: (context, state) => const EnterMobileNUmber(),
    ),

  ],
);