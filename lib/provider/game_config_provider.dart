import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/material.dart';

class GameConfigProvider extends ChangeNotifier {
  final GameConfig _currentConfig;

  GameConfigProvider(this._currentConfig);

  GameConfig get currentConfig => _currentConfig;
}
