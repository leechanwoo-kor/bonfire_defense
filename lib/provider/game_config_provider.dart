import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

class GameConfigProvider extends ChangeNotifier {
  GameConfig _currentConfig;

  GameConfigProvider(this._currentConfig);

  GameConfig get currentConfig => _currentConfig;

  void updateGameConfig(GameConfig newConfig) {
    _currentConfig = newConfig;
    notifyListeners();
  }
}
