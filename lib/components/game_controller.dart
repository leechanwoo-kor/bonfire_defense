import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/game_managers/end_game_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/pages/game/game.dart';
import 'package:bonfire_defense/util/defender.dart';
import 'package:bonfire_defense/util/stage_config.dart';
import 'package:bonfire_defense/widgets/start_button.dart';

class GameController extends GameComponent {
  final StageConfig config;
  bool _running = false;
  int _countEnemy = 0;

  bool get isRunning => _running;
  int get countEnemy => _countEnemy;
  set running(bool value) => _running = value;

  void increaseCountEnemy() {
    _countEnemy++;
  }

  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;

  GameController({required this.config}) {
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
  }

  @override
  void update(double dt) {
    if (_running) {
      _enemyManager.addsEnemy(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }

  void startStage() {
    _running = true;
    gameRef.overlays.remove(StartButton.overlayName);
    gameRef.query<Defender>().forEach((element) {
      element.showRadiusVision(false);
    });
  }

  @override
  void onMount() {
    int count = 5;
    for (var defender in config.defenders) {
      switch (defender) {
        case DefenderType.arch:
          gameRef.add(
            Archer(
              position: Vector2(
                count * 1 * BonfireDefense.tileSize - 8,
                2 * BonfireDefense.tileSize - 8,
              ),
            ),
          );
          break;
        case DefenderType.knight:
          gameRef.add(
            Knight(
              position: Vector2(
                count * 1 * BonfireDefense.tileSize - 8,
                2 * BonfireDefense.tileSize - 8,
              ),
            ),
          );
          break;
      }
      count = count + 3;
    }

    super.onMount();
  }
}
