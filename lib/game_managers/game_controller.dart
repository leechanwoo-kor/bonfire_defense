import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender_info.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/provider/enemy_state_provider.dart';
import 'package:bonfire_defense/provider/game_config_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/menu_page.dart';
import 'package:bonfire_defense/utils/game_config.dart';
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
  }

  void addDefender(DefenderInfo info, Vector2? tilePosition) {
    _defenderManager.addDefender(info, tilePosition);
  }

  void nextStage() {
    _gameStateProvider.stopGame();
    _gameStateProvider.nextStage();
    _enemyStateProvider.resetEnemyCount();
  }

  Future<void> checkWave() async {
    while (_gameStateProvider.state == GameState.waving) {
      if (_enemyStateProvider.enemyCount == config.enemies.length) {
        endWaveCheck();
      }
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  void endWaveCheck() {
    if (_gameStateProvider.count == 0) {
      _gameStateProvider.stopGame();

      if (_gameStateProvider.life <= 0) {
        var msg = 'Game over!';
        showDialogEndGame(msg, true);
      } else {
        var msg = 'Stage ${_gameStateProvider.currentStage} cleared!';
        showFullOverlay(context, msg, false);
      }
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
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                    (route) => false);
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

  void showFullOverlay(BuildContext context, String message, bool isGameOver) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    // 오버레이를 화면에 추가
    Overlay.of(context).insert(overlayEntry);

    // 특정 시간 후에 오버레이 제거 및 다음 액션 수행
    Future.delayed(const Duration(milliseconds: 500), () {
      overlayEntry.remove();
      if (isGameOver) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
          (route) => false,
        );
      } else {
        nextStage();
      }
    });
  }
}
