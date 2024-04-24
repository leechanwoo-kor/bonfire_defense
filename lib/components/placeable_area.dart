import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/util/game_config.dart';
import 'package:bonfire_defense/widgets/unit_selection_overlay.dart';
import 'package:provider/provider.dart';

class PlaceableArea extends GameDecoration with TapGesture {
  PlaceableArea({
    required super.position,
    required super.size,
  });

  @override
  void onTap() {
    final gameController = gameRef.context.read<GameController>();

    // Overlay가 활성화되어 있거나 현재 위치에 이미 다른 유닛이 배치되어 있으면 실행하지 않음
    if (!gameController.isOverlayActive(UnitSelectionOverlay.overlayName) &&
        isPlaceable()) {
      gameController.setPlacementPosition(position);
      gameController.setOverlayActive(UnitSelectionOverlay.overlayName, true);
    }
  }

// 현재 위치에 Defender가 이미 배치되어 있는지 확인
  bool isPlaceable() {
    // 게임에서 모든 Defender를 가져옵니다.
    Iterable<GameComponent> defenders = gameRef.query<Defender>();

    // 현재 PlaceableArea의 위치에 대한 사각형을 생성합니다.
    Rect placeableRect = Rect.fromLTWH(position.x, position.y, size.x, size.y);

    for (var defender in defenders) {
      // 각 Defender의 위치와 크기에 대한 사각형을 생성합니다.
      Rect defenderRect = Rect.fromLTWH(
        defender.position.x - (BonfireDefense.tileSize - defender.size.x) / 2,
        defender.position.y - (BonfireDefense.tileSize - defender.size.y) / 2,
        GameConfig.tileSize,
        GameConfig.tileSize,
      );

      // 사각형이 중첩되는지 확인합니다.
      if (placeableRect.overlaps(defenderRect)) {
        return false; // 여기에 이미 Defender가 배치되어 있습니다.
      }
    }
    return true; // Defender가 배치되어 있지 않으므로 배치 가능합니다.
  }
}
