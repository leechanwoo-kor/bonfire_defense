import 'package:bonfire/bonfire.dart';
import 'package:bonfire_defense/utils/tower_info.dart';
import 'package:flutter/material.dart';

class BaseButton extends GameDecoration with TapGesture {
  final IconData icon;
  final void Function(BaseButton) onTapCallback;
  final TowerInfo towerInfo;
  bool isTapped = false;
  bool isSelected = false;

  BaseButton({
    required super.position,
    required this.icon,
    required this.onTapCallback,
    required this.towerInfo,
    required super.size,
  });

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
