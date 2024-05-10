import 'package:bonfire_defense/utils/game_config.dart';

class DefenderInfo {
  final DefenderType type;
  final String name;
  final String attackType;
  final String imagePath;
  final int cost;

  DefenderInfo({
    required this.type,
    required this.name,
    required this.attackType,
    required this.imagePath,
    required this.cost,
  });

  static final Map<DefenderType, DefenderInfo> _infoMap = {
    DefenderType.arch: DefenderInfo(
      name: '[인간]\n궁수',
      type: DefenderType.arch,
      attackType: 'speed',
      imagePath: 'assets/images/arch.png',
      cost: 20,
    ),
    DefenderType.knight: DefenderInfo(
      name: '[인간]\n검사',
      type: DefenderType.knight,
      attackType: 'splash',
      imagePath: 'assets/images/knight.png',
      cost: 30,
    ),
    DefenderType.lancer: DefenderInfo(
      name: '[인간]\n창병',
      type: DefenderType.lancer,
      attackType: 'power',
      imagePath: 'assets/images/lancer.png',
      cost: 50,
    ),
    DefenderType.orcArcher: DefenderInfo(
      name: '[오크]\n궁수',
      type: DefenderType.orcArcher,
      attackType: 'speed',
      imagePath: 'assets/images/arch.png',
      cost: 20,
    ),
    DefenderType.orcWarrior: DefenderInfo(
      name: '[오크]\n전사',
      type: DefenderType.orcWarrior,
      attackType: 'splash',
      imagePath: 'assets/images/knight.png',
      cost: 30,
    ),
    DefenderType.test: DefenderInfo(
      name: '테스트\n용병',
      type: DefenderType.test,
      attackType: 'power',
      imagePath: 'assets/images/lancer.png',
      cost: 50,
    ),
  };

  static DefenderInfo getInfo(DefenderType type) {
    return _infoMap[type]!;
  }

  static List<DefenderInfo> getInfos() {
    return _infoMap.values.toList();
  }
}
