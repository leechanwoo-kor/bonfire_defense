import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/util/stage_config.dart';

class EnemyManager {
  final GameController _controller;

  EnemyManager(this._controller);

  void addsEnemy(double dt) {
    if (_controller.countEnemy < _controller.config.enemies.length) {
      if (_controller.checkInterval('addsEnemy', 1000, dt)) {
        _createEnemy();
      }
    }
  }

  void _createEnemy() {
    Enemy enemy;
    switch (_controller.config.enemies[_controller.countEnemy]) {
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
      } catch (e) {
        print("Error adding enemy: $e");
      }
    }
    _controller.updateStats(enemyChange: 1, countChange: 1);
  }
}
