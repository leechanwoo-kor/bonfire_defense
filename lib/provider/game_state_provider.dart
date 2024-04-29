import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

enum GameState { idle, running, paused, ended }

class GameStateProvider with ChangeNotifier {
  GameState _state = GameState.idle;
  int _currentStage = 1;

  void startGame() {
    _state = GameState.running;
    notifyListeners();
  }

  void stopGame() {
    _state = GameState.idle;
    notifyListeners();
  }

  void nextStage() {
    _currentStage++;
    notifyListeners();
  }

  GameState get state => _state;
  int get currentStage => _currentStage;
}

class DefenderStateProvider with ChangeNotifier {
  final Map<DefenderType, int> _defenderCounts = {};

  void addDefender(DefenderType type) {
    if (_defenderCounts.containsKey(type)) {
      _defenderCounts[type] = _defenderCounts[type]! + 1;
    } else {
      _defenderCounts[type] = 1;
    }
    notifyListeners();
  }

  int getDefenderCount(DefenderType type) {
    return _defenderCounts[type] ?? 0;
  }

  Vector2? _placementPosition;
  Vector2? get placementPosition => _placementPosition;

  void setPlacementPosition(Vector2? position) {
    _placementPosition = position;
    notifyListeners();
  }
}

class EnemyStateProvider with ChangeNotifier {
  int _enemyCount = 0;

  void addEnemy() {
    _enemyCount++;
    notifyListeners();
  }

  int get enemyCount => _enemyCount;

  void resetEnemyCount() {
    _enemyCount = 0;
    notifyListeners();
  }

  void updateEnemyCount(int change) {
    _enemyCount += change;
    notifyListeners();
  }
}
