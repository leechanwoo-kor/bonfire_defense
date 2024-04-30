import 'package:bonfire_defense/game_managers/game_controller.dart';

abstract class EntityManager {
  final GameController gameController;
  double _timer = 0;

  EntityManager(this.gameController);

  void update(double dt) {
    _timer += dt * 1000; // 시간 업데이트
    if (_timer >= 1000) {
      if (canAddEntity()) {
        addEntity();
        _timer = 0;
      }
    }
  }

  bool canAddEntity();

  void addEntity();
}
