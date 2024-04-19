import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/pages/game/game.dart';
import 'package:bonfire_defense/util/stage_config.dart';

enum GameStageEnum { test1, test2, tower_defense }

abstract class GameStages {
  static StageConfig get(GameStageEnum stage) => _stages[stage]!;

  static final Map<GameStageEnum, StageConfig> _stages = {
    GameStageEnum.test1: StageConfig(
      tiledMapPath: 'map/map.tmj',
      enemies: [
        EnemyType.orc,
        EnemyType.orc,
      ],
      defenders: [
        DefenderType.arch,
      ],
      enemyIntialPosition: Vector2(
        -1 * BonfireDefense.tileSize,
        7 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          12 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          12 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          20 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
    GameStageEnum.test2: StageConfig(
      tiledMapPath: 'map/map2.tmj',
      enemies: [
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
      ],
      defenders: [
        DefenderType.arch,
        DefenderType.knight,
      ],
      enemyIntialPosition: Vector2(
        -1 * BonfireDefense.tileSize,
        2 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          4 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          4 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          8 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          7 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          8 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          12 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          12 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          20 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
    GameStageEnum.tower_defense: StageConfig(
      tiledMapPath: 'map/map3.tmj',
      enemies: [
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
      ],
      defenders: [
        DefenderType.arch,
        DefenderType.knight,
      ],
      enemyIntialPosition: Vector2(
        9 * BonfireDefense.tileSize,
        -1 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          8 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          8 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          15 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          15 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          3 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          11 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          -1 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
  };
}
