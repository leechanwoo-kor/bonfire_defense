import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/components/lancer.dart';
import 'package:bonfire_defense/game_managers/end_game_manager.dart';
import 'package:bonfire_defense/game_managers/enemy_manager.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:bonfire_defense/widgets/start_button.dart';
import 'package:flutter/material.dart';

class GameController extends GameComponent with ChangeNotifier {
  final GameConfig config;

  Map<DefenderType, int> defenderCount = {};

  bool _running = false;
  int _countEnemy = 0;
  int _count = 0;
  int _score = 0;
  int _life = 10;

  // bool get isRunning => _running;
  int get countEnemy => _countEnemy;
  int get count => _count;
  int get score => _score;
  int get life => _life;

  set running(bool value) {
    try {
      if (_running != value) {
        _running = value;
        notifyListeners();
      }
    } catch (e) {
      print('Error setting running: $e');
    }
  }

  void updateStats({
    int enemyChange = 0,
    int countChange = 0,
    int scoreChange = 0,
    int lifeChange = 0,
  }) {
    _countEnemy += enemyChange;
    _count += countChange;
    _score += scoreChange;
    _life += lifeChange;
    notifyListeners();
  }

  late EnemyManager _enemyManager;
  late EndGameManager _endGameManager;

  GameController({required this.config}) {
    _enemyManager = EnemyManager(this);
    _endGameManager = EndGameManager(this);
  }

  @override
  void update(double dt) {
    if (_running) {
      _enemyManager.addsEnemy(dt);
      _endGameManager.checkEndGame(dt);
    }

    super.update(dt);
  }

  void startStage() {
    _running = true;
    gameRef.overlays.remove(StartButton.overlayName);
    gameRef.query<Defender>().forEach((element) {
      // element.showRadiusVision(false);
    });
    notifyListeners();
  }

  Vector2? placementPosition;

  void setPlacementPosition(Vector2 position) {
    placementPosition = position;
  }

  void addDefender(DefenderType type, Vector2? tilePosition) {
    if (tilePosition == null) {
      return;
    }

    Vector2 unitSize = Vector2.all(32.0);
    Vector2 unitPosition = Vector2(
      tilePosition.x + (BonfireDefense.tileSize - unitSize.x) / 2,
      tilePosition.y + (BonfireDefense.tileSize - unitSize.y) / 2,
    );
    GameComponent defender = DefenderFactory.createDefender(type, unitPosition);
    gameRef.add(defender);

    defenderCount[type] = (defenderCount[type] ?? 0) + 1;

    notifyListeners();
  }

  // 유닛 타입의 카운트를 반환
  int getDefenderCount(DefenderType type) {
    return defenderCount[type] ?? 0;
  }

  activateSpecialAbility() {}

  pauseGame() {}
}

class DefenderFactory {
  static GameComponent createDefender(DefenderType type, Vector2 position) {
    switch (type) {
      case DefenderType.arch:
        return Archer(position: position);
      case DefenderType.knight:
        return Knight(position: position);
      case DefenderType.lancer:
        return Lancer(position: position);
      default:
        throw UnimplementedError('Defender type $type not supported');
    }
  }
}
