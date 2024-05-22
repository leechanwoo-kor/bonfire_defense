import 'dart:async';
import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class Projectile extends GameDecoration with Movement {
  final Vector2 target;
  final double damage;
  final VoidCallback onHit;
  @override
  final double speed;
  SpriteAnimation? projectileAnimation;
  StreamSubscription? moveSubscription;

  static const double targetThreshold = 0.5;

  Projectile({
    required super.position,
    required this.target,
    required this.damage,
    required this.onHit,
    required this.speed,
  }) : super(
          size: Vector2.all(16),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));

    double angle = atan2(target.y - position.y, target.x - position.x);

    projectileAnimation = await SpriteAnimation.load(
      'projectile.png',
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(32, 32),
      ),
    );

    if (projectileAnimation != null) {
      add(SpriteAnimationComponent(
        animation: projectileAnimation!,
        size: size,
        angle: angle,
      ));
    }

    moveToTarget();
  }

  void moveToTarget() {
    moveSubscription =
        Stream.periodic(const Duration(milliseconds: 16)).listen((_) {
      Vector2 direction = (target - position).normalized();
      position.add(direction * speed * 0.016);

      if (position.distanceTo(target) < targetThreshold) {
        hit();
      }
    });
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      hit();
    } else {
      super.onCollision(intersectionPoints, other);
    }
  }

  void hit() {
    moveSubscription?.cancel();
    removeFromParent();
    gameRef.add(ExplosionEffect(target.clone()));
    onHit();
  }
}

class ExplosionEffect extends GameDecoration {
  ExplosionEffect(Vector2 position)
      : super(
          position: position,
          size: Vector2.all(32),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final explosionAnimation = await SpriteAnimation.load(
      'effect/explosion.png',
      SpriteAnimationData.sequenced(
        amount: 14,
        stepTime: 0.1,
        textureSize: Vector2(64, 64),
      ),
    );

    await playSpriteAnimationOnce(explosionAnimation, onFinish: () {
      removeFromParent();
    });
  }
}
