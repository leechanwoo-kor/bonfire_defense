import 'package:bonfire_defense/screens/about_page.dart';
import 'package:flutter/material.dart';
import 'package:bonfire_defense/screens/stages_page.dart';
import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/stages.dart';

class AppRoutes {
  static const String homeRoute = '/';
  static const String aboutRoute = '/about';
  static const String stagesRoute = '/stages';
  static const String gameRoute = '/game';

  static Map<String, WidgetBuilder> defineRoutes() {
    return {
      homeRoute: (_) => const MenuPage(),
      aboutRoute: (_) => const AboutPage(),
      stagesRoute: (_) => const StagesPage(),
      gameRoute: (context) => BonfireDefense(
            config: GameStages.get(
              ModalRoute.of(context)?.settings.arguments as GameStageEnum,
            ),
          ),
    };
  }

  static void open(BuildContext context, String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }
}
