import 'package:bonfire_defense/screens/about_screen.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeRoute = '/';
  static const String aboutRoute = '/about';
  static const String stagesRoute = '/stages';
  static const String gameRoute = '/game';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      homeRoute: (_) => const SplashScreen(),
      aboutRoute: (_) => const AboutScreen(),
      gameRoute: (context) => const BonfireDefense(),
    };
  }

  static void open(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
