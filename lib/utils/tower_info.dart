import 'package:bonfire_defense/utils/game_config.dart';

class TowerInfo {
  final String name;
  final String imagePath;
  final double attackDamage;
  final double visionRange;
  final int attackInterval;
  final int cost;
  final TowerType type;
  final String attackType;

  TowerInfo({
    required this.name,
    required this.imagePath,
    required this.attackDamage,
    required this.visionRange,
    required this.attackInterval,
    required this.cost,
    required this.type,
    required this.attackType,
  });

  static TowerInfo getInfo(TowerType type) {
    switch (type) {
      case TowerType.spirit:
        return TowerInfo(
          name: 'Spirit Tower',
          imagePath: 'tower/tower_spirit.png',
          attackDamage: 2,
          visionRange: 16.0 * 5,
          attackInterval: 1250,
          cost: 70,
          type: TowerType.spirit,
          attackType: 'Spirit',
        );
      case TowerType.archer:
        return TowerInfo(
          name: 'Archer Tower',
          imagePath: 'tower/tower_archer.png',
          attackDamage: 5,
          visionRange: 16.0 * 5,
          attackInterval: 1000,
          cost: 70,
          type: TowerType.archer,
          attackType: 'Ranged',
        );
      case TowerType.dwarf:
        return TowerInfo(
          name: 'Dwarf Tower',
          imagePath: 'tower/tower_dwarf.png',
          attackDamage: 12,
          visionRange: 16.0 * 5,
          attackInterval: 1750,
          cost: 125,
          type: TowerType.dwarf,
          attackType: 'Explosive',
        );
      case TowerType.mage:
        return TowerInfo(
          name: 'Mage Tower',
          imagePath: 'tower/tower_mage.png',
          attackDamage: 13,
          visionRange: 16.0 * 5,
          attackInterval: 1500,
          cost: 100,
          type: TowerType.mage,
          attackType: 'Magic',
        );
      default:
        throw Exception('Invalid TowerType');
    }
  }
}
