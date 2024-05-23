import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/camera_controller.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
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
  late CameraController cameraController;
  late DefenderManager _defenderManager;
  late EnemyManager _enemyManager;

  late GameConfig? config;

  bool get _isGameRunning => _gameStateProvider.state == GameState.running;
  bool get _isGameWaving => _gameStateProvider.state == GameState.waving;

  GameConfigProvider get _gameConfigProvider =>
      Provider.of<GameConfigProvider>(context, listen: false);
  GameStateProvider get _gameStateProvider =>
      Provider.of<GameStateProvider>(context, listen: false);
  DefenderStateProvider get _defenderStateProvider =>
      Provider.of<DefenderStateProvider>(context, listen: false);
  EnemyStateProvider get _enemyStateProvider =>
      Provider.of<EnemyStateProvider>(context, listen: false);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _defenderManager = DefenderManager(this);
    _enemyManager = EnemyManager(this);

    _initializeCameraController();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isGameRunning) {
      _enemyManager.startWave();
      checkWave();
    }
  }

  void _initializeCameraController() {
    config = _gameConfigProvider.currentConfig;
    final double mapWidth = config!.tilesInWidth * BonfireDefense.tileSize;
    final double mapHeight = config!.tilesInHeight * BonfireDefense.tileSize;
    cameraController = CameraController(gameRef, mapWidth, mapHeight);
  }

  void addDefender(DefenderInfo info, Vector2? tilePosition) {
    _defenderManager.addDefender(info, tilePosition);
  }

  void nextStage() {
    final gameStateProvider = _gameStateProvider;
    gameStateProvider.stopGame();
    gameStateProvider.nextStage();
    _enemyStateProvider.resetEnemyCount();
    _defenderStateProvider.shuffleDefenders();
  }

  Future<void> checkWave() async {
    while (_isGameWaving) {
      print("Enemy count: ${_enemyStateProvider.enemyCount}");
      if (_enemyStateProvider.enemyCount == config!.enemies.length) {
        endWaveCheck();
      }
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  void endWaveCheck() {
    if (_gameStateProvider.count == 0) {
      _gameStateProvider.stopGame();

      if (_gameStateProvider.life <= 0) {
        showDialogEndGame('Game over!', true);
      } else {
        showFullOverlay(context,
            'Stage ${_gameStateProvider.currentStage} cleared!', false);
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
        _navigateToMenuPage();
      } else {
        nextStage();
      }
    });
  }

  void _navigateToMenuPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage()),
      (route) => false,
    );
  }
}
