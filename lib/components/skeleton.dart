import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/util/character_spritesheet.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:flutter/widgets.dart';

class Skeleton extends SimpleEnemy with PathFinding, UseLifeBar, HasTimeScale {
  final void Function(Skeleton) onDeath;

  static const _speedDefault = GameConfig.defaultSpeed;
  final List<Vector2> path;

  Skeleton({
    required this.onDeath,
    required super.position,
    required this.path,
    required int life,
  }) : super(
          size: Vector2.all(24),
          speed: _speedDefault,
          animation:
              CharacterSpritesheet(fileName: 'skeleton.png').getAnimation(),
        ) {
    setupPathFinding(
      linePathEnabled: false,
    );
    setupLifeBar(
      barLifeDrawPosition: BarLifeDrawPorition.bottom,
      showLifeText: false,
      borderRadius: BorderRadius.circular(20),
      size: Vector2(16, 4),
      offset: Vector2(0, 0),
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
    super.die();
    onDeath(this);
    removeFromParent();
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
