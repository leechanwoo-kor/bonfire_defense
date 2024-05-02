import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/game_managers/entity_manager.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class EnemyManager extends EntityManager {
  final GameStateProvider state;
  final EnemyStateProvider enemyStateProvider;
  final GameConfig config;

  EnemyManager(super.gameController)
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

  @override
  bool canAddEntity() {
    return enemyStateProvider.enemyCount < config.enemies.length;
  }

  @override
  void addEntity() {
    _createEnemy();
  }

  void _createEnemy() {
    GameStateProvider state = Provider.of<GameStateProvider>(
        gameController.gameRef.context,
        listen: false);

    if (enemyStateProvider.enemyCount >= config.enemies.length) return;
    Enemy enemy;

    switch (config.enemies[enemyStateProvider.enemyCount]) {
      case EnemyType.orc:
        enemy = Orc(
          onDeath: death,
          position: Vector2(
            config.enemyInitialPosition.x - 8,
            config.enemyInitialPosition.y - 8,
          ),
          path: List.of(config.enemyPath),
          life: 100 + (state.currentStage * 10),
        );
        break;
    }
    if (!enemy.isMounted) {
      try {
        gameController.gameRef.add(enemy);
        enemyStateProvider.updateEnemyCount(1);
        state.updateCount(1);
      } catch (e) {
        print("Error adding enemy: $e");
      }
    }
  }

  void death(Orc orc) {
    state.updateCount(-1);
    state.updateScore(1);
  }
}
