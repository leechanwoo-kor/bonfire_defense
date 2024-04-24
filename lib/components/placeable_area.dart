import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/widgets/unit_selection_overlay.dart';
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
}
