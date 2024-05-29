import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/tower/tower.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';

class TowerArcher extends Tower {
  TowerArcher(Vector2 position)
      : super(
          towerInfo: TowerInfo.getInfo(TowerType.archer),
          position: position - Vector2(4, 30),
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
