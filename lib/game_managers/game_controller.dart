import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/provider/stats_provider.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent with ChangeNotifier {
  final GameConfig config;
  Map<DefenderType, int> defenderCount = {};

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

  @override
  void update(double dt) {
    StatsProvider stats =
        Provider.of<StatsProvider>(gameRef.context, listen: false);
    if (stats.running) {
      _enemyManager.addsEnemy(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }

  void startStage() {
    StatsProvider stats =
        Provider.of<StatsProvider>(gameRef.context, listen: false);
    stats.running = true;
  }

  void nextStage() {
    StatsProvider stats =
        Provider.of<StatsProvider>(gameRef.context, listen: false);
    stats.running = false;
    stats.updateStage();
    stats.resetEnemyCount();
  }

  Vector2? placementPosition;

  void setPlacementPosition(Vector2 position) {
    placementPosition = position;
  }
}

class EndGameManager {
  final GameController gameController;

  EndGameManager(this.gameController);

  void checkEndGame(double dt) {
    StatsProvider stats = Provider.of<StatsProvider>(
        gameController.gameRef.context,
        listen: false);

    if (!gameController.checkInterval('addsEnemy', 1000, dt)) return;
    if (stats.countEnemy != gameController.config.enemies.length) {
      return;
    }

    final enemies = gameController.gameRef.query<Enemy>();
    if (enemies.isEmpty) {
      stats.running = false;
      final gameSensor = gameController.gameRef.query<EndGameSensor>().first;
      if (gameSensor.counter > gameController.config.countEnemyPermited) {
        showDialogEndGame('Game over!', true);
      } else {
        showDialogEndGame('Stage ${stats.stage} cleared!', false);
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
