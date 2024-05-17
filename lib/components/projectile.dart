import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class Projectile extends GameDecoration with Movement {
  final Vector2 target;
  final double damage;
  final VoidCallback onHit;
  @override
  final double speed;
  SpriteAnimation? projectileAnimation;

  static const double targetThreshold = 0.1;

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
  void update(double dt) {
    super.update(dt);

    Vector2 direction = (target - position).normalized();
    position.add(direction * speed * dt);

    if (position.distanceTo(target) < targetThreshold) {
      hit();
    }
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
    if (!isRemoved) {
      removeFromParent();
    }
    gameRef.add(ExplosionEffect(target.clone()));
    onHit();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));

    // Load the animation for the projectile
    projectileAnimation = await SpriteAnimation.load(
      'projectile.png', // Path to the projectile sprite sheet
      SpriteAnimationData.sequenced(
        amount: 5, // Number of frames in the projectile sprite sheet
        stepTime: 0.1, // Duration of each frame
        textureSize: Vector2(32, 32), // Size of each frame
      ),
    );

    if (projectileAnimation != null) {
      add(SpriteAnimationComponent(
        animation: projectileAnimation!,
        size: size,
      ));
    }
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
