import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class Lancer extends Defender {
  Lancer({required super.position})
      : super(
          type: DefenderType.lancer,
          attackDamage: 100,
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 3,
          animation: CharacterSpritesheet(fileName: 'human.png').getAnimation(),
          initDirection: Direction.down,
          attackInterval: 1400,
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
