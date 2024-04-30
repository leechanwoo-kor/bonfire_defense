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
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  GameStateProvider stateProvider =
                      Provider.of<GameStateProvider>(context, listen: false);
                  stateProvider.init();
                  DefenderStateProvider defenderStateProvider =
                      Provider.of<DefenderStateProvider>(context,
                          listen: false);
                  defenderStateProvider.init();
                  EnemyStateProvider enemyStateProvider =
                      Provider.of<EnemyStateProvider>(context, listen: false);
                  enemyStateProvider.resetEnemyCount();
                  OverlayProvider overlayProvider =
                      Provider.of<OverlayProvider>(context, listen: false);
                  overlayProvider.clearOverlays();
                  Navigator.of(context).pushNamed(
                    '/game',
                    arguments: GameStageEnum.main,
                  );
                },
                child: const Text('Play'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/about'),
                child: const Text('About'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
