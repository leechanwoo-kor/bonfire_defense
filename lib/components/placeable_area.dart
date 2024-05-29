import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/defender.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/game_managers/game_controller.dart';
import 'package:bonfire_defense/provider/defender_state_provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';
import 'package:bonfire_defense/screens/game.dart';
import 'package:bonfire_defense/utils/defender_info.dart';
import 'package:bonfire_defense/widgets/buttons/defense_tower_button.dart';
import 'package:bonfire_defense/widgets/buttons/tower_info_button.dart';
import 'package:provider/provider.dart';

class PlaceableArea extends GameDecoration with TapGesture {
  GameController controller;
  final void Function(TowerSelectButtons) onTowerButtonsDisplayed;
  final void Function(TowerInfoButtons) onTowerInfoButtonsDisplayed;

  PlaceableArea({
    required super.position,
    required super.size,
    required this.controller,
    required this.onTowerButtonsDisplayed,
    required this.onTowerInfoButtonsDisplayed,
  });

  @override
  void onTap() {
    final state = gameRef.context.read<DefenderStateProvider>();
    final gameState = gameRef.context.read<GameStateProvider>();
    final defender = state.selectedDefender;
    final index = state.selectedDefenderIndex;

    // Tower? existingTower = _getTowerAtPosition();

    // if (existingTower != null) {
    //   // 이미 타워가 배치된 경우: 타워 정보 버튼 그룹을 표시
    //   final towerIfnoButton =
    //       TowerInfoButtons(tower: existingTower, position: position);
    //   gameRef.add(towerIfnoButton);
    //   onTowerInfoButtonsDisplayed(towerIfnoButton);
    //   return;
    // }

    if (defender == null) {
      // 선택된 Defender가 없을 때 DefenseTower 추가
      if (isPlaceable()) {
        final tower = TowerSelectButtons(position: position);
        gameRef.add(tower);
        onTowerButtonsDisplayed(tower);
      }
      return;
    }

    final infos = DefenderInfo.getInfos();
    final info = infos.firstWhere((info) => info.type == defender.type);

    if (index != null && isPlaceable()) {
      if (gameState.gold >= info.cost) {
        controller.addDefender(info, position);
        gameState.updateGold(-info.cost);
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

  Tower? _getTowerAtPosition() {
    // 게임에서 모든 타워를 가져옴
    Iterable<Tower> towers = gameRef.query<Tower>();

    // 현재 PlaceableArea의 위치에 대한 사각형 생성
    Rect placeableRect = Rect.fromLTWH(position.x, position.y, size.x, size.y);

    for (var tower in towers) {
      // 각 타워의 위치와 크기에 대한 사각형 생성
      Rect towerRect = Rect.fromLTWH(
        tower.position.x,
        tower.position.y,
        tower.size.x,
        tower.size.y,
      );

      // 사각형이 중첩되는지 확인
      if (placeableRect.overlaps(towerRect)) {
        return tower; // 타워가 배치되어 있음
      }
    }
    return null; // 타워가 배치되어 있지 않음
  }
}
