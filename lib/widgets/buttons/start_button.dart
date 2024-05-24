import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';

class StartButton extends GameDecoration with TapGesture {
  late double _scale;
  bool scalingUp = true;
  final double minScale = 0.9;
  final double maxScale = 1.0;
  final double scaleStep = 0.002;

  StartButton({required Vector2 position})
      : super(
          position: Vector2(position.x - 2, position.y + 8),
          size: Vector2.all(18),
        ) {
    _scale = minScale;
  }

  @override
  void render(Canvas canvas) {
    final gameStateProvider = gameRef.context.read<GameStateProvider>();
    if (gameStateProvider.state == GameState.waving) {
      return;
    }
    super.render(canvas);

    const icon = Icons.play_arrow;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    const iconSize = 12.0;
    final textSpan = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: iconSize,
        fontFamily: icon.fontFamily,
        color: Colors.black,
      ),
    );

    final paint = Paint()..color = Colors.white;
    double radius = (size.x / 2) * _scale;

    canvas.save();
    canvas.translate((size.x * (1 - _scale)) / 2, (size.y * (1 - _scale)) / 2);
    canvas.scale(_scale);

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

    canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (scalingUp) {
      _scale += scaleStep;
      if (_scale >= maxScale) {
        scalingUp = false;
      }
    } else {
      _scale -= scaleStep;
      if (_scale <= minScale) {
        scalingUp = true;
      }
    }
  }

  @override
  void onTap() {
    final gameStateProvider = gameRef.context.read<GameStateProvider>();
    if (gameStateProvider.state != GameState.waving) {
      gameStateProvider.startGame();
    }
  }
}
