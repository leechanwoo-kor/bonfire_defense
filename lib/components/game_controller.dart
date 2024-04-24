import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/game_managers/end_game_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/defender.dart';
import 'package:bonfire_defense/util/stage_config.dart';
import 'package:bonfire_defense/widgets/start_button.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent with ChangeNotifier {
  final StageConfig config;
  Map<String, bool> overlaysActive = {};

  bool _running = false;
  int _countEnemy = 0;
  int _count = 0;
  int _score = 0;
  int _life = 10;

  bool get isRunning => _running;
  int get countEnemy => _countEnemy;
  int get count => _count;
  int get score => _score;
  int get life => _life;

  // 오버레이 상태 변경 메소드
  void setOverlayActive(String overlayName, bool isActive) {
    if (overlaysActive[overlayName] != isActive) {
      overlaysActive[overlayName] = isActive;
      notifyListeners();
    }
  }

  // 오버레이 상태 조회 메소드
  bool isOverlayActive(String overlayName) {
    return overlaysActive[overlayName] ?? false;
  }

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

  void updateStats({
    int enemyChange = 0,
    int countChange = 0,
    int scoreChange = 0,
    int lifeChange = 0,
  }) {
    _countEnemy += enemyChange;
    _count += countChange;
    _score += scoreChange;
    _life += lifeChange;
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
