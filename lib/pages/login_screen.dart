import 'package:flutter/material.dart';

import '../routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String name = AppRoutes.login;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Column(
        children: [Text('Login Screen')],
      ),
    );
  }
}
