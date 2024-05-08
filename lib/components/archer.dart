import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/character_spritesheet.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/util/game_config.dart';

class Archer extends Defender {
  Archer({required super.position})
      : super(
          type: DefenderType.arch,
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 5,
          animation:
              CharacterSpritesheet(fileName: 'archer.png').getAnimation(),
          initDirection: Direction.down,
          attackInterval: 1000,
        );

  @override
  void performAttack() {
    seeComponentType<Enemy>(
      radiusVision: visionRange,
      observed: (enemies) {
        if (enemies.isNotEmpty) {
          _executeAttack(enemies.first);
        }
      },
    );
  }

  void _executeAttack(Enemy enemy) {
    final enemyDirection = getComponentDirectionFromMe(enemy);
    animation?.playOnceOther(
      'attack-range-${enemyDirection.name}',
      onStart: () => _executeDamage(enemy),
    );
  }

  void _executeDamage(Enemy enemy) {
    enemy.receiveDamage(
      AttackFromEnum.PLAYER_OR_ALLY,
      20,
      null,
    );
  }
}
