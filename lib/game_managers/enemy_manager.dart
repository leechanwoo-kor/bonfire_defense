import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/provider/stats_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class EnemyManager {
  final GameController _controller;
  EnemyManager(this._controller);

  double _timer = 0;

  void addsEnemy(double dt) {
    _timer += dt * 1000;
    EnemyStateProvider enemyState = Provider.of<EnemyStateProvider>(
        _controller.gameRef.context,
        listen: false);
    GameConfig config = Provider.of<GameConfigProvider>(
            _controller.gameRef.context,
            listen: false)
        .currentConfig;
    if (_timer >= 1000) {
      if (enemyState.enemyCount < config.enemies.length) {
        _createEnemy();
        _timer = 0;
      }
    }
  }

  void _createEnemy() {
    GameConfig config = Provider.of<GameConfigProvider>(
            _controller.gameRef.context,
            listen: false)
        .currentConfig;
    EnemyStateProvider enemyState = Provider.of<EnemyStateProvider>(
        _controller.gameRef.context,
        listen: false);
    StatsProvider gameStats =
        Provider.of<StatsProvider>(_controller.gameRef.context, listen: false);

    if (enemyState.enemyCount >= config.enemies.length) return;
    Enemy enemy;

    switch (config.enemies[enemyState.enemyCount]) {
      case EnemyType.orc:
        enemy = Orc(
          _controller,
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
        _controller.gameRef.add(enemy);
        enemyState.updateEnemyCount(1);
        gameStats.updateCount(1);
      } catch (e) {
        print("Error adding enemy: $e");
      }
    }
  }
}
