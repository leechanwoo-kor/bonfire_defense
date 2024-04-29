import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/provider/stats_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class EnemyManager {
  final GameController _controller;
  EnemyManager(this._controller);

  double _timer = 0;

  void addsEnemy(double dt) {
    _timer += dt * 1000;
    StatsProvider stats =
        Provider.of<StatsProvider>(_controller.gameRef.context, listen: false);

    if (_timer >= 1000) {
      if (stats.countEnemy < _controller.config.enemies.length) {
        _createEnemy();
        _timer = 0;
      }
    }
  }

  void _createEnemy() {
    StatsProvider stats =
        Provider.of<StatsProvider>(_controller.gameRef.context, listen: false);
    if (stats.countEnemy >= _controller.config.enemies.length) return;
    Enemy enemy;

    switch (_controller.config.enemies[stats.countEnemy]) {
      case EnemyType.orc:
        enemy = Orc(
          _controller,
          position: Vector2(
            _controller.config.enemyInitialPosition.x - 8,
            _controller.config.enemyInitialPosition.y - 8,
          ),
          path: List.of(_controller.config.enemyPath),
        );
        break;
    }
    if (!enemy.isMounted) {
      try {
        _controller.gameRef.add(enemy);
        stats.updateEnemyCount(1);
        stats.updateCount(1);
      } catch (e) {
        print("Error adding enemy: $e");
      }
    }
  }
}
