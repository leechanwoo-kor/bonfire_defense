import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/end_game_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent with ChangeNotifier {
  final GameConfig config;

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
    GameStateProvider state =
        Provider.of<GameStateProvider>(gameRef.context, listen: false);
    if (state.running) {
      _enemyManager.addsEnemy(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }

  void nextStage() {
    GameStateProvider state =
        Provider.of<GameStateProvider>(gameRef.context, listen: false);
    EnemyStateProvider enemyState =
        Provider.of<EnemyStateProvider>(gameRef.context, listen: false);
    state.stopGame();
    state.nextStage();
    enemyState.resetEnemyCount();
  }

  Vector2? placementPosition;

  void setPlacementPosition(Vector2 position) {
    placementPosition = position;
  }
}
