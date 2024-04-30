import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/game_managers/game_manager.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent with ChangeNotifier {
  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;
  late GameStateProvider? _gameStateProvider;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
    _gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
  }

  @override
  void update(double dt) {
    if (_gameStateProvider?.state == GameState.running) {
      _enemyManager.update(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }
}
