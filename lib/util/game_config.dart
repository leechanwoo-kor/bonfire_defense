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

enum DefenderType { arch, knight, lancer }
