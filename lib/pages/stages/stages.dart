import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/pages/game/game.dart';
import 'package:bonfire_defense/util/stage_config.dart';

enum GameStageEnum { test1, test2, towerDefense, main }

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
      enemyInitialPosition: Vector2(
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
      enemyInitialPosition: Vector2(
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
    GameStageEnum.towerDefense: StageConfig(
      tiledMapPath: 'map/map3.tmj',
      enemies: [
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
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
      enemyInitialPosition: Vector2(
        9 * BonfireDefense.tileSize,
        -1 * BonfireDefense.tileSize,
      ),
      enemyPath: [
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          5 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          13 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          9 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          13 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          17 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          6 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          17 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          13 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          2 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
        Vector2(
          13 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
          -1 * BonfireDefense.tileSize + BonfireDefense.tileSize / 2,
        ),
      ],
    ),
    GameStageEnum.main: StageConfig(
      tiledMapPath: 'map/main.tmj',
      enemies: [
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
        EnemyType.orc,
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
