import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class OrcArcher extends Defender {
  OrcArcher({required super.position})
      : super(
          type: DefenderType.orcArcher,
          attackDamage: 30,
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 5,
          animation:
              CharacterSpritesheet(fileName: 'orc-red.png').getAnimation(),
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
