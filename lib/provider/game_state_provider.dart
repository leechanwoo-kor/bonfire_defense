import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

enum GameState { idle, running, paused, ended, waving }

class GameStateProvider with ChangeNotifier {
  GameState _state = GameState.idle;
  int _currentStage = 1;
  int _count = 0;
  int _gold = 50;
  int _life = 10;

  GameState get state => _state;
  int get currentStage => _currentStage;
  int get count => _count;
  int get gold => _gold;
  int get life => _life;

  void updateCount(int change) {
    _count += change;
    notifyListeners();
  }

  void updateGold(int change) {
    _gold += change;
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

  void waving() {
    _state = GameState.waving;
    notifyListeners();
  }

  void endGame() {
    _state = GameState.ended;
    notifyListeners();
  }

  void init() {
    _state = GameState.idle;
    _currentStage = 1;
    _count = 0;
    _gold = 50;
    _life = 10;
    notifyListeners();
  }
}

class DefenderStateProvider with ChangeNotifier {
  DefenderStateProvider() {
    init();
  }

  final Map<DefenderType, int> _defenderCounts = {};

  void addDefender(DefenderType type) {
    _defenderCounts[type] = (_defenderCounts[type] ?? 0) + 1;
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

  DefenderType? _selectedDefender;

  void setSelectedDefender(DefenderType? type) {
    _selectedDefender = type;
    notifyListeners();
  }

  DefenderType? get selectedDefender => _selectedDefender;

  List<DefenderType> availableDefenders = [];

  DefenderType pickRandomDefender() {
    Random random = Random();
    return DefenderType.values[random.nextInt(DefenderType.values.length)];
  }

  List<DefenderType> pickRandomDefenders(int count) {
    Random random = Random();
    return List.generate(
        count,
        (index) =>
            DefenderType.values[random.nextInt(DefenderType.values.length)]);
  }

  void shuffleDefenders() {
    availableDefenders = pickRandomDefenders(3);
    availableDefenders.shuffle();
    availableDefenders = availableDefenders.take(3).toList();
    notifyListeners();
  }

  void replaceDefenderAfterPlacement(int index) {
    if (index < availableDefenders.length) {
      availableDefenders[index] = pickRandomDefender();
      notifyListeners();
    }
  }

  int? _selectedDefenderIndex;

  void setSelectedDefenderIndex(int index) {
    _selectedDefenderIndex = index;
    notifyListeners();
  }

  int? get selectedDefenderIndex => _selectedDefenderIndex;

  void init() {
    shuffleDefenders();
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
