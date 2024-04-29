import 'package:flutter/material.dart';

class StatsProvider with ChangeNotifier {
  int _stage = 1;

  int _countEnemy = 0;
  int _count = 0;
  int _score = 0;
  int _life = 10;

  int get stage => _stage;

  int get countEnemy => _countEnemy;
  int get count => _count;
  int get score => _score;
  int get life => _life;

  void updateStage() {
    _stage++;
    notifyListeners();
  }

  void resetEnemyCount() {
    _countEnemy = 0;
    notifyListeners();
  }

  void updateEnemyCount(int change) {
    _countEnemy += change;
    notifyListeners();
  }

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
}
