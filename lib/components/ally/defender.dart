import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
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
    showDialog(
      context: gameRef.context,
      builder: (context) {
        final defenderInfo = DefenderInfo.getInfo(type);
        bool canMerge =
            (gameRef.context.read<DefenderStateProvider>().canMerge(type)) &&
                (gameRef.context.read<GameStateProvider>().gold >= 100) &&
                (defenderInfo.type != DefenderType.test); // TODO test 코드 제거
        return DefenderInfoDialog(
          defender: this,
          defenderInfo: defenderInfo,
          onClose: () => Navigator.pop(context),
          onSell: () => DefenderManager.sellDefender(this),
          onMerge: canMerge ? () => DefenderManager.mergeDefender(this) : null,
        );
      },
    );
  }
}