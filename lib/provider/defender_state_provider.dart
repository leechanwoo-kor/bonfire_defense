import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:flutter/material.dart';

class DefenderStateProvider with ChangeNotifier {
  final Random _random = Random();
  // static final List<DefenderInfo> _defenderList = DefenderInfo.getInfos();
  static final List<DefenderInfo> _defenderList = DefenderInfo.getInfos()
      .where((info) => info.type != DefenderType.test)
      .toList();

  DefenderStateProvider() {
    init();
  }

  Vector2? _placementPosition;
  Vector2? get placementPosition => _placementPosition;

  void setPlacementPosition(Vector2? position) {
    _placementPosition = position;
    notifyListeners();
  }

  DefenderInfo? _selectedDefender;

  void setSelectedDefender(DefenderInfo? type) {
    _selectedDefender = type;
    notifyListeners();
  }

  DefenderInfo? get selectedDefender => _selectedDefender;

  List<DefenderInfo> availableDefenders = [];

  DefenderInfo pickRandomDefender() {
    return _defenderList[_random.nextInt(_defenderList.length)];
  }

  List<DefenderInfo> pickRandomDefenders(int count) {
    return List.generate(
        count, (index) => _defenderList[_random.nextInt(_defenderList.length)]);
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
    defenderCount.clear();
    notifyListeners();
  }

  DefenderInfo info(DefenderType type) {
    return DefenderInfo.getInfo(type);
  }

  Map<DefenderType, int> defenderCount = {};

  void addDefender(DefenderType type) {
    if (defenderCount.containsKey(type)) {
      defenderCount[type] = defenderCount[type]! + 1;
    } else {
      defenderCount[type] = 1;
    }
    notifyListeners();
  }

  void decrementDefenderCount(DefenderType type) {
    if (defenderCount[type] != null && defenderCount[type]! > 0) {
      defenderCount[type] = defenderCount[type]! - 1;
      notifyListeners();
    }
  }

  bool canMerge(DefenderType type) {
    print("Defender count(${type}): ${defenderCount[type]}");
    return defenderCount[type] != null && defenderCount[type]! >= 2;
  }
}
