import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/archer.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/components/ally/peon.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/components/ally/knight.dart';
import 'package:bonfire_defense/components/ally/lancer.dart';
import 'package:bonfire_defense/components/ally/orc_archer.dart';
import 'package:bonfire_defense/components/ally/orc_test.dart';
import 'package:bonfire_defense/components/ally/orc_warrior.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefenderManager {
  final GameController gameController;

  DefenderManager(this.gameController);

  void addDefender(DefenderInfo info, Vector2? tilePosition) {
    if (tilePosition == null) return;

    Vector2 unitSize = Vector2.all(32.0);
    Vector2 unitPosition = Vector2(
      tilePosition.x + (BonfireDefense.tileSize - unitSize.x) / 2,
      tilePosition.y + (BonfireDefense.tileSize - unitSize.y) / 2,
    );
    GameComponent defender = createDefender(info, unitPosition);
    gameController.gameRef.context
        .read<DefenderStateProvider>()
        .addDefender(info.type);
    gameController.gameRef.add(defender);
  }

  static GameComponent createDefender(DefenderInfo info, Vector2 position) {
    switch (info.type) {
      case DefenderType.arch:
        return Archer(position: position);
      case DefenderType.knight:
        return Knight(position: position);
      case DefenderType.lancer:
        return Lancer(position: position);
      case DefenderType.orcArcher:
        return OrcArcher(position: position);
      case DefenderType.orcWarrior:
        return OrcWarrior(position: position);
      case DefenderType.test:
        return OrcTest(position: position);
      case DefenderType.peon:
        return Peon(position: position);
      default:
        throw UnimplementedError('Defender type ${info.type} not supported');
    }
  }

  static void sellDefender(Defender defender) {
    int refundAmount = DefenderInfo.getInfo(defender.type).cost ~/ 2;
    defender.gameRef.context.read<GameStateProvider>().updateGold(refundAmount);
    defender.removeFromParent();
    Navigator.pop(defender.gameRef.context);
  }

  static void mergeDefender(Defender defender) {
    List<Defender> sameTypeDefenders = defender.gameRef
        .query()
        .whereType<Defender>()
        .where((d) => d.type == defender.type && d != defender)
        .toList();

    if (sameTypeDefenders.isNotEmpty) {
      // 머지 유닛 제거
      final randomDefender =
          sameTypeDefenders[Random().nextInt(sameTypeDefenders.length)];
      randomDefender.removeFromParent();
      defender.removeFromParent();

      defender.gameRef.context
          .read<DefenderStateProvider>()
          .decrementDefenderCount(defender.type, 2);

      // 머지 유닛 생성
      Vector2 mergePosition = defender.position.clone();
      defender.gameRef.context.read<GameStateProvider>().updateGold(-50);
      createUpgradedDefender(mergePosition, defender);
    }
    Navigator.pop(defender.gameRef.context);
  }

  static createUpgradedDefender(Vector2 position, Defender defender) {
    DefenderInfo upgradedInfo = DefenderInfo.getInfo(DefenderType.test);
    GameComponent upgradedDefender =
        DefenderManager.createDefender(upgradedInfo, position);
    defender.gameRef.add(upgradedDefender);
    defender.gameRef.context
        .read<DefenderStateProvider>()
        .addDefender(upgradedInfo.type);
  }
}
