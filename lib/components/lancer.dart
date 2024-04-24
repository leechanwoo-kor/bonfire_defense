import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/character_spritesheet.dart';

class Lancer extends Defender {
  Lancer({required super.position})
      : super(
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 4,
          animation: CharacterSpritesheet(fileName: 'human-soldier-red.png')
              .getAnimation(),
          initDirection: Direction.down,
          attackInterval: 1000,
        );

  @override
  void performAttack() {
    seeComponentType<Enemy>(
      radiusVision: visionRange,
      observed: (enemies) {
        if (enemies.isNotEmpty) {
          _executeAttack(enemies);
        }
      },
    );
  }

  void _executeAttack(List<Enemy> enemies) {
    final enemyDirection = getComponentDirectionFromMe(enemies.first);
    animation?.playOnceOther(
      'attack-range-${enemyDirection.name}',
      onStart: () => _executeDamage(enemies.first),
    );
  }

  void _executeDamage(Enemy enemy) {
    enemy.receiveDamage(
      AttackFromEnum.PLAYER_OR_ALLY,
      25,
      null,
    );
  }
}
