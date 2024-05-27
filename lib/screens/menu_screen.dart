import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/provider/enemy_state_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/screens/about_screen.dart';
import 'package:bonfire_defense/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3b3a36),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bonfire Defense',
              style: TextStyle(
                fontFamily: 'Catholicon',
                fontSize: 48,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            buildMenuButton(context, 'Play', () => startGame(context)),
            const SizedBox(height: 16),
            buildMenuButton(context, 'About', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(
      BuildContext context, String label, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff6d4c41),
          textStyle: const TextStyle(
            fontFamily: 'Catholicon',
            fontSize: 24,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        child: Text(label),
      ),
    );
  }

  void startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(
          onLoadComplete: () async {
            initializeProviders(context);
            await Future.delayed(const Duration(milliseconds: 500));
          },
        ),
      ),
    );
  }

  void initializeProviders(BuildContext context) {
    context.read<GameStateProvider>().init();
    context.read<DefenderStateProvider>().init();
    context.read<EnemyStateProvider>().resetEnemyCount();
    context.read<OverlayProvider>().clearOverlays();
  }
}
