import 'package:bonfire/npc/enemy/enemy.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EndGameManager {
  final GameController gameController;

  EndGameManager(this.gameController);

  void checkEndGame(double dt) {
    GameStateProvider state = Provider.of<GameStateProvider>(
        gameController.gameRef.context,
        listen: false);
    EnemyStateProvider enemyState = Provider.of<EnemyStateProvider>(
        gameController.gameRef.context,
        listen: false);

    if (!gameController.checkInterval('addsEnemy', 1000, dt)) return;
    if (enemyState.enemyCount != gameController.config.enemies.length) {
      return;
    }

    final enemies = gameController.gameRef.query<Enemy>();
    if (enemies.isEmpty) {
      state.stopGame();
      final gameSensor = gameController.gameRef.query<EndGameSensor>().first;
      if (gameSensor.counter > gameController.config.countEnemyPermited) {
        showDialogEndGame('Game over!', true);
      } else {
        showDialogEndGame('Stage ${state.currentStage} cleared!', false);
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
