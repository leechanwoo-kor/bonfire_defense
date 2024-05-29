import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/enemy/orc.dart';
import 'package:bonfire_defense/components/enemy/skeleton.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/enemy_state_provider.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:provider/provider.dart';

class EnemyManager {
  final GameController gameController;

  final GameStateProvider state;
  final EnemyStateProvider enemyStateProvider;
  final GameConfig config;

  EnemyManager(this.gameController)
      : state = Provider.of<GameStateProvider>(gameController.gameRef.context,
            listen: false),
        enemyStateProvider = Provider.of<EnemyStateProvider>(
            gameController.gameRef.context,
            listen: false),
        config = Provider.of<GameConfigProvider>(gameController.gameRef.context,
                listen: false)
            .currentConfig;

  Future<void> startWave() async {
    state.waving();

    while (canAddEntity()) {
      addEntity();
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  bool canAddEntity() {
    return enemyStateProvider.enemyCount < config.enemies.length;
  }

  void addEntity() {
    _createEnemy();
  }

  void _createEnemy() {
    GameStateProvider state = Provider.of<GameStateProvider>(
        gameController.gameRef.context,
        listen: false);

    if (enemyStateProvider.enemyCount >= config.enemies.length) return;
    Enemy enemy;

    double baseLife = 5;
    double life = baseLife * (pow(1.5, state.currentStage - 1));

    switch (config.enemies[enemyStateProvider.enemyCount]) {
      case EnemyType.orc:
        enemy = Orc(
          onDeath: death,
          position: Vector2(
            config.enemyInitialPosition.x - 8,
            config.enemyInitialPosition.y - 8,
          ),
          path: List.of(config.enemyPath),
          life: life,
        );
        break;
      case EnemyType.skeleton:
        enemy = Skeleton(
          onDeath: death,
          position: Vector2(
            config.enemyInitialPosition.x - 8,
            config.enemyInitialPosition.y - 8,
          ),
          path: List.of(config.enemyPath),
          life: life,
        );
    }

    gameController.gameRef.add(enemy);
    enemyStateProvider.updateEnemyCount(1);
    state.updateCount(1);
  }

  void death(SimpleEnemy enemy) {
    state.updateCount(-1);
    state.updateGold(3);
  }
}
