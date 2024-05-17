import 'package:bonfire/bonfire.dart';
import 'package:flutter/widgets.dart';

class Projectile extends GameDecoration with Movement {
  final Vector2 target;
  final double damage;
  final VoidCallback onHit;
  @override
  final double speed;

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

    if (position.distanceTo(target) < 2) {
      onHit();
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Enemy) {
      other.receiveDamage(AttackFromEnum.PLAYER_OR_ALLY, damage, null);
      onHit();
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: size));

    sprite = await Sprite.load('peon.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
