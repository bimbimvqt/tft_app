import 'package:flutter/material.dart';
import '../pages/home_screen.dart';
import '../pages/login_screen.dart';
import '../pages/main_screen.dart';
import '../pages/onboarding_Screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.name: (context) => const HomeScreen(),
  MainScreen.name: (context) => const MainScreen(),
  OnboardingScreen.name: (context) => const OnboardingScreen(),
  LoginScreen.name: (context) => const LoginScreen(),
};
