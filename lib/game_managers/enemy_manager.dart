import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/game_managers/entity_manager.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class EnemyManager extends EntityManager {
  EnemyManager(super.controller);

  @override
  bool canAddEntity() {
    EnemyStateProvider enemyState = Provider.of<EnemyStateProvider>(
        gameController.gameRef.context,
        listen: false);
    GameConfig config = Provider.of<GameConfigProvider>(
            gameController.gameRef.context,
            listen: false)
        .currentConfig;
    return enemyState.enemyCount < config.enemies.length;
  }

  @override
  void addEntity() {
    _createEnemy();
  }

  void _createEnemy() {
    GameConfig config = Provider.of<GameConfigProvider>(
            gameController.gameRef.context,
            listen: false)
        .currentConfig;
    EnemyStateProvider enemyState = Provider.of<EnemyStateProvider>(
        gameController.gameRef.context,
        listen: false);
    GameStateProvider state = Provider.of<GameStateProvider>(
        gameController.gameRef.context,
        listen: false);

    if (enemyState.enemyCount >= config.enemies.length) return;
    Enemy enemy;

    switch (config.enemies[enemyState.enemyCount]) {
      case EnemyType.orc:
        enemy = Orc(
          gameController,
          position: Vector2(
            config.enemyInitialPosition.x - 8,
            config.enemyInitialPosition.y - 8,
          ),
          path: List.of(config.enemyPath),
        );
        break;
    }
    if (!enemy.isMounted) {
      try {
        gameController.gameRef.add(enemy);
        enemyState.updateEnemyCount(1);
        state.updateCount(1);
      } catch (e) {
        print("Error adding enemy: $e");
      }
    }
  }
}
