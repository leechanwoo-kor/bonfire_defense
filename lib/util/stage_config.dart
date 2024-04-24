import 'package:bonfire/bonfire.dart';

class StageConfig {
  final String tiledMapPath;
  final List<Vector2> enemyPath;
  final Vector2 enemyInitialPosition;
  final List<EnemyType> enemies;
  final int countEnemyPermited;

  final int tilesInWidth;
  final int tilesInHeight;

  StageConfig({
    required this.tiledMapPath,
    required this.enemyPath,
    required this.enemyInitialPosition,
    required this.enemies,
    this.countEnemyPermited = 1,
    required this.tilesInWidth,
    required this.tilesInHeight,
  });
}

enum EnemyType { orc }

enum DefenderType { arch, knight, lancer }
