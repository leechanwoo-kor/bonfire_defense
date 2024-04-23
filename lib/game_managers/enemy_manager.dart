import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/game_controller.dart';
import 'package:bonfire_defense/components/orc.dart';
import 'package:bonfire_defense/util/stage_config.dart';

class EnemyManager {
  final GameController _gameController;

  EnemyManager(this._gameController);

  void addsEnemy(double dt) {
    if (_gameController.countEnemy < _gameController.config.enemies.length) {
      if (_gameController.checkInterval('addsEnemy', 1000, dt)) {
        _createEnemy();
      }
    }
  }

  void _createEnemy() {
    Enemy enemy;
    switch (_gameController.config.enemies[_gameController.countEnemy]) {
      case EnemyType.orc:
        enemy = Orc(
          position: Vector2(
            _gameController.config.enemyInitialPosition.x - 8,
            _gameController.config.enemyInitialPosition.y - 8,
          ),
          path: List.of(_gameController.config.enemyPath),
        );
        break;
    }
    _gameController.gameRef.add(enemy);
    _gameController.increaseCountEnemy();
    _gameController.increaseCount();
  }
}
