import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/game_managers/end_game_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/pages/game/game.dart';
import 'package:bonfire_defense/util/defender.dart';
import 'package:bonfire_defense/util/stage_config.dart';
import 'package:bonfire_defense/widgets/start_button.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent with ChangeNotifier {
  final StageConfig config;
  bool _running = false;
  int _countEnemy = 0;
  int _count = 0;
  int score = 0;

  bool get isRunning => _running;
  int get countEnemy => _countEnemy;
  int get count => _count;
  set running(bool value) {
    try {
      if (_running != value) {
        _running = value;
        notifyListeners();
      }
    } catch (e) {
      print('Error setting running: $e');
    }
  }

  void increaseCountEnemy() {
    _countEnemy++;
    notifyListeners();
  }

  void increaseCount() {
    _count++;
    notifyListeners();
  }

  void decreaseCount() {
    _count--;
    notifyListeners();
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
    notifyListeners();
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

    notifyListeners();
    super.onMount();
  }

  activateSpecialAbility() {}

  pauseGame() {}
}
