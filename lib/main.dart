import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/provider/enemy_state_provider.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/utils/sounds.dart';
import 'package:bonfire_defense/utils/stages.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setPortrait();
  }
  await Sounds.initialize();
  Sounds.playBackgroundSound();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                GameConfigProvider(GameStages.get(GameStageEnum.map))),
        ChangeNotifierProvider(create: (_) => GameStateProvider()),
        ChangeNotifierProvider(create: (_) => DefenderStateProvider()),
        ChangeNotifierProvider(create: (_) => EnemyStateProvider()),
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
      initialRoute: '/',
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
