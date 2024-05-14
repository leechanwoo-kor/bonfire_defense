import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:provider/provider.dart';

class Peon extends Defender {
  int hitsCount = 0;

  Peon({required super.position})
      : super(
          type: DefenderType.peon,
          attackDamage: 1,
          size: Vector2.all(32),
          visionRange: BonfireDefense.tileSize * 20,
          animation: CharacterSpritesheet(fileName: 'orc.png').getAnimation(),
          initDirection: Direction.down,
          attackInterval: 500,
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
      'attack-basic-${enemyDirection.name}',
      onFinish: () => _executeDamage(enemies),
    );
  }

  void _executeDamage(List<Enemy> enemies) {
    for (var enemy in enemies) {
      enemy.receiveDamage(
        AttackFromEnum.PLAYER_OR_ALLY,
        attackDamage,
        null,
      );
      hitsCount++;
      if (hitsCount % 5 == 0) {
        gameRef.context.read<GameStateProvider>().updateGold(1);
      }
    }
  }
}
