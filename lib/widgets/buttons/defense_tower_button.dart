import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class DefenseTowerButtons extends GameDecoration with TapGesture {
  late List<DefenseTowerButton> buttons;

  DefenseTowerButtons({required super.position})
      : super(
          size: Vector2.all(18),
        );

  @override
  void onMount() {
    super.onMount();
    _initializeButtons();
  }

  void _initializeButtons() {
    buttons = [
      DefenseTowerButton(
        position: Vector2(position.x - 20, position.y),
        icon: Icons.ac_unit,
        onTapCallback: () => print("Button 1 pressed"),
      ),
      DefenseTowerButton(
        position: Vector2(position.x + 20, position.y),
        icon: Icons.access_alarm,
        onTapCallback: () => print("Button 2 pressed"),
      ),
      DefenseTowerButton(
        position: Vector2(position.x, position.y - 20),
        icon: Icons.accessibility,
        onTapCallback: () => print("Button 3 pressed"),
      ),
      DefenseTowerButton(
        position: Vector2(position.x, position.y + 20),
        icon: Icons.account_balance,
        onTapCallback: () => print("Button 4 pressed"),
      ),
    ];

    for (var button in buttons) {
      gameRef.add(button);
    }
  }

  void removeButtons() {
    for (var button in buttons) {
      button.removeFromParent();
    }
    buttons.clear();
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

class DefenseTowerButton extends GameDecoration with TapGesture {
  final IconData icon;
  final VoidCallback onTapCallback;
  bool isTapped = false;

  DefenseTowerButton({
    required Vector2 position,
    required this.icon,
    required this.onTapCallback,
  }) : super(
          position: position,
          size: Vector2.all(16),
        );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final iconSize = 12.0;
    final textSpan = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: iconSize,
        fontFamily: icon.fontFamily,
        color: Colors.black,
      ),
    );

    final paint = Paint()..color = Colors.white;
    double radius = size.x / 2;

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), radius, paint);

    textPainter.text = textSpan;
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - iconSize) / 2,
        (size.y - iconSize) / 2,
      ),
    );
  }

  @override
  void onTap() {
    isTapped = true;
    onTapCallback();
    Future.delayed(Duration(milliseconds: 100), () {
      isTapped = false;
    });
  }
}
