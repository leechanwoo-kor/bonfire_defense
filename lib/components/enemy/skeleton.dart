import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/character_spritesheet.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:flutter/widgets.dart';

class Skeleton extends SimpleEnemy with PathFinding, UseLifeBar, HasTimeScale {
  final void Function(Skeleton) onDeath;

  static const _speedDefault = GameConfig.defaultSpeed;
  final List<Vector2> path;

  Skeleton({
    required this.onDeath,
    required super.position,
    required this.path,
    required super.life,
  }) : super(
            size: Vector2.all(24),
            speed: _speedDefault,
            animation:
                CharacterSpritesheet(fileName: 'skeleton.png').getAnimation()) {
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
    if (!isRemoved) {
      super.die();
      onDeath(this);
      removeFromParent();
    }
  }
}
