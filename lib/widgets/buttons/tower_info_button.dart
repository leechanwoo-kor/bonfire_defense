import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/tower/tower.dart';
import 'package:bonfire_defense/game_managers/tower_manager.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:bonfire_defense/widgets/buttons/base_button.dart';
import 'package:bonfire_defense/widgets/buttons/base_panel.dart';
import 'package:flutter/material.dart';

class TowerInfoPanel extends BasePanel<TowerActionButton> {
  TowerInfoPanel({required this.tower, required super.position})
      : super(size: Vector2.all(18));

  final Tower tower;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initializeButtons([
      createButton(
          offset: Vector2(-20, 0),
          icon: Icons.arrow_upward,
          towerType: tower.towerInfo.type,
          buttonType: ButtonType.upgrade),
      createButton(
          offset: Vector2(20, 0),
          icon: Icons.sell,
          towerType: tower.towerInfo.type,
          buttonType: ButtonType.sell),
    ]);
  }

  TowerActionButton createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
    required ButtonType buttonType,
  }) {
    return TowerActionButton(
      position: position + offset,
      icon: icon,
      onTapCallback: onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
      buttonType: buttonType,
    );
  }

  @override
  void handleSameButtonTap(TowerActionButton tappedButton) {
    if (tappedButton.buttonType == ButtonType.upgrade) {
      print("Upgrade tower");
    } else if (tappedButton.buttonType == ButtonType.sell) {
      TowerManager.sellTower(tower);
    }
    selectedButton!.isSelected = false;
    selectedButton = null;
    removeButtons();
  }
}

class TowerActionButton extends BaseButton {
  TowerActionButton(
      {required super.position,
      required super.icon,
      required super.onTapCallback,
      required super.towerInfo,
      required super.buttonType})
      : super(
          size: Vector2.all(16),
        );
}
