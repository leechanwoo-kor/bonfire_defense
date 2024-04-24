import 'package:bonfire/bonfire.dart';

abstract class Defender extends SimpleAlly {
  final int attackInterval;
  final double visionRange;
  double lastAttackTime = 0;

  Defender({
    required super.position,
    required super.size,
    required this.attackInterval,
    required this.visionRange,
    super.animation,
    super.initDirection,
  });

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldAttack(dt)) {
      performAttack();
    }
  }

  bool shouldAttack(double dt) {
    lastAttackTime += dt * 1000;
    if (lastAttackTime >= attackInterval) {
      lastAttackTime = 0;
      return true;
    }
    return false;
  }

  void performAttack();
}
