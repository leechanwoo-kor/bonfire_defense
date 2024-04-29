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
