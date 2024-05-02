import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/game_managers/game_manager.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class GameController extends GameComponent {
  late DefenderManager _defenderManager;
  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;
  late GameStateProvider _gameStateProvider;

  bool _waveStarted = false;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _defenderManager = DefenderManager(this);
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
    _gameStateProvider = Provider.of<GameStateProvider>(context, listen: false);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_gameStateProvider.state == GameState.running && !_waveStarted) {
      _enemyManager.startWave();
      _waveStarted = true;
    } else if (_gameStateProvider.state != GameState.running) {
      _waveStarted = false;
    }

    if (_gameStateProvider.state == GameState.running) {
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }

  void addDefender(DefenderType type, Vector2? tilePosition) {
    _defenderManager.addDefender(type, tilePosition);
  }
}
