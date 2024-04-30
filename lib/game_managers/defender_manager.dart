import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/archer.dart';
import 'package:bonfire_defense/components/knight.dart';
import 'package:bonfire_defense/components/lancer.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:provider/provider.dart';

class DefenderManager {
  final GameController gameController;
  final DefenderStateProvider defenderStateProvider;

  DefenderManager(this.gameController)
      : defenderStateProvider = Provider.of<DefenderStateProvider>(
            gameController.gameRef.context,
            listen: false);

  void addDefender(DefenderType type, Vector2? tilePosition) {
    if (tilePosition == null) return;

    Vector2 unitSize = Vector2.all(32.0);
    Vector2 unitPosition = Vector2(
      tilePosition.x + (BonfireDefense.tileSize - unitSize.x) / 2,
      tilePosition.y + (BonfireDefense.tileSize - unitSize.y) / 2,
    );
    GameComponent defender = createDefender(type, unitPosition);
    gameController.gameRef.add(defender);
    defenderStateProvider.addDefender(type);
  }

  static GameComponent createDefender(DefenderType type, Vector2 position) {
    switch (type) {
      case DefenderType.arch:
        return Archer(position: position);
      case DefenderType.knight:
        return Knight(position: position);
      case DefenderType.lancer:
        return Lancer(position: position);
      default:
        throw UnimplementedError('Defender type $type not supported');
    }
  }
}
