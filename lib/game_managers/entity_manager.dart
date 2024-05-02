import 'package:bonfire_defense/game_managers/game_controller.dart';

abstract class EntityManager {
  final GameController gameController;

  EntityManager(this.gameController);

  bool canAddEntity();

  void addEntity();
}
