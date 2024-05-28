import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';

class ArcherTower extends Tower {
  ArcherTower(Vector2 position)
      : super(
          position: position + Vector2(0, -16),
          type: TowerType.archer,
          attackDamage: 20,
          size: Vector2(16, 32),
          visionRange: BonfireDefense.tileSize * 4,
          attackInterval: 1000,
          imagePath: 'tower/tower.png',
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
