import 'package:flutter/material.dart';

import 'package:final_project_to_do/screens/screens.dart';

class AppRouting {
  static const initialRoute = 'startScreen';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoute = {};

    appRoute.addAll(
        {"startScreen": (BuildContext context) => const StartScreen()});
    appRoute.addAll(
        {"homeScreen": (BuildContext context) => const HomeScreen()});
    appRoute.addAll(
        {"loginScreen": (BuildContext context) => const LoginScreen()});
    appRoute.addAll(
        {"signUpScreen": (BuildContext context) => const SignUpScreen()});

    return appRoute;
  }
}