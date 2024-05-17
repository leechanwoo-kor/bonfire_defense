import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class Archer extends Defender {
  Archer({required super.position})
      : super(
          type: DefenderType.arch,
          attackDamage: 20,
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 4,
          animation: CharacterSpritesheet(fileName: 'human.png').getAnimation(),
          initDirection: Direction.down,
          attackInterval: 1000,
        );

  @override
  void executeAttack(List<Enemy> enemies) {
    final enemyDirection = getComponentDirectionFromMe(enemies.first);
    animation?.playOnceOther(
      'attack-range-${enemyDirection.name}',
      onStart: () => launchProjectile([enemies.first]),
    );
  }
}
