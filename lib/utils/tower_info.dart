import 'package:bonfire_defense/utils/game_config.dart';

class TowerInfo {
  final TowerType type;
  final String name;
  final String attackType;
  final String attackDamage;
  final int cost;
  final String imagePath;

  TowerInfo({
    required this.type,
    required this.name,
    required this.attackType,
    required this.attackDamage,
    required this.cost,
    this.imagePath = 'tower/tile000.png',
  });

  static final Map<TowerType, TowerInfo> _infoMap = {
    TowerType.archer: TowerInfo(
      name: 'Archer Tower',
      type: TowerType.archer,
      attackType: '빠름',
      attackDamage: '5',
      cost: 70,
      imagePath: 'tower/tile000.png',
    ),
    TowerType.barrack: TowerInfo(
      name: 'Barrack',
      type: TowerType.barrack,
      attackType: '보통',
      attackDamage: '2',
      cost: 70,
      imagePath: 'tower/tile000.png',
    ),
    TowerType.dwarf: TowerInfo(
      name: 'Dwarf Tower',
      type: TowerType.dwarf,
      attackType: '매우 느림',
      attackDamage: '12',
      cost: 125,
      imagePath: 'tower/tile000.png',
    ),
    TowerType.mage: TowerInfo(
      name: 'Mage Tower',
      type: TowerType.mage,
      attackType: '느림',
      attackDamage: '13',
      cost: 100,
      imagePath: 'tower/tile000.png',
    ),
  };

  static TowerInfo getInfo(TowerType type) {
    return _infoMap[type]!;
  }

  static List<TowerInfo> getInfos() {
    return _infoMap.values.toList();
  }
}
