import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:provider/provider.dart';

class EndGameSensor extends GameDecoration with Sensor {
  final GameController _gameController;

  int counter = 0;

  EndGameSensor(this._gameController,
      {required super.position, required super.size});
  @override
  void onContact(GameComponent component) {
    GameStateProvider state = Provider.of<GameStateProvider>(
      _gameController.context,
      listen: false,
    );

    if (component is Enemy) {
      counter++;
      component.removeFromParent();
      state.updateCount(-1);
      state.updateLife(-1);
    }
    super.onContact(component);
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(size: size),
    );
    return super.onLoad();
  }
}
