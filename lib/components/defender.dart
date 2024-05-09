import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
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
      builder: (context) => DefenderInfoDialog(
        defender: this,
        onClose: () => Navigator.pop(context),
        onSell: () => sellDefender(context),
        onUpgrade: () {},
      ),
    );
  }

  void sellDefender(BuildContext context) {
    int refundAmount =
        DefenderInfo.getInfos().firstWhere((card) => card.type == type).cost ~/
            2;
    gameRef.context.read<GameStateProvider>().updateGold(refundAmount);
    removeFromParent();
    Navigator.pop(context);
  }
}

mixin EndDragInTile on DragGesture {
  @override
  void onEndDrag(GestureEvent event) {
    Vector2 tilePosition = (event.worldPosition / BonfireDefense.tileSize)
      ..floor();
    Vector2 proposedPosition =
        (tilePosition * BonfireDefense.tileSize) - Vector2.all(8);
    Rect proposedRect = Rect.fromLTWH(proposedPosition.x, proposedPosition.y,
        BonfireDefense.tileSize, BonfireDefense.tileSize);

    // 게임 내 모든 PlaceableArea, Defender 가져오기
    Iterable<PlaceableArea> placeableAreas = gameRef.query<PlaceableArea>();
    Iterable<Defender> defenders = gameRef.query<Defender>();

    bool isPlaceable = placeableAreas.any((area) {
      Rect areaRect = Rect.fromLTWH(
          area.position.x, area.position.y, area.size.x, area.size.y);
      return areaRect.overlaps(proposedRect);
    });

    bool hasDefender = defenders.any((defender) {
      Rect defenderRect = Rect.fromLTWH(defender.position.x,
          defender.position.y, defender.size.x, defender.size.y);
      return defender != this && defenderRect.overlaps(proposedRect);
    });

    if (isPlaceable && !hasDefender) {
      position = proposedPosition;
      originalPosition = proposedPosition;
    } else {
      position = originalPosition;
    }

    super.onEndDrag(event);
  }

  Vector2 get originalPosition;
  set originalPosition(Vector2 value);
}
