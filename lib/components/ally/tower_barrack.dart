import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class TowerBarrack extends Tower {
  TowerBarrack(Vector2 position)
      : super(
          position: position - Vector2(4, 30),
          type: TowerType.archer,
          attackDamage: 2,
          size: Vector2(24, 48),
          visionRange: BonfireDefense.tileSize * 5,
          attackInterval: 1250,
          imagePath: 'tower/tower_barrack.png',
        );

  @override
  void executeAttack(List<Enemy> enemies) {
    launchProjectile(enemies);
    // final enemyDirection = getComponentDirectionFromMe(enemies.first);
    // animation?.playOnceOther(
    //   'attack-range-${enemyDirection.name}',
    //   onStart: () => launchProjectile([enemies.first]),
    // );
  }
}
