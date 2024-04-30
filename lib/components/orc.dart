import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/util/character_spritesheet.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Orc extends SimpleEnemy with PathFinding, UseLifeBar, HasTimeScale {
  final GameController _gameController;

  static const _speedDefault = GameConfig.defaultSpeed;
  final List<Vector2> path;

  Orc(
    this._gameController, {
    required super.position,
    required this.path,
  }) : super(
          size: Vector2.all(32),
          speed: _speedDefault,
          life: 100 +
              (Provider.of<GameStateProvider>(_gameController.gameRef.context,
                              listen: false)
                          .currentStage -
                      1) *
                  10,
          animation: CharacterSpritesheet(fileName: 'orc.png').getAnimation(),
        ) {
    setupPathFinding(
      linePathEnabled: false,
    );
    setupLifeBar(
      barLifeDrawPosition: BarLifeDrawPorition.bottom,
      showLifeText: false,
      borderRadius: BorderRadius.circular(20),
      size: Vector2(16, 4),
      offset: Vector2(0, -2.5),
    );
    movementOnlyVisible = false;
  }

  @override
  void onMount() {
    moveAlongThePath(path);
    super.onMount();
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2.all(16),
        isSolid: true,
        position: size / 4,
      ),
    );
    return super.onLoad();
  }

  @override
  void die() {
    GameStateProvider state = Provider.of<GameStateProvider>(
      _gameController.context,
      listen: false,
    );
    removeFromParent();
    state.updateCount(-1);
    state.updateScore(1);
    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    timeScale = 0.5;
    animation?.playOnceOther(
      'hurt-${lastDirection.name}',
      runToTheEnd: true,
      onFinish: () {
        timeScale = 1.0;
      },
    );
    super.receiveDamage(attacker, damage, identify);
  }
}
