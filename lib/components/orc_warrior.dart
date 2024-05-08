import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/character_spritesheet.dart';

class OrcWarrior extends Defender {
  OrcWarrior({required super.position})
      : super(
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 3,
          animation: CharacterSpritesheet(fileName: 'orc.png').getAnimation(),
          initDirection: Direction.down,
          attackInterval: 2000,
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
      'attack-meele-${enemyDirection.name}',
      onFinish: () => _executeDamage(enemies),
    );
  }

  void _executeDamage(List<Enemy> enemies) {
    for (var enemy in enemies) {
      enemy.receiveDamage(
        AttackFromEnum.PLAYER_OR_ALLY,
        30,
        null,
      );
    }
  }
}
