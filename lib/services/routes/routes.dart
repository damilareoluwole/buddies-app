import 'package:buddies/screens/auth/password/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:buddies/screens/auth/login.dart';
import 'package:buddies/screens/auth/logout.dart';
import 'package:buddies/screens/auth/verify_otp.dart';
import 'package:buddies/screens/auth/privacy.dart';
import 'package:buddies/screens/auth/register.dart';
import 'package:buddies/screens/dashboard.dart';
import 'package:buddies/screens/onboarding/splash.dart';
import 'package:buddies/screens/profile/edit_profile.dart';
import 'package:buddies/screens/settings.dart';
import 'package:buddies/services/navigation_service.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder>{
    Routes.splash: (context) => const SplashScreen(),
    Routes.login: (context) => const LoginScreen(),
    Routes.register: (context) => const RegisterScreen(),
    Routes.verifyOtp: (context) => const VerifyOtp(),
    Routes.privacy: (context) => const PrivacyScreen(),
    Routes.dashboard: (context) => const DashboardScreen(),
    Routes.editProfile: (context) => const EditProfileScreen(),
    Routes.logout: (context) => const LogoutScreen(),
    Routes.settings: (context) => const SettingsScreen(),
    Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
  };
}

goHome() {
  NavigationService.instance.navigateToReplacementUntil(Routes.dashboard);
}

logout() {
  NavigationService.instance.navigateToReplacementUntil(Routes.login);
}

class Routes {
  static const splash = 'splash';
  static const dashboard = 'dashboard';
  static const login = 'login';
  static const register = 'register';
  static const verifyOtp = 'verrifyOtp';
  static const privacy = 'privacy';
  static const logout = 'logout';
  static const editProfile = 'editProfile';
  static const settings = 'settings';
  static const forgotPassword = 'forgotPassword';
}
