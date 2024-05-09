import 'package:flutter/material.dart';

class EnemyStateProvider with ChangeNotifier {
  int _enemyCount = 0;

  int get enemyCount => _enemyCount;

  void addEnemy() {
    _enemyCount++;
    notifyListeners();
  }

  void resetEnemyCount() {
    _enemyCount = 0;
    notifyListeners();
  }

  void updateEnemyCount(int change) {
    _enemyCount += change;
    notifyListeners();
  }
}
