import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';

class TowerDwarf extends Tower {
  TowerDwarf(Vector2 position)
      : super(
          towerInfo: TowerInfo.getInfo(TowerType.dwarf),
          position: position - Vector2(4, 30),
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
