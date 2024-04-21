import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/app_routes.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/components/game_controller.dart';
import 'package:flutter/material.dart';

class EndGameManager {
  final GameController gameController;

  EndGameManager(this.gameController);

  void checkEndGame(double dt) {
    if (gameController.countEnemy == gameController.config.enemies.length) {
      final enemies = gameController.gameRef.query<Enemy>();
      if (enemies.isEmpty) {
        gameController.running = false;
        final gameSensor = gameController.gameRef.query<EndGameSensor>().first;
        if (gameSensor.counter > gameController.config.countEnemyPermited) {
          showDialogEndGame('Game over!');
        } else {
          showDialogEndGame('Win!');
        }
      }
    }
  }

  void showDialogEndGame(String text) {
    showDialog(
      context: gameController.context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == AppRoutes.stagesRoute,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
