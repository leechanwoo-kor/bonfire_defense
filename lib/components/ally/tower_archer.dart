import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class TowerArcher extends Tower {
  TowerArcher(Vector2 position)
      : super(
          position: position + Vector2(0, -16),
          type: TowerType.archer,
          attackDamage: 5,
          size: Vector2(16, 32),
          visionRange: BonfireDefense.tileSize * 10,
          attackInterval: 1000,
          imagePath: 'tower/tower_archer.png',
        );

  @override
  void executeAttack(List<Enemy> enemies) {
    launchProjectile([enemies.first]);
    // final enemyDirection = getComponentDirectionFromMe(enemies.first);
    // animation?.playOnceOther(
    //   'attack-range-${enemyDirection.name}',
    //   onStart: () => launchProjectile([enemies.first]),
    // );
  }
}
