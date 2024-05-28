import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';

enum GameStageEnum { main, main2 }

abstract class GameStages {
  static GameConfig get(GameStageEnum stage) => _stages[stage]!;

  static final Map<GameStageEnum, GameConfig> _stages = {
    GameStageEnum.main: GameConfig(
      tilesInHeight: 12,
      tilesInWidth: 20,
      tiledMapPath: 'map/main.tmj',
      enemies: [
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
      ],
      enemyInitialPosition: Vector2(
        6 * BonfireDefense.tileSize,
        -1 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          14 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          14 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          0 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
    GameStageEnum.main2: GameConfig(
      tilesInHeight: 40,
      tilesInWidth: 40,
      tiledMapPath: 'map/main2.tmj',
      enemies: [
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
        EnemyType.skeleton,
      ],
      enemyInitialPosition: Vector2(
        6 * BonfireDefense.tileSize,
        -1 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          14 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          14 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          10 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          0 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
  };
}
