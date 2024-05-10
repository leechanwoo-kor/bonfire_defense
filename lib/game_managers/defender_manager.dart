import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/components/lancer.dart';
import 'package:bonfire_defense/components/orc_archer.dart';
import 'package:bonfire_defense/components/orc_test.dart';
import 'package:bonfire_defense/components/orc_warrior.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:provider/provider.dart';

class DefenderManager {
  final GameController gameController;

  DefenderManager(this.gameController);

  void addDefender(DefenderInfo info, Vector2? tilePosition) {
    if (tilePosition == null) return;

    Vector2 unitSize = Vector2.all(32.0);
    Vector2 unitPosition = Vector2(
      tilePosition.x + (BonfireDefense.tileSize - unitSize.x) / 2,
      tilePosition.y + (BonfireDefense.tileSize - unitSize.y) / 2,
    );
    GameComponent defender = createDefender(info, unitPosition);
    gameController.gameRef.context
        .read<DefenderStateProvider>()
        .addDefender(info.type);
    gameController.gameRef.add(defender);
  }

  static GameComponent createDefender(DefenderInfo info, Vector2 position) {
    switch (info.type) {
      case DefenderType.arch:
        return Archer(position: position);
      case DefenderType.knight:
        return Knight(position: position);
      case DefenderType.lancer:
        return Lancer(position: position);
      case DefenderType.orcArcher:
        return OrcArcher(position: position);
      case DefenderType.orcWarrior:
        return OrcWarrior(position: position);
      case DefenderType.test:
        return OrcTest(position: position);
      default:
        throw UnimplementedError('Defender type ${info.type} not supported');
    }
  }
}
