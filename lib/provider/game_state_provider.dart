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

  void init() {
    _state = GameState.idle;
    _currentStage = 1;
    _count = 0;
    _gold = 265;
    _life = 20;
    notifyListeners();
  }

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
    if (_life < 0) {
      _life = 0;
    }
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
}
