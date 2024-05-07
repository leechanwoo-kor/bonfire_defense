import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/provider/overlay_provider.dart';
import 'package:bonfire_defense/util/stages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff85a643),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildMenuButton(context, 'Play', () => startGame(context)),
            const SizedBox(height: 16),
            buildMenuButton(context, 'About',
                () => Navigator.of(context).pushNamed('/about')),
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
        child: Text(label),
      ),
    );
  }

  void startGame(BuildContext context) {
    initializeProviders(context);
    Navigator.of(context).pushNamed('/game', arguments: GameStageEnum.main);
  }

  void initializeProviders(BuildContext context) {
    context.read<GameStateProvider>().init();
    context.read<DefenderStateProvider>().init();
    context.read<EnemyStateProvider>().resetEnemyCount();
    context.read<OverlayProvider>().clearOverlays();
  }
}
