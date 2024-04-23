import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/game_controller.dart';
import 'package:bonfire_defense/widgets/unit_selection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceableArea extends GameDecoration with TapGesture {
  final bool placeable;

  PlaceableArea({
    required super.position,
    required super.size,
    this.placeable = true,
  });

  @override
  void onTap() {
    if (placeable) {
      final gameController = gameRef.context.read<GameController>();
      bool isActive =
          gameController.isOverlayActive(UnitSelectionOverlay.overlayName);
      gameController.setOverlayActive(
          UnitSelectionOverlay.overlayName, !isActive);
    } else {
      print("Error: Placement area is not placeable.");
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (placeable) {
      final rect = Rect.fromLTWH(
        position.x,
        position.y,
        size.x,
        size.y,
      );
      canvas.drawRect(
        rect,
        Paint()..color = Colors.green.withOpacity(0.5),
      );
    }
  }
}
