import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/game_controller.dart';

class EndGameSensor extends GameDecoration with Sensor {
  final GameController _gameController;

  int counter = 0;

  EndGameSensor(this._gameController,
      {required super.position, required super.size});
  @override
  void onContact(GameComponent component) {
    if (component is Enemy) {
      counter++;
      component.removeFromParent();
      _gameController.updateStats(countChange: -1, lifeChange: -1);
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
