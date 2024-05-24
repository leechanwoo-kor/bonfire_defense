import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bonfire_defense/provider/game_state_provider.dart';

class OptionButtons extends StatelessWidget {
  const OptionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
      builder: (context, gameState, child) {
        if (!gameState.showOptions) return const SizedBox.shrink();

        final position = gameState.optionsPosition;
        const offset = 35.0;
        const double radius = offset;

        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: CirclePainter(center: position, radius: radius),
              ),
            ),
            _buildOptionButton(position.dx, position.dy - radius,
                Icons.sports_outlined, () {}),
            _buildOptionButton(
                position.dx, position.dy + radius, Icons.shield, () {}),
            _buildOptionButton(
                position.dx - radius, position.dy, Icons.arrow_outward, () {}),
            _buildOptionButton(
                position.dx + radius, position.dy, Icons.auto_fix_high, () {}),
          ],
        );
      },
    );
  }

  Widget _buildOptionButton(
      double left, double top, IconData icon, VoidCallback onPressed) {
    return Positioned(
      left: left - 15,
      top: top - 15,
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: onPressed,
        iconSize: 30.0,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Offset center;
  final double radius;
  final Color color;

  CirclePainter(
      {required this.center, required this.radius, this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
