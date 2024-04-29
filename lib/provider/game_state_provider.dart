import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

class GameStateProvider with ChangeNotifier {
  bool _running = false;
  int _currentStage = 1;

  void startGame() {
    _running = true;
    notifyListeners();
  }

  void stopGame() {
    _running = false;
    notifyListeners();
  }

  void nextStage() {
    _currentStage++;
    notifyListeners();
  }

  bool get running => _running;
  int get currentStage => _currentStage;
}

class DefenderStateProvider with ChangeNotifier {
  Map<DefenderType, int> _defenderCounts = {};

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
