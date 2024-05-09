import 'package:bonfire_defense/utils/game_config.dart';

class DefenderCard {
  final DefenderType type;
  final String name;
  final String attackType;
  final String imagePath;
  final int cost;

  DefenderCard({
    required this.type,
    required this.name,
    required this.attackType,
    required this.imagePath,
    required this.cost,
  });

  static List<DefenderCard> getCards() {
    return [
      DefenderCard(
        name: '궁수',
        type: DefenderType.arch,
        attackType: 'speed',
        imagePath: 'assets/images/arch.png',
        cost: 20,
      ),
      DefenderCard(
        name: '기사',
        type: DefenderType.knight,
        attackType: 'splash',
        imagePath: 'assets/images/knight.png',
        cost: 30,
      ),
      DefenderCard(
        name: '창병',
        type: DefenderType.lancer,
        attackType: 'power',
        imagePath: 'assets/images/lancer.png',
        cost: 50,
      ),
      DefenderCard(
        name: '오크 궁수',
        type: DefenderType.orcArcher,
        attackType: 'speed',
        imagePath: 'assets/images/arch.png',
        cost: 20,
      ),
      DefenderCard(
        name: '오크 전사',
        type: DefenderType.orcWarrior,
        attackType: 'splash',
        imagePath: 'assets/images/knight.png',
        cost: 30,
      ),
    ];
  }
}
