import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/components/ally/tower.dart';
import 'package:bonfire_defense/utils/game_config.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:flutter/material.dart';

class TowerInfoButtons extends GameDecoration with TapGesture {
  final Tower tower;
  late List<TowerInfoButton> buttons;
  TowerInfoButton? selectedButton;

  TowerInfoButtons({required super.position, required this.tower})
      : super(
          size: Vector2.all(18),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    initializeButtons();
  }

  void initializeButtons() {
    buttons = [
      createButton(
        offset: Vector2(0, -20),
        icon: Icons.arrow_upward,
        towerType: tower.type,
      ),
      createButton(
        offset: Vector2(0, 20),
        icon: Icons.sell,
        towerType: tower.type,
      ),
    ];

    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  TowerInfoButton createButton({
    required Vector2 offset,
    required IconData icon,
    required TowerType towerType,
  }) {
    return TowerInfoButton(
      position: position + offset,
      icon: icon,
      onTapCallback: onButtonTap,
      towerInfo: TowerInfo.getInfo(towerType),
    );
  }

  void onButtonTap(TowerInfoButton tappedButton) {
    if (selectedButton != null) {
      if (selectedButton == tappedButton) {
        handleSameButtonTap(tappedButton);
        return;
      } else {
        selectedButton!.isSelected = false;
      }
    }

    handleNewButtonTap(tappedButton);
  }

  void handleSameButtonTap(TowerInfoButton tappedButton) {
    print('기능 구현');
    selectedButton!.isSelected = false;
    selectedButton = null;
    removeButtons();
  }

  void handleNewButtonTap(TowerInfoButton tappedButton) {
    selectedButton = tappedButton;
    tappedButton.isSelected = true;
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
    selectedButton = null;
  }

  bool anyButtonTapped() {
    return buttons.any((button) => button.isTapped);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onTap() {
    // 방어 타워 클릭 시 행동 정의
  }
}

class TowerInfoButton extends GameDecoration with TapGesture {
  final IconData icon;
  final void Function(TowerInfoButton) onTapCallback;
  final TowerInfo towerInfo;
  bool isTapped = false;
  bool isSelected = false;

  TowerInfoButton({
    required super.position,
    required this.icon,
    required this.onTapCallback,
    required this.towerInfo,
  }) : super(
          size: Vector2.all(16),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    drawButtonBackground(canvas);
    drawIcon(canvas);
    drawCost(canvas);
  }

  void drawButtonBackground(Canvas canvas) {
    final paint = Paint()..color = isSelected ? Colors.green : Colors.white;
    final radius = size.x / 2;
    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, paint);
  }

  void drawIcon(Canvas canvas) {
    const iconSize = 12.0;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: iconSize,
          fontFamily: icon.fontFamily,
          color: Colors.black,
        ),
      ),
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.x - iconSize) / 2, (size.y - iconSize) / 2),
    );
  }

  void drawCost(Canvas canvas) {
    final costPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: '${towerInfo.cost}',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );

    costPainter.layout();
    costPainter.paint(
      canvas,
      Offset((size.x - costPainter.width) / 2, size.y + 2),
    );
  }

  @override
  void onTap() {
    isTapped = true;
    onTapCallback(this);
  }
}
