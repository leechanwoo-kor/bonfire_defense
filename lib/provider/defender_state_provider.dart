import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:flutter/material.dart';

class DefenderStateProvider with ChangeNotifier {
  DefenderStateProvider() {
    init();
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
    _placementPosition = null;
    notifyListeners();
  }

  DefenderInfo info(DefenderType type) {
    return DefenderInfo.getInfos().firstWhere((card) => card.type == type);
  }
}
