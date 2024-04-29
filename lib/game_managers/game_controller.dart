import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent with ChangeNotifier {
  final GameConfig config;
  Map<DefenderType, int> defenderCount = {};
  bool _running = false;
  int _countEnemy = 0;
  int _count = 0;
  int _score = 0;
  int _life = 10;
  int _stage = 1;

  late DefenderManager _defenderManager;
  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;

  GameController({required this.config}) {
    _defenderManager = DefenderManager(this);
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
  }

  void addDefender(DefenderType type, Vector2? tilePosition) {
    _defenderManager.addDefender(type, tilePosition);
  }

  int getDefenderCount(DefenderType type) {
    return _defenderManager.getDefenderCount(type);
  }

  bool get isRunning => _running;
  int get countEnemy => _countEnemy;
  int get count => _count;
  int get score => _score;
  int get life => _life;
  int get stage => _stage;

  set running(bool value) {
    if (_running != value) {
      _running = value;
      notifyListeners();
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
    notifyListeners();
  }

  void nextStage() {
    _running = false;
    _stage++;
    _countEnemy = 0; // Reset the count for the new stage
    notifyListeners();
  }

  Vector2? placementPosition;

  void setPlacementPosition(Vector2 position) {
    placementPosition = position;
  }

  activateSpecialAbility() {
    // Implementation of special abilities
  }
}

class EndGameManager {
  final GameController gameController;

  EndGameManager(this.gameController);

  void checkEndGame(double dt) {
    if (!gameController.checkInterval('addsEnemy', 1000, dt)) return;
    if (gameController.countEnemy != gameController.config.enemies.length) {
      return;
    }

    final enemies = gameController.gameRef.query<Enemy>();
    if (enemies.isEmpty) {
      gameController.running = false;
      final gameSensor = gameController.gameRef.query<EndGameSensor>().first;
      if (gameSensor.counter > gameController.config.countEnemyPermited) {
        showDialogEndGame('Game over!', true);
      } else {
        showDialogEndGame('Stage ${gameController.stage} cleared!', false);
      }
    }
  }

  void showDialogEndGame(String text, bool isGameOver) {
    showDialog(
      context: gameController.context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              if (isGameOver) {
                Navigator.of(context).popUntil(
                    (route) => route.settings.name == AppRoutes.homeRoute);
              } else {
                gameController.nextStage(); // Continue to the next stage
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
