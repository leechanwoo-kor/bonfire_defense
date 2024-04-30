import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

enum GameState { idle, running, paused, ended }

class GameStateProvider with ChangeNotifier {
  GameState _state = GameState.idle;
  int _currentStage = 1;
  int _count = 0;
  int _score = 0;
  int _life = 10;

  int get count => _count;
  int get score => _score;
  int get life => _life;

  void updateCount(int change) {
    _count += change;
    notifyListeners();
  }

  void updateScore(int change) {
    _score += change;
    notifyListeners();
  }

  void updateLife(int change) {
    _life += change;
    notifyListeners();
  }

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

  void init() {
    _state = GameState.idle;
    _currentStage = 1;
    _count = 0;
    _score = 0;
    _life = 10;
    notifyListeners();
  }
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

  void init() {
    _defenderCounts.clear();
    _placementPosition = null;
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
