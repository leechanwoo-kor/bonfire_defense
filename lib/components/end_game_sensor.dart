import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/stats_provider.dart';
import 'package:provider/provider.dart';

class EndGameSensor extends GameDecoration with Sensor {
  final GameController _gameController;

  int counter = 0;

  EndGameSensor(this._gameController,
      {required super.position, required super.size});
  @override
  void onContact(GameComponent component) {
    StatsProvider stats = Provider.of<StatsProvider>(
        _gameController.gameRef.context,
        listen: false);

    if (component is Enemy) {
      counter++;
      component.removeFromParent();
      stats.updateCount(-1);
      stats.updateLife(-1);
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
