import 'package:bonfire/bonfire.dart';

class GameConfig {
  static const double defaultSpeed = 50.0;
  final String tiledMapPath;
  final List<Vector2> enemyPath;
  final Vector2 enemyInitialPosition;
  final List<EnemyType> enemies;

  final int tilesInWidth;
  final int tilesInHeight;

  GameConfig({
    required this.tiledMapPath,
    required this.enemyPath,
    required this.enemyInitialPosition,
    required this.enemies,
    required this.tilesInWidth,
    required this.tilesInHeight,
  });
}

enum EnemyType { orc, skeleton }

enum DefenderType { arch, knight, lancer, orcArcher, orcWarrior }

const Map<DefenderType, int> defenderCosts = {
  DefenderType.arch: 20,
  DefenderType.knight: 30,
  DefenderType.lancer: 50,
  DefenderType.orcArcher: 20,
  DefenderType.orcWarrior: 30,
};

const Map<DefenderType, String> defenderNames = {
  DefenderType.arch: "궁수",
  DefenderType.knight: "기사",
  DefenderType.lancer: "창병",
  DefenderType.orcArcher: "오크 궁수",
  DefenderType.orcWarrior: "오크 전사",
};
