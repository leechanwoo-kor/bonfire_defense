import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender_info.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/widgets/defender_detail_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class Defender extends SimpleAlly with TapGesture {
  final int attackInterval;
  final double visionRange;
  final DefenderType type;
  final double attackDamage;
  double lastAttackTime = 0;
  Vector2 originalPosition = Vector2.zero();

  Defender({
    required this.type,
    required this.attackDamage,
    required super.position,
    required super.size,
    required this.attackInterval,
    required this.visionRange,
    super.animation,
    super.initDirection,
  }) {
    originalPosition = position.clone();
  }

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

  @override
  void onTap() {
    try {
      showDialog(
        context: gameRef.context,
        builder: (context) {
          final defenderInfo = DefenderInfo.getInfo(type);
          return DefenderInfoDialog(
            defender: this,
            defenderInfo: defenderInfo,
            onClose: () => Navigator.pop(context),
            onSell: () => sellDefender(context),
            onMerge: () {},
          );
        },
      );
    } catch (e) {
      print('Failed to fetch defender info: $e');
    }
  }

  void sellDefender(BuildContext context) {
    int refundAmount = DefenderInfo.getInfo(type).cost ~/ 2;
    gameRef.context.read<GameStateProvider>().updateGold(refundAmount);
    removeFromParent();
    Navigator.pop(context);
  }
}
