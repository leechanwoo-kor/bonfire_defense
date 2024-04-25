import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/util/stages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Flame.device.fullScreen();
    Flame.device.setPortrait();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                GameController(config: GameStages.get(GameStageEnum.main))),
        ChangeNotifierProvider(create: (_) => OverlayProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonfire Defense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 14.0)),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      routes: AppRoutes.defineRoutes(),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            double aspectRatio = 16 / 9;
            double screenWidth = constraints.maxWidth;
            double screenHeight = constraints.maxHeight;

            double calculatedHeight = screenWidth * aspectRatio;
            if (calculatedHeight > screenHeight) {
              screenWidth = screenHeight / aspectRatio;
              calculatedHeight = screenHeight;
            }

            return Center(
              child: SizedBox(
                width: screenWidth,
                height: calculatedHeight,
                child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
