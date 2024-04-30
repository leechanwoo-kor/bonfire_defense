import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/game_managers/game_manager.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent with ChangeNotifier {
  // late DefenderManager _defenderManager;
  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;

  GameController() {
    // _defenderManager = DefenderManager(this);
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
  }

  @override
  void update(double dt) {
    GameStateProvider state =
        Provider.of<GameStateProvider>(gameRef.context, listen: false);
    if (state.state == GameState.running) {
      _enemyManager.addsEnemy(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }
}
