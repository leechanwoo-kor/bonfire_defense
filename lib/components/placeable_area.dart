import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/defender.dart';
import 'package:bonfire_defense/components/defenderInfo.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:provider/provider.dart';

class PlaceableArea extends GameDecoration with TapGesture {
  GameController controller;

  PlaceableArea({
    required super.position,
    required super.size,
    required this.controller,
  });

  @override
  void onTap() {
    final state = gameRef.context.read<DefenderStateProvider>();
    final gameState = gameRef.context.read<GameStateProvider>();
    final type = state.selectedDefender;
    final index = state.selectedDefenderIndex;

    DefenderInfo info =
        DefenderInfo.getInfos().firstWhere((info) => info.type == type);

    if (index != null && type != null && isPlaceable()) {
      DefenderInfo card =
          DefenderInfo.getInfos().firstWhere((card) => card.type == type);
      if (gameState.gold >= card.cost) {
        controller.addDefender(info, position);
        gameState.updateGold(-card.cost);
        state.replaceDefenderAfterPlacement(index); // 선택된 카드의 인덱스로 교체
        state.setSelectedDefender(null);
      }
    }

    if (isPlaceable()) {
      state.setPlacementPosition(position);
    }
  }

// 현재 위치에 Defender가 이미 배치되어 있는지 확인
  bool isPlaceable() {
    // 게임에서 모든 Defender를 가져옴
    Iterable<GameComponent> defenders = gameRef.query<Defender>();

    // 현재 PlaceableArea의 위치에 대한 사각형 생성
    Rect placeableRect = Rect.fromLTWH(position.x, position.y, size.x, size.y);

    for (var defender in defenders) {
      // 각 Defender의 위치와 크기에 대한 사각형 생성
      Rect defenderRect = Rect.fromLTWH(
        defender.position.x - (BonfireDefense.tileSize - defender.size.x) / 2,
        defender.position.y - (BonfireDefense.tileSize - defender.size.y) / 2,
        16.0,
        16.0,
      );

      // 사각형이 중첩되는지 확인
      if (placeableRect.overlaps(defenderRect)) {
        return false; // 이미 Defender 배치되어 있음
      }
    }
    return true; // Defender가 배치되어 있지 않으므로 배치 가능
  }
}
