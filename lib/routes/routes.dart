import 'package:flutter/material.dart';
import 'package:tft_app/pages/home_screen.dart';
import 'package:tft_app/pages/login_screen.dart';
import 'package:tft_app/pages/main_screen.dart';
import 'package:tft_app/pages/onboarding_Screen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.name: (context) => const HomeScreen(),
  MainScreen.name: (context) => const MainScreen(),
  OnboardingScreen.name: (context) => const OnboardingScreen(),
  LoginScreen.name: (context) => const LoginScreen(),
};
