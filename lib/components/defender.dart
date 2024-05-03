import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/placeable_area.dart';
import 'package:bonfire_defense/screens/game.dart';

abstract class Defender extends SimpleAlly with DragGesture, EndDragInTile {
  final int attackInterval;
  final double visionRange;
  double lastAttackTime = 0;
  Vector2 originalPosition = Vector2.zero();

  Defender({
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

    // 게임 내 모든 PlaceableArea 가져오기
    Iterable<PlaceableArea> placeableAreas = gameRef.query<PlaceableArea>();

    bool isPlaceable = placeableAreas.any((area) {
      Rect areaRect = Rect.fromLTWH(
          area.position.x, area.position.y, area.size.x, area.size.y);
      return areaRect.overlaps(proposedRect);
    });

    if (isPlaceable) {
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
