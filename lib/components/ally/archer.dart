import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/projectile.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
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
      onStart: () => _launchProjectile(enemy),
    );
  }

  void _launchProjectile(Enemy enemy) {
    final projectile = Projectile(
      position: position.clone(),
      target: enemy.position,
      damage: attackDamage,
      speed: 150,
      onHit: () {
        _executeDamage(enemy);
      },
    );
    gameRef.add(projectile);
  }

  void _executeDamage(Enemy enemy) {
    enemy.receiveDamage(
      AttackFromEnum.PLAYER_OR_ALLY,
      attackDamage,
      null,
    );
  }
}
