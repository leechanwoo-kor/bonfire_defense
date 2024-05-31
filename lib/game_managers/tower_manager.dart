import 'package:bonfire_defense/components/tower/tower.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:provider/provider.dart';

class TowerManager {
  final GameController gameController;

  TowerManager(this.gameController);

  static sellTower(Tower tower) {
    int fee = TowerInfo.getInfo(tower.towerInfo.type).cost ~/ 2;
    tower.gameRef.context.read<GameStateProvider>().updateSpirit(fee);
    tower.removeFromParent();
  }
}
