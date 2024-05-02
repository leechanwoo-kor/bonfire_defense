import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/end_game_sensor.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/routes.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent {
  late DefenderManager _defenderManager;
  late EnemyManager _enemyManager;

  late GameConfig config;
  late GameStateProvider _gameStateProvider;
  late EnemyStateProvider _enemyStateProvider;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _defenderManager = DefenderManager(this);
    _enemyManager = EnemyManager(this);

    config =
        Provider.of<GameConfigProvider>(context, listen: false).currentConfig;

    _gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
    _enemyStateProvider =
        Provider.of<EnemyStateProvider>(context, listen: false);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameStateProvider.state == GameState.running) {
      _enemyManager.startWave();
      checkWave();
    }

    super.update(dt);
  }

  void addDefender(DefenderType type, Vector2? tilePosition) {
    _defenderManager.addDefender(type, tilePosition);
  }

  void nextStage() {
    _gameStateProvider.stopGame();
    _gameStateProvider.nextStage();
    _enemyStateProvider.resetEnemyCount();
  }

  Future<void> checkWave() async {
    while (_gameStateProvider.state == GameState.waving) {
      if (_enemyStateProvider.enemyCount == config.enemies.length) {
        if (_gameStateProvider.count == 0) {
          _gameStateProvider.stopGame();

          final gameSensor = gameRef.query<EndGameSensor>().first;
          if (gameSensor.counter > config.countEnemyPermited) {
            var msg = 'Game over!';
            showDialogEndGame(msg, true);
          } else {
            var msg = 'Stage ${_gameStateProvider.currentStage} cleared!';
            showDialogEndGame(msg, false);
          }
        }
      }
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  void showDialogEndGame(String text, bool isGameOver) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(text),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isGameOver) {
                Navigator.of(context).popUntil(
                    (route) => route.settings.name == AppRoutes.homeRoute);
              } else {
                nextStage();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
