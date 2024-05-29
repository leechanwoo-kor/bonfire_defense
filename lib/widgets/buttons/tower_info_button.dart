import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:bonfire_defense/widgets/buttons/base_button.dart';
import 'package:bonfire_defense/widgets/buttons/base_panel.dart';
import 'package:flutter/material.dart';

class TowerInfoPanel extends BasePanel<TowerActionButton> {
  TowerInfoPanel({required super.position, required this.tower})
      : super(size: Vector2.all(18));

  final Tower tower;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initializeButtons([
      createButton(
          offset: Vector2(-20, 0),
          icon: Icons.arrow_upward,
          towerType: tower.type),
      createButton(
          offset: Vector2(20, 0), icon: Icons.sell, towerType: tower.type),
    ]);
  }

  TowerActionButton createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
  }) {
    return TowerActionButton(
      position: position + offset,
      icon: icon,
      onTapCallback: onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
    );
  }

  @override
  void handleSameButtonTap(TowerActionButton tappedButton) {
    print('기능 구현');
    selectedButton!.isSelected = false;
    selectedButton = null;
    removeButtons();
  }
}

class TowerActionButton extends BaseButton {
  TowerActionButton({
    required super.position,
    required super.icon,
    required super.onTapCallback,
    required super.towerInfo,
  }) : super(
          size: Vector2.all(16),
        );
}
