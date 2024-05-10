import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/game_managers/defender_manager.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
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
          bool canMerge =
              gameRef.context.read<DefenderStateProvider>().canMerge(type);
          return DefenderInfoDialog(
            defender: this,
            defenderInfo: defenderInfo,
            onClose: () => Navigator.pop(context),
            onSell: () => sellDefender(context),
            onMerge: canMerge ? () => mergeDefender(context) : null,
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

  void mergeDefender(BuildContext context) {
    List<Defender> sameTypeDefenders = gameRef
        .query()
        .whereType<Defender>()
        .where((d) => d.type == type && d != this)
        .toList();

    if (sameTypeDefenders.isNotEmpty) {
      // 머지 유닛 제거
      final randomDefender =
          sameTypeDefenders[Random().nextInt(sameTypeDefenders.length)];
      randomDefender.removeFromParent();
      removeFromParent();

      gameRef.context
          .read<DefenderStateProvider>()
          .decrementDefenderCount(type, 2);

      // 머지 유닛 생성
      Vector2 mergePosition = position.clone();
      gameRef.context.read<GameStateProvider>().updateGold(-100);
      createUpgradedDefender(mergePosition, context);
    }
    Navigator.pop(context);
  }

  void createUpgradedDefender(Vector2 position, BuildContext context) {
    DefenderInfo upgradedInfo = DefenderInfo.getInfo(DefenderType.test);
    GameComponent upgradedDefender =
        DefenderManager.createDefender(upgradedInfo, position);
    gameRef.add(upgradedDefender);
    gameRef.context
        .read<DefenderStateProvider>()
        .addDefender(upgradedInfo.type);
  }
}
